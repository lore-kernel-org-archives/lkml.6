Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BCE1C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 09:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0991F208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 09:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TesefeLv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0991F208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731997AbeGaLN6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 07:13:58 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33575 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729768AbeGaLN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 07:13:58 -0400
Received: by mail-oi0-f66.google.com with SMTP id 8-v6so2485202oip.0;
        Tue, 31 Jul 2018 02:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to:cc;
        bh=5KWdTI4GZbXoLqwunPxLCGeW+pNnPHvyjoRUdZTXDgU=;
        b=TesefeLvhrwyd0Kzd8+YiOdCGKfqM1g/fCkHSczLv803THaqvMcTV1yUxKGcTkXNSf
         fQeRlDFORCBO9DX4o8fh/8JauYzEWGA7aZWzAVEbQ4YTdEGVDZSf2lF36JDRH+2/j5dY
         gLWlFfi9+/6UmAcXnrVfY5MKJkjnGahkr9GQISfwHDyg3AdAl0mEzE5UEu4dxPQbyp4i
         AHB2nL5LlVpjfNNQK4xRG7PUbw47D0VVYf1GtY4NU82Sx6lyn2yzhrIthTmmx20nVVW9
         mG3aTmcAtL8t07pFNYeWu8LYHY9znclflU8sPRymE9CC/th4oD1j2gYLValGXdp0e/LL
         IuRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:cc;
        bh=5KWdTI4GZbXoLqwunPxLCGeW+pNnPHvyjoRUdZTXDgU=;
        b=saX5farrGWGx0jkcjtoVNSdp1EdWMla0z4RovEFDcGek5JA1IzbdvNR+CezmYsTRQC
         13ruWVyXEP1awnoZVjO/WKqGSQEbOC3IhwZCp58TfQ1fK7w0mXceeoueiohkIFqwS9PS
         mxcFx0DHXglFGQoosVH5og/VMkZ6z0M7xLO8y5HRCJAkp6a8IS5Xk+PAcY4vgNJr8IkB
         FWUoHK6wNoAt8JYwpzNTJy6OCy+M4mdd6TfeFCE9b/ODF0YHQ9nesLDtIBQho8sjTK+9
         y1jVj6J1ngYRkgqrL62TcKGA65R10ZdXwldyLyApo5u5Cu1rf8ZZWbQM6Jg1THOcs9zS
         9SfA==
X-Gm-Message-State: AOUpUlEPXRPh23GktPcugfV9wbJlIf9OKZnMe0l+FzShJUdlEZ6miDGq
        ZlECGYSjhHEsmpE+6qTHr8lXZZdAWV0JIMNs35uY8SNk
X-Google-Smtp-Source: AAOMgpeIt5b3Ixl8eCt0P8qqWzkz7eSF0niLGxIps8UAv1u3+J5crhNQW6yyvqDObz8mBvfDE8cP42qFX5EsdgnFa/E=
X-Received: by 2002:aca:6285:: with SMTP id w127-v6mr20491104oib.120.1533029670674;
 Tue, 31 Jul 2018 02:34:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Tue, 31 Jul 2018 02:34:30
 -0700 (PDT)
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 31 Jul 2018 11:34:30 +0200
X-Google-Sender-Auth: oeMNTTyD23LFtRmd2y18CWYKDpE
Message-ID: <CAJZ5v0jeTuS0v=9AmQz0c_qAE6ppHVKvBsa2CXJUiRf5axNuCg@mail.gmail.com>
Subject: [GIT PULL] Urgent ACPI fixes for v4.18
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
 acpi-urgent-4.18

with top-most commit 5f95d39b4246c034838b10f5a4ee50be5b984b95

 Merge branch 'acpi-soc'

on top of commit 73c2a01c52b657f4a0ead6c95f64c5279efbd000

 ACPICA: AML Parser: ignore dispatcher error status during table load

to receive urgent ACPI fixes for final 4.18.

These fix a recent ACPICA regression affecting control method
execution at the table level and an earlier hibernation regression
in the ACPI driver for Intel SoCs (LPSS) that was missed by a
previous fix in this cycle.

Specifics:

 - Fix a recent ACPICA regression introduced by a previous fix
   that caused control method execution at the table level to be
   mishandled by mistake (Erik Schmauss).

 - Fix a hibernation regression from the 4.15 cycle in the ACPI
   driver for Intel SoCs (LPSS) that caused the platform firmware
   to be confused during resume from hibernation by the driver's
   PM quirks which was fixed for system-wide suspend/resume (ACPI
   S3) earlier in this cycle, but that previous fix missed the
   hibernation (ACPI S4) case (Rafael Wysocki).

Thanks!


---------------

Erik Schmauss (1):
      ACPICA: AML Parser: ignore control method status in module-level code

Rafael J. Wysocki (1):
      ACPI / LPSS: Avoid PM quirks on suspend and resume from hibernation

---------------

 drivers/acpi/acpi_lpss.c     | 26 +++++++++++++++++---------
 drivers/acpi/acpica/psloop.c | 19 ++++++++++++-------
 2 files changed, 29 insertions(+), 16 deletions(-)
