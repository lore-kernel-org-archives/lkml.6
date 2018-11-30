Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F422C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61FC320834
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="SC1Lf6aD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61FC320834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbeLAKHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 05:07:18 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34172 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726519AbeLAKHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 05:07:18 -0500
Received: by mail-lj1-f195.google.com with SMTP id u6-v6so6408810ljd.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 14:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=D2hp/Ir0gBlnqWcUXzziRNf+Jis9t1VhUFTTdvJjBRc=;
        b=SC1Lf6aDLPjRP0JOUQoUj1dytI3cZdU5eDX1AxmL025ahvjfNxiC9+hqH6zA6KsDj+
         yQzEH0lOl332nbvYrSuopMgodlP+XrHkayXTEkhdtaSxpmPiujcZ1pRCKatLBIFjgYpD
         F6oA/3oqvvWacuukkqVquHuiWeCG1Pr032pbeiPygpObRjBF43ic/eLKcICxCr4gD5LO
         Wjt8J0BEJTzD1UGiO8g3Xyhas5e2LSy0voSlzD5Pkl9UCifkgUU4JzB8DhQVSynw12jX
         CGljiNu8k8fEulyz6NWdt1PKXpeSqVEpBD48xfBNeULmrasehxkxJ89zmdLL60Ps3/1o
         bPiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=D2hp/Ir0gBlnqWcUXzziRNf+Jis9t1VhUFTTdvJjBRc=;
        b=EI09+9rFdxM8tSvp4vSI1wCH15oq1sOWBjQm6h1FMMbixrC+pgccQhOAwtl7UqGbCB
         EYZ+R4z2wBYm6NIFv0F62vhmBpnIUy1ipyfb/EQ3mfygaSe605jcoYCPg2u0qRiUwJCK
         enEFOJsjMCsyMyGoOgg6L7l8lhZVOhzYOhQOOjFRYJ5J/2+Q2bIR7ZsfR14a8ZxpaDGF
         6zu9HVwBd8OqwYejkMD1ftKGlwijgTugWJCie/LzT3eFJSyYh8o6XlhUHqieiiZMrUFS
         UvLanJRZE36W+6i5cDd4zDmithMoEpz/HQ4MZtzn3o76KdxbVnw6yneHSeLCLuLkU/Qm
         38aA==
X-Gm-Message-State: AA+aEWbVCujDVrNl+miZZdQL1mK/NzgojLYNmRzONEeqV0qk76Uvj+cy
        tcmH9Wn8Z79GCgPO9YimzbCaFQ==
X-Google-Smtp-Source: AFSGD/VbTI/4U1VT41i7x5ClnS7JN+PeiNmFfZw/R0ZuiILEih03rWq9gADRYveyGS/GzhN/cfpVHA==
X-Received: by 2002:a2e:9603:: with SMTP id v3-v6mr4293247ljh.15.1543618584252;
        Fri, 30 Nov 2018 14:56:24 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id f8sm1143749lfe.72.2018.11.30.14.56.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 14:56:22 -0800 (PST)
Date:   Fri, 30 Nov 2018 11:48:18 -0800
From:   Olof Johansson <olof@lixom.net>
To:     Rob Herring <robh@kernel.org>
Cc:     chunyan.zhang@unisoc.com, Lyra Zhang <zhang.lyra@gmail.com>,
        ARM-SoC Maintainers <arm@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: [GIT PULL] sprd dts for kernel v4.20-rc1
Message-ID: <20181130194818.7v5ysbwkoq6buzko@localhost>
References: <1539854253-4784-1-git-send-email-chunyan.zhang@unisoc.com>
 <20181102183246.r5xxwsic2mxwihsi@localhost>
 <CAL_Jsq+HFPnzw4Fo3rLRMxber8_itGZ=LjnUeyvvDOt4_txm3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+HFPnzw4Fo3rLRMxber8_itGZ=LjnUeyvvDOt4_txm3g@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 09:18:34AM -0600, Rob Herring wrote:
> On Fri, Nov 2, 2018 at 1:50 PM Olof Johansson <olof@lixom.net> wrote:
> >
> > On Thu, Oct 18, 2018 at 05:17:33PM +0800, Chunyan Zhang wrote:
> > > Hi Arnd,
> > >
> > > For 4.20-rc1 there's one patch only for sprd devicetree, please pull from my git tree:
> > >
> > > https://github.com/lyrazhang/linux.git m-v4.19-rc1
> > >
> > > Please let me know if there's some problem.
> > >
> > > Thanks,
> > > Chunyan
> > >
> > > ----------------------------------------------------------------
> > >
> > > Suzuki K Poulose (1):
> > >   arm64: dts: sc9836/sc9860: Update coresight bindings for hardware
> > >     ports
> > >
> > >  arch/arm64/boot/dts/sprd/sc9836.dtsi |  78 +++++++------
> > >  arch/arm64/boot/dts/sprd/sc9860.dtsi | 215 ++++++++++++++++++-----------------
> > >  2 files changed, 151 insertions(+), 142 deletions(-)
> >
> > Hi,
> >
> > This came in right before the merge window so it wasn't included since
> > it's more of a cleanup. Please resend it after -rc1 is out and we'll be
> > happy to queue it up for 4.21.
> 
> I'm enabling by default the DT warnings that this fixes, so please pull it in.

It was merged on November 13.


-Olof
