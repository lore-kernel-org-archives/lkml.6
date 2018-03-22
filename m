Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751797AbeCVXFX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 19:05:23 -0400
Received: from mail-ot0-f181.google.com ([74.125.82.181]:46823 "EHLO
        mail-ot0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751531AbeCVXFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 19:05:21 -0400
X-Google-Smtp-Source: AG47ELvcTEJYTQnZYhr+0ZbQNnR/0tO5wGPxSBE3ZWt3+Godx/mdi0poqDy0g0WhLxNo0yRkUoL4x5JvMb8CgYg9anQ=
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 23 Mar 2018 00:05:20 +0100
X-Google-Sender-Auth: Cva9Q2sLpzndlmjvObbXXtXeTYE
Message-ID: <CAJZ5v0gT_p44NGUhkw7irDk-Uo8HnEYQ35+wJaBUo3ziLSbPsQ@mail.gmail.com>
Subject: [GIT PULL] ACPI fixes for v4.16-rc7
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-4.16-rc4

with top-most commit 594fdbaab739f82b3a712b88beb483ca1ca250ee

 Merge branch 'acpi-wdat'

on top of commit c698ca5278934c0ae32297a8725ced2e27585d7f

 Linux 4.16-rc6

to receive ACPI fixes for 4.16-rc7.

These revert one recent commit that added incorrect battery quirks
for some Asus systems and fix an off-by-one error in the watchdog
driver based on the ACPI WDAT table.

Specifics:

 - Revert the recent change adding battery quirks for Asus GL502VSK
   and UX305LA as these quirks turn out to be inadequate and possibly
   premature (Daniel Drake).

 - Fix an off-by-one error in the resource allocation part of the
   watchdog driver based on the ACPI WDAT table (Takashi Iwai).

Thanks!


---------------

Daniel Drake (1):
      Revert "ACPI / battery: Add quirk for Asus GL502VSK and UX305LA"

Takashi Iwai (1):
      ACPI / watchdog: Fix off-by-one error at resource assignment

---------------

 drivers/acpi/acpi_watchdog.c |  4 ++--
 drivers/acpi/battery.c       | 48 +++-----------------------------------------
 drivers/watchdog/wdat_wdt.c  |  2 +-
 3 files changed, 6 insertions(+), 48 deletions(-)
