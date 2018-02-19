Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3989416-1519035335-2-16872372172871191176
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519035334; b=WMkaVJOuRLFFcZ92Ayp5XSVT56T5jsyqaKSdhvvpinjtbqd
    sp2s9/sSUWa/mjImuHYnWIIB1XngQycibgjlNnRT3SW5I5DMkFIvSKncQsqHU+Tn
    VQJi5J1fz0KsERXJDawF7HbqnvNIcsza/zl5q4yvUYOJaS1DWxeiLJAN6VKUUnRN
    lSGB5rMYRJuk16UXSC5ZRkhXED5KhCuDKwFTdo/FzfcSof81TNEz3bY0aURK9Tkd
    hkcUQzf55TgGRMoSAdyD1Xj5Ucx/I8h4ei2YxRsh8G7ug6bjXWqyUIU4XUpAyaSG
    XdYCzoGrXTAgbXu8NAZ3arexyPp5SebMnnCPONw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519035334;
    bh=pzyeqMvNzPIe2BmBogZOWpRWF1xkneDcqiy7IXSlnyQ=; b=TBECk3LEhLTg
    SMcnHmse9uZ/7cZUfdvm8jMOWgZdwRluKs+SkeFwl50XEGywYKtHkyUl2ifDX+Nz
    YrkgluOs80uOlGENfu3HSsAxL53P60SQ2eRxgdoXyOxPSJW+2Y/MuEE9mjjWZoGZ
    PATR/heDJOc0o/h4OKgodUXV32Lf0QxFw2Ax6uTnPWzg+aRDshDv2t11D1Ko5Sgg
    +XOdtEcYUHK3kxup50jTbJucRaisiFeTdtZD3b3sGqke60q+yr5iMxs0Natxe5UH
    8/x93vnXAHZEZi2n77sVf8HOq/wrn5LdrgeU6O1RTYW4r+1kox1Gv79Tz84sApOC
    xmPZ0RrbrQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752657AbeBSKPS (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Feb 2018 05:15:18 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:42061 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752244AbeBSKPQ (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 19 Feb 2018 05:15:16 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: stable@vger.kernel.org
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Felipe Balbi <balbi@kernel.org>,
        linux-usb@vger.kernel.org
Subject: [4.9-stable 8/9] usb: phy: msm add regulator dependency
Date: Mon, 19 Feb 2018 11:13:27 +0100
Message-Id: <20180219101343.2922561-9-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180219101343.2922561-1-arnd@arndb.de>
References: <20180219101343.2922561-1-arnd@arndb.de>
X-Provags-ID: V03:K0:iigpTvVPK3Wr0NV/L8CQi7004USg8TJWd8yIZB55rZVkogSbbod
 z83GZwKgvYj5Xf+9Mmfny9nJjIatOf4TWUCi9juRFJRAoc9Fa49ne4lqPsorJ+SYOb+cMzM
 gKRnsXTw8WNsrWWBjhrwgqhz5mEJl1o9Ez0IGzk8C/mYAEtQrttLrGRwRzKlk+ErMdio1zq
 AOLRFkb2fwaofH63nb4tA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:R0ygRDGouG4=:LN4tgf61Hu6kTa/xPpqowI
 J0K9oesN311D1kPp+0pFlF5/ZizNj9v9pWe9eJBVTq/t6uAKMkoygbf2Q9A3jm2lDDrejfZFv
 3IKg1V3IAHKNcIYE7OzBvDJmbGX1dCQV8pAVo9X1RXGSr1J2LV/kCaPFaHIwZuQM8Af0xw+tC
 Gq+edbm2JifEuOYuTui0qxc9j2dbwWRo2mUW5wnyi2NOmqSObgb4Loqdc8HpjSugYFpyyqgJ1
 jWuaL1vAx445GFaKK44dqt1iFDd0GY3VogZz4HYUQf6k4hno2gvWnApIhS7lws9PyZHf0Pj5S
 wg7gRcYWsFO8WjXWEmqQftswsk+2Oov8HjzGx8qBXKKNjY+jhH8l19IAPNZldSzCL0YSHQKaO
 VGI7HQW3/EKMuTgDqPHMfqXZFqJMu5sjZEGNB7/ox/g70JPYuqf4kHUXFB5aFBNzy3AtE9tKQ
 PZjSqqIdziiglE/q0PbcfwspQZPfO3wpx7j3MHnlhKngjD+R3+jzoGFp4sM6F6NiokMnwq4w3
 B8/nqRpySsoUBfBEVL/i4BkJyq/8ENK1Bh2IYi0uOnyAjvVwABLqc9Vm5FFFToTcDnYVYlpFk
 k/ykGcicTyvQRsQoK6uIttY/I7HlqxjD4J2+6daoGLveaMt0122HmI3zDg7u9721kf4IHrPt8
 nzIIo7alsHqPL9OFqTYX+hqRlWPbVKhbrJDbu/6xwMkxQ1ZO4k/0/qiWiW7pGLavp1cj6kMFU
 /AlcyZ50soTNBOyAmwE72tVFy551CNeHpEy8pQ==
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On linux-4.4 and linux-4.9 we get a warning about an array that is
never initialized when CONFIG_REGULATOR is disabled:

drivers/usb/phy/phy-msm-usb.c: In function 'msm_otg_probe':
drivers/usb/phy/phy-msm-usb.c:1911:14: error: 'regs[0].consumer' may be used uninitialized in this function [-Werror=maybe-uninitialized]
  motg->vddcx = regs[0].consumer;
  ~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~
drivers/usb/phy/phy-msm-usb.c:1912:14: error: 'regs[1].consumer' may be used uninitialized in this function [-Werror=maybe-uninitialized]
  motg->v3p3  = regs[1].consumer;
  ~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~
drivers/usb/phy/phy-msm-usb.c:1913:14: error: 'regs[2].consumer' may be used uninitialized in this function [-Werror=maybe-uninitialized]
  motg->v1p8  = regs[2].consumer;

This adds a Kconfig dependency for it. In newer kernels, the driver no
longer exists, so this is only needed for stable kernels.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/usb/phy/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
index b9c409a18faa..125cea1c3c8d 100644
--- a/drivers/usb/phy/Kconfig
+++ b/drivers/usb/phy/Kconfig
@@ -147,6 +147,7 @@ config USB_MSM_OTG
 	depends on (USB || USB_GADGET) && (ARCH_QCOM || COMPILE_TEST)
 	depends on USB_GADGET || !USB_GADGET # if USB_GADGET=m, this can't be 'y'
 	depends on RESET_CONTROLLER
+	depends on REGULATOR
 	depends on EXTCON
 	select USB_PHY
 	help
-- 
2.9.0

