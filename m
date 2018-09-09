Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4225C4321E
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 11:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E1E220857
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 11:07:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E1E220857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbeIIP47 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 11:56:59 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46204 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726650AbeIIP47 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 11:56:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E94B018A;
        Sun,  9 Sep 2018 04:07:39 -0700 (PDT)
Received: from iMac.local (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E41083F5BC;
        Sun,  9 Sep 2018 04:07:36 -0700 (PDT)
Date:   Sun, 9 Sep 2018 12:07:33 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Grant Likely <grant.likely@secretlab.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Leif Lindholm <leif.lindholm@linaro.org>,
        Alexander Graf <agraf@suse.de>,
        bcm-kernel-feedback-list@broadcom.com,
        Olof Johansson <olof@lixom.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] arm64: defconfig: enable EFI_ARMSTUB_DTB_LOADER
Message-ID: <20180909110732.GA63296@iMac.local>
References: <CAOesGMho8CfT7iDXadmkB5=7DoOi6n8qXcS9X643vf+Y0BbD6w@mail.gmail.com>
 <CAKv+Gu_mKU+RdPgg2Dfezy4-L+KDEEBx02R49ObomRhEkJJ6Mw@mail.gmail.com>
 <CAOesGMgLHx3+j1bWEsMWsN-yjGNZyLOpAjLg0Jut8gG=ADE25g@mail.gmail.com>
 <CAKv+Gu_x=bS4xJcD_LuEnnN=Lx4Jc87uK8J_ACdA9EeUqtM3Yg@mail.gmail.com>
 <CACxGe6uK+N5XUqZhH7gAQXoq+QXMvFPHF_i4WqivrufTU=0cog@mail.gmail.com>
 <bf917897-1697-a6c4-7f77-8dfa74dddc8a@broadcom.com>
 <CAKv+Gu8FK9K0G-GJygdpkwqKYzjvpDDj8TyGTC2u0SRxK3ez_w@mail.gmail.com>
 <1f8095f1-1f0c-0791-31c4-c7b986c4ce1f@broadcom.com>
 <CACxGe6tbuDzEaBqOD7Z3nWMW0Nkcf22MFbD3BL+KBqnKEo2tQw@mail.gmail.com>
 <dc26dc1b-c022-341b-18ba-c009275e5ee9@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dc26dc1b-c022-341b-18ba-c009275e5ee9@broadcom.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 11:04:36AM -0700, Scott Branden wrote:
> On 18-09-05 11:00 AM, Grant Likely wrote:
> > On Wed, Sep 5, 2018 at 6:27 PM Scott Branden <scott.branden@broadcom.com> wrote:
> > > On 18-09-05 02:40 AM, Ard Biesheuvel wrote:
> > > > On 4 September 2018 at 19:19, Scott Branden <scott.branden@broadcom.com> wrote:
> > > > > Rather than introduce EFI_ARMSTUB_DTB_LOADER, why not have
> > > > > the efistub use CONFIG_OF to determine whether it supports dtb= or not?
> > > > > 
> > > > > That way ACPI-only distros disable devicetree support entirely.
> > > > > 
> > > > Unfortunately, CONFIG_OF cannot be disabled on arm64 even on ACPI-only builds.
> > > OF shouldn't be automatically selected in the arm64/Kconfig.  It should
> > > have a config parmaeter like other archs as mips and arm.  I can
> > > submit a patch so it functions the same way as other archs so it
> > > is not always selected.  It will be good to add a USE_OF config
> > > options like the other archs (or simply remove the select from the
> > > Kconfig and choose OF directly in the defconfig. This will have
> > > the added benefit of doing away with OF support when its not
> > > needed on an ARM64 platform.  ACPI is already not automatically
> > > selected for all ARM64 platforms, nor should devicetree.
> > We don't do that on Arm because a devicetree is always required at
> > boot time. Even on ACPI systems a tiny DTB is used containing just a
> > /chosen node for passing the kernel command line and the initrd
> > location.
> 
> Seems bizarre DTB is not needed for x86 to boot from UEFI with ACPI
> support?  I'll look into it further at some point in order to remove such
> anomaly.  There should be no need for such devicetree reliance.

I'd say don't waste time on this, the patch would not get merged ;). As
Grant said, we use a tiny dtb to pass the command line, initrd to the
kernel. You'd have to invent an alternative (setup_header, ATAGs) and I
really don't see the point of increased complexity just because of some
philosophical arguments against OF.

-- 
Catalin
