Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3269524-1523477203-2-9110827878548764325
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523477202; b=PG3znc6AWEkwLqO8c2Ih9/nmkU9jJR6MKkACTDo03IPb0fvzgY
    N19WG+5Ay3LBOky5FRIfkfbGt5U5b8pVU2qXC7Ji7knIq7lZbe3ecZa/cYfjzSFU
    HVLt9RftDMcwu93YRkXw9lCA91wYhaH4V7VA/RNg+SJn213DyTTTm4ByLWZbOetN
    RRDh3RPChYPaxYs4DvChVPXMA9odj2bYRIs1vaalmHH01jYsbLqLcbjhkT9uhcVr
    xsymnhpvpv8vN2o3/HcHcqDNpngk8GgP/vHlxmWT+kb2wGDm2l+XXeOUs9wyP42i
    EovpWFxhWbJeiOroMsRTLpXscGyx1Kbw+v/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523477202; bh=Im2uLmgXNJMqTNL8mPARNI9A4lqc8q
    YnEZSdJZrNFdk=; b=W3LP56yk1yh9g2W3+HmYHIaVm5oLCHDRlw984fK312Zd/I
    aY4F0vE7vGUAr7iZXundH2mdyDnoFvPlxMaDFrhvXAS563u3Mbpv0NQmFMaXKtM4
    eu7FL/BkLlTrI/NgXuqhZHJiPpugO2BlTtLzXVlkp/yJrFOvK8D0CjK4Ejx2uySz
    wHStP9SPDZ1dTGt/YgPQtxppgdzViB5P+FNqF7PFK6ybGCeJJikKJqhN0GJ5YYir
    WkkrK1bqXlxoxzE8jGu7qDmFXR8pF1ayE233GvYk0MpL6+mo+6imEMMW6J6sKwWb
    TsM+JwUreUwDEnsV3BlodbQE8OGX0/vjkzAEY44g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKlgFrZz1s67pKcVHKyzUXk6avKBbmSrKCnl8A2ZuDEFLRfawtQwdeMov5MPN5j34f5aNEn9u7u38EkaaZCl9dkQREBsuNnfYlmDWRnSBNOEbYlT0jjx
    up5x78MYjXsFB2V8G5ND+/CPqyXriFywG3U5SBDNC02VUKilCHFzXaEzKJeuoluqY5SOO7vaXMieOrjhdTqKZ/jLZIaFk/wdBW6edtC19/AUspEHN3SkfAzO
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=sozttTNsAAAA:8 a=ag1SF4gXAAAA:8 a=yMhMjlubAAAA:8 a=zqmjmVBSbDmV5F_WRE8A:9
    a=QEXdDO2ut3YA:10 a=aeg5Gbbo78KNqacMgKqU:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933682AbeDKSzT (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:55:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34946 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933673AbeDKSzQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:55:16 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Suman Anna <s-anna@ti.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 061/310] uio: fix incorrect memory leak cleanup
Date: Wed, 11 Apr 2018 20:33:20 +0200
Message-Id: <20180411183624.855470858@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Suman Anna <s-anna@ti.com>


[ Upstream commit 0d83539092ddb1ab79b4d65bccb866bf07ea2ccd ]

Commit 75f0aef6220d ("uio: fix memory leak") has fixed up some
memory leaks during the failure paths of the addition of uio
attributes, but still is not correct entirely. A kobject_uevent()
failure still needs a kobject_put() and the kobject container
structure allocation failure before the kobject_init() doesn't
need a kobject_put(). Fix this properly.

Fixes: 75f0aef6220d ("uio: fix memory leak")
Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/uio/uio.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -279,7 +279,7 @@ static int uio_dev_add_attributes(struct
 		map = kzalloc(sizeof(*map), GFP_KERNEL);
 		if (!map) {
 			ret = -ENOMEM;
-			goto err_map_kobj;
+			goto err_map;
 		}
 		kobject_init(&map->kobj, &map_attr_type);
 		map->mem = mem;
@@ -289,7 +289,7 @@ static int uio_dev_add_attributes(struct
 			goto err_map_kobj;
 		ret = kobject_uevent(&map->kobj, KOBJ_ADD);
 		if (ret)
-			goto err_map;
+			goto err_map_kobj;
 	}
 
 	for (pi = 0; pi < MAX_UIO_PORT_REGIONS; pi++) {
@@ -308,7 +308,7 @@ static int uio_dev_add_attributes(struct
 		portio = kzalloc(sizeof(*portio), GFP_KERNEL);
 		if (!portio) {
 			ret = -ENOMEM;
-			goto err_portio_kobj;
+			goto err_portio;
 		}
 		kobject_init(&portio->kobj, &portio_attr_type);
 		portio->port = port;
@@ -319,7 +319,7 @@ static int uio_dev_add_attributes(struct
 			goto err_portio_kobj;
 		ret = kobject_uevent(&portio->kobj, KOBJ_ADD);
 		if (ret)
-			goto err_portio;
+			goto err_portio_kobj;
 	}
 
 	return 0;
