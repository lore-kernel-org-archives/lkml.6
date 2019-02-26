Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A082FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 06:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 715C12173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 06:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551162026;
	bh=9w8mnQ9eFt/5KpibElCfdfR86FQyPwTZXJ0HJ2cI2xU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=DesigOcy2B0PpO4Ex5kp+vaGrnx2RgDxi0a9pzeAzef7iizQb7HdlXvvhQEV8qceY
	 xpmvQUkCZOkBd6oroB6QS44gxMifLHa/hY1JyPwEdNrRPfxJj94StpojAA0B9sv0a3
	 qX6ZCRaAo/NFM99Ns/UVhMqdJVibhwdeGJo3/DE0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbfBZGUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 01:20:24 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:34439 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfBZGUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 01:20:24 -0500
Received: by mail-io1-f66.google.com with SMTP id e1so9654210iok.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 22:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=N/2WTR1CA/ewwRuNv2Ih7VvBVXPzfHZPHFpt2uDgjlQ=;
        b=cvt1OGbLXwye/jg9VR7/y1NUaaAZZhFZeIjEnlY8e63Mlz6gp7RzOEt0MayrOedPvU
         0TXOGDvvJYqNIXxHeJgExInyMHDSYFyEePOUugdQ4aA/4ObJDRqij4WbY56uXlPIGQrf
         sQOoO6RLGl0X33p9sQ0HmMvvEyoLx/MNwxN/JxeLddExX48DJCqYtwQPAQY4XZkoBpU/
         Ee/MOHQonfbYjt62n4emN2klL+wGfooyvyzH0pybu+aZY+F9LSs10rlJmXQOzoCy+YzT
         urWIUQpqksMqKvV3SkzU7gZjg3B+RtAckrsyWcDaMRFWId51Fgfwi5nOG5aOtvrPpmRa
         xzKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=N/2WTR1CA/ewwRuNv2Ih7VvBVXPzfHZPHFpt2uDgjlQ=;
        b=JRCSPZyZkNAZ6bvZ8ocJeIV97PbvpP4WrhIsJe8og+aX4/+p+Yftavm1NTQrbLwTIj
         XIh6/diUCQbuAjTpPD+TAz7Wn5DV0YfUgeSsMuVt84iuXekQOodXRsO1X7MrxPZDlu7o
         dLBkkFQF7XddhHpbdNK5XOhNKv/KedTXSPt4l5YzuVRZmbsvLaYiK/3ifewmlkDRhDqk
         f+WrgDOxmbSaTOkvSa3LJmG2rJDE6kTn4l6/XiZjw6iYWTpsK6JHgBxe/B47Yuq6SLcG
         GSCbQzR+ozlfbsR4mNTzchuZRfTEGz1EZrqKNcLVONnK5OKPSH+zOxryP8Y8vuIJPgg/
         aTUA==
X-Gm-Message-State: AHQUAuZFIscAAjLn9EmEdJ/vEl5GJMbZdi8eKzT1tfcZkWd3ElyWNdZ5
        i8E2+HRdgXNYYF0TCk3WBP4=
X-Google-Smtp-Source: AHgI3IaPWr171g/uJ6orEo6hhVyVyBJJDAcY9SMradZJeZHJgky6Pc0Ggaq1jjlEJd2pCOx/JGxA7A==
X-Received: by 2002:a6b:1444:: with SMTP id 65mr11612528iou.105.1551162023014;
        Mon, 25 Feb 2019 22:20:23 -0800 (PST)
Received: from kbl.lan (h66-222-56-144.cntcnh.dsl.dynamic.tds.net. [66.222.56.144])
        by smtp.gmail.com with ESMTPSA id w8sm6431431ita.21.2019.02.25.22.20.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 22:20:22 -0800 (PST)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 0/14] v2 multi-die/package topology support
Date:   Tue, 26 Feb 2019 01:19:58 -0500
Message-Id: <20190226062012.23746-1-lenb@kernel.org>
X-Mailer: git-send-email 2.18.0-rc0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series does 4 things.

1. Parses the new CPUID.1F leaf to discover multi-die/package topology

2. Export multi-die topology inside the kernel

3. Update 3 places (coretemp, pkgtemp, rapl) that that need to know
   the difference between die and package-scope MSR.

   (Note: Kan Liang has a patch series on top of this one to similarly
   make the uncore perf code multi-die/package aware.)

4. Export multi-die topology to user-space via sysfs

These changes should have 0 impact on cache topology,
NUMA topology, Linux scheduler, or system performance.

These topology changes primarily impact parts of the kernel
and some applciations that care about package MSR scope.
Also, some software is licensed per package, and other tools,
such as benchmark reporting software sometimes cares about packages.

Changes since v1:

Responded to all syntax and style feedback.

Fixed a bug in the CPUID.1F parsing code
	we were parsing the leaf properly, but in some configs
	we were not updating the maps correctly

topology_logical_die_id() replaces topology_unique_die_id()

	Suggested by Kan, who's uncore code uses
	topology_logical_package_id().

Restored sysfs core_siblings, core_siblings_list

	v1 proposed re-defining this existing attribute to
	be the threads in a die, rather than in a package.

	For compatibility, decided rather to keep this
	attribute unchanged, for now, even though
	its name makes little sense, and it makes
	no sense in a multi-die system.

Added sysfs package_threads, package_threads_list

	Added this attribute to show threads siblings in a package.
	Exactly same as "core_siblings above", a name now deprecated.
	This attribute name and definition is immune to future
	topology changes.

	Suggested by Brice.

Added sysfs die_threads, die_threads_list

	Added this attribute to show which threads siblings in a die.
	V1 had proposed putting this info into "core_siblings", but we
	decided to leave that legacy attribute alone.
	This attribute name and definition is immune to future
	topology changes.

	On a single die-package system this attribute has same contents
	as "package_threads".

	Suggested by Brice.

Added sysfs core_threads, core_threads_list

	Added this attribute to show which threads siblings in a core.
	Exactly same as "thread_siblings", a name now deprecated.
	This attribute name and definition is immune to future
	topology changes.

	Suggested by Brice.


For compatibility, sysfs cpuX/topology core_siblings
and core_siblings_list are unchanged.  They retain
their legacy defintion of listing which CPUs share
the same package.

Patch Summary:

Unchanged:

[PATCH 01/14] x86 topology: Fix doc typo
[PATCH 02/14] topolgy: Simplify cputopology.txt formatting and
[PATCH 03/14] x86 smpboot: Rename match_die() to match_pkg()
[PATCH 05/14] cpu topology: Export die_id
[PATCH 07/14] powercap/intel_rapl: Simplify rapl_find_package()
[PATCH 10/14] powercap/intel_rapl: update rapl domain name and debug

Bug Fixed:

[PATCH 04/14] x86 topology: Add CPUID.1F multi-die/package support

New since v1:

[PATCH 06/14] x86 topology: Define topology_logical_die_id()
[PATCH 12/14] topology: Create package_threads sysfs attribute
[PATCH 13/14] topology: Create core_threads sysfs attribute
[PATCH 14/14] topology: Create die_threads sysfs attribute

Updated (to use logical_die_id()):

[PATCH 08/14] powercap/intel_rapl: Support multi-die/package
[PATCH 09/14] thermal/x86_pkg_temp_thermal: Support multi-die/package
[PATCH 11/14] hwmon/coretemp: Support multi-die/package



 Documentation/cputopology.txt                | 72 ++++++++++++++---------
 Documentation/x86/topology.txt               |  6 +-
 arch/x86/include/asm/processor.h             |  5 +-
 arch/x86/include/asm/smp.h                   |  1 +
 arch/x86/include/asm/topology.h              |  5 ++
 arch/x86/kernel/cpu/topology.c               | 85 +++++++++++++++++++++-------
 arch/x86/kernel/smpboot.c                    | 73 +++++++++++++++++++++++-
 arch/x86/xen/smp_pv.c                        |  1 +
 drivers/base/topology.c                      | 22 +++++++
 drivers/hwmon/coretemp.c                     |  9 +--
 drivers/powercap/intel_rapl.c                | 75 +++++++++++++-----------
 drivers/thermal/intel/x86_pkg_temp_thermal.c |  9 +--
 include/linux/topology.h                     |  6 ++
 13 files changed, 276 insertions(+), 93 deletions(-)

These patches are also available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git x86


