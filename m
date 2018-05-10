Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1523401-1525931345-2-722031928928439076
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, UNPARSEABLE_RELAY 0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525931344; b=V/NAuAxc/Q2m/6uN6pXeGMdtpRoiXB3GSLAaeNW65MFG/1m4d6
    NJIf1TAN6uMZ4zDKY6wfLUr738fH062QJD9+NCjd09Y4uMYdidDrJFZTTUb7pwzF
    w8rNiL0MUaTw4BdWydLW8IXUDaSD7UyMgix4Qhbpc7hqILQvYdkyst74BsLN173R
    adcxIVFsiGzsEpMp0lzmpprq2VMtBwwpRgyVf9+uOere4TPDViUrD5/qOidhtPUp
    e0GOFCHwwPO/s0Jzcbz7FOFeAUWA+C/udhcL86eGB8tZQqSWVko11RqNpZ5JOU5n
    fRa5d0DGhHVY+3AEVNEDfZM85RQizJKpysMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1525931344; bh=d3jrdG/py/PvhBeJLR2GcbQLr2cqkT
    JB67gUgG+Nqqk=; b=eUmU2cHWl/LKQcwnWEm8RzdbaQFWwbxiEXUbsJtPqEoElX
    eGCU4awkJ8S90OZuHfUWu9WuPuwRJhsYVXajk8ySDGEZEhyeVGkbDZJ0qZ/vV6GM
    HPFwyPi00mhYtPQdC+CpBAaRlYcjhzGuF6Gyu17K9zumxIsmALrLFNGEDUczI8Dt
    NfqlbYbEldT/P4JyuPgJD1eyIHrMhCN17HFgs5ZHhfYYF37RHYRsqBIsZLASi97l
    34lPzAB1XIlPcEY4A7ufM4k9IjBdlVrQP1NUipitmaWZsaLZ2iVUq3/fwiWB239U
    MQVx2fSOWCMMBnv16O7P4koCAr2B1f/J6zNN4zfw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mediatek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=mediatek.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mediatek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=mediatek.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDhaXdRcUYDvQnviBKgkqitUEvEF0LsCQLRUxkUlS/oJnKmqCnpm8hmYkmB4YErFk6TV3Iekcie0TggRplZ0jdXfTDm4xwb0SJ/qgx88bdGXXCCAqMWx
    zf+m515dGIbACn6wtk+F53Y+5HvXwPyQ/EDzy/8I+Kq3RclunOc3NYD57xz4bhJqT3Y1NK2dgzdTLn/0DIAD8ooxI+ZVER76/iMBd5kiIs7DmLT+lUJpApCN
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=mpaa-ttXAAAA:8
    a=VwQbUJbxAAAA:8 a=m-Vw8LavUTyuxteSGH4A:9 a=x8gzFH9gYPwA:10
    a=6heAxKwa5pAsJatQ0mat:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756725AbeEJFsn (ORCPT <rfc822;greg@kroah.com>);
        Thu, 10 May 2018 01:48:43 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:49470 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753633AbeEJFr0 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 10 May 2018 01:47:26 -0400
X-UUID: 399c5e5fb68042cda549564cad0892b7-20180510
From: Chunfeng Yun <chunfeng.yun@mediatek.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
CC: Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v2 5/7] usb: mtu3: make USB_MTU3_DUAL_ROLE depend on EXTCON but not USB_MTU3
Date: Thu, 10 May 2018 13:47:10 +0800
Message-ID: <70bbec675e9624dc4aed71481f38111fcf4bc002.1525930818.git.chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <6b82c11302a81368bd6936424d081ede3340b431.1525930818.git.chunfeng.yun@mediatek.com>
References: <6b82c11302a81368bd6936424d081ede3340b431.1525930818.git.chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In fact the driver depends on EXTCON only when it's configed as
USB_MTU3_DUAL_ROLE, so make USB_MTU3_DUAL_ROLE depend on EXTCON but
not USB_MTU3.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/mtu3/Kconfig b/drivers/usb/mtu3/Kconfig
index 25cd619..8daf277 100644
--- a/drivers/usb/mtu3/Kconfig
+++ b/drivers/usb/mtu3/Kconfig
@@ -2,7 +2,7 @@
 
 config USB_MTU3
 	tristate "MediaTek USB3 Dual Role controller"
-	depends on EXTCON && (USB || USB_GADGET) && HAS_DMA
+	depends on (USB || USB_GADGET) && HAS_DMA
 	depends on ARCH_MEDIATEK || COMPILE_TEST
 	select USB_XHCI_MTK if USB_SUPPORT && USB_XHCI_HCD
 	help
@@ -40,6 +40,7 @@ config USB_MTU3_GADGET
 config USB_MTU3_DUAL_ROLE
 	bool "Dual Role mode"
 	depends on ((USB=y || USB=USB_MTU3) && (USB_GADGET=y || USB_GADGET=USB_MTU3))
+	depends on (EXTCON=y || EXTCON=USB_MTU3)
 	help
 	  This is the default mode of working of MTU3 controller where
 	  both host and gadget features are enabled.
-- 
1.9.1

