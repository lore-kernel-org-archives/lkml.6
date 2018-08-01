Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ECF9C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38203208A2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bUUOxdiH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38203208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389333AbeHALsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 07:48:41 -0400
Received: from mail-oi0-f47.google.com ([209.85.218.47]:45764 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389055AbeHALsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 07:48:41 -0400
Received: by mail-oi0-f47.google.com with SMTP id q11-v6so33503101oic.12;
        Wed, 01 Aug 2018 03:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to:cc;
        bh=f3Ike5p1H1+NGjRJEyQBzCBGqe3tWNv5lj/c75+Sh+A=;
        b=bUUOxdiHE+Wl4oL3vxIW58A6zSUwomevgLNNrS5hrQWqojxC/+SYePgRAtDtwSzg7g
         ijc1AUsUal1T4ZhWcFMSLSvoY9EfzebXEFanTCY5T6j0/5MnNOvzC3fbix73OZTpy3qJ
         Juhkv1QfVN6jCWhdRSd5SrgNWSue1y0yVOfakrawntyjpd09Iqvq9jVnxqQgXEcg79Vd
         pm5VlWLCLqLh2tgHPoio0pyKXd97DpyTQlEvL/tPxDAZCPi8GxBqmM5tkHvTJ1s+cX7a
         kEenqb7epXgRi3AyfDpMULa7nLGwrKqI9zMoQq5lOajV74rTVOpH6aR35j0QfDxN1EGb
         DbcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:cc;
        bh=f3Ike5p1H1+NGjRJEyQBzCBGqe3tWNv5lj/c75+Sh+A=;
        b=sV1KE34GHX95F4coewtOJPgSseeaYuO8HbvO9f4PiIAaE8ygF8YLLgSvvifMN4C0Wz
         WBps5CCz0BntM36yYFE1F8skz1CxRLHnCmVZdCwQf+R082OwKSaXk0cHLTzVlOlXRrpI
         6n3HidWWnsp5+p881QDTsliq2gADkfKXuIiuOXCw/tYheORaFMVkQKNmnZmwrbaF0305
         LAVppgtLCzKSUdpFaLu4Jndd/TbC01nTSW9WaEYT7uNtr+uyUCw7SfVUddAYLXiOQOw9
         VlagHCQnkgX2+waNMxMiKgsJ1z9PBDVSewRXcZD8vrL3C69BckJ/vdH8/cP4GYMWaCXN
         JgDw==
X-Gm-Message-State: AOUpUlGIWZ5xzgDHiRQRD0ox/gb3gvSlhtnEfsyANZWOZC9pC9jmcdO8
        hDLB7GeRgBw0letB/mHNT2l+YPLDMrwb3Coc7WuiOVFN
X-Google-Smtp-Source: AAOMgpfp/WNgwEotXae9TPR9Y9Y/SOTbxbnztIg5I3BmHZu9qgT0OoL7kyfNCjnaOGXrhyi+6wIZE/Xwvy1uLivO7aI=
X-Received: by 2002:aca:ecd0:: with SMTP id k199-v6mr2988332oih.227.1533117822289;
 Wed, 01 Aug 2018 03:03:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Wed, 1 Aug 2018 03:03:41 -0700 (PDT)
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 1 Aug 2018 12:03:41 +0200
X-Google-Sender-Auth: Z5mzmcVWv3P_GCHM4bjVehcwBAk
Message-ID: <CAJZ5v0jHpO3werjy2f1RVuFSNCpJReSi3QzxDT1Vuz5fAGd_Ow@mail.gmail.com>
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

urgent power management fixes for final 4.18.

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
