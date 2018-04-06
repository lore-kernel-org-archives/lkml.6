Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1491530-1523022561-3-4007342519152479312
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523022561; b=HBK30oNm5Qi1zWUTDPuFpGA0NOioa9Yb5hE/+WaJWLxx1/mJfI
    3rGS95UrEj8XHTKmADpiPPaMZCB6SSaGrQ3V3ZVn9UQC6UFqNZ//l3uIvsqYQWzq
    Syiwp1K9SfhWznuhQeRsEoBLMhjIIsV0FWWWQG6YSd5ozu7WzVYbA/s4+2Gz4/7M
    rtmUlzv6ukD1DqxWPBVQuOA/IU47Ej/nPUeKMFY9iywE064mE1CCjL/uab0LOzD2
    7GdKFsS13E4EAzjRdDWHbLEqTpfoKU0GXf/EK7LhMQhoO9HoVUMwNvvh61sAM3Vd
    AJNyIO6PwHQQAUe+eCSKJ98/eAfkl5UWWjMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523022561; bh=+HasVumDdipSscMXxj7pTAsj1eoOlD
    563F0KMzi+UsU=; b=qrsrXC5EKbwWvYfRwXeXfWdlU+ebfp/XNpIjGVK2boQoCa
    mZkDwgoFCzdzGI1uyXbvBveuXqSPRD6W1sR/o/dVYixyPfrm8IDWzSovISHcZLI0
    uu/xPpK1qPOnorKpOfQzFMa0Eqy9CUL1TgkDmIpH1ST5PV8k3/gBjTDrQvu7ZJwC
    CFeeCgnyi9zrSz+u5Si8W20nySkiO5v0hUO8p6snl0l1unLdN2U/AkamV3kVSA2X
    07c+m8ShvHRHz8qEwJak5B23dEn842V4IASzygmrimyt8GqxWjKkhCuBFfUPxDzJ
    9eMwNLYmYus9O1/PlJr10TfDJVWFu/sZg8un0ChA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfHazwrbvMkQ3cUKiWRTz8h7HBAJ/n1HLXFF3ZFk2REdlBQ8eIfL3Sk2Df0LQxvjYhtFRPSqJieYytcrZlvdkLjwEWg59yeZcsCXPAfViDkxvGCtV/Zgd
    /mAiKwTmvsN6hTzPAvC/0TgyCZ8ScCqu+DGrNuAVqrMdn8RI2BkUUJJ/MDkfv5kCk59B1EScfbpJH7Qk1JW/OYXg628nQ3Uzqg8wrk3GsZYDiVFI16y2G0wS
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=7ZN4cI0QAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=ag1SF4gXAAAA:8
    a=NvoEgiLvZTmWR0OFwL8A:9 a=QEXdDO2ut3YA:10 a=Dl0WHwQvj8hGZljrFLtM:22
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932996AbeDFNpI (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 09:45:08 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37994 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933027AbeDFNpH (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 6 Apr 2018 09:45:07 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Dennis Wassenberg <dennis.wassenberg@secunet.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.16 27/31] Input: i8042 - add Lenovo ThinkPad L460 to i8042 reset list
Date: Fri,  6 Apr 2018 15:24:52 +0200
Message-Id: <20180406084344.674946378@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084340.999820380@linuxfoundation.org>
References: <20180406084340.999820380@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dennis Wassenberg <dennis.wassenberg@secunet.com>

commit b56af54ac78c54a519d82813836f305d7f76ef27 upstream.

Reset i8042 before probing because of insufficient BIOS initialisation of
the i8042 serial controller. This makes Synaptics touchpad detection
possible. Without resetting the Synaptics touchpad is not detected because
there are always NACK messages from AUX port.

Signed-off-by: Dennis Wassenberg <dennis.wassenberg@secunet.com>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/serio/i8042-x86ia64io.h |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -621,6 +621,13 @@ static const struct dmi_system_id __init
 		},
 	},
 	{
+		/* Lenovo ThinkPad L460 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad L460"),
+		},
+	},
+	{
 		/* Clevo P650RS, 650RP6, Sager NP8152-S, and others */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
