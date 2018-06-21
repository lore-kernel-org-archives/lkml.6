Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46921C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3EC620883
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJXqdfa4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3EC620883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933162AbeFUNbZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 09:31:25 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:37142 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932755AbeFUNbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 09:31:22 -0400
Received: by mail-ot0-f196.google.com with SMTP id 101-v6so3571884oth.4;
        Thu, 21 Jun 2018 06:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to:cc;
        bh=g6+h3bsRvrld4Xt0Lxex0KMkIsWM1iBS/FqRYYLmxdA=;
        b=WJXqdfa4UMN0QQHRESD0Dbla9wbxJ+FKuXn+tJn2g+YDAyZ/XS3duwpG3xKH0kDjTc
         sziDkpnv3JZvBZZJScP3lHChfNf1Tl1Tb8YwQutpLHxIfCfcMVLSMcH/DN4/TOAcswtd
         vgndo39RA0on0ZcbAuS5dwW/IpAvziysjaRWkF1z8OyxZQZogsiEN1j9wfTyXpR2rEUw
         DkgO5A4srwOieLeU9sXYwWZArYZxAjbMocfbtMDkaLtBMSWPurqe4zxz46pBSCatQj8y
         +MNbSS7vIuUsQd1rkhk5h+Kaiha5pclR+SuFgHtYx4NpFKkt//a5MWGdjWycB9fR826R
         E2dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:cc;
        bh=g6+h3bsRvrld4Xt0Lxex0KMkIsWM1iBS/FqRYYLmxdA=;
        b=eC21LMNgh5wuQoBHi2H1KHNp8PKDth9g2fmEhzYJB6qgVWYZMp3YRLJ8cbQ0puM/So
         uQFKpc4bBR+cPeDvAoXde4ZIzfhQcGs8Mtpiq9N9xjpAPpud/KvLWfhFEqbMoLi727Cb
         TQbsxahq6qim4s1Ehzfat959bAItWH6lf+eBZM52v00CI2x0qLivEeMvr5prdQiXqcSO
         bdMUy3rpfu/i3FkG9M9wvNnpi9g1r3+SCENKG3m3QLUsfJTjDIe27QJB0+dBbUK4g5OE
         sI1vzMsro+lNr4AXGZlFNHNJxBYjb8ky3kD44Gkx76DsLFUif/XPgMjV0IIUxePnUISe
         NtKA==
X-Gm-Message-State: APt69E2Zm4SU5P0v2vy3p92svIs5IkjfhqpA1FZ5BSllBdQdFOiHC2lB
        P/J79YFlbrSTkoqfps1MSpBfPC8+M+H3j+XrKnI=
X-Google-Smtp-Source: ADUXVKIulhf/u+HHtm50cZz0icYduyQMZq3A6NPyMSDVYc+r62BVVS3Z00TEV/z2eSgUs+m9Zh2bjekOOu27eTk0igU=
X-Received: by 2002:a9d:1012:: with SMTP id h18-v6mr14815504ote.364.1529587877463;
 Thu, 21 Jun 2018 06:31:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1429:0:0:0:0:0 with HTTP; Thu, 21 Jun 2018 06:31:17
 -0700 (PDT)
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 21 Jun 2018 15:31:17 +0200
X-Google-Sender-Auth: WZPkkF0HW7j9y3vxgQmZRPhiibU
Message-ID: <CAJZ5v0iUU3WUZQ7NDR2dbxzOSGf3vrXr=7r5zQzSEwh1qokxgQ@mail.gmail.com>
Subject: [GIT PULL] ACPI fixes for v4.18-rc2
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
 acpi-4.18-rc2

with top-most commit e50f182c9094f95ecfd52a7f33e7e7320e85eb49

 Merge branches 'acpi-soc' and 'acpi-processor'

on top of commit ce397d215ccd07b8ae3f71db689aedb85d56ab40

 Linux 4.18-rc1

to receive ACPI fixes for 4.18-rc2.

These fix a suspend/resume regression in the ACPI driver for Intel
SoCs (LPSS), add a new system wakeup quirk to the ACPI EC driver and
fix an inline stub of a function in the ACPI processor driver that
diverged from the original.

Specifics:

 - Fix a suspend/resume regression in the ACPI driver for Intel SoCs
   (LPSS) to make it work on systems where some power management
   quirks should only be applied for runtime PM and suspend-to-idle
   and not for suspend-to-RAM (Rafael Wysocki).

 - Add a system wakeup quirk for Thinkpad X1 Carbon 6th to the ACPI
   EC driver to avoid drainig battery too fast while suspended to
   idle on those systems (Mika Westerberg).

 - Fix an inline stub of acpi_processor_ppc_has_changed() to match
   the original function definition (Brian Norris).

Thanks!


---------------

Brian Norris (1):
      ACPI / processor: Finish making acpi_processor_ppc_has_changed() void

Mika Westerberg (1):
      ACPI / EC: Use ec_no_wakeup on Thinkpad X1 Carbon 6th

Rafael J. Wysocki (1):
      ACPI / LPSS: Avoid PM quirks on suspend and resume from S3

---------------

 drivers/acpi/acpi_lpss.c | 18 +++++++++++-------
 drivers/acpi/ec.c        | 20 ++++++++++++++++++++
 include/acpi/processor.h |  3 +--
 3 files changed, 32 insertions(+), 9 deletions(-)
