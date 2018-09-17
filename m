Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42703ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D78A0214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="hAwbRQGG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D78A0214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729862AbeIQI2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:28:51 -0400
Received: from mail-by2nam03on0130.outbound.protection.outlook.com ([104.47.42.130]:60384
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728718AbeIQI2t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:28:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gdBKgc/FnX+pbwTgQKFEJ9MFrHmFAO1A+B0gdvqUWL8=;
 b=hAwbRQGGLBgA4JI3MKNknG2xWinwlsQnorkP0Rdz2KK2HqkIVLR2U83JChoFdKq22lD4qlKPyeyku5UqhqkafvPsZGRLuC1oIORISIvTN3JIjasiqPtFf4ZgmXsfS/xeO/J7/X1Mht8sUorcRhvDaDNTAl5WaDQW17hMWcxwjnM=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0855.namprd21.prod.outlook.com (10.173.192.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Mon, 17 Sep 2018 03:03:29 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:03:29 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Colin Ian King <colin.king@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 06/87] staging: rts5208: fix missing error check
 on call to rtsx_write_register
Thread-Topic: [PATCH AUTOSEL 4.14 06/87] staging: rts5208: fix missing error
 check on call to rtsx_write_register
Thread-Index: AQHUTjLeWleOn+B7B0irsK+xPeeQxQ==
Date:   Mon, 17 Sep 2018 03:02:28 +0000
Message-ID: <20180917030220.245686-6-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0855;6:OgA+kK+vXC+izL4q3bDnrTqNL3SM5SgPexHusA4srL08C3sDoAFAsLdzjELigbW4ylM238Dw7z6sQPSjTqOSV0rHHqYhtwcxo1W10qMkM9EoSunshFIxqGuI7PZtQ3eNJEI2y4tgkyzyRHRWlRSvM1Xzn0KthMAscGAmhnibLMvDDH9fGFMh/Lcvth8p1rE+9peS2+JlQTCQJC0HDme1W+4tA7tdx2f4GU77qcar/T3u59ynMQuIngo28SnspEh8mwUvUrlFPfQ6lqmEM2TohT5rVPzH0xMy/U6adDpoVlmGrkzNJeSKeQSmL591/rGi2ES8i1okIiw/1wIsb+gob2k7ObRg8L/uGDCdWQwLHamFpzQIV89f3YMxgpm2SIUYALMVehkoFKJzm+NzJr4sS7qibEhpcly91/O6ovhqqgANtnpYVL+GgroVqz6/vcM7MRnv8nsTfZNHql+vS4uL8w==;5:AZm/dLbLsiCU5XqUqzBSI+zKF0FXhVjzXTTMqM/CjqDG4/w5tej4hvvv3GhGynlpJXg+hFD1k5c2YOz+xYIa1eRwkOTn6rflG3xJCbT9ekqP44qENYT0iFbV52mpksRJBSlD3IGbxh2dhu+c0X8C6D7NhHsr1O4lMth9FWqV+f8=;7:pXos5QHAXmTW7PEeTUfGjvfE3wjnQkuzldQ1RZF+LJfEjdlacsGSsoFU0+Mz0f/+BZ32x0ddfKR9hGZ7LxNtYa+m7h3OJPqbAW0wZ3k8l9JwU8ERYyF74jCu3/n0VGxe7d7Z8k8YBigXukTh6C6rTYygltvzIVmRe5LbVCwiYepQxYSWO+petb65crDrIv+gGZvnHvWv7CpCKoi4Fsr5//Ncy0mpkU2VvhzqVoU42czOrX33KKljorOgNpsI0nBS
x-ms-office365-filtering-correlation-id: d488da2d-3af1-4b5e-7863-08d61c4a2557
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0855;
x-ms-traffictypediagnostic: CY4PR21MB0855:
x-microsoft-antispam-prvs: <CY4PR21MB0855A896CF2DB9C92E33B42BFB1E0@CY4PR21MB0855.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(198206253151910)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0855;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0855;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(396003)(136003)(366004)(199004)(189003)(6436002)(99286004)(7736002)(110136005)(54906003)(97736004)(5660300001)(66066001)(446003)(72206003)(76176011)(86362001)(86612001)(81166006)(81156014)(2906002)(478600001)(305945005)(68736007)(105586002)(2616005)(106356001)(476003)(11346002)(22452003)(6486002)(10090500001)(10290500003)(8676002)(36756003)(6346003)(6116002)(6506007)(3846002)(102836004)(107886003)(6512007)(1076002)(25786009)(217873002)(4326008)(14454004)(26005)(256004)(14444005)(486006)(186003)(316002)(2900100001)(8936002)(53936002)(5250100002)(2501003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0855;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: N2VCftMbE6xK5YqdGdzbyk3w0qm4JrdKu3MCZYFBBSYQ6v8hI3ZI7U+0v/5h3vmWYXWV/n8s7d+9fRa3JY8SQQWy0/4P63zJ+6CjGTX3Qg0NcsUOGTbdYYolLTLGqJOYHwLduCV5quEH0Pvve+MeVFGo6dcy+JYeUMza+/6grJv551cmeuNh2EPLg0YHUU3q6lS1ilb+g1jj1pkpWAjVccMvBrfe6O5nUg0yb4NtGVfwTiRbU6QtnmezoLrM4VdjSyWUh23m7s0m9jOoY9w6dJS7mXCgNFX/5iMYS4xO3Zfu/wyq1K+lkZfnCRTiE9P9GQIGl5W8jyjk2R3c0VxfjDoVBdysm+NAdlBb+k3iObo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d488da2d-3af1-4b5e-7863-08d61c4a2557
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:02:28.4002
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0855
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
index 4033a2cf7ac9..d98d5fe25a17 100644
--- a/drivers/staging/rts5208/sd.c
+++ b/drivers/staging/rts5208/sd.c
@@ -5002,7 +5002,7 @@ int sd_execute_write_data(struct scsi_cmnd *srb, stru=
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
