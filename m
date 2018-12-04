Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E313CC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B545B2081B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:33:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B545B2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbeLDSdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 13:33:20 -0500
Received: from mail-eopbgr750044.outbound.protection.outlook.com ([40.107.75.44]:19558
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725797AbeLDSdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 13:33:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/HnY920aSoED7Sp4b4ntYVwVWA+mVzTFSbBy55W+xo=;
 b=kp6wDOwkojb2F+4ZjmyHZ5u7/AvQqzKl3P0T5x3Xng0iknpEL9qz7zP6pEkX20RHkm/U93CE2RqNx6uArv5kY197uKJKVUIhOZbRIz778g79cdddUxwtOsf4VNXd8i25pEaqPrxe+co/fuHW1VZ31UsLADubS2ePZzv4sISOSB8=
Received: from BL0PR12MB2355.namprd12.prod.outlook.com (52.132.10.161) by
 BL0PR12MB2562.namprd12.prod.outlook.com (52.132.27.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Tue, 4 Dec 2018 18:33:14 +0000
Received: from BL0PR12MB2355.namprd12.prod.outlook.com
 ([fe80::6d6b:9a9e:71b6:1c0e]) by BL0PR12MB2355.namprd12.prod.outlook.com
 ([fe80::6d6b:9a9e:71b6:1c0e%3]) with mapi id 15.20.1382.020; Tue, 4 Dec 2018
 18:33:14 +0000
From:   "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
CC:     "Agrawal, Akshu" <Akshu.Agrawal@amd.com>,
        "djkurtz@chromium.org" <djkurtz@chromium.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Adam.Thomson@diasemi.com" <Adam.Thomson@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] ASoC: Fix function return type
Thread-Topic: [PATCH 1/2] ASoC: Fix function return type
Thread-Index: AQHUi//Ro7UpefvJDUiblqpXWVc9pw==
Date:   Tue, 4 Dec 2018 18:33:14 +0000
Message-ID: <1543948103-20752-1-git-send-email-akshu.agrawal@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BMXPR01CA0048.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:c::34) To BL0PR12MB2355.namprd12.prod.outlook.com
 (2603:10b6:207:4c::33)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.156.251]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR12MB2562;20:1V/ts1If/RTrXtx8kzcS0UqyzDg0mgxxAx3/E0IXcUAtpiSYHMQhrlfG1hjM9f6GMNQl8VBzaySF/KauvF49P23cfaPuJQb7u+0Uk75PqdWRUhgIXrJCkq1kiuBGfEPqtoX3i2ob/kQXp1SsPgbTLhdlzg5JrRmIPSIkBRgMUHQGMbc0Y2nl92EnbK9UXGAfKyE43TKV5Uo7e+ubOicgGBTZOV2sRzx7qB5fQwMz4B9axJ/o3UpEPr8kHZCofy+6
x-ms-office365-filtering-correlation-id: 6c9cb9f4-5fe9-483a-3f2c-08d65a16f34f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BL0PR12MB2562;
x-ms-traffictypediagnostic: BL0PR12MB2562:
x-microsoft-antispam-prvs: <BL0PR12MB25623BC64919D434684980F4F8AF0@BL0PR12MB2562.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231455)(999002)(944501493)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BL0PR12MB2562;BCL:0;PCL:0;RULEID:;SRVR:BL0PR12MB2562;
x-forefront-prvs: 0876988AF0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(366004)(39860400002)(396003)(346002)(189003)(199004)(86362001)(6436002)(81166006)(81156014)(6486002)(14454004)(7736002)(8936002)(36756003)(305945005)(71190400001)(256004)(97736004)(71200400001)(102836004)(1671002)(25786009)(26005)(106356001)(39060400002)(2616005)(68736007)(105586002)(486006)(6512007)(186003)(59246006)(53936002)(4326008)(109986005)(8676002)(54906003)(316002)(99286004)(52116002)(5660300001)(72206003)(478600001)(386003)(476003)(66066001)(6506007)(2906002)(6116002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR12MB2562;H:BL0PR12MB2355.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: QZ5X/qbG9oWm5uNO+laXYyCQaRAzMtth3nxX7wB586Kxbigo77FwptNquSQclHYRGObE/IGaCMfTfGIsDoxhQQKl2A3ngsh6Zl/Em+4g0FaCKkGUZ0zgF8OZqPlXGW4ASBt/RSMtVwpZhsZYIWsz0sqPvxNz6z+tnnJMA0t5vy/ADnPmxs92/RlwyT6+fvfPj0BldnWTMcfiOtAMvrqSmb5vLeu1Y08Py2n/uG6Oln4Dgb19+LEEdisVkEyvhJROiI0RFJwcn+qNeydH32bP/NuF7wh6BEzQZ/bKpUCUcXm0i2QQnrzifGnSwBWYmFXsZxV0PmFhpUtqxum86XkvAf24jaSHKiKfzrQzPNfZryk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c9cb9f4-5fe9-483a-3f2c-08d65a16f34f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2018 18:33:14.3625
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2562
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function returns -1 on error and the return type
should be int.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
 include/sound/soc.h | 2 +-
 sound/soc/soc-io.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 8ec1de8..591d743 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1341,7 +1341,7 @@ static inline int snd_soc_component_cache_sync(
 /* component IO */
 int snd_soc_component_read(struct snd_soc_component *component,
 	unsigned int reg, unsigned int *val);
-unsigned int snd_soc_component_read32(struct snd_soc_component *component,
+int snd_soc_component_read32(struct snd_soc_component *component,
 				      unsigned int reg);
 int snd_soc_component_write(struct snd_soc_component *component,
 	unsigned int reg, unsigned int val);
diff --git a/sound/soc/soc-io.c b/sound/soc/soc-io.c
index 1ff9175..d08f5b1 100644
--- a/sound/soc/soc-io.c
+++ b/sound/soc/soc-io.c
@@ -38,7 +38,7 @@ int snd_soc_component_read(struct snd_soc_component *comp=
onent,
 }
 EXPORT_SYMBOL_GPL(snd_soc_component_read);
=20
-unsigned int snd_soc_component_read32(struct snd_soc_component *component,
+int snd_soc_component_read32(struct snd_soc_component *component,
 				      unsigned int reg)
 {
 	unsigned int val;
--=20
1.9.1

