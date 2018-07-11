Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122B1C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF2772083B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/fvslwf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF2772083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732591AbeGKJlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 05:41:25 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:43235 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbeGKJlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 05:41:25 -0400
Received: by mail-oi0-f65.google.com with SMTP id b15-v6so48030055oib.10;
        Wed, 11 Jul 2018 02:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to:cc;
        bh=J20nVvKfKi8CaHcq01sqaVgmfWyS1w7cq2vex7k3zdU=;
        b=P/fvslwfuEnnHP4lBC71YcgNU+aDPAN2Tr+Txfsui4BJKsD/luCeNVeEkyz3WLDXJm
         9NFq3txFF84k7PJf/5Hw1zp/QD8LNkBW2ag8ilJbKbAmP5Z4vMQSoZI6obXO081haJqM
         ZTFCj8R/f/8RS++UNxnLAq8hz4xqruoUuiXPLj4w59/4acld5u0BY3ERdXsln3dxJmuw
         Cf0o+k3SkrWPHhorBezfCU42maBsq/ljYV0IPds2lI+dQBdAJcmKSY5RcsYLu70Ok31R
         vpqSs7xp8b0tmji8H55Z4QqnCOF2m7F10DMTYvwW0a+A/Ai8627Gwt/crHQBP4mCVvEC
         49IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:cc;
        bh=J20nVvKfKi8CaHcq01sqaVgmfWyS1w7cq2vex7k3zdU=;
        b=dGebPMzRXs+T6APS/cqITUvq5dRiTYOL+gZGV4LDh0ciO1ine0RxIsvhRS7J2kRWti
         +xoRQU6wEoUuOxgXn5wQxLfnNDRCsEjXB7tD6dUNmeo6Bp+kTxJRUkKzQOHvvpGipp4Z
         0qSDw6Ga++jwU26A2168Lb97QLSgIqqGw+vWJYzoG4z9qK5c8FvAE6qXIGt0brGiTytn
         X5RXDtQ3Fm1cpyG9HqXFoiitnW7lZSSWuZvmxq099MWmsM82qahSfPWA6DkA738tcsDR
         ODQVsI+eie7fj4z66jkjRCwc4LoUq+/cC9MbMaxZCw9/SLHYAr6Mf/+pwbDpjvDdWRRw
         oRTA==
X-Gm-Message-State: APt69E1c0YcgypmsnlM4apHOh7TSM8K4qW33V610XRiXokYXwzqlkAdX
        H7gsZP5rQdDL9yfeDOvNfg3+uOA6HABS+y4/GBaU2w==
X-Google-Smtp-Source: AAOMgpeYYgLg4W4l94AhzedxeozqQ50vLD6FJ2OFgs0y/bdS02nQW7GBSTND0mVfgAs+NOoE2wgJ6hIuMoIuBeCUAMw=
X-Received: by 2002:aca:adc6:: with SMTP id w189-v6mr32811558oie.174.1531301878934;
 Wed, 11 Jul 2018 02:37:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Wed, 11 Jul 2018 02:37:58
 -0700 (PDT)
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 11 Jul 2018 11:37:58 +0200
X-Google-Sender-Auth: bkzTlQn-fSJLVHudx8XKes2wroQ
Message-ID: <CAJZ5v0g6TncQk+GZJ1UTYHkyvOphdn=_B5kwL1nbMU6GaE6nCw@mail.gmail.com>
Subject: [GIT PULL] ACPI fix for v4.18-rc5
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
 acpi-4.18-rc5

with top-most commit fa85015c0d95884c8dc42f38e2f2d6137d436b67

 ACPICA: Clear status of all events when entering S5

on top of commit 1e4b044d22517cae7047c99038abb444423243ca

 Linux 4.18-rc4

to receive an ACPI regression fix for 4.18-rc5.

This addresses a regression in ACPICA that ceased to clear the
status of GPEs and fixed events before entering the ACPI S5 (off)
system state during the 4.17 cycle which caused some systems to
power up immediately after they had been turned off.

Thanks!


---------------

Rafael J. Wysocki (1):
      ACPICA: Clear status of all events when entering S5

---------------

 drivers/acpi/acpica/hwsleep.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)
