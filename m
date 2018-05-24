Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1874556-1527162272-3-25297625427579513
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527162272; b=CKkybpNJgryO7rIWwox+QrpXQgrYV6JjddUUf10dDW1mvRLQbj
    5i21McHRz14i1RXzGK03ekb8tOpgWRnL2jRWH2v/odIvmFo/aSwJArDgBV2YfeA3
    p013nrx4NvL5qp6Hz+4jNzpHgNTaClyZUImXwbkc8+gNl2kYj1XvYQqSrz9+fsP8
    Ns8ttl99B8LNqKPxa8GUYcBCSW+7G0TRuW0U57L5jIYyU2yLkG9hnNlEn5kffWjU
    TRIDMpl6mTyR0euQaQS+8aV5FosJYNLXjz9DQ6qXoRq5a/e68SYRuLLY+h2UixDp
    a2tPPYAbNBCGmMmyPsbjUio0tSfnva5EQvSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527162272; bh=hsSJEVrH2gbv5v1WrLQSSGTXyA+NIY
    CZTwxe3ubVxwA=; b=dlH4u1OMAsLyybYK08eF4o+DzpHueJ6IzrYBKxxJdSzjmn
    Kw+DpGsx9jdkiRGLCM+NLJtEOlKXdnN/R7YCs48LJ5AQedxOlV29Rmlq1dRolkK0
    V01S4ojqrIYBCK/GRZTUAWO//9kmrsp0kPGKT+Ir7jtc23ZMrVyeM8hIuXwY7o5y
    IB8x5Irs2cgLRcpbgmJxslw3GTkEriAuJNokGw1/bvfaCqpjv+xh+Cgzr8jmG3gj
    ueM+1XEWxqHmP9TQRzQSl2Cg2LBrHwFmlCiJ3AzKaCely+zXCoI1+EWSecH2MOnb
    cP3lKj/FaQwhzQcx4PIpvOm3Mi9ELm7v5GXi56Lg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=NKP9AaQ9 x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=NKP9AaQ9 x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBERtFdBN6M0CuqlZenBUV6U/0MzIBIR6L7+OCo2q4r1/H4TbiH2PaK7cK3KciUOLBAVnsVbW7NbXYbyEKkPoiC+2pP+aeUrsvX3nOpnP0G/RtJrXuob
    9vx5vb2zxp0xNUEmGpa/9H4lelDqHtf5wYGjsRgcebjTpzEbXB9lV0M7wL5z9/gQvsVgwn/78v7AG8StGCy+s95YcPSGdUgtKM5pgjwNmh4FUqm0RnIXDxI+
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=pGLkceISAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=u-AzxMXRe4DiE4IcPcUA:9
    a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969237AbeEXLni (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:43:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:33450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967191AbeEXJsQ (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:48:16 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nobutaka Okabe <nob77413@gmail.com>,
        Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 35/96] ALSA: usb-audio: Add native DSD support for Luxman DA-06
Date: Thu, 24 May 2018 11:38:18 +0200
Message-Id: <20180524093607.586426661@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093605.602125311@linuxfoundation.org>
References: <20180524093605.602125311@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nobutaka Okabe <nob77413@gmail.com>

[ Upstream commit 71426535f49fe6034d0e0db77608b91a0c1a022d ]

Add native DSD support quirk for Luxman DA-06 DAC, by adding the
PID/VID 1852:5065.

Rename "is_marantz_denon_dac()" function to "is_itf_usb_dsd_2alts_dac()"
to cover broader device family sharing the same USB audio
implementation(*).
For the same reason, rename "is_teac_dsd_dac()" function to
"is_itf_usb_dsd_3alts_dac()".

(*)
These devices have the same USB controller "ITF-USB DSD", supplied by
INTERFACE Co., Ltd.
"ITF-USB DSD" USB controller has two patterns,

Pattern 1. (2 altsets version)
- Altset 0: for control
- Altset 1: for stream (S32)
- Altset 2: for stream (S32, DSD_U32)

Pattern 2. (3 altsets version)
- Altset 0: for control
- Altset 1: for stream (S16)
- Altset 2: for stream (S32)
- Altset 3: for stream (S32, DSD_U32)

"is_itf_usb_dsd_2alts_dac()" returns true, if the DAC has "Pattern 1"
USB controller, and "is_itf_usb_dsd_3alts_dac()" returns true, if
"Pattern2".

Signed-off-by: Nobutaka Okabe <nob77413@gmail.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/usb/quirks.c |   29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1153,24 +1153,27 @@ bool snd_usb_get_sample_rate_quirk(struc
 	return false;
 }
 
-/* Marantz/Denon USB DACs need a vendor cmd to switch
+/* ITF-USB DSD based DACs need a vendor cmd to switch
  * between PCM and native DSD mode
+ * (2 altsets version)
  */
-static bool is_marantz_denon_dac(unsigned int id)
+static bool is_itf_usb_dsd_2alts_dac(unsigned int id)
 {
 	switch (id) {
 	case USB_ID(0x154e, 0x1003): /* Denon DA-300USB */
 	case USB_ID(0x154e, 0x3005): /* Marantz HD-DAC1 */
 	case USB_ID(0x154e, 0x3006): /* Marantz SA-14S1 */
+	case USB_ID(0x1852, 0x5065): /* Luxman DA-06 */
 		return true;
 	}
 	return false;
 }
 
-/* TEAC UD-501/UD-503/NT-503 USB DACs need a vendor cmd to switch
- * between PCM/DOP and native DSD mode
+/* ITF-USB DSD based DACs need a vendor cmd to switch
+ * between PCM and native DSD mode
+ * (3 altsets version)
  */
-static bool is_teac_dsd_dac(unsigned int id)
+static bool is_itf_usb_dsd_3alts_dac(unsigned int id)
 {
 	switch (id) {
 	case USB_ID(0x0644, 0x8043): /* TEAC UD-501/UD-503/NT-503 */
@@ -1187,7 +1190,7 @@ int snd_usb_select_mode_quirk(struct snd
 	struct usb_device *dev = subs->dev;
 	int err;
 
-	if (is_marantz_denon_dac(subs->stream->chip->usb_id)) {
+	if (is_itf_usb_dsd_2alts_dac(subs->stream->chip->usb_id)) {
 		/* First switch to alt set 0, otherwise the mode switch cmd
 		 * will not be accepted by the DAC
 		 */
@@ -1208,7 +1211,7 @@ int snd_usb_select_mode_quirk(struct snd
 			break;
 		}
 		mdelay(20);
-	} else if (is_teac_dsd_dac(subs->stream->chip->usb_id)) {
+	} else if (is_itf_usb_dsd_3alts_dac(subs->stream->chip->usb_id)) {
 		/* Vendor mode switch cmd is required. */
 		switch (fmt->altsetting) {
 		case 3: /* DSD mode (DSD_U32) requested */
@@ -1304,10 +1307,10 @@ void snd_usb_ctl_msg_quirk(struct usb_de
 	    (requesttype & USB_TYPE_MASK) == USB_TYPE_CLASS)
 		mdelay(20);
 
-	/* Marantz/Denon devices with USB DAC functionality need a delay
+	/* ITF-USB DSD based DACs functionality need a delay
 	 * after each class compliant request
 	 */
-	if (is_marantz_denon_dac(chip->usb_id)
+	if (is_itf_usb_dsd_2alts_dac(chip->usb_id)
 	    && (requesttype & USB_TYPE_MASK) == USB_TYPE_CLASS)
 		mdelay(20);
 
@@ -1371,14 +1374,14 @@ u64 snd_usb_interface_dsd_format_quirks(
 		break;
 	}
 
-	/* Denon/Marantz devices with USB DAC functionality */
-	if (is_marantz_denon_dac(chip->usb_id)) {
+	/* ITF-USB DSD based DACs (2 altsets version) */
+	if (is_itf_usb_dsd_2alts_dac(chip->usb_id)) {
 		if (fp->altsetting == 2)
 			return SNDRV_PCM_FMTBIT_DSD_U32_BE;
 	}
 
-	/* TEAC devices with USB DAC functionality */
-	if (is_teac_dsd_dac(chip->usb_id)) {
+	/* ITF-USB DSD based DACs (3 altsets version) */
+	if (is_itf_usb_dsd_3alts_dac(chip->usb_id)) {
 		if (fp->altsetting == 3)
 			return SNDRV_PCM_FMTBIT_DSD_U32_BE;
 	}
