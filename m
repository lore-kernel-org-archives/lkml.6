Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59128C6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 23:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA60E20673
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 23:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pados.hu header.i=@pados.hu header.b="IF9qhy0j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA60E20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=pados.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754356AbeGGXzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 19:55:14 -0400
Received: from erza.pados.hu ([176.9.136.194]:48678 "EHLO erza.pados.hu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754060AbeGGXzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 19:55:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pados.hu;
         s=february2016; h=Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=L8BhTyw7ExH1VCI/U4221YSaPJSAEKfolqV7eOIMafM=; b=IF9qhy0jRbfg5EJzSXCIEAldst
        hnrJaJt9ErxLdrBjx8Q9akAnPVD6gco47Zo8IXoNxQnod69wI2QrtM3x3K+e8R8hx7edjWBywpIdV
        9Fzl2PX7E5nVQyFa6R+qpZSPMqCotvOfjQgU2oUT6RN35Rjmq/2j16q0qK71/sL8T1LYajToGHqkb
        sdFoVeMW71MGO2YuliR6UZYp2zP5e09iyg0Et15qCV7sY1nCXzXlSmZ96KQgD7ToNL86hKnHy4yRo
        vf7bjZs1loAnR6DCdY+fAPOMKQPXO36vD7yvaY1fOj1JJW57zqR3rdwzSKo+Itei94okH8K33OLPY
        R6UsYUQQ==;
Received: from 4f7a7acb.dsl.pool.telekom.hu ([79.122.122.203] helo=localhost)
        by erza with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <pados@pados.hu>)
        id 1fbx2i-0003AH-WE; Sun, 08 Jul 2018 01:55:09 +0200
From:   Karoly Pados <pados@pados.hu>
To:     "Johan Hovold" <johan@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Karoly Pados <pados@pados.hu>
Subject: [PATCH v2] USB: serial: cp210x: Improve baudrate support for CP2102N
Date:   Sun,  8 Jul 2018 01:54:40 +0200
Message-Id: <20180707235440.18027-1-pados@pados.hu>
X-Mailer: git-send-email 2.17.1
X-Spam_score: -2.9
X-Spam_report: Spam detection software, running on the system "erza",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  CP2102N devices support a lot more baudrates than earlier
   chips by SiLabs. These devices are not constrained anymore by the table in
    AN205, and are able to generate almost any baudrate in the supported range
    with only minimal errors. This has also been verified with a scope on a physical
    device. This patch adds support for all baudrates supported by the CP2102N.
    [...] 
 Content analysis details:   (-2.9 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
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

CP2102N devices support a lot more baudrates than earlier chips by
SiLabs. These devices are not constrained anymore by the table in AN205,
and are able to generate almost any baudrate in the supported range
with only minimal errors. This has also been verified with a scope on
a physical device. This patch adds support for all baudrates supported
by the CP2102N.

Signed-off-by: Karoly Pados <pados@pados.hu>
---
 drivers/usb/serial/cp210x.c | 104 +++++++++++++++++++++++-------------
 1 file changed, 68 insertions(+), 36 deletions(-)

diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index b1849f657e01..5c943e181d68 100644
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
@@ -456,6 +459,19 @@ struct cp210x_gpio_write {
 	u8	state;
 } __packed;
 
+/*
+ * Helper to determine if a specific serial device belongs to the cp2102n
+ * family of devices.
+ */
+static bool cp210x_is_cp2102n(struct usb_serial *serial)
+{
+	struct cp210x_serial_private *priv = usb_get_serial_data(serial);
+
+	return  (priv->partnum == CP210X_PARTNUM_CP2102N_QFN28) ||
+		(priv->partnum == CP210X_PARTNUM_CP2102N_QFN24) ||
+		(priv->partnum == CP210X_PARTNUM_CP2102N_QFN20);
+}
+
 /*
  * Helper to get interface number when we only have struct usb_serial.
  */
@@ -757,43 +773,59 @@ static int cp210x_get_line_ctl(struct usb_serial_port *port, u16 *ctl)
 
 /*
  * cp210x_quantise_baudrate
- * Quantises the baud rate as per AN205 Table 1
+ * Determine a valid baudrate nearest to the requested one.
  */
-static unsigned int cp210x_quantise_baudrate(unsigned int baud)
+static unsigned int cp210x_quantise_baudrate(struct usb_serial *serial,
+					     unsigned int baud)
 {
-	if (baud <= 300)
-		baud = 300;
-	else if (baud <= 600)      baud = 600;
-	else if (baud <= 1200)     baud = 1200;
-	else if (baud <= 1800)     baud = 1800;
-	else if (baud <= 2400)     baud = 2400;
-	else if (baud <= 4000)     baud = 4000;
-	else if (baud <= 4803)     baud = 4800;
-	else if (baud <= 7207)     baud = 7200;
-	else if (baud <= 9612)     baud = 9600;
-	else if (baud <= 14428)    baud = 14400;
-	else if (baud <= 16062)    baud = 16000;
-	else if (baud <= 19250)    baud = 19200;
-	else if (baud <= 28912)    baud = 28800;
-	else if (baud <= 38601)    baud = 38400;
-	else if (baud <= 51558)    baud = 51200;
-	else if (baud <= 56280)    baud = 56000;
-	else if (baud <= 58053)    baud = 57600;
-	else if (baud <= 64111)    baud = 64000;
-	else if (baud <= 77608)    baud = 76800;
-	else if (baud <= 117028)   baud = 115200;
-	else if (baud <= 129347)   baud = 128000;
-	else if (baud <= 156868)   baud = 153600;
-	else if (baud <= 237832)   baud = 230400;
-	else if (baud <= 254234)   baud = 250000;
-	else if (baud <= 273066)   baud = 256000;
-	else if (baud <= 491520)   baud = 460800;
-	else if (baud <= 567138)   baud = 500000;
-	else if (baud <= 670254)   baud = 576000;
-	else if (baud < 1000000)
-		baud = 921600;
-	else if (baud > 2000000)
-		baud = 2000000;
+	if (cp210x_is_cp2102n(serial)) {
+		int clk_div;
+		int prescaler;
+
+		/*
+		 * Limit to valid range, then
+		 * calculate actual baudrate as per cp2102n datasheet.
+		 */
+		baud = clamp(baud, 300u, 3000000u);
+		prescaler = baud <= 365 ? 4 : 1;
+		clk_div = DIV_ROUND_CLOSEST(48000000, 2 * prescaler * baud);
+		baud = 48000000 / (2 * prescaler * clk_div);
+	} else {
+		/* Quantise baudrate as per AN205 Table 1 */
+		if (baud <= 300)
+			baud = 300;
+		else if (baud <= 600)      baud = 600;
+		else if (baud <= 1200)     baud = 1200;
+		else if (baud <= 1800)     baud = 1800;
+		else if (baud <= 2400)     baud = 2400;
+		else if (baud <= 4000)     baud = 4000;
+		else if (baud <= 4803)     baud = 4800;
+		else if (baud <= 7207)     baud = 7200;
+		else if (baud <= 9612)     baud = 9600;
+		else if (baud <= 14428)    baud = 14400;
+		else if (baud <= 16062)    baud = 16000;
+		else if (baud <= 19250)    baud = 19200;
+		else if (baud <= 28912)    baud = 28800;
+		else if (baud <= 38601)    baud = 38400;
+		else if (baud <= 51558)    baud = 51200;
+		else if (baud <= 56280)    baud = 56000;
+		else if (baud <= 58053)    baud = 57600;
+		else if (baud <= 64111)    baud = 64000;
+		else if (baud <= 77608)    baud = 76800;
+		else if (baud <= 117028)   baud = 115200;
+		else if (baud <= 129347)   baud = 128000;
+		else if (baud <= 156868)   baud = 153600;
+		else if (baud <= 237832)   baud = 230400;
+		else if (baud <= 254234)   baud = 250000;
+		else if (baud <= 273066)   baud = 256000;
+		else if (baud <= 491520)   baud = 460800;
+		else if (baud <= 567138)   baud = 500000;
+		else if (baud <= 670254)   baud = 576000;
+		else if (baud < 1000000)
+			baud = 921600;
+		else if (baud > 2000000)
+			baud = 2000000;
+	}
 	return baud;
 }
 
@@ -1054,7 +1086,7 @@ static void cp210x_change_speed(struct tty_struct *tty,
 	 *
 	 * NOTE: B0 is not implemented.
 	 */
-	baud = cp210x_quantise_baudrate(baud);
+	baud = cp210x_quantise_baudrate(port->serial, baud);
 
 	dev_dbg(&port->dev, "%s - setting baud rate to %u\n", __func__, baud);
 	if (cp210x_write_u32_reg(port, CP210X_SET_BAUDRATE, baud)) {
-- 
2.17.1

