Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZp6SmX2Y/amERgWlwrqb7dJ7U/fQtnnshPqSX+h/cwWOtBy3rTneV/k0Plig7okTJ2rprc5
ARC-Seal: i=1; a=rsa-sha256; t=1525116378; cv=none;
        d=google.com; s=arc-20160816;
        b=jN8i2tOpB4Mh0fNUEA6cB0Uc+Tx0KnC6Z83VmYG+MwsRl1qZW5Fj92BQnnNueI/orB
         b1sr1Dz2IorR2LOm1VDtjx/sEw6nEOu/7aDD6FYcfP5KdfUKoz5jNRXt6uXenDmhcmax
         u0yfAXQCN1Jk9yDIfBi1P3dOATuKrN0LH/tc/4K7LUZFQZKbUDb7bA9nAGFbb9R1PQ/u
         Om8vncgcGPucZ4ui+4iIumwLMMWjo8jUSNDdQ91cQq+qf+8VRrvWWfBGo8EiFN9Q2Zyf
         tSQE6Ywhy1Dzewg2Is5DqD2UklNKoW1XoD3SOTHkvtolpsQ8fOntrxUkba35fcJ20sAx
         ra5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=+pOqLtZhCsank5jYmVLDCM8CaXM0AN2dxbJYaq7MkyU=;
        b=YypSUqlDyPBZAyE6SYyVBuOqmNva/PICrD6xwfLm55UQWG2U2Ji4ngAFze8iswcYyo
         OKpWQIP9VdX57H+zAjTmJUlSL3bPJKrBLAWCiGTq+igQ3Flb6NepdHKnh2M85l7D2Cbs
         lD1Ac5b8ttfRAqhI2h5opLodbEAeN05q+xEertLpbl2OPRbSi7TACzfL/sEyFa3hPf3Q
         2T6Wnk+w43M6aV0+T1lx7dGNn2GzDcXLa1OpaAH2e0UnHrOQLv3Xmqf+Atlu0ZYE4nVi
         qPTOBZoszpNh7PeOS7aAcAy2h2Y28pTZB+MIAPKC3fmPuzRbXscoVs8ey7v/zyTqotiW
         RZbg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35D5A22DAC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Kamil Lulko <kamilx.lulko@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [PATCH 4.9 14/61] usb: core: Add quirk for HP v222w 16GB Mini
Date: Mon, 30 Apr 2018 12:24:17 -0700
Message-Id: <20180430183952.437495553@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430183951.312721450@linuxfoundation.org>
References: <20180430183951.312721450@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200291962669964?=
X-GMAIL-MSGID: =?utf-8?q?1599200432071704445?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
 
