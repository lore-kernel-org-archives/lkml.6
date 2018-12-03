Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFAF0C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4758208A3
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JwatynwX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4758208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbeLCSxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 13:53:53 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:43876 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbeLCSxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 13:53:52 -0500
Received: by mail-yw1-f65.google.com with SMTP id l200so5825273ywe.10;
        Mon, 03 Dec 2018 10:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jpIGOfArGBNMWgXZsUy3sEnlg2klwzYzkIyY2tbBTK8=;
        b=JwatynwXe3U2C61TazCuoQ6nGG84WsmpDKP50qy/YTu4oJXe7h2pTo84KoemGh4C+6
         pmD9BKu9Z+s84C+aR0Q3IeUrUFlUDepYIaUWxMvt7K5AE/luZSq9o1eTF6ehI6qEj/Ls
         S4SL0+5uCtfA2cHl0Mz2dtlP5hVkI+HNGT8i9YX2DPPNtsQarwp2sVjy50f6hF4SBwMS
         nFCVl8CN/tqirPnBrNareQgmbBz9+bQxrsUbUSpTgP5eVRsSHACSS0n6B1Om3TWw+IPc
         pjOBN9B8BubqN2+auUciQ62ksIed1F/q7Fhy6KYoxRoxBPMiseiNPPQUoYaY9K+kJdUF
         6+yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jpIGOfArGBNMWgXZsUy3sEnlg2klwzYzkIyY2tbBTK8=;
        b=ipuvuEpZ2jCMUS9Ybcn8oEL8sd+5gM9UffW47Q1Uhf4GKGwuGZ9bJbkPG9ULUMsO70
         irFT8fb60IvAwsEzrP2fz1NjzFfJ4VYIAdBU6dlsXnwQmuEH0I8XYBuGlKWyKp/Shw9b
         oW6kgX0umvbd5nNm9IXWiyKShXGtXEmVDqtepTypW76HGz5bUDRoRTjf+Iv2WVyBRuKL
         J1RCuODSR/1ed8FuAgm79umB5CPk4WqHPSQ30gkAWJ0Am8bzt8PQxl+i1ymJLL4s4tvE
         p+ZcBHVISrPfSzbcPe1SyHP1SrZaPdatRS+1qiZ8OgAWwSRITr9iCY6kgdEqtfcyoas3
         RKeg==
X-Gm-Message-State: AA+aEWb1FDvhap5fEleO0zX1v7/OUFyowQRPebS+zsZTmqC3OlA7DAll
        8opkKaqYJRBV8pRPFNDFcA==
X-Google-Smtp-Source: AFSGD/UqqFGBRjV/4v1RTKMf5mq9yaA7NHpHwm+wCiEkxH8LnEYkGcIrnTkL8oQDVoR7+sD/lyd9jA==
X-Received: by 2002:a81:8d14:: with SMTP id d20mr17546176ywg.150.1543863229844;
        Mon, 03 Dec 2018 10:53:49 -0800 (PST)
Received: from 960.armstrong.edu ([130.254.104.55])
        by smtp.gmail.com with ESMTPSA id u132sm4842769ywc.11.2018.12.03.10.53.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 10:53:49 -0800 (PST)
From:   Ayman Bagabas <ayman.bagabas@gmail.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kailang Yang <kailang@realtek.com>,
        Hui Wang <hui.wang@canonical.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        alsa-devel@alsa-project.org
Cc:     ayman.bagabas@gmail.com
Subject: [PATCH v9 0/3] Huawei laptops
Date:   Mon,  3 Dec 2018 13:53:37 -0500
Message-Id: <20181203185344.3521-1-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set is based on new audio LED triggers in branch topic/leds-trigger from
        git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git

Changes from v8:
* Explicitly use NULL in acpi_get_handle
* Drop __initconst from huawei_wmi_keymap

Changes from v7:
* Switch to wmi_driver
* Use devm to allocate and manage devices
* Skip registering LED subsystem if a ACPI controller method was not found

Changes from v6:
* Use audio LED triggers patch set
* Use KEY_CONFIG (XF86Tools) instead of KEY_PROG1.
 In Windows, the key is used to launch Huawei PC manager. XF86Tools is
 used by default on most desktop environments i.e. Gnome.

Changes from v5:
* Review tags

Changes from v4:
* Consistency in file names
* How module would be enabled (Kconfig)
* Match license in SPDX and MODULE_LICENSE 

Changes from v3:
* Code formatting

Changes from v2:
* Support for Huawei MBX
* Style and formatting issues

Ayman Bagabas (3):
  ALSA: hda: fix front speakers on Huawei MBXP.
  x86: add support for Huawei WMI hotkeys.
  ALSA: hda: add support for Huawei WMI micmute LED

 drivers/platform/x86/Kconfig      |  16 +++
 drivers/platform/x86/Makefile     |   1 +
 drivers/platform/x86/huawei-wmi.c | 226 ++++++++++++++++++++++++++++++
 sound/pci/hda/patch_realtek.c     |  22 +++
 4 files changed, 265 insertions(+)
 create mode 100644 drivers/platform/x86/huawei-wmi.c

-- 
2.19.2

