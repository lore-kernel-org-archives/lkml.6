Return-Path: <chunfeng.yun@mediatek.com>
X-Google-Smtp-Source: AB8JxZpjKnLAiV+boJB1dDdzP8gPUuccxcCzqJ0gGW4Gh7C84V0Xuc0cBUZb6wEkhfDvXUoXOG6x
ARC-Seal: i=1; a=rsa-sha256; t=1527065656; cv=none;
        d=google.com; s=arc-20160816;
        b=BHpLgarOP4YvUVe+UXm4ljrEPb1KXguGswWKnMkh8f444qk5wTGyq0HL15QO6zQyQp
         r0Qnus19KMyt+o2TpzWE1sIgOsMKWdbADvGcDox0mNcCLW/jMCyrKZg7xx2r29SzZSFA
         l46ULMmuN8Or/qOLdas/WGPEEZE9ohWwlRey3dWUW7nQCPZ/vmXDMO2gDonC8SZg7xeA
         Lt7eZ/NY51gKluzrjONwV/ZsZpva/t7Sw5inKptfg+Pw/G/4x/rDmjLNBW5El1e7e9Hb
         Ry1feUEQnWXNzWOZ4nf6lQXbxkwgUEKMGCAkf9ls4EODYKYEGDynrehHn7b14nMmumvL
         Yvhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:arc-authentication-results;
        bh=I/9WFf1rBDO4RkBWdWKdkdjOxMR9wnURG7dIy9uLS6Y=;
        b=lW4IrYR7OxgPrbCduR3bbip8InzFwMfsPaYUCe7C7gHOXsxdMZLF+AYeXYyOapro9p
         aeLXn5xPYR/KI22E4quVJNpK2b9dHa8AConvF92VBB32vcnWbFU6FW6hbJfM+KYXx3km
         65cbh05X4NtGtAuLU483/VOw57a3fNDcc0LNUaWWgIbq3MdaRnnFSJQ95A5oPPn/rDe6
         oZ6o4lN8bq8SLtD2B6PAeFEC+14Ya1BIdR3N8rmmcSaNEgTJfPoEtKBdl4RHcfANs7d1
         sdG+9q7ehMurpW3qbVG/1Sy6B09hCqG5RIJibuvjmnkN4paFw7hmBUnC+/fnurrsXCrM
         v9Nw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of chunfeng.yun@mediatek.com designates 1.203.163.78 as permitted sender) smtp.mailfrom=chunfeng.yun@mediatek.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of chunfeng.yun@mediatek.com designates 1.203.163.78 as permitted sender) smtp.mailfrom=chunfeng.yun@mediatek.com
X-UUID: 7cd3d092791947ea9808884e56cc82eb-20180523
From: Chunfeng Yun <chunfeng.yun@mediatek.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Felipe Balbi
	<felipe.balbi@linux.intel.com>
CC: Matthias Brugger <matthias.bgg@gmail.com>, Chunfeng Yun
	<chunfeng.yun@mediatek.com>, <linux-usb@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
Subject: [next, PATCH 3/6] usb: mtu3: clear test_mode flag when reset
Date: Wed, 23 May 2018 16:53:17 +0800
Message-ID: <613f22070f3f5be49a4405e53032da485ef35e8c.1527065109.git.chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1291b13a362eaa0cccd30cb8dd4f56d33e1d172d.1527065109.git.chunfeng.yun@mediatek.com>
References: <1291b13a362eaa0cccd30cb8dd4f56d33e1d172d.1527065109.git.chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601244397645456789?=
X-GMAIL-MSGID: =?utf-8?q?1601244397645456789?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Clear test_mode flag when the gadget is reset by host, otherwise
will affect the next test item.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/mtu3_gadget.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/mtu3/mtu3_gadget.c b/drivers/usb/mtu3/mtu3_gadget.c
index de0de01..5c60a8c 100644
--- a/drivers/usb/mtu3/mtu3_gadget.c
+++ b/drivers/usb/mtu3/mtu3_gadget.c
@@ -719,4 +719,5 @@ void mtu3_gadget_reset(struct mtu3 *mtu)
 	mtu->u1_enable = 0;
 	mtu->u2_enable = 0;
 	mtu->delayed_status = false;
+	mtu->test_mode = false;
 }
-- 
1.9.1
