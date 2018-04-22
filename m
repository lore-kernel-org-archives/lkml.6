Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2651967-1524406552-2-17536905119589154853
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enrosv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524406551; b=B4+Pab+OHbxpohCJsvpqQmPIJ9u09TgcB2FM5hkyu5VFUCU+Aq
    N0RzjlghXSqk9/v7ndIokxvlqO/0Y4FnwUS1tlaxoVeJMt+mlCYdJUhZPHqCIQer
    G7oiZ8NIytne3H6Qjh2haoKQvohKYBr1HCf+b71CfT62LrYw1BPcTbkdOvqB7YcZ
    IbGg8vzpDJdY6UU7BcOMrA7palT9qA/DhdsN758XVGl5QeqfpYKynixh1b1CUqRs
    bLtJFmudBQ3KsDTCGozKH6q4esWRdd28oMn2Ltw8ggNlszV9Igk901fvvTc5Wht3
    D8wV2K+Kma/l0GTeTjs4fxoGlQCtbRHHAk4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524406551; bh=ZS1RCPbVLINNSHjSiEqp/D54OyDN//
    gtbURaTlivmxM=; b=XYPBiA/VSjLaEm4Ho6R6bd4xxDmw9DrIcJfuqPJTqZ/WxJ
    HJOvcN33+EP02ylcul42k5RqUbC57jo5rm8o1Zki1qslefvjGfNbffjECSjeXeDm
    tRmTv5X+CCnayl6AME4xQ2isquiCwar4aTdyRpoqoDmvcfOWHICHFdj/SQrX7WvY
    UhjkE9YXs5ac4LR7h1NZ7s6jFIjDouqIIvxjrMIxGYxLphb+rGZOV05RB4nzALfM
    eH/jTS6ZegEWML5DxN27YdX76Y4HLQjt+KuUtUR05aF+66JNxFc0OHoXT7/OBU9Q
    Mt0dQQ3PvajMEkTYN15T7s9hQ2wgy6TDTN7Lzorw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfHpeVvRFSc4b+Ncp0M4oMUy+8GWV80kwbH1clguTke2fz6eWhPe2OpZCGq37ChNxIWJaqIldWZGsFt7w4VDl9wqScuCO5nUHYzDoch32Y+/Klc/y4mHk
    /BdBBP1n6qUfRgsgvm2YaHCG9wNQDkuz3U7Ot7lsYAwOYzJE/mNNhmFeAc8gn4DnjaAT1OvjW1O25J0X8I9SdG+2ifpxb+QskysGfh20WhdGpKad7sISO9Jm
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=hD80L64hAAAA:8 a=_jlGtV7tAAAA:8 a=ag1SF4gXAAAA:8 a=mcZFpYgTAuSn6IqRhOEA:9
    a=QEXdDO2ut3YA:10 a=nlm17XC03S6CtCLSeiRr:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932162AbeDVOPs (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 10:15:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56966 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757003AbeDVOPo (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 10:15:44 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.4 15/97] hwmon: (ina2xx) Fix access to uninitialized mutex
Date: Sun, 22 Apr 2018 15:52:53 +0200
Message-Id: <20180422135305.472721520@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135304.577223025@linuxfoundation.org>
References: <20180422135304.577223025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marek Szyprowski <m.szyprowski@samsung.com>

commit 0c4c5860e9983eb3da7a3d73ca987643c3ed034b upstream.

Initialize data->config_lock mutex before it is used by the driver code.

This fixes following warning on Odroid XU3 boards:

INFO: trying to register non-static key.
the code is fine but needs lockdep annotation.
turning off the locking correctness validator.
CPU: 5 PID: 1 Comm: swapper/0 Not tainted 4.15.0-rc7-next-20180115-00001-gb75575dee3f2 #107
Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[<c0111504>] (unwind_backtrace) from [<c010dbec>] (show_stack+0x10/0x14)
[<c010dbec>] (show_stack) from [<c09b3f74>] (dump_stack+0x90/0xc8)
[<c09b3f74>] (dump_stack) from [<c0179528>] (register_lock_class+0x1c0/0x59c)
[<c0179528>] (register_lock_class) from [<c017bd1c>] (__lock_acquire+0x78/0x1850)
[<c017bd1c>] (__lock_acquire) from [<c017de30>] (lock_acquire+0xc8/0x2b8)
[<c017de30>] (lock_acquire) from [<c09ca59c>] (__mutex_lock+0x60/0xa0c)
[<c09ca59c>] (__mutex_lock) from [<c09cafd0>] (mutex_lock_nested+0x1c/0x24)
[<c09cafd0>] (mutex_lock_nested) from [<c068b0d0>] (ina2xx_set_shunt+0x70/0xb0)
[<c068b0d0>] (ina2xx_set_shunt) from [<c068b218>] (ina2xx_probe+0x88/0x1b0)
[<c068b218>] (ina2xx_probe) from [<c0673d90>] (i2c_device_probe+0x1e0/0x2d0)
[<c0673d90>] (i2c_device_probe) from [<c053a268>] (driver_probe_device+0x2b8/0x4a0)
[<c053a268>] (driver_probe_device) from [<c053a54c>] (__driver_attach+0xfc/0x120)
[<c053a54c>] (__driver_attach) from [<c05384cc>] (bus_for_each_dev+0x58/0x7c)
[<c05384cc>] (bus_for_each_dev) from [<c0539590>] (bus_add_driver+0x174/0x250)
[<c0539590>] (bus_add_driver) from [<c053b5e0>] (driver_register+0x78/0xf4)
[<c053b5e0>] (driver_register) from [<c0675ef0>] (i2c_register_driver+0x38/0xa8)
[<c0675ef0>] (i2c_register_driver) from [<c0102b40>] (do_one_initcall+0x48/0x18c)
[<c0102b40>] (do_one_initcall) from [<c0e00df0>] (kernel_init_freeable+0x110/0x1d4)
[<c0e00df0>] (kernel_init_freeable) from [<c09c8120>] (kernel_init+0x8/0x114)
[<c09c8120>] (kernel_init) from [<c01010b4>] (ret_from_fork+0x14/0x20)

Fixes: 5d389b125186 ("hwmon: (ina2xx) Make calibration register value fixed")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
[backport to v4.4.y/v4.9.y: context changes]
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hwmon/ina2xx.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/hwmon/ina2xx.c
+++ b/drivers/hwmon/ina2xx.c
@@ -447,6 +447,7 @@ static int ina2xx_probe(struct i2c_clien
 
 	/* set the device type */
 	data->config = &ina2xx_config[id->driver_data];
+	mutex_init(&data->config_lock);
 
 	if (of_property_read_u32(dev->of_node, "shunt-resistor", &val) < 0) {
 		struct ina2xx_platform_data *pdata = dev_get_platdata(dev);
@@ -473,8 +474,6 @@ static int ina2xx_probe(struct i2c_clien
 		return -ENODEV;
 	}
 
-	mutex_init(&data->config_lock);
-
 	data->groups[group++] = &ina2xx_group;
 	if (id->driver_data == ina226)
 		data->groups[group++] = &ina226_group;
