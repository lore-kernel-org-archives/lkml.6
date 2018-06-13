Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C562EC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 11:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7967720891
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 11:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="csfBCJaE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7967720891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935294AbeFMLDm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 07:03:42 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:42064 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934677AbeFMLDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 07:03:40 -0400
Received: by mail-oi0-f67.google.com with SMTP id k190-v6so1897700oib.9;
        Wed, 13 Jun 2018 04:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to:cc;
        bh=oQEIW/hBZS2rqVmgLQAyPMTLnF7Gj05ty9M9HwkB/0A=;
        b=csfBCJaEwC0sL6QCP8SUmDTGyESb1uQl+AEXXFbIrbWIdohA/Lh7QRNkgw4CY1iN8B
         4rnxmmAF7kctMn7GpRutnpCyjUdNM2L/hCqzylzGuML63hy7RTZja+BCIQ8K1bQQlXHq
         oOoWw6hyb5Qv+I71ubVTdo6Tx37+PBcvrZ7O1jiiP0wtVvmRc+PIfaYSDvZuN7f6onG8
         aWlo35qxizdxqWaKgeZj36iqjysUJc1yBeTrmWzTJn1Pd1pbIgb5Dpjft+xeKWOc+FI4
         otCOzzQ3XAizvTgMwDnDR1Phvsv0TpSGS+jaVB9eDoePLPq77ezWOMHP8ShAZ0BrLy2S
         2J3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:cc;
        bh=oQEIW/hBZS2rqVmgLQAyPMTLnF7Gj05ty9M9HwkB/0A=;
        b=EyrtIFIChsmbqV7Ks8rzzxUl8449uyB94Tf1NU8HLV4FRVKVBXLtdcKnxQ0IQDZPgx
         nKDcOAWumFivdU+tQcT9IhJEXVHI6ZpyB3RVRO37YbuDqLW0TlxFgeQne094+MG1QkB4
         TkJtN/ov0xehgbQi7J2+G1mNltjoL/VNHEI1XhStt0/Skz6OIvAIONIl0b/BCiSKibbB
         VBD3wdC5Zx23eTSvV3lEokepk1xFF6dbt+pRduY/v5NLp1/ghwGEC9ZoWF7GaqOoUSEv
         N8RUGRf3zwRX+/A6ZThT3TIeQ9VyUQOyfwfqKO6U3kKLgIK6NVafQ2z7eFP/DcAcwpXM
         AwlA==
X-Gm-Message-State: APt69E23Y07tmJ4kpwIQK7t72Xk4r4wVUqsfUMsWpfKTpfPlND+Oe+V6
        7RuJ34ze/cLLBx6fw888EqJTy5kAMCC70lzRt2r2AA==
X-Google-Smtp-Source: ADUXVKIsPQp4D/VN1+Xm0Ooj5YRETOW3M5RP3G/5zXo+8/O52+4FhVrvGeu2NRRr9ekBXVU2e/SaznO57O6mb8kbmAM=
X-Received: by 2002:aca:5bc6:: with SMTP id p189-v6mr4338984oib.116.1528887819858;
 Wed, 13 Jun 2018 04:03:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1429:0:0:0:0:0 with HTTP; Wed, 13 Jun 2018 04:03:39
 -0700 (PDT)
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 13 Jun 2018 13:03:39 +0200
X-Google-Sender-Auth: qUDp8dRIliC90GAnitW1qu74gw0
Message-ID: <CAJZ5v0gp-g2EW1QXagwDQvmt55C14N6s+7or-8c7LebB2FK5LA@mail.gmail.com>
Subject: [GIT PULL] More ACPI updates for v4.18-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-4.18-rc1-2

with top-most commit 674455326ee397bc8334920533f71090b61fa594

 Merge branch 'acpica'

on top of commit f4fe74cc909bf811cd9cc7fd84f5a7514e06a7e1

 Merge tag 'acpi-4.18-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive additional ACPI updates for 4.18-rc1.

These update the ACPICA code in the kernel to upstream revision
20180531 including one important AML parser fix and updates
related to the IORT table, make the kernel recognize the
"Windows 2017.2" _OSI string and update the customized methods
documentation.

Specifics:

 - Update the ACPICA code in the kernel to upstream revision
   20180531 including:
   * AML parser fix to continue loading tables after detecting an AML
     error (Erik Schmauss).
   * AML parser debug option to dump parse trees (Bob Moore).
   * Debugger updates (Bob Moore).
   * Initial bits of Unload () operator deprecation (Bob Moore).
   * Updates related to the IORT table (Robin Murphy).

 - Make Linux respond to the "Windows 2017.2" _OSI string which
   allows native Thunderbolt enumeration to be used on Dell systems
   and was unsafe before recent changes in the PCI subsystem (Mario
   Limonciello).

 - Update the ACPI method customization feature documentation (Erik
   Schmauss).

Thanks!


---------------

Bob Moore (5):
      ACPICA: Debugger: Add count of namespace nodes after namespace dump
      ACPICA: AML Parser: Add debug option to dump parse trees
      ACPICA: Debugger: Reduce verbosity for module-level code errors.
      ACPICA: Interpreter: Begin deprecation of Unload operator
      ACPICA: Update version to 20180531

Erik Schmauss (2):
      ACPI / Documentation: update ACPI customize method feature docs
      ACPICA: AML parser: attempt to continue loading table after error

Mario Limonciello (1):
      ACPICA: Recognize the _OSI string "Windows 2017.2"

Robin Murphy (2):
      ACPICA: IORT: Update for revision D
      ACPICA: IORT: Add PMCG node supprt

---------------

 Documentation/acpi/method-customizing.txt | 10 +++---
 drivers/acpi/acpica/dbnames.c             |  1 +
 drivers/acpi/acpica/dbobject.c            | 23 +++++++++++++-
 drivers/acpi/acpica/dsdebug.c             | 12 ++++++--
 drivers/acpi/acpica/exconfig.c            | 11 +++++++
 drivers/acpi/acpica/nsdump.c              |  3 ++
 drivers/acpi/acpica/psloop.c              | 51 ++++++++++++++++++++++++++++++-
 drivers/acpi/acpica/psobject.c            | 30 ++++++++++++++++++
 drivers/acpi/acpica/pswalk.c              | 34 +++++++++++++++++++--
 drivers/acpi/acpica/uterror.c             | 10 +++---
 drivers/acpi/acpica/utosi.c               |  1 +
 include/acpi/acoutput.h                   |  4 ++-
 include/acpi/acpixf.h                     |  2 +-
 include/acpi/actbl2.h                     | 25 +++++++++++----
 include/acpi/actypes.h                    |  1 +
 15 files changed, 192 insertions(+), 26 deletions(-)
