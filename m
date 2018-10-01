Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC28C64EB1
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36D9E2083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="AzG5bC+b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36D9E2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728836AbeJAHN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:13:28 -0400
Received: from mail-dm3nam03on0101.outbound.protection.outlook.com ([104.47.41.101]:12851
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728730AbeJAHN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:13:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eMxU0HrB9d9+2tYUZ9/gY1q+Hr3MqxwqyefBvbcwm6I=;
 b=AzG5bC+bgJRqLX69D1nUKVlGy8iFpQnPcjr4VEcGwuH7JGf3TVPHMEa8okP4SR106v7oQ6wguAz2humsF0qM6Eniaw2K22RdzGi7Px+UF8fkwzjY8dz2bmv51m3LlOn+tcPxeAiyt6HgUG/9wtq6fQ5ULMxOTDbFG806419HEW8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0472.namprd21.prod.outlook.com (10.172.121.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.3; Mon, 1 Oct 2018 00:38:14 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:38:14 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Matt Ranostay <matt.ranostay@konsulko.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 18/65] Revert "iio: temperature:
 maxim_thermocouple: add MAX31856 part"
Thread-Topic: [PATCH AUTOSEL 4.18 18/65] Revert "iio: temperature:
 maxim_thermocouple: add MAX31856 part"
Thread-Index: AQHUWR8Jv37A0V42hUi4F4+PMz+SpQ==
Date:   Mon, 1 Oct 2018 00:38:14 +0000
Message-ID: <20181001003754.146961-18-alexander.levin@microsoft.com>
References: <20181001003754.146961-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003754.146961-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0472;6:MaR25Gp8JIGfbuAQ3WK3L9V/RwddTnMtcB5SVEa+jcP3COenBSHBqBG08KyF2Dw0P9KhYoXiaS8dMiiQCHnvS0wyPeYXJris0GIQR5pdNw3PLVyX2rwW+1lkoenX5Nb7W8Pvl+w7RGo/Hl5ZrbtFrAR5Oc1S4/Oe6I+jQD+l1norU2IlBtTIk7jcQvoCuiBflH5NFnDpG85QK8OrR1OIM39v+1nxVIHqLCZf+hLXQWnVzTGvVEa+/vA6A6GPctkrBk7cgS2/Ib6AuaRBgKOMLBnxX8CjCF562qNk9+aW9bQ3F/Wq+v8sev4vW+Az9cgL4IXc1OND9vLuIQIyp8CxizeXkB3au0FlRxNpUg6Hj+zy3wyDXbCtN10HDu5QjnASXTE5YDVSdpfaJhj44MCE5G73AbUYqgedXcql4z3zalw9957nP+QLmlz2maGVAIEDipQLaTUc2Lvp+1PFOCtwEQ==;5:crIQ80WyJz66zcEW3j3ihzkEQsI957xt9tDVDZtvN0mgWD7+1jXEyY7F0FqoEL6wZRykW2YZZWx6L1XIhKteu2GTmZf/Elr8gzjeTj8CU7WSvN2QezEt90AeFO8fEdoo8M2+E+B0qwrzSucmzE1mLJVfXmmpxsM3hrCan5xdYoY=;7:pub/3G2vRGe6g+njMqcwnBEb9Z+c+0fzPcxtorz47jMPVdbXDe+EPriMDmp1g5XafLULWQSY6CM9OArwwF6Rn1BMgX4c2SwfolI27mHp9KeTLzRvhtTCg3pXeflfBB44qDjEcLbyn90ZKIQJo/PvT7JEbdip9SVYwWgPVsKpINUkjSbYpg5vjwEeh9zc+rGKYxELPuBTJDmVZppEG8o+YiCZ7w0At0l0ZLUwy/oIObozmrS5X2+VvUccGtLE8zmN
x-ms-office365-filtering-correlation-id: 715c3389-62ec-428c-783b-08d627362c31
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0472;
x-ms-traffictypediagnostic: CY4PR21MB0472:
x-microsoft-antispam-prvs: <CY4PR21MB04727C56B38E867771DFAADBFBEF0@CY4PR21MB0472.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(50582790962513)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0472;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0472;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(396003)(376002)(39860400002)(346002)(199004)(189003)(5660300001)(6486002)(8936002)(68736007)(486006)(6436002)(2616005)(6506007)(6346003)(8676002)(6512007)(81166006)(81156014)(5250100002)(6116002)(2906002)(3846002)(107886003)(2501003)(1076002)(22452003)(478600001)(102836004)(25786009)(4326008)(97736004)(10090500001)(11346002)(256004)(14444005)(106356001)(105586002)(99286004)(86362001)(575784001)(53936002)(316002)(71200400001)(71190400001)(305945005)(2900100001)(217873002)(7736002)(10290500003)(14454004)(34290500001)(446003)(66066001)(72206003)(110136005)(54906003)(186003)(86612001)(476003)(76176011)(26005)(36756003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0472;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: KDS+ZgKLDkTJ1u7DMylRdSg29EJ5V7rfMgqwuAF6TP775MRITiue/kU9Mcg2966DEhE4Euqkiqs5miTy7K7Og8HmOO+L9YYJFDRWcWFGpl3YNm9NWKCGdajht63/7Ou5fDK2FbZA3hzKqPND8Sb+TMOa2gJKSpQMSW1fj0VAcjA/xILzwLbdHY0s1txOX34SemhYoQaENkBsK0K+AVv4sO8NRog4Nd6sf17w9pPF/2KRx0DM0I7O7FvflG5UZiB0t0jjqmivzOfcgUdgrm21lhL4fG4FmRoYRfiBCIKzvqNnPEhOM3yOIU5ZP4LwQEhKXw1It8rvnzB/ORsCfUzyhvEgxqi0BUjsCIOjRBfpfb4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 715c3389-62ec-428c-783b-08d627362c31
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:38:14.0999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0472
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
index 54e383231d1e..c31b9633f32d 100644
--- a/drivers/iio/temperature/maxim_thermocouple.c
+++ b/drivers/iio/temperature/maxim_thermocouple.c
@@ -258,7 +258,6 @@ static int maxim_thermocouple_remove(struct spi_device =
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
