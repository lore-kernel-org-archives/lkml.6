Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2943005-1517591759-2-5672951799507674039
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517591758; b=ol+b+N5bkOAHhTD8wr58+QhG4ToDsoSN+Yn6DrPGc5oGPSg
    BIteaoD6s9gmDruEYMqyEq2lBEdbb5CPTp822PUFvbqlvMlvt6jKQ6nRWvG2+84S
    /WBiA1LLYejNlpQHsYivhFVj7oiXvArnOWRDD0VCqU6i37X1WfN3+E8nSJExMbSz
    HtegQlrgn0UTJxaj5Yll1BRnAisq1WexxPdIZ+WMUboiT/MuUhxbtswNOzlFtsJB
    QcP9VGO1n49t3GrH1h1ICTgxW47EZ0F3QEEsJTapSO77hCBaqUadCHVhJTpc95LX
    YVtoPUp5oD/KBvkN/eOsjsxe9wgR1EP/6zO0EXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517591758; bh=XP0PnDFILi3LYD9u8boj5U/oNN
    MEk6JhOdK+rCdGHTQ=; b=EV8VZUbhxlmWSWfm7q9jtNUlAi/KlHhb2ksg+ZaiRI
    LfGVtP8vBmkYXvvRsFFkQud65Mj7UGtRoLUyG9/MDdL2svvWMArI//YdauUvUpcJ
    nkKzAILC2c18kNOpfZzo+W7cIjjB8KJmDiFv5hJkSgjwApFb87bx2l85wtzJSm0c
    f6ttvXMusOaxlq7foNdcx902dBs1GWBveVTmJS6P85I8vW8jZr/Y3ANeYAueBFbl
    5ZL++0LH0c3Nm+7rHZMhcAXVazhfoYVLll8dphPPBCAl5zvsdPwabyNku8Vg312M
    +y5uco/B94Xss1DisbLxwE8wS+ghHUUQfh86nbm1kEFA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753791AbeBBRP4 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:15:56 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:40854 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753608AbeBBRPt (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:15:49 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Yoshiaki Okamoto <yokamoto@allied-telesis.co.jp>,
        Hiroyuki Yamamoto <hyamamo@allied-telesis.co.jp>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.15 31/55] usb: option: Add support for FS040U modem
Date: Fri,  2 Feb 2018 17:58:49 +0100
Message-Id: <20180202140829.324952675@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140826.117602411@linuxfoundation.org>
References: <20180202140826.117602411@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: OKAMOTO Yoshiaki <yokamoto@allied-telesis.co.jp>

commit 69341bd15018da0a662847e210f9b2380c71e623 upstream.

FS040U modem is manufactured by omega, and sold by Fujisoft. This patch
adds ID of the modem to use option1 driver. Interface 3 is used as
qmi_wwan, so the interface is ignored.

Signed-off-by: Yoshiaki Okamoto <yokamoto@allied-telesis.co.jp>
Signed-off-by: Hiroyuki Yamamoto <hyamamo@allied-telesis.co.jp>
Acked-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/option.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -380,6 +380,9 @@ static void option_instat_callback(struc
 #define FOUR_G_SYSTEMS_PRODUCT_W14		0x9603
 #define FOUR_G_SYSTEMS_PRODUCT_W100		0x9b01
 
+/* Fujisoft products */
+#define FUJISOFT_PRODUCT_FS040U			0x9b02
+
 /* iBall 3.5G connect wireless modem */
 #define IBALL_3_5G_CONNECT			0x9605
 
@@ -1894,6 +1897,8 @@ static const struct usb_device_id option
 	{ USB_DEVICE(LONGCHEER_VENDOR_ID, FOUR_G_SYSTEMS_PRODUCT_W100),
 	  .driver_info = (kernel_ulong_t)&four_g_w100_blacklist
 	},
+	{USB_DEVICE(LONGCHEER_VENDOR_ID, FUJISOFT_PRODUCT_FS040U),
+	 .driver_info = (kernel_ulong_t)&net_intf3_blacklist},
 	{ USB_DEVICE_INTERFACE_CLASS(LONGCHEER_VENDOR_ID, SPEEDUP_PRODUCT_SU9800, 0xff) },
 	{ USB_DEVICE_INTERFACE_CLASS(LONGCHEER_VENDOR_ID, 0x9801, 0xff),
 	  .driver_info = (kernel_ulong_t)&net_intf3_blacklist },
