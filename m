Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C80C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 09:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA8F120844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 09:20:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA8F120844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388959AbeHALFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 07:05:33 -0400
Received: from mout.gmx.net ([212.227.17.22]:39115 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387502AbeHALFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 07:05:32 -0400
Received: from homer.simpson.net ([185.191.219.92]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MDV5t-1fjMX53s69-00GsrI; Wed, 01
 Aug 2018 11:20:31 +0200
Message-ID: <1533115229.4735.43.camel@gmx.de>
Subject: Re: bisected - arm64 kvm unit test failures
From:   Mike Galbraith <efault@gmx.de>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Date:   Wed, 01 Aug 2018 11:20:29 +0200
In-Reply-To: <864lgey2ja.wl-marc.zyngier@arm.com>
References: <20180727215710.zq6gkoqzlb4ca7qv@linutronix.de>
         <1532768831.9882.71.camel@gmx.de> <1532847330.1618.8.camel@gmx.de>
         <1532864867.1618.32.camel@gmx.de> <1532967899.30205.62.camel@gmx.de>
         <1533061729.12487.26.camel@gmx.de> <867elay7he.wl-marc.zyngier@arm.com>
         <1533103345.4735.19.camel@gmx.de> <864lgey2ja.wl-marc.zyngier@arm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:gKRm10YT+Ah7qUDmt1Cf5aE/Yg07IfVFInwn2o3kHerkugHayEf
 dud/SmXYt64q1JtFfYxBqJF5vPnSj8pWO+MHxevPIBvqh27uzCx+VI0PkIVaOV+PoHaf1hf
 +BlzvnAS+6SCLmrqx7GQMpS7BPLa2UMb7JPA7lbhjgFQbnGyqKZynlZY2QYAsAjKxxcdLxg
 kuFA7w8gfx/jQSXTEM66Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6ISR+RoUPdQ=:5aJl/SlNIuWR79Pn4iHK3M
 aig5Rjpr7n7DpfSbExS97EcweOyhTFSRqfH7UQsZtA5igp3v/JPUgaK4I+DUBrJz7STamMXk2
 n8y2YsVhzZBH/AFSU+kE+WPD/vKpyXUwRubDevwSCoUWcxozxzvXyU9lfW/qMEknTyMYx1nXC
 ItmCbJXxweWuw/CKHZheE3Kpmzvzd+T+RzSMfuiJBOeECICwSXd7+t/nEvgp6W/dyj1+TNnH5
 M3xb4FHB8NFhxoBHxZU7dM40qFE+Bin1gHmKzXJH1GehWpWHHcpKtmhj5297UbPt0SuGda9bw
 3r5yoqltTaXozSc2FLfj/0Hm8PwgSzszzAY2OOi7Qxz2Pr0pBW6xoE/HnvP5XsEVvklFCk37u
 fqd+ksg43B1ER3CoCKSyV8vM/5pXR7+jYruooxfy5fJb2vvCwVXNDarun/LAY628rOtlra9jy
 UMPux9ztF87B/MhbtVny9/2/8D97pnF0e0oJ7mm+0MY7VSZoUKMVnl/0hWN7p2s6yRPXD2WTA
 I7fACDjLdjKL7Xggag04m/xl/EBmu34FhRBytYX6gOw1aEu0m16Q59V6rtVV19O1pienSf3n3
 7EKcgyJum+SQHPWPKdDZVLjwSE9poRNrEoqgkzfM0xwj8ETKpwQFqfFMgaxdogX3U6nToKxty
 IEYEu3R52lieS8UPPmUKfGq1uFRL9Sqjz39okZ+RdpadpatEjTJH6iNUNHOyPw8dbqzaRB2op
 8DpMXwWXeely/AXF8ErQ6WFRvYpH+v4wfAgPgBnAv0b+Y7QZ/aE8eIFHFjROHZy2TsnjIZ4P3
 i/IFmZj
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-08-01 at 08:22 +0100, Marc Zyngier wrote:
> On Wed, 01 Aug 2018 07:02:25 +0100,
> Mike Galbraith <efault@gmx.de> wrote:
> > 
> > [1  <text/plain; ISO-8859-15 (7bit)>]
> > On Wed, 2018-08-01 at 06:35 +0100, Marc Zyngier wrote:
> > > 
> > > Is it something that is reproducible with the current mainline (non-RT)?
> > 
> > These waters are a bit muddy, it's config dependent.  I'm trying to
> > generate a reproducing !RT config for -rc7 as we speak.  If I build
> > openSUSE/master-default, it does NOT reproduce.  That with the bisect
> > config just finished building, and.... yup, it reproduced
> > (attached).
> 
> Thanks for that.

Cheers.  The dependency is THP, which is disabled in RT.

--- config.save	2018-05-18 17:59:44.729165480 +0200
+++ .config	2018-08-01 11:00:24.484148316 +0200
@@ -632,7 +632,10 @@ CONFIG_DEFAULT_MMAP_MIN_ADDR=65536
 CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
 CONFIG_MEMORY_FAILURE=y
 # CONFIG_HWPOISON_INJECT is not set
-# CONFIG_TRANSPARENT_HUGEPAGE is not set
+CONFIG_TRANSPARENT_HUGEPAGE=y
+CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
+# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
+CONFIG_TRANSPARENT_HUGE_PAGECACHE=y
 CONFIG_CLEANCACHE=y
 CONFIG_FRONTSWAP=y
 CONFIG_CMA=y
@@ -4306,6 +4309,7 @@ CONFIG_RAS=y
 # CONFIG_ANDROID is not set
 # CONFIG_LIBNVDIMM is not set
 CONFIG_DAX=y
+# CONFIG_DEV_DAX is not set
 CONFIG_NVMEM=y
 # CONFIG_MTK_EFUSE is not set
 # CONFIG_QCOM_QFPROM is not set
@@ -5175,6 +5179,7 @@ CONFIG_DECOMPRESS_XZ=y
 CONFIG_DECOMPRESS_LZO=y
 CONFIG_DECOMPRESS_LZ4=y
 CONFIG_GENERIC_ALLOCATOR=y
+CONFIG_RADIX_TREE_MULTIORDER=y
 CONFIG_ASSOCIATIVE_ARRAY=y
 CONFIG_HAS_IOMEM=y
 CONFIG_HAS_IOPORT_MAP=y

