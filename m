Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CAA4C282D8
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13D0021473
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="gZoeLnUL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731567AbfA3PIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 10:08:45 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:13626 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730505AbfA3PIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 10:08:40 -0500
X-IronPort-AV: E=Sophos;i="5.56,540,1539673200"; 
   d="scan'208";a="27058554"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 30 Jan 2019 08:08:39 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 30 Jan 2019 08:08:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AS0bpVOWnq4BG8ZsO4M6ItdHVuTTkLJQPyTfOxA2OME=;
 b=gZoeLnUL/du3/yC6Zw6pAyy4jzlM9dBFntlDDcOaBeRVbJYl11xp5kY56gjTpBxnVDV4KVW4H0G4giHGWF1XO0rPwYj5RoJ8w8csLsiIljVzC09H4sKD0sMJNBVYvVO0czIK3Z+Ot0hbaYADkRj8egczvoCm8wZoJIYuD2X41r8=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1796.namprd11.prod.outlook.com (10.175.99.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.17; Wed, 30 Jan 2019 15:08:38 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.017; Wed, 30 Jan 2019
 15:08:38 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <broonie@kernel.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
CC:     <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH 5/9] spi: atmel-quadspi: return appropriate error code
Thread-Topic: [PATCH 5/9] spi: atmel-quadspi: return appropriate error code
Thread-Index: AQHUuK2tLf54vHcEj0qIhNwqgM2FvQ==
Date:   Wed, 30 Jan 2019 15:08:38 +0000
Message-ID: <20190130150818.24902-6-tudor.ambarus@microchip.com>
References: <20190130150818.24902-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190130150818.24902-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P189CA0019.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::32) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1796;6:lIxuI5mySjgfjaDSAMYGj9Hz7exzlnQw5tnQFrVjejd3Tbjb7sI9qTeiLN0zCn075meXwH+QpNIRA25/rySXkdqiYLpJk8qv5xs5vl1adCAaqd1Kq0XkkfoxIZkrO2I6ihyEc/vZcM3Z1RCuaPCP8pDDBZm4xuP7YviloykpqcZ3DKo8A8c+MZUM7u3ZdmIdUXnpm12vwXZM34Ok0cD9xBZYm66x5jysMIqo7yT/uxmSihGttWSO2Q86y5J8qyAAwEuVzq7clzutvZ35v7GejvHoWxlawXH5Q1sCOMXIs0zf0PhBHsIUEv9OGAfUx8IJtKS7atr+QxpXvu4Xr5PhGDBDUMKwHn6hbaNqu6W6gmtlh8Ye5z2Y0gVJALiw3SVLoBfqvlpEIcxquB2y+bAEsau2fVeumt2N7mv0vbGjZTtvBpbwoA54AWvkkcaJgjg6KDRGT6D57XQSmdwvra7cvQ==;5:/5E5cu3Sgqpyn0xBYKex/1q4M7iEcf7NnxzdD7h3WJHJ1m0dM6MAmXPyzndLLU9ETz6VeusxBuPPJAXjIdEK52rTxfBlfV0pDbq3GmUGZqiNc8Zp/W7j4X56owQZJ/GkyDErkutP9QNeiaNzps2hjMvRWN2gmGgsJRbHEgQiqvnrxxi4uLS7waXdwmAuhbMfdn0rxxwBsuKKKQlofR88EQ==;7:wqE/lgEm0eaw8TqALHgZNHKaS8+LQOMgJJv6B9Rr1TPIYHMavgBcHyP3wcD+Ui/RVnh9kn/IdCXMsUy4pSaZOmPeRariwuxK2R8Q6hOxiF6SVYe5AXFN1Vh+6064jiqpXXk5cLQ+BfhjNxa7rYIv9w==
x-ms-office365-filtering-correlation-id: 4f271410-df67-4df6-2eba-08d686c4cff3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1796;
x-ms-traffictypediagnostic: BN6PR11MB1796:
x-microsoft-antispam-prvs: <BN6PR11MB179685005355E2A93CFD0944F0900@BN6PR11MB1796.namprd11.prod.outlook.com>
x-forefront-prvs: 0933E9FD8D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(366004)(346002)(136003)(396003)(199004)(189003)(386003)(316002)(81156014)(2501003)(72206003)(81166006)(4744005)(486006)(14454004)(476003)(110136005)(1076003)(8936002)(6116002)(4326008)(11346002)(50226002)(52116002)(6506007)(2616005)(36756003)(3846002)(68736007)(6486002)(6436002)(53936002)(8676002)(54906003)(66066001)(6512007)(478600001)(99286004)(186003)(71200400001)(97736004)(86362001)(2906002)(256004)(71190400001)(305945005)(446003)(6636002)(102836004)(105586002)(25786009)(7736002)(26005)(106356001)(107886003)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1796;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Ln0zl3WikV1+6MVqHwT/u3dbmUmG6Asyaa7KkNYoVZqiqcYeOcko4RSXAoVWn7q8lFMBotCSQSwDICAQT4K/LqDj479stxiEpN8en1grRBVsed7bd+2tjq7vpaleyu3lv6obrlyLk4pAtP+xSINrTT5AeBFAXAw0WhFYGIX5Bk7E9m5M3kOmIGR+lJuACFrhlqInNF8sm1Y5hQtq/1G9KdWCAWow5i9ip72zEKjBdBiwyr6g3WjX3NtHF6ogbDTQaSNZrypJnYm6Ol6nQChigLWULUjZO5GoqaVsL6MDG1paOn1mwaJkU5vSBctA9DL1pbLTdUFOjryqyl1/0Oe9hAv5IMll2qog4z70zjW9fgXHsaFjTWU6HT67lDrctgSxpx3rqVn25wUXoESp7yosYARmJw38q7vors1tVkq6lyE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f271410-df67-4df6-2eba-08d686c4cff3
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2019 15:08:36.2222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1796
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Return -ENOTSUPP when atmel_qspi_find_mode() fails. Propagate
the error in atmel_qspi_exec_op().

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/spi/atmel-quadspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 3643f0c851b0..e6de6e3d1345 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -208,7 +208,7 @@ static int atmel_qspi_find_mode(const struct spi_mem_op=
 *op)
 		if (atmel_qspi_is_compatible(op, &sama5d2_qspi_modes[i]))
 			return i;
=20
-	return -1;
+	return -ENOTSUPP;
 }
=20
 static bool atmel_qspi_supports_op(struct spi_mem *mem,
@@ -239,7 +239,7 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, cons=
t struct spi_mem_op *op)
=20
 	mode =3D atmel_qspi_find_mode(op);
 	if (mode < 0)
-		return -ENOTSUPP;
+		return mode;
=20
 	ifr |=3D sama5d2_qspi_modes[mode].config;
=20
--=20
2.9.5

