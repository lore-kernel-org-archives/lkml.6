Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D9D5C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECA3920877
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="fQPBnxJW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECA3920877
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732170AbeIXVK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:10:27 -0400
Received: from mail-eopbgr690129.outbound.protection.outlook.com ([40.107.69.129]:55616
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733046AbeIXUvi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:51:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7EIAXvIGT5n2s12s6nX0zQfNdKPZn25kqHDIajyJ810=;
 b=fQPBnxJWtRi39DHye5ooiS2bS6wpJ3IA4GI2s5WeoJfn3wh7ERByKcNGuFyfLtaXFZ8LUJi81nE2oy5bm/XCnwULmZnfbFlVwBKScn6QwmtArC0iriN2zUAaNVvh5r55QP2tpkidjcPiFkaxnL1ogQifqXuAwyTUh8RETNcVA2c=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0744.namprd21.prod.outlook.com (10.173.189.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.2; Mon, 24 Sep 2018 14:49:01 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:49:01 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jon Kuhn <jkuhn@barracuda.com>,
        Steven French <Steven.French@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 56/76] fs/cifs: don't translate SFM_SLASH
 (U+F026) to backslash
Thread-Topic: [PATCH AUTOSEL 4.18 56/76] fs/cifs: don't translate SFM_SLASH
 (U+F026) to backslash
Thread-Index: AQHUVBWrok0ApgHw9UyS8yfiH0unkA==
Date:   Mon, 24 Sep 2018 14:48:35 +0000
Message-ID: <20180924144751.164410-55-alexander.levin@microsoft.com>
References: <20180924144751.164410-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144751.164410-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0744;6:CEN+ixnLKMRiMHD2PdxrvkHAYq+t/VdrQq4YI1AtMi0tTqKOoYsb+xvhi4n5HW3Dq9p1ji3DxE4YGr+wX04rlQ4imYJTkEDmB6Z/aBJsHfnvnWqpDQUd0D++4azkj54834kIpwJND5jDNg4eiMyHYfw8f7tiJANkKrO9oAIYLQm57rtKAHJpSqlghbPk7WqeBsprt7dsBFcyb0RGiWtIeVT9fFUyTRxsuj2C4IluPKVc9gMaN0l/ZBwcZnbWgfGFFh+loe2EZLbTEagL43MXHFCC4D5T5TLV1dLQaGLk0DQMilQEwSPOItZnwo0C48kMpJqfW5Qk5QylFDZ8m8LHNomRAoZJyKl3hqMryeG4L+fqBrhNdT4GWjoTv1nL02YtSaJoUXe8UrVAVm7oKrwtq2Rjc69OBaD84nr8SGnJvgeXgGOWyl5yClhedCXJ4r29FAU8D4kO8jaQCYEZyH/YQg==;5:y+9c7UHd+/7DerGJMIGf4qDJZ3W+cRiqfIL9LF4i9pSOVbgq08QuRK3vbPd/loB2MId/qpay03sx07yGtVUp88i3kusV57q04EDYW6I2djDCsfU0qTrPdGnooIuZBYri2wOr7M+9Fw5qxYN4hUCQpiD695F353kHQatdCDEg6fc=;7:zBrpc8pc6hpHKQUKH+hPMn8JT2aXud4hZs9QBjN1EZtPMD/OTzcVgy8fihnFrUClFHHZFY5Qer/vDb7S0cd1q2OaB4KdJE1N2L//Me2DR2w1w8YhT06QmGzp7f0e9ImkasnXIwM6QYkXs9Shg87t9Gn6rRl+UcotW+9ve2kegINnlI6gQio2V7rYE6nNDmV58Jb6X2wuaRzuiTS1zUOWoIO3Fh9u5HydTPHV6mR0/UYLIEqDXCj/7GzFBOypkws0
x-ms-office365-filtering-correlation-id: 0dd3adac-6f2b-4304-bba2-08d6222cddd1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0744;
x-ms-traffictypediagnostic: CY4PR21MB0744:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB074413EBAE5C0554C281D8F0FB170@CY4PR21MB0744.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(158342451672863)(129605872554195)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(3002001)(6055026)(149066)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0744;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0744;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(346002)(39860400002)(376002)(366004)(189003)(199004)(11346002)(446003)(476003)(86362001)(186003)(81166006)(6506007)(8676002)(81156014)(6666003)(5660300001)(486006)(99286004)(53936002)(305945005)(6512007)(6436002)(2616005)(71200400001)(71190400001)(68736007)(6486002)(102836004)(10090500001)(7736002)(36756003)(97736004)(86612001)(316002)(3846002)(6116002)(1076002)(217873002)(14444005)(256004)(54906003)(110136005)(107886003)(10290500003)(4326008)(478600001)(22452003)(5250100002)(26005)(8936002)(2906002)(2501003)(2900100001)(66066001)(72206003)(105586002)(14454004)(76176011)(25786009)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0744;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ktulxnkAIw0QFI9hJPFTcFdvBtehd7pmvQN7j7phlWwo1vlOUHEb5thzm4SL38UcZkbhvYjDFtogpU3BXsKFDRm0anOtw7McRvLWpgiD9dF3+39CIQT9818ydxZ8oBS886XWLz1j+Wrkbp4z/JzXq5pqaZMGbst01SyGzAHqETzb5uCqqJZwI48ywQ0YlsvVZDsr1potncegqByAK343uRZWXZDBaVq3YFSl4HUuvplWaLE5EvMFmmCnzmpGYFiksTSGEFGB0HptWM5EqgAa/jBKgCa62Bwi7B29/Nuj+yZivWp+PZK7sLvrRTF7wtBxzFHnhforrkPISEmlU6uVTGZacIVliYrS/yOlUTY8p2E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dd3adac-6f2b-4304-bba2-08d6222cddd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:48:35.5805
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0744
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jon Kuhn <jkuhn@barracuda.com>

[ Upstream commit c15e3f19a6d5c89b1209dc94b40e568177cb0921 ]

When a Mac client saves an item containing a backslash to a file server
the backslash is represented in the CIFS/SMB protocol as as U+F026.
Before this change, listing a directory containing an item with a
backslash in its name will return that item with the backslash
represented with a true backslash character (U+005C) because
convert_sfm_character mapped U+F026 to U+005C when interpretting the
CIFS/SMB protocol response.  However, attempting to open or stat the
path using a true backslash will result in an error because
convert_to_sfm_char does not map U+005C back to U+F026 causing the
CIFS/SMB request to be made with the backslash represented as U+005C.

This change simply prevents the U+F026 to U+005C conversion from
happenning.  This is analogous to how the code does not do any
translation of UNI_SLASH (U+F000).

Signed-off-by: Jon Kuhn <jkuhn@barracuda.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/cifs/cifs_unicode.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/cifs/cifs_unicode.c b/fs/cifs/cifs_unicode.c
index b380e0871372..a2b2355e7f01 100644
--- a/fs/cifs/cifs_unicode.c
+++ b/fs/cifs/cifs_unicode.c
@@ -105,9 +105,6 @@ convert_sfm_char(const __u16 src_char, char *target)
 	case SFM_LESSTHAN:
 		*target =3D '<';
 		break;
-	case SFM_SLASH:
-		*target =3D '\\';
-		break;
 	case SFM_SPACE:
 		*target =3D ' ';
 		break;
--=20
2.17.1
