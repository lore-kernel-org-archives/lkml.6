Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-574721-1526690958-2-10932829432862938428
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526690957; b=jlBqM1xNVGf7DkicQGd3YePcyJbbGTU4E73P9YPhNXCSH+KqM9
    x+Kvdu5c5STfaAFxa4s7j/S5NCPDfZ7VbLxIzT0eKVTsLpWxsIy2NSDdaheeu+Ls
    TKqoBxPVQaI6TwyYtzkj/NdBuAd+ot5CsNcgy0yBJduSaU72KdjCIPMvmk7POqWu
    3Fn5q24Qe1Je5oMJbm1/7lmtlFutlwlSGWQmtWz96RQKEGSYZpffCTgDAQn2DtFq
    OCDeNlDReEZQIaz/UatcweP9xtQmZga9Uq8o5zfmvQLOVtEoqdZtNCGI6sS+yp4a
    dxqybMFg/mnuPr6tP0Tjc/fuux6Jyt6IjpHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1526690957; bh=ythtbzKM5KTKr5b+Ru3X5Y+xYoNvs6
    XWl4plbkccVkc=; b=fHtblS+G5EmM+u7RZdqRkFLsLszUFXpgPLd4uUAKK/aiV4
    h/+mEwGqBmUqEbs6XIhtRhtHxhFbgNag/dW6jVwPWOEcVjdHtV6y6bHHi7kh8iuc
    5YUbij+Iw1cGkjDZktKf5jlLN3qhzRB2OVAgDYqCRU4SGgT0NBFtro34ad960CPW
    A8/JvvnHUl7+x9uf98z8xAWjUYpTbzGA2F+oktE8ICiqg35YyXiTBf27OKsyZJcv
    ZwCSy9ZoXkI9I8SF22TuFiE4dv15/dfwkvaDqschnuQuCBmCoU/1n5LSARJS8JDr
    5ON4fpZxk0OJeidsF1CBfIx1JOUYcevrGlY5oAsg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=linaro.org header.i=@linaro.org header.b=kmadjF4F x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=qLjT+1wU;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=linaro.org header.i=@linaro.org header.b=kmadjF4F x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=qLjT+1wU;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOYsI0uYmzAitkkxwq64jv19S38j4WzZUx9S3DTP2HULyFAFNh1Bt2+fTk8cXWc1OcYF3SrZ5MRExg/mg/XttHY6ijA2CuTHVlW0YNTemxszQjeFZwEH
    +usibqOcNyOO8V7h23Nmq1+iIY4ufG94ke1yt2sCyLg0CeXkQogzd6xzV+vjuNv33UIiLuEckwXeWPobApAGMb8cyBAZcC3YPVbVe44h9ks0l33HC+Vw5JIU
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=xqWC_Br6kY4A:10 a=VUJBJC2UJ8kA:10
    a=jIQo8A4GAAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
    a=9f7s3DRQrkJldriD0Y0A:9 a=x8gzFH9gYPwA:10 a=Lf5xNeLK5dgiOs8hzIjU:22
    a=AjGcO6oz07-iQ99wixmX:22 a=cvBusfyB2V15izCimMoJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752044AbeESAtN (ORCPT <rfc822;greg@kroah.com>);
        Fri, 18 May 2018 20:49:13 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:43213 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751816AbeESAtL (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 18 May 2018 20:49:11 -0400
X-Google-Smtp-Source: AB8JxZop1TunDGZhRB0j6eS2o9XcwmAXVjuX+56AOyZzo7QC716u1c4mRFylP7lMrfafP1lTT2l7uA==
From: John Stultz <john.stultz@linaro.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: John Stultz <john.stultz@linaro.org>,
        John Youn <johnyoun@synopsys.com>,
        Vardan Mikayelyan <mvardan@synopsys.com>,
        Artur Petrosyan <arturp@synopsys.com>,
        Grigor Tovmasyan <tovmasya@synopsys.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        linux-usb@vger.kernel.org
Subject: [PATCH] usb: dwc2: Fix HiKey regression caused by power_down feature
Date: Fri, 18 May 2018 17:49:03 -0700
Message-Id: <1526690943-8211-1-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In 4.17-rc, commit 03ea6d6e9e1f ("usb: dwc2: Enable power down")
caused the HiKey board to not correctly handle switching between
usb-gadget and usb-host mode.

Unplugging the OTG port would result in:
[   42.240973] dwc2 f72c0000.usb: dwc2_restore_host_registers: no host registers to restore
[   42.249066] dwc2 f72c0000.usb: dwc2_host_exit_hibernation: failed to restore host registers

And the USB-host ports would not function.

And plugging in the OTG port, we would see:
[   46.046557] WARNING: CPU: 3 PID: 6 at drivers/usb/dwc2/gadget.c:260 dwc2_hsotg_init_fifo+0x194/0x1a0
[   46.055761] CPU: 3 PID: 6 Comm: kworker/u16:0 Not tainted 4.17.0-rc5-00030-ge67da8c #231
[   46.055767] Hardware name: HiKey Development Board (DT)
[   46.055784] Workqueue: dwc2 dwc2_conn_id_status_change
...

Thus, this patch sets the hisi params to disable the power_down
flag by default, and gets thing working again.

Cc: John Youn <johnyoun@synopsys.com>
Cc: Vardan Mikayelyan <mvardan@synopsys.com>
Cc: Artur Petrosyan <arturp@synopsys.com>
Cc: Grigor Tovmasyan <tovmasya@synopsys.com>
Cc: Felipe Balbi <felipe.balbi@linux.intel.com>
Cc: linux-usb@vger.kernel.org
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/usb/dwc2/params.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c
index f03e418..96b1b25 100644
--- a/drivers/usb/dwc2/params.c
+++ b/drivers/usb/dwc2/params.c
@@ -70,6 +70,7 @@ static void dwc2_set_his_params(struct dwc2_hsotg *hsotg)
 		GAHBCFG_HBSTLEN_SHIFT;
 	p->uframe_sched = false;
 	p->change_speed_quirk = true;
+	p->power_down = false;
 }
 
 static void dwc2_set_rk_params(struct dwc2_hsotg *hsotg)
-- 
2.7.4

