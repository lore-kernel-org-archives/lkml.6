Return-Path: <vadimp@mellanox.com>
X-Google-Smtp-Source: AIpwx48fwFg9vvRCMKo0yp1IU6WqLang7sKF3ExZM+p91GnT8Uab98jX3YTQ1TQyCAQFYYCp622/
ARC-Seal: i=1; a=rsa-sha256; t=1522137951; cv=none;
        d=google.com; s=arc-20160816;
        b=QetaFspSh1Jblud9Ow5fXJJa3HoLibujTiP4t5xck5mCYgZPqX2gsoV3dxg2/AyUZM
         Jelm3+/Maw6Cj/d0Ks7uyZA0ZwyJux2azIAhaRsweRw8W+YV6zKpfjU/BMBro30LaZGU
         5dC5htVwXSaI5nSxVCd2tcer7EErm4KmV1/2PKNnvgLi1NHUP5/wlGBZDalhtBBczhp9
         ayk7RjlqcfUguCmDIMOY0m+mVahsBZv5ckF55SHuVvYC/2xQ13zSttQNT4VqzRDWSsQg
         s3YAXZFXz33bDKyDeMDVrlhPr66bWkfri12R60yP1P0On59KVTnVg2OQ4APgEieSK+kF
         KF+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=4/GEKwbQQ37HoBlZSRv9yaifWXWTdjeKrHFyMWSVoZM=;
        b=OEPoWOGLzSimA1+0DRzO8ZcmblfYfD3dPyxBmhlDhRytIHOpPrp07lvCMuXElnIr6f
         uXLkUCDQmj/e5d+xezUyw3Hu1CdPFNe9e5tCRJHnzUuLFFZtn5EW6gsWL/MPFyE4uka5
         UlJ6u87AQZOoD0+bdiWt+KY9R/nsGzf4rKLux7DTKcFAZa4AVeScBYHTHzqF16VLi8zX
         W22N1mGvwUlcGSUmdsUxXi2AtO6MgxWZUP20WoArsFjNfDNoIInO1A9joZbJ2Ga77Qsw
         YrcoTXRuOG8EUO5/9oXweajvdNzwUM3LXQD+xCCApu5DAWjq+X5jc8jLAOMtAAC7uYSM
         G3Cg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of vadimp@mellanox.com designates 193.47.165.129 as permitted sender) smtp.mailfrom=vadimp@mellanox.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=mellanox.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of vadimp@mellanox.com designates 193.47.165.129 as permitted sender) smtp.mailfrom=vadimp@mellanox.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=mellanox.com
From: Vadim Pasternak <vadimp@mellanox.com>
To: dvhart@infradead.org, andy.shevchenko@gmail.com,
        gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        jiri@resnulli.us, michaelsh@mellanox.com, ivecera@redhat.com,
        Vadim Pasternak <vadimp@mellanox.com>
Subject: [PATCH v1 0/7] platform/x86: Mellanox add fixes and new features
Date: Tue, 27 Mar 2018 10:02:00 +0000
Message-Id: <1522144927-56512-1-git-send-email-vadimp@mellanox.com>
X-Mailer: git-send-email 2.1.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596077324934314192?=
X-GMAIL-MSGID: =?utf-8?q?1596077324934314192?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patcheset includes:

Document fixes for mlxreg-hotplug driver and mlxreg header file.

Fix for the race condition in mlxreg-hotplug driver.

Adding support for ODM system types.

Activation of Mellanox LED driver from mlx-platform.

Introduction of new mlxreg-io driver.

Activation of mlxreg-io driver from mlx-platform.

Vadim Pasternak (7):
  platform_data/mlxreg: Document fixes for hotplug device
  platform/mellanox: mlxreg-hotplug: Document fixes for hotplug private
    data
  platform/mellanox: mlxreg-hotplug: add extra cycle for hotplug work
    queue
  platform: mellanox: add new ODM system types to mlx-platform
  platform/x86: mlx-platform: Add LED platform driver activation
  platform/mellanox: Introduce support for Mellanox register access
    driver
  platform/x86: mlx-platform: Add mlxreg-io platform driver activation

 drivers/platform/mellanox/Kconfig          |  11 +
 drivers/platform/mellanox/Makefile         |   1 +
 drivers/platform/mellanox/mlxreg-hotplug.c |  23 +-
 drivers/platform/mellanox/mlxreg-io.c      | 221 ++++++++++++++
 drivers/platform/x86/mlx-platform.c        | 447 +++++++++++++++++++++++++++++
 include/linux/platform_data/mlxreg.h       |  66 ++++-
 6 files changed, 765 insertions(+), 4 deletions(-)
 create mode 100644 drivers/platform/mellanox/mlxreg-io.c

-- 
2.1.4
