Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8688EC64EAD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40C6C20666
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="SDlBrLOp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40C6C20666
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729611AbeJAHPB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:15:01 -0400
Received: from mail-dm3nam03on0121.outbound.protection.outlook.com ([104.47.41.121]:26473
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729559AbeJAHO7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:14:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nrMPVPeoE7YAB6JC0WDx6uhzeKyBTk99kpvZE+E11TM=;
 b=SDlBrLOpingHZMrzbvMQwxwwSSSpBAaivv8xACZZk2jZW+vWSYwm8nUDs4gY2R1cqrmowVSoHz0SqRN/2vXO5ZYEDhGR/ukVe1N6yx1NR3HiHnqDcTpEr6JLguaQ9/XqWbzpoPGOs1+5R3WVWCzwfNJOQ+UPDpaxHsyJEdAuOSY=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0696.namprd21.prod.outlook.com (10.175.121.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.6; Mon, 1 Oct 2018 00:39:42 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:39:42 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Matt Ranostay <matt.ranostay@konsulko.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 12/37] Revert "iio: temperature:
 maxim_thermocouple: add MAX31856 part"
Thread-Topic: [PATCH AUTOSEL 4.14 12/37] Revert "iio: temperature:
 maxim_thermocouple: add MAX31856 part"
Thread-Index: AQHUWR8lhvYhrQD38U69gxiNkvei1A==
Date:   Mon, 1 Oct 2018 00:39:01 +0000
Message-ID: <20181001003850.147107-12-alexander.levin@microsoft.com>
References: <20181001003850.147107-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003850.147107-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0696;6:dSkbB2j2CP1ji9+K6mqAnfrgKtyE9ZP1cXzS0RXunxJLKg18Cpqka3FV/cCDU5jyTHYjbTMuIAvKEoFl9Qrn/mdiQ02mc8883qcqzHMmJARU1fihbOlpoILBZwbmLPsqaShSAMmwe5Yj0g0hUybDAoLmAp8sjH2XGFrfEcObh/tKR7HYjUePUFdwZgtslJgTS7VZngzREOCD0gjrpZ2ubQo47BzFkzNHaUTjRpvIBA9yGAGeR502l7yV5C8+/jWtJcYZ4cu5ze4dvMhabbzpZyRpbrepJu9DgFhKceW3FKOsWhjOZcYNsxi7a2G9muRzMnV+Lz/FM3KEDwRepgTPINwK+T4HosiSkIXIgOkz86FWkLVpCemzewZd/QLBStdxe+A+qpnUoIDqPjtEUCtCEg7oHlEIVQo3eZHsOVKLl3qRyY1OmOJF/yTrqyCz5SMG3DFl72KyHwhkOK3xui9uVQ==;5:vQmkAHomePq1CHDvxRS0pqWKVtHT5gQ3VKpsV2r3ia/1ZBRMCH3xwCUbs24b2XJuRfedfZXQxdWL5Eo4HHbieFfYjuktDEjn29R2PTJMhqJdMJqxsUwMRktrarIl0dRXYz2J4t/UP+07pXW1DogHCuBjRsBn7Sd2wmQurGPQt6M=;7:HQLxCjxiIZJmOM/vPEoKLiLtd8OTHGprnOEfrrM+lN4TPGAiZj/nmQ5HuAlECSFRxlzEfeU8tlyrhP0lYyXC6MdxE94RLavyKqbB8++UKPZMDMRIuxYVUHc3PXVYMJz1Vw/vYVB4diVOGy17cfludOqTybIBuMnHk5DiskVHyELMu5hOXeF69s8Mb8G/K5e12AZtFEaHo4uNhe5gStkjVaHvu42OlSkPCXH7+LsAeYGLIXedDZOfgizCkBCiSNkt
x-ms-office365-filtering-correlation-id: cb7fa473-b73a-4071-dac9-08d62736607e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0696;
x-ms-traffictypediagnostic: CY4PR21MB0696:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB06963CA7BB7F17060EC11EB2FBEF0@CY4PR21MB0696.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(50582790962513)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0696;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0696;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(376002)(39860400002)(396003)(346002)(136003)(366004)(189003)(199004)(3846002)(6116002)(5250100002)(71200400001)(97736004)(217873002)(71190400001)(1076002)(76176011)(6506007)(99286004)(11346002)(26005)(86362001)(575784001)(36756003)(2501003)(446003)(2906002)(86612001)(102836004)(2616005)(476003)(14454004)(107886003)(10090500001)(14444005)(4326008)(34290500001)(316002)(486006)(22452003)(256004)(186003)(66066001)(53936002)(305945005)(25786009)(2900100001)(106356001)(6486002)(105586002)(7736002)(6512007)(81156014)(81166006)(6666003)(8936002)(8676002)(5660300001)(68736007)(54906003)(110136005)(6436002)(10290500003)(72206003)(478600001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0696;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ShS/4RuCGUGcfDkfSXXGC6c0zcLp5jWO0F6wCNK2dhgfUB3ewuu0J6+Zyvs82s0umpnslxyXG5DhMd6J2PX2pzyXyzo/nuRKpcXVBkoW60YOLpL86YXXM29ctx6iP0zTGSBfqMvD47qpg8tgfdYRg374ORlE75hw+pXoDjmQaGrfCupVx7WmsP4xuz1io6p4/m6CSIVcH3UIZBneCs8foyYXSqkMWFZml3fO4scvpoaxvnpZXLKlz2rVno0ojnx7SHR+E54NkKEiWE/2jraASt9+Hlf1QEUNmFd6iCEyD+PUHnX7uv2bifmAUzyAHTYVQMqcmfsKVEghjz5Axqi14HHEXnDUpK+O1mo2rMHQsS4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb7fa473-b73a-4071-dac9-08d62736607e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:39:01.0157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0696
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matt Ranostay <matt.ranostay@konsulko.com>

[ Upstream commit 65099ea85e885c3ea1272eca8774b771419d8ce8 ]

This reverts commit 535fba29b3e1afef4ba201b3c69a6992583ec0bd.

Seems the submitter (er me, hang head in shame) didn't look at the datashee=
t
enough to see that the registers are quite different.

This needs to be reverted because a) would never work b) to open it  be add=
ed
to a Maxim RTDs (Resistance Temperature Detectors) under development by aut=
hor

Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/iio/temperature/maxim_thermocouple.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/temperature/maxim_thermocouple.c b/drivers/iio/tem=
perature/maxim_thermocouple.c
index d70e2e53d6a7..557214202eff 100644
--- a/drivers/iio/temperature/maxim_thermocouple.c
+++ b/drivers/iio/temperature/maxim_thermocouple.c
@@ -267,7 +267,6 @@ static int maxim_thermocouple_remove(struct spi_device =
*spi)
 static const struct spi_device_id maxim_thermocouple_id[] =3D {
 	{"max6675", MAX6675},
 	{"max31855", MAX31855},
-	{"max31856", MAX31855},
 	{},
 };
 MODULE_DEVICE_TABLE(spi, maxim_thermocouple_id);
--=20
2.17.1
