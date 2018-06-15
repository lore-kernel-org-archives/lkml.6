Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E185DC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 21:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A8DE208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 21:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pados.hu header.i=@pados.hu header.b="xB+c3yUY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A8DE208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=pados.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756628AbeFOVwQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 17:52:16 -0400
Received: from erza.pados.hu ([176.9.136.194]:40540 "EHLO erza.pados.hu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756235AbeFOVwP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 17:52:15 -0400
X-Greylist: delayed 1328 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Jun 2018 17:52:14 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pados.hu;
         s=february2016; h=Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ihX2rBtX5+w3LNm02LK+p4/oeMCAiBWFqxtNClGXFyM=; b=xB+c3yUYydw2ys+L4IoO6Lgoig
        ZN7t58R7j/BLDl/eIqiByd0projjy0Ta5dRJvuNrJcgnna8nQqKiYK+iGzpPFSejrAwI9EziXwvp2
        wSeB5nac9y8KEJ3mOmnJ2YIvPqJk/ME64JqLAW5GWu0Tylr6sXap+km/P353yLscOCtG9kNE7/E5Q
        yPbxVkBCif7kKMjOK3Cjx7tmJdbrgs7KgloUgEPxG0SoPyVutrA+AHhLJ0Y+l3KOklq4MOyEJpeWY
        PsygK6fYWgrkK4kEzk+q/eSYcN9yXWGrrZ7Mv4B0kHfFbIVuMZ+E0NVMJPYSxX6q9QZSY0qOjurdk
        cXF3flIA==;
Received: from 188-143-49-191.pool.digikabel.hu ([188.143.49.191] helo=localhost)
        by erza with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <pados@pados.hu>)
        id 1fTwIF-0006U0-FC; Fri, 15 Jun 2018 23:30:04 +0200
From:   Karoly Pados <pados@pados.hu>
To:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Karoly Pados <pados@pados.hu>
Subject: [PATCH] USB: serial: cp210x: Improve baudrate support for CP2102N
Date:   Fri, 15 Jun 2018 23:29:57 +0200
Message-Id: <20180615212957.26539-1-pados@pados.hu>
X-Mailer: git-send-email 2.17.1
X-Spam_score: -2.9
X-Spam_report: Spam detection software, running on the system "erza",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  The CP2102N supports more baudrates than earlier chips by
   SiLabs. This patch adds support for all rates documented in the datasheet
   of this device. Signed-off-by: Karoly Pados <pados@pados.hu> --- drivers/usb/serial/cp210x.c
    | 39 ++++++++++++++++++++++++++ 1 file changed, 28 insertions(+), 11 deletions(-)
    [...] 
 Content analysis details:   (-2.9 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
  0.0 TVD_RCVD_IP            Message was received from an IP address
  0.0 URIBL_BLOCKED          ADMINISTRATOR NOTICE: The query to URIBL was blocked.
                             See
                             http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
                              for more information.
                             [URIs: pados.hu]
 -1.9 BAYES_00               BODY: Bayes spam probability is 0 to 1%
                             [score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CP2102N supports more baudrates than earlier chips by SiLabs.
This patch adds support for all rates documented in the datasheet
of this device.

Signed-off-by: Karoly Pados <pados@pados.hu>
---
 drivers/usb/serial/cp210x.c | 39 ++++++++++++++++++++++++++-----------
 1 file changed, 28 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index b1849f657e01..793b86252c46 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -357,6 +357,9 @@ static struct usb_serial_driver * const serial_drivers[] = {
 #define CP210X_PARTNUM_CP2104	0x04
 #define CP210X_PARTNUM_CP2105	0x05
 #define CP210X_PARTNUM_CP2108	0x08
+#define CP210X_PARTNUM_CP2102N_QFN28	0x20
+#define CP210X_PARTNUM_CP2102N_QFN24	0x21
+#define CP210X_PARTNUM_CP2102N_QFN20	0x22
 #define CP210X_PARTNUM_UNKNOWN	0xFF
 
 /* CP210X_GET_COMM_STATUS returns these 0x13 bytes */
@@ -758,8 +761,12 @@ static int cp210x_get_line_ctl(struct usb_serial_port *port, u16 *ctl)
 /*
  * cp210x_quantise_baudrate
  * Quantises the baud rate as per AN205 Table 1
+ * The CP2102N is fully (except for baud rate aliasing) software-
+ * compatible, but supports some additional baudrates. However, there is
+ * no quantitisation table available for this model, so in this case we
+ * take the supported baudrate which is closest to the requested one.
  */
-static unsigned int cp210x_quantise_baudrate(unsigned int baud)
+static unsigned int cp210x_quantise_baudrate(unsigned int baud, bool cp2102n)
 {
 	if (baud <= 300)
 		baud = 300;
@@ -790,10 +797,17 @@ static unsigned int cp210x_quantise_baudrate(unsigned int baud)
 	else if (baud <= 491520)   baud = 460800;
 	else if (baud <= 567138)   baud = 500000;
 	else if (baud <= 670254)   baud = 576000;
-	else if (baud < 1000000)
-		baud = 921600;
-	else if (baud > 2000000)
-		baud = 2000000;
+	else if (cp2102n) {
+		if (baud <= 960800)        baud = 921600;
+		else if (baud <= 1100000)  baud = 1000000;
+		else if (baud <= 1350000)  baud = 1200000;
+		else if (baud <= 1750000)  baud = 1500000;
+		else if (baud <= 2500000)  baud = 2000000;
+		else                       baud = 3000000;
+	} else {
+		if (baud < 1000000)        baud = 921600;
+		else if (baud > 2000000)   baud = 2000000;
+	}
 	return baud;
 }
 
@@ -1045,16 +1059,19 @@ static void cp210x_get_termios_port(struct usb_serial_port *port,
 static void cp210x_change_speed(struct tty_struct *tty,
 		struct usb_serial_port *port, struct ktermios *old_termios)
 {
-	u32 baud;
-
-	baud = tty->termios.c_ospeed;
+	bool is_cp2102n;
+	u32 baud = tty->termios.c_ospeed;
+	struct cp210x_serial_private *priv = usb_get_serial_data(port->serial);
 
-	/* This maps the requested rate to a rate valid on cp2102 or cp2103,
-	 * or to an arbitrary rate in [1M,2M].
+	/* This maps the requested rate to a rate valid on cp2102(n) or
+	 * cp2103 or to an arbitrary rate in [1M,2M].
 	 *
 	 * NOTE: B0 is not implemented.
 	 */
-	baud = cp210x_quantise_baudrate(baud);
+	is_cp2102n =	(priv->partnum == CP210X_PARTNUM_CP2102N_QFN28) ||
+			(priv->partnum == CP210X_PARTNUM_CP2102N_QFN24) ||
+			(priv->partnum == CP210X_PARTNUM_CP2102N_QFN20);
+	baud = cp210x_quantise_baudrate(baud, is_cp2102n);
 
 	dev_dbg(&port->dev, "%s - setting baud rate to %u\n", __func__, baud);
 	if (cp210x_write_u32_reg(port, CP210X_SET_BAUDRATE, baud)) {
-- 
2.17.1

