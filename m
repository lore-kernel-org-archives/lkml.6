Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D07BECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D68D2087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="BJQtjkUG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D68D2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731468AbeIXU7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:59:32 -0400
Received: from mail-bl2nam02on0111.outbound.protection.outlook.com ([104.47.38.111]:27262
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388520AbeIXUxA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:53:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7EIAXvIGT5n2s12s6nX0zQfNdKPZn25kqHDIajyJ810=;
 b=BJQtjkUGH3Quq9+TTSFibhaBAVnLOgIxVnhUv+blWE+0stzzRvxUVv+FmYjiPRe0pLDtKxvxbym3qbGNb7NWp72jXDrEf8qca0UmdobMpDXCtDM3xCj/sHTxJ/2BObiyKmFYeGnZufSjDpJ9m31OPCXm5Z1sCSLb3kQRY0z4dRE=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0470.namprd21.prod.outlook.com (10.172.121.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:50:20 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:50:20 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jon Kuhn <jkuhn@barracuda.com>,
        Steven French <Steven.French@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 28/36] fs/cifs: don't translate SFM_SLASH
 (U+F026) to backslash
Thread-Topic: [PATCH AUTOSEL 4.14 28/36] fs/cifs: don't translate SFM_SLASH
 (U+F026) to backslash
Thread-Index: AQHUVBXAntAiw2O/Ekec5V1k+kCHRA==
Date:   Mon, 24 Sep 2018 14:49:09 +0000
Message-ID: <20180924144851.164533-28-alexander.levin@microsoft.com>
References: <20180924144851.164533-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144851.164533-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0470;6:sdSSTyAwBZN4T5Fjx4gIfZjH8q0f61qfFkRKuyHulqGvfOGrJBXgv4b1FYGr3V/ex/2IumaL0KoaJkKbsQmdSgTtrjy2Z+9Hz35DB+J1sdaLUdPffOvOSpzu3suSLH8oyYRPr3pLyLr+kgjWip3YYxO1cEox/IE9VM7e7j9xnSg+fIBtP/GT7yKrc2MgPBxstDq/UNYQbuUXRx3NPS4M1oR61oiFS4zX7zIH+hVQsgpLWE5XQkOqt0MJB29BYFGs92k8qn0Dn1/qmNtF2uRPcPDgwrYpzi4qNRbWIQ7HqCwzeZWYu5KBRj87wRu8DfTMN8fbpDgX/m/fq88TitE5c2q/Bri+6rOHvA89B+9jHJxhNoQYtySo+VhYSWaCTjC373dDu/gNgkamAUrMsLYqKwcaR075MpmZnnI4J/x2PMQXY5Mh9qLvL2y9dFy4mF9JNgyrXWU/eX0nIiYAyRiVCw==;5:yZMST3owpjKF0UjzeJouyCwcdh03W7WAgIP0kHBqUWcHymgkkQWwQH5hqqXvP6G/FYp1SV04q5kj/3tpOfnXcnByS395+ITMctFGt873utSwJvz44FeaWt5R8+MLFp3wiDhnBkLnA+vEnycQhhSzyxehoG8lHI6aTZFrnhnxagU=;7:TvA1VmO36HBvV80NPdlo77k8gOrBNamtKT7ILbmbUfD58XmJk0jvWDHECkNntQrNwORYLCGyHxT6SvY8QwkMWDZB4bm2svVvhy2W3p6UvpHWOCCFOXOj+BE3yGEVI2xrotsDevXXJjeNfZPR5l2Bf4gPX+2+X3SoJUovLL2M7+TBcmvATRyWrw9T8ccjwJnTKooyYsud5LWEbqer29+UTqZj2VKrNYodTTlGIqP1VDYFGmqKDKon/2EX6qRqrjl5
x-ms-office365-filtering-correlation-id: 7320f41f-b49c-480f-c615-08d6222d0cc2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0470;
x-ms-traffictypediagnostic: CY4PR21MB0470:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0470507FF6F91B1999436207FB170@CY4PR21MB0470.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(158342451672863)(129605872554195)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149066)(150027)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0470;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0470;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(346002)(366004)(136003)(189003)(199004)(26005)(97736004)(53936002)(14444005)(25786009)(1076002)(76176011)(99286004)(102836004)(186003)(6666003)(4326008)(3846002)(110136005)(107886003)(86362001)(5660300001)(6116002)(72206003)(54906003)(478600001)(8676002)(217873002)(86612001)(256004)(14454004)(10290500003)(316002)(6486002)(6436002)(106356001)(486006)(105586002)(446003)(6506007)(11346002)(476003)(10090500001)(2616005)(2501003)(5250100002)(71190400001)(68736007)(66066001)(81156014)(71200400001)(22452003)(7736002)(305945005)(2900100001)(8936002)(6512007)(81166006)(36756003)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0470;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: wJOEfGwSgRS29WQAKsMH0ojAqBX3562JZZN/TXtLINOmrkDuUIuE+QV60gVcg9HtbkpPdwz8SEnvIq/scW8HRxkvKxd3GnPgPUJJ9OKxArdRM7e3iTMgt9vk6CMWRaxJR1RGT1K+2Ub4yUeVXbjjk1UOCZJxwJycIg1P3rpIqrn6ou/qWMFwADcbGqKkEMZ0h76f2v2WBpDpkodoVKzOqvjni0OmA/EXaIV0GijFgcJcRhGN98i4z2IXfJjqFPe+/qrCuc3tni1ULYbpHnCmqcUNmxpS9o5+fw90PMqxNOuXWf6SLtF3HPbr4vZtUki+P7BUST+ykKgIhsK40NIdhKorxsUyuGio8mrR/XK5H/Q=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7320f41f-b49c-480f-c615-08d6222d0cc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:49:09.3904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0470
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
