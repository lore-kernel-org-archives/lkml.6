Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4028164-1523370956-2-14292392708505601830
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523370955; b=evJ0S7TxtgJqYTYHWd9sSkGwlVa13CbDiBQIcYsDlauT1M+UeS
    +s7uE6S83zUH8JC4E1RnnrREcsBLqHWddfMs0eTVZjeELVw+lQ6WQ58XoWWBX93p
    GC93FDs6sM85xt+JgCDf7o1gK3Ty6OWANG6v1yGLJgaYzwiXN5He6D7vxjlNjRFn
    lrxSyUvV3TB5B11QOKzvL9TUZZKoizoS6G0xpAUjtCPOqYvZAJj/3CTXMYcFrVpd
    PBD53yI/ORiEiGdIGsibslmLvv7deduaFexBlg0FGJBDmNARXlYSePc0PB0CNtkW
    zAv20HZs2anZLUo1T2uBFDZgf3ynLxcHsPAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1523370955; bh=reRxTDLYVJzZxFQlOasV2hkuTgqpdH
    oczzDdxAdyoqc=; b=PLe8JpCI4KVl3d0vvOpxF1kjMgjpikpl0ktHdtuqoLCKJH
    gVkdojTlol5sPVtBKsSeEC3BKlyDfkiYCQ6Q2FzsUF97Qjb0cqGLbySp0zTnIZ1I
    dp9oJSuKZvnZ32E57wMgm4qYEuyhuavFuiBv5zSFzlvoK67v9W6fk7okBsht0B8l
    MmKsh5FLCjjCi7AFDQZQKlhMIwRVMiKgMJR/AgoJPu7VvH5FfNdh3gZNDX7LyMkQ
    BZtGvpRfUp+pZR+NkbeAk7cZXAmCrDvq6ZmcqX1msAYVCKZ9ZzptP/eKTN2drKj1
    U/KX8AsysbErHttgckExVMiwnZ7X+d8lsM8TMsqg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Tn72Ej76 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=rXYTaX9A;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Tn72Ej76 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=rXYTaX9A;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFn6y7gNRHxUgHM4NM+DxVKo/KfqqWI2J5zb31IxP1F4aKQL7BnsGW2CnoeNHQXmxMxZes0GrJp8P6FpAiygksAZaVtKVOMNBiUqlrOZqjWjxyE/vDl6
    7TfJsYs2iU8rXeEykUVyx+D7KQ7LKvJSXPDip0WLWKimVdiDJG22OPLS1rhRkzPSZ7yGRJ5pN9aHR9JWLUHEd2e1Lfd6W+QTJpGHzEYMVUryOHYUx5Ob0D+t
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=x7bEGLp0ZPQA:10 a=tmjX-nCzVX8A:10
    a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
    a=PtY2mPG4HLG9_tPD0bUA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754189AbeDJOfi (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 10:35:38 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:40403 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754182AbeDJOff (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 10 Apr 2018 10:35:35 -0400
X-Google-Smtp-Source: AIpwx4/BJqpeSkc1A8X1ERYFMYTMp5bb2oMYS7oA6jQjPz/+GlswBX4ENo5qulOOeOgmj4ZldZqE8g==
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: davem@davemloft.net, andreas@kemnade.info, johan@kernel.org,
        johannes.berg@intel.com, stephen@networkplumber.org,
        Linyu.Yuan@alcatel-sbell.com.cn
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] net: usb: hso: Replace GFP_ATOMIC with GFP_KERNEL in hso_create_device
Date: Tue, 10 Apr 2018 22:35:24 +0800
Message-Id: <1523370924-32425-1-git-send-email-baijiaju1990@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

hso_create_device() is never called in atomic context.

The call chains ending up at hso_create_device() are:
[1] hso_create_device() <- hso_create_bulk_serial_device() <- hso_probe()
[2] hso_create_device() <- hso_create_mux_serial_device() <- hso_probe()
[3] hso_create_device() <- hso_create_net_device() <- hso_probe()
hso_probe() is set as ".probe" in struct usb_driver, 
so it is not called in atomic context.

Despite never getting called from atomic context,
hso_create_device() calls kzalloc() with GFP_ATOMIC,
which does not sleep for allocation.
GFP_ATOMIC is not necessary and can be replaced with GFP_KERNEL,
which can sleep and improve the possibility of sucessful allocation.

This is found by a static analysis tool named DCNS written by myself.
And I also manually check it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/net/usb/hso.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/usb/hso.c b/drivers/net/usb/hso.c
index d7a3379..3d7a33f 100644
--- a/drivers/net/usb/hso.c
+++ b/drivers/net/usb/hso.c
@@ -2332,7 +2332,7 @@ static struct hso_device *hso_create_device(struct usb_interface *intf,
 {
 	struct hso_device *hso_dev;
 
-	hso_dev = kzalloc(sizeof(*hso_dev), GFP_ATOMIC);
+	hso_dev = kzalloc(sizeof(*hso_dev), GFP_KERNEL);
 	if (!hso_dev)
 		return NULL;
 
-- 
1.9.1

