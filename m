Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01796C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 836C12077B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="DOmfwWyT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 836C12077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729925AbeIBRic (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:38:32 -0400
Received: from mail-co1nam03on0101.outbound.protection.outlook.com ([104.47.40.101]:4252
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728978AbeIBRbS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:31:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XTZx2ABIByF/ek4TLNmOd9piRiL0QZssEWxSQRAHLkM=;
 b=DOmfwWyTnW4Wfcrkcf8Me1/9pVqyLwmLkinb9y9x8leIOjvIsESk5TsanAefYUHw+2dJAH9tsNj5QCduLp7dK5cOwbi6DtwHimhrBhe7u2jFyTv3ltRkFi+FC4PbSKziXl5idxWUi7xijbwDDoYcROtO0ckHWoRF2lvcu3jOQ/g=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0741.namprd21.prod.outlook.com (10.173.189.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:15:27 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:15:27 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Mauricio Faria de Oliveira <mfo@canonical.com>,
        Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 43/62] partitions/aix: append null character to
 print data from disk
Thread-Topic: [PATCH AUTOSEL 4.9 43/62] partitions/aix: append null character
 to print data from disk
Thread-Index: AQHUQr7ywMLL6tT8gEuqr1CLcwm8RA==
Date:   Sun, 2 Sep 2018 13:14:57 +0000
Message-ID: <20180902131411.183978-33-alexander.levin@microsoft.com>
References: <20180902131411.183978-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131411.183978-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0741;6:6r7sOIoq95ManbkmFz81aCr+wjAuuFWtfoVjnxcwhxsdOI/NBzH8Fqmd12xiUCC88czFkQDgkS+FsYMlKplH2GpBDAz0tGpWQ2Kd8+cbzpPcP5ZqrosO0wz/t0+XRiCrhXJzh8nLY33oSM4RXJloQIRpVYfuH95/0wTujYI5pXarA3YHcovkLoRqJNvPi//r1ZVXxVI6z8elWkgvB8AHRdu+tXBp7dMMmy4XiDIvzYAJBkMLguRqFvrIRj0EB+4DC6Deh9535/iWpjpb1FPXqqcZycxJmJF+M6T6OCom/Qp/jjMGkizKsvSY0mS0+xI09Mxe4LL2gO/Q7wQ2+Ovnywq5zVIDIDrUeasCy/be5H9po6Snd3X8kfUtD2h4jd5OFl1XRWP67NyqWwd0QBNA84QrXOOR3loj9KUgRIc7TVgAl9lU9SRAvrYH5IGB2fpfNRqEGjWZBeYq4LEmpAIT3A==;5:tGQkd9268k0YObEhxWI8vbMJeh0iiojuick6AjMjwEbQfn83fegWAkdkBZfyAtLctUkiiRjjcf7br4rhvN/R8xY+rt9v/SemirJ7GJjziMHG27n4Jw6NpOF7nX2QnHPhsMM/+VHzVY4lzFMvtcLsgcIsEDzG35zZAq8LKeEF3jw=;7:ufoGzpzD9NtlPLw6fCQT+nZ0cGlhCkXiDSCG3FLUa3Uwg/Z6N0BiePtd2AhLoQ5njKjsgGRx09V7x2Co1UewJtd8wU86GhKpOpuG3s1browDBBq5zeX93nmFCYvRNP2oUIXWzqzOseFnhQlXXQolhqIlY0FdBEoEGm6PCZAWkxeS6cqDcI/RrnP5eBenQEWKusfSCY368qNJc4t08dK6de9iuK7jG0eTujBUaclby5xhw61mLcbfYT2RtTB1xbPN
x-ms-office365-filtering-correlation-id: 3ad19c94-f8d4-402d-2165-08d610d626a9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0741;
x-ms-traffictypediagnostic: CY4PR21MB0741:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB07413B32C8B67FD131939024FB0D0@CY4PR21MB0741.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(198206253151910);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0741;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0741;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(136003)(346002)(396003)(376002)(199004)(189003)(97736004)(2906002)(186003)(26005)(256004)(14444005)(102836004)(11346002)(25786009)(476003)(486006)(2616005)(446003)(305945005)(66066001)(5250100002)(2501003)(7736002)(6506007)(8676002)(68736007)(76176011)(6666003)(99286004)(6486002)(105586002)(81156014)(81166006)(53936002)(5660300001)(22452003)(478600001)(6436002)(86362001)(14454004)(54906003)(36756003)(106356001)(110136005)(6512007)(4326008)(107886003)(217873002)(3846002)(2900100001)(316002)(8936002)(1076002)(10090500001)(6116002)(72206003)(86612001)(10290500003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0741;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: y7CybwKKNHntgGav1N9SzxGuHAP2B9SQYuVpqFhaWvU1m7rkYVg7h1CkYlx3d5QjTwo5TJpNlRYQB8lEdvuZqr4+dRa2rfXB860zWPYtwnipQj+G6URg5/e2NAkv8uti3a8WbDfaeA6sr08MpvDbAx9QBjfOiRWfirfQDG+PuzOUPnc36z8eWDi3j5qkd9qDaRAfmka7pm20LGepYYMrGXUzCdpMqwqr9vAF4+gcNNA7883MYGxwgI1B+IRlJNxuexkns5Ct73LqpO/e1oO0VoLJAyEUyiKx0VYypoWyvsOik+H2xsCrURQe9Md5v8i6Svplg1S7GHNa/xgGOEjiHW6tFFjDP2iocDpf4Tx2hm4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ad19c94-f8d4-402d-2165-08d610d626a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:14:57.5099
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0741
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
