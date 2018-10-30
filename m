Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35BCC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 08:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CF6520848
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 08:30:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CF6520848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbeJ3RWy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 13:22:54 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43795 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbeJ3RWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 13:22:54 -0400
Received: by mail-oi1-f195.google.com with SMTP id j202-v6so9200894oih.10;
        Tue, 30 Oct 2018 01:30:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=YXzInOKjHk6G7PUWaFbv8IfErWTqzaEWR5ZyD49DTmQ=;
        b=iamz/gSDdWT/BFu4Qdgbe+RutkqoNQEq2UWa0oHiMPn9MfZto1V+a1qNWvPgW3RQer
         6mBevaUOwF4EJVUFqfDCSEBZ8JGmQd8h+qw1OpBIUsTUbRq66EWZEyTydtwK7zqmmvVP
         TWpFVNuQfWQSY8nJcq81MAaIw2huSbzDreSqRy1RlFA6fUhsOaNIwKfNu+9TiMylLafH
         ++hiBJs6xbYi6/nSa2d766WkE+M7/C0aECQl1qil8W4AoOy+dUB9brFMnEzebcT8ABeu
         QaP9XlnM9XNz8C6jce7K3JVIJGZLklPk7JC7JwbCjje63uT2mPHxzWJddy39pMlHjdxn
         K81g==
X-Gm-Message-State: AGRZ1gIvwbYS7jruHB06NwMP7gCR4dKaclcJgv5FplljMxt5qhJqwaY5
        PBg8ENllJfuUrw1a25Nur7yS6mgWBjMio10Fzmk=
X-Google-Smtp-Source: AJdET5dhqZ+P3lbHkwxByinCdZ/rot7HVJwL7F+Uc2wtSlS5HjsiKeHIvzJQbE3ROZoGUtKGgWkIWsfVdGfbT6twFNc=
X-Received: by 2002:aca:c2c3:: with SMTP id s186-v6mr11014755oif.193.1540888226307;
 Tue, 30 Oct 2018 01:30:26 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 30 Oct 2018 09:30:15 +0100
Message-ID: <CAJZ5v0ihPs+sU+s357sYNYBVmqd1CC2JH6_XvRsJQx1A_J7wJw@mail.gmail.com>
Subject: [GIT PULL] More ACPI updates for v4.20-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-4.20-rc1-2

with top-most commit 6a9b593d4b6f5994209456de7a3c2db0974b5dda

 ACPI / PMIC: xpower: Add depends on IOSF_MBI to Kconfig entry

on top of commit bd6bf7c10484f026505814b690104cdef27ed460

 Merge tag 'pci-v4.20-changes' of
git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci

to receive additional ACPI updates for 4.20-rc1.

These rework the handling of the P-unit semaphore on Intel
Baytrail and Cherrytrail systems to avoid race conditions and
excessive overhead related to it (Hans de Goede).

There was a merge conflict between this material and the i2c
tree (merged now) in linux-next that should be straightforward
to resolve [1].

Thanks!

[1] https://lore.kernel.org/lkml/20181029130925.60ea7830@canb.auug.org.au/


---------------

Hans de Goede (4):
      x86: baytrail/cherrytrail: Rework and move P-Unit PMIC bus semaphore code
      ACPI / PMIC: xpower: Block P-Unit I2C access during read-modify-write
      i2c: designware: Cleanup bus lock handling
      ACPI / PMIC: xpower: Add depends on IOSF_MBI to Kconfig entry

---------------

 arch/x86/include/asm/iosf_mbi.h              |  39 +++--
 arch/x86/platform/intel/iosf_mbi.c           | 217 ++++++++++++++++++++++++---
 drivers/acpi/Kconfig                         |   2 +-
 drivers/acpi/pmic/intel_pmic_xpower.c        |  21 ++-
 drivers/i2c/busses/i2c-designware-baytrail.c | 139 +----------------
 drivers/i2c/busses/i2c-designware-common.c   |   4 +-
 drivers/i2c/busses/i2c-designware-core.h     |   9 +-
 drivers/i2c/busses/i2c-designware-platdrv.c  |   2 -
 8 files changed, 250 insertions(+), 183 deletions(-)
