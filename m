Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3970764-1526044766-2-16198633228036468467
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES ensk.us-asciiro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526044765; b=D+CVenmdEyl0FjTfb1tD2kaUdDJYNB811Zy3jilysvQ7ZHyl1P
    1djGLeu5DkyV6uClwdWPcFJ3mNp8lBh4qKN/jhtJliBYm7JxAYVhR8OyeNHk4CG8
    uprvJ6aLy/NiIeQNnT0q9i9dz+Pn0Hfr5UCLvZMzM95mOCMJMvAWtWH7Y5M6ZIaE
    vMP714ISXZpw8xNQvzo2JxGzSN23Xzh53peIvk3KsRWoBYJ+E6TXAh77pAghflKR
    EV+S10FvFcbbiBivYxWi1++fWLm0NicI7w0Scl9ciHCQaCkpH8fDtkcUBb0szUFv
    U0sIMI+2bcaqoOTXGGbuNxXLz2pZ3QoE9DWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526044765; bh=
    jMIsNuGHaU5xaJOwbj2cvNx/sWvXRKtCFGAbUG7rQqc=; b=liY9i5YW27lfG3BJ
    wAbbaco3CrMCI/YyY4+V4c5GGJ79epg6v7wEL3ZHJbqe4yyVOpWxPxVSp/kPYb9h
    fjOPduItK2e/71O8H5AaEEHftK68RJ3ilY/yxK0Z73lpv3djahfUtcn0EOdqTyVg
    b59cmxpc84y5aAVHAe7dzRH+l+wosMgZtAtbNeYhro4g4O4t/FrabhrljJ8hvi5K
    OrRT0UjKuUCeAvdtZfk9T3HwbqF/RaFPeJ8pDIxvivC656meFpWyrgASN6ZSSd3R
    EkrZI8DYtupYbAoTWEzyhXZ4niy7zJ703HOdz2wgd0YDIo2GMQ1gvwVeaCZ8cWRk
    yseetw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux.intel.com header.result=pass
    header_org.domain=intel.com header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux.intel.com header.result=pass
      header_org.domain=intel.com header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfITqJ7IykMt+8E4oxiKB3EsQb8S7kPYyl16g2DoFsTUiDSZbLiRsQt6Pqb8N37UD1MgitIh7kFNgNdJSEgYT4n/4R5slMEkHGaiLGfG4jvXR5SkVsyx6
    p/O+iwVp9GeTS+Mn1NU8kSbExwHwN0jtX1WLW0dyZmddvfQq+6q6Irnb/Gv+OLY4PP/DYt9FXavq2ztswkRXq+6xib9veSIHsdqzqypTRic5FjOy0rFnYkeF
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=QyXUC8HyAAAA:8
    a=VwQbUJbxAAAA:8 a=kk74zjg4mkyIWxKywmkA:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753006AbeEKNTL (ORCPT <rfc822;greg@kroah.com>);
        Fri, 11 May 2018 09:19:11 -0400
Received: from mga03.intel.com ([134.134.136.65]:43628 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753134AbeEKNSv (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Fri, 11 May 2018 09:18:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,388,1520924400";
   d="scan'208";a="54341754"
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Guenter Roeck <linux@roeck-us.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jun Li <jun.li@nxp.com>, Mats Karrman <mats.dev.list@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3 4/5] usb: typec: pi3usb30532: Start using generic state values
Date: Fri, 11 May 2018 16:18:37 +0300
Message-Id: <20180511131838.62064-5-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180511131838.62064-1-heikki.krogerus@linux.intel.com>
References: <20180511131838.62064-1-heikki.krogerus@linux.intel.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Instead of the tcpm specific mux states, using the generic
USB type-c connector state values.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/typec/mux/pi3usb30532.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/typec/mux/pi3usb30532.c b/drivers/usb/typec/mux/pi3usb30532.c
index b0e88db60ecf..09b711dfe5c3 100644
--- a/drivers/usb/typec/mux/pi3usb30532.c
+++ b/drivers/usb/typec/mux/pi3usb30532.c
@@ -83,13 +83,15 @@ static int pi3usb30532_mux_set(struct typec_mux *mux, int state)
 	new_conf = pi->conf;
 
 	switch (state) {
-	case TYPEC_MUX_NONE:
+	case TYPEC_STATE_SAFE:
 		new_conf = PI3USB30532_CONF_OPEN;
 		break;
-	case TYPEC_MUX_USB:
+	case TYPEC_STATE_USB:
 		new_conf = (new_conf & PI3USB30532_CONF_SWAP) |
-			   PI3USB30532_CONF_USB3;
+			PI3USB30532_CONF_USB3;
 		break;
+	/* To be replaced with actual DisplayPort connector states */
+	/*
 	case TYPEC_MUX_DP:
 		new_conf = (new_conf & PI3USB30532_CONF_SWAP) |
 			   PI3USB30532_CONF_4LANE_DP;
@@ -98,6 +100,9 @@ static int pi3usb30532_mux_set(struct typec_mux *mux, int state)
 		new_conf = (new_conf & PI3USB30532_CONF_SWAP) |
 			   PI3USB30532_CONF_USB3_AND_2LANE_DP;
 		break;
+	*/
+	default:
+		break;
 	}
 
 	ret = pi3usb30532_set_conf(pi, new_conf);
-- 
2.17.0

