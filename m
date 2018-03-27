Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/DiOa+9fSyA0+BVOntaXQSamGBpMJxWVXCZ+cuKlNiW2wqB9/Bl8/POUJ1vbiPzyU3/tf4
ARC-Seal: i=1; a=rsa-sha256; t=1522168497; cv=none;
        d=google.com; s=arc-20160816;
        b=aUHR5QuELUFZj98zhBcVk/aOYWvJpRjvgbX5X4nXgxbMwMdOpcsbcGtktje4exhXFE
         GQoxx1VicY9U+rc2Sba/T55uvJWzgH5SPSSSxMB8jl1vgd/uxoZ3P9u6bwv1I0Wo0mjB
         Va/Q8H2JY4O4K9t4j0lqFDfakEZNdRESLW/0O5L9hqSMQjLTULkZ9w+VTc0clLGEwtZY
         cU4jyKparSahYwm796fVHw9s7PQiK4EsYutG9X1tiviKHwqpS4yh5g2k9K8gYU5T6qg2
         ddwExZbYh6GcpiiWn/4YQogmJvrqDLCXqPn5QprrOErdR/hDqBt0gIZw3Fw74mKxVZdm
         WOug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=nGlvzYiERU4QcX/kAcBTCSrIVJKXb1B3po2mQXB66/E=;
        b=Uwc68r6LoaMQM7jGESEMvseFwhfeTZTiaf/CxZ8jUrb/mm2BKzl84Qv3w1WP/g4KG4
         EiC1pRmpXiCWC1+6YBRi1yaESlf0iyVoxXlU8WFJBUPfQOFY626vAXLr8gxsBon41suv
         dB21EvvGagYvjUvn3ixG5Izj2PJHUpDeVjdlwDZJLAmLodNmTF7VFqz1H2QnIr/o7kK0
         idTtEpeYmCZ7/tAeqiKDlZfpIGkJE5uqKPS0+W0esUI/ruWU2OH5W7TeQp/mWwvkE0FR
         fJd42Q1Va98fSc4Ba87hT3oNZNLmUTcF88TMhO7sDImQAKxIXS0bkV6Ugj4C3zHBWNja
         z4Bg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH 4.14 032/101] Bluetooth: btusb: Add Dell OptiPlex 3060 to btusb_needs_reset_resume_table
Date: Tue, 27 Mar 2018 18:27:04 +0200
Message-Id: <20180327162751.957017204@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109354675323902?=
X-GMAIL-MSGID: =?utf-8?q?1596109354675323902?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

commit 0c6e526646c04ce31d4aaa280ed2237dd1cd774c upstream.

The issue can be reproduced before commit fd865802c66b ("Bluetooth:
btusb: fix QCA Rome suspend/resume") gets introduced, so the reset
resume quirk is still needed for this system.

T:  Bus=01 Lev=01 Prnt=01 Port=13 Cnt=01 Dev#=  4 Spd=12  MxCh= 0
D:  Ver= 2.01 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0cf3 ProdID=e007 Rev=00.01
C:  #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb

Cc: stable@vger.kernel.org
Cc: Brian Norris <briannorris@chromium.org>
Cc: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/bluetooth/btusb.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -387,6 +387,13 @@ static const struct usb_device_id blackl
  * the module itself. So we use a DMI list to match known broken platforms.
  */
 static const struct dmi_system_id btusb_needs_reset_resume_table[] = {
+	{
+		/* Dell OptiPlex 3060 (QCA ROME device 0cf3:e007) */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex 3060"),
+		},
+	},
 	{}
 };
 
