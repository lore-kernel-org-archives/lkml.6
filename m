Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AAD1C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E14682086D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BGsQxV0a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E14682086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbeH2LhG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 07:37:06 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33764 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbeH2LhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 07:37:05 -0400
Received: by mail-pf1-f195.google.com with SMTP id d4-v6so1913424pfn.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 00:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KbQUysjEP1xsNZVrxroiuYFkSF+ojmTkoR8Lw0wgNp0=;
        b=BGsQxV0aXNaLgF6NNwvVv+xCt9Q0jMt09FjbgP+YCncALh+X59vBg7CniLqEQpgMEw
         abUUVagNhZP8BkxFX1jS9p2P6Dbvud9PW2ha3PtStkxQj6azo3sRq4/KcCjHz7MTPTBD
         08UPyuY0ib2gSzg+OJl4iC3y/Sbd/HJg/GcoU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KbQUysjEP1xsNZVrxroiuYFkSF+ojmTkoR8Lw0wgNp0=;
        b=ZrFvFGJu1o4G8WXYaUlnj80xIvmeMw3qvvPpr8wznZEe2EUJiKEbjV7CnDHt4dGqEm
         iekeNZmzK8mk9iufVt2oUpe532144Mo02/jcX8Ge+3u/zoLmBSsRKH/LiNEcAFzLmpj9
         ZajnODW3i7M+M8/u5U0y2ZeYIlKJD9yHwg/7s+l1SUUrId0s0nDo5TLKghLC4uJamKHX
         +jW7q8XfNpEvUSZx1SHPvhh0152zI4L433EAz7eHsmkAo8/hbVxRREDmR1yYdC8HVw0I
         stDUWFU+cji8imbezyUOZg7jJpgUvRER6w8jLprjP/imLHdJMG7ZMNDrnffrQycT8VhN
         7ceA==
X-Gm-Message-State: APzg51BvGOTb2cI17gZ8jw07b3F/tmlO7a84H6eyLXONd/K3lRocJCJD
        P4HrClhOQcM4ES4neKIRF9mU
X-Google-Smtp-Source: ANB0Vdaa6VTp9disFYH69tbeYBO2eJQbeGxUpmEOyJbjM1sxx0eEi34xd8Lnbrj5PeuCFL5XWro7zw==
X-Received: by 2002:a63:9841:: with SMTP id l1-v6mr4498019pgo.228.1535528491996;
        Wed, 29 Aug 2018 00:41:31 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6384:6a6:70b9:a288:9cdc:3e44])
        by smtp.gmail.com with ESMTPSA id z11-v6sm8848391pgz.62.2018.08.29.00.41.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 00:41:31 -0700 (PDT)
Date:   Wed, 29 Aug 2018 13:11:19 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     sravanhome@gmail.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>, pn@denx.de,
        mp-cs@actions-semi.com, Jeff Chen <jeff.chen@actions-semi.com>,
        "Thomas C. Liau" <thomas.liau@actions-semi.com>,
        linux@cubietech.com
Subject: Re: [PATCH v4 0/5] Add Actions Semi S700 pinctrl support
Message-ID: <20180829074119.GA24958@Mani-XPS-13-9360>
References: <0180729200038.11795-1-sravanhome@gmail.com>
 <20180731194743.13678-1-sravanhome@gmail.com>
 <CACRpkda=q+LZMUN5xJ777ZGWxYRBdZTvG0naNqr5BoLnVQ1=aA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkda=q+LZMUN5xJ777ZGWxYRBdZTvG0naNqr5BoLnVQ1=aA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 09:35:38AM +0200, Linus Walleij wrote:
> On Tue, Jul 31, 2018 at 9:48 PM Saravanan Sekar <sravanhome@gmail.com> wrote:
> 
> > This patchset adds pinctrl support for Actions Semi S700 SoC.
> > Pinmux functions are only accessible for pin groups while pinconf
> > parameters are available for both pin groups and individual pins.
> >
> > pinctrl driver is verified using the Cubieboard7.
> >
> > common functionalities from s900 is moved for all Actions Semi
> > SoC's usage.
> > Common pad control configurations are moved to SoC specific
> >
> > dts entry for pinctrl depends on clock driver which is still under review:
> > https://patchwork.kernel.org/patch/10533959/
> 
> So what is the status of this patch set?
>

Oops. This one slipped through the cracks...

> I am happy to apply it once you have the right buildtime dependencies
> and Manivannan's ACK on the patch set! (Looks good to me.)
> 

Sadly mutt played its part on this patchset and 1,3 patches got
deleted accidentally.

> Maybe you want to rebase on v4.19-rc1 and resend as v5 before
> I do that though?
> 

Parthiban,

Can you please rebase and send the next iteration as Linus said. I'll take a
look.

Sorry for the late reply.

Regards,
Mani

> Yours,
> Linus Walleij
