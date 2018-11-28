Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E28C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 19:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A63020864
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 19:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="pW6NhdEf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A63020864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729178AbeK2G0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 01:26:48 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:55930 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbeK2G0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 01:26:48 -0500
X-IronPort-AV: E=Sophos;i="5.56,291,1539673200"; 
   d="scan'208";a="24624068"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 28 Nov 2018 12:24:06 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 28 Nov 2018 12:24:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pfTQTUGYkQuw4yQxUlldtrKdMOghv3aTXBD/+ppVAv4=;
 b=pW6NhdEfXeNx7rnStEnH/RdZbkhncnmwXPm+rVS2MBT9jNhBWZtvIHNKe4jZsq/F1p1FH9hLy5nujX/dufSALhDDlaRHiSMLllLgq/oH2hUO5zWB805IkPCEKkisBPwaGfnwAJZJvpccCT+xR2H8FZPEK1uxPcOF3kC9Zc0BWko=
Received: from BYAPR11MB3447.namprd11.prod.outlook.com (20.177.186.216) by
 BYAPR11MB3287.namprd11.prod.outlook.com (20.177.185.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Wed, 28 Nov 2018 19:24:03 +0000
Received: from BYAPR11MB3447.namprd11.prod.outlook.com
 ([fe80::cdfc:b9aa:9d19:5d09]) by BYAPR11MB3447.namprd11.prod.outlook.com
 ([fe80::cdfc:b9aa:9d19:5d09%3]) with mapi id 15.20.1361.019; Wed, 28 Nov 2018
 19:24:03 +0000
From:   <Dave.Carroll@microchip.com>
To:     <gustavo@embeddedor.com>, <aacraid@microsemi.com>
CC:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 04/41] scsi: aacraid: linit: Mark expected switch
 fall-through
Thread-Topic: [PATCH 04/41] scsi: aacraid: linit: Mark expected switch
 fall-through
Thread-Index: AQHUhtKqPXoLnIx5D0q6EV8imm/JnaVlka8A
Date:   Wed, 28 Nov 2018 19:24:03 +0000
Message-ID: <BYAPR11MB3447CB719791FC8249AF938B88D10@BYAPR11MB3447.namprd11.prod.outlook.com>
References: <cover.1543374820.git.gustavo@embeddedor.com>
 <d59c13880a70724c3645d96945bf8a128f835244.1543374820.git.gustavo@embeddedor.com>
In-Reply-To: <d59c13880a70724c3645d96945bf8a128f835244.1543374820.git.gustavo@embeddedor.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [207.109.165.140]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR11MB3287;6:UA8okKl0k5Qj3CZh9XNurQE8jFyKJgPwovFDyt8V9D0F4OOt/0KSHYg1MSE4wy6z7sF67FznEeooAu7ObGIZTzPuhbfXNagkYx8L2DmlQBVThxOylvjpJXV0b0ktKUI2mE8KSmsPPkfcvS6TsfZlpx1y6WmgkSklnbpN318UNDZO7t+sm+/KlcJ9oApBclym83SlY6LBrfKHB4RDwwfrFPUZ9slna4j8CbW54xq1u93BKQdeuMtFW7HyBJdJrI8uJB9+vmx8S3jUIHXcy3IxeRnlmzCHB02lRIfkSaSpQWwC8yRHe/74zRBya0OUZv14/Kcm/z7st/T+G4zylKMn7fvKcYHW0m0klp+YdBc5ItDIiP7L5bwS3YX//GhHZ0VbXdrQZfcR3odr/1+IeIQm/OHK3OQ+ouN2lPK3cfiLl6O1q6mfprAYQb7dq3eLw9L9tkF9nubVkVKJCAOWaYr0Eg==;5:rOsHt7fl/aNeLyoe/dFvkfFQrw2Un/BLpqI9puPwQ8xtlSQlwedZ8tThVh+fHXyT8Q3CDa4Bk05ORljgNN85usZi3cNHgEOHIIOVgzxthSdG6Qz50q2A5mKDg7oOC4fkLBhQZGZR3Bk3pG89oQhhuFyPQOhorsqNWESV5cZcSTk=;7:SeCuuT4X3SeZ80iDN/J5UqKzC1ZPR9106jinonsJMC4XY9hg6f/e0g+TgFGva3nG6Bd33CWEFU8VVwylF6lq3QGX3t8PTqOPq1Mxl+mUK5hN2/tbhbj1nknlc8awsjta8pexNFdLYmn1XfI/7v5dvw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 99e45b8f-914d-4493-8ed3-08d655670edc
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR11MB3287;
x-ms-traffictypediagnostic: BYAPR11MB3287:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Dave.Carroll@microchip.com; 
x-microsoft-antispam-prvs: <BYAPR11MB32879EAACE39EACE0932464C88D10@BYAPR11MB3287.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231443)(999002)(944501410)(52105112)(93006095)(93001095)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BYAPR11MB3287;BCL:0;PCL:0;RULEID:;SRVR:BYAPR11MB3287;
x-forefront-prvs: 0870212862
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(39860400002)(366004)(396003)(199004)(189003)(13464003)(55016002)(3846002)(86362001)(76176011)(71200400001)(71190400001)(66066001)(9686003)(6436002)(229853002)(106356001)(105586002)(26005)(53936002)(256004)(6506007)(68736007)(486006)(14454004)(11346002)(446003)(7696005)(476003)(99286004)(102836004)(6246003)(6116002)(186003)(53546011)(305945005)(74316002)(25786009)(2906002)(4326008)(8936002)(81156014)(8676002)(5660300001)(478600001)(72206003)(7736002)(33656002)(81166006)(316002)(97736004)(54906003)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR11MB3287;H:BYAPR11MB3447.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: wbIDHqjVWVwFfEu83MCGEGS3nuluH9s3MPTbAhKrsfqlcqK+UtZ1hPnILEfQWnuYDanje5km5qvJ2Dz5jmCRn3um8mFsOZtuF8LuSZcz0zYUgaPxGG++zaxr4GbH/VqRQruWW4U6sn3XTWyJGAckVWZkXReF3elLOLpeaj0zZjA77nndsg47MafW3r8PUdc3hZ/A5kCi6t4l0y4bph60y+Y4oAMseRgl2Yh3/SmJWMRbjckt7cCskEnGzpVbl/4FEtEnAbmBTzi/lAcLh4yEIHqF6Ue6LI/pPJvAM3lTEzJw6veIFSXB7TGv9Z/qlbOslmm3g7SIUQYxag3yWVACPGBlhOfZ74WseMyRMh62oXg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 99e45b8f-914d-4493-8ed3-08d655670edc
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2018 19:24:03.7738
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3287
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Gustavo A. R. Silva [mailto:gustavo@embeddedor.com]
> Sent: Tuesday, November 27, 2018 9:26 PM
> To: Adaptec OEM Raid Solutions <aacraid@microsemi.com>
> Cc: James E.J. Bottomley <jejb@linux.ibm.com>; Martin K. Petersen
> <martin.petersen@oracle.com>; linux-scsi@vger.kernel.org; linux-
> kernel@vger.kernel.org; Gustavo A. R. Silva <gustavo@embeddedor.com>
> Subject: [PATCH 04/41] scsi: aacraid: linit: Mark expected switch fall-th=
rough
>=20
>=20
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases wher=
e
> we are expecting to fall through.
>=20
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/scsi/aacraid/linit.c | 1 +

Reviewed-by: Dave Carroll <david.carroll@microsemi.com>
