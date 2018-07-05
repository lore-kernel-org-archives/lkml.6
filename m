Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E773DC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A186F240E4
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVCHr2eh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A186F240E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753994AbeGELba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 07:31:30 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:34669 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753698AbeGELb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 07:31:28 -0400
Received: by mail-oi0-f68.google.com with SMTP id 13-v6so16195427ois.1;
        Thu, 05 Jul 2018 04:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to:cc;
        bh=aOOOds09cvQIOh/glCYqdOboK72BT2S2nJfZm6t64Bs=;
        b=CVCHr2ehf++cvjcQxm448aNwLND58Y20SWrC04ZKgKYxJZrE5aluR5t3ICHDwC8eYE
         u0w9uyT1CB2fnZqkNQ7n/t7oxJQJm/Y/bby4QUG1J1itwbtvFSY0Mw2slPz4gOp9tDDf
         4MKso4NFh+zjhRhnrjP9CG2ayDAls957RX0BCIrVW4RmTm9tZaMXwgwqNN3k5TeD3M96
         Vn881mu43XDqqAURy6OjZ8edj0AS3H0hlWuwXut+20xbN0CdKAkDl3HN+OvAv3LNW1E5
         KAUvijIsY+z6W0nYnsMC/pV6jdnXGtpmOi8VrLVbmNqvJ2QKN/GcE9DNnAlGVWgzGaM8
         0hWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:cc;
        bh=aOOOds09cvQIOh/glCYqdOboK72BT2S2nJfZm6t64Bs=;
        b=AL8SDP3QWCaYEhOuSpmo5IQ6Dvw4pf8WH6OIfMz65fnsT2gBWeEfV3bx4k6mvc6irW
         fPT5eo820K+9TzlCb/tgyEll9/aMeLPZgPMX2BRDrCYMteCwg3gdrY31AXSSKtUCEGuL
         HFSyytxsmc8ER+n84S1GQBMQ/e5G9DvxGt1X4j/l4J+4FLFdWjJQ4ONGaCyxDOE7I2VS
         NFQzMGAQmlZOsLkNxGScF3/Kl9fm9HNjNmuwpTVB2QFJ1okN3aMuH7rpqh4P8mEWyant
         Qxl4IKXmeRlpMV5PqXNJ72dUW0NeU7qsY5NWzDktxfdpzqpWD1Gf8og7FXSrISZk3Uj7
         kJjg==
X-Gm-Message-State: APt69E14uxj0jz/fcWDa3LDYsvFXVrrQ0Ttm1e3GcskqQSLfKClBUtEz
        lRGuACF8SvDR6L/jPWOTdCi0wY14UG8iavkf12Jebw==
X-Google-Smtp-Source: AAOMgpcmbCHGzEboGcW3KTIPcrL5eaTyLTU/rvVyw4l5L5YQKSSNUG0GMMdiPrCp+QfF6kgbcTzBs5FDowgVgmEJFPA=
X-Received: by 2002:aca:ad4f:: with SMTP id w76-v6mr6636822oie.233.1530790287832;
 Thu, 05 Jul 2018 04:31:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Thu, 5 Jul 2018 04:31:27 -0700 (PDT)
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 5 Jul 2018 13:31:27 +0200
X-Google-Sender-Auth: dvlAwxCuXa6IYYeFtH9ee4Eue-4
Message-ID: <CAJZ5v0hTE4OMOQ7wJ0S5eEwK+ZzYo4HVaGHvJiDPVA4xJc2hyQ@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v4.18-rc4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
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
 pm-4.18-rc4

with top-most commit 88b96088e94ec66f6c9015eee28cb9d053be69c0

 Merge branch 'pm-pci'

on top of commit 021c91791a5e7e85c567452f1be3e4c2c6cb6063

 Linux 4.18-rc3

to receive power management fixes for 4.18-rc4.

These fix a PCI power management regression introduced during the
4.17 cycle and fix up the recently added support for devices in
multiple power domains.

Specifics:

 - Resume parallel PCI (non-PCIe) bridges on suspend-to-RAM (ACP S3)
   to avoid confusing the platform firmware which started to happen
   after a core power management regression fix that went in during
   the 4.17 cycle (Rafael Wysocki).

 - Fix up the recently added support for devices in multiple power
   domains by avoiding to power up the entire domain unnecessarily
   when attaching a device to it (Ulf Hansson).

Thanks!


---------------

Rafael J. Wysocki (1):
      PCI / ACPI / PM: Resume bridges w/o drivers on suspend-to-RAM

Ulf Hansson (1):
      PM / Domains: Don't power on at attach for the multi PM domain case

---------------

 drivers/base/power/domain.c | 16 +++++++++-------
 drivers/pci/pci-acpi.c      | 12 ++++++++++++
 2 files changed, 21 insertions(+), 7 deletions(-)
