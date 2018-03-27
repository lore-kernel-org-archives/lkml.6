Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49MRY4C47PAmQgC8MAJ7gYz6vJ7sNKDHbg4+MKo77uMO+DoM8tboWe9lp7Mm2Oap6cM+F5i
ARC-Seal: i=1; a=rsa-sha256; t=1522168792; cv=none;
        d=google.com; s=arc-20160816;
        b=PYuunooWredYWNc1O4jYlcQpG6xf2I5Qx9k6xA8vdXFhXqRcNMDAi2ENAcF/HW9yRw
         Ma+/43uEXnS4D1foROQy28yefwmSdvIz0KjqOIqubi1pUcvrs/HFbdM5S4rVUfGA15Ru
         j2gaX73kpZISVrvZytGXRibRLOeu9Yrs5P569Gg1Ow5OHyM/woe9XeofaHReWRahDKOS
         4aD/iFwc/kSsPZgw7isUxpu1tB2084SWI1JFgxdKrBjS2Z2GkQt/56JnO0W4j7dfjneY
         l0sn4cvxUIFpxXb8l3jdphth9ugoZjwsFJUFWTpd9MpX0+rnx1FIasIncJwU93o7dWtA
         3LEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=66Knbh3dTpYfjcwJ3idCFQkA6Y5icg4jPv4Pz88Zb3E=;
        b=hddNAkghWYoFQc0+ZaZvLyd2flRAfK87M8J3GwPWtL7zKlJZlaiy4IoBkyv2GomKCD
         HunAQF7MJw9MOHcDUamwa6MmwfVZBu7IlclfccaIilPIgTxwPjz0WN/756C7aNK4Z94e
         SgVVIIxPgFAMbonqb5S6MKafPRZdcfzW9IaAYLbgCLXQ8xnysiH5qaRcw4CCg7HAVaio
         9rmkox0bjvp6rovi+ftEgdWEQKUPG1X+USwMswAjmq6LfGAARtTEnwB5hAoyKSquFzoN
         mwJ6e3JyKM//rb8gKfvZC5i0VXZ4JSmukEO8Zq+WXcxtZHjWLZnlf/o8XMo8sKqXl1Ww
         6aSg==
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
Subject: [PATCH 4.15 032/105] Bluetooth: btusb: Add Dell OptiPlex 3060 to btusb_needs_reset_resume_table
Date: Tue, 27 Mar 2018 18:27:12 +0200
Message-Id: <20180327162759.339580656@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109354675323902?=
X-GMAIL-MSGID: =?utf-8?q?1596109663396480299?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -382,6 +382,13 @@ static const struct usb_device_id blackl
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
 
