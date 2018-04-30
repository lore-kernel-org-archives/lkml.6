Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZomgJHj+RwPQmQgNnC8Bj1uwZ3MUXBWPulPf/bvjBi9JFMh22wUgrKhVsGcLQXlDV05bC2C
ARC-Seal: i=1; a=rsa-sha256; t=1525116344; cv=none;
        d=google.com; s=arc-20160816;
        b=Hho4GjxPU8K2djwPOSRHA5EiV83GeV9aaJ4DIzRK5GsdaPNyP5LwgRu07ZaXXDDfam
         ySuG5fz2fgsjlyM4ADlNkDpXQCZobb8JwhfSOYE+uuZYrW3akca8FbltTsoykKk4B6Fh
         mL8BR0mixojWDbSPLuI3BHrbXqoVqs9kvEHce8Kb8VXVzoo/9LBX0VobAtNcLo7+XTec
         FoMw76YNPsGwScLqb0zNzW8C5vLZbyS2KrQjHwzmfiMM5PrB4LWNobZ+JqCXlrp9B4Eq
         sKbNFYQDqTMYfDsdUQaWKS2hMFF4B5eClgO7B//6iyjgt0wXqfWufNanHx0XyVqAu71F
         Toug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=NQfyMVLqSDBw72Xjg5LU78RtlcTxK27W50rWUBeywKw=;
        b=LVWdmQh5TtE9tLbMUwzJ2gCy3J1/tYI2JNONpPFw2K4534pdNY6rSii+C6HEt44m35
         vGedZBncz/6OvcvObpXrDkUNVoYW5EHB1A9wEHTiN67mmcb4L28FhxNJYGsDYXLzSlFf
         8kId87jIlWY/K41Gs4F/8+m6zSZEoFdn7nyJBmqWcTwm2IbTDpPM5JSZ5pT2zOMMsm8t
         Q/Sb0xsLTcQaA8CynHGOJJylbknhimQifPdY2YaKUbHV74J3cov+jLEE322cNX/nbfqJ
         CBJAnfKTkEUC6Hmv4in982mRINn2x5XWaS8oH4n5XskQr2Gv+wyR9h5hMsB8bCiU1KKe
         7MBQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 785D622DAC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Kamil Lulko <kamilx.lulko@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [PATCH 4.4 10/44] usb: core: Add quirk for HP v222w 16GB Mini
Date: Mon, 30 Apr 2018 12:24:21 -0700
Message-Id: <20180430190946.752230461@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430190946.093694747@linuxfoundation.org>
References: <20180430190946.093694747@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200291962669964?=
X-GMAIL-MSGID: =?utf-8?q?1599200396830388578?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kamil Lulko <kamilx.lulko@intel.com>

commit 3180dabe08e3653bf0a838553905d88f3773f29c upstream.

Add DELAY_INIT quirk to fix the following problem with HP
v222w 16GB Mini:

usb 1-3: unable to read config index 0 descriptor/start: -110
usb 1-3: can't read configurations, error -110
usb 1-3: can't set config #1, error -110

Signed-off-by: Kamil Lulko <kamilx.lulko@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/core/quirks.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -45,6 +45,9 @@ static const struct usb_device_id usb_qu
 	{ USB_DEVICE(0x03f0, 0x0701), .driver_info =
 			USB_QUIRK_STRING_FETCH_255 },
 
+	/* HP v222w 16GB Mini USB Drive */
+	{ USB_DEVICE(0x03f0, 0x3f40), .driver_info = USB_QUIRK_DELAY_INIT },
+
 	/* Creative SB Audigy 2 NX */
 	{ USB_DEVICE(0x041e, 0x3020), .driver_info = USB_QUIRK_RESET_RESUME },
 
