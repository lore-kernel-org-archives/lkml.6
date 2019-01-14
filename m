Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CDEEC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AD2B20656
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pados.hu header.i=@pados.hu header.b="usYSW0gf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfANMzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 07:55:46 -0500
Received: from erza.pados.hu ([176.9.136.194]:39010 "EHLO erza.pados.hu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726449AbfANMzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 07:55:46 -0500
X-Greylist: delayed 1534 seconds by postgrey-1.27 at vger.kernel.org; Mon, 14 Jan 2019 07:55:44 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pados.hu;
         s=february2016; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
        Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=rXbiEf79sJoWrz/kAiUQbcyFCnrDzGwpuOg3buNZrsE=; b=usYSW0gfDdcgT53AYroiC1TlVf
        06mJhCAQtxkj42lyu7IABEAzxTtbQTjuSZeswVNfw0rTMDR4LSnESny/O6r0UrShHvuGAIrYnzRDI
        NjkFQR2Q30eFTIPMM11iTkORfaCDxuqsULPzIQaFuSZRBFXRANEFqAQ+g63jXtJi/+SJdSSNFs2Cq
        SvXUaJUujP2yxbKPKPwC5alM/H9FhcOIiGrhRYGa6kXs2d7TOVkZeu5L146kP1jA56rWQDmIu5zRZ
        vmMj98r5B1PG5kJdbzpYYchZ7xave8UVHz4mrlzCcSq9nftvdxwGrx1N0CC/T+zRRJLkz9eHn+fDf
        jtjkwVDA==;
Received: from 188-143-5-0.pool.digikabel.hu ([188.143.5.0] helo=localhost)
        by erza with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <pados@pados.hu>)
        id 1gj1NX-00045P-WF; Mon, 14 Jan 2019 13:30:08 +0100
From:   Karoly Pados <pados@pados.hu>
To:     "Johan Hovold" <johan@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Loic Poulain" <loic.poulain@linaro.org>
Cc:     Karoly Pados <pados@pados.hu>
Subject: [PATCH] USB: serial: ftdi_sio: Fix GPIO not working in autosuspend
Date:   Mon, 14 Jan 2019 13:30:03 +0100
Message-Id: <20190114123003.8228-1-pados@pados.hu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam_score: -2.9
X-Spam_report: Spam detection software, running on the system "erza",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  There is a bug in the current GPIO code for ftdi_sio: it failed
    to take USB autosuspend into account. If the device is in autosuspend, calls
    to usb_control_msg() fail with -EHOSTUNREACH. Because the s [...] 
 Content analysis details:   (-2.9 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
  0.0 URIBL_BLOCKED          ADMINISTRATOR NOTICE: The query to URIBL was
                             blocked.  See
                             http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
                              for more information.
                             [URIs: pados.hu]
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
 -1.9 BAYES_00               BODY: Bayes spam probability is 0 to 1%
                             [score: 0.0000]
  0.0 TVD_RCVD_IP            Message was received from an IP address
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a bug in the current GPIO code for ftdi_sio: it failed to take USB
autosuspend into account. If the device is in autosuspend, calls to
usb_control_msg() fail with -EHOSTUNREACH. Because the standard value for
autosuspend timeout is usually 2-5 seconds, this made it almost impossible
to use the GPIOs on machines that have USB autosuspend enabled. This patch
fixes the issue by acquiring a PM lock on the device for the duration of
the USB transfers. Tested on an FT231X device.

Signed-off-by: Karoly Pados <pados@pados.hu>
---
Please consider backporting to 4.20.x, otherwise the GPIO driver is not
really usable for anybody with USB autosuspend enabled (eg. many laptops),
at least not without manual configuration.

 drivers/usb/serial/ftdi_sio.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index 1ab2a6191013..01813dce37f2 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1783,6 +1783,13 @@ static int ftdi_set_bitmode(struct usb_serial_port *port, u8 mode)
 	int result;
 	u16 val;
 
+	result = usb_autopm_get_interface(port->serial->interface);
+	if (result) {
+		dev_err(&port->serial->interface->dev,
+			"Failed to wake device from autosuspend.\n");
+		return result;
+	}
+
 	val = (mode << 8) | (priv->gpio_output << 4) | priv->gpio_value;
 	result = usb_control_msg(serial->dev,
 				 usb_sndctrlpipe(serial->dev, 0),
@@ -1795,6 +1802,8 @@ static int ftdi_set_bitmode(struct usb_serial_port *port, u8 mode)
 			val, result);
 	}
 
+	usb_autopm_put_interface(port->serial->interface);
+
 	return result;
 }
 
@@ -1846,9 +1855,18 @@ static int ftdi_read_cbus_pins(struct usb_serial_port *port)
 	unsigned char *buf;
 	int result;
 
+	result = usb_autopm_get_interface(port->serial->interface);
+	if (result) {
+		dev_err(&port->serial->interface->dev,
+			"Failed to wake device from autosuspend.\n");
+		return result;
+	}
+
 	buf = kmalloc(1, GFP_KERNEL);
-	if (!buf)
+	if (!buf) {
+		usb_autopm_put_interface(port->serial->interface);
 		return -ENOMEM;
+	}
 
 	result = usb_control_msg(serial->dev,
 				 usb_rcvctrlpipe(serial->dev, 0),
@@ -1863,6 +1881,7 @@ static int ftdi_read_cbus_pins(struct usb_serial_port *port)
 	}
 
 	kfree(buf);
+	usb_autopm_put_interface(port->serial->interface);
 
 	return result;
 }
-- 
2.20.1

