Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E4AC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A12FE2087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="TtkHf/F/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A12FE2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389324AbeIXUyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:54:36 -0400
Received: from mail-eopbgr680134.outbound.protection.outlook.com ([40.107.68.134]:2178
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731967AbeIXUyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:54:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ayqkGHssZRveY7gN1YavpIrEjnsWqBJRKkq8a9Jdekc=;
 b=TtkHf/F/SGF1IVfZzuf8dEzP/4v26e+T7ZJ+5VS9yAxsT0mvI3XIuzctCaP6kVz/Tj9fu48lKmUyKc3BiibmVS7ndK031g+EsOW2yXFafnbjNL9MJ3j/aY0dT1Y6Mqkv8F/w2ZSvIEwdj+1ajWUNBbiSKTQH6uYO4BEGgJ6WStU=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0631.namprd21.prod.outlook.com (10.175.115.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.2; Mon, 24 Sep 2018 14:51:50 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:51:50 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jon Kuhn <jkuhn@barracuda.com>,
        Steven French <Steven.French@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 08/13] fs/cifs: don't translate SFM_SLASH
 (U+F026) to backslash
Thread-Topic: [PATCH AUTOSEL 3.18 08/13] fs/cifs: don't translate SFM_SLASH
 (U+F026) to backslash
Thread-Index: AQHUVBXlK4mNXAY+UE+UuJ5wa44HEA==
Date:   Mon, 24 Sep 2018 14:50:11 +0000
Message-ID: <20180924144959.164754-8-alexander.levin@microsoft.com>
References: <20180924144959.164754-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144959.164754-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0631;6:K9UGoOdX6DJpMzXGNlZz35mZd5rBW4SC+0Tuyn1xMwgN10GoBMN20kAGN7YTBn5U1kw+lZCpJWJLA2rELEvymxMcAP2tLQ5i70/TjE3nI1aUwQ3Y9lOVD3A2BD3abIibHcbLHzP4N6CY4wtbPOPDuroaO/Oa/a0nZNFKz4KYQCdHk6sLQ+O5doLO6ljPw1tz9kEnvvTiTb/8hdJG6F7sTTucvSjUKN7yaEuchAOxhhnfUPNIi05WE9wc4THBUgjBYbsNePO5bZS41sU8iNXRP8ohkO7/QTKChthmgtFfGBn7EBl27dFoJNpn7c7KCTgZjbJWh+lh7gWsEkk1lYImk9OfPwASCGfk9t8xrTX2UA+bHmApXVnjaB33ri6zUqBp65ZbMtIO2lAPfhzqnjxEu4tWYcq71ae4JG1+ZUteV0QxmE8iEY37nBNXC5RnBvvyeLDBgl4Phmy5G4Vme+ixRg==;5:a2uxGI0Jh4cRtP0WOua5RYbcAbhOTQjGMQB/BX8+hhKMn8UpY77QlJxwa3eK9G5Vh3RC7pogtu/QArKVvZM6U4ObeEtmWRUfIRVEw8TdHGv1Og+4fUlFIxgoJ7ZMgbtpttcQfhy1mXX4nnqNXMIYCWZFbQaYYKr0aj6Xr1tXoao=;7:KwW3LWzfBDE4IqevggmEDfjD28rjgCNV9FUvvdaWcvF+4UkfedrGd4Ry7Pdy5xKU1S+yewIoLibv701YCDw3eRqO0vQTv61IBss4OrjAcntkjV1+5NY7sHVidpDPuM2TmG482yDIX8hfwDJjoZU/oJe2f5/Q7h1x7m7riUJxrbsSdJRRhuO7tq+u833CqyYaRSm0z0EmEZMwVbFUvF06SJBukIri1Wr9KPflbZfX2MrBTo4VQEwtyEYkcJJQQJUh
x-ms-office365-filtering-correlation-id: cb97cd96-377e-435a-5105-08d6222d4268
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0631;
x-ms-traffictypediagnostic: CY4PR21MB0631:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0631D998261F6BDF468DDC3DFB170@CY4PR21MB0631.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(158342451672863)(129605872554195)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149066)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0631;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0631;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(396003)(346002)(366004)(376002)(199004)(189003)(10290500003)(316002)(8936002)(66066001)(4326008)(107886003)(6666003)(22452003)(6512007)(25786009)(110136005)(54906003)(305945005)(68736007)(53936002)(7736002)(99286004)(5660300001)(2900100001)(6486002)(186003)(97736004)(26005)(6436002)(217873002)(71190400001)(10090500001)(1076002)(71200400001)(2616005)(11346002)(446003)(476003)(5250100002)(3846002)(486006)(2501003)(14444005)(256004)(86612001)(105586002)(14454004)(86362001)(81156014)(81166006)(106356001)(76176011)(72206003)(2906002)(478600001)(36756003)(102836004)(8676002)(6506007)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0631;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: /mMakDtXG9FC/iU4grSlUI3X93uZKco+ttAKCq8r840RjiOmcfyIvcUprvRuxupFBGhjroH3Z8Deq/xjp8GZAlNJOXVBNwItpETfxUoS69IpudsiyVcdiQh4W6/SDfng1GCAt+Nt99dT2FSEo7GzKWB7mbb/6V9LnITmTfflaA+VzecVdgWA+xlRQVGtpS7deHjf+yRkwO6zUZPdmSbwtFzUkVmBSyzPMNVZh7815PAKea2yKSdXTovPdRv40TV9UoXfbgyk7kjde2v70ef/evoj5bAcjwcz9/0xJNYBy/34TWrFMKF+LZeZEv0chuySeKeEWkaVg2aTbki5JLUpIYrAtM1aDM4fnhmRfR1p+1E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb97cd96-377e-435a-5105-08d6222d4268
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:50:11.8618
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0631
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
index 4c7752639067..a39cb5c01fcf 100644
--- a/fs/cifs/cifs_unicode.c
+++ b/fs/cifs/cifs_unicode.c
@@ -136,9 +136,6 @@ convert_sfm_char(const __u16 src_char, char *target)
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
