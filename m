Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD79C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96AC620652
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="eDvwHnQy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96AC620652
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730348AbeIBRfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:35:10 -0400
Received: from mail-sn1nam01on0115.outbound.protection.outlook.com ([104.47.32.115]:32096
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729327AbeIBRcV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:32:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XTZx2ABIByF/ek4TLNmOd9piRiL0QZssEWxSQRAHLkM=;
 b=eDvwHnQyIzNPB/rVZXWXu1Zk95Wc1auDxs4ongqhUyMtodC8mMNUbX6EAedVEJ5eliTtcuf/eDWoFVr1RIoIFG2PnRVSWlaNPd8dm0uh0PYc8kUa37xEKVI7oEHWHJijQiEmfWUzyWQaMOBw7gn/ueoAUtHcM+w1cxO3y0JS7aU=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0167.namprd21.prod.outlook.com (10.173.192.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:16:27 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:16:27 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Mauricio Faria de Oliveira <mfo@canonical.com>,
        Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 31/47] partitions/aix: append null character to
 print data from disk
Thread-Topic: [PATCH AUTOSEL 4.4 31/47] partitions/aix: append null character
 to print data from disk
Thread-Index: AQHUQr8hWBd5RI6nw0aQpgYUyQm0CA==
Date:   Sun, 2 Sep 2018 13:16:16 +0000
Message-ID: <20180902131533.184092-31-alexander.levin@microsoft.com>
References: <20180902131533.184092-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131533.184092-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0167;6:4Velq6sa4IK2wHjsToZoGKU51eMpTj6pzkT+S5iznv1MkerKmcmPVfMnyZOf+ya9ObYlhkWStfJpRbwAFFzkibv+WXZGd5BvShQ2Rr0qbmqbSosgzgce7z0aGZm5hnokRuCit0RIJ+kitl4tInzO/YWAPCsYSqDm9tsIedCXGCERQI5TwlHqC5JUr7mzM5uqYQpxlwvoEYZuT7LPO/yIqbKA54M+oTIalRjYL58kytv31m6EwFr1wVNPJHBV6lhOP4hiTLPU3Bmc03y4TRur8JNQnAh+TDNSsR6ENEc3QN9lnntk8Y1qKKQJ1KTC//pmW584wSe+Q6Hqt13qWER58P60Ne0+GvN+BwiZJOjzXQUyX473LsYyIl+UVPWiRZY17ki3N1yEv//HV2TpQpIWWdqY4Uv5w3YAI+Lj06Dsglg59Jp3VBaPK/hxNdcGR9Lwawd/XW/n5ZLeF42+D3jt+w==;5:yW259LV4H4jiTkSihok8ZqTXaWiXx0UnMhWdxdrVNI2sv1NybBDFypZ7giNQw9jddfwZ88nQVYAciJoakUQLwFZL5VcGl23R/hJOI7lxharMflzG0D9rOyjzXA+8aHHSbKNpQ45inAUZ7nPU4bYbgYinCeL2XlIOnCMqvg2ATjs=;7:WwOhWtxm7R8R1uY+lhlyCEwSBeau+ZmL96t8dhzScWHknSxpSXjvp1wkGZ1qAjfIY7OtzBYjb0t32xFhmncnSMxq8+RdE8TeaQXNN+JwIeXTMkscObvEKvgLD10i7Er/siK2lpyI4RvWyQvwuV/CRY3UmbcwD4uGYedjfiC6aEOjLVBAHYcLb4MQgwM54Nr4QLnmD/IFCnw/4PQmg7HcawpyA6om4R/F3J/8uo3tqRrBOg/3Vt4YocgmuXZtEe6O
x-ms-office365-filtering-correlation-id: 287b22a7-765c-4e61-3ac6-08d610d64a78
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0167;
x-ms-traffictypediagnostic: CY4PR21MB0167:
x-microsoft-antispam-prvs: <CY4PR21MB016780C4C746291597B254A9FB0D0@CY4PR21MB0167.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(198206253151910);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0167;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0167;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(376002)(346002)(366004)(396003)(199004)(189003)(305945005)(6436002)(7736002)(6486002)(106356001)(105586002)(6512007)(53936002)(8676002)(36756003)(6666003)(6346003)(186003)(476003)(486006)(26005)(2616005)(11346002)(446003)(5660300001)(2501003)(5250100002)(10090500001)(102836004)(97736004)(6506007)(2900100001)(81156014)(316002)(81166006)(66066001)(22452003)(217873002)(2906002)(99286004)(54906003)(1076002)(8936002)(76176011)(68736007)(110136005)(3846002)(10290500003)(4326008)(25786009)(478600001)(6116002)(86612001)(86362001)(107886003)(72206003)(14454004)(14444005)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0167;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 8LLg9hv2Fjb3RE/VgfwQqDyZ4wI3DZ2Y/DbNyE8uT7AUCusteI+ejTRwxwKLrgXqHcln4Qq7x334V8R5lTD1EuNR3FT0XK1SS8QVoGjkWtKIarE/VtsQN2l8T8MkP1l/SC2SABBKU6ixdPgnxfXxrOCVWT/lDq71+SfRi2fkioJAmQe++bj59juhP57Xpk+26WMKj9y9emuSrlF3EysqurBbNMFZPqGTHJ14Dt4jfgSeeppbuY3Jm1PchYWD/wFgScZ3qajy8dNEeEaKjF5j+RxZenaNq/uNKXFUykjT7fJMXdC2Q5j4JHn5XaBLgBnXSKuQHJrm6HUYH5SIGfgMbqDst5UbJwJq4Scxo6Elj9g=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 287b22a7-765c-4e61-3ac6-08d610d64a78
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:16:16.8662
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0167
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mauricio Faria de Oliveira <mfo@canonical.com>

[ Upstream commit d43fdae7bac2def8c4314b5a49822cb7f08a45f1 ]

Even if properly initialized, the lvname array (i.e., strings)
is read from disk, and might contain corrupt data (e.g., lack
the null terminating character for strings).

So, make sure the partition name string used in pr_warn() has
the null terminating character.

Fixes: 6ceea22bbbc8 ("partitions: add aix lvm partition support files")
Suggested-by: Daniel J. Axtens <daniel.axtens@canonical.com>
Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 block/partitions/aix.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/block/partitions/aix.c b/block/partitions/aix.c
index f3ed7b2d89bf..fa74698e12a6 100644
--- a/block/partitions/aix.c
+++ b/block/partitions/aix.c
@@ -281,10 +281,14 @@ int aix_partition(struct parsed_partitions *state)
 				next_lp_ix +=3D 1;
 		}
 		for (i =3D 0; i < state->limit; i +=3D 1)
-			if (lvip[i].pps_found && !lvip[i].lv_is_contiguous)
+			if (lvip[i].pps_found && !lvip[i].lv_is_contiguous) {
+				char tmp[sizeof(n[i].name) + 1]; // null char
+
+				snprintf(tmp, sizeof(tmp), "%s", n[i].name);
 				pr_warn("partition %s (%u pp's found) is "
 					"not contiguous\n",
-					n[i].name, lvip[i].pps_found);
+					tmp, lvip[i].pps_found);
+			}
 		kfree(pvd);
 	}
 	kfree(n);
--=20
2.17.1
