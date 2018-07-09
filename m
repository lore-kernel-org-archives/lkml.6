Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69634C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 00:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14A81208DE
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 00:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jVcH4sJv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14A81208DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933207AbeGIAHC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 20:07:02 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34705 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932942AbeGIAHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 20:07:01 -0400
Received: by mail-pf0-f195.google.com with SMTP id e10-v6so12321476pfn.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jul 2018 17:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=TBYYWNIunOPOXXp1h6GYsMejT/InhEEpQzf9z0Ky6F4=;
        b=jVcH4sJv17jSOUoiyCvAvovrFxd2HkSeGyFTTvOo6isZJ1jVCo8ql86ZaMmZ/zRjLC
         9x4em3OQ2ass6ZXCSQpTpIAKY9poVWRCG3dTyZxzuC5IKlv5N6NJ4teeY2Ontv1xY2eN
         y+CXLtqcK9eOh+U6RemiOVmrklbxA2Eab9/Hs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TBYYWNIunOPOXXp1h6GYsMejT/InhEEpQzf9z0Ky6F4=;
        b=B0mHWuGPkAODhbZ0Q+f1m9PXzDAFkbi2MjzfNZDzJFPoLiWk9XfSPZAXZidOSBDg4Y
         6cy2tZ+m/hC/g1Sp8nfGxdv68rQUvhxnrcqwFQvaab6l4gnSYe2RXZ0jDhFWAEG0Aj+k
         HoAExfEmP0DvWcTjVwD5aQnl8UfUDDN4XHBB/3ujUZkWINx56nZ0ZRB4pTSEFq1mtcV7
         EniFnG2KJqXefWBhSLDS9mdq8wWIgBjj5nsCAPfeqP8nTMf3uT7Uj92/WHY0og1CKfW6
         H1XxkF0bwnzt24vVl5ny094foY6foi3/EaYP5cCzxrrg8vllY3bWftsS+3wzBNhAhxXq
         64Cg==
X-Gm-Message-State: APt69E30ed4M89npUd54VaHtC4ThNEkvtAnNlj3yskeUkEQJIArN4hs8
        jMKO5RYx1Id7rwMZAuomGtc7wXoisgo=
X-Google-Smtp-Source: AAOMgpdbjjMrnJH5L0FvzXXpHlCd6tPqm4kyXd1+2aupy2NK3YutDDMMXlK5pUTwHqEp3/ejSDZmjQ==
X-Received: by 2002:a63:5c10:: with SMTP id q16-v6mr16830370pgb.452.1531094820511;
        Sun, 08 Jul 2018 17:07:00 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id e82-v6sm31423474pfd.40.2018.07.08.17.06.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Jul 2018 17:06:59 -0700 (PDT)
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
Subject: [PATCH v3 0/3] arm64: kexec,kdump: fix boot failures on acpi-only system
Date:   Mon,  9 Jul 2018 09:07:47 +0900
Message-Id: <20180709000750.22172-1-takahiro.akashi@linaro.org>
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

Patch#2 and #3 addresses kdump case. Ard's patch [4] needs to be applied
preliminarily.


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

James Morse (1):
  arm64: export memblock_reserve()d regions via /proc/iomem

 arch/arm64/include/asm/acpi.h      | 23 ++++++++++++------
 arch/arm64/kernel/acpi.c           | 11 +++------
 arch/arm64/kernel/setup.c          | 38 ++++++++++++++++++++++++++++++
 drivers/firmware/efi/arm-runtime.c | 14 +++++------
 4 files changed, 64 insertions(+), 22 deletions(-)

-- 
2.17.0

