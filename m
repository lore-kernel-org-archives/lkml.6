Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72824C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 19:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BE5327863
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 19:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="aw4awhBk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BE5327863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754878AbeF1TRZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 15:17:25 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:46338 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753410AbeF1TRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 15:17:23 -0400
Received: by mail-io0-f195.google.com with SMTP id u23-v6so6261476ioc.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 12:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9vGLKomZ6mOhWk8FNFP50yCf39PN/eMDoDt2056ucsk=;
        b=aw4awhBkPutEzf+iaS+FATEoMYrnO+b/FxdXZv1S66jD03kFMEf8Aw1RpZJsdFVUnT
         xAqfn0VvBG5QS/sO17cJRgeWQE9Ma1mGurjnK55m8oOhetDRhnM6OuvdaVAPOUPWesnS
         2bgqyTQguzd9irV5O7Y6W/AxVFLVEFvqMoe8zK0IneU6N5ieqAeh1IITOTX+pepgGhKh
         SKIfETFAaD1fwKIEVgo7SHFaui6vwIcn/8g7aXmcKpuS240R37ujhlG6+e8DeqKzJkXl
         Wg129bQyha9jibFwKPQ4qgynO0sjpvfvC4a0DQyOounytVRRIKsqYtSN0R8WoeAC7egs
         4Dpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9vGLKomZ6mOhWk8FNFP50yCf39PN/eMDoDt2056ucsk=;
        b=AwwklJ2T58zpOLzwBrIysdrdNOdy9vEHIfriaxocloLgrvNp4qDjHJRD/VcBAGIv/Q
         of8SZJ8Zg2eZhhoeH7VIWBNpJ7g7ruIpF2wosIEaV9/jvs0IwNVsg5z1VxFlidl8cG2W
         7SzYybPeuh3VBaMlX4iHSPDDp2FTUaXnA2GRXvNBHLdYBWnqadO+fukBGKpsk1zp4tBO
         NZdyjNrFc67DDPzecqaQITYIxrE+TPdFaj8snDk8+tuK8LCBk7X2onLgEQkx4SQ7hwJ4
         BwGp8S9kJZnjwNC7RLVlcWJI6FZBQ0d5/74h9dAas8Cg+Conj5eUhtf9QWdNPUyusLwg
         KGLQ==
X-Gm-Message-State: APt69E3AuTnZwmCgQ8j0M7oKS2bBt+VA8bCpfvvCPtY++xEU0zTR8vFu
        u6gM+eol7Wzt25w18OA4tnZhaQ==
X-Google-Smtp-Source: AAOMgpfSjZweGNnPex3C8nbUrIiv1mPrzoMeYfuN36vxoo4FkJ+4/RyoHaqHN7HN/m27LBcWx+bu/w==
X-Received: by 2002:a6b:be05:: with SMTP id o5-v6mr9583375iof.45.1530213442972;
        Thu, 28 Jun 2018 12:17:22 -0700 (PDT)
Received: from [192.168.1.212] (107.191.0.158.static.utbb.net. [107.191.0.158])
        by smtp.gmail.com with ESMTPSA id m1-v6sm3915025iti.31.2018.06.28.12.17.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 12:17:21 -0700 (PDT)
Subject: Re: [PATCH BUGFIX RESEND 0/4] bfq: fix bugs breaking bandwidth
 guarantees occasionally
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, broonie@kernel.org,
        linus.walleij@linaro.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name
References: <20180625195537.7769-1-paolo.valente@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <359b2f24-f680-2e76-d6e1-3b8b67fcacc7@kernel.dk>
Date:   Thu, 28 Jun 2018 13:17:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180625195537.7769-1-paolo.valente@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/25/18 1:55 PM, Paolo Valente wrote:
> Hi,
> during some bandwidth tests, I found some occasional but severe
> malfunctions (losses of bandwidth control). The first three patches in
> this series fix the bugs that caused these malfunctions. The last
> patch is a fix/improvement of the name of one of the functions
> involved with these bugs.

Applied for 4.19, thanks.

-- 
Jens Axboe

