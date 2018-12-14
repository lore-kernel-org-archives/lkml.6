Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D363C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 19:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B48272086D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 19:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="oEqzc5Ea"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730655AbeLNTi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 14:38:57 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:53488 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730548AbeLNTi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 14:38:56 -0500
X-IronPort-AV: E=Sophos;i="5.56,354,1539673200"; 
   d="scan'208";a="24229968"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 14 Dec 2018 12:38:55 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Fri, 14 Dec 2018 12:38:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cyqT2vd0weG9Ehjt3+k83zl0bb+xa6Qb9AjCQY3sCjI=;
 b=oEqzc5EanOEyzzOk0Q6EU3r9c4bxJcaTkMjcDMxkRRXeCsIpg6hrEM/9m6s8SiX7Nbs3c8fmYzOGmedneFH1w6lFnGAR+okwjd01r3m7pN9MBdzTao3jCvf6TrQ7r4GaYnQJhIfwOyW77VjYxWRHk1nq1c9a3HBumQMTG9zBo1k=
Received: from BYAPR11MB2855.namprd11.prod.outlook.com (52.135.228.141) by
 BYAPR11MB3222.namprd11.prod.outlook.com (20.177.127.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.22; Fri, 14 Dec 2018 19:38:53 +0000
Received: from BYAPR11MB2855.namprd11.prod.outlook.com
 ([fe80::1137:d81d:de30:c394]) by BYAPR11MB2855.namprd11.prod.outlook.com
 ([fe80::1137:d81d:de30:c394%2]) with mapi id 15.20.1404.028; Fri, 14 Dec 2018
 19:38:53 +0000
From:   <Don.Brace@microchip.com>
To:     <mironov.ivan@gmail.com>, <linux-scsi@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <don.brace@microsemi.com>,
        <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>,
        <esc.storagedev@microsemi.com>
Subject: RE: [PATCH 0/6] Add support of the HBA mode on HP Smart Array P410i
 controllers
Thread-Topic: [PATCH 0/6] Add support of the HBA mode on HP Smart Array P410i
 controllers
Thread-Index: AQHUk7AP2GWqzt2GdE2cof/UTeWSraV+oF0g
Date:   Fri, 14 Dec 2018 19:38:52 +0000
Message-ID: <BYAPR11MB285586623125DD1C98EE87F1E1A10@BYAPR11MB2855.namprd11.prod.outlook.com>
References: <20181214132115.21440-1-mironov.ivan@gmail.com>
In-Reply-To: <20181214132115.21440-1-mironov.ivan@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Don.Brace@microchip.com; 
x-originating-ip: [216.54.225.58]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR11MB3222;6:T/Soia9UzaCI4NDVsZ8Ury9VPel+ldrqWROZ/HUGPm/Rd8iDKJ026mCliCXzHsV4Htyi1ka5mOUsb945Slz9NxNk5L7OQWaSqTOetLumBAsol+AivdumQww7Ai7DWfLOrE6saO1ac0nbT5PuugXJgVEPP4nXtcx0ZxPvUrx1SLlg94JXTciN0nCPCn9j0QvhK14H4+OcZfo6GJz3IjDn6h6ZxC4i/vupr9SgjLpCSaerBXzxmPWTxAi8hirHuBDi6J0WDJDflUBmghiSXHTngg0mGbJJfky8IE8WE/L+aQZaWHYi6s5ucYZX6eRbTqj2AVjhBu7jThwlbB+sBmaTpQCN9F1yHwT5V/LZNhU/dRzX2aRGgab/o1LBDHQ9/MlOu9Bib+QWg6GED/cXWZ2SiDshi74YMdlJIEwUzTjH5cbtkNHwlFvSiV4cjG0GmsFs0HU3lo7S10lp0jN3fP77dQ==;5:m7Cp/tml4yzrNZLq9iRq6/oE9L73MP3XpF+FCunMDvonNwYsOVf7V2MSdQvIvzil0HYVkGBaxG+K/4LUZOYwaDgom/RYAlSNYeNjMF6KUtrXGrsT3IopuTeVUI4m7hmRqhYEj19bo7XkIvD8KOmUEAyk4TTf98ZC0E9uWOeVnL8=;7:E6JuYMdZky+9GPucWU/SG0IQhTdGYbEO+hiURv/UMsm1w6mLpH5SNVKAWhQfHwpQmJ4lWuXwrcb+VkQ93nnPoKaUk8beS5gESW3cV48wHQQ9dp7szonDa1fCXKCqkPEJ/1+lKcV62np8EtxY5RvLug==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 374500bb-e22f-4d7f-d590-08d661fbc789
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR11MB3222;
x-ms-traffictypediagnostic: BYAPR11MB3222:
x-microsoft-antispam-prvs: <BYAPR11MB3222729D096E858CA2D965FBE1A10@BYAPR11MB3222.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231475)(944501520)(52105112)(10201501046)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BYAPR11MB3222;BCL:0;PCL:0;RULEID:;SRVR:BYAPR11MB3222;
x-forefront-prvs: 08864C38AC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(396003)(346002)(376002)(199004)(189003)(13464003)(2501003)(55016002)(305945005)(97736004)(316002)(6306002)(486006)(54906003)(25786009)(110136005)(81156014)(99286004)(74316002)(86362001)(5660300001)(9686003)(8676002)(71190400001)(71200400001)(476003)(6436002)(2906002)(229853002)(7736002)(68736007)(14444005)(256004)(446003)(6116002)(4326008)(7696005)(39060400002)(11346002)(81166006)(3846002)(6246003)(8936002)(66066001)(14454004)(76176011)(53936002)(33656002)(106356001)(53546011)(102836004)(72206003)(478600001)(26005)(105586002)(966005)(186003)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR11MB3222;H:BYAPR11MB2855.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 1zsy5Aqsd7zX4pUilfzWCeWr+LzXWODFgIhxnoaTllQzwnLiGrKNECEi0xWzOeMvCeCsMyYOIKs8PaJmjPeR3pmtV7X0Or42UL0EFX3sNasOvdkdWWZd3NzLDpS87tFfykVFvZwypoJGhoPGHRdgw8MEzAZiesEMwgyFNMzIrOmpF+BjsaENeL72TvZlcT0hBpiiHDbrd5YGgKdX70Ovn8VyFIDynvXPJ1NPGSrkNlz79zkir8yHWPOiCx1/30WQIdU1822m8euz1qu3VvK5mgYRTxyIqez9TFwLJJaUa7hn0HzWYPH2ocp2Xtix4BP8
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 374500bb-e22f-4d7f-d590-08d661fbc789
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2018 19:38:53.0638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3222
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----Original Message-----
From: linux-scsi-owner@vger.kernel.org [mailto:linux-scsi-owner@vger.kernel=
.org] On Behalf Of Ivan Mironov
Sent: Friday, December 14, 2018 7:21 AM
To: linux-scsi@vger.kernel.org; mironov.ivan@gmail.com
Cc: linux-kernel@vger.kernel.org; Don Brace <don.brace@microsemi.com>; Jame=
s E.J. Bottomley <jejb@linux.vnet.ibm.com>; Martin K. Petersen <martin.pete=
rsen@oracle.com>; esc.storagedev@microsemi.com
Subject: [PATCH 0/6] Add support of the HBA mode on HP Smart Array P410i co=
ntrollers

This series of patches adds support of the HBA mode on HP Smart Array P410i=
 RAID controllers.

This is not guaranteed to be correct as I do not have any access to documen=
tation on these controllers. However, this works fine for me on hardware th=
at I have. Also, these changes successfully passes blktests[1] and xfstests=
[2].

To make sure that this new functionality does not break anything, it is dis=
abled by default and may be enabled only manually using new module paramete=
r.

[1] https://github.com/osandov/blktests
[2] https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

Ivan Mironov (6):
  scsi: hpsa: Add function to check if device is a disk or a zoned
    device
  scsi: hpsa: Support HBA mode on HP Smart Array P410i controllers
  scsi: hpsa: Add/mask existing devices on rescan if visibility changes
  scsi: hpsa: Ignore HBA flag from NVRAM if logical devices exist
  scsi: hpsa: Name more fields in "struct bmic_identify_controller"
  scsi: hpsa: Do not use HBA flag from NVRAM if HBA is not supported

 drivers/scsi/hpsa.c     | 145 ++++++++++++++++++++++++++++++++++++----
 drivers/scsi/hpsa.h     |   3 +
 drivers/scsi/hpsa_cmd.h | 113 ++++++++++++++++++++++++++++++-
 3 files changed, 244 insertions(+), 17 deletions(-)

--
2.19.2

NAKing this series.
- The P410 controllers do not fully support HBA mode and we do not support =
adding it to the hpsa driver.

