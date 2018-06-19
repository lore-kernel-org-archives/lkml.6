Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF1FC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 06:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D240020875
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 06:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KKxeGYYL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D240020875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755816AbeFSGp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 02:45:58 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:43400 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751767AbeFSGn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 02:43:56 -0400
Received: by mail-pl0-f68.google.com with SMTP id c41-v6so10395577plj.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 23:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=P8CdaOGVTAyb3AJS+5wYUO46UJr+fNO9qIgKbngI8F4=;
        b=KKxeGYYLkWUwZZwkIQ7QIq8XXif2+b7tDEf1W0NIBt6qyu94zpjhc974ayq9ovGUwr
         uVeV839nW/akXvgylufQNt1T/ttuPvCt8o0A11m+IZkshi/6fb5y0KtEi3A/wsmoCsUH
         n0JzB35hw5g5JWEPpCzc/gp4Rlj+JyR+YqFdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=P8CdaOGVTAyb3AJS+5wYUO46UJr+fNO9qIgKbngI8F4=;
        b=dUnrPIueNpAcooUVqohqnz1qKdKXKG7BtNgNZwi36E7y/rUDDi6xF279NIzPostvuY
         zoO0LloaAG+FeTwvhPFipN8Hlr7I4lPKpgctgZ7+mnb5fB9QjCvntRVNR5CsPU2SFVzd
         xBxPSF+zz7Z9XxKAgB7rSWMZPfpMzLtoFlhwFl4VVh2Fn8ktMIcay/XmZ6ffZx8tAqXR
         zD0T3+cuzYUQ15RWlrj4qwYfeRAbXVMWkg6fuv93uHDmO7EuNal9YQRpea802b6BHg9+
         LyKM7LWftg5/Z9YGQvKSO6FaRA1PHPPuf1+AGGXrOY9zw7enXgXb5BC5PXNef7a9nOj5
         yrnw==
X-Gm-Message-State: APt69E3MAiota12cXSPaY1GkmPr9dTjwam78g/3StG53I0fERdMHlopc
        m3hv3vNRNHOgiRp4o/5J7ksmOg==
X-Google-Smtp-Source: ADUXVKLce4gwW7GCagKxS1ooXxLGwaiiEyKWAyiTiL6laI4gppFuX6/yAyhkeKuyztXY0I0SblrLZA==
X-Received: by 2002:a17:902:6a89:: with SMTP id n9-v6mr17338099plk.302.1529390636361;
        Mon, 18 Jun 2018 23:43:56 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id r26-v6sm40889214pfj.180.2018.06.18.23.43.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 23:43:55 -0700 (PDT)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com,
        akpm@linux-foundation.org, ard.biesheuvel@linaro.org
Cc:     tbaicar@codeaurora.org, bhsharma@redhat.com, dyoung@redhat.com,
        james.morse@arm.com, mark.rutland@arm.com, al.stone@linaro.org,
        graeme.gregory@linaro.org, hanjun.guo@linaro.org,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v2 0/4] arm64: kexec,kdump: fix boot failures on acpi-only system
Date:   Tue, 19 Jun 2018 15:44:20 +0900
Message-Id: <20180619064424.6642-1-takahiro.akashi@linaro.org>
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

Patch#2 to #4 addresses kdump case. This is a revised version after
Ard's comments.[3]

Changes in v2 (2018, June 19, 2018)
* re-organise v1's patch#2 and #3 into v2's #2, #3 and #4
  not to break bisect

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-March/565980.html
[2] https://git.linaro.org/people/takahiro.akashi/kexec-tools.git arm64/resv_mem
[3] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-April/573655.html

AKASHI Takahiro (3):
  efi/arm: map UEFI memory map even w/o runtime services enabled
  efi/arm: map UEFI memory map earlier on boot
  arm64: acpi: fix alignment fault in accessing ACPI

James Morse (1):
  arm64: export memblock_reserve()d regions via /proc/iomem

 arch/arm64/include/asm/acpi.h      | 23 ++++++++++++------
 arch/arm64/kernel/acpi.c           | 11 +++------
 arch/arm64/kernel/setup.c          | 38 ++++++++++++++++++++++++++++++
 drivers/firmware/efi/arm-runtime.c | 27 ++++++++++-----------
 init/main.c                        |  3 +++
 5 files changed, 72 insertions(+), 30 deletions(-)

-- 
2.17.0

