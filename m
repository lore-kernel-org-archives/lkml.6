Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E56C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B48220815
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549017537;
	bh=tQIWKd29/4cN5cjTYEnJkXcS1kFreZd0pOgX+WdzzdA=;
	h=From:Date:Subject:To:Cc:List-ID:From;
	b=SkaIhiTHrN7nsk3mmApB35ROC3WbkTuV5v0YulXfOiSI7XcHsIVPEvUyG0gemx04l
	 REf/m/Gh28K+nAxozC/+by2V+Hn84I2k2san1XwDu6wSt5owhlo2dxkhT9bO0o0pPa
	 91oOKCaOsqAe9xt+wVYAl6QeWH2P9YtfDcpJcG/Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729740AbfBAKi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 05:38:56 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46010 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729037AbfBAKiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 05:38:55 -0500
Received: by mail-ot1-f66.google.com with SMTP id 32so5544739ota.12;
        Fri, 01 Feb 2019 02:38:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=EtABUZSTfTPzXb1MOluCPV3aG+niaUhqU7in6B0elVA=;
        b=Tuhmn2mb87s0IN8vgEW++SFbyqRTN0bAp0F1T6p+w+zhJwXt53hbKZVio7OXM3/viZ
         dznR/zt952axwTrqtHpB9TOUaJUvXVFMUXdl50XoZfO1MfVDAC7hUNVF09oGRjUo2UdB
         yz3CUG7C7+WtQNDH8+QoEV736LQO0due2bYen7a/p5dk8gh2B4R+nx+cGe0W79ePtARc
         x+Js/hDSfuFoKlTTiqVV7Iq2mdNmiiK3Pf5/ttdo4wTF8ikC0xq8Pgz6HjkqBU4EcK07
         iM3sLxtT2HUqEK/0x7hZ7fxQgtSy2mzpaHG6sWEaD0LjlUoU5zzSC7LqkC0MlX9v8oTs
         FGcQ==
X-Gm-Message-State: AJcUukdyWwCmM00xhrrBVJb2+TllUlgGoiwWMojnJxC4LW1HML2vk5Bu
        6aeb/so+ycuh5lvndxVFlRb8A5R4W1OH6uwZE9C/GYYU
X-Google-Smtp-Source: ALg8bN7PchS5ltakv/2ZznXxQUOSzGbpvyz3iEZ+l5NkPX4cC6oq2k9dSl2mrLspf4r8JbMb6ACvWht6I6SJQ4rxUTI=
X-Received: by 2002:a9d:4c84:: with SMTP id m4mr25970156otf.124.1549017534642;
 Fri, 01 Feb 2019 02:38:54 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 1 Feb 2019 11:38:43 +0100
Message-ID: <CAJZ5v0hCRCMfJS4nXKnLrGJpEf3Jp6tLwkAeqtTOFOFNk4ckjA@mail.gmail.com>
Subject: [GIT PULL] ACPI-related Kconfig fixes for v5.0-rc5
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-5.0-rc5

with top-most commit b473406a06c49d39d6d653e9981b0bd70300485d

 Merge branch 'acpi-misc'

on top of commit f17b5f06cb92ef2250513a1e154c47b78df07d40

 Linux 5.0-rc4

to receive ACPI-related Kconfig fixes for 5.0-rc5.

These prevent invalid configurations from being created (e.g. by
randconfig) due to some ACPI-related Kconfig options' dependencies
that are not specified directly (Sinan Kaya).

Thanks!


---------------

Sinan Kaya (3):
      mfd: Fix unmet dependency warning for MFD_TPS68470
      platform/x86: Fix unmet dependency warning for ACPI_CMPC
      platform/x86: Fix unmet dependency warning for SAMSUNG_Q10

---------------

 drivers/mfd/Kconfig          | 2 +-
 drivers/platform/x86/Kconfig | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)
