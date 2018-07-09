Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F6C1C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 23:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01763208DB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 23:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HR+Y3Em1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01763208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933206AbeGIXl0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 19:41:26 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:37873 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932828AbeGIXlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 19:41:24 -0400
Received: by mail-pf0-f196.google.com with SMTP id x10-v6so4876276pfm.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 16:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Uj8pkoBOXKQmwupl7YG3aqymyd/MK8TVdoF/8RiGvT4=;
        b=HR+Y3Em1Hdfd65aIcIpkGY4ItH3sOUVXnC7IpduN1OekVf4p3YfCn1hcEoata0FyYM
         5y0U9bW6h+kILery3o7CEfuxCENHZ4flX0Jvb+B75P6V4MduWh6gxIBS9FWStDy4ZlTA
         OB8DzHpYtYh4FXeF/eUAyo4U9Pyzqtqb7qEg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Uj8pkoBOXKQmwupl7YG3aqymyd/MK8TVdoF/8RiGvT4=;
        b=Ft9vj92/L9RWcyfCaqTKxwQs24j9PnAvd3YITeIsHgh8qvvvJ3pY8uJXLvmCYIJbEY
         rL51IsGRs9uM/0a7FE39c8liw5r4NrZVwKmkTAbelKx3N2Jr8g5tfVeL1P/QGf62srL6
         05mHcpO9dnRP5samq0OVSMmnUFOXL2On7HH9ZEK5Z6EpkG1zHLImdEQv8gYrpbzGfc9G
         2Tfk381sskkx1zwj72Zm7cRcSDJUXc9oIGnC6Mx3giCOIfsowhWRKM1NJTrAn2XBXvPp
         1G72YIo2832aQum/0hGLuaFqMBiW4y4R4CCcCn+QV59TYtNrvMazR/LzNqiroQjS0Ond
         AApw==
X-Gm-Message-State: APt69E1fB6XWJGcyBO+IDVoqk1lyhNlqpmqcp/67MV83yrBfq+A5AoSg
        eAbLNTGwVHRw4iGO2UAdlbBQLw==
X-Google-Smtp-Source: AAOMgpe0FYO19bqC3jq/0Rvx6pZHOb9HAip/8grq6qGlinuHaXxXAhwhPtIsq+R7KIPFYwm8SWXQLg==
X-Received: by 2002:a63:d309:: with SMTP id b9-v6mr7212965pgg.163.1531179684071;
        Mon, 09 Jul 2018 16:41:24 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id t3-v6sm29062690pfk.161.2018.07.09.16.41.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 16:41:23 -0700 (PDT)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com,
        ard.biesheuvel@linaro.org
Cc:     tbaicar@codeaurora.org, bhsharma@redhat.com, dyoung@redhat.com,
        james.morse@arm.com, mark.rutland@arm.com, al.stone@linaro.org,
        graeme.gregory@linaro.org, hanjun.guo@linaro.org,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v3.1 0/4] arm64: kexec,kdump: fix boot failures on acpi-only system
Date:   Tue, 10 Jul 2018 08:42:25 +0900
Message-Id: <20180709234229.20181-1-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This patch series is a set of bug fixes to address kexec/kdump
failures which are sometimes observed on ACPI-only system and reported
in LAK-ML before.

In short, the phenomena are:
1. kexec'ed kernel can fail to boot because some ACPI table is corrupted
   by a new kernel (or other data) being loaded into System RAM. Currently
   kexec may possibly allocate space ignoring such "reserved" regions.
   We will see no messages after "Bye!"

2. crash dump (kdump) kernel can fail to boot and get into panic due to
   an alignment fault when accessing ACPI tables. This can happen because
   those tables are not always properly aligned while they are mapped
   non-cacheable (ioremap'ed) as they are not recognized as part of System
   RAM under the current implementation.

After discussing several possibilities to address those issues,
the agreed approach, in my understanding, is
* to add resource entries for every "reserved", i.e. memblock_reserve(),
  regions to /proc/iomem.
  (NOMAP regions, also marked as "reserved," remains at top-level for
  backward compatibility. User-space can tell the difference between
  reserved-system-ram and reserved-address-space.)
* For case (1), user space (kexec-tools) should rule out such regions
  in searching for free space for loaded data.
* For case (2), the kernel should access ACPI tables by mapping
  them with appropriate memory attributes described in UEFI memory map.
  (This means that it doesn't require any changes in /proc/iomem, and
  hence user space.)

Please find past discussions about /proc/iomem in [1].
--- more words from James ---
Our attempts to fix this just in the kernel reached a dead end, because Kdump
needs to include reserved-system-ram, whereas kexec has to avoid it. User-space
needs to be able to tell reserved-system-ram and reserved-address-space apart.
Hence we need to expose that information, and pick it up in user-space.

Patched-kernel and unpatch-user-space will work the same way it does today, as
the additional reserved regions are ignored by user-space.

Unpatched-kernel and patched-user-space will also work the same way it does
today as the additional reserved regions are missing.
--->8---

Patch#1 addresses kexec case, for which you are also required to update
user space. See necessary patches in [2]. If you want to review Patch#1,
please also take a look at and review [2].

Patch#2, #3 and #4 address the kdump case above.


Changes in v3.1 (2018, July 10, 2018)
* add Ard's patch[4] to this patch set

Changes in v3 (2018, July 9, 2018)
* drop the v2's patch#3, preferring [4]

Changes in v2 (2018, June 19, 2018)
* re-organise v1's patch#2 and #3 into v2's #2, #3 and #4
  not to break bisect

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-March/565980.html
[2] https://git.linaro.org/people/takahiro.akashi/kexec-tools.git arm64/resv_mem
[3] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-April/573655.html
[4] https://marc.info/?l=linux-efi&m=152930773507524&w=2

AKASHI Takahiro (2):
  efi/arm: map UEFI memory map even w/o runtime services enabled
  arm64: acpi: fix alignment fault in accessing ACPI

Ard Biesheuvel (1):
  efi/arm: preserve early mapping of UEFI memory map longer for BGRT

James Morse (1):
  arm64: export memblock_reserve()d regions via /proc/iomem

 arch/arm64/include/asm/acpi.h      | 23 ++++++++++++------
 arch/arm64/kernel/acpi.c           | 11 +++------
 arch/arm64/kernel/setup.c          | 38 ++++++++++++++++++++++++++++++
 drivers/firmware/efi/arm-init.c    |  1 -
 drivers/firmware/efi/arm-runtime.c | 16 +++++++------
 5 files changed, 66 insertions(+), 23 deletions(-)

-- 
2.17.0

