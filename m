Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E1AC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09142206B8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:01:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09142206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbeI2D0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 23:26:37 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41800 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbeI2D0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 23:26:37 -0400
Received: by mail-oi1-f193.google.com with SMTP id l197-v6so6576872oib.8;
        Fri, 28 Sep 2018 14:01:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lRsq3w2R+gURnajoQ19rTCU7wGm92qa64p4LIPgdLd8=;
        b=HNpejmcpC9waWFo/++s4uA5Yy4jJkj+xUSVF8vh8IQg+KStHV4SGE1A0GGwAL6B4JZ
         nD9fao+XW4eKeYaAO2rd84RmonMHNXIjQU8IDbYEDQsaNcva2pX246IXCLJBhuPeNYpj
         C4IpRNbBuiDYF0Klxpg5ZkbU0QQKuoblZaqpn1OD38dHZDHgrmxgn7zuO6zSs35t3DUS
         S2357jGqkSMplGeu9VwsEdwMhwJkC9dPVM3hDgZ7NKDtCJj1JYH5Q+jGTqmLSbzweqxd
         NM0XgFNGgqygj3Ov/1ulYuKKG/coGC4+7A/clhl6pPQkHJUxQy/dpoA7NaTeLlEzSlM0
         TKng==
X-Gm-Message-State: ABuFfojliNvwgTY0yIy5g+/HRh7a0HjPVinNl5KqOponAKNLBbzv75Nj
        y8nf7c3NOa1Of1F9nDRzprVNBl4He6s=
X-Google-Smtp-Source: ACcGV63A+dU0U6/Z0BJjTcsEX4ZbIRdiSsUBhJCcojZM9rMaUN+cv4kHkqa8xjo9AlrMuxycQW89IA==
X-Received: by 2002:aca:3006:: with SMTP id w6-v6mr208450oiw.342.1538168465098;
        Fri, 28 Sep 2018 14:01:05 -0700 (PDT)
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com. [209.85.210.41])
        by smtp.gmail.com with ESMTPSA id n1-v6sm2290118ote.37.2018.09.28.14.01.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 14:01:04 -0700 (PDT)
Received: by mail-ot1-f41.google.com with SMTP id e18-v6so7326335oti.8;
        Fri, 28 Sep 2018 14:01:04 -0700 (PDT)
X-Received: by 2002:a9d:1d2a:: with SMTP id m39-v6mr267327otm.168.1538168464035;
 Fri, 28 Sep 2018 14:01:04 -0700 (PDT)
MIME-Version: 1.0
References: <CADRPPNT0QiBkJtJnxjW95Yf-mirL5OzRrvqj8rC-O8fiz17VnA@mail.gmail.com>
 <CAL_JsqKRH8uEzSx6H6ZSRJF9Ecp4am1cNsxgQqf2OO5_aGR1zw@mail.gmail.com>
In-Reply-To: <CAL_JsqKRH8uEzSx6H6ZSRJF9Ecp4am1cNsxgQqf2OO5_aGR1zw@mail.gmail.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Fri, 28 Sep 2018 16:00:52 -0500
X-Gmail-Original-Message-ID: <CADRPPNQam-QUfqDMvu42KS+50VaHfGPhCZj-1jRHQ-Od0fbxuQ@mail.gmail.com>
Message-ID: <CADRPPNQam-QUfqDMvu42KS+50VaHfGPhCZj-1jRHQ-Od0fbxuQ@mail.gmail.com>
Subject: Re: drivers binding to device node with multiple compatible strings
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Grant Likely <grant.likely@secretlab.ca>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        frowand.list@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 3:07 PM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Thu, Sep 27, 2018 at 5:25 PM Li Yang <leoyang.li@nxp.com> wrote:
> >
> > Hi Rob and Grant,
> >
> > Various device tree specs are recommending to include all the
> > potential compatible strings in the device node, with the order from
> > most specific to most general.  But it looks like Linux kernel doesn't
> > provide a way to bind the device to the most specific driver, however,
> > the first registered compatible driver will be bound.
> >
> > As more and more generic drivers are added to the Linux kernel, they
> > are competing with the more specific vendor drivers and causes problem
> > when both are built into the kernel.  I'm wondering if there is a
> > generic solution (or in plan) to make the most specific driver bound
> > to the device.   Or we have to disable the more general driver or
> > remove the more general compatible string from the device tree?
>
> It's been a known limitation for a long time. However, in practice it
> doesn't seem to be a common problem. Perhaps folks just remove the
> less specific compatible from their DT (though that's not ideal). For
> most modern bindings, there's so many other resources beyond
> compatible (clocks, resets, pinctrl, etc.) that there are few generic
> drivers that can work.
>
> I guess if we want to fix this, we'd need to have weighted matching in
> the driver core and unbind drivers when we get a better match. Though
> it could get messy if the better driver probe fails. Then we've got to
> rebind to the original driver.

Probably we can populate the platform devices from device tree after
the device_init phase?  So that all built-in drivers are already
registered when the devices are created and we can try find the best
match in one go?  For more specific loadable modules we probably need
to unbind from the old driver and bind to the new one.  But I agree
with you that it could be messy.

>
> Do you have a specific case where you hit this?

Maybe not a new issue but "snps,dw-pcie" is competing with various
"fsl,<chip>-pcie" compatibles.  Also a specific PHY
"ethernet-phy-idAAAA.BBBB" with generic "ethernet-phy-ieee802.3-c45".

Regards,
Leo
