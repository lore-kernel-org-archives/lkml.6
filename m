Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1764CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 20:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0C382250F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 20:16:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0C382250F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbeKOGU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 01:20:58 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45672 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725756AbeKOGU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 01:20:58 -0500
Received: by mail-ot1-f65.google.com with SMTP id 32so15397890ota.12;
        Wed, 14 Nov 2018 12:16:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=v4v56mZTf9/e7dYvXZZ+3+Q2k86oVKItDYfDMGSVIUM=;
        b=f3hWCky8fy7hbbW4jEvtrZc9ABKNTerMer3ek+S1dlBDJmk4AcH8GLzoehYC8+/M2s
         6hnykhgue64sJGjsZwy7V9QyXQ+Nnox7dsmMalk+wYZkMJwCxj6z+6vpWwCt+X6Z0XlU
         EW+uk4RnzHBGsN2whHRCLH3ooyuGL/ZYsdexFsB817sYweFveoYDeq0Qnq6ReTakj8PW
         kpGeNTgmIj4dSe+rSnCg87Hi3LgdJEQXOTgu+THrmXpRiA2Rx/tq9MTbkfZox/tXtkA6
         ppCAr24vZhBqySfxBJl+Jp0Wrz1YEn16353Nvt1tyUUfhoVfAQvwF4OQFOWj3UONEutI
         XIpA==
X-Gm-Message-State: AGRZ1gIBlLcsEtkWv2CjOujx3QxIWIQfUNxVlncOBq+1k1pHTg379WYq
        Rf9jjWunQ9eNAgCrPrX4nLy36oYMRtEs/XIkhCacsTXk
X-Google-Smtp-Source: AJdET5eIeV0h3oYnIsQiPHyJLLoim94jeRgiIsaDZdvKvLGScspMWGalY1MV2lTMS++/SezbWSNWit9vI0iOsYKw+ms=
X-Received: by 2002:a9d:588c:: with SMTP id x12mr2061778otg.139.1542226577467;
 Wed, 14 Nov 2018 12:16:17 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 14 Nov 2018 21:16:14 +0100
Message-ID: <CAJZ5v0jv7Bbkc4bsnu8xwjQWneRJedbdd3dNp98wEDdCYOpg9Q@mail.gmail.com>
Subject: [GIT PULL] Power management updates for v4.20-rc3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-4.20-rc3

with top-most commit 97dc6c03c1b0a9af7aa26da7b0b266a762451f5f

 Merge branch 'pm-cpuidle'

on top of commit 651022382c7f8da46cb4872a545ee1da6d097d2a

 Linux 4.20-rc1

to receive power management updates for 4.20-rc3.

These remove a stale DT entry left behind after recent removal of
a cpufreq driver without users, fix up error handling in the imx6q
cpufreq driver, fix two issues in the cpufreq documentation, and
update the ARM cpufreq driver.

Specifics:

 - Drop stale DT binding for the arm_big_little_dt driver removed
   recently (Sudeep Holla).

 - Fix up error handling in the imx6q cpufreq driver to make it
   report voltage scaling failures (Anson Huang).

 - Fix two issues in the cpufreq documentation (Viresh Kumar,
   Zhao Wei Liew).

 - Fix ARM cpuidle driver initialization regression from the 4.19
   time frame and rework the driver registration part of it to
   simplify code (Ulf Hansson).

Thanks!


---------------

Anson Huang (1):
      cpufreq: imx6q: add return value check for voltage scale

Sudeep Holla (1):
      dt-bindings: cpufreq: remove stale arm_big_little_dt entry

Ulf Hansson (2):
      ARM: cpuidle: Don't register the driver when back-end init returns -ENXIO
      ARM: cpuidle: Convert to use cpuidle_register|unregister()

Viresh Kumar (1):
      Documentation: cpu-freq: Frequencies aren't always sorted

Zhao Wei Liew (1):
      Documentation: cpufreq: Correct a typo

---------------

 Documentation/admin-guide/pm/cpufreq.rst           |  2 +-
 Documentation/cpu-freq/cpufreq-stats.txt           |  8 ++-
 .../bindings/cpufreq/arm_big_little_dt.txt         | 65 ----------------------
 drivers/cpufreq/imx6q-cpufreq.c                    |  7 ++-
 drivers/cpuidle/cpuidle-arm.c                      | 40 +++----------
 5 files changed, 19 insertions(+), 103 deletions(-)
