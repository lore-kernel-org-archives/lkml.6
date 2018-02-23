Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsDNK58RXfb5lqwfSoy75EDkH+lCcsApoSu8lz7zoaT5Q6iMKpv8yFpYSfKGmapNLuUJyKV
ARC-Seal: i=1; a=rsa-sha256; t=1519412221; cv=none;
        d=google.com; s=arc-20160816;
        b=Wj8fsaaB5RKJnJ6fJQhKe0BC39OV8fhVDpFY+K/syegMnIgSQTgj+4W+XYyUaYfNwF
         j1lPEC0Eap5gcosG0fUeIUnoZ5QliHV5eGdL3z7z9e2unATT1uoYPAM7ZlAMkzS3x0sU
         COVDPHx2QAI6DZYC7Xdo5NrYdyC5aKwlYoPrL7Y6Xre2cYDngMmDXIZ/OVHqunW3nTdJ
         8lyowrbngKeI0we7cC36a1sRVuxnRM6R7rCS/LohxTriuKRXYyBJewZ8HEjeVvk/L04I
         mpoGwP2BkqP8kQxOaWuDoe3CDbrX+Mwh8IzhBTzBQXOgAFIRbgPKSK4/hDmicUilhr2R
         11ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=1qDqT7Dv7ZMAlxU76yNdvTtik2CAanM38KgH5QZoseM=;
        b=MgncaADtFaayU9+h0kolyvBkBee7lwm5hc1cQlu6tBOVJZgNGDaxaJy5Yf7cPFOzyQ
         RBmGx1O+jFWN8SP8dBq/23vv9QDXCUpSZr0YhQlqy+/P3Rh9jNA2gBR3qfuk5WFUiObf
         OjmXeMQzd/ybOvrW9j/N2wkwFmivhWUb6B5S7UQkXRGHBqBkeThs05TIt5O8DJx0urA+
         OjT2cbdxZhBa+zTu6RhkXlCcS8T1nGVD5NKTk8RmCLGlOHY0wpRoODX43YoS3czV4ryb
         mCqO/FhJ6y3iYeNSUSpNrCFRAYTGaxprIf3EkrlrGljFbKR92pIZ2fyDjpbMgkX5uoZZ
         3o8Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH 4.14 157/159] mei: me: add cannon point device ids
Date: Fri, 23 Feb 2018 19:27:45 +0100
Message-Id: <20180223170801.946329146@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593219189171382911?=
X-GMAIL-MSGID: =?utf-8?q?1593219189171382911?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Usyskin <alexander.usyskin@intel.com>

commit f8f4aa68a8ae98ed79c8fee3488c38a2f5d2de8c upstream.

Add CNP LP and CNP H device ids for cannon lake
and coffee lake platforms.

Cc: <stable@vger.kernel.org> 4.14+
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/misc/mei/hw-me-regs.h |    3 +++
 drivers/misc/mei/pci-me.c     |    3 +++
 2 files changed, 6 insertions(+)

--- a/drivers/misc/mei/hw-me-regs.h
+++ b/drivers/misc/mei/hw-me-regs.h
@@ -132,6 +132,9 @@
 #define MEI_DEV_ID_KBP        0xA2BA  /* Kaby Point */
 #define MEI_DEV_ID_KBP_2      0xA2BB  /* Kaby Point 2 */
 
+#define MEI_DEV_ID_CNP_LP     0x9DE0  /* Cannon Point LP */
+#define MEI_DEV_ID_CNP_H      0xA360  /* Cannon Point H */
+
 /*
  * MEI HW Section
  */
--- a/drivers/misc/mei/pci-me.c
+++ b/drivers/misc/mei/pci-me.c
@@ -98,6 +98,9 @@ static const struct pci_device_id mei_me
 	{MEI_PCI_DEVICE(MEI_DEV_ID_KBP, MEI_ME_PCH8_CFG)},
 	{MEI_PCI_DEVICE(MEI_DEV_ID_KBP_2, MEI_ME_PCH8_CFG)},
 
+	{MEI_PCI_DEVICE(MEI_DEV_ID_CNP_LP, MEI_ME_PCH8_CFG)},
+	{MEI_PCI_DEVICE(MEI_DEV_ID_CNP_H, MEI_ME_PCH8_CFG)},
+
 	/* required last entry */
 	{0, }
 };
