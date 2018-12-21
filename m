Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4210C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72410218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="F4vCTfCj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732205AbeLUHlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 02:41:07 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52712 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730294AbeLUHlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 02:41:06 -0500
Received: by mail-wm1-f65.google.com with SMTP id m1so4352518wml.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 23:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=wXL5f8n1srKsQxmGBFauSfHPgXgwfmcCSAYDei6qN7Y=;
        b=F4vCTfCjg7hklY95hmB97lF/cUrfPxUEXMD1Q+NyFAVsV6epkaCJUZTNeH0gszy2hH
         oiY6zuhvyK3ZINVDN1BlQWEtUB6L/XIqlaLjUKTAP3uur+zPog6a35efTsvs4t+6YN28
         v0uviWHi0/FZRB95o/kXLhZF4XEJ2zycnSvhI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=wXL5f8n1srKsQxmGBFauSfHPgXgwfmcCSAYDei6qN7Y=;
        b=mAD7Xu9QPq+TIrPFzkAAuwLk+vUECsyoHRwrD36eq5PfG60hqkQr/ciy3U/LW3RbY3
         gBvs24blDtsFZv9n1MoElxiMHXiH6WqqDcSVqKiAdB/F4e4ktJNA7XLDuXZVbdHA6E84
         ufYHsLdSIgeuqwYNva5Rdhy+fY8lolpuP7juJnNd+0pnIqpZzpSM8UKpCBYl07vb1YWF
         +IhXYtG5zVREuGpYn25i5dst0QVj2l3btctiBhWOa4DAPRlE6FrfjMw6lsxjLScFhQRg
         jbCqRyx6e2P/saXY8p8PDfPuN0oA3TxyC5cRPe9Lz2Ze6ko4kpDscen4tKIOSoASn0Le
         FRNQ==
X-Gm-Message-State: AA+aEWYklrwQSsp9cDvvlHqABiCZGm/UaVbVNrm8yh7drdzHkiaTiA0M
        IGFYk/6NaKwQ+rwqxQ62E+gsXiEJY9M=
X-Google-Smtp-Source: AFSGD/XXCqbgRoB2koMOkag3IfFE3of9TGe/NT9c3krl8eC+OMC0v1dOIPq0DoGOtq2elEaDn+NCZQ==
X-Received: by 2002:a1c:d74a:: with SMTP id o71mr1655755wmg.73.1545378064972;
        Thu, 20 Dec 2018 23:41:04 -0800 (PST)
Received: from dell ([95.149.164.119])
        by smtp.gmail.com with ESMTPSA id f15sm8785543wrt.10.2018.12.20.23.41.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 23:41:04 -0800 (PST)
Date:   Fri, 21 Dec 2018 07:41:02 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Frank Lee <tiny.windzz@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mfd: convert to DEFINE_SHOW_ATTRIBUTE
Message-ID: <20181221074102.GP4497@dell>
References: <20181202021710.9307-1-tiny.windzz@gmail.com>
 <CACRpkdahwmjED=BY715E+cpRhveqk32vCRpevyHF8SdcqC0kvg@mail.gmail.com>
 <CAEExFWssZtWV3XnJpjwm8BXAE4duhrrvjaPWQhfRP3W4y-O1Rg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEExFWssZtWV3XnJpjwm8BXAE4duhrrvjaPWQhfRP3W4y-O1Rg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Dec 2018, Frank Lee wrote:

> ping......

I've told you about this before:

"
Please don't do that.

If you think your patch has been missed, then please send it again as
a [RESEND].  In this case you will need to fix the $SUBJECT line too.
To see what it should look like do the following:
 
  `git log --oneline -- drivers/mfd`
 
Once fixed, s/[PATCH]/[RESEND/ and resubmit it.
"

In this case the $SUBJECT line is fine, but the rest is relevant.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
