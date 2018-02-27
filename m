Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-757978-1519715616-2-1507072915688140136
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
    t=1519715616; b=th+FiCdBDDrEr4oE1HKc45TRxsFErN/IhxJe1lPSsEtf4xX
    fSUisi65KlU06sqdz6vBu/FH4dyKLvzR9KXA7Xvc7wCgpeS5VaZpD9wcv3EpirIE
    9LvIw6BNd3oYuqOzduiUQHvxXefgusv+k1/9Ye3ZX9Ida7vTH5OcDxokLEsDJ+IY
    +tOg5VNZxlKt/CuwtOZErdwwKWNjIu7d0kt3zOGXG2ItdTzQQB+xOnsnGEE8MRnu
    7FuWszNHoMmhDESaMurZqFyD3koIu8R5isP30am1bokn1d8P1w8x6C/kpl7qOeOm
    d6GBLTzfZp2cKOuxi0iRBJkvPlqlLveigRAnQFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519715616;
    bh=TDG+1jtVNQaa1YbZ4vKj8VLqHqqxRsrKvjkv0Au+8AI=; b=pqjmEMqOyyxB
    xRRuygCDY5qKSqKWz+6eHR2qEVgyDstfu+i6a90nBbTohAw4jDS3sTazJ9jB/Xd/
    yQBrjN08ISFCswDRkHHoC2NQX5kDObVl7+H6xpapU+G3fugCVnyiM/5KUBleN/zK
    tFG1pqlkGgadi3e+pH/5kb43IQ9MaboJjW7gLTA8mEkoKOVIoHF3xTlxSArN6yDL
    KWr9BnrTLiuuV/Px7XokZRiYAkDZpROagMAgpP6idj7bb2ZsXHe9b5Gjqv03Potr
    gdtoewoUu2HMqj/Q4I0VhrGmdnkFgy4+ZqorogpC1bR76TEG34c9wZ4qEhsvI6Ja
    YAXW5XtJsg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=LfRHuj/a x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=LfRHuj/a x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752233AbeB0HNe (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 02:13:34 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:50116 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752129AbeB0HLp (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 27 Feb 2018 02:11:45 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180227071142euoutp021cac56f4f0325ff87dcce2cea7b829cf~XHTK16-3u2625726257euoutp02a
X-AuditID: cbfec7f5-b5fff700000028a9-b3-5a9504ad5319
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
Subject: [PATCH v5 5/6] extcon: add possibility to get extcon device by OF
 node
Date: Tue, 27 Feb 2018 08:11:33 +0100
Message-id: <20180227071134.28063-6-a.hajda@samsung.com>
X-Mailer: git-send-email 2.16.2
In-reply-to: <20180227071134.28063-1-a.hajda@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0hTURzHO/e1u9HqNiVPKpmDQCW1KOOIEgYVF+mPEkIaWK68zOeUXTX1
        D5Mwm0/MV9rDmflIcVlT1ESNzBylNnW+ysJCcDTMB2qiaea89t/n+/t9zvmdczg0LlsgHOkI
        dTynUSuj5ZSEaOldM3nqiWLF8YJFb/TlxScS3dH+ItGr0kYSjS9bSKTr2a6NrMxTqGAqn0Am
        00sRyrxfJUKG6TESmdsfU6jU1IWhypq7ONL3fBOh6vEhDN3t7BEFMGxDeQNgzXm5GPtIW0ay
        hvpMip3KNmJsU9VtNq+5HrBLhsOXaIXEP4yLjkjkNN5nQiXhw9WhcTqnpNHylDQwezAL0DRk
        TsFa3YUsIKFlzHMA02e+E0JYArBIrxdlAfGONDo7TwqNGgA3LeuYELYAbG7t2LEoxh1uNn2m
        bGzPhMC54XbcJuHMIAEH+6w7kh1zGerXGjAbE8xR+N7wdacuZRDsn2ilhHEu8OnAKG5jMeML
        35T0U7aNIDNJwYonJbvSOagdaSMEtoNWY/PuWZ2huTCbEBZkA/ixKxMXQhGAJqsZEyw/+M44
        RNoYZ/bBgpYHuPAcUqjNkAkKC9f/dOACn4WWRi0l3DkHwPXJaTwfOFaAPfXAgUvgY1Qcf1LN
        3fLilTF8glrldTM2xgC2/0HfX+NKG+jauNENGBrI90oDnIsUMlKZyCfHdANI43J7ad2zQoVM
        GqZMTuE0sdc1CdEc3w2caELuIL3mlqqQMSplPBfFcXGc5n8Xo8WOaeDK1dVDeUFKX6I38HWF
        +KIht2sg2D3850hfoE+BqyzM3n/it5+a+gBJv/0LIU2rVSlJP8ruhai33m7U6oIyrK7dp893
        LvVXoh6XdGOdzJNSNT/0cPYIjAw7oudaViNXD0S7ZViT045h0zM+CXFjqbwlh9XJ8cW5KLvl
        4smgYDnBhytPeOAaXvkPWvYVQgMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrILMWRmVeSWpSXmKPExsVy+t/xy7prWaZGGdy5K2Bxa905Voumjres
        FhtnrGe1uP7lOavF/CNAsStf37NZTLo/gcXi/PkN7BadE5ewW2x6fI3V4vKuOWwWM87vY7JY
        tKyV2WLtkbvsFkuvX2SyaN17hN1BwGPNvDWMHpf7epk8ZnfMZPXYtKqTzeN+93Emj81L6j36
        tqxi9Pi8SS6AI4rLJiU1J7MstUjfLoEr49LShIL50hVX51U1ML4R62Lk5JAQMJG4+uY9axcj
        F4eQwBJGiTtrPzJDOI1MEu/a5jOCVLEJaEr83XyTDcQWEYiVeHvqM1gRs8AFFonfE2eygySE
        Bfwlls/6zwpiswioShzddAcszitgIXHmxnY2iHXyEgvPXmUGsTkFLCX2TzsDFhcCqrnfeYx1
        AiPPAkaGVYwiqaXFuem5xUZ6xYm5xaV56XrJ+bmbGIEBu+3Yzy07GLveBR9iFOBgVOLhnSE3
        JUqINbGsuDL3EKMEB7OSCO/KxZOjhHhTEiurUovy44tKc1KLDzFKc7AoifOeN6iMEhJITyxJ
        zU5NLUgtgskycXBKNTCejn5Z//PETbZG7j98LWuEVkjNdttou9Jwm/Ch3WtZ7kzJXa0i8bm0
        7cx17tDylcIia1md1DgVQy8GuRctn9ih/GvbpfllBrWWDVErtS4fXaBsKMRiyDat+aek0+3w
        f3PjGk97+C/LtXuTdenI9fVznikG/e7dzX7na0Q4n8zOup8SRSf2Sc9RYinOSDTUYi4qTgQA
        xMXrjlQCAAA=
X-CMS-MailID: 20180227071141eucas1p1170216070d70007a07de120a0dc3363a
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180227071141eucas1p1170216070d70007a07de120a0dc3363a
X-RootMTR: 20180227071141eucas1p1170216070d70007a07de120a0dc3363a
References: <20180227071134.28063-1-a.hajda@samsung.com>
        <CGME20180227071141eucas1p1170216070d70007a07de120a0dc3363a@eucas1p1.samsung.com>
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
index cb38c2747684..47a5ca9eb86d 100644
--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
@@ -1336,6 +1336,28 @@ void extcon_dev_unregister(struct extcon_dev *edev)
 EXPORT_SYMBOL_GPL(extcon_dev_unregister);
 
 #ifdef CONFIG_OF
+
+/*
+ * extcon_find_edev_by_node - Find the extcon device from devicetree.
+ * @node	: OF node identyfying edev
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

