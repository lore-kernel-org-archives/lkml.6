Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33330ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCF62214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="IVQ3UVAX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCF62214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728692AbeIQIZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:25:54 -0400
Received: from mail-by2nam03on0114.outbound.protection.outlook.com ([104.47.42.114]:33973
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728493AbeIQIZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:25:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cDce4bn/jKKSRoTt8larrKgGecTgRk3Y9lSq5TG1KQE=;
 b=IVQ3UVAXuqBZaCCKjCN13+ZS2RiM4JHEFRLrjNcGVFdDeOXShW3G/pHKxfK8eiJws1cbGF5rIC50Rilk5pda0fjHIdBZYRYp/R3cwM3NCRM8g6C/kdfU9Mxa1mhD33eiYR6nHJxWjxV49Cfke8NSqUG+8I7x6PkF4am2gjFtwz4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0277.namprd21.prod.outlook.com (10.173.193.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Mon, 17 Sep 2018 03:00:22 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:00:22 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Colin Ian King <colin.king@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 012/136] staging: rts5208: fix missing error
 check on call to rtsx_write_register
Thread-Topic: [PATCH AUTOSEL 4.18 012/136] staging: rts5208: fix missing error
 check on call to rtsx_write_register
Thread-Index: AQHUTjKQE6ssW/zwLUuuWYNJmYUirA==
Date:   Mon, 17 Sep 2018 03:00:18 +0000
Message-ID: <20180917030006.245495-12-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0277;6:0QxMt7ygMVRTKaPS0lC/LWyKBs9zgIYom7YtJhyAusLIatOmGlNV1KB67FoZU/oVcUmRBr7lUQqqWOa961x1ZWSvjw7Es5OttZ281nampu5xCvdejD0aCvW+6mGyqy4wh+TZnzd1LrgDgmHIQtrtnlMqUkEs+NjO9BnZXlYjLsWChHevQL96FRpOKkDt4zWJJ+MxgQs993FWXMc/W3rWmq5oK+SjfbIz4aDI3EWjSL8WK999b04K3X27rUDVLA6EIPHDsYlp8YT+6MMSXvENHtKc6n1NfxLhqzn2hwUEepDMkRBesaTHlfFEpJM7TgeppPLD+bxILvyWD0aXK6btqzY08/6zvdCsagZ9jl+rZiv3Y4jgekSS7pFX3fCqxFHFaOh5VNWbTP40kIHg10as99/KCrbrCdcIhZ5TEEwv34u8iP9eSGr92uSkmSENiReaTOj+Z16hIU01tdpgCr2Tuw==;5:hgnILvX/dLf9CKpK+731HYCzmZjMrWnypp3u+8A8Ph1dex6m3J+vaqOnSCLPmPj6VF4v/yA99xuPBzGPflxBemNahcpObkwFmFyjTRUgaduCheUXwPBlCGaB5Vmhv7TdfbP21m8P2IPzu2DdNg5uuiMc/JdfxhrWu/GY7as7Pi0=;7:GJZrnbYKHT5CoSF8LQIydbHeoXldj/dk/hRhBR8lA5UMwanhCbUdkiBBZCD0+rhWLh6Lrrvmky6wPVcQTb3rgjgJWhVeBfiKmagmJJCOzEKO0mEpY8kkkgVOdUo6v896/tFqFgpYtMO+CFyN8ugIqOfBGF7iQrkeWUA93JWHAHmzpT6A9ghMdAJRYTBwoYYULKtAM7Q8QnuzwQ5ZP7ua63JmoZoCp12F3Fb1KbiLxi1yPgAuXOQvQPqH9EHXF6D6
x-ms-office365-filtering-correlation-id: 8fae8b8f-18f1-4dcf-7de9-08d61c49b5df
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0277;
x-ms-traffictypediagnostic: CY4PR21MB0277:
x-microsoft-antispam-prvs: <CY4PR21MB02775B3DFB46E8D846C01A93FB1E0@CY4PR21MB0277.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(198206253151910)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0277;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0277;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(376002)(136003)(39860400002)(199004)(189003)(446003)(4326008)(2616005)(53936002)(107886003)(11346002)(22452003)(68736007)(486006)(316002)(14454004)(106356001)(476003)(217873002)(25786009)(105586002)(10290500003)(14444005)(97736004)(66066001)(6486002)(6436002)(5660300001)(256004)(5250100002)(6512007)(6666003)(2906002)(2501003)(6346003)(99286004)(72206003)(2900100001)(26005)(6116002)(186003)(1076002)(36756003)(81166006)(6506007)(10090500001)(81156014)(86612001)(102836004)(86362001)(8676002)(54906003)(8936002)(110136005)(305945005)(76176011)(478600001)(7736002)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0277;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: QRfGuwCGX6kVVq+hDRLvUC9WHdDX3aiqHaZDxplL2XHJMQlrXOcoTFZAmgMcxQ8exOYGng3EENjpz32YsyYqGn9hRh1YeZ3JBLFZRrnHr/E89b/RmeDF+Dd7ITaiJniR6ov+O73aD+ACAIiQxC9wPttwwL0kO725+ywgPB2pXqUeW2TcqKeKkOBdjEkIiu2AtPtBNy28XCNRPt9fxZCjAtlxHv4QVCFQIDSsP5WtzsToATqFJyQyituV6nGGIkjliolj9mrk1dFSkDiAhI77LKqDsUMXLp39HN/7VC6BFP2p9AiQZS2B2ileUu/vTXuRQD+S1wme647bKW0Loy7f/yVo5/qKydabLp2VMiqfuhI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fae8b8f-18f1-4dcf-7de9-08d61c49b5df
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:00:18.6830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0277
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit c5fae4f4fd28189b1062fb8ef7b21fec37cb8b17 ]

Currently the check on error return from the call to rtsx_write_register
is checking the error status from the previous call. Fix this by adding
in the missing assignment of retval.

Detected by CoverityScan, CID#709877

Fixes: fa590c222fba ("staging: rts5208: add support for rts5208 and rts5288=
")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/staging/rts5208/sd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rts5208/sd.c b/drivers/staging/rts5208/sd.c
index d548bc695f9e..0421dd9277a8 100644
--- a/drivers/staging/rts5208/sd.c
+++ b/drivers/staging/rts5208/sd.c
@@ -4996,7 +4996,7 @@ int sd_execute_write_data(struct scsi_cmnd *srb, stru=
ct rtsx_chip *chip)
 			goto sd_execute_write_cmd_failed;
 		}
=20
-		rtsx_write_register(chip, SD_BYTE_CNT_L, 0xFF, 0x00);
+		retval =3D rtsx_write_register(chip, SD_BYTE_CNT_L, 0xFF, 0x00);
 		if (retval !=3D STATUS_SUCCESS) {
 			rtsx_trace(chip);
 			goto sd_execute_write_cmd_failed;
--=20
2.17.1
