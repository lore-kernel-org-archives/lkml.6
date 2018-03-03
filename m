Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1247250-1520120431-2-16549012037642953193
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520120431; b=e/A5Q8vYGnZD3STkyzJ10+HU5OWYjAfnYciy1lLy4S3at9M
    3jHCZ4V5h643Puq5rsj/ymIzEhanp1hQa0t3IB1sOqDytLDmUtokTWNlmhxOzfOO
    Qi+jcKZV7EDsU+vuLmc4yOHlrfsHA5TgE+r6kfmoA6mi/VxmEM4qCHIT3nh6q+Nd
    tAeu0PRFiB9MToQawv1rodM6gafrkvF5YKZ4QpejRtEbQGEmivIOYcr8yOQkTpDm
    uqWz3CzPEJnszBDm7UtoV8W/It5SSOVc3/z92gGyiMay2N8csOC+9HDDRFsWXsv2
    z7dn+579XjGZkqnvavYuTq0uyByjS4wzo1q4gKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520120431; bh=vweaBA
    JhwwX+CCWCU1QuY2AVyaa82eEW82aKvC+rdqA=; b=BeGbIAY522Qd+SyDNIMc7U
    zR+OUIAoersdizA7pu/6/qCuXsm7avwHJG9prYBqEK4IPg0bdHAgSXn9+PTeMkdx
    KFB7XMsEID3Vusr/8nxdKdPRULvXE3JP1CVMeoCukCT0HOx22Yxkhnu6X65m5xrP
    BRwvD1pEoupuyYvwYWXyx8uaIs/IpuHoTlsaG5wXOWgjcQZcb0LAhbwnCibL498Q
    y7WFLlhkEutV3UBAJzDSs6J3jF0pgH05NnRq7POHrTVPLR/h2aPinAYJ7lA3iRvE
    ysFyTPhZUkndT5ZV6/mPCi1lWlY4u8h6q2P1rUVi9gA7nFfiTA2S1eOfv4OhFqLw
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=O8zfofFi x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=O8zfofFi x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934370AbeCCXkP (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:40:15 -0500
Received: from mail-sn1nam02on0094.outbound.protection.outlook.com ([104.47.36.94]:45030
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934308AbeCCWfE (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:35:04 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Zhilong Liu <zlliu@suse.com>, Shaohua Li <shli@fb.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 144/219] md.c:didn't unlock the mddev before
 return EINVAL in array_size_store
Thread-Topic: [PATCH AUTOSEL for 4.9 144/219] md.c:didn't unlock the mddev
 before return EINVAL in array_size_store
Thread-Index: AQHTsz8SJp8Hgc65FE2CDnRol0iI1w==
Date: Sat, 3 Mar 2018 22:29:20 +0000
Message-ID: <20180303222716.26640-144-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0924;6:tXxC1TKs+rltf0H8LYCZhsCqbDBTq0Hx5L5J2iYyDVsPvW7vypRjuWlg58tMLytcr0x+vDiG9gZPUAjlr4Kvs/8PyvMR3vlJ26oeOXotsx6U9kUZtH5dYrZPVcrxvR/RXmK2Ri9MHyYQau8UWymMowuyhs0RpAPpx3qFQjrHGaSjmmqpiZeJrFMaUm+VCJ3MNIg7mvjumHK5MegzrLVLgMNFy1g+BTwUeZoQM9msBOn4o4DoMK592/BBC7UMno5EDBHA/FTrE4hIN0mL+fe76900QyBp3d3qEGtacUl27tGAgYRUgCyJlUvPFFEM2Z0w0VzDf/fIxTNUZUM4huZ6h/jNa5qZtDFDDITR9w+bTh4=;5:4C8ytdsgqjfPRjwxfAb3vmESEdZOZDGTRHmNIVLMqi0jag1rCtWL66aiCVdgC/T0RtvRYYwfKTX0s9bkPQeAj5m5oxw9a8HDuJCRBe5YrquvPMzoi0BdQM7mNvp4IeLEXWGRc7yyE2d7TDAQi0qAwCOysynfXcuSdpS4WOITD2U=;24:ZXNtu4zGAjoGjlrGBil2KWkG1rA7IR7w6t59KM8bgpO18AemgI0BRK+FwfysdWvGjIFiBPjvdkOAUfcsAjDFDj9+Hd+xeCJRMwaQizIilFc=;7:3WPsCVi0yhkNATnQ5vGnUGxa7k2C3uueiU2bUc5JBYCjNxj28Hqm7++s6pmNNMm0gKh90e7E/fjh9GDqXWL4sS2ugSQXUcgr5Tv4dIwxLYzxbqu06hRZsKKUw6RoZ0pfnC6qsFv7l2QRlQLXGiN/bUH2BuidjLYJ/UiWuHd3HN+KWYo5d12alePEogpeE28xybTIivE5gim9PH5yJXhcb6GeSL6nvoUxArh9PeLhgN6myZvJqjb87HSn7F3AOMMg
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 19b008ac-9381-4179-ffbf-08d58156fec3
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB0924;
x-ms-traffictypediagnostic: MW2PR2101MB0924:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB0924E269B4114A0031172E5BFBC40@MW2PR2101MB0924.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(67672495146484);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0924;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0924;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39860400002)(396003)(366004)(39380400002)(189003)(199004)(102836004)(2950100002)(10090500001)(6666003)(316002)(26005)(186003)(25786009)(2900100001)(2906002)(54906003)(22452003)(110136005)(97736004)(6506007)(59450400001)(7736002)(4326008)(305945005)(5250100002)(86362001)(2501003)(99286004)(68736007)(72206003)(53936002)(6436002)(6116002)(3846002)(5660300001)(66066001)(1076002)(76176011)(14454004)(36756003)(3660700001)(6486002)(86612001)(81156014)(8676002)(81166006)(10290500003)(6512007)(8936002)(3280700002)(478600001)(107886003)(106356001)(105586002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0924;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19b008ac-9381-4179-ffbf-08d58156fec3
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:20.0413
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0924
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Zhilong Liu <zlliu@suse.com>

[ Upstream commit b670883bb9e55ba63a278d83e034faefc01ce2cf ]

md.c: it needs to release the mddev lock before
the array_size_store() returns.

Fixes: ab5a98b132fd ("md-cluster: change array_sectors and update size are =
not supported")

Signed-off-by: Zhilong Liu <zlliu@suse.com>
Reviewed-by: Guoqing Jiang <gqjiang@suse.com>
Signed-off-by: Shaohua Li <shli@fb.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/md/md.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 8ebf1b97e1d2..564da422c179 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -4826,8 +4826,10 @@ array_size_store(struct mddev *mddev, const char *bu=
f, size_t len)
 		return err;
=20
 	/* cluster raid doesn't support change array_sectors */
-	if (mddev_is_clustered(mddev))
+	if (mddev_is_clustered(mddev)) {
+		mddev_unlock(mddev);
 		return -EINVAL;
+	}
=20
 	if (strncmp(buf, "default", 7) =3D=3D 0) {
 		if (mddev->pers)
--=20
2.14.1
