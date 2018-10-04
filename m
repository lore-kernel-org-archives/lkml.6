Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8540CC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CD1321473
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=secretlab-ca.20150623.gappssmtp.com header.i=@secretlab-ca.20150623.gappssmtp.com header.b="RMlBgxlU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CD1321473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=secretlab.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727765AbeJDQZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 12:25:33 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39229 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727150AbeJDQZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 12:25:32 -0400
Received: by mail-qt1-f194.google.com with SMTP id e22-v6so2048138qto.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 02:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=secretlab-ca.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sCKH4RQnTBpbeTBBN1euQfMgvs4V7eNXnGtZahTXz9o=;
        b=RMlBgxlURbreXIvdBKCc8WEpGZTsp5EPcsqG5rqIft2HhSRlBjEA7MCj+q9wmhcyTK
         UjVEWp9nnMwzmSaZkYgV626vgbEWhlqC05dGIhNWlhs/Gz1arFsjNWQNO51ASTEVeKhg
         V2x2aXqVTJqcb4somx66vMEdK67w4LvQq7hAZvtY2t17z0eribA5YCtqcuVYiIQHCcwY
         VXFYgR3lsSOYfGUjhb6r2/IFkhBuiNAa4UuAHg7nQgBxrs5PIGUziFeXSKEbyg1cTZZ1
         yvEDWjLigph+Vqz+rkz/O7D2yUtJexolqzVy5cPuyeM8rXH6cLhEM5MXGwqx0WOKnBam
         aFAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sCKH4RQnTBpbeTBBN1euQfMgvs4V7eNXnGtZahTXz9o=;
        b=pYwujR9n/zgpDCAqIqnCkL8nEUljGH8CAYVdFs3DkuYvov+feNsKVtJi5daFAdTkGn
         uGgxQIf3UCFhI2d7eGc0Vrn24tHb6HjblHeFrIBrSkP7/M7SvI/9qgCYP6hk7yslYpX8
         RyUAacdsP96yNpPyGPAISo9gHZfDVj36Y4l20JbZyKKaEDzPEUHP1+3d9f57aobw5vvl
         dsyoQ8wV2nOuKF1f2an9IkPaMjU2F256QxNGyOx2HW6oP2gYenBTZxUrV4HCgXq/CRmV
         mnxm9+jCw7nxzJoOF+2/v+DGkw9Kb3xh2oTmJcFH3FKSpq8rBgMOcbQhA7y2q4jsPtpJ
         h+Uw==
X-Gm-Message-State: ABuFfoj0f1qOZRaofGrgCzLql5OPMFsPml7T86dAP0vDEpa7K6JmsVnQ
        aCVivVIMo3e19s+wP4NmQzEBYYEgcpdAjFSrnu1qrQ==
X-Google-Smtp-Source: ACcGV63u0comoE/bR2Z8HnA95ESTlTk6G33GXn5IO/aUkVWIic4fpDVQxIPIZkr0m2fg3z2S0/9iMzgocLHwGyFLv4g=
X-Received: by 2002:ac8:1b87:: with SMTP id z7-v6mr4513208qtj.321.1538645588379;
 Thu, 04 Oct 2018 02:33:08 -0700 (PDT)
MIME-Version: 1.0
References: <CADRPPNT0QiBkJtJnxjW95Yf-mirL5OzRrvqj8rC-O8fiz17VnA@mail.gmail.com>
 <CAL_JsqKRH8uEzSx6H6ZSRJF9Ecp4am1cNsxgQqf2OO5_aGR1zw@mail.gmail.com> <CADRPPNQam-QUfqDMvu42KS+50VaHfGPhCZj-1jRHQ-Od0fbxuQ@mail.gmail.com>
In-Reply-To: <CADRPPNQam-QUfqDMvu42KS+50VaHfGPhCZj-1jRHQ-Od0fbxuQ@mail.gmail.com>
From:   Grant Likely <grant.likely@secretlab.ca>
Date:   Thu, 4 Oct 2018 10:32:56 +0100
Message-ID: <CACxGe6u2FQ8r1Ya6-mWoGcs7g2OLMccu68uskZvDLS6ows-hXQ@mail.gmail.com>
Subject: Re: drivers binding to device node with multiple compatible strings
To:     leoyang.li@nxp.com
Cc:     Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev@lists.ozlabs.org,
        Frank Rowand <frowand.list@gmail.com>,
        Grant Likely <grant.likely@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 10:01 PM Li Yang <leoyang.li@nxp.com> wrote:
>
> On Fri, Sep 28, 2018 at 3:07 PM Rob Herring <robh+dt@kernel.org> wrote:
> >
> > On Thu, Sep 27, 2018 at 5:25 PM Li Yang <leoyang.li@nxp.com> wrote:
> > >
> > > Hi Rob and Grant,
> > >
> > > Various device tree specs are recommending to include all the
> > > potential compatible strings in the device node, with the order from
> > > most specific to most general.  But it looks like Linux kernel doesn't
> > > provide a way to bind the device to the most specific driver, however,
> > > the first registered compatible driver will be bound.
> > >
> > > As more and more generic drivers are added to the Linux kernel, they
> > > are competing with the more specific vendor drivers and causes problem
> > > when both are built into the kernel.  I'm wondering if there is a
> > > generic solution (or in plan) to make the most specific driver bound
> > > to the device.   Or we have to disable the more general driver or
> > > remove the more general compatible string from the device tree?
> >
> > It's been a known limitation for a long time. However, in practice it
> > doesn't seem to be a common problem. Perhaps folks just remove the
> > less specific compatible from their DT (though that's not ideal). For
> > most modern bindings, there's so many other resources beyond
> > compatible (clocks, resets, pinctrl, etc.) that there are few generic
> > drivers that can work.
> >
> > I guess if we want to fix this, we'd need to have weighted matching in
> > the driver core and unbind drivers when we get a better match. Though
> > it could get messy if the better driver probe fails. Then we've got to
> > rebind to the original driver.
>
> Probably we can populate the platform devices from device tree after
> the device_init phase?  So that all built-in drivers are already
> registered when the devices are created and we can try find the best
> match in one go?  For more specific loadable modules we probably need
> to unbind from the old driver and bind to the new one.  But I agree
> with you that it could be messy.

It's a tradeoff.
>
> >
> > Do you have a specific case where you hit this?
>
> Maybe not a new issue but "snps,dw-pcie" is competing with various
> "fsl,<chip>-pcie" compatibles.  Also a specific PHY
> "ethernet-phy-idAAAA.BBBB" with generic "ethernet-phy-ieee802.3-c45".
>
> Regards,
> Leo
