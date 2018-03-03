Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1310899-1520122292-2-4458233380547856498
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520122292; b=J97QFzdo9Lt03FNU4x++eeIx1SN2C3MjQMNioL6WW8cjsl0
    xR3J2H53DJKYjm+LOsQlG/UHBFxkJ05RXOjJ2xTgM3pcllKX2+K8+9oY2wMEZyh+
    bI0nVZQoVAiPqGQkTx5yGK+2um61Ii2+5/NkP546SzyPv/vDudK2Azv3I8WxH66c
    grFZCoNwG2H6kH1yojxcFx1rZWWdFZbEWsXa/unnnVMGNKbCF2nyZTnCzZaQKBXY
    5NHxwhFSG5z6KUK9riVrmiHhkhitb4SDgijCeQyyOFRgDsIEklRfjf9jrJTDe0uK
    woWKbiQTIK72V/jn4kgmThFdma6nLaFxkmTdnmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520122292; bh=mt4nG4
    sUT74HEaxl3b8c5FbOEu3tjr70KGyumiXEEoU=; b=O4GMKpCjLeh3t/opJz5E8o
    mcTZZi5qZkAod5WOavUkfD9fj2Hpo3WNkCf4c7fIuw4oFF/X+ngno/Zz30wtUVrl
    sGQ4yc5vAMQ/b+FZmzaUPfWatcdk1c8ANR0/cTEaJkHHbFj84s4giAh9nhf5DwCJ
    YME+ZskScGZ7FzPFuVb28J9TJEZ9aUtSoqJqGdKfMwddUa3EGmto1ll7QQfbw6wB
    AKRncYWoBPjsq/kA96toNCzQjYqaiBlCtt8ReFtksE/9UpGP7yxOKbMcCWUUy4mP
    WNsrHcSD7BnLQxu6L+kHJfZG1IE7c++fVc2plulLLzYyn4FQ+3yYiHzWkXWNr2OQ
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Zi37r9od x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Zi37r9od x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933532AbeCDAKz (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:10:55 -0500
Received: from mail-sn1nam01on0137.outbound.protection.outlook.com ([104.47.32.137]:51749
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933263AbeCCWa5 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:30:57 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Arnd Bergmann <arnd@arndb.de>, Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 83/84] IB/mlx5: revisit -Wmaybe-uninitialized
 warning
Thread-Topic: [PATCH AUTOSEL for 4.14 83/84] IB/mlx5: revisit
 -Wmaybe-uninitialized warning
Thread-Index: AQHTsz64dPWHHYQF+UCzdJRp0t5ltQ==
Date: Sat, 3 Mar 2018 22:26:48 +0000
Message-ID: <20180303222518.26271-83-alexander.levin@microsoft.com>
References: <20180303222518.26271-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222518.26271-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0970;7:TBv08pD5h1F2H7ptOByN31i7dCzKiW5DlAP9zkZt8JkHYq0ECbauNcFWZjllN8EVfK9669TQ1BAAB4FNUrRYATISp6Dwm3wrLdcA9RQQ7y8Ffvm/9XeARGaj4IIFMk3tiazHL24l65UHxa6oziS3lucVOia/f56UpcJ7ODoKQd/cC7MeLoyGajeyPHjK6+GKvkPvGr4EOk+6JH9bpOgu8AxZdI+B0TDrUwzgbKQqqzqOFoy+ke7IF89ibYXBURjQ
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5a52c0a1-3986-4b74-16b5-08d581566d18
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0970;
x-ms-traffictypediagnostic: MW2PR2101MB0970:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB09708A9F8F47464A0CE9BF90FBC40@MW2PR2101MB0970.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0970;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0970;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(366004)(396003)(39860400002)(346002)(199004)(189003)(575784001)(86362001)(110136005)(4326008)(6506007)(14454004)(99286004)(8936002)(1076002)(36756003)(2906002)(102836004)(76176011)(25786009)(6486002)(316002)(478600001)(3280700002)(107886003)(186003)(54906003)(26005)(81166006)(7736002)(8676002)(6512007)(81156014)(305945005)(72206003)(59450400001)(6436002)(53936002)(6116002)(6666003)(86612001)(68736007)(3846002)(2950100002)(3660700001)(10290500003)(22452003)(10090500001)(2900100001)(106356001)(2501003)(66066001)(97736004)(5660300001)(5250100002)(105586002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0970;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: TiDhZ0qHZmmY4f5Ghf4odr718re+TNv7fFZpI1RXd2NsM59WMHhD6mmrDYJGU18QXrc0ifAZALXI9Yeg/5a/YW1N1WZoTFYK0jPyNDoNyagSberOsWsVHJFZepi7nuFeSVZrtlPCnNKejRMPUib5ZQfX6sH6jsvFL3nma9AxwI8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a52c0a1-3986-4b74-16b5-08d581566d18
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:26:48.9161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0970
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 1b19b95169cd52fe82cd442fec0b279fe25cc838 ]

A warning that I thought I had fixed before occasionally comes
back in rare randconfig builds (I found 7 instances in the last
100000 builds, originally it was much more frequent):

drivers/infiniband/hw/mlx5/mr.c: In function 'mlx5_ib_reg_user_mr':
drivers/infiniband/hw/mlx5/mr.c:1229:5: error: 'order' may be used uninitia=
lized in this function [-Werror=3Dmaybe-uninitialized]
  if (order <=3D mr_cache_max_order(dev)) {
     ^
drivers/infiniband/hw/mlx5/mr.c:1247:8: error: 'ncont' may be used uninitia=
lized in this function [-Werror=3Dmaybe-uninitialized]
drivers/infiniband/hw/mlx5/mr.c:1247:8: error: 'page_shift' may be used uni=
nitialized in this function [-Werror=3Dmaybe-uninitialized]
drivers/infiniband/hw/mlx5/mr.c:1260:2: error: 'npages' may be used uniniti=
alized in this function [-Werror=3Dmaybe-uninitialized]

I've looked at all those findings again and noticed that they are all
with CONFIG_INFINIBAND_USER_MEM=3Dn, which means ib_umem_get() returns
an error unconditionally and we never initialize or use those variables.
This triggers a condition in gcc iff mr_umem_get() is partially but not
entirely inlined, which in turn depends on the exact combination of
optimization settings. This is a known problem with gcc, with no
easy solution in the compiler, so this adds another workaround that
should be more reliable than my previous attempt.

Returning an error from mlx5_ib_reg_user_mr() earlier means that we
can completely bypass the logic that caused the warning, the compiler
can now see that the variable is never accessed.

Fixes: 14ab8896f5d9 ("IB/mlx5: avoid bogus -Wmaybe-uninitialized warning")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/hw/mlx5/mr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/m=
r.c
index 37bbc543847a..2520320845ee 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1206,6 +1206,9 @@ struct ib_mr *mlx5_ib_reg_user_mr(struct ib_pd *pd, u=
64 start, u64 length,
 	int err;
 	bool use_umr =3D true;
=20
+	if (!IS_ENABLED(CONFIG_INFINIBAND_USER_MEM))
+		return ERR_PTR(-EINVAL);
+
 	mlx5_ib_dbg(dev, "start 0x%llx, virt_addr 0x%llx, length 0x%llx, access_f=
lags 0x%x\n",
 		    start, virt_addr, length, access_flags);
=20
--=20
2.14.1
