Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2951738-1517591664-2-3290104053964014533
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517591663; b=c5Kn9uOtutBBL25Z8qcANdHE9p2oKSXoD/GYrQHYRnghPu9
    nTJzhX5EHhvIMqoA0n8QBAeDYYD+SE/9Dagyde2kCSWv3oZ9rMf6hoZKukzRQGlU
    /VBL27zmfiqyWvl0zavGiC1cHPaxZKJwNnRE5+4oKKVjDhxI3ryRSbG/m8I+aNLY
    +NQKv/R5TwaMWJSKBGK+sZWniF8DfpCOLIb9zm99NWrD8BMQEl+vfLGF49w952Mc
    903pMwXOltjPRC2Fpgz0aYMb6bK3Q2n+dIhbkFD3YRPkxpbDuCFYn1xmSYpqZ0Pz
    3IfvgmOWz89or9Q401hywz/VV7639agpO2xZrmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517591663; bh=DV4mGouGKKC2cDzSs+lFojT8cl
    nOZ8rsB5HTufNgeHI=; b=PovbyFNVBLxFjXFWtP/StFgCwamQOsz39bVK2prwsO
    zfuhftLjjH3jhMh0p5CpuLh3SLMZUAdMt35ELT4Vei5Gg2yP2p4mMiauTypaTnrD
    pQHoY0CfEXMI17IeQlozcwL0jaCQW/hU3OieR/dI9Dc/8jBrCSCyvBSDqC9lApYS
    WpVOv0fEtmcGD0lM1rDIF7D3r3tVQV1andU0kT8fD7jQaiyjDJ+vM1kYkGD4HwBi
    4ragJ6syWAPJIjp4o7WlDE0CqECaCGArrY1ZpRzfZ9SYb3CTeoe1UXNl/uno09fT
    XjenHB9rtSJ2RqVsmUL3UDKO9b1wCHL89O+d4kl4bmpQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753609AbeBBROT (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:14:19 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:40432 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753590AbeBBROO (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:14:14 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lyude Paul <lyude@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.14 154/156] Input: synaptics-rmi4 - unmask F03 interrupts when port is opened
Date: Fri,  2 Feb 2018 17:58:55 +0100
Message-Id: <20180202140847.360646121@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

commit 6abe534f0776d2437c8302f58d8eb5abd483e926 upstream.

Currently we register the pass-through serio port when we probe the F03 RMI
function, and then, in sensor configure phase, we unmask interrupts.
Unfortunately this is too late, as other drivers are free probe devices
attached to the serio port as soon as it is probed. Because interrupts are
masked, the IO times out, which may result in not being able to detect
trackpoints on the pass-through port.

To fix the issue we implement open() and close() methods for the
pass-through serio port and unmask interrupts from there. We also move
creation of the pass-through port form probe to configure stage, as RMI
driver does not enable transport interrupt until all functions are probed
(we should change this, but this is a separate topic).

We also try to clear the pending data before unmasking interrupts, because
some devices like to spam the system with multiple 0xaa 0x00 announcements,
which may interfere with us trying to query ID of the device.

Fixes: c5e8848fc98e ("Input: synaptics-rmi4 - add support for F03")
Reviewed-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/rmi4/rmi_f03.c |   64 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 54 insertions(+), 10 deletions(-)

--- a/drivers/input/rmi4/rmi_f03.c
+++ b/drivers/input/rmi4/rmi_f03.c
@@ -32,6 +32,7 @@ struct f03_data {
 	struct rmi_function *fn;
 
 	struct serio *serio;
+	bool serio_registered;
 
 	unsigned int overwrite_buttons;
 
@@ -138,6 +139,37 @@ static int rmi_f03_initialize(struct f03
 	return 0;
 }
 
+static int rmi_f03_pt_open(struct serio *serio)
+{
+	struct f03_data *f03 = serio->port_data;
+	struct rmi_function *fn = f03->fn;
+	const u8 ob_len = f03->rx_queue_length * RMI_F03_OB_SIZE;
+	const u16 data_addr = fn->fd.data_base_addr + RMI_F03_OB_OFFSET;
+	u8 obs[RMI_F03_QUEUE_LENGTH * RMI_F03_OB_SIZE];
+	int error;
+
+	/*
+	 * Consume any pending data. Some devices like to spam with
+	 * 0xaa 0x00 announcements which may confuse us as we try to
+	 * probe the device.
+	 */
+	error = rmi_read_block(fn->rmi_dev, data_addr, &obs, ob_len);
+	if (!error)
+		rmi_dbg(RMI_DEBUG_FN, &fn->dev,
+			"%s: Consumed %*ph (%d) from PS2 guest\n",
+			__func__, ob_len, obs, ob_len);
+
+	return fn->rmi_dev->driver->set_irq_bits(fn->rmi_dev, fn->irq_mask);
+}
+
+static void rmi_f03_pt_close(struct serio *serio)
+{
+	struct f03_data *f03 = serio->port_data;
+	struct rmi_function *fn = f03->fn;
+
+	fn->rmi_dev->driver->clear_irq_bits(fn->rmi_dev, fn->irq_mask);
+}
+
 static int rmi_f03_register_pt(struct f03_data *f03)
 {
 	struct serio *serio;
@@ -148,6 +180,8 @@ static int rmi_f03_register_pt(struct f0
 
 	serio->id.type = SERIO_PS_PSTHRU;
 	serio->write = rmi_f03_pt_write;
+	serio->open = rmi_f03_pt_open;
+	serio->close = rmi_f03_pt_close;
 	serio->port_data = f03;
 
 	strlcpy(serio->name, "Synaptics RMI4 PS/2 pass-through",
@@ -184,17 +218,27 @@ static int rmi_f03_probe(struct rmi_func
 			 f03->device_count);
 
 	dev_set_drvdata(dev, f03);
-
-	error = rmi_f03_register_pt(f03);
-	if (error)
-		return error;
-
 	return 0;
 }
 
 static int rmi_f03_config(struct rmi_function *fn)
 {
-	fn->rmi_dev->driver->set_irq_bits(fn->rmi_dev, fn->irq_mask);
+	struct f03_data *f03 = dev_get_drvdata(&fn->dev);
+	int error;
+
+	if (!f03->serio_registered) {
+		error = rmi_f03_register_pt(f03);
+		if (error)
+			return error;
+
+		f03->serio_registered = true;
+	} else {
+		/*
+		 * We must be re-configuring the sensor, just enable
+		 * interrupts for this function.
+		 */
+		fn->rmi_dev->driver->set_irq_bits(fn->rmi_dev, fn->irq_mask);
+	}
 
 	return 0;
 }
@@ -204,7 +248,7 @@ static int rmi_f03_attention(struct rmi_
 	struct rmi_device *rmi_dev = fn->rmi_dev;
 	struct rmi_driver_data *drvdata = dev_get_drvdata(&rmi_dev->dev);
 	struct f03_data *f03 = dev_get_drvdata(&fn->dev);
-	u16 data_addr = fn->fd.data_base_addr;
+	const u16 data_addr = fn->fd.data_base_addr + RMI_F03_OB_OFFSET;
 	const u8 ob_len = f03->rx_queue_length * RMI_F03_OB_SIZE;
 	u8 obs[RMI_F03_QUEUE_LENGTH * RMI_F03_OB_SIZE];
 	u8 ob_status;
@@ -226,8 +270,7 @@ static int rmi_f03_attention(struct rmi_
 		drvdata->attn_data.size -= ob_len;
 	} else {
 		/* Grab all of the data registers, and check them for data */
-		error = rmi_read_block(fn->rmi_dev, data_addr + RMI_F03_OB_OFFSET,
-				       &obs, ob_len);
+		error = rmi_read_block(fn->rmi_dev, data_addr, &obs, ob_len);
 		if (error) {
 			dev_err(&fn->dev,
 				"%s: Failed to read F03 output buffers: %d\n",
@@ -266,7 +309,8 @@ static void rmi_f03_remove(struct rmi_fu
 {
 	struct f03_data *f03 = dev_get_drvdata(&fn->dev);
 
-	serio_unregister_port(f03->serio);
+	if (f03->serio_registered)
+		serio_unregister_port(f03->serio);
 }
 
 struct rmi_function_handler rmi_f03_handler = {
