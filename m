Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E80C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80C76240E4
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ne73iqZh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80C76240E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753910AbeGELci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 07:32:38 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:38248 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753660AbeGELcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 07:32:36 -0400
Received: by mail-oi0-f68.google.com with SMTP id v8-v6so16195142oie.5;
        Thu, 05 Jul 2018 04:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to:cc;
        bh=L7893Hp6FRDjpPXhT4VhsTipRtni6HXjr9pmWqtuUfI=;
        b=ne73iqZhfXrEkWKxraurxz2t+WbM9ANbufr+9SoSwffBVt2rmO0GH0Y+X6Qlxe5oWT
         MrY4rru5FmnhIyejA8baIeWPpZCZ3q71COzLBtEE+Q+RxtbpeDi4Nv5kYoNddK7OgPMY
         o/yzTglsolOgaHbLCwygCDdT/WoRtPBeTamkqom7TrSs2hhrxb6i/5TGeC0cyM0KWPnE
         cJWW+Dfb938CCzcZo5xYGtmvLwaSrexdMtpITL/TqrDYs1Lj70EPcIS6W+b8r5ud7thi
         lq1Y8OnG8w5RARgx1PKmuU4WqOOcgSi6dcln6O8fibN6ZpefrCYIsoPc+y6n/tDRINoH
         lN6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:cc;
        bh=L7893Hp6FRDjpPXhT4VhsTipRtni6HXjr9pmWqtuUfI=;
        b=LizTDjOs/5j5iLOjV28obcgfuensoGqv8KvnGgYnvOV8aGaJR26Y4EI2uj9cZwqxyf
         ffNS7clam7wwJ6jUpqKC7yZMie5KWR5pBcNxfjmEx+BHbvogRTBPis1WD8jXKIa60Fue
         tKUsoN3HzXemdtdTPpAZRlNbduxV+ZGURS0CYlLM64Ny4oiIZvDYuuGVbuttWFxOuf5n
         Skm1VTrE96yioOBPEnPdhqhqPWyvRwCJB79zdk6Dfg+Fy85siIO41PvxAfHKFwzyhJyO
         VbdOUBYxqPE9Dcdu3iTlXGsCuFc5eHkHXbdyRqdumxFZmbXAot3CgUYNX61Upf5eh4ZP
         QCfQ==
X-Gm-Message-State: APt69E0YxJb5RUoWSPMIF9gH9JA9149aeUsB/Y7zx5qycdpQ4+jwKUgF
        ep0voNw8dUgY+5A2BN49xGr4yQbZmXh/VqY+2T0=
X-Google-Smtp-Source: AAOMgpdwz89dBQt5MZizxCgVa/5LHV88uLxDTPlMDZMocmJtW6LmHlJPlbPP5FDCaai6xois1l97f7PD98+baG4SMdg=
X-Received: by 2002:aca:adc6:: with SMTP id w189-v6mr6549782oie.174.1530790355910;
 Thu, 05 Jul 2018 04:32:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Thu, 5 Jul 2018 04:32:35 -0700 (PDT)
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 5 Jul 2018 13:32:35 +0200
X-Google-Sender-Auth: QutC7VZSfEzdVG1NLBBR0cOjzIY
Message-ID: <CAJZ5v0jT8iYaPLmrHWshDppHhZr3sqhrtFeTVzD6S=dvTdZ+CA@mail.gmail.com>
Subject: [GIT PULL] ACPI fixes for v4.18-rc4
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
 acpi-4.18-rc4

with top-most commit df958569dbaa398f525057729717e44809ac4306

 Merge branches 'acpi-tables' and 'acpica'

on top of commit 021c91791a5e7e85c567452f1be3e4c2c6cb6063

 Linux 4.18-rc3

to receive ACPI fixes for 4.18-rc4.

These fix a recent ACPICA regression, fix a battery driver regression
introduced during the 4.17 cycle and fix up the recently added
support for the PPTT ACPI table.

Specifics:

 - Revert part of a recent ACPICA regression fix that added leading
   newlines to ACPICA error messages and made the kernel log look
   broken (Rafael Wysocki).

 - Fix an ACPI battery driver regression introduced during the 4.17
   cycle due to incorrect error handling that made Thinkpad 13
   laptops crash on boot (Jouke Witteveen).

 - Fix up the recently added PPTT ACPI table support by covering
   the case when a PPTT structure represents a processors group
   correctly (Sudeep Holla).

Thanks!


---------------

Jouke Witteveen (1):
      ACPI / battery: Safe unregistering of hooks

Rafael J. Wysocki (1):
      ACPICA: Drop leading newlines from error messages

Sudeep Holla (1):
      ACPI / PPTT: use ACPI ID whenever ACPI_PPTT_ACPI_PROCESSOR_ID_VALID is set

---------------

 drivers/acpi/acpica/uterror.c |  6 +++---
 drivers/acpi/battery.c        |  9 +++++----
 drivers/acpi/pptt.c           | 10 ++++++++--
 3 files changed, 16 insertions(+), 9 deletions(-)
