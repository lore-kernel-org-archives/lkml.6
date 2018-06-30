Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF59C3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 20:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 160752536B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 20:23:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 160752536B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751725AbeF3UXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 16:23:54 -0400
Received: from mout.gmx.net ([212.227.17.21]:49175 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751466AbeF3UXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 16:23:50 -0400
Received: from ls3530.fritz.box ([92.116.139.101]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LpwZn-1g26ii2or9-00fg7p; Sat, 30
 Jun 2018 22:23:39 +0200
Date:   Sat, 30 Jun 2018 22:23:35 +0200
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Subject: [GIT PULL] parisc architecture code cleanups and fixes
Message-ID: <20180630202335.GA7097@ls3530.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Provags-ID: V03:K1:PhduCnCFN5RaSQPnwZekGyEcnqVy9Qd86/tZG+PfvjnS7adu5ZI
 WbMFBOMYy+ilgoOos9suOYEhnwh+dB4oZoZNghno7pfpSyToXzUNn72lVIwxyraRBvgzw6r
 +/509wqWvLEtckoFmTIoz/3wxquicvuj/ugworWjeDrI55tAI1ZcTSSkEU1C3dJ5SrCI2xx
 n5vchp11nUrEUQPIsFQAg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NiYo5hkWnsA=:9+LEtITwVEWg53I/CS/Imn
 OCjvPaL+6oW9pA4iQXzd9Si17WjrBK20FYRMK/RMJK8nXvKMm+qACRn+ffrSjUAj9JJ6EYsJd
 LaFQLWPAWSJk1R9XlZG/Dh9v7QC6ub1VJf9RbHCwmfnxeQrxYshhulywLwAtyPNxxcSwEl8sG
 U1TAkFyfhlU1ttdN7C2n4FFaF937+5Ds4nK8c0e6pzwh7sTIpVXegGJG5GtzLC6JwF10T0d+b
 eo+1iVvzbW2Ocmr/P3snMCF/+whplvZQk9VHa0o7XlVAbMIIulKbYFK0yv9LAWUW85oPgNw5a
 eR6eCHP+kaWXA/K4VMRFlbvOM1xlLJufPv1MQS94Ukm/uAHUMYje+p+4MJiFCjaPZTJGaFfdE
 Tj70iZtCSgFl9fZaBLmkDkXqcAGYFymaSizwtgQ47dWlYLEl/4oo03u2zjdBDzimWV8Gas27s
 YHSJbpWT5FgvqAYadrZSQDASTyrO9fkyArju84D9Kq2mM8C/rCsdm98Lb3jdKThFztaqrO6XI
 tmgzHofifceJ/1N+WwAiedwm8hS+vo+qUiHFXtMiKmWqSVlJuZnwJyTAKe/royqSVZIV9tOjW
 KRvMRpYOM9EU0pxSiycbErs/X+0KRdXH1OsnynYCL+WoLgKthPwZKIsy9eUDeJYLsLwSp27GW
 dDxfjM0C3yJ0xaoeP0/Nkyoha3qUEF/5MnOHRA60Rqas3xVa5iGt7jrQJygi37PKM+PVRVTyP
 IgHz4g+ar2VSaNbOKWXd2JQALfgIdkv+TSnsp6RUPEH47cgAz+prQvhv+2o=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull some patches for the parisc architecture from:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-4.18-1

Nothing exiting in this patchset, just small cleanups of header files, kernel
now defaults to 4 CPUs when building a SMP kernel, mark 16- and 64-kB page
sizes broken and addition of the new io_pgetevents syscall.  

Thanks,
Helge

----------------------------------------------------------------
Andy Shevchenko (1):
      parisc: Convert printk(KERN_LEVEL) to pr_lvl()

Helge Deller (6):
      parisc: Drop struct sigaction from not exported header file
      parisc: Mark 16kB and 64kB page sizes BROKEN
      parisc: Default to 4 SMP CPUs
      parisc: Wire up io_pgetevents syscall
      parisc: Reduce debug output in unwind code
      parisc: Build kernel without -ffunction-sections

 arch/parisc/Kconfig                   |  6 +++---
 arch/parisc/Makefile                  |  4 ----
 arch/parisc/include/asm/signal.h      |  8 --------
 arch/parisc/include/uapi/asm/unistd.h |  3 ++-
 arch/parisc/kernel/drivers.c          | 25 +++++++++----------------
 arch/parisc/kernel/syscall_table.S    |  1 +
 arch/parisc/kernel/unwind.c           |  4 ++--
 7 files changed, 17 insertions(+), 34 deletions(-)
