Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3869096-1522702394-2-5618881470098893649
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522702394; b=m2UvFTKgSp2simD59zVsBxlQxIcY+j+fgkhRNT7cX1M/d4ZELv
    jo0/WRtL0u0+CkuxC0R6Qc6OavC7862Vs+kxtAZic227KJKny/xCOcVJ9i5H6FUL
    NT7x8xtioFvm0WPJXwvfdP+8ZL4/DIg4bvJtFC42hDTaguR6mHlcq1mNeChkusSn
    N9scLleL/acfWetf4TXMXFdgR7FNtdoVviVjg+Mu6ggCojz+IZgId5LYZC9Y9Djf
    ulQf/DVmjNNecTmogvKSFN24ePLsKAKms4Nw6JmlWSQX1IQsuE+D7IZts6YU9LNn
    TpGvGds5HSsPhnqwjnTuOQvjgk77aKElGGpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1522702394; bh=
    DfCAIU2jkp42MIJjYCU+NI69m5ALgp//r1rxgYq93Ug=; b=bb2og4WbytlnYuTs
    9Vadoy0iKbIdEdXC/avBPykhXou727vwg9+JKAiyYoUqigXN0Qs4nf+60WwAt3M9
    DvR/9ewBc1RgMGzbpMLVfszNu0nMr6snbygTOVAkh71G7ibK4xu7oTkFj9ifC9r8
    DxFSwd10xXS5qbQ+feZKUNss0H7/VJ1RdDbEivywZcsE/yGLbNVMISSpBb5oU6mN
    BDLNOSRVQK4ndYHY+aR2PAIN/3tCuf4QgBl45H1Rky0UwP4ZQqolVMsIFd48Ewtb
    gJw0HCR+I/P5U7Osir7Y5K/5vWqCESicn1KkzWjvEg4U8llNyNs42sBdGuzcW/JU
    XGR71w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfONjMCVUnbRcyMDVh3ku8l0Tyb62pfuxs/tUy4CExEFvL2IePxSbV0Jd7+qU0c/9sGqAU6gq/5QN4yx+Sf7iW8vL5U1WN97vL1NUm91sSPFsG3+3tunk
    n0oN6cHCXU2VswboyiC+xFYj80reKbRFLQ+ZkjVdI8FIAzV7uFE2X/kf5iFr+OvKFHagxdqDm4ZQx6eHrqCwSw7Zu0jYQW4f837J1VA1YfN+13aPQFyEvaB+
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=hD80L64hAAAA:8
    a=VwQbUJbxAAAA:8 a=-yexfZKO-uF4pAQBvgUA:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754178AbeDBUw5 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 2 Apr 2018 16:52:57 -0400
Received: from osg.samsung.com ([64.30.133.232]:35974 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753116AbeDBUw4 (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Mon, 2 Apr 2018 16:52:56 -0400
From: Shuah Khan <shuahkh@osg.samsung.com>
To: valentina.manea.m@gmail.com, shuah@kernel.org,
        gregkh@linuxfoundation.org
Cc: Shuah Khan <shuahkh@osg.samsung.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usbip: vhci_hcd: Fix usb device and sockfd leaks
Date: Mon,  2 Apr 2018 14:52:32 -0600
Message-Id: <20180402205232.21659-2-shuahkh@osg.samsung.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180402205232.21659-1-shuahkh@osg.samsung.com>
References: <20180402205232.21659-1-shuahkh@osg.samsung.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

vhci_hcd fails to do reset to put usb device and sockfd in the
module remove/stop paths. Fix the leak.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
Cc: stable <stable@vger.kernel.org>
---
 drivers/usb/usbip/usbip_common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/usbip/usbip_common.h b/drivers/usb/usbip/usbip_common.h
index 473fb8a87289..bf8afe9b5883 100644
--- a/drivers/usb/usbip/usbip_common.h
+++ b/drivers/usb/usbip/usbip_common.h
@@ -243,7 +243,7 @@ enum usbip_side {
 #define	VUDC_EVENT_ERROR_USB	(USBIP_EH_SHUTDOWN | USBIP_EH_UNUSABLE)
 #define	VUDC_EVENT_ERROR_MALLOC	(USBIP_EH_SHUTDOWN | USBIP_EH_UNUSABLE)
 
-#define	VDEV_EVENT_REMOVED	(USBIP_EH_SHUTDOWN | USBIP_EH_BYE)
+#define	VDEV_EVENT_REMOVED (USBIP_EH_SHUTDOWN | USBIP_EH_RESET | USBIP_EH_BYE)
 #define	VDEV_EVENT_DOWN		(USBIP_EH_SHUTDOWN | USBIP_EH_RESET)
 #define	VDEV_EVENT_ERROR_TCP	(USBIP_EH_SHUTDOWN | USBIP_EH_RESET)
 #define	VDEV_EVENT_ERROR_MALLOC	(USBIP_EH_SHUTDOWN | USBIP_EH_UNUSABLE)
-- 
2.14.1

