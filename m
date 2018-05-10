Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1523401-1525931287-2-814000972352267157
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
    1525931286; b=gHQYb0QV9qnr9mzlVQV6e6cFh38aMyxfmQv+91jzbYiKjRtU9S
    z1u0gZSWAuz1HCCtUoRLkHd2FBrYnKvwz7cNoPuIX14Rj93+02oIGrkpWTNkO7rZ
    3DgZm8PQhpEtFaxnIw3PhrjVJF+3Rc8y+5ZGYN9Ga+tRvIcmMt2/2KRKrfXyOmMJ
    uPChrtDdT9LrkFOdHz1hzyK2+uvCHRpj+AijuA3INmQzWoKA0Gnc1wEAUePuvFZg
    w5wjgSdypzk/B4WT73koQLKFeCawPwSsyxTrzAdH27ipU2bp/fTJxujwJ2JWJZYX
    qsnRuHV568bO/jHUqQ4cJpbn3zCZNWYQEqXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1525931286; bh=ESMZiEzRZiUJnOf/tuNRWGZZHMekog
    D+HUboMET18ps=; b=WsGaTfhxEAnAqkZmrKzRyTfC48GV+jBkMXjGUNh4DOnW9F
    YbsnGcF8pjKd5JVvVCqZKoasOViwmVHXOigfaCLmVWkSb7jbv7XU9fIbWHWbExmv
    kNe9djktxHsWqm31LjvNpQ8iyIesmFlEfWQhIsc18gZLv/E2MsXS60wSOKCybJCG
    QKXrxe3Ci098AZ01ieWDGa5JJVTEjTqAdI1HiTEjppyaMGdIYZqJK/l+Ubu67Nmw
    UvKS9Hipqbk9lBe7aLgd2EN06bzb/APf2kO2PDJNKpIhrJadp6+LK6nPDsoz0AYm
    FDFDEbM/BQyw+R4Zx818AtHa3eJYAxRKND/MEuaQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfJssrc2+6f+W+AhbQJmRnSJf7KV8QOlRLXL6JT25HC9qyOD8xhNek6VtBJcWZt/1HGXX0Q9fis4kInb3BgrOGbEOaHhC8qxznoHdwgLcSwDaFpIE7Upl
    lUp74wB+57WSfh6W9AXH2UigE/MJxWJfZAE9tCxFAdQZxhBGyJPI3/m5F+AR9u2WxBvYsbXT6ZM3RgQdlW7vlPXpBYMdqzd9EoWPGDL6JmBz1dy+DtcEwQvF
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=mpaa-ttXAAAA:8
    a=VwQbUJbxAAAA:8 a=xiyLrrtsVy6n212a4k8A:9 a=x8gzFH9gYPwA:10
    a=6heAxKwa5pAsJatQ0mat:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756697AbeEJFrv (ORCPT <rfc822;greg@kroah.com>);
        Thu, 10 May 2018 01:47:51 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:48794 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756662AbeEJFrd (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 10 May 2018 01:47:33 -0400
X-UUID: e45a7e7f885148cd95998017900df11d-20180510
From: Chunfeng Yun <chunfeng.yun@mediatek.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
CC: Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v2 2/7] usb: mtu3: remove repeated setting of gadget state
Date: Thu, 10 May 2018 13:47:07 +0800
Message-ID: <affcd9dfe86a0dceda1151cf7d39ce880fae14fb.1525930818.git.chunfeng.yun@mediatek.com>
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

The usb_add_gadget_udc() will set the gadget state as
USB_STATE_NOTATTACHED, so we needn't set it again.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/mtu3_gadget.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3_gadget.c b/drivers/usb/mtu3/mtu3_gadget.c
index f05f10f..de0de01 100644
--- a/drivers/usb/mtu3/mtu3_gadget.c
+++ b/drivers/usb/mtu3/mtu3_gadget.c
@@ -660,14 +660,10 @@ int mtu3_gadget_setup(struct mtu3 *mtu)
 	mtu3_gadget_init_eps(mtu);
 
 	ret = usb_add_gadget_udc(mtu->dev, &mtu->g);
-	if (ret) {
+	if (ret)
 		dev_err(mtu->dev, "failed to register udc\n");
-		return ret;
-	}
 
-	usb_gadget_set_state(&mtu->g, USB_STATE_NOTATTACHED);
-
-	return 0;
+	return ret;
 }
 
 void mtu3_gadget_cleanup(struct mtu3 *mtu)
-- 
1.9.1

