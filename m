Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D88C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 09:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EB7E2077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 09:42:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EB7E2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728577AbeIGOWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 10:22:19 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:46570 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbeIGOWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 10:22:19 -0400
Received: by mail-oi0-f68.google.com with SMTP id y207-v6so26067654oie.13;
        Fri, 07 Sep 2018 02:42:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=fnyBE9UFg2eo9UWUtPur5FU+0bPzBG07w/Mmstp4838=;
        b=sV1hRQh/28fXm50TiPD0dK2Y4U8fQ4vP+eHQg9axh93Jb07qak5/MKVup9P2f8wIsM
         zreu1WsptZpa+6xjCVEkQ4hXbm+30SIs3Zn8LouBQ5sBQVA5MOVknP7s+JPnaAzEDKsl
         o366ZciA6RRnzR9SlRw6V6575hhlGmPX5I7VWPUchKBmGZx0aMZRziPIMJMEptLWWtD/
         PvnuSr9jnV6+h24OVrC+rEkG0mDjQNL9FshVjEm+apwi0TvhOGvd6SompVEBz8CYwDrH
         C2jU4q31aiKMZyZugaZt4CZWAFq8wWQrylEIK+0FUPewc04L1HoKtqbhfhO2jiPQW38w
         A/OQ==
X-Gm-Message-State: APzg51DE3T6tEoiOCc9yZf4+5ErZoEZncae6HToWFFsga8H90WOCF3jv
        c4uyp2yHgdKNgSzxGMMjxtB5dd3ExXwquDkr0kcAdGf0
X-Google-Smtp-Source: ANB0VdbjwihN8ABbw6FEcDNJsVme6ECXj1TMXba21VYQBqQnxCHd/19vJnvJ1L1yYnDPql26SCSwije56gGqOypimYc=
X-Received: by 2002:aca:d098:: with SMTP id j24-v6mr7422367oiy.72.1536313331970;
 Fri, 07 Sep 2018 02:42:11 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 7 Sep 2018 11:42:00 +0200
Message-ID: <CAJZ5v0ic2OFieyNQ7Ka6YhNZSZshVK3cEjCSwbOMOdbd_P+ZkA@mail.gmail.com>
Subject: [GIT PULL] ACPI fixes for v4.19-rc3
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
 acpi-4.19-rc3

with top-most commit a6b7eb3b4176d9732d74d214b349932faa5524b4

 Merge branch 'acpi-bus'

on top of commit 57361846b52bc686112da6ca5368d11210796804

 Linux 4.19-rc2

to receive two ACPI fixes for 4.19-rc3.

These fix a regression from the 4.18 cycle in the ACPI driver
for Intel SoCs (LPSS) and prevent dmi_check_system() from being
called on non-x86 systems in the ACPI core.

Specifics:

 - Fix a power management regression in the ACPI driver for Intel
   SoCs (LPSS) introduced by a system-wide suspend/resume fix during
   the 4.18 cycle (Zhang Rui).

 - Prevent dmi_check_system() from being called on non-x86 systems in
   the ACPI core (Jean Delvare).

Thanks!


---------------

Jean Delvare (1):
      ACPI / bus: Only call dmi_check_system() on X86

Zhang Rui (1):
      ACPI / LPSS: Force LPSS quirks on boot

---------------

 drivers/acpi/acpi_lpss.c |  2 +-
 drivers/acpi/bus.c       | 13 +++++++------
 2 files changed, 8 insertions(+), 7 deletions(-)
