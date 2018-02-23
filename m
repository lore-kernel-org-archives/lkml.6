Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224kEhNZKhbst+OASbizdtwGD5JiuXgh4CjS0PGmDAbLbWl2gDKlQ0Ap+LIDXeefZEEn8CaZ
ARC-Seal: i=1; a=rsa-sha256; t=1519412222; cv=none;
        d=google.com; s=arc-20160816;
        b=oGK3iu3ECtfaurL2FDZIaMZKfbt6j19e0DEbhvVyXm84FwNET1auj3e1FBLNWWWcJm
         2J5QIdPUZuIYilYFCvZNMGKAYqkOx17VeF2kM1Wu2rHM1Bm+ZpA2TDQoTTSRmJrvYmlN
         BkjyghjPQTFZfRQcy1kNm7qRz8Xyv/Dn97+h9dAv1xNZ81a8WEgBhiLXhg7JDOvOcB9Q
         cx0/I6GDt87T5b5GdguMMMGqXnmJBSG5p66rjIHG2m0gO7yBJguWS1odIvJY2Djl1khL
         OtJpQLen0ieQN5Oxz37t849uMRLu/J8oQS2W+pa1JC7IeJkvuCj/6tnFaFbYyLZRF9a9
         r9lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=uCN609/TSxyoVm5ZVOejaQ7vJfLLdY7MyAZSPRZjEAA=;
        b=wW0BnlkYrWU5StjyODFJtg8UcXbYd3Nr0V1xS7NXbdsArPlm0dzjYVwwJlsRJzkZPb
         DCMJM0Fgr6CN8zAk+iLR0Y2dhg+3GC3ek//CMSGMYyI9HwYu9WzHZjeDcYTfvCWEuESv
         rVNuvgTYkaJsrxFA/EVpE1pkSHzajNpb6n1giKlmWvcsCpttMZzZzAGlC+9YYwN4+xeP
         GfxAsjCRhbJLueoxioh6Bpr5eO/Q/wNqjp6kJZpDuIVV84v2rwHrU9oJiqVFOAEzWDwl
         +a7QrfxqwpSvO/ZqFipHOeOq/+OKDdNZSMFJDIP61Z2ZkeIK0gMT20eQc3xV2RPJRs7D
         dfcA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH 4.14 158/159] mei: me: add cannon point device ids for 4th device
Date: Fri, 23 Feb 2018 19:27:46 +0100
Message-Id: <20180223170802.069106803@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593219191114651685?=
X-GMAIL-MSGID: =?utf-8?q?1593219191114651685?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tomas Winkler <tomas.winkler@intel.com>

commit 2a4ac172c2f257d28c47b90c9e381bec31edcc44 upstream.

Add cannon point device ids for 4th (itouch) device.

Cc: <stable@vger.kernel.org> 4.14+
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/misc/mei/hw-me-regs.h |    2 ++
 drivers/misc/mei/pci-me.c     |    2 ++
 2 files changed, 4 insertions(+)

--- a/drivers/misc/mei/hw-me-regs.h
+++ b/drivers/misc/mei/hw-me-regs.h
@@ -133,7 +133,9 @@
 #define MEI_DEV_ID_KBP_2      0xA2BB  /* Kaby Point 2 */
 
 #define MEI_DEV_ID_CNP_LP     0x9DE0  /* Cannon Point LP */
+#define MEI_DEV_ID_CNP_LP_4   0x9DE4  /* Cannon Point LP 4 (iTouch) */
 #define MEI_DEV_ID_CNP_H      0xA360  /* Cannon Point H */
+#define MEI_DEV_ID_CNP_H_4    0xA364  /* Cannon Point H 4 (iTouch) */
 
 /*
  * MEI HW Section
--- a/drivers/misc/mei/pci-me.c
+++ b/drivers/misc/mei/pci-me.c
@@ -99,7 +99,9 @@ static const struct pci_device_id mei_me
 	{MEI_PCI_DEVICE(MEI_DEV_ID_KBP_2, MEI_ME_PCH8_CFG)},
 
 	{MEI_PCI_DEVICE(MEI_DEV_ID_CNP_LP, MEI_ME_PCH8_CFG)},
+	{MEI_PCI_DEVICE(MEI_DEV_ID_CNP_LP_4, MEI_ME_PCH8_CFG)},
 	{MEI_PCI_DEVICE(MEI_DEV_ID_CNP_H, MEI_ME_PCH8_CFG)},
+	{MEI_PCI_DEVICE(MEI_DEV_ID_CNP_H_4, MEI_ME_PCH8_CFG)},
 
 	/* required last entry */
 	{0, }
