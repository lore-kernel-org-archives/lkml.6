Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2379707-1519371697-2-2911408992028620609
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519371696; b=qkdnJ+PCXSsqwGNHPNFY0JA8kI68Y3mB/44fWhlRSXOsL/r
    5bs2FDOKrsYF/L+weqYDZrMVb9Rr0IKCR6eU2U1SgDHKwP8J1ysaEO1VR70LuR0m
    KlnZycgHGgdLoH1NriUEbfosxeTi5vxEF/HSqa72Z7EdtRbipVu2j0SHehbOEYNa
    0MvfyDU4kkhwdofLfcrkYpFHPEXiK0BgIPe74Y4vBjC//FiRlTs9IxR/Fqazo8bn
    ofIGvkNpqH8iA9koJ4IgyBnDGuno/vbw7nIyh3GGxr9jswRRrYrxXe5WT6K3WQdP
    h13iPB8GYSQreH0wTm2OLp+3A/FCmncsz+XXC7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519371696; bh=j9xDzSPQv37Xv13oEeb5moXP3t
    Eu2Z7JDMtGYRlpeBc=; b=uoMflrmZ4yR8f8n1u6xcKreOO4fqdjk2RzqEnfC1ow
    r8edEbPagaKDo3ZHHVVh5qWxK6x+Fz12uKo1Qq2vm6jDLdLPBYHqdVwggD8Yd+6U
    KBS49QOJ/qlE0qwyksGHlbJ0z1PIj3OHiGLSxtENpr1XLA2Eq0tRWzSBptoRAkmJ
    j8zPRsNiEMdKiEQsHJh6I/4G+Ra5yNlLQwCh8wqpAJbZ5MrzcnSq2Qc037xJrhEF
    vHzkMeSiwhKFowIpIR0168b8e7q0UN1nYrkhO0lFvxRIww2rUcW86XcolTNMWODd
    LPu18FlDDWJlM+nwuJLWPPZXtis1/s3+7kfvnFt6yO4w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751503AbeBWHle (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 02:41:34 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:51218 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750962AbeBWHld (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 02:41:33 -0500
Date: Fri, 23 Feb 2018 08:41:33 +0100
From: gregkh <gregkh@linuxfoundation.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Olof's autobuilder <build@lixom.net>,
        Olof Johansson <olof@lixom.net>,
        Kernel Build Reports Mailman List
        <kernel-build-reports@lists.linaro.org>,
        stable <stable@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: stable-rc build: 13 warnings 0 failures
 (stable-rc/v4.15.4-164-g0cbdf96)
Message-ID: <20180223074133.GB327@kroah.com>
References: <5a8d9447.0bbf630a.b5452.267e@mx.google.com>
 <CAK8P3a3tQ8_tcuMgDxT9KwqZsOSzSAw31-b5os35GuPYTRK61g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3tQ8_tcuMgDxT9KwqZsOSzSAw31-b5os35GuPYTRK61g@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 21, 2018 at 05:35:26PM +0100, Arnd Bergmann wrote:
> On Wed, Feb 21, 2018 at 4:46 PM, Olof's autobuilder <build@lixom.net> wrote:
> > Warnings:
> 
> Hi Greg,
> 
> It's much better already, thanks for picking up all the patches so
> far. Looking at the
> remaining warnings:
> 
> >         arm64.allmodconfig:
> > arch/arm64/boot/dts/mediatek/mt8173-evb.dtb: Warning (cooling_device_property): Missing property '#cooling-cells' in node /cpus/cpu@0 or bad phandle (referred from /thermal-zones/cpu_thermal/cooling-maps/map@0:cooling-device[0])
> > arch/arm64/boot/dts/mediatek/mt8173-evb.dtb: Warning (cooling_device_property): Missing property '#cooling-cells' in node /cpus/cpu@100 or bad phandle (referred from /thermal-zones/cpu_thermal/cooling-maps/map@1:cooling-device[0])
> 
> Send a patch for this now, backported from mainline.
> 
> > WARNING: modpost: missing MODULE_LICENSE() in drivers/phy/qualcomm/phy-qcom-ufs.o
> 
> This is coming to a future mainline kernel.
> 
> > WARNING: modpost: missing MODULE_LICENSE() in drivers/soc/qcom/rmtfs_mem.o
> 
> It seems I missed a couple of MODULE_LICENSE backports in the previous list.
> 
> 3b229bdb54cc ("soc: qcom: rmtfs_mem: add missing
> MODULE_DESCRIPTION/AUTHOR/LICENSE")
> 
> >         arm.allmodconfig:
> > /tmp/cctgVBy5.s:18153: Warning: using r15 results in unpredictable behaviour
> > /tmp/cctgVBy5.s:18225: Warning: using r15 results in unpredictable behaviour
> 
> Still got this on my radar, no fix is upstream yet.
> 
> > WARNING: modpost: missing MODULE_LICENSE() in sound/soc/ux500/snd-soc-ux500-plat-dma.o
> > WARNING: modpost: missing MODULE_LICENSE() in sound/soc/ux500/snd-soc-ux500-mach-mop500.o
> 
> 1783c9d7cb7b ("ASoC: ux500: add MODULE_LICENSE tag")
> 
> > WARNING: modpost: missing MODULE_LICENSE() in drivers/video/fbdev/mmp/mmp_disp.o
> 
> c1530ac5a3ce ("video: fbdev/mmp: add MODULE_LICENSE")
> 
> > WARNING: modpost: missing MODULE_LICENSE() in arch/arm/common/bL_switcher_dummy_if.o
> 
> a21b4c10c7bf ARM: 8743/1: bL_switcher: add MODULE_LICENSE tag
> 
> > WARNING: modpost: missing MODULE_LICENSE() in drivers/soc/qcom/rmtfs_mem.o
> 
> 3b229bdb54cc soc: qcom: rmtfs_mem: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE

I've picked these license patches up now, thanks.

greg k-h
