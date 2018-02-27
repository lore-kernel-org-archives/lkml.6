Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2581406-1519770287-2-14229964450597617318
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES ensvda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519770287; b=gCS5YN+Xmql6V4RKuI3w8CiS27VjAwKx8UnyrKrTSD3CTfb
    pFsShlalWbbXjXVFW4IHZR6ykSxIxaTykjKfrkc4YnpS77kDUETYw61gC17ceUz0
    DP2lCG95lGIknlP8w+UU8veI2kF3dEqcQzNf31jmWLNWuTgzNPPK4hQj3xvA3e1R
    zSW/Zt1LP8oOEOjnB9WOdXrDtgIZEMqzeua613exy6pZcIFeW9/9X9OAuBh0xETc
    R+CGHSmuqsDmzYng9oDn9h25n5+fL+i5Q/u4qfld0VzthZ7kxq5yxz0pyGt15V2U
    1KTDskV29BbKRvqUeHjDfS5pKIAKpZx6XaGKEFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519770287;
    bh=ytq3QUldzt5kiMmi4KR52GUyHctxm7lThsD7joS/abE=; b=uP7b/ju3JQFQ
    P+Ja/mVFDQ1uTh3My5T5SAasdYCFRXV+kf3PMNYxrcZWqF/qSbthqdJPM6jrP+sw
    mROzxKLvfN54NhybR5/Y3OtEfJGddfKBzbrDIgbQbCPkvPZ/FPvojXV7DJkkPUfg
    fCzHt30436XzA9rBeFgX9ZlzK0jQZKOPt1tmRiALH9EFcsNccF25f/jjS5zwuKiz
    HRz33Ui9kZhsl39P02DCMRx0RwoDyXoX7Swz0gnC1lMT9+sfPr6/cN+OoIz2pAN5
    grW5b75I+eWBQghdJ9bB2sSX9FXMK+IBwV/Xbf5J0idfrQZk0sIMvuVac6eOLrMC
    md81b3QjoQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751932AbeB0WYV (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 17:24:21 -0500
Received: from osg.samsung.com ([64.30.133.232]:55022 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751836AbeB0WYU (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Tue, 27 Feb 2018 17:24:20 -0500
From: Shuah Khan <shuahkh@osg.samsung.com>
To: valentina.manea.m@gmail.com, shuah@kernel.org,
        gregkh@linuxfoundation.org
Cc: Shuah Khan <shuahkh@osg.samsung.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usbip: tools usbip_network: Fix cryptic error messages
Date: Tue, 27 Feb 2018 15:23:56 -0700
Message-Id: <20180227222356.23245-2-shuahkh@osg.samsung.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180227222356.23245-1-shuahkh@osg.samsung.com>
References: <20180227222356.23245-1-shuahkh@osg.samsung.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Kernel and tool version mismatch message is cryptic. Fix it to be
informative.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
---
 tools/usb/usbip/src/usbip_network.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/usb/usbip/src/usbip_network.c b/tools/usb/usbip/src/usbip_network.c
index b4c37e76a6e0..90325fa8bc38 100644
--- a/tools/usb/usbip/src/usbip_network.c
+++ b/tools/usb/usbip/src/usbip_network.c
@@ -179,8 +179,8 @@ int usbip_net_recv_op_common(int sockfd, uint16_t *code)
 	PACK_OP_COMMON(0, &op_common);
 
 	if (op_common.version != USBIP_VERSION) {
-		dbg("version mismatch: %d %d", op_common.version,
-		    USBIP_VERSION);
+		err("USBIP Kernel and tool version mismatch: %d %d:",
+		    op_common.version, USBIP_VERSION);
 		goto err;
 	}
 
-- 
2.14.1

