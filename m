Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1171329-1520491878-2-9198191577031335552
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520491877; b=sv3BubBKxm5Awrux749PC24gMsxdZl8lrx1VPlTKUNrcaF+
    gSQeoM2LYYGXDSaZLNc2A4XVrbd5vwWieeYFnq+lE0x0T0TEuFFRkyM8xH9bXXRr
    x6Y5GteyWldF8nsPzGi5dMAthRxg6jTP9VU5cAI8dz0texA/5xaBCrV3aIIREZDC
    3LlgPB9JBZf8pRCPrA5WvA4zRBvBiHZ/BzR8njHNPVAgVMAwn7LJPOxI02wDlZ2g
    5gFAwZlKjcP/p786OdYva+F5NnKx5TlPt+Z5lUZt1uPVoRxQWdKoI4+6hYp4jSzg
    HDRAxvLzYvOMKHAkH+0PijCQEhFNJnCuR6SGFOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520491877; bh=D+/Z0c
    RVucYBrhPRdFtRKszMlyIWYz1bsRb6IQsIT5k=; b=kiIXJ/DILLahpUmVOcAFVz
    LZ42miaNYxpyuVkqk1ka8XQk7fVslde5HCZArQYtJ9ndb1Prcupd/bALmsZWXVEw
    T/x2bjmupHS65HavyjN9C+Nri3nBH+e0Kkij3/MRMzuYvshL30KtIPtA5aw2jQa4
    wY5UE6zQgn8Jzhpziz7yB6QiU6VPq1bP5Ra3Lz0MebiPvcUUfUoiKlaXzD2/0Ozx
    h68b6YCa9k4jNir+By5OK5dcWI+9C/QQVr5CZPjO9Z9KHRDDKtucSzRJlqdKZJr9
    cqZmy77p47Y5l/2ACwl6FuDh19aWg5GQBgftP6GzJVbAR2UkS+Yel4ygxSodMGzg
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PukEOARZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PukEOARZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965090AbeCHGvA (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:51:00 -0500
Received: from mail-by2nam03on0117.outbound.protection.outlook.com ([104.47.42.117]:8510
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965023AbeCHE6K (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:58:10 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Loic Poulain <loic.poulain@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 02/67] Bluetooth: btqcomsmd: Fix skb double
 free corruption
Thread-Topic: [PATCH AUTOSEL for 4.14 02/67] Bluetooth: btqcomsmd: Fix skb
 double free corruption
Thread-Index: AQHTtpn3tMkFzIjO7k6dDHfWXTkRJA==
Date: Thu, 8 Mar 2018 04:57:32 +0000
Message-ID: <20180308045641.7814-2-alexander.levin@microsoft.com>
References: <20180308045641.7814-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045641.7814-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0936;20:bkP3XNSLyvxcqzT/qLdefO9/3Kfj6Me+4laeDdj9PupuDndSGU0p2+BqhpuzXBkCmhTvoDdBbUPlMm6r5jGrNy5yYlwcvljbTRKtQDnNgNTsBVjql24p27oSh7JTLoYNtG5UNRRzyfXU4E2VMF4kif0cmp48ZNbW7UV9M2E0jVc=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f7a862e0-7d32-4d95-0f38-08d584b12c0f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0936;
x-ms-traffictypediagnostic: DM5PR2101MB0936:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09364020DE3D58AA34C707FCFBDF0@DM5PR2101MB0936.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0936;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0936;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(39380400002)(346002)(376002)(199004)(189003)(478600001)(99286004)(575784001)(6506007)(59450400001)(3660700001)(36756003)(86362001)(54906003)(6116002)(110136005)(2950100002)(102836004)(1076002)(3846002)(6486002)(3280700002)(10090500001)(10290500003)(305945005)(72206003)(6436002)(6666003)(26005)(5250100002)(2906002)(186003)(2501003)(105586002)(76176011)(66066001)(7736002)(68736007)(25786009)(6512007)(106356001)(86612001)(8936002)(107886003)(81166006)(2900100001)(5660300001)(4326008)(81156014)(53936002)(14454004)(97736004)(316002)(22452003)(8676002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0936;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: a5Eu53pdAizaCSB1AfKIJIqCVzxOqoyHXcY1jS/xP91sNmMtvpvIaX+GSJu5BLZK4cu19DpeDJ3z0tmcpPxsFkI4lXNtdeOamfUDgc1Dz5e10uiDE6lciEbeFRXrrUq2Z/h4pJLCXMCQV/5c6cZ+YCGcaKaQothpOXGKUcSjw4pBIVOZqlQ8MTSXcZOkohjQtPeMa8FeLgDYEFg5Gz7y065JyWwPxMgUxf+i2S9kw6dUJFfanwGem4YEGaxL5wcn+vamOt49dRMAyD4ImKhHB1kf4pe8mI/VI5dqGpNq0ovTy52DqHSlYsn/BdBmy8+ZRijhJUvkhYqqY2F4vwH4hA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7a862e0-7d32-4d95-0f38-08d584b12c0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:57:32.2583
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0936
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Loic Poulain <loic.poulain@linaro.org>

[ Upstream commit 67b8fbead4685b36d290a0ef91c6ddffc4920ec9 ]

In case of hci send frame failure, skb is still owned
by the caller (hci_core) and then should not be freed.

This fixes crash on dragonboard-410c when sending SCO
packet. skb is freed by both btqcomsmd and hci_core.

Fixes: 1511cc750c3d ("Bluetooth: Introduce Qualcomm WCNSS SMD based HCI dri=
ver")
Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/bluetooth/btqcomsmd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btqcomsmd.c b/drivers/bluetooth/btqcomsmd.c
index bd810d01538a..093fd096f0c8 100644
--- a/drivers/bluetooth/btqcomsmd.c
+++ b/drivers/bluetooth/btqcomsmd.c
@@ -86,7 +86,8 @@ static int btqcomsmd_send(struct hci_dev *hdev, struct sk=
_buff *skb)
 		break;
 	}
=20
-	kfree_skb(skb);
+	if (!ret)
+		kfree_skb(skb);
=20
 	return ret;
 }
--=20
2.14.1
