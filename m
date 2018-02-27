Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1435288-1519734159-2-4867361586625380878
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
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
    t=1519734158; b=KIIsamvSCp/gRxXMhKSujN6cZp5AN2S0WMqIi/dxXrv/b7n
    7yOwXHAIAWYQbH/WO84CB2QrK6D3LtA00AnoAl7cuYzb0IbpM9ZP3TQnqYhKFsrC
    9tP7fSEbBORoDw3VLNpGR63PCE7qnURnicIFQN8E7VbUIXthNrLCSSQalDVZUJZU
    6i+rrS2ucJ6CLYSDQySyK8qlMIyl2pk77UcQrTMzDGgQrKT0BwKZJO/+Pc3reRww
    /grEz0WMP9kUf/jOfmPOOriz7Khm2YLUAfld5Ae/BNTutpm5Fl/5wGvy78VTPGGM
    7bY2Bh8LgLyGXXAZjZJC6P/+mOAuqMuxuZc43pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519734158;
    bh=PfICIDybBZQb5UQQy1oZrj2LMbMSMsxiG/elRsAK99U=; b=TSn6ZpRPUC4P
    JFRdoHstSmIi/x06GoHiCVO/yC2lQ1+PkftJI008y73P0qSnLrDmjZaiMfRvgt0D
    VEE7+/K3IxEbl3glJ9bDsovIu920zls9h5VAZAv4j6IBLeYdJmdhRnOfL4/LNMgj
    mScKxXqYfWm+itODlK+4AHicQ8jDNXdJMpSe8MadDJ1AV8VHR0EA7/XrfN/V0Gja
    KoWJo4opujmTr9jOGE19O27fH0QVzoPFYLz3N4/jofTZvxkib61v/pNW8CsMQsod
    +7Euk9mhkLI7d8/ICpRAtXCmNCdgATFm6YcYjpyAoQrPyat4u2vrobdvwg+UT7ri
    ivqNIuimsQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=O+6OOU7n x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=O+6OOU7n x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752542AbeB0MWW (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 07:22:22 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:53588 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752049AbeB0MWU (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 27 Feb 2018 07:22:20 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180227122217euoutp0263435189cc87d00473cdd6ef0a03e223~XLiVub8uW1494814948euoutp02r
X-AuditID: cbfec7f2-1dbff70000011644-21-5a954d783c3b
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
Subject: [PATCH v6 5/6] extcon: add possibility to get extcon device by OF
 node
Date: Tue, 27 Feb 2018 13:22:07 +0100
Message-id: <20180227122207.23056-1-a.hajda@samsung.com>
X-Mailer: git-send-email 2.16.2
In-reply-to: <5A953AF2.6030501@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEIsWRmVeSWpSXmKPExsWy7djPc7oVvlOjDBZOEba4te4cq0VTx1tW
        i40z1rNaXP/ynNVi/hGg2JWv79ksJt2fwGJx/vwGdovOiUvYLTY9vsZqcXnXHDaLGef3MVks
        WtbKbLH2yF12i6XXLzJZtO49wu4g4LFm3hpGj8t9vUwesztmsnpsWtXJ5nG/+ziTx+Yl9R59
        W1YxenzeJBfAEcVlk5Kak1mWWqRvl8CVcWzid/aC+dIVf/snMjUwvhHrYuTkkBAwkdjfsZml
        i5GLQ0hgBaPEjnvboJzPjBL3ryxjhanqm7qRFSKxjFHi3pSjUM5/RolF/z+xgFSxCWhK/N18
        kw3EFhGIlXh3aRczSBGzwAUWiQunX7GDJIQFAiX+Xf/JBGKzCKhKfJvwmxHE5hWwkFi5dhEz
        xDp5iYVnr4LZnALaEj9PX2MHGSQhcJ9N4tmkuywQRS4S6z9ugbKFJV4d38IOYctIXJ7czQLR
        0M0ocWpfJzOEM4VR4vyry0wQVdYSh49fBPuOWYBPYtK26UBFHEBxXomONiGIEg+J3W/+QAPA
        EcjuAmsVEqiTWPF8IfsERqkFjAyrGMVTS4tz01OLDfNSy/WKE3OLS/PS9ZLzczcxAlPC6X/H
        P+1g/Hop6RCjAAejEg/vDLkpUUKsiWXFlbmHGCU4mJVEeFcunhwlxJuSWFmVWpQfX1Sak1p8
        iFGag0VJnDdOoy5KSCA9sSQ1OzW1ILUIJsvEwSnVwBgzR/NyRj/37Mmr2gTrldTlz59o9nkb
        JRAw1fjMkerWN6wxMfsY19cVHJ8du3hqxC1jwR+3eY51sfBuOvzr6ATFTSJiGqfj64wnWG7g
        TTzF+Ya7tcqukM9Gd3WoccfCwG7Td7Yb2MwLfh2z9VkjOYn9bnKSoNQz/5/rr9flJ7YGF5e/
        dLn9SImlOCPRUIu5qDgRAMJ1sq8FAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMLMWRmVeSWpSXmKPExsVy+t/xy7rlvlOjDN6eULe4te4cq0VTx1tW
        i40z1rNaXP/ynNVi/hGg2JWv79ksJt2fwGJx/vwGdovOiUvYLTY9vsZqcXnXHDaLGef3MVks
        WtbKbLH2yF12i6XXLzJZtO49wu4g4LFm3hpGj8t9vUwesztmsnpsWtXJ5nG/+ziTx+Yl9R59
        W1YxenzeJBfAEcVlk5Kak1mWWqRvl8CVcWzid/aC+dIVf/snMjUwvhHrYuTkkBAwkeibupG1
        i5GLQ0hgCaPE15dboZxGJolz+6awglSxCWhK/N18kw3EFhGIlXh76jMzSBGzwAUWid8TZ7KD
        JIQF/CVmv2thBrFZBFQlvk34zQhi8wpYSKxcu4gZYp28xMKzV8FsTgFtiZ+nr4H1CgloSWw7
        vphxAiPPAkaGVYwiqaXFuem5xUZ6xYm5xaV56XrJ+bmbGIFBu+3Yzy07GLveBR9iFOBgVOLh
        nSE3JUqINbGsuDL3EKMEB7OSCO/KxZOjhHhTEiurUovy44tKc1KLDzFKc7AoifOeN6iMEhJI
        TyxJzU5NLUgtgskycXBKNTBGrKpfZp+65OahN2tT54cozi4L/PFHIU/lywcWhmeq2leLDXhm
        Cqzg7djxd4PYW4nMqDvu2UJqfNuP97mqu1zR3HbhfP58TvsUxiXuCQkyTwQuC8ttiPl+j2el
        nGLFPj09q1/GZ/fefvSq8Od21x+cifYCy3exF0ypbjvW8Emk+qX1rbuXZu9UYinOSDTUYi4q
        TgQAxIwaclYCAAA=
X-CMS-MailID: 20180227122215eucas1p11a1a12c26665f032c666d10effaf15fc
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180227122215eucas1p11a1a12c26665f032c666d10effaf15fc
X-RootMTR: 20180227122215eucas1p11a1a12c26665f032c666d10effaf15fc
References: <5A953AF2.6030501@samsung.com>
        <CGME20180227122215eucas1p11a1a12c26665f032c666d10effaf15fc@eucas1p1.samsung.com>
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
v5: function renamed to extcon_find_edev_by_node (Andy)
v2: changed label to follow local convention (Chanwoo)
---
 drivers/extcon/extcon.c | 44 ++++++++++++++++++++++++++++++++++----------
 include/linux/extcon.h  |  6 ++++++
 2 files changed, 40 insertions(+), 10 deletions(-)

diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index cb38c2747684..8bff5fd18185 100644
--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
@@ -1336,6 +1336,28 @@ void extcon_dev_unregister(struct extcon_dev *edev)
 EXPORT_SYMBOL_GPL(extcon_dev_unregister);
 
 #ifdef CONFIG_OF
+
+/*
+ * extcon_find_edev_by_node - Find the extcon device from devicetree.
+ * @node	: OF node identifying edev
+ *
+ * Return the pointer of extcon device if success or ERR_PTR(err) if fail.
+ */
+struct extcon_dev *extcon_find_edev_by_node(struct device_node *node)
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
+	edev = extcon_find_edev_by_node(node);
 	of_node_put(node);
 
-	return ERR_PTR(-EPROBE_DEFER);
+	return edev;
 }
+
 #else
+
+struct extcon_dev *extcon_find_edev_by_node(struct device_node *node)
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
+EXPORT_SYMBOL_GPL(extcon_find_edev_by_node);
 EXPORT_SYMBOL_GPL(extcon_get_edev_by_phandle);
 
 /**
diff --git a/include/linux/extcon.h b/include/linux/extcon.h
index 6d94e82c8ad9..7f033b1ea568 100644
--- a/include/linux/extcon.h
+++ b/include/linux/extcon.h
@@ -230,6 +230,7 @@ extern void devm_extcon_unregister_notifier_all(struct device *dev,
  * Following APIs get the extcon_dev from devicetree or by through extcon name.
  */
 extern struct extcon_dev *extcon_get_extcon_dev(const char *extcon_name);
+extern struct extcon_dev *extcon_find_edev_by_node(struct device_node *node);
 extern struct extcon_dev *extcon_get_edev_by_phandle(struct device *dev,
 						     int index);
 
@@ -283,6 +284,11 @@ static inline struct extcon_dev *extcon_get_extcon_dev(const char *extcon_name)
 	return ERR_PTR(-ENODEV);
 }
 
+static inline struct extcon_dev *extcon_find_edev_by_node(struct device_node *node)
+{
+	return ERR_PTR(-ENODEV);
+}
+
 static inline struct extcon_dev *extcon_get_edev_by_phandle(struct device *dev,
 				int index)
 {
-- 
2.16.2

