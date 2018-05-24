Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1733193-1527156525-2-16744515789971816760
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
    1527156525; b=YH9fhR8GPogjrPQmYD/E7Ug4sBC7GoEL0emKR5/m1rnWASdO2v
    KnRcYcjffWZYOsv4AmQ5JORyk3z6R2Ff8G2h2EdVmNt20zCdfzxtdMIA5O81KgtG
    sMGiP+AePHNpeO5GoHH+kvUkVm/hjKec6k5PcAtMZSdJ6KGLZBSnGTp8tmS+eXUj
    R30kOHKhqhjkhhtAP2v3VFoTVZ9h0NqM2qKcP+mnqG5we0hIMK/NJm4THqqcD8IA
    czGC50CL0kTe0toEMpnKYrcPIbJVTUGjxtt9+xvVTpMuo3sGt9bXB3POvxqhxEwG
    cuk53gs4t/cNkNwriUFFRUQWSYGZLA7tbxnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527156525; bh=oRc0IIRgHHCAlEBJD1ai8pc+RdWGSf
    Qnp3amYbopjww=; b=gzG/9XZlSvukQ1nevzPG4r7kvtfPXtAsGmTbDLfirmz0ON
    Ge0omM5DPy6gOCW9ICEXzWCzFY42YXUTr3WLSgaKIvUjbjtDHfJgMnLVze7D4J+O
    KujIxz1xwE+MtLQCj9rA6cxwTLsZ84zVADuCisXlHNpDOwL4qyUZgbwXi8wBrUlW
    jt6vFFgGgs26g0M2f0agJ+f4K0Ae169xS5gkNgMAOGS88ky/Fg8UXSr1H7Ss6x8G
    lts64KiVMOrOM6XnopxRxNJGmUOhmPFiT31sz2sGE4Vzsf/jWPPFluXAQvs+PqJv
    5RuvCXLbjd+WvQVgLhcOrrP28w+G+R3KBvDMUBXQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=yipjeYuc x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=yipjeYuc x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfH0qRWcALN+X7QMhnE9F7we6MzzOC1hZ3Fp7tf8AxPx13hnIm85OCAmnKlwNbegBYqc3ojNHqawvb/Skzh0rOAh/nOma+qx5wVxRLzmpkcUM8OPGqVRx
    CvZQnKZr8TIPn1GnCR9hBmruAfIZhg/QXoOMlIfk26/PCCP15N27n00CaNLYQ2REalKcAEtPYfpvAlN0erc+X7uFEEXcH3m8QSKbBb5CsqAOmmhDzNxOJDSU
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=P-IC7800AAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=_reXzBdDsLP_B_R58xkA:9
    a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031425AbeEXKI1 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 06:08:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:55100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031229AbeEXKGF (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 06:06:05 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 160/161] rtc: rp5c01: fix possible race condition
Date: Thu, 24 May 2018 11:39:45 +0200
Message-Id: <20180524093037.431976454@linuxfoundation.org>
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

[ Upstream commit bcdd559268039d8340d38fa58668393596e29fdc ]

The probe function is not allowed to fail after registering the RTC because
the following may happen:

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

Switch to devm_rtc_allocate_device/rtc_register_device to register the rtc
as late as possible.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/rtc/rtc-rp5c01.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

--- a/drivers/rtc/rtc-rp5c01.c
+++ b/drivers/rtc/rtc-rp5c01.c
@@ -249,16 +249,24 @@ static int __init rp5c01_rtc_probe(struc
 
 	platform_set_drvdata(dev, priv);
 
-	rtc = devm_rtc_device_register(&dev->dev, "rtc-rp5c01", &rp5c01_rtc_ops,
-				  THIS_MODULE);
+	rtc = devm_rtc_allocate_device(&dev->dev);
 	if (IS_ERR(rtc))
 		return PTR_ERR(rtc);
+
+	rtc->ops = &rp5c01_rtc_ops;
+
 	priv->rtc = rtc;
 
 	error = sysfs_create_bin_file(&dev->dev.kobj, &priv->nvram_attr);
 	if (error)
 		return error;
 
+	error = rtc_register_device(rtc);
+	if (error) {
+		sysfs_remove_bin_file(&dev->dev.kobj, &priv->nvram_attr);
+		return error;
+	}
+
 	return 0;
 }
 
