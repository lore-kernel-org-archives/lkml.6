Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754324AbeCGLEI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 06:04:08 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:42015 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751149AbeCGLED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 06:04:03 -0500
X-Google-Smtp-Source: AG47ELtxccL4uGacyKIC6r+WYzjz1ofbAF3EGCUhfr9kZO413Qy/+qZFExH/Zz7SrshVITtixhZ9GA==
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: ysato@users.sourceforge.jp, dalias@libc.org
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org
Subject: [PATCH 0/2] sh: use put_device() instead of kfree()
Date: Wed,  7 Mar 2018 16:33:12 +0530
Message-Id: <cover.1520420267.git.arvind.yadav.cs@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Never directly free @dev after calling device_register(), even
if it returned an error! Always use put_device() to give up the
reference initialized.

Arvind Yadav (2):
  [PATCH 1/2] sh: maple: use put_device() instead of kfree()
  [PATCH 2/2] sh: superhyway: use put_device() if device_register fail

 drivers/sh/maple/maple.c           |  3 ++-
 drivers/sh/superhyway/superhyway.c | 11 +++++++++--
 2 files changed, 11 insertions(+), 3 deletions(-)

-- 
1.9.1
