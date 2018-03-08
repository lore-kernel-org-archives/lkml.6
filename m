Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1171329-1520493077-2-17008746074384792678
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520493076; b=CsFL7asIIJz7P9G5fXJgbgSPj0Pi9T+T8Ncc/UiUAb2f1gB
    gFoMrYwv7khj+smyYwY/siVqnxhCLWaL2/OWOr1+Sqcun6mlOneNkoyHP2tB0L9t
    5cFPqLLHTeYycd/sX0wMXOzCdWvHDzEb/76N9/HJ7r+FQktJFSbcb2I2lDj9VVwp
    d+vgPhV0lI0cR4vZKQhQTGOg4LEZ4OVwD4VfZVPiEiVUUqaXbpD8oq8clR6qRw0j
    q50HF/Ne/sFeuKfiRFa2/rjxYa22pp9QDCyQDUF0i57whRc+9qkmktRNJrlEXzEp
    f299LfkfozaiIb4nx8WsX13b/brQ/V7gBUfUeXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520493076; bh=2g75kV
    WIU8qXjW7cN5SqJNEQPy5kFAs3925qoRYpUKU=; b=G4SZDPaX0lU201IVkqDiyi
    vefJFRTGD/Nuc3pBm86Jg1YhqaKgjrynuTkGND8iVKLOwT6HSNgd3fJzjVowsbKL
    kjJ4J4Yh4UpKErH32AR8g1p+Sjo4h08mfex9+dcIU+34sOBRYcxAB58N+zjiWzyb
    9IEBnciZY8uj0DYNb7fEYH6BSarQxRqoWqFiyFq6lfzb8gLJev2Uh/5bX6oeKGxy
    TbgmuREJDe8KJqkQSQMWfLfxV/I8VCtG/iXMc3FCtnLq1GQMZfXtIlvM8zy2FjmA
    qE9+euBK6NOqhNVXYyjlVb/RS3oBLjDeOIPwmZNK1BvY3UWyqz/KGHdNEpKJ9GLQ
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=G2nMMBY9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=G2nMMBY9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934732AbeCHHLC (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 02:11:02 -0500
Received: from mail-by2nam03on0095.outbound.protection.outlook.com ([104.47.42.95]:43489
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755105AbeCHE4M (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:56:12 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Yuval Shaia <yuval.shaia@oracle.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 11/78] IB/ipoib: Warn when one port fails to
 initialize
Thread-Topic: [PATCH AUTOSEL for 4.15 11/78] IB/ipoib: Warn when one port
 fails to initialize
Thread-Index: AQHTtpnDBBeUiUkBkkmL8GeTA+X+BA==
Date: Thu, 8 Mar 2018 04:56:05 +0000
Message-ID: <20180308045525.7662-11-alexander.levin@microsoft.com>
References: <20180308045525.7662-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045525.7662-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0902;7:0Y9N15pl7Q6oYNwjZ/HaPoYkbUIeMV7DEPY35qGlMYeHX7/EyD06Qe14Z5zEtki7KBvjU4QDchuyIGY7L/d4As3BHh4TUGdi0uiwep2nYMp3oP3URUJazAEyIWPxmh/dr+mat61Ff352QfyKVXiSBYBjomqx6tf9kvf6ZbIoRDpiizGxRtla6b3rLM2uv6GwyPOfofQdiYrXS36lBmt2m0QHnkaeeTXvl6/St2Yp7IQhwyumbYz/zz+yymaC507E;20:cbnueuTY6Xnl1XzzBLWyiBRWMKAeXdeBH+JGw7vb4rS4Ba+9FcCIkK7k+N9DnykOrM0LCri19kT0KFfdJ7k1E1+kuNRFnyKU6aPA6pZZcFQkdeunz7ucxwvhckuKOcCM9TYyjr5A3etFdC4wDlIp06xp0YghM40bdZ50IJBiC0o=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b547b7e8-4c37-4292-d92b-08d584b0e686
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0902;
x-ms-traffictypediagnostic: DM5PR2101MB0902:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0902D9654E901BB2170D9C88FBDF0@DM5PR2101MB0902.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0902;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0902;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(39380400002)(376002)(366004)(396003)(189003)(199004)(8936002)(81156014)(81166006)(7736002)(5250100002)(8676002)(99286004)(26005)(107886003)(186003)(2950100002)(106356001)(10090500001)(575784001)(305945005)(66066001)(97736004)(2501003)(86362001)(3846002)(3660700001)(72206003)(6436002)(1076002)(6486002)(5660300001)(54906003)(110136005)(68736007)(53936002)(14454004)(36756003)(25786009)(478600001)(10290500003)(6506007)(2900100001)(102836004)(76176011)(6512007)(22452003)(6116002)(316002)(4326008)(105586002)(86612001)(2906002)(3280700002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0902;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: zgZicT4IGJThKX1MrFRxEysc9ornS6GzsTy+adY3mUpmkVAKPFfiCbuzI0xYutONh86eNoRymMY61nPlcVaF1MOnW7MFbKibeYyyjr2Uim0/SIslfyup9EcSI87+nlVyYVxEe5C1Tbr9d59AEr0w7lhVQNXo/Mel+IeklzRbHLXMakbJg62NtoK0CjsC20qP0ek+wpNk7ofow0xBNK+CvXKDMtUj6sSuCv8p2t7eC8DuKW5ivD90Zqt4XpLNrHN9gPE75RjH22UIAOC5TxL5qylqleTVkHUsbPQo80ieskOAahvM/0fDXYn5lMWc/Sw3wP+iikEL84jNZ3jjDU08UQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b547b7e8-4c37-4292-d92b-08d584b0e686
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:56:05.5758
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0902
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Yuval Shaia <yuval.shaia@oracle.com>

[ Upstream commit ac6dbf7fa4707c75a247b540cc0b5c881f3d0ba8 ]

If one port fails to initialize an error message should indicate the
reason and driver should continue serving the working port(s) and other
HCA(s).

Fixes: e4b2d06892c7 ("IB/ipoib: Remove device when one port fails to init")=
.
Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/ulp/ipoib/ipoib_main.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband=
/ulp/ipoib/ipoib_main.c
index 8880351df179..c35c28015f8e 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -2207,8 +2207,10 @@ static struct net_device *ipoib_add_port(const char =
*format,
 	int result =3D -ENOMEM;
=20
 	priv =3D ipoib_intf_alloc(hca, port, format);
-	if (!priv)
+	if (!priv) {
+		pr_warn("%s, %d: ipoib_intf_alloc failed\n", hca->name, port);
 		goto alloc_mem_failed;
+	}
=20
 	SET_NETDEV_DEV(priv->dev, hca->dev.parent);
 	priv->dev->dev_id =3D port - 1;
@@ -2337,8 +2339,7 @@ static void ipoib_add_one(struct ib_device *device)
 	}
=20
 	if (!count) {
-		pr_err("Failed to init port, removing it\n");
-		ipoib_remove_one(device, dev_list);
+		kfree(dev_list);
 		return;
 	}
=20
--=20
2.14.1
