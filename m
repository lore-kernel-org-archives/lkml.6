Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1459510-1523022145-2-8116817662567270745
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523022145; b=lITDP3/Kd6gk9917lBQLMitfBx5PN9PanCe5SqeQEHXFewuEds
    HjZ+cSp63Zg8mA19c6prc+fNDHcUj4OC4BYFpodMkjlWJmb2j8241wBjNHYt5qp0
    eT5fWIBkBWiGBbl81PTGcZA8eW73dqjfjqphuYHMSQCAknUyUxyLptTBTqpRP+uD
    OIiP2LBWiQ1lztsmWth4RllIg6dcVVqiSy57HQRk+3ryMHhnY3DujrCA3Dz8PV+R
    LqpcRc4lO2hEdlF+bY9bD7uXQqv1jhzTcdDTSHWVmeVVfDZGVMb8aN/svvtTlZE2
    8nwxLb2QL9IeljQqzLXDpAJ1c40LOBFUV6zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523022145; bh=crvPUYHtJsvy7JiSToN2/W0y9jL57d
    dRWCUVs8fxEf4=; b=RVBzgKOH7HDgTRVOOcheduNEIUhN2x8hm02ow8Dq7W3Ild
    WdLgcvf7GRpAP/DA5RRrGinS4eIj37NKCFw8R8p0a/x8cgzbb7LTHNOOErwjaZ4G
    eiWpIyi8ft3zWQGJACLeK8R0mqr84ARCR3fJ3LZCNNAzn5PzBwFyTQpW9lcuS2XZ
    fd06bLOtkO86QDwRSH3vD2DKyCu/+3UZMRpCCwjCUPO0pLMJfRMDbEW0qPuHZ8pw
    i3fEwqOf/Ih2TW4fweU04aw1Vk9oMPmXMSlwMIM6fu0bi43fs0NEggCJ1dmium0i
    uIz4UUvyiHsEtBMAWSzSsZ01s+HvPXIlP43WRU3A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKXlIf/8TYSo3ZoLK1DudTAuoODoToso00CWPAFxC2SlpIjpiNCr72ErgU/l2R6CdobcVXyEIX5AcOogq8myYctVvX3I/vVavrlHVD3VZW4u54xtv8i3
    TO3q25RJ9gB2qAYt736F3+U6yG0YVkqBiuSNMhwxpwvrh4JTdrpusisa2TVCvbctH3BL5kT9psDnlOGbHSAMdse0VOs5FBoLj9usxorDlCAV1tSm9GpGH2xF
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=xLcVsCfpAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=rspm2b3yuRhifnkBGqYA:9
    a=QEXdDO2ut3YA:10 a=4-ZGFxpmiTxXQSWJmrgh:22 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756540AbeDFNmW (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 09:42:22 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36904 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752827AbeDFNmT (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 6 Apr 2018 09:42:19 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Major Hayden <major@mhtx.net>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.15 41/72] USB: serial: ftdi_sio: add RT Systems VX-8 cable
Date: Fri,  6 Apr 2018 15:24:16 +0200
Message-Id: <20180406084352.545058977@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084349.367583460@linuxfoundation.org>
References: <20180406084349.367583460@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Major Hayden <major@mhtx.net>

commit 9608e5c0f079390473b484ef92334dfd3431bb89 upstream.

This patch adds a device ID for the RT Systems cable used to
program Yaesu VX-8R/VX-8DR handheld radios. It uses the main
FTDI VID instead of the common RT Systems VID.

Signed-off-by: Major Hayden <major@mhtx.net>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/ftdi_sio.c     |    1 +
 drivers/usb/serial/ftdi_sio_ids.h |    3 +++
 2 files changed, 4 insertions(+)

--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -769,6 +769,7 @@ static const struct usb_device_id id_tab
 		.driver_info = (kernel_ulong_t)&ftdi_NDI_device_quirk },
 	{ USB_DEVICE(TELLDUS_VID, TELLDUS_TELLSTICK_PID) },
 	{ USB_DEVICE(NOVITUS_VID, NOVITUS_BONO_E_PID) },
+	{ USB_DEVICE(FTDI_VID, RTSYSTEMS_USB_VX8_PID) },
 	{ USB_DEVICE(RTSYSTEMS_VID, RTSYSTEMS_USB_S03_PID) },
 	{ USB_DEVICE(RTSYSTEMS_VID, RTSYSTEMS_USB_59_PID) },
 	{ USB_DEVICE(RTSYSTEMS_VID, RTSYSTEMS_USB_57A_PID) },
--- a/drivers/usb/serial/ftdi_sio_ids.h
+++ b/drivers/usb/serial/ftdi_sio_ids.h
@@ -923,6 +923,9 @@
 /*
  * RT Systems programming cables for various ham radios
  */
+/* This device uses the VID of FTDI */
+#define RTSYSTEMS_USB_VX8_PID   0x9e50  /* USB-VX8 USB to 7 pin modular plug for Yaesu VX-8 radio */
+
 #define RTSYSTEMS_VID		0x2100	/* Vendor ID */
 #define RTSYSTEMS_USB_S03_PID	0x9001	/* RTS-03 USB to Serial Adapter */
 #define RTSYSTEMS_USB_59_PID	0x9e50	/* USB-59 USB to 8 pin plug */
