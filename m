Return-Path: <vadimp@mellanox.com>
X-Google-Smtp-Source: AH8x227fL83DB3TZzLvtGVpaxLcSKBZHPaK0MvDv1JwxtcJ9LbJ9k+I7KbmhslE83LLdRHWANTRE
ARC-Seal: i=1; a=rsa-sha256; t=1517554173; cv=none;
        d=google.com; s=arc-20160816;
        b=k3kTeIsITcRV0iQV/sxuK6Ge2Q2IaUJY4IcCUD4K+I4mKOGFRNscQXloMkZ/WxsLq8
         2f01B/xyZvYXVnb68L3JAab17vzKWFK+bfpHDJjueLs4wSWLmALghBPXdwJiRThQaGWY
         eRFhGjOrPk8D9MNnRbWjveMESzv0KFocu2a9AinuR3PqmhM9H22NPfobqE7tla5a/50V
         s65JBbkgLX5TVCeQhNGrFAYP6+9zoJlYQZzOiOA+iIJUcoMChitBy6VnydOXD8RZJ1re
         /RsJNvt2gZxv+Sql3FEpgENp/p9zs0piv3WNz80DzERF32LE8wkGZaN6RW9OV9vAz4Iz
         gC/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=D2AgqsEk+/kgNAuUPdJIy49lD1P2DtDFOlq/mbgeZWg=;
        b=IH2LgpaaOO2bwgK333NOERACr9pPwgJk929Rtt3bBpMuzjLWUy+TyCdBo07ovns9V/
         pgpJmnJL92j8LbvwJDTA+CwW6KBdULxnA0YDClduk2QhTghEVeNGfNV8QjJhG21V2Df2
         4L9Ltj3sJqT5nQlBkoLArBMwHy51BdALOhzIUO0+MvH2aVrOtcSqTrb1MlJ9Xts7YQxY
         I6UFt9y5wE5S7U5tKQ1NtmVUR7nOEY5q5BnV8NeWo82NKplaBtW4FfeSETMUnHJwo3CY
         e4cqnzQQaAQiB+y4WdvNYYZxz9hx20zL1ys6FwpqGLdxgkPbh2K79tOkbQxP1NECX4rd
         KHtw==
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
Subject: [patch v1 2/4] platform/x86: mlx-platform: Add define for the negative bus
Date: Fri,  2 Feb 2018 08:45:46 +0000
Message-Id: <1517561148-38587-3-git-send-email-vadimp@mellanox.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1517561148-38587-1-git-send-email-vadimp@mellanox.com>
References: <1517561148-38587-1-git-send-email-vadimp@mellanox.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591270885121716699?=
X-GMAIL-MSGID: =?utf-8?q?1591270885121716699?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add define for the negative bus Id in order to use it in case no hotplug
device is associated with hotplug interrupt signal. In this case signal
will be handled by mlxreg-hotplug driver, but any device will not be
associated with this signal.

Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>
---
 drivers/platform/x86/mlx-platform.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/mlx-platform.c b/drivers/platform/x86/mlx-platform.c
index a1ae93d..177b40a 100644
--- a/drivers/platform/x86/mlx-platform.c
+++ b/drivers/platform/x86/mlx-platform.c
@@ -90,6 +90,7 @@
 #define MLXPLAT_CPLD_LPC_MUX_DEVS		2
 
 /* Hotplug devices adapter numbers */
+#define MLXPLAT_CPLD_NR_NONE			-1
 #define MLXPLAT_CPLD_PSU_DEFAULT_NR		10
 #define MLXPLAT_CPLD_FAN1_DEFAULT_NR		11
 #define MLXPLAT_CPLD_FAN2_DEFAULT_NR		12
-- 
2.1.4
