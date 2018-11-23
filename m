Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE42C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 10:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C5B420820
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 10:12:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C5B420820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409278AbeKWUzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 15:55:52 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40648 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393883AbeKWUzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 15:55:52 -0500
Received: by mail-ot1-f67.google.com with SMTP id s5so10205616oth.7;
        Fri, 23 Nov 2018 02:12:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=RzicbqRA+sc8lZGo/bttd6EuTXocDuwhmR10RzuVyfg=;
        b=HtIHGvVzb0n2c75Y8+KgYV+b9NTsC17merQTyuCezIDNb3l162mdW4MVtj3p9c+njc
         2TtfnZldMLQWD/lb6yrKcQ9Nx3dQwHAKsNPLgZH1nZYOa9uAjFMQbqRL3lLjn0Kd8BWa
         HpcpJIEgJqspXW13xbe8uNn3+p9fpWt1fdQF39CaaUJwicOGFPC8S8CHkHCP7UhO1VE4
         vRJktf4BuTSXV6WRNWo+uQG63/4BwndWDfuzfOetduRS5aFBVKOXYcqpVgOACKFNRrZ1
         cUFJyD9XwzZ6tSupWR9bVBrk/4O1Vim1hUwZo22gGQjYU6Wj+VVDC/hFsn7avb59AbRf
         5Z1g==
X-Gm-Message-State: AGRZ1gJvFRYXk1Ci/LYRgclk77yxOHeUeu38F95A0TfIhXxfOFekOTov
        LMeB8rn91+mj11beMvuaKM9HFVVzpvmQ9FfEIeI=
X-Google-Smtp-Source: AFSGD/UaP+hwZQdBg/rVcXcsB67EbAooBaNowil0xFe44cYiypzq/E/zXvB8MB0/BT1Pndlyn2uHIcVZ5O0GtcHCxls=
X-Received: by 2002:a9d:588c:: with SMTP id x12mr8704222otg.139.1542967934009;
 Fri, 23 Nov 2018 02:12:14 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 23 Nov 2018 11:12:02 +0100
Message-ID: <CAJZ5v0i5P6fEocXaOTRjBEW=NM5zYeHxrOB-KzxPpEXTq75esg@mail.gmail.com>
Subject: [GIT PULL] ACPI fix for v4.20-rc4
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
 acpi-4.20-rc4

with top-most commit 2bbb5fa37475d7aa5fa62f34db1623f3da2dfdfa

 ACPI / platform: Add SMB0001 HID to forbidden_id_list

on top of commit 9ff01193a20d391e8dbce4403dd5ef87c7eaaca6

 Linux 4.20-rc3

to receive an ACPI fix for 4.20-rc4.

This prevents the ACPI core from registering a platform device for
the SMB0001 HID to avoid IRQ allocation issues (Hans de Goede).

Thanks!


---------------

Hans de Goede (1):
      ACPI / platform: Add SMB0001 HID to forbidden_id_list

---------------

 drivers/acpi/acpi_platform.c | 1 +
 1 file changed, 1 insertion(+)
