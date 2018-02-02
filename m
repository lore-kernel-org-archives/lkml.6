Return-Path: <vadimp@mellanox.com>
X-Google-Smtp-Source: AH8x226hu8XmeGs6dGqhnerWMVtC2kmrl+nzD9LxnKsCJIJXpbocNEBWcVpoTBwNo7kfIH+sRqep
ARC-Seal: i=1; a=rsa-sha256; t=1517554164; cv=none;
        d=google.com; s=arc-20160816;
        b=xpvBQdlKMWyUeba6RDMCn3MYOIMccaBhw+jZEv/LBrxnQUMUF/7GbCVYKpmZqpSF8S
         u7BHIp+Qw6G6yP2+f1gpOYPuRmwva68mXGbLJqLcgIjOF8E0WeQzvZ9K0wYKP2WI/HhP
         L2XV3Obfl5d4+/h6XK9LvakgmT+cEJwUqZxXawGr8ag4XXbvWiYLVHTiRp7p2S9ZcRZo
         RNsSoMmbB8IqQkJFP4qOSx2H8/yi9jaxS8drO+tlmuorRmTK144R5Ka7P7e34W1eKTbN
         UBCT1xeEJ+5ACCxfNr9B/OAUkcFRZcbM+ccXvENogxXGa5NghvWqa9UE0G6VGVI/KYR7
         m3eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=WCFa4dtXLRhY3Ssk3OG55/gKVQrz094qEZUKLVq23C8=;
        b=VGMdy9YDlFnFMDzAGcSYUZ94yM/2jnC+oyk67JOvyCtOfT0GczU1QDY8Mt2GrlZUTT
         ukjU1xIvr9WU9XbWBRFA8hOAaILOtzIuSRgbQ3hUmHfOxzNbUMwRpessattFOLxVwzzK
         G9keXE8YNJL2ptwQP27i9BrGu3Kjz3zGmDVIUiGEFsnZtaXobZFh+/1nlcWhA2iIkU6J
         UevNd2u2pZOuu83vH26/0pc7smPwYb0niivY8ndmvMuaAL7FFGMyoMo/Rt2Riksz7RJH
         cdyGOKTiFUIOcEM5Fdhhtt6WmpueUFrwdSkS4Kr25iCNovDeJD6WWddzafQNmVU7RSMS
         4/Ng==
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
        jiri@resnulli.us, Vadim Pasternak <vadimp@mellanox.com>
Subject: [patch v1 0/4] mlx-platform: Add support for new Mellanox systems, code improvement, fixes for msn21xx system
Date: Fri,  2 Feb 2018 08:45:44 +0000
Message-Id: <1517561148-38587-1-git-send-email-vadimp@mellanox.com>
X-Mailer: git-send-email 2.1.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591270875340200693?=
X-GMAIL-MSGID: =?utf-8?q?1591270875340200693?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The patchset:
- adds defines for bus numbers, used for system topology description;
- fixes definition for power cables for system family msn21xx;
- introduces support for new Mellanox systems;

Vadim Pasternak (4):
  platform/x86: mlx-platform: Use defines for bus assignment
  platform/x86: mlx-platform: Add define for the negative bus
  platform/x86: mlx-platform: Fix power cable setting for systems from
    msn21xx family
  platform/x86: mlx-platform: Add support for new Mellanox systems

 drivers/platform/x86/mlx-platform.c | 345 ++++++++++++++++++++++++++++++++++--
 1 file changed, 335 insertions(+), 10 deletions(-)

-- 
2.1.4
