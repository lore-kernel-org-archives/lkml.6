Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1049172-1519203472-2-13379654360782283195
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519203472; b=mnqqDX5iWtqw8OEPNNGFuQOFb8QdbMG0TGchtzVS9c0evOz
    nizhGbpQvWlOprlOYj3itNciCkV6EdVYwUPvwwA1NfCbiOAfXQrEXPvoST6/BNkB
    93SFWKSvWJWDRz7T1Eso58utjT3V77fWCdOqNo0hlOeBqbFw15CsnpuG6X/aMn2L
    qVIdRSoVdD4rk1mAyXnU6Rs8xmB4vgCBNo4ZcbG/DOFZG8BEGk05lNo8j6vAJ3B8
    5cEMJlaQ1D/MraUNuVpa/Mb3jj0Bq7r+2Mo6202tn1wNJXtWlpmLqQfRGBTLiCWM
    +6RS++s2ffX2wxvDfbafIQ6q0mAqunkGGJLMVtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519203472;
    bh=mr7gf62V4U79ARIUVqoHcehBY8W4+5Q5P3QG9FN85nA=; b=qQXoLruzgQIU
    oNW/twa2K3BJ3l0wJsYszqjOjW/7klBIa4KScbg9JkX0dth9z9+eESXQ3wi9k+TP
    jrdU8AC2tkevXzj6sLQrJOUYTDVllbm1wv0CvBeomHcQvddsTN55xuLr0/zX7jOT
    TRiYHnn1S1UgauYJ7pZkQnECVUJabENppeu3lAQ/V0F2pJfREidh46toR30S7xWw
    QA9CTKZmkmdGCW/oPw53WTS1jp5rmNtc0d02JnxDsJBCnVVCSxGPrcYi/Qxc7uX1
    Cnp3Mp8vlU6wqIx5hM6/pXPE1KAU8JQRoDZpvVBKrmfckge5jQyD4NFvCJ1CsZsV
    iSDMp3tIMg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=Y1lBWqEJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=Y1lBWqEJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752170AbeBUI5h (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 03:57:37 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:54321 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752629AbeBUI4M (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 21 Feb 2018 03:56:12 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180221085610euoutp01f870dbf6b39d0cce3651c10cd745f702~VS2p-qCeU2475124751euoutp01K
X-AuditID: cbfec7f2-5ffe19c000011644-4b-5a8d3429323a
From: Andrzej Hajda <a.hajda@samsung.com>
To: devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Cc: Andrzej Hajda <a.hajda@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        dri-devel@lists.freedesktop.org, Inki Dae <inki.dae@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH v4 5/6] extcon: add possibility to get extcon device by OF
 node
Date: Wed, 21 Feb 2018 09:55:40 +0100
Message-id: <20180221085541.14556-6-a.hajda@samsung.com>
X-Mailer: git-send-email 2.16.1
In-reply-to: <20180221085541.14556-1-a.hajda@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMIsWRmVeSWpSXmKPExsWy7djPc7qaJr1RBlOOCFncWneO1aKp4y2r
        xcYZ61ktrn95zmox/whQ7MrX92wWk+5PYLE4f34Du0XnxCXsFpseX2O1uLxrDpvFjPP7mCwW
        LWtltlh75C67xdLrF5ksWvceYXcQ8Fgzbw2jx+W+XiaP2R0zWT02repk87jffZzJY/OSeo++
        LasYPT5vkgvgiOKySUnNySxLLdK3S+DKOHtjB3vBZ6mKQ8++MjUwHhfrYuTkkBAwkfh6dSF7
        FyMXh5DACkaJyXv2MEE4nxklPt15zgJT9WLhZBaIxDJGifs7dzFCOP8ZJb4cXcoGUsUmoCnx
        d/NNMFtEIFbi3aVdzCBFzAIXWCQunH7FDpIQFgiUmL/1EZjNIqAqsXfmTrAGXgELifeLP7BD
        rJOXOPymiRXE5hSwlPi9dxLYIAmB22wSr842MUEUuUi0P/jACmELS7w6vgWqWUais+MgE0RD
        N6PEqX2dUN1TGCXOv7oM1W0tcfj4RbBuZgE+iUnbpgMVcQDFeSU62oQgSjwkvm7rgyp3lJi6
        4y0rxM89jBL7J79in8AotYCRYRWjeGppcW56arFhXmq5XnFibnFpXrpecn7uJkZgUjj97/in
        HYxfLyUdYhTgYFTi4bXQ6YkSYk0sK67MPcQowcGsJMJbKdQbJcSbklhZlVqUH19UmpNafIhR
        moNFSZw3TqMuSkggPbEkNTs1tSC1CCbLxMEp1cDYsDzt2ylrfvWDl40nTZC+FKJ7RvhhQGDD
        C7cZxiebr3I9dZRa4lH3eZFEo1K41FatJVse3z15fMcvqYoCf78by8s8zbOabLs4m9bHWcbd
        Sd4Z/CXFhT9pvuXq02fYj3EZWR00cPtl/vxs/bMWc/tjIhX+hsJn18uvabMRv+audaFgymvf
        u0ZKLMUZiYZazEXFiQBGfLpuBgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrELMWRmVeSWpSXmKPExsVy+t/xa7oaJr1RBl//GFvcWneO1aKp4y2r
        xcYZ61ktrn95zmox/whQ7MrX92wWk+5PYLE4f34Du0XnxCXsFpseX2O1uLxrDpvFjPP7mCwW
        LWtltlh75C67xdLrF5ksWvceYXcQ8Fgzbw2jx+W+XiaP2R0zWT02repk87jffZzJY/OSeo++
        LasYPT5vkgvgiOKySUnNySxLLdK3S+DKOHtjB3vBZ6mKQ8++MjUwHhfrYuTkkBAwkXixcDIL
        iC0ksIRR4tX58C5GLiC7kUni0L0dYAk2AU2Jv5tvsoHYIgKxEm9PfWYGKWIWuMAi8XviTHaQ
        hLCAv8TThTfAbBYBVYm9M3eCNfAKWEi8X/yBHWKbvMThN02sIDangKXE772TmCE2W0h8OPeV
        fQIjzwJGhlWMIqmlxbnpucWGesWJucWleel6yfm5mxiBIbvt2M/NOxgvbQw+xCjAwajEw2uh
        0xMlxJpYVlyZe4hRgoNZSYS3Uqg3Sog3JbGyKrUoP76oNCe1+BCjNAeLkjjveYPKKCGB9MSS
        1OzU1ILUIpgsEwenVAOjn7vLB44aOf0kOR2pAONbcyoTepMP9aZ4H7yqXGI0JzFlXfnSEzYp
        iwyO9PHO/PvpXU5pbVyuv8FXEelXmWfy9vxkLfnQnn9jh+7zdYLmSy/mrbK2P2Yz6avpae1t
        4v8btv7//L8zd5+BYcq+wPDnRd13v2ZMjHMvcmFaLTd17ZIe2a38JeeVWIozEg21mIuKEwGD
        oLF2VQIAAA==
X-CMS-MailID: 20180221085608eucas1p162d2e579a1cc887672b722458edb98fe
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180221085608eucas1p162d2e579a1cc887672b722458edb98fe
X-RootMTR: 20180221085608eucas1p162d2e579a1cc887672b722458edb98fe
References: <20180221085541.14556-1-a.hajda@samsung.com>
        <CGME20180221085608eucas1p162d2e579a1cc887672b722458edb98fe@eucas1p1.samsung.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Since extcon property is not allowed in DT, extcon subsystem requires
another way to get extcon device. Lets try the simplest approach - get
edev by of_node.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
---
v2: changed label to follow local convention (Chanwoo)
---
 drivers/extcon/extcon.c | 44 ++++++++++++++++++++++++++++++++++----------
 include/linux/extcon.h  |  6 ++++++
 2 files changed, 40 insertions(+), 10 deletions(-)

diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index cb38c2747684..c4972c4cb3bd 100644
--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
@@ -1336,6 +1336,28 @@ void extcon_dev_unregister(struct extcon_dev *edev)
 EXPORT_SYMBOL_GPL(extcon_dev_unregister);
 
 #ifdef CONFIG_OF
+
+/*
+ * extcon_get_edev_by_of_node - Get the extcon device from devicetree.
+ * @node	: OF node identyfying edev
+ *
+ * Return the pointer of extcon device if success or ERR_PTR(err) if fail.
+ */
+struct extcon_dev *extcon_get_edev_by_of_node(struct device_node *node)
+{
+	struct extcon_dev *edev;
+
+	mutex_lock(&extcon_dev_list_lock);
+	list_for_each_entry(edev, &extcon_dev_list, entry)
+		if (edev->dev.parent && edev->dev.parent->of_node == node)
+			goto out;
+	edev = ERR_PTR(-EPROBE_DEFER);
+out:
+	mutex_unlock(&extcon_dev_list_lock);
+
+	return edev;
+}
+
 /*
  * extcon_get_edev_by_phandle - Get the extcon device from devicetree.
  * @dev		: the instance to the given device
@@ -1363,25 +1385,27 @@ struct extcon_dev *extcon_get_edev_by_phandle(struct device *dev, int index)
 		return ERR_PTR(-ENODEV);
 	}
 
-	mutex_lock(&extcon_dev_list_lock);
-	list_for_each_entry(edev, &extcon_dev_list, entry) {
-		if (edev->dev.parent && edev->dev.parent->of_node == node) {
-			mutex_unlock(&extcon_dev_list_lock);
-			of_node_put(node);
-			return edev;
-		}
-	}
-	mutex_unlock(&extcon_dev_list_lock);
+	edev = extcon_get_edev_by_of_node(node);
 	of_node_put(node);
 
-	return ERR_PTR(-EPROBE_DEFER);
+	return edev;
 }
+
 #else
+
+struct extcon_dev *extcon_get_edev_by_of_node(struct device_node *node)
+{
+	return ERR_PTR(-ENOSYS);
+}
+
 struct extcon_dev *extcon_get_edev_by_phandle(struct device *dev, int index)
 {
 	return ERR_PTR(-ENOSYS);
 }
+
 #endif /* CONFIG_OF */
+
+EXPORT_SYMBOL_GPL(extcon_get_edev_by_of_node);
 EXPORT_SYMBOL_GPL(extcon_get_edev_by_phandle);
 
 /**
diff --git a/include/linux/extcon.h b/include/linux/extcon.h
index 6d94e82c8ad9..b47e0c7f01fe 100644
--- a/include/linux/extcon.h
+++ b/include/linux/extcon.h
@@ -230,6 +230,7 @@ extern void devm_extcon_unregister_notifier_all(struct device *dev,
  * Following APIs get the extcon_dev from devicetree or by through extcon name.
  */
 extern struct extcon_dev *extcon_get_extcon_dev(const char *extcon_name);
+extern struct extcon_dev *extcon_get_edev_by_of_node(struct device_node *node);
 extern struct extcon_dev *extcon_get_edev_by_phandle(struct device *dev,
 						     int index);
 
@@ -283,6 +284,11 @@ static inline struct extcon_dev *extcon_get_extcon_dev(const char *extcon_name)
 	return ERR_PTR(-ENODEV);
 }
 
+static inline struct extcon_dev *extcon_get_edev_by_of_node(struct device_node *node)
+{
+	return ERR_PTR(-ENODEV);
+}
+
 static inline struct extcon_dev *extcon_get_edev_by_phandle(struct device *dev,
 				int index)
 {
-- 
2.16.1

