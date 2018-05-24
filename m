Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1733193-1527156530-2-6279995353778000718
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
    1527156530; b=HljRBIRh5Pwj8p7ePzxfuhc1g2a+kbop+SJs5f9DHs5w9PALaJ
    ASNYVhLKxq401jrF7gsfyQLb3YzhHsRzN80RbUeJrlEt0Wv2qnzLWyvs4YIzoEc7
    TN6HpQdCXV4P2W+cEKqoKqHrcWdCXZGhh04LUygn7p2oQHqyNuA3cWsKKFDn+XXC
    VJYaS9msJO6hR0SuruKEN4+dt/w+RLnpOc6axNLmoGO3fhAIy9w5tlU7J4IP/sjZ
    qcaqJaSMyV++JAntBL+0Fgx0q2IUypfO7YGwmWmp5yG90x3fqYdwwWjvv3IJhZRm
    ydshtYIxH77ybLsyJ/RmHhV5OY5DjGZaHi4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527156530; bh=3HL3LtE96D874W3dDHchKeyKRTdHGa
    MZO79rJPL6S4E=; b=aosScbVVDu037c/5k1wu8jTrM93oOd+oPuRjKzKUHXUifW
    UCazVgoRsfQ2R0f+imMK3aWlnfS/fPxWgudMFYcL1Aew/gjuOZIzjRLx1RNhj884
    zbtBRV+2ZOhBjAwPWgOUvK+wSwS7AxCvQBYQz6f6WkN6uzOX524YfQMb51B8oP+O
    yrDoPdx7zt1OUCpNh/beBFNlypnglLyxrVCxQi+ITRjE3fGXX9vWvQglacvY7NDZ
    zkzwLvKvp7GuzrIZVvUZKpxwLgaqNhoSoltgXQdqzRG1Z+1ykDhFnTnWgMMOWqQg
    +OWOprdBb/bgwr6EzGu0WUDpy7BfuOMTHvBUQ9Bw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=xNE1eSlX x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=xNE1eSlX x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfBZz+1cwcmwHCtYRblXHlBfjIh1oKr7r3kmP6XzMutT6zTaRq54fNoaT5fInfdZXDoKUDVrfFS6zlHWYFFrdgMyuERxZdPfo7T6DWZavzuF2/YgJGZk4
    QeLHsp106TdX2oJ6v7O6Ta+XHdwGkX1domDSs8zWLadZMmFSVhGWTR/Zc7huvw2YezJ1N8XaEZ22xDb7+k4ehLz0HxFWmZEiBXH0Akfb7bi7u48ASpylwXTd
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=P-IC7800AAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=-1-aRErqP1VAc6yjLfcA:9
    a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031665AbeEXKGD (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 06:06:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:55030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030890AbeEXKF7 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 06:05:59 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 158/161] rtc: m41t80: fix race conditions
Date: Thu, 24 May 2018 11:39:43 +0200
Message-Id: <20180524093037.128894858@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
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

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

[ Upstream commit 10d0c768cc6d581523d673b9d1b54213f8a5eb24 ]

The IRQ is requested before the struct rtc is allocated and registered, but
this struct is used in the IRQ handler, leading to:

Unable to handle kernel NULL pointer dereference at virtual address 0000017c
pgd = a38a2f9b
[0000017c] *pgd=00000000
Internal error: Oops: 5 [#1] ARM
Modules linked in:
CPU: 0 PID: 613 Comm: irq/48-m41t80 Not tainted 4.16.0-rc1+ #42
Hardware name: Atmel SAMA5
PC is at mutex_lock+0x14/0x38
LR is at m41t80_handle_irq+0x1c/0x9c
pc : [<c06e864c>]    lr : [<c04b70f0>]    psr: 20000013
sp : dec73f30  ip : 00000000  fp : dec56d98
r10: df437cf0  r9 : c0a03008  r8 : c0145ffc
r7 : df5c4300  r6 : dec568d0  r5 : df593000  r4 : 0000017c
r3 : df592800  r2 : 60000013  r1 : df593000  r0 : 0000017c
Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c53c7d  Table: 20004059  DAC: 00000051
Process irq/48-m41t80 (pid: 613, stack limit = 0xb52d091e)
Stack: (0xdec73f30 to 0xdec74000)
3f20:                                     dec56840 df5c4300 00000001 df5c4300
3f40: c0145ffc c0146018 dec56840 ffffe000 00000001 c0146290 dec567c0 00000000
3f60: c0146084 ed7c9a62 c014615c dec56d80 dec567c0 00000000 dec72000 dec56840
3f80: c014615c c012ffc0 dec72000 dec567c0 c012fe80 00000000 00000000 00000000
3fa0: 00000000 00000000 00000000 c01010e8 00000000 00000000 00000000 00000000
3fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
3fe0: 00000000 00000000 00000000 00000000 00000013 00000000 29282726 2d2c2b2a
[<c06e864c>] (mutex_lock) from [<c04b70f0>] (m41t80_handle_irq+0x1c/0x9c)
[<c04b70f0>] (m41t80_handle_irq) from [<c0146018>] (irq_thread_fn+0x1c/0x54)
[<c0146018>] (irq_thread_fn) from [<c0146290>] (irq_thread+0x134/0x1c0)
[<c0146290>] (irq_thread) from [<c012ffc0>] (kthread+0x140/0x148)
[<c012ffc0>] (kthread) from [<c01010e8>] (ret_from_fork+0x14/0x2c)
Exception stack(0xdec73fb0 to 0xdec73ff8)
3fa0:                                     00000000 00000000 00000000 00000000
3fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
3fe0: 00000000 00000000 00000000 00000000 00000013 00000000
Code: e3c33d7f e3c3303f f5d0f000 e593300c (e1901f9f)
---[ end trace 22b027302eb7c604 ]---
genirq: exiting task "irq/48-m41t80" (613) is an active IRQ thread (irq 48)

Also, there is another possible race condition. The probe function is not
allowed to fail after the RTC is registered because the following may
happen:

CPU0:                                CPU1:
sys_load_module()
 do_init_module()
  do_one_initcall()
   cmos_do_probe()
    rtc_device_register()
     __register_chrdev()
     cdev->owner = struct module*
                                     open("/dev/rtc0")
    rtc_device_unregister()
  module_put()
  free_module()
   module_free(mod->module_core)
   /* struct module *module is now
      freed */
                                      chrdev_open()
                                       spin_lock(cdev_lock)
                                       cdev_get()
                                        try_module_get()
                                         module_is_live()
                                         /* dereferences already
                                            freed struct module* */

Switch to devm_rtc_allocate_device/rtc_register_device to allocate the rtc
before requesting the IRQ and register it as late as possible.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/rtc/rtc-m41t80.c |   18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

--- a/drivers/rtc/rtc-m41t80.c
+++ b/drivers/rtc/rtc-m41t80.c
@@ -885,7 +885,6 @@ static int m41t80_probe(struct i2c_clien
 {
 	struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
 	int rc = 0;
-	struct rtc_device *rtc = NULL;
 	struct rtc_time tm;
 	struct m41t80_data *m41t80_data = NULL;
 	bool wakeup_source = false;
@@ -909,6 +908,10 @@ static int m41t80_probe(struct i2c_clien
 		m41t80_data->features = id->driver_data;
 	i2c_set_clientdata(client, m41t80_data);
 
+	m41t80_data->rtc =  devm_rtc_allocate_device(&client->dev);
+	if (IS_ERR(m41t80_data->rtc))
+		return PTR_ERR(m41t80_data->rtc);
+
 #ifdef CONFIG_OF
 	wakeup_source = of_property_read_bool(client->dev.of_node,
 					      "wakeup-source");
@@ -932,15 +935,11 @@ static int m41t80_probe(struct i2c_clien
 		device_init_wakeup(&client->dev, true);
 	}
 
-	rtc = devm_rtc_device_register(&client->dev, client->name,
-				       &m41t80_rtc_ops, THIS_MODULE);
-	if (IS_ERR(rtc))
-		return PTR_ERR(rtc);
+	m41t80_data->rtc->ops = &m41t80_rtc_ops;
 
-	m41t80_data->rtc = rtc;
 	if (client->irq <= 0) {
 		/* We cannot support UIE mode if we do not have an IRQ line */
-		rtc->uie_unsupported = 1;
+		m41t80_data->rtc->uie_unsupported = 1;
 	}
 
 	/* Make sure HT (Halt Update) bit is cleared */
@@ -993,6 +992,11 @@ static int m41t80_probe(struct i2c_clien
 	if (m41t80_data->features & M41T80_FEATURE_SQ)
 		m41t80_sqw_register_clk(m41t80_data);
 #endif
+
+	rc = rtc_register_device(m41t80_data->rtc);
+	if (rc)
+		return rc;
+
 	return 0;
 }
 
