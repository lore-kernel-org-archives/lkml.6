Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA52C61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 11:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0A4D2084C
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 11:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbfASL4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 06:56:08 -0500
Received: from proxy05.fsdata.se ([89.221.252.250]:36631 "EHLO
        mail-gw01.fsdata.se" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727868AbfASL4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 06:56:08 -0500
Received: from localhost (94.234.47.42) by DAG01.HMC.local (192.168.46.11)
 with Microsoft SMTP Server (TLS) id 15.0.1263.5; Sat, 19 Jan 2019 12:56:02
 +0100
From:   Mattias Jacobsson <2pi@mok.nu>
To:     <andy@infradead.org>, <dvhart@infradead.org>,
        <mario.limonciello@dell.com>, <michal.lkml@markovi.net>,
        <mjg59@srcf.ucam.org>, <pali.rohar@gmail.com>,
        <yamada.masahiro@socionext.com>
CC:     <2pi@mok.nu>, <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] platform/x86: wmi: add WMI support to MODULE_DEVICE_TABLE()
Date:   Sat, 19 Jan 2019 12:55:52 +0100
Message-ID: <cover.1547827336.git.2pi@mok.nu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [94.234.47.42]
X-ClientProxiedBy: PROXY05.HMC.local (192.168.46.55) To DAG01.HMC.local
 (192.168.46.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds WMI support to MODULE_DEVICE_TABLE().

[PATCH 1/3]: prepare struct wmi_device_id
[PATCH 2/3]: add support
[PATCH 3/3]: update existing drivers to use MODULE_DEVICE_TABLE()

Mattias Jacobsson (3):
  platform/x86: wmi: move struct wmi_device_id to mod_devicetable.h
  platform/x86: wmi: add WMI support to MODULE_DEVICE_TABLE()
  platform/x86: wmi: use MODULE_DEVICE_TABLE() instead of MODULE_ALIAS()

 drivers/platform/x86/dell-smbios-wmi.c       |  2 +-
 drivers/platform/x86/dell-wmi-descriptor.c   |  2 +-
 drivers/platform/x86/dell-wmi.c              |  4 ++--
 drivers/platform/x86/huawei-wmi.c            |  3 +--
 drivers/platform/x86/intel-wmi-thunderbolt.c |  2 +-
 drivers/platform/x86/wmi-bmof.c              |  2 +-
 drivers/platform/x86/wmi.c                   |  2 +-
 include/linux/mod_devicetable.h              | 13 +++++++++++++
 include/linux/wmi.h                          |  5 +----
 scripts/mod/devicetable-offsets.c            |  3 +++
 scripts/mod/file2alias.c                     | 18 ++++++++++++++++++
 11 files changed, 43 insertions(+), 13 deletions(-)

-- 
2.20.1

