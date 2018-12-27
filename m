Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F44C43612
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 22:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98A4E2148E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 22:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GrK8P4V+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731523AbeL0Wb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 17:31:57 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38436 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730644AbeL0Wb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 17:31:57 -0500
Received: by mail-wm1-f65.google.com with SMTP id m22so18582814wml.3;
        Thu, 27 Dec 2018 14:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=u4pRfWPAstoud3EmvLPk/X25LuWe+P2eo9XD4R6R1kg=;
        b=GrK8P4V+TNe7HVfckxArkt+2Q2CiJXg2rsyUjpa9hzo5g01mF3o6F6lVR3MkCqo9XA
         bGixL51pqRINnhbzqG6hCQL3tIdNKFZu61AZAzhRWwKX01I1yHy4AYgkk2jeEfP6rUlY
         Z7u47/wBgbVetHuKUjL2/PDMHMRtlseihAVjpiZDFzE+54JdXnlU0KFJ6/1ms1TopaHz
         B3De6Qy/8jTg+xBWRwTtfp5Y+jNSAdSJnkOM9IXFYR1pzepAT2IuEM7P0sbqvy44sLDa
         PB6yazwSM4hIDfMt38YHlrjN5BgrloDn/sh3nu/Xd5hf2COOfeCj7gJQH4tOB92uKLJx
         BCoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u4pRfWPAstoud3EmvLPk/X25LuWe+P2eo9XD4R6R1kg=;
        b=r7rOqW/9RUD4Y329rVpNdRuSR5qWA0HShYO5V3uLgvVAHEzRuKYPxzO2HLBD3Wh8BW
         TzTGhJ6cmRpJeGOJEeoyfECi7ShSvJE0NN1/BVjxoXFZk6gkXwkufwN0FWJtYkyZNcVK
         AbZRHzrm7Lz/WDte4jo1NsG/IiXACURjxE1IXGhm787KTB8wWXL39UJ9Jha2JdboCANn
         DJIC3epEpL0dn+l4aKEj88ElitW1G78bvKnDEMoB3r7Q5czFYtfFzS9c9+PhDzYvJraZ
         Iw4BGtA3bXn9pnWTsM7No/zXmgn4eodlxzHsKcdmaiecNzz4fY0KAIhGfhHBstLDBHcw
         ReOg==
X-Gm-Message-State: AA+aEWbXCnPZHG3KltDvDCBV43mMXGvtp8YqdN3UFvdq4Z7OLsp3Jc/3
        YM2go5nTBThYkUhaAi7cr1m3iWMn
X-Google-Smtp-Source: ALg8bN4rbtZjADPnhMd/+kXNe57Lh5dYo9z6uYRTTFYqAwth/9vXeKyX8AyZQ8/ITAMwfll6MCmQ+g==
X-Received: by 2002:a1c:d7d3:: with SMTP id o202mr24053221wmg.135.1545949915044;
        Thu, 27 Dec 2018 14:31:55 -0800 (PST)
Received: from ?IPv6:2003:ea:8bcf:e300:25c7:a0bd:faa6:5840? (p200300EA8BCFE30025C7A0BDFAA65840.dip0.t-ipconnect.de. [2003:ea:8bcf:e300:25c7:a0bd:faa6:5840])
        by smtp.googlemail.com with ESMTPSA id l14sm77169605wrp.55.2018.12.27.14.31.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Dec 2018 14:31:54 -0800 (PST)
Subject: Re: [PATCH] rtc: rv8803: Check return value of rv8803_write_reg
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181227202856.27408-1-pakki001@umn.edu>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <ab4c081a-82d7-4a50-5c2a-4dbb4ba79223@gmail.com>
Date:   Thu, 27 Dec 2018 23:31:47 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20181227202856.27408-1-pakki001@umn.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.12.2018 21:28, Aditya Pakki wrote:
> In rv8803_handle_irq, rv8803_write_reg can return a failed return
> value when attempting to write to the bus. The fix checks the output
> and throws a dev_warn notifying of the failure.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>  drivers/rtc/rtc-rv8803.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
You seem to submit the same type of changes throughout very
different subsystems. And you do it w/o thinking and testing.
If you would have looked at rv8803_write_reg() you would have
seen that it prints an error in case of failure. So your
patch achieves nothing.
You got David Miller upset already and it looks like you
want to achieve the same with other maintainers too.
I'd strongly suggest that you stop sending patches until
you better understand the kernel code.




