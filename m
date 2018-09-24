Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5F2C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDA4320C0A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Yw9gctva"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDA4320C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732553AbeIXU4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:56:19 -0400
Received: from mail-eopbgr720095.outbound.protection.outlook.com ([40.107.72.95]:35088
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731516AbeIXUyB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:54:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjLJ87+c0oECD5F0TVCRYLRPCzPpvA3uJUTH06wJZzc=;
 b=Yw9gctvaPpHy3HScVb/i/ATML9UCVe5sqqaeAVKk0PI8u7jjm7J/lcpUQ3VBLr0y8PYEIUEsbzw3sz2d0RpT3FTxhogQZQrPtQbQXyOuKX/YrnvsqAkghOVlwv98TH+Rsl+luyT6/qey2GwZQBfGbjJA7njpOV9betcMPYsGrqk=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0821.namprd21.prod.outlook.com (10.173.192.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:51:09 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:51:09 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jon Kuhn <jkuhn@barracuda.com>,
        Steven French <Steven.French@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 12/18] fs/cifs: don't translate SFM_SLASH (U+F026)
 to backslash
Thread-Topic: [PATCH AUTOSEL 4.4 12/18] fs/cifs: don't translate SFM_SLASH
 (U+F026) to backslash
Thread-Index: AQHUVBXZNnCMob1Ypkq+yv56VFveug==
Date:   Mon, 24 Sep 2018 14:49:51 +0000
Message-ID: <20180924144942.164688-12-alexander.levin@microsoft.com>
References: <20180924144942.164688-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144942.164688-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0821;6:EzJ5GmIAbtS+yjb5INblaaBSMRbKYfGOHhz4e34ISADA+iZCXsYrr56d4Y6vf3r02d1YyfB5y6Nt6dUnDZlMzIWsjlyN8DpgTEfiOCgZdnGvU1MW2GjPtCcvYHSJ18fFSQOivca3w4Tv8aRQaEs6T3dTc7/6kAaniN8YIUaPTC0Lo1afqyNyFkMhsjzI1Zztvk7WvryAulZo+NAnhSzwAU5H2olYFaq+1+/YC0vuHG+e49SEsB4Qt+beneFbndjOu70q/lu6vrODKnQsrfsSeXAe0/ArPcstRd4jFBiAdVC7T5RfCdEbAKfmHHEuQBYQcbzKWyszcDNgGYymc+W5A0r0aukI1af1umXLWhg4l7lpD++t/DsWh+WEeCUzI4JqVk6TpRv4OQojBoS4aYd3UYY5g8vmTXaRBiu5e/p49FR26FwEVnKoQzrCN9TXvxzoDTGKiUPeYkxk6C5NodVdOw==;5:Z4Y1/ciAX7W1lQXPF9uAcvL1Y0CbMbvh0lDN8te0BjtF/8ek47R8jchHy3vmyKzoqsRkq80SlCfpymk1NZZLSUtYpe6cxnVYp76bpm2PZ6big7W6383pVt1r4X8w1WvtVC2mLcgskX2oCOK1kbXMumZtkKUjEVurFatFUs+PP6g=;7:c8xNTHuUOIsLZTEFF2sd3wujuyxxLIy5Wi2gGRDRVF6NKjOuQAfB8Rxm6/MvbZsJe6hNh0E3L694/dKANfgvqyWcqXFWg8is7m4pwOpxw7VK9bA6haaKothCapbh1+EE5xf4QtSFxA9RS4O1gKDFeUjmOE61/nN4uc0pPMPOvn3h9M4YU0+TfLg02NJM0rFG74NPMtmAukWryWnqrEG6Dha4CbNPGwK+15CMnwXYh4ChD75Aa9SpuKz/ZdIiWGws
x-ms-office365-filtering-correlation-id: bda53647-80f1-42b0-b3bb-08d6222d2a41
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0821;
x-ms-traffictypediagnostic: CY4PR21MB0821:
x-microsoft-antispam-prvs: <CY4PR21MB0821DAEF6532F128885D2022FB170@CY4PR21MB0821.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(158342451672863)(129605872554195)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149066)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0821;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0821;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(376002)(136003)(396003)(366004)(199004)(189003)(102836004)(5660300001)(53936002)(6512007)(6436002)(256004)(14444005)(217873002)(6666003)(6486002)(2501003)(10090500001)(2906002)(68736007)(5250100002)(97736004)(107886003)(66066001)(36756003)(4326008)(25786009)(1076002)(3846002)(6116002)(2900100001)(8936002)(81166006)(81156014)(8676002)(86612001)(575784001)(86362001)(7736002)(305945005)(72206003)(186003)(26005)(10290500003)(6506007)(6346003)(478600001)(14454004)(110136005)(2616005)(446003)(11346002)(476003)(76176011)(486006)(54906003)(99286004)(105586002)(106356001)(71190400001)(71200400001)(22452003)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0821;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: xiPgFNDyZZiKAD72hmXpsrxqSjeYQsYXId7FJyPu5yEbYDbOzt0qhdFrcD5X6DTx3GhLwZXWK8ujNfJWaqT3xhYuRY+CyHU5fjX3JH3bTymIgk2+1VG6fZCMsKk89F/AceggzQG5K1FSpfm0RQP5N2LpIwN8EqJHd0+GZ69tTyyWSJnMWg8wgbhogMeM3YTVxYZEinRNsObM9Phh724GUXT2Xn/xmKWwo222j2W3T/nSnmZge6A0nSMNEpo2m1uhMLHM/khGmWKbpSZaPUtQPNNGKyILhwk+Ew9+II1A4qcuZ+yjCfpin82uyOJOCViFBLfHGizh38YtCVdy6S5y/cikrKB752ctf+rnoQhHpCA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bda53647-80f1-42b0-b3bb-08d6222d2a41
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:49:51.5471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0821
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
index a0b3e7d1be48..211ac472cb9d 100644
--- a/fs/cifs/cifs_unicode.c
+++ b/fs/cifs/cifs_unicode.c
@@ -101,9 +101,6 @@ convert_sfm_char(const __u16 src_char, char *target)
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
