Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67BC5C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F97020883
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XijjV6qT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F97020883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933129AbeFUN34 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 09:29:56 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36816 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932755AbeFUN3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 09:29:55 -0400
Received: by mail-oi0-f66.google.com with SMTP id 14-v6so2922427oie.3;
        Thu, 21 Jun 2018 06:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to:cc;
        bh=NFo8zH4K7GSWbklXhGZXDb/o7J3SAfaUXr4dqDDEtCI=;
        b=XijjV6qTzYbN6grrRC2CMx0xwyN2ty83BBtTOSCQXI0A02yD+TIc9pWFlSRUAUFftG
         goME8UuIvk7Nw4sPXMvQslxAbyYce1KrZwbeW/rsd4KxVngxThY170kDD+qlc3QoIZFI
         OYhbmpKSUFZjjsauAppTTKfboypOPAsrdpkaq0/HWl92v75RNNB4ktWenYEQKIdAUhJT
         Mgj0Dlgd2Ws9OeKiUQh8M6ka+ayiTz03smkJAxSWfRCU6GYPuOL8qZYgADjNcRd7Akch
         oS0rOHF6MRxPHuUzXUGw4OUKetV67q1yJlR0rqKgZWd3xYvgu/vJxv65lIfqWpgFKD3E
         DF5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:cc;
        bh=NFo8zH4K7GSWbklXhGZXDb/o7J3SAfaUXr4dqDDEtCI=;
        b=HcixVaXydrE8UVbggYvI4z8h+foGY7d5vBO1IsqEbsyuskyXk16KHES+7J5tHujsCV
         rlbS0/KZhK3j20z3mCn4Z/fqX4WOQtkn387OifigQgmkNq9oBxSkbY3s+5mtfwNsKWcv
         2ORGmtI1+QEfWhi8rWScKoSdyHxmHQvG6M6qLhh0tWy6eJzfgkHIBG+6TVZu2YKFirVK
         USWkSmqotLOykQcL0YWZ/lqy3A5CulaifV00HycpornzPPOi7PEsnyo73vj5m9rTiN6o
         CdiCH4Pg2kz83m4k0t8gYr6sA8gnfj52tejqumrkxoNvZuJtB/cs+Dz/obWYZ1tW8eZL
         MoAw==
X-Gm-Message-State: APt69E02k0U08UIuE7RlVo4621b2oA1+o3rnZYYb4VAQHn3GWheN/FFY
        lLUxGjczR9bdKZ65PZtK88MRAWwee1dahF+9NL57Cw==
X-Google-Smtp-Source: ADUXVKIgCkBelpYWFPw7kMi+3ciANsDD6r8TNS0R69PSrSz1yTDjoCc9/r0REwlHieD5KoEj+QxMPVe8wG2EyKTjXoQ=
X-Received: by 2002:aca:e143:: with SMTP id y64-v6mr13633445oig.282.1529587794442;
 Thu, 21 Jun 2018 06:29:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1429:0:0:0:0:0 with HTTP; Thu, 21 Jun 2018 06:29:54
 -0700 (PDT)
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 21 Jun 2018 15:29:54 +0200
X-Google-Sender-Auth: Xurlsfv-PrgCbSgamXFuri3amWQ
Message-ID: <CAJZ5v0jL0rDAD+Urc-tD76embqNABWHkShAeiE0ErSJvNWzbgQ@mail.gmail.com>
Subject: [GIT PULL] Power management changes for v4.18-rc2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-4.18-rc2

with top-most commit b51e001385f1c861445af3efeab766811ee8db29

 Merge branch 'pm-tools'

on top of commit ce397d215ccd07b8ae3f71db689aedb85d56ab40

 Linux 4.18-rc1

to receive power management changes for 4.18-rc2.

These are mostly fixes, including some fixes for changes made
during the recent merge window and some "stable" material, plus
some minor extensions of the turbostat utility.

Specifics:

 - Fix the PM core to avoid introducing a runtime PM usage counter
   imbalance when adding device links during driver probe (Rafael
   Wysocki).

 - Fix the operating performance points (OPP) framework to ensure
   that the regulator voltage is always updated as appropriate when
   updating clock rates (Waldemar Rymarkiewicz).

 - Fix the intel_pstate driver to use correct max/min limits for
   cores with differing maximum frequences (Srinivas Pandruvada).

 - Fix a typo in the intel_pstate driver documentation (Rafael
   Wysocki).

 - Fix two issues with the recently added Kryo cpufreq driver (Ilia
   Lin).

 - Fix two recent regressions and some other minor issues in the
   turbostat utility and extend it to provide some more diagnostic
   information (Len Brown, Nathan Ciobanu).

Thanks!


---------------

Ilia Lin (2):
      cpufreq: kryo: Fix possible error code dereference
      cpufreq: kryo: Add module remove and exit

Len Brown (4):
      tools/power turbostat: fix show/hide issues resulting from mis-merge
      tools/power turbostat: decode cpuid.1.HT
      tools/power turbostat: add optional APIC X2APIC columns
      tools/power turbostat: version 18.06.20

Nathan Ciobanu (4):
      tools/power turbostat: fix segfault on 'no node' machines
      tools/power turbostat: alphabetize the help output
      tools/power turbostat: add single character tokens to help
      tools/power turbostat: add the missing command line switches

Rafael J. Wysocki (2):
      PM / core: Fix supplier device runtime PM usage counter imbalance
      Documentation: intel_pstate: Fix typo

Srinivas Pandruvada (1):
      cpufreq: intel_pstate: Fix scaling max/min limits with Turbo 3.0

Waldemar Rymarkiewicz (1):
      PM / OPP: Update voltage in case freq == old_freq

---------------

 Documentation/admin-guide/pm/intel_pstate.rst |   2 +-
 drivers/base/core.c                           |  15 +-
 drivers/cpufreq/intel_pstate.c                |  27 ++-
 drivers/cpufreq/qcom-cpufreq-kryo.c           |  25 ++-
 drivers/opp/core.c                            |   2 +-
 tools/power/x86/turbostat/turbostat.8         |   2 +-
 tools/power/x86/turbostat/turbostat.c         | 240 ++++++++++++++++++--------
 7 files changed, 224 insertions(+), 89 deletions(-)
