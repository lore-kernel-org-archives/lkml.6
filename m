Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE83ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 14:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3391C208B1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 14:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="VZCD3SMl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3391C208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730028AbeGMPO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 11:14:27 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:38662 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729670AbeGMPO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 11:14:26 -0400
Received: by mail-lf0-f68.google.com with SMTP id a4-v6so27427289lff.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 07:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Sue2LFuHuAowKxpKHlAqLjkOKRE5R3lGuIcJR7ImqVs=;
        b=VZCD3SMlsefpN6Pl2jV93usUX76O+iAFkr+m84zSXXhq6Z2Ul2U4D1o8YqT7vMt/U4
         iEIFUejDV2//oGbbAdX5O73sunOP6J/6nCibFJu4aK2JikjxS8nNTX5seiQUf2Vw2030
         l0jEkwKl8IC9GqTFXCPbPbqaPEdVzNLV2mgbe5HNWPmBfp/5LvE9WBMR5Gy64YyaO9DH
         tPKcbQ4LG0AeOKuF/cqg6uKDdMw0r3gghjRucsCPS5sQw53nco1Darge/myz8+/MBr8m
         FJa15nzhFzGKgsqs/7IrmQI/y9DQ2dimdATF8s+A674NgKdS+GM37Bz7EA7rxGghJLA4
         9q2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Sue2LFuHuAowKxpKHlAqLjkOKRE5R3lGuIcJR7ImqVs=;
        b=LdPRskUvIrkZLOMkexMUZyoc7cDreYwfks/byORmGbp6ZPj0GVCccIo1VPZBmoJkAI
         rR7blzIWL1xsOq+BngtI9G1Kp8UOiKFpy3onQ8++EMxvsggv6gbRsCfSEHSn8DejyVcx
         iBnma7dY3QYs0T81w8tppp5Q97hyrs23Q81Iy0uRBoZsjAuSVP2A5yDmVwOeVtPQYga3
         N0tcaLpEPzy8ZorbWxWCz6ZYPKXy2/WVAeaYBR7fQ7O9IploU1k/hceeOJk/oFBCqwQs
         NkapYO4C18l1VFmTT3P8Ydhr674l8CKTYpF8aaPy4Cd/h8HBcR+N1k4PDyKugJrwIvjE
         qdmQ==
X-Gm-Message-State: AOUpUlEOF2HgJ/tEzvHDHqdDTENamqS3BPeKpWeQPh5Wf4W82oOzpdEt
        TKrmacdiySoA9VhDxBbEGvfbNQ==
X-Google-Smtp-Source: AAOMgpc4x4SkBQFSJvuk7/ZbW3ZRTab1IwYH3s7aIjsibjNOAx6+OHE5xN9ealRwkLc+znQ1V/OE0w==
X-Received: by 2002:a19:501e:: with SMTP id e30-v6mr5162006lfb.71.1531493965411;
        Fri, 13 Jul 2018 07:59:25 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.se.alltele.net. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id f18-v6sm2866509lja.85.2018.07.13.07.59.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 07:59:23 -0700 (PDT)
Date:   Fri, 13 Jul 2018 07:59:10 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Paul Kocialkowski <contact@paulk.fr>,
        Laura Abbott <labbott@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>
Subject: Re: [PATCH] Revert "arm64: Use aarch64elf and aarch64elfb emulation
 mode variants"
Message-ID: <20180713145910.2mlzip5ssk72cleo@localhost>
References: <20180709200956.31158-1-labbott@redhat.com>
 <20180710090125.GA28924@arm.com>
 <fcd8d97b6714d787297f1b362558e7a68855a1da.camel@paulk.fr>
 <20180710093615.GA30095@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710093615.GA30095@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 10:36:16AM +0100, Will Deacon wrote:
> On Tue, Jul 10, 2018 at 11:30:39AM +0200, Paul Kocialkowski wrote:
> > On Tue, 2018-07-10 at 10:01 +0100, Will Deacon wrote:
> > > Thanks, Laura.
> > > 
> > > I'll take this as a fix, and add a comment to the Makefile to justify
> > > why we need the linux target.
> > 
> > So this comes down to either breaking fedora/debian toolchains (that
> > don't support elf emulation mode) or breaking bare-metal toolchains
> > (that don't support linux emulation mode).
> > 
> > Since Linux is a bare-metal project that does not technically require
> > the linux target (who said using "Linux" for all things is confusing?),
> > I think it should aim for the elf target in the long term.
> > 
> > But well, breaking Linux build in common distros isn't good either, so I
> > guess it makes sense to revert this while distros toolchains are being
> > fixed. Hopefully, it won't take too long.
> > 
> > What do you think?
> 
> Yes, we need to revert the change since it's a regression otherwise. I think
> the best course of action here would be to find a way that we can either
> tell the linker that it doesn't need the missing linker scripts because
> we're providing our own, or find a way to pass different LD flags depending
> on whether or not we have a linux toolchain.
> 
> For now, I've pushed the revert to for-next/fixes.

Hi Will,

This is regressed in mainline as well. But I think we can just use a (slightly
improved) ld-option here? I checked it for x86 regression since it uses the
one-argument version. Patch is here, can you pick that up instead and get it in
for 4.18-rc?

Thanks,


-Olof

From 0d73b2d1774d5edce20aac919ba356b61d098646 Mon Sep 17 00:00:00 2001
From: Olof Johansson <olof@lixom.net>
Date: Fri, 13 Jul 2018 07:56:11 -0700
Subject: [PATCH] arm64: Fix build on some toolchains

Not all toolchains have the baremetal elf targets, RedHat/Fedora ones in
particular. So, probe for whether it's available and use the previous
(linux) targets if it isn't.

Fixes: 38fc42486775 ("arm64: Use aarch64elf and aarch64elfb emulation mode variants")
Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/arm64/Makefile    | 4 ++--
 scripts/Kbuild.include | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 7976d2d242fa..c5ce97f69731 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -60,13 +60,13 @@ ifeq ($(CONFIG_CPU_BIG_ENDIAN), y)
 KBUILD_CPPFLAGS	+= -mbig-endian
 CHECKFLAGS	+= -D__AARCH64EB__
 AS		+= -EB
-LDFLAGS		+= -EB -maarch64elfb
+LDFLAGS		+= -EB $(call ld-option, -maarch64elfb, -maarch64linuxb)
 UTS_MACHINE	:= aarch64_be
 else
 KBUILD_CPPFLAGS	+= -mlittle-endian
 CHECKFLAGS	+= -D__AARCH64EL__
 AS		+= -EL
-LDFLAGS		+= -EL -maarch64elf
+LDFLAGS		+= -EL $(call ld-option, -maarch64elf, -maarch64linux)
 UTS_MACHINE	:= aarch64
 endif
 
diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index c8156d61678c..1e13f502b42f 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -163,8 +163,8 @@ cc-ldoption = $(call try-run,\
 	$(CC) $(1) $(KBUILD_CPPFLAGS) $(CC_OPTION_CFLAGS) -nostdlib -x c /dev/null -o "$$TMP",$(1),$(2))
 
 # ld-option
-# Usage: LDFLAGS += $(call ld-option, -X)
-ld-option = $(call try-run, $(LD) $(LDFLAGS) $(1) -v,$(1),$(2))
+# Usage: LDFLAGS += $(call ld-option, -X, -Y)
+ld-option = $(call try-run, $(LD) $(LDFLAGS) $(1) -v,$(1),$(2),$(3))
 
 # ar-option
 # Usage: KBUILD_ARFLAGS := $(call ar-option,D)
-- 
2.11.0

