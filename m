Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD1CC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 621C2206A3
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bxc+0NZB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbfAHRZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 12:25:17 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:34121 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728996AbfAHRZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 12:25:16 -0500
Received: by mail-yb1-f196.google.com with SMTP id w186so983172ybg.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 09:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=3bg8CAnFW238OIcpYA+0yZo5cJSugpakiBbJrbNjlKY=;
        b=bxc+0NZBmNtmzZMFuoxksibf2LzHorp/nJMXDwUNg7SuoiEObIn4J09MT+DLuweAVa
         JB3bqQiR4K6Iti0lpHx7ZI+HRS5MzEDUEtg7kHNYx0CESX/FmstrhT8Rr4YKEFGb+eXT
         U/6VAgfV9e1tvwFIsWW84RBpT+3FF8kNYIl0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3bg8CAnFW238OIcpYA+0yZo5cJSugpakiBbJrbNjlKY=;
        b=MaBz4uhr1ES/5UcX0tozKpZM8j3o6a/gIaVc1ftjg+mSX+7vCgFLVd6tYHQiG3bBg2
         KAG8QxgRSsSZ+mYodLImr+PHib6ivxmTjQ8d5rz6hXnFzW++KDG+Q7KxOFXRiewonwI6
         3ykCXQaJHDj2h3cY/LbsHIiAju0dXpS1crEXmm2vvfG71HyHNsNRNs19SrIC24eVbfeK
         dE619BQEw9+LBu6v3GAo/Xt/3zhKTJESym/lrIAcBH33U8UIQpank4+z+ePZJ6aty1hK
         Q0OSizRfYtzXwPSxqzwNTBs3Dm+Ube7E7eKc1rSUdr1RppZDw4GaYicEq8e+hm2iOk4e
         2IDg==
X-Gm-Message-State: AJcUukfkMRSrVzATihsMTIzk4iWkVdQQEt7P3O6kdg1KMA1BXJLdP+/h
        k5KiWN76fPwl7imaZ0wV2t2QGg==
X-Google-Smtp-Source: ALg8bN4wHddVIFoJHInYz7PaSeIFeBkHjI/6p6ArC9mXmlLxlIMC76qUHvHhjQzryfR9Vvb6eZNbXA==
X-Received: by 2002:a25:2f88:: with SMTP id v130mr2493374ybv.455.1546968314963;
        Tue, 08 Jan 2019 09:25:14 -0800 (PST)
Received: from [10.136.8.252] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id v9sm34914192ywh.2.2019.01.08.09.25.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 09:25:13 -0800 (PST)
Subject: Re: [PATCH 0/8] Add IPROC I2C slave mode and NIC I2C support
To:     Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Shreesha Rajashekar <shreesha.rajashekar@broadcom.com>,
        Michael Cheng <ccheng@broadcom.com>, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
References: <1546938997-13798-1-git-send-email-rayagonda.kokatanur@broadcom.com>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <6a5380e3-1e15-31e3-bbaa-134856a0c2dc@broadcom.com>
Date:   Tue, 8 Jan 2019 09:25:09 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1546938997-13798-1-git-send-email-rayagonda.kokatanur@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You sent out the same patch series 3 times without any explanation. Very
confusing.

Is this the latest one that should be reviewed?

Thanks,

Ray

On 1/8/2019 1:16 AM, Rayagonda Kokatanur wrote:
> Hi,
> This patchset contains support for IPROC I2C slave and NIC I2C support.
> Following are the brief changes done inorder to support both IPROC I2C
> slave mode and NIC I2C,
> 
> a. Add support to allow I2C rx transfer upto 255 bytes
> b. Add polling mode support to the iProc I2C driver. Polling mode is used
>    in certain SoCs where interrupt is not connected from the I2C block.
> c. Add warpper read/write access for register to support indirect register
>    access. This is required in certain SoCs with this iProc I2C
>    block registered.
> 
> 
> Ray Jui (1):
>   dt-bindings: i2c: iproc: make 'interrupts' optional
> 
> Rayagonda Kokatanur (5):
>   i2c: iproc: add polling support
>   i2c: iproc: use wrapper for read/write access
>   dt-bindings: i2c: iproc: add "brcm,iproc-nic-i2c" compatible string
>   i2c: iproc: add NIC I2C support
>   arm64: dts: Stingray: Add NIC i2c device node
> 
> Shreesha Rajashekar (2):
>   i2c: iproc: I2C read up to 255 bytes support
>   i2c: iproc: Add Slave mode support
> 
>  .../devicetree/bindings/i2c/brcm,iproc-i2c.txt     |  14 +-
>  .../arm64/boot/dts/broadcom/stingray/stingray.dtsi |  18 +
>  drivers/i2c/busses/Kconfig                         |   1 +
>  drivers/i2c/busses/i2c-bcm-iproc.c                 | 767 +++++++++++++++++----
>  4 files changed, 669 insertions(+), 131 deletions(-)
> 
