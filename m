Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2591571-1524405282-2-1003944009277297782
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524405281; b=ZcgIyqYjUNkHvA0aR4HLeCHF4rPQ2zM0mfOEWkCfsdJocCKVBH
    kgC9xVTQh9HOSpK1GaltDW9Y3FAJZrHo+BBNpixvnK1OIlcm3r5wsnNh5fyWxiw5
    MSYhxNsvsTgla9Zd5WZjqQaiWA3Hx+y5aQ+G7OKzgARhE10+tODYmPuOQlDQLvTp
    fUvyED+P71TFChrRIOa8cQfjVgXu9prqNgMEqZLX8D2pVAnS1DlRedqgh5Tdgu5g
    GBNlu0j0g4MS8pqjaDXJzQLyY1FNBVZ743cCH06Te8gxmxGkn36uaSnWpt5XUKOF
    ym1wQ40Trp7+/8A09pJDHJZviN8JVsMEzckA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524405281; bh=amQNpahzL82gdyos1EzkB0Cmr2YDWw
    qEL6hlYV/rEcc=; b=p/krOM7wg8hpdjZOOjwEgNhiwwJ99QkLPWbA4ytQjTMo0h
    18+0J79yJOXjGfu8dMsCFQ0cxvSOq8IizifXMv0c+5w2HDmWQHcYeW/H/RYoaIjK
    HzxOitad0c9KJCLPuEaKMYOCykoEDioo6lRKoyklglf1MgHXK5vqRY+etKqxHZIv
    xOOpY7t7Kadawqi7JSspK/3qmQfjCL6gb8BqAEfu/hexSAo4qmWV6U3/uInfGvmO
    6gGiqiwJ5YzqR4o2M3Kig1YIEbUO6bf8K8g/kf3PORg7Ct5exEwoYOdpf3L6BP8I
    cIDbmr0G0D4hLhzaBa0rJ8xr34yJPtA4OiTPYGJQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfGPmBH+OGB7ZhQUrnw60cRh1JXkjpDLbT+bARgxLCVOcTMRJLtKTDdX8mnyx9pdtfq1wrrYdt8FyQkHMYFaw51xPB7MGVbSjYo/Z2szBMPWcDNoXQrrj
    wQnjuGtxPcpwYvH4BzVv5QCP66yNL/OQXFnKKciFvBPL53WjNDx6WAtRpt/oqnFE8MOTvhAH/+kuH4FwHboG8Zx96A3MV3jaBvtVKT9ktjOVZRlngrRkBkHj
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=Dei6p5SHAAAA:8 a=ag1SF4gXAAAA:8
    a=jWd5aLCeDPsBo_hiVssA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=M-Yerj1wOn-OpK7r_3ei:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751301AbeDVNyk (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 09:54:40 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44246 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751053AbeDVNyk (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 09:54:40 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH 4.16 001/196] Bluetooth: hci_bcm: Add irq_polarity module option
Date: Sun, 22 Apr 2018 15:50:21 +0200
Message-Id: <20180422135104.335923713@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit e09070c51b280567695022237e57c428e548b355 upstream.

Add irq_polarity module option for easier troubleshooting of irq-polarity
issues.

Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/bluetooth/hci_bcm.c |   20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -126,6 +126,10 @@ struct bcm_data {
 static DEFINE_MUTEX(bcm_device_lock);
 static LIST_HEAD(bcm_device_list);
 
+static int irq_polarity = -1;
+module_param(irq_polarity, int, 0444);
+MODULE_PARM_DESC(irq_polarity, "IRQ polarity 0: active-high 1: active-low");
+
 static inline void host_set_baudrate(struct hci_uart *hu, unsigned int speed)
 {
 	if (hu->serdev)
@@ -975,11 +979,17 @@ static int bcm_acpi_probe(struct bcm_dev
 	}
 	acpi_dev_free_resource_list(&resources);
 
-	dmi_id = dmi_first_match(bcm_active_low_irq_dmi_table);
-	if (dmi_id) {
-		dev_warn(dev->dev, "%s: Overwriting IRQ polarity to active low",
-			    dmi_id->ident);
-		dev->irq_active_low = true;
+	if (irq_polarity != -1) {
+		dev->irq_active_low = irq_polarity;
+		dev_warn(dev->dev, "Overwriting IRQ polarity to active %s by module-param\n",
+			 dev->irq_active_low ? "low" : "high");
+	} else {
+		dmi_id = dmi_first_match(bcm_active_low_irq_dmi_table);
+		if (dmi_id) {
+			dev_warn(dev->dev, "%s: Overwriting IRQ polarity to active low",
+				 dmi_id->ident);
+			dev->irq_active_low = true;
+		}
 	}
 
 	return 0;
