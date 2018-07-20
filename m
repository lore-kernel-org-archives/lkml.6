Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A74FFECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 08:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 513AB206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 08:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sZc4dBqC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 513AB206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbeGTIuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 04:50:32 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33019 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727204AbeGTIuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 04:50:32 -0400
Received: by mail-oi0-f66.google.com with SMTP id l10-v6so19854858oii.0;
        Fri, 20 Jul 2018 01:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to:cc;
        bh=5HwqE1bsGfTQHm7LDHWtYHMlQnsHaPc7IrHaNTdv1JA=;
        b=sZc4dBqCdxSQ8ejE8DspMrBWPm+vtKLQ9lvX6kl5OM6IrJ2X8m5PL2ap50mM55bALO
         8Y9/w/c2+kEaWj0AtohMiM6gUrvQg/vqYpjAOi0HYD458R6IDvoFmP8y3XPJiQwF1cUF
         MZDS2E6NTP2nXRfPePd3JNJcvJAXD57GqXUW0pxLcm90JYgTVmbI6lYQDSmmqM8PKlKY
         Yjgmd+p81+CxKBbD86cVrK01l/1i00A0SNTNFSGx9aA34lbq0zwdGr/ZW67tOw4j5xV0
         n4fH4XxGg4iZ4/ZQi73Q6WOLt+/Dqvv4/7AsYpHkiw452PN9iceshQ6L+eyczNzVAdLh
         r9sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:cc;
        bh=5HwqE1bsGfTQHm7LDHWtYHMlQnsHaPc7IrHaNTdv1JA=;
        b=b7+R/Oj5LDvS3uvA3jdgVsHgtINLsa8AXXxi1tLkjPKWa3Tvz1iu0bce7kChSPZtNw
         eHRw2lscY3AVn6ta+cm8qJsddw7SFba83mXpshqbGs/FOQD/7lTAjIDGZwgIN5fzglcY
         14aS5i28++LWSG7hXRI1mYy5uHAqb463Ms/v4p1LT3tKahRqMBDE0Eo6Osbk3TcjTkfZ
         TNqJZAQgndvBYPiKjCg7pynaMy5A2fv2uphU1axSysDFLe2QCqK12Z5iha94/XD72oVF
         sZ4Zif+YJfeqr9yrREl4pCsQZ54DTIC3tHCKHFxvTNqrKYfpo1DhtfMW5oEJ2o7qKW+E
         9DwA==
X-Gm-Message-State: AOUpUlHPnVJmOSOc+UqweNnq470rLuYQxnAx+xGreDrZMk0rUryAdNDn
        tznUMD7AhBJSSW+XRLp/Lbbw2ti+BGa+nyNsSck=
X-Google-Smtp-Source: AAOMgpds+tRg/Qi6jKk/WksJ56g2Kvym/KLpTKLETES7w6za/9yNsVldP0y8X7k9mPE8t2agUsxn8MqSA5+UmQCUKxw=
X-Received: by 2002:aca:adc6:: with SMTP id w189-v6mr1085625oie.174.1532073808472;
 Fri, 20 Jul 2018 01:03:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Fri, 20 Jul 2018 01:03:28
 -0700 (PDT)
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 20 Jul 2018 10:03:28 +0200
X-Google-Sender-Auth: JF72ly2KZOzSNVpeDeDDCkQ4jUc
Message-ID: <CAJZ5v0ipKgfRfCmkRshrm9726=5rj5dUrKSLAK2GNEcdvnBMtw@mail.gmail.com>
Subject: [GIT PULL] Power management fix for v4.18-rc6
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
 pm-4.18-rc6

with top-most commit 95d6c0857e54b788982746071130d822a795026b

 cpufreq: intel_pstate: Register when ACPI PCCH is present

on top of commit 9d3cce1e8b8561fed5f383d22a4d6949db4eadbe

 Linux 4.18-rc5

to receive a power management fix for 4.18-rc6.

This fixes a relatively old initialization issue in intel_pstate
causing the pcc-cpufreq driver to be used instead of it on some HP
Proliant systems, which turned into a functional regression during
the 4.17 cycle, because pcc-cpufreq is a scalability disaster and
that was amplified by the idle loop rework done at that time (Rafael
Wysocki).

Thanks!


---------------

Rafael J. Wysocki (1):
      cpufreq: intel_pstate: Register when ACPI PCCH is present

---------------

 drivers/cpufreq/intel_pstate.c | 17 ++++++++++++++++-
 drivers/cpufreq/pcc-cpufreq.c  |  4 ++++
 2 files changed, 20 insertions(+), 1 deletion(-)
