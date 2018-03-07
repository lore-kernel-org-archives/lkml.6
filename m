Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-29808-1520455446-2-17633367860129727270
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520455445; b=gEN/HvYXPoM6zQoijBpPU57Vlypzi52HRJgGPlhv+hZoD9c
    OI2FxwOoC87blPKampIWuOHH5rldJ5o3tbHr3dflOLp6CzGNQqOCDqxTQkwSvoGc
    66HsIOkCNrCIDK7ZA+lsuJ50N6RGZEvoqip/p12Wa1UAzGBI60kQrySD4YxDb9gL
    M4oZVE0lcnYzcEKFKE1IQwFIZdY1ThLbDWGjYf4/J1Q2nyYChB3C+eFkcv6R1vLL
    4QzfpB66qRxaWok/6J7vGipJOPgwbMGTmW8dvKfmdAIW1GCmQrYAMN+D8On3JzHd
    bdqqmmtEa4w78/77ESKRyWGpkiH6cZa1REviBlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:in-reply-to:references:sender:list-id;
    s=arctest; t=1520455445; bh=QbW859QzbbSCqw7lpOoC/9WVMA58Dzf7dHM
    wL4HpeMs=; b=tgYU/cKq4I0URbTjGBCjLdrRJW0Z5A3PdjiwaL6kCuDcvmcvr+i
    vYCCkX3mBxpx22QfSVSjguECZKpFNXt7UFQ7wkudFj+isE+CWb4Gr/uRkW/UKYDE
    WaqPgwZ2thEIBOy0/21mAxGdIQeAXYxPzh8qbzgPq+Cs6TzGATPVoke+YxAxfFC6
    Mu0ZmxQViTyB3duXVGLBdQ3LeLgq6PckhVQM00IHJWfvxfIUuqZq7/BQWjOkxQHT
    62rcI0lcLmY6W3SfpBwYkrG9ffu6NDFc4v06D5IXC1iA9Bb0/VWl+nOCjfLUo33v
    QmpjPN0Kxnk+EWBmUp6Pec+KrLBR+IGl0BA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=25 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=25 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934759AbeCGUmx (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 15:42:53 -0500
Received: from osg.samsung.com ([64.30.133.232]:62167 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934747AbeCGUmv (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Wed, 7 Mar 2018 15:42:51 -0500
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
From: Shuah Khan <shuahkh@osg.samsung.com>
To: valentina.manea.m@gmail.com, shuah@kernel.org,
        gregkh@linuxfoundation.org
Cc: Shuah Khan <shuahkh@osg.samsung.com>, yuyang.du@intel.com,
        k.opasiak@samsung.com, nobuo.iwata@fujixerox.co.jp,
        julien.boibessot@armadeus.com, jdieter@lesbg.com,
        peter.senna@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] usbip: usbip_host_common: Use new error codes to return request status
Date: Wed,  7 Mar 2018 13:42:25 -0700
Message-Id: <396a52023e61a8f68e66dd9d37c44ea06fd731a4.1520455011.git.shuahkh@osg.samsung.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1520455010.git.shuahkh@osg.samsung.com>
References: <cover.1520455010.git.shuahkh@osg.samsung.com>
In-Reply-To: <cover.1520455010.git.shuahkh@osg.samsung.com>
References: <cover.1520455010.git.shuahkh@osg.samsung.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Currently ST_OK and ST_NA are the only values used to communicate
status of a request from a client. Use new error codes to clearly
indicate what failed. For example, when client sends request to
import a device that isn't export-able, send ST_DEV_BUSY to the client.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
---
 tools/usb/usbip/libsrc/usbip_host_common.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/usb/usbip/libsrc/usbip_host_common.c b/tools/usb/usbip/libsrc/usbip_host_common.c
index 6ff7b601f854..dc93fadbee96 100644
--- a/tools/usb/usbip/libsrc/usbip_host_common.c
+++ b/tools/usb/usbip/libsrc/usbip_host_common.c
@@ -234,14 +234,17 @@ int usbip_export_device(struct usbip_exported_device *edev, int sockfd)
 		switch (edev->status) {
 		case SDEV_ST_ERROR:
 			dbg("status SDEV_ST_ERROR");
+			ret = ST_DEV_ERR;
 			break;
 		case SDEV_ST_USED:
 			dbg("status SDEV_ST_USED");
+			ret = ST_DEV_BUSY;
 			break;
 		default:
 			dbg("status unknown: 0x%x", edev->status);
+			ret = -1;
 		}
-		return -1;
+		return ret;
 	}
 
 	/* only the first interface is true */
-- 
2.14.1

