Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1145125-1520117462-2-8919631769090492058
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES daensv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520117462; b=h2XIrwKHvQOEtbkVUTwCQ5qypAtWGazZMFeYRdj/6wdXuuD
    3TqbtvP3UHYS1WD+kcP9alD7+JThiD+q+S5u8TwhwxenjlnfPV4U4GGPSKFxTl1C
    fdmxwf3yWxtkydS1hB4yJzpUSamTBqz+mM0NmPDX7njrq9vHWACUnGrLSuwc+2kK
    keT+ppF3dRtp0O5nFWuPmUzfSfFBpSz7C9sPY+i/Xb3M4w1BIqFOHvS2Esyq/cN0
    TAzOwvmrt8/ynTuWqJ8oTBHdr6QIbECOPnaM07lkEj52LOf/5RV6xHpBdfoRTfPl
    wkUL1au0iZlXb7XotXk6e+G1Dv4lIjRQuvDA8aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520117462; bh=n+AQD1
    Rx7MQBmd05kmq8T1xocFow1mIKVyysM9u0pnc=; b=GKBNn9r5+UMzwXI63VSe59
    x/EdGxGqut5oQwxFVsyVaqD3mKR+FGqy5rLKWQwRE1YKJkMraUbEqF+VXOWdqfhf
    jvKZIXlHEGp8D7vXUuIHR/7zhgQX0u+nZ+5TfWeWfBhhkUDlKs4SImcP7H49oc+l
    RLqvrJxM6u7KgtniMgFAwHrrn3DVJT1+U3NxzpkOHDS3Jkms3/SnHRRkegBbIlVe
    Hb3kOTVR+IfQDts2Rl6Yz2Q+TYgKt49ecpA8s+uodmXxYB5CAranXZBiOdIPVKpg
    f8aH0ZaTQMaI05cGQ/U7eIdXksd8HAaoXt4IKINbwhiBsbwCTKvikPk7q2TvYaWA
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CnmsuDED x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CnmsuDED x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932629AbeCCWui (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:50:38 -0500
Received: from mail-cys01nam02on0126.outbound.protection.outlook.com ([104.47.37.126]:64496
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934404AbeCCWlN (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:41:13 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Andrew Lunn <andrew@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 29/63] net/faraday: Add missing include of
 of.h
Thread-Topic: [PATCH AUTOSEL for 3.18 29/63] net/faraday: Add missing include
 of of.h
Thread-Index: AQHTsz+l+VWprd3zIkCX12hCmCg1iA==
Date: Sat, 3 Mar 2018 22:33:27 +0000
Message-ID: <20180303223228.27323-29-alexander.levin@microsoft.com>
References: <20180303223228.27323-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223228.27323-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2SPR01MB06;6:r1yNzebrNrZ3MKFraLSE73+J89cT8OLKBWKExkLJ+EEYxJniLiNtsoTjhtaLa6LyJVT6Ibqhfrx8l9oqzmNKx7LLziIWzZoey9vXwSoEdKDwx8OQ4y4zKUpUxAuxkce3WMqlOJchqdrQ26br2Z4pBfIoOP3ylFp+cpZmugBRRcymV9/947EzfauPGczJP8dUNByJlRUPxEw2PKUm9C6hhHj5Da3/I7UlQ8nSkKvc+xMgmvnPo33l0fMJexTfhYW0eZr0oWy+Gl96oka5/AklajdYNK4Ved4CBElm2Bp4FHtigGP+Ca9IlVgKvzad/fcsv0ksbyKjmnUJXmAa9CGIClGPeemzX5GAJiBPUsN9nK+RyR9qS00+VdaW5vZrTspG;5:MSL4VH8f13jw2UVKMmHsacFqisDLaXRmmLI1ZRd5uYmQEGQes7Mrc+e4MfrGBX02NchDeSeWwGvP4tty5v39XR1INiMculMHPHrb7TDfW4+5P+vuztev/EA3U/bzyO+I2o9e73gbkKh2bYFlV87As29aSdUwKQT2YBzQFyoiQo4=;24:NQ2mV+I/9Fqvu6usJGDfsXlKhDBz33XV9CAk6M5/t73/LTAiZ6nbqiVu/fjLaiHQBlHA15B9Q1vn4+Wblg9Xq2QJ6CCqa+r90iGIwbUK1BI=;7:Pkb4oW3QMVu7rP/QcWwn7h4Wsj0vF6jFP9l+868wZX9FxSw3qNdKaU3GJZIS7Duu/eoJsA6h9VfIeeDDy4sov5eju/2vPB4Ho0stL4oV1MPT7vl0YRz3nEnsR/eUCkN+Z8fq8qAS4UDqiq4gAG8HitaKrJxiVW3vhlE3mxIFLfgSwem+S0BAsf5tYbMzWF6Q4+xPyP8+Jv3m6XgJ8WyqX3TBBNUenVAs1SemKammWpZAK2yiCM0AyJQVGnlnoFm2
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: add471da-5c4f-4507-1383-08d58157dc89
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2SPR01MB06;
x-ms-traffictypediagnostic: MW2SPR01MB06:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2SPR01MB0667C363475DEBF4393FC6FBC40@MW2SPR01MB06.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MW2SPR01MB06;BCL:0;PCL:0;RULEID:;SRVR:MW2SPR01MB06;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(39860400002)(39380400002)(366004)(376002)(189003)(199004)(3660700001)(575784001)(8936002)(72206003)(5660300001)(14454004)(110136005)(6512007)(4326008)(6506007)(26005)(2501003)(66066001)(86362001)(7736002)(54906003)(305945005)(25786009)(10290500003)(53936002)(6436002)(2906002)(81156014)(8676002)(478600001)(102836004)(106356001)(316002)(186003)(5250100002)(81166006)(6486002)(76176011)(86612001)(6666003)(2900100001)(3846002)(68736007)(97736004)(36756003)(1076002)(107886003)(2950100002)(105586002)(99286004)(6116002)(3280700002)(22452003)(10090500001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2SPR01MB06;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: Do1l2zL5PVpHJI8WDEbyw3Ihi3EQ/8x+mWUFWOAV6OC9kWdLPN86xAOzP/85i2xkul4L0EIhnKnFxmvptssS3TgkQ+bIt/wSyUdzfcdMRYoHxGnYc/eJ+MfWrbrQwdVIWC+zAz9ZIdA19e7yxF4nnT3J13Xi1mZcisH7S8rRCiQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: add471da-5c4f-4507-1383-08d58157dc89
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:33:27.2631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2SPR01MB06
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Andrew Lunn <andrew@lunn.ch>

[ Upstream commit d39004ab136ebb6949a7dda9d24376f3d6209295 ]

Breaking the include loop netdevice.h, dsa.h, devlink.h broke this
driver, it depends on includes brought in by these headers. Adding
linux/of.h fixes it.

Fixes: ed0e39e97d34 ("net: break include loop netdevice.h, dsa.h, devlink.h=
")
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/faraday/ftgmac100.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/etherne=
t/faraday/ftgmac100.c
index c77fa4a69844..0900fd5098eb 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -28,6 +28,7 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
+#include <linux/of.h>
 #include <linux/phy.h>
 #include <linux/platform_device.h>
 #include <net/ip.h>
--=20
2.14.1
