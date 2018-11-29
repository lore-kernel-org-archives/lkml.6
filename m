Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F53C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 255FB20673
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gvpoh4I/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 255FB20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbeK3LF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 06:05:26 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:42370 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbeK3LFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 06:05:25 -0500
Received: by mail-vs1-f65.google.com with SMTP id b74so2283394vsd.9;
        Thu, 29 Nov 2018 15:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Mdrgw0ag+aZYKUyw1yG3n2xoeVBcrian9U6aVKzh6+U=;
        b=Gvpoh4I/hkhZXiVQGYv8iQM0jy6DiSe4YunygNaTzyoEI5dp9zhg8rJx8AMrYebY/W
         PeuPt3kVsznT4oNf0s76kuMYQoXnpHSoMeVarfwRb9ZM9c+ESgDw+r95BSrl99Mi1w10
         FBHGcFkq2ZAaB/nxQ88Ftngu2qrttS7GtzZofJxf/6qhUQiQkcjNLkljl0rof09q8Fj8
         nRl4oybJsXIHH5/zId5EmvTvlcHReDrSDLRvv6LcuV/8Xb25enjl0cyxqzTAQMWmRwtD
         FOeYFau6EECyV+05JiM51/yaUCrcFOPQXVYM8AJgz7air4xvxjcSw3paqcEKqsxNOVuP
         DOog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Mdrgw0ag+aZYKUyw1yG3n2xoeVBcrian9U6aVKzh6+U=;
        b=N3WRUNFD1Vtgm3iCS23Hm4Ugis6EQWx9VwuQw4EXzvDpUXPViuR12HoiezzSRt8+oi
         Ir8WyF2MX6ei28jeSf0DaWWV4Ss9xSGvMlpCZHz/aiWuqIPQQlvbcptwp5nwj+bcrPtv
         swNCyEXDMRaZEGNCGqBWpwG1upp6deUKfXQrvTADgJ5Xmp6KugmzcQVWbYCwor9lcpuD
         yoHm/LO90jRgLwKIi3WamssVpLtyRZVWdEmOm+dNMeKQLZ30BkG70Q8vB2sBUl848LVs
         0lRplxh4vWv7B5Xxvu+Ayhjm88K+kvy0ii6jAkl4NZWMLhqQdN6APNLVp7ailOJyzl5q
         0Psw==
X-Gm-Message-State: AA+aEWZhA06X9ARNXldJ3LgdWFojhyQZeHnxyrVa0nzX2Y+js4pb/ir9
        OJV0Fj2WMT0/ZDVD1gWeZg==
X-Google-Smtp-Source: AFSGD/W1z+FYGz0JKnapoaFSJ42SIyFEL6RqxeOCHHdI8Dj3sZ88vC+vJ2lPnCKC+SuDv2pKjKpDyg==
X-Received: by 2002:a67:cb9b:: with SMTP id h27mr1567557vsl.227.1543535886777;
        Thu, 29 Nov 2018 15:58:06 -0800 (PST)
Received: from localhost.localdomain ([2601:902:c200:6512:a50b:fc5d:3604:d966])
        by smtp.gmail.com with ESMTPSA id d195sm520831vka.29.2018.11.29.15.58.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 15:58:05 -0800 (PST)
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
Subject: [PATCH v8 0/3] Huawei laptops
Date:   Thu, 29 Nov 2018 18:57:35 -0500
Message-Id: <20181129235742.14332-1-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set is based on new audio LED triggers in branch topic/leds-trigger from
        git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git

Changes from v7:
* Switch to wmi_driver
* Use devm to allocate and register devices
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

 drivers/platform/x86/Kconfig      |  16 ++
 drivers/platform/x86/Makefile     |   1 +
 drivers/platform/x86/huawei-wmi.c | 238 ++++++++++++++++++++++++++++++
 sound/pci/hda/patch_realtek.c     |  22 +++
 4 files changed, 277 insertions(+)
 create mode 100644 drivers/platform/x86/huawei-wmi.c

-- 
2.19.1

