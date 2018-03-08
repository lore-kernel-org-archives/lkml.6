Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-912290-1520485447-2-8155210423554856788
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
    t=1520485447; b=JG8IFGOl7aegKiUBCLWeucpuXo3WPtIKNnW62tFZ5IiUGB3
    m95JOMljUuGSklz4FLITq4Ut1E6PWNF7CJYDBOkwOcmdPtICeMKukyC8JW2xsCPA
    cQwHly/6ZFmFlRpsEoeq1MebbBFGUcFVGIb0RdQ4vxFSji5hW6zJqp9ocm0fkxX5
    9dNgGv/f9njAwfg36Rwk8RSozJurNbPn6UrZNLWnELgmNC9/Gj5ZAb/h9C8UxhN6
    EB2dcJfJ8tVwvraZVTq/vatAgSlt1FBJ2UdVgQAb5q7fC0whaPrZgcWtSUPvVx40
    X2WUKpx2rqyy8YJFQbqX4iEsMLXRRed9tMv18cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520485447; bh=uyaf5H
    sN8Cd6P2drtdaUXJ/w8lDox6ZQWhmN3kmv+aM=; b=F0onW5r4hFf817u6TWWbXT
    GgEAZjWm4uGrV8T2oWjdfXXyzNgezJfTMtWmuClTjHjSAT1dPHqoTcxM6SLBW4pv
    6HxRpeQRNvXjsIDskHAOaTrZBTGwVC2G60YO6mh35ofK/qo2TTURCLhfhCbIuVYJ
    VTC/Qu3pBmjo3Si+VmUX32Lt8g4tHWxKzo2/0j+pdDpxK++aStvCGTuzC/l7eaIF
    XvA0P05CKf2XRN9gkwAaSBuyUbjQBM6pMt3ke7wonoAxBS5QPY51OKSd8deChvsO
    FyOfgH08CbcRb+wzPL8l9YyOL7UCO+LUfJ48aqIIm8Zhf4gcS+pRq6zH5W1g0crQ
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=laQqHp2m x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=laQqHp2m x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966096AbeCHFED (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:04:03 -0500
Received: from mail-co1nam03on0092.outbound.protection.outlook.com ([104.47.40.92]:45512
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966085AbeCHFEA (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:04:00 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Loic Poulain <loic.poulain@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 153/190] Bluetooth: btqcomsmd: Fix skb double
 free corruption
Thread-Topic: [PATCH AUTOSEL for 4.9 153/190] Bluetooth: btqcomsmd: Fix skb
 double free corruption
Thread-Index: AQHTtppPf4KU4wF3PUCx2PlgKImAqA==
Date: Thu, 8 Mar 2018 04:59:59 +0000
Message-ID: <20180308045810.8041-153-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0902;20:blq5u8zkCLigCyLgG28lsvZQGDG5IgCwBawLbAosm2eEmdp3gU4JwhSCeFTpinhftc4CgI0KNl+iQ9VA53n8YmvqBdHFVHx4d1zaTM6WLDqO9RjkAr9fze8FgRSy1mbTL9TSnUx5ZqGk34gaY8Ntie3tFK8DQACvI5O8eaAzdfo=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 99bff63e-2584-4623-4d7c-08d584b1fdf4
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0902;
x-ms-traffictypediagnostic: DM5PR2101MB0902:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09021354EC212B94A624A239FBDF0@DM5PR2101MB0902.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0902;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0902;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(39380400002)(376002)(366004)(396003)(189003)(199004)(8936002)(81156014)(81166006)(7736002)(5250100002)(8676002)(99286004)(26005)(107886003)(186003)(2950100002)(106356001)(10090500001)(575784001)(305945005)(66066001)(97736004)(2501003)(86362001)(3846002)(3660700001)(72206003)(6436002)(1076002)(6486002)(5660300001)(54906003)(110136005)(68736007)(53936002)(14454004)(36756003)(25786009)(478600001)(10290500003)(6506007)(59450400001)(2900100001)(102836004)(76176011)(6512007)(22452003)(6116002)(316002)(4326008)(105586002)(86612001)(2906002)(3280700002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0902;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: Ktt4a4pd4T8l9B1CGJk3k4Cz29XTLyFeX4rE8JiufC5n/ErEYNRKDjFRSi+YD7Adr+pKANZyi/bbPYDPoz2cfA7VgldDxMpJUhnmXgCIbHFp2VUNxP5P+CzQZZov9aQ//ts1kB38jJOS2hqMYN2InwkSN2Mfz2B0V7wBpAyNfvh4dP2Ln1xs5DW+0XBRnyEF8J5A7hA+Z6nFbqohd0aLEU7TCosRqlhCXbnhbzv3toUzWvIL/gCfAiqB3gaANi1PB8reUdvQyW41AujyLJ38xxWbi940RO8i3thRxJg3zlE66OY3kkZyrKapL0bFTlUqWRqp0vvUkHZMgCy1NFKpcQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99bff63e-2584-4623-4d7c-08d584b1fdf4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:59.8803
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0902
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
index 08c2c93887c1..3aac78a5091b 100644
--- a/drivers/bluetooth/btqcomsmd.c
+++ b/drivers/bluetooth/btqcomsmd.c
@@ -85,7 +85,8 @@ static int btqcomsmd_send(struct hci_dev *hdev, struct sk=
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
