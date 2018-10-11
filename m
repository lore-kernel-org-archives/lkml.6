Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 235FDC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 07:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8B7020841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 07:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JW/cEGDN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8B7020841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbeJKPR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 11:17:27 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:35433 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbeJKPR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 11:17:26 -0400
Received: by mail-it1-f193.google.com with SMTP id p64-v6so11892454itp.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 00:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CD2VfBHRkC1TrdQeKORSu1hkEGGkeeJnjGAri1Swivc=;
        b=JW/cEGDNaP4S/oG2JCXKWyAShKI8uD7QDq3I2b1qurJvRGrLiSzdPAAFluQxzzBehf
         pxEBnOnVfBa+wtbxhRuOkhAb3LlpNoBHpcyfXR2VCE/w5AUJmNnGF93KKUP0OkJn38Vq
         i5lhrcrX4CB46+GqJvpYq4jMU5bS3W0FjzBCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CD2VfBHRkC1TrdQeKORSu1hkEGGkeeJnjGAri1Swivc=;
        b=QnyfkFy7H5D09gqko5tqGK3+x5HNBReTxQX8owl4aNcjVOIOzkE5iCPDeP+5mFDe19
         xpQhr3jU4oafe4akAUyhGna9C1un8THAFDZm9N7kTkJ1V3EF5pwSau/x/VCrQgUrOsYf
         wBtDC8GmomOulHrU1BdPKccGLw92zEF/vMUrgiAo7LlBCXb/LC9o7LG5rgDq4M+6grSz
         +jzSfO01wThg4gC1dpKR2uetMxH+cCN6rEKCQYTU5diOK3T649dMTSWQ/AO0BbR/Wqxb
         2uj3DwZFrfrd/81d/uk4w3/CkagGuc0vllQtI3y7zULOnLXH1z4y/yJQ6yFBm9TkGtTu
         /kiA==
X-Gm-Message-State: ABuFfohYiHX9y4XBaEWZbH/BJ+BoNKi2LhNT8qiIgtNzqVf+xrns7W+f
        e8f+5FvvMN2MuFyhPo7ZO9yNIDvEBScMTA9lgsdJ/Q==
X-Google-Smtp-Source: ACcGV61RyjbxdSXg+7wrrMRa5zyTPbohgnDrkLNT8T3J1eXa4I/88cXBuzZiwjY80pkiPxJeeBpApdlQb/z0rQ8kmWA=
X-Received: by 2002:a02:3f5d:: with SMTP id c29-v6mr388539jaf.107.1539244281974;
 Thu, 11 Oct 2018 00:51:21 -0700 (PDT)
MIME-Version: 1.0
References: <20181011141728.50b2d17c@canb.auug.org.au>
In-Reply-To: <20181011141728.50b2d17c@canb.auug.org.au>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 11 Oct 2018 09:51:10 +0200
Message-ID: <CACRpkdYic+7AN9d-F1kzZbLtOa0hHdM02NP3hvyWkM9VAckcmg@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the pinctrl tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 5:17 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> After merging the pinctrl tree, today's linux-next build (x86_64
> allmodconfig) produced this warning:
>
> drivers/pinctrl/bcm/pinctrl-ns.c: In function 'ns_pinctrl_probe':
> drivers/pinctrl/bcm/pinctrl-ns.c:288:29: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
>   ns_pinctrl->chipset_flag = (unsigned int)of_id->data;
>                              ^
> drivers/pinctrl/bcm/pinctrl-ns.c:310:27: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
>    unsigned int chipsets = (unsigned int)src->drv_data;
>                            ^

I tried to fix it, stumbled, not I tried to fix it again.
Let's see if I got it right now!

Thanks,
Linus Walleij
