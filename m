Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4783C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BCFF24997
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="r9ZAyHV9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BCFF24997
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753014AbeGBVLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 17:11:09 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:46861 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752768AbeGBVLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 17:11:08 -0400
Received: by mail-io0-f196.google.com with SMTP id p7-v6so3550773ioh.13
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 14:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FSONCz1F2csjIdVxHSaWGKTYJrmzxK5VgpHpZOPWubU=;
        b=r9ZAyHV9M7hpQ1IV7AXTg1scmMbGfhwXJjfpyxwV8c23eEmwqjZUrMFOraAYkx5sQK
         lOoZ0ETjcFdauwIiLiQ98X/qz0GVX1QkVIEp5n20MnRH+wtBKhBUUbx9W0FCITTsgHgX
         M7i7Q91wQmBEiqWd2vbKgIF01p1yl5JUWDTL5eKNq2sysF7y1IQU5iAeD0J4FJMe7dJW
         GkAv6rAg7omMW+oLeWKfTwBhqD10pNA+s/WxmMpAns8fRBFDSmnw+4a3hlZy10bEP4mi
         TAJaQdgzhxbjjJG5vt0GkXrPOmVnX448X1xkZRUSSEqRqeWieTPObHfXVPwGoolrh8EK
         c3xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FSONCz1F2csjIdVxHSaWGKTYJrmzxK5VgpHpZOPWubU=;
        b=Llni3Vx3IpNMsoYoAVoSU2J1qDvrItfv8MG29BwgC1bifrTlBoL4vIwCd6TvuJGCAG
         AhLqeEkcp08Z4XG5QJ9Y4gLc2SOpyjsY4urEXFFa+YgZKfNHkDOsGLm/wrRZztPpPhHx
         qovbfXjUz0mNXzSOQmZnQ6UAbSeTmHeAZKKv36uHNBgI/4FbxOLNAoX1TjL1KkuqrDqA
         iA54xlAPI6ceSAJTd7mixWAPnNJK4Y/jrIs9D04YsKJWAjOgH4sauPLH0pLNBnMXI4kC
         7xDuQgxL/QNeDPYSC8meR3fyhnYABsij/B0wxz78ke9suOLby8VE0zV0vxlNgh4AvUC9
         KyzQ==
X-Gm-Message-State: APt69E2kOigd0ANBaIMoBUYkGPMhiLe2rJk6o/ak58V6Z72aMctTJLcD
        +4gwSO6u/PM10tcg92ngXaKB10+shFY=
X-Google-Smtp-Source: AAOMgpfhTp5gGVY0WmRj8Cdr8TKuREHOkDJ2umHVGyo77Wrls2LjeTzoKjYr/uMnLdWwdBmlyqb7Bw==
X-Received: by 2002:a6b:3114:: with SMTP id j20-v6mr21896295ioa.215.1530565867105;
        Mon, 02 Jul 2018 14:11:07 -0700 (PDT)
Received: from [192.168.1.212] (107.191.0.158.static.utbb.net. [107.191.0.158])
        by smtp.gmail.com with ESMTPSA id 189-v6sm7307979iov.4.2018.07.02.14.11.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 14:11:05 -0700 (PDT)
Subject: Re: [PATCH] drbd: mark expected switch fall-throughs
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>
Cc:     drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180702174902.GA18713@embeddedor.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d776672f-3173-037e-81fc-5c2619177682@kernel.dk>
Date:   Mon, 2 Jul 2018 15:11:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180702174902.GA18713@embeddedor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/2/18 11:49 AM, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Warning level 2 was used in this case: -Wimplicit-fallthrough=2

Applied, thanks.

-- 
Jens Axboe

