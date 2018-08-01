Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C61CC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19267208AF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VhzANF+D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19267208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389152AbeHALwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 07:52:44 -0400
Received: from mail-oi0-f41.google.com ([209.85.218.41]:35542 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730915AbeHALwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 07:52:44 -0400
Received: by mail-oi0-f41.google.com with SMTP id m11-v6so8337455oic.2;
        Wed, 01 Aug 2018 03:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to:cc;
        bh=cZKDLMSge7TFDqGZnz4QFu+eM58VTRKyJOQ5RLLXlnE=;
        b=VhzANF+DG0cY2AmSAlOPwq21iOUIcXcPq8EnuchTOssLKD/XgLPojp7dBmhgtBBVZ6
         LoKdDs9fAuxOKTUF3wD5exLBIiIdwcFiaipSgULhbETowN1//PehPySIdOY98+Asfxws
         R5W3NzoKqBvhkKQDnXc10lTu/bUfbPm73qROgMNX3HCrkU8utB1jTSvBNHDI+BvgB+jP
         oudrL+ph9mI/CjGxJGH2yyldmuU4l0v0YOS6/aJxVbTfzLtczNvf5+nXiJ6mTEqNlZJD
         pmZRijFq2JHdHD6NAIYZzPV68Q+ZAZW84LKlD041nnxXeCW/+oL2sfcYkensGBLgaAMz
         xVFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:cc;
        bh=cZKDLMSge7TFDqGZnz4QFu+eM58VTRKyJOQ5RLLXlnE=;
        b=pZjn+Cwa6oSzrC5J2PDX7v8IbteSR9Oc7dxsyYzqkJ3i9yLOtCjD8Lm+UhI2+Mz+P9
         KiVqn9zH9tl45r6wl8Pd+adgUtDLJj6GhoOyP9xmq2/XGz7tOkLLajk+gs5yyI9syC6y
         N9OzQzu28qCYzMOBp2L/e0nnhZ07XZG3UiMrqNDwAMHgdoYlW5dQPPrm5naMXtEFGbJS
         biE9aEHSuPodSSI96mEW64v77Z5qTBN47DJM/1tvbfqN3ZjvI71bHEtmi0Za6Ps1zQKh
         jJKRKhaZfI1+M0srKzWUUV0yQpCIduPFXMFCv9a41yP3iQAy2a5va+U1jwh3Wef9voWc
         //iQ==
X-Gm-Message-State: AOUpUlFeLhDU2PbUwYIIG2SviE6rVX4aElX/v3NSX3Bj+bgtPfQWLzTk
        A0XFeB/RpDfBnq6PmpxZDoF/u9++Ivg9K8ZRcnvnlf6N
X-Google-Smtp-Source: AAOMgpd8FvsdME7U+6MsTXMA2YikF+hJMmbTLvMENZXgJkUfGHfeb9beVck7A0/u6OaIU2Ep626OCZwyGSUFZ/Lfdlg=
X-Received: by 2002:aca:b841:: with SMTP id i62-v6mr2690939oif.358.1533118063737;
 Wed, 01 Aug 2018 03:07:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Wed, 1 Aug 2018 03:07:43 -0700 (PDT)
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 1 Aug 2018 12:07:43 +0200
X-Google-Sender-Auth: fzFCyHf7OL2XbDYElOSdvTF1mEo
Message-ID: <CAJZ5v0gZpLtLZUK87B7O0Zn_srvaHUYBSMD4gn7U4A6uNhxNcA@mail.gmail.com>
Subject: [GIT PULL] Urgent power management fixes for v4.18
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-urgent-4.18

with top-most commit 9b7c19e96cededec6b0435933adefbd56cad37ab

 Merge branch 'pm-tools'

on top of commit acb1872577b346bd15ab3a3f8dff780d6cca4b70

 Linux 4.18-rc7

to receive urgent power management fixes for final 4.18.

These fix the scope of a recent intel_pstate driver optimization
used incorrectly on some systems due to processor identification
ambiguity and fix a few issues in the turbostat utility, including
three recent regressions.

Specifics:

 - Use ACPI FADT preferred PM Profile to distinguish Skylake
   desktop processors from some server ones with the same model
   number in order to limit the scope of the recent IO-wait boost
   optimization to servers, as intended (Srinivas Pandruvada).

 - Fix several issues in the turbostat utility:
   * Fix the -S option on 1-CPU systems (Len Brown).
   * Fix computations using incorrect processor core counts (Artem
     Bityutskiy).
   * Fix the x2apic debug message (Len Brown).
   * Fix logical node enumeration to allow for non-sequential
     physical nodes (Prarit Bhargava).
   * Fix reported family on modern AMD processors (Calvin Walton).
   * Clarify the RAPL column information in the man page (Len Brown).

Thanks!


---------------

Artem Bityutskiy (1):
      tools/power turbostat: fix bogus summary values

Calvin Walton (1):
      tools/power turbostat: Read extended processor family from CPUID

Len Brown (4):
      tools/power turbostat: Update turbostat(8) RAPL throttling
column description
      tools/power turbostat: fix -S on UP systems
      tools/power turbostat: fix x2apic debug message output file
      tools/power turbostat: version 18.07.27

Prarit Bhargava (1):
      tools/power turbostat: Fix logical node enumeration to allow for
non-sequential physical nodes

Srinivas Pandruvada (1):
      cpufreq: intel_pstate: Limit the scope of HWP dynamic boost platforms

---------------

 drivers/cpufreq/intel_pstate.c        |  17 ++++-
 tools/power/x86/turbostat/turbostat.8 |   4 +-
 tools/power/x86/turbostat/turbostat.c | 120 ++++++++++++++++------------------
 3 files changed, 74 insertions(+), 67 deletions(-)
