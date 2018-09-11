Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B926CC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 22:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 637C62087F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 22:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="jpJwARGm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 637C62087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbeILD7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 23:59:08 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:35935 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbeILD7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 23:59:08 -0400
Received: by mail-it0-f65.google.com with SMTP id u13-v6so544049iti.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 15:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gI1eVRH8nDiYXaYQWk5N/Nj16NqPi/G+O7ckNwavfyM=;
        b=jpJwARGmsDPuv7dllRYPe+XmThehZkLkNSmZNNR4bwrps+n7q+wMyjVlpsZTZAXP7S
         I3vYEO86tr+DGUSow7iQ8D3R26A/doOkEAQ7k6kaJl3yau06/dWIMNWBUgD06VsbrZ/x
         frv3xJ9I6Gljdd1wEc/hulbSgdHlAAUSeHJ0QEsHilMyGIb1Usb5iSsh2QbW7oMPZ5XY
         o+z8FlqakzC/i9thiJ2dUGm/QGN5nyRaV8Rtr1c4YKcvzbRgdRL1T+Z1UHIFL0L63PZH
         Ba+Q/8eeewMe/Z/2s5QzdrbuJS3VpDrsF/CQIQ7dBBthLCeFZYqxeakG3ly5LOGUWYzf
         Oh8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gI1eVRH8nDiYXaYQWk5N/Nj16NqPi/G+O7ckNwavfyM=;
        b=AKWsg147EgMXqB7RHQ1pRlio/oh8EX07mf0+vIub7eRMqZhHtL5ZjzTIw1oOd/GWUm
         jCN8ivEH6IW0JZt3rrJnjxIQOw9vxcAO6d51xoJFU6lFMr/DUcovylwwn6Eu56U/rL/F
         pn9F8B8/33PeHF3lPW7x0UGnU1bng91OAkt4zzmgrcpVxMrLSnDowPyvEmBA84bFF7as
         1JMnkm15kO76Go3SFVDwqpi4a7xMkgnvNxbZ6GEHktr0imxafeyibYYfZAZBAvmZc2mE
         z/0fnBm87si6I2yXtFByP4gb55ITMiSOliJmflN5cX4qXWRz55mKQchfC/YOLw4EO/IX
         9ifg==
X-Gm-Message-State: APzg51BEX40zfzmGEhrq9/0hi77aYdTtMucDq71ygSdZyoExTvJb8ciX
        iPVCztrhT+q3mZNgj5AY5v/Spw==
X-Google-Smtp-Source: ANB0VdbyC2FT8Sp2niazlV84dh0g6n8ADXzNOtRzLSBx+FRlbfTXGesK3Tjxcc2kQRERdrsn2HWGYA==
X-Received: by 2002:a24:7b8d:: with SMTP id q135-v6mr3889705itc.43.1536706658134;
        Tue, 11 Sep 2018 15:57:38 -0700 (PDT)
Received: from [192.168.1.212] (107.191.0.22.static.utbb.net. [107.191.0.22])
        by smtp.gmail.com with ESMTPSA id d65-v6sm10324874iof.46.2018.09.11.15.57.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 15:57:36 -0700 (PDT)
Subject: Re: [PATCH] rsxx: Remove unnecessary parentheses
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Joshua Morris <josh.h.morris@us.ibm.com>,
        Philip Kelleher <pjk1939@linux.vnet.ibm.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
References: <20180911215040.7906-1-natechancellor@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f8ee0011-d544-ce09-0bd7-94946c101fbd@kernel.dk>
Date:   Tue, 11 Sep 2018 16:57:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180911215040.7906-1-natechancellor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/18 3:50 PM, Nathan Chancellor wrote:
> Clang warns when more than one set of parentheses is used for a
> single conditional statement:
> 
> drivers/block/rsxx/cregs.c:279:15: warning: equality comparison with
> extraneous parentheses [-Wparentheses-equality]
>         if ((cmd->op == CREG_OP_READ)) {
>              ~~~~~~~~^~~~~~~~~~~~~~~
> drivers/block/rsxx/cregs.c:279:15: note: remove extraneous parentheses
> around the comparison to silence this warning
>         if ((cmd->op == CREG_OP_READ)) {
>             ~        ^              ~
> drivers/block/rsxx/cregs.c:279:15: note: use '=' to turn this equality
> comparison into an assignment
>         if ((cmd->op == CREG_OP_READ)) {
>                      ^~
>                      =
> 1 warning generated.

Applied for 4.20, thanks.

-- 
Jens Axboe

