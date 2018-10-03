Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6448CC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 16:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E68C21470
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 16:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QnSHIbfV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E68C21470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbeJCWwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 18:52:42 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:45007 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbeJCWwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 18:52:42 -0400
Received: by mail-yb1-f193.google.com with SMTP id x5-v6so2576857ybl.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 09:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=r5eOxdkRwXJ8BFmkB3arcqaO7pEDM51vZaTZGBjoL44=;
        b=QnSHIbfVeb5WuqNnwLd7F7n7Jf111QAMZL/3YZrM4/YLYjEz6X6gLg/34W6uMKZHz/
         roq64QuIVo8PGLLXUC2i1b++isNrl45146ElsNgYM/M5bSSfSLfof6DzYHbH04xfrOI/
         ChkYPZFaOCRgkXPCV8mRTQW5oM0efAnJrWwtFPkNqKmcBtowiHcFdY2NST4IOYbQdFJG
         VeojWyItg61Xu5Ljs7IBbXtrSRSZGiiEI1/4QKV+prK/4eXt63n4hjCc4nqnz9kG4Qad
         uBIBZd1u3fo95nFt6ISXoAe96zejVIVgePo/Sh89EyqhuJ2VRfwrKGkFaUo38iIDcSnN
         Tzkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=r5eOxdkRwXJ8BFmkB3arcqaO7pEDM51vZaTZGBjoL44=;
        b=AsqCSdbSPtOmlMe/OKr5NHpodljtgTrjP4WgAkerHV0U0yquxRhkBy88xQAg8G5QCa
         mNtSekuuYuG2hhalTIOm12Vb6CnzyRCbPCB2KBq/u06F7vFgQKoIxWq8y/+zBZhwxKGF
         uQcCw+jksubLOLixWMUdSRwtS0kpcShw0Z47+yAWkY6YERR58GaO/XrCgJPy/gCpxwYA
         YY2f4VThkoP8BdGtondfWih8+Y30E+vQqOstQjYrET46yhU6O9PP4PCOy+XcqSkxN+2Z
         BEGP5A9no46PYJzsUHup6+wT8A86M2U1JDH+0OggG+RtlpkgXRuGuLKYoSp7HupwMYb6
         NPuA==
X-Gm-Message-State: ABuFfojAMLNOUmI/jY5RK69uwx+VEXzRrSi5+9yaEkk85PG0V8A8A5FU
        KXLzH6femot2lJXGkVSWPdrmNj0Z2Shr/Q4BUOuQQg6BFlmYLQ==
X-Google-Smtp-Source: ACcGV6237Qg5FogFlXEN12WTvUX2+yhRquZt/XNJh1mXuI/vWiZ9nHje5t/lqgvb4y7tVpPwjwXIHb1DxciSpwoNkM0=
X-Received: by 2002:a25:e481:: with SMTP id b123-v6mr1282943ybh.416.1538582620976;
 Wed, 03 Oct 2018 09:03:40 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Wed, 3 Oct 2018 18:03:29 +0200
Message-ID: <CAJiuCcdR5dfN3MtvoqOMEG1hK+EuYgsdAaabW5wQrEDTdAOQdw@mail.gmail.com>
Subject: SoCFPGA Turn on ARM errata for L2 cache ?
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Saw this patch on the Altera OpenSource GitHub.

But it's not mainlained can I propose it?

How do you do when the patch is from someone else ? Do you keep the
sign-off of the original author or do you just mention it? in the
commit log ?

Thanks,
Clement

From 6f7559407c1fcdb9b31c9493f0da79d614290e91 Mon Sep 17 00:00:00 2001
From: Dinh Nguyen <dinguyen@kernel.org>
Date: Wed, 27 Feb 2013 18:29:14 -0600
Subject: [PATCH] ARM: socfpga: Turn on ARM errata for L2 cache

Turn on these ARM and PL310 errata for SoCFPGA:

ARM_ERRATA_754322
ARM_ERRATA_764369
ARM_ERRATA_775420

PL310_ERRATA_588369
PL310_ERRATA_727915
PL310_ERRATA_753970
PL310_ERRATA_769419

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 arch/arm/mach-socfpga/Kconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
index 4adb901dd5eb..a04660918d71 100644
--- a/arch/arm/mach-socfpga/Kconfig
+++ b/arch/arm/mach-socfpga/Kconfig
@@ -11,6 +11,13 @@ menuconfig ARCH_SOCFPGA
  select HAVE_ARM_TWD if SMP
  select MFD_SYSCON
  select PCI_DOMAINS if PCI
+ select ARM_ERRATA_754322
+ select ARM_ERRATA_764369 if SMP
+ select ARM_ERRATA_775420
+ select PL310_ERRATA_588369
+ select PL310_ERRATA_727915
+ select PL310_ERRATA_753970 if PL310
+ select PL310_ERRATA_769419

 if ARCH_SOCFPGA
 config SOCFPGA_SUSPEND
