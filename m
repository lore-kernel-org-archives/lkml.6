Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E3C7C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 09:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF060206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 09:37:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF060206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbeIGOSC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 10:18:02 -0400
Received: from mail-oi0-f44.google.com ([209.85.218.44]:42907 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbeIGOSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 10:18:02 -0400
Received: by mail-oi0-f44.google.com with SMTP id v198-v6so8423015oif.9;
        Fri, 07 Sep 2018 02:37:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=sWija4QtgEf1Rp1XBWlPkZN6p/D6vEigMAwsU7Dc1s4=;
        b=YAnzA/dhT6rM6oV9GmGIAf3uXNzPslUjaUnutHLlKu3xBecE4UfJfJHB+VhJfchp71
         eso3VEXefop5YeiKyINotKnUjr8GLimI2vA6hxpzr59t/NAWAWSwcAgvcV8vjps3Fux9
         NNF6j1L835f6G6c6EdpPOYsYHMnFROzqF4SByD25xeE3uJWu5VgliBgrSRPGSF29q5hk
         xaJGJ7v1oLXaf4t4amlG+NlMKemQVuatsqsknUq05dLe+HTmj7r2bBQkcUXornbmn8EK
         XkQcKTUN6dqZm7L4HKPMGte8ROSD5f5q3UOlhJ88BY+wxZWRvPaUH7WqAxJ5HEjWXXaZ
         7MKA==
X-Gm-Message-State: APzg51A+dzCU4ShlTwZB6WKkdw6r17eIFv+OoaKoZTxIoChFmYqgpEJe
        rpXQ7sadJLcren3cmIa6hmOLdjKwzG+T6Y2ZKYQ=
X-Google-Smtp-Source: ANB0VdY0ri0vlCtr0Wy03A/rD1hwQFzzLZGrzEtjKcnYNgTfQ7t7PK4JwytUK/EAvTOYqf56bv/26aOKXu6P1Q1iAOc=
X-Received: by 2002:aca:1719:: with SMTP id j25-v6mr7345623oii.138.1536313075580;
 Fri, 07 Sep 2018 02:37:55 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 7 Sep 2018 11:37:44 +0200
Message-ID: <CAJZ5v0jWX3mBgeQdhGJr8_Okt_bouG+azeFORh=XiMTLvyimPw@mail.gmail.com>
Subject: [GIT PULL] ACPI fixes for v4.19-rc3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

two ACPI fixes for 4.19-rc3.

These fix a regression from the 4.18 cycle in the ACPI driver
for Intel SoCs (LPSS) and prevent dmi_check_system() from being
called on non-x86 systems in the ACPI core.

Specifics:

 - Fix a power management regression in the ACPI driver for Intel
   SoCs (LPSS) introduced by a system-wide suspend/resume fix during
   the 4.18 cycle (Zhang Rui).

 - Prevent dmi_check_system() from being called on non-x86 systems in
   the ACPI core (Jean Delvare).

Thanks!


---------------

Jean Delvare (1):
      ACPI / bus: Only call dmi_check_system() on X86

Zhang Rui (1):
      ACPI / LPSS: Force LPSS quirks on boot
