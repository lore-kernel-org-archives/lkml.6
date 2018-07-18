Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9529AECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54FDD2064D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:02:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54FDD2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730451AbeGRPk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 11:40:26 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38940 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbeGRPk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 11:40:26 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2D2DACA8;
        Wed, 18 Jul 2018 15:02:07 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.4 0/3] 4.4.142-stable review
Date:   Wed, 18 Jul 2018 17:01:57 +0200
Message-Id: <20180718145156.152413234@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.142-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.4.142-rc1
X-KernelTest-Deadline: 2018-07-20T14:51+00:00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.4.142 release.
There are 3 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Fri Jul 20 14:51:50 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.142-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.4.142-rc1

Arnaldo Carvalho de Melo <acme@redhat.com>
    perf tools: Move syscall number fallbacks from perf-sys.h to tools/arch/x86/include/asm/

Andy Lutomirski <luto@kernel.org>
    x86/cpu: Probe CPUID leaf 6 even when cpuid_level == 6

Rasmus Villemoes <linux@rasmusvillemoes.dk>
    Kbuild: fix # escaping in .cmd files for future Make


-------------

Diffstat:

 Makefile                                |  4 ++--
 arch/x86/kernel/cpu/common.c            |  7 ++++---
 scripts/Kbuild.include                  |  5 +++--
 tools/arch/x86/include/asm/unistd_32.h  |  9 +++++++++
 tools/arch/x86/include/asm/unistd_64.h  |  9 +++++++++
 tools/build/Build.include               |  5 +++--
 tools/perf/config/Makefile              |  1 +
 tools/perf/perf-sys.h                   | 18 ------------------
 tools/perf/util/include/asm/unistd_32.h |  1 -
 tools/perf/util/include/asm/unistd_64.h |  1 -
 tools/scripts/Makefile.include          |  2 ++
 11 files changed, 33 insertions(+), 29 deletions(-)


