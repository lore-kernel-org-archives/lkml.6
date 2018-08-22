Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690F3C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2890020BEC
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:41:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2890020BEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbeHVNFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 09:05:43 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:43620 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728462AbeHVNFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 09:05:43 -0400
Received: by mail-oi0-f68.google.com with SMTP id b15-v6so2087593oib.10;
        Wed, 22 Aug 2018 02:41:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=0SLZ7YQ1IsMzNBfqYEKVbawCwQOjcL69Ad2WyMCXXHs=;
        b=K1qyRphRXCyrnTxjHCXIFDW563cpbjRgG71y11C41IuZWthg+9M9qMe/uwx+E6JuEj
         RhKHyp9nJOzXqo9eoBPel1TGRGNLAqAhN6nq9atn9T0PSkJs03yW12XNEm09/akOVIx+
         tjJ0vY4u9vBeEemVT24rGsuJBBiY8w4vgt4riMcowTMjoJOeg5q9u3jNw7bpHeH0zojc
         +vqKmFZqkTrqTaNl/LZskTI4a36+ApKz5RfNxinQ08lPRd9m983VlByDJGxQwX6sLriF
         9irZvDZTY+Q1ij9OUr2JATBe1/QXUDHeoEF1PF2WQb0I3NZvNJpVd3dLdPb60wN2MPTl
         Ip/Q==
X-Gm-Message-State: APzg51AkVv5awr3nXrjH5xLxWFwr8lxnFuLx4yDYnzqx2HoIGr5wSvG1
        W7viWxw/Cy6r4LRKK7I5HlFzFadnUVtOhUfcEjI=
X-Google-Smtp-Source: ANB0VdaiH7xuB0sdBIDlfpQnI3Dl6VSMdOmS3Co70Qt22zuxy/T45KXxmx6S8/kZPjr+dz82+kMQUL7xh5pfhUvDwXM=
X-Received: by 2002:aca:1719:: with SMTP id j25-v6mr3231580oii.138.1534930895653;
 Wed, 22 Aug 2018 02:41:35 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 22 Aug 2018 11:41:24 +0200
Message-ID: <CAJZ5v0gJYBtH2P3oS-hGxk0p1Vy6jcv-ZzggoDS3PSS+S9k_ng@mail.gmail.com>
Subject: [GIT PULL] More ACPI updates for v4.19-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-4.19-rc1-2

with top-most commit d1f3ab5b13c03b6f32d5379cd3cd5c7e50ce612c

 Merge branch 'acpi-pmic'

on top of commit 2c20443ec221dcb76484b30933593e8ecd836bbd

 Merge tag 'acpi-4.19-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive more ACPI updates for 4.19-rc1.

These update the ACPICA code in the kernel to the most recent
upstream revision (which includes a regression fix and other
improvements), make ACPICA clear the status of all ACPI events
when entering sleep states (to restore the previous behavior)
and update the ACPI operation region driver for the CrystalCove
PMIC.

Specifics:

 - Update the ACPICA code in the kernel to upstream revision 20180810
   including:
   * Fix for AML parser regression causing it to mishandle opcodes
     that open a scope upon parse failures (Erik Schmauss).
   * Fix for a reference counting issue on large systems (Erik
     Schmauss).
   * Fix to discard values coming from register reads that have
     failed (Erik Schmauss).
   * Two acpiexec fixes (Bob Moore, Erik Schmauss).
   * Debugger cleanup (Bob Moore).
   * Cleanup of duplicate table error message (Bob Moore).
   * Cleanup of hex detection in the utilities (Erik Schmauss).

 - Make ACPICA clear the status of all ACPI events when entering
   sleep states again to avoid functional regressions (Rafael Wysocki).

 - Update the ACPI operation region driver for the CrystalCove PMIC
   to cover all of the known operation region fields (Hans de Goede).

Thanks!


---------------

Bob Moore (4):
      ACPICA: Update an error message for a duplicate table
      ACPICA: Debugger: Cleanup interface to the AML disassembler
      ACPICA: acpiexec: fix a small memory leak regression
      ACPICA: Update version to 20180810

Erik Schmauss (7):
      ACPICA: AML Parser: ignore all exceptions resulting from
incorrect AML during table load
      ACPICA: ACPICA: add status check for acpi_hw_read before
assigning return value
      ACPICA: Utilities: split hex detection into smaller functions
      ACPICA: AML Parser: skip opcodes that open a scope upon parse failure
      ACPICA: acpi_exec: fixing -fi option
      ACPICA: Reference count: add additional debugging details
      ACPICA: Reference Counts: increase max to 0x4000 for large servers

Hans de Goede (1):
      ACPI / PMIC: CrystalCove: Extend PMOP support to support all
possible fields

Rafael J. Wysocki (1):
      ACPICA: Clear status of all events when entering sleep states

---------------

 drivers/acpi/acpica/aclocal.h      |   1 +
 drivers/acpi/acpica/acnamesp.h     |  17 +++---
 drivers/acpi/acpica/acutils.h      |   2 +
 drivers/acpi/acpica/dbinput.c      |  10 ++++
 drivers/acpi/acpica/dbmethod.c     |   8 +--
 drivers/acpi/acpica/dbxface.c      |  10 +++-
 drivers/acpi/acpica/dsfield.c      |  34 +++++++++++-
 drivers/acpi/acpica/hwregs.c       |   9 ++-
 drivers/acpi/acpica/hwsleep.c      |  11 +---
 drivers/acpi/acpica/nsaccess.c     |  13 +++++
 drivers/acpi/acpica/psloop.c       |  43 ++++++++-------
 drivers/acpi/acpica/tbdata.c       |   4 +-
 drivers/acpi/acpica/utdelete.c     |   7 ++-
 drivers/acpi/acpica/utstrsuppt.c   |  26 ++++++++-
 drivers/acpi/acpica/utstrtoul64.c  |   2 +-
 drivers/acpi/pmic/intel_pmic_crc.c | 109 ++++++++++++++++++++++++++++++++++++-
 include/acpi/acconfig.h            |   2 +-
 include/acpi/acexcep.h             |   6 ++
 include/acpi/acpixf.h              |   2 +-
 19 files changed, 260 insertions(+), 56 deletions(-)
