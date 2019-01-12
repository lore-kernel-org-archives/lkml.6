Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 881C4C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 01:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D39A2084E
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 01:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="D7LHORWe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfALBXj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 20:23:39 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46850 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbfALBXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 20:23:39 -0500
Received: by mail-pl1-f195.google.com with SMTP id t13so7504112ply.13
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 17:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xXAKq+C73qcWwmQZCf1cLaLWH7ZoqZLp/OTcQcqTqr0=;
        b=D7LHORWew52n5SzWVyB8gJZ9PRz0amc9HSfLMFAGKx/hL97MVZyNYRz7c7z8BP90zx
         Z9cCW5rQjP93QU8oxqkmzWTX5g34HM+O3CkhM3JmIlS4o7urjmKv1RmLYWHn2FqlcWed
         ivdz0FcuGtNeQxHEDbf3eFtfPf76dXsmToEXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xXAKq+C73qcWwmQZCf1cLaLWH7ZoqZLp/OTcQcqTqr0=;
        b=uLccmpvnpiWaRIWIKMEFcmfDmlZ67q0ahUyE6j7AdIGN9BwPUPb32QLxojS6sqEwkg
         /Zd/E/MIhlMGqbSPm8E4SpKwKtEVus6ghhqXl0Qx3RKFEDl9WYwWJIMJHY7rMR+zKSDj
         cMDcu2jn3BhBNTgifbwQRN4b2Ihb3NfnYG+GisAzgSSB4iEnjCLpN5B7n0AxwKIMh7Jz
         imMfyQydHeS1BXslWf+sLneD/T4VNVCuzz6DuwVKBSYi8rBYUnlVI3GdBUqQpQJsvCDL
         nC8zyzsi/u4PXNaI72XcGJfN2I5ql7uKrSPUL6bignw4hdjuhu9qr5w++QOUJprufHJa
         l0vA==
X-Gm-Message-State: AJcUukdgM8DPV7oLEvC6gvoVU62jlt8tChss+3DmRVTwuEfLsOLPyT3s
        6bms0/TKGg3PDHWRcZ1o0ZlxwA==
X-Google-Smtp-Source: ALg8bN5bg+OqCtOaxfHkCuCJ85svvIcWGEbvf25Xs2c8R57gLF5zHsoC+5Z75f0gAKk+W2cPiO9vEg==
X-Received: by 2002:a17:902:bb86:: with SMTP id m6mr17052484pls.315.1547256218929;
        Fri, 11 Jan 2019 17:23:38 -0800 (PST)
Received: from dragon (61-216-91-114.HINET-IP.hinet.net. [61.216.91.114])
        by smtp.gmail.com with ESMTPSA id g3sm173001780pfe.37.2019.01.11.17.23.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 11 Jan 2019 17:23:37 -0800 (PST)
Date:   Sat, 12 Jan 2019 09:23:26 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the imx-mxs tree
Message-ID: <20190112012323.GA8478@dragon>
References: <20190111093003.2f00829e@canb.auug.org.au>
 <20190111095605.129a93a2@canb.auug.org.au>
 <20190111001559.12d91530@jawa>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190111001559.12d91530@jawa>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 12:15:59AM +0100, Lukasz Majewski wrote:
> Hi Stephen,
> 
> > Hi all,
> > 
> > On Fri, 11 Jan 2019 09:30:03 +1100 Stephen Rothwell
> > <sfr@canb.auug.org.au> wrote:
> > >
> > > After merging the imx-mxs tree, today's linux-next build (arm
> > > multi_v7_defconfig) failed like this:  
> > 
> > Actually this is only treated as a warning.

Thanks for reporting, Stephen.

> 
> Thanks for the notification. I will look on that (soon).

I just sent a fix for it.

https://patchwork.kernel.org/patch/10760827/

> 
> > 
> > > arch/arm/boot/dts/vfxxx.dtsi:550.24-563.6: Warning
> > > (spi_bus_bridge): /soc/aips-bus@40080000/spi@400ad000: incorrect
> > > #address-cells for SPI bus also defined at
> > > arch/arm/boot/dts/vf610-bk4.dts:130.8-142.3
> > > arch/arm/boot/dts/vf610-bk4.dtb: Warning (spi_bus_reg): Failed
> > > prerequisite 'spi_bus_bridge'
> > > 
> > > 
> > > Caused by commit
> > > 
> > >   cf91ce9696a0 ("ARM: dts: vf610-bk4: Provide support for reading
> > > ID code from MVB device")  

I found that the warning exists even on v5.0-rc1, so it's not caused by
Lukasz's change.

Shawn
