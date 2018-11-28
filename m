Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 702DBC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 19:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2728620864
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 19:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="yR1baQyc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2728620864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbeK2GYn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 01:24:43 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:46037 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbeK2GYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 01:24:42 -0500
X-IronPort-AV: E=Sophos;i="5.56,291,1539673200"; 
   d="scan'208";a="21640418"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 28 Nov 2018 12:21:59 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 28 Nov 2018 12:21:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AaanZFVwIgHlU1UXWX4xJRtu80koCtwtFfpUuWdyjJc=;
 b=yR1baQyc/5Hqrk5ITD2dDFZp89pMAlqdxKNdsSt7HDT9Cb1LbPa3t9B3ZnjwYBX6ffsFCjWrlZgX0gd+0DKJtEGYmnFKdm10s4rsqGK/39hIokoMdYhUh13dHRO8MqAwNbWpQtGGwQbTMlFzkm21WaTPWo0PWx7a2o3LNrjauIA=
Received: from BYAPR11MB3447.namprd11.prod.outlook.com (20.177.186.216) by
 BYAPR11MB3077.namprd11.prod.outlook.com (20.177.226.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Wed, 28 Nov 2018 19:21:56 +0000
Received: from BYAPR11MB3447.namprd11.prod.outlook.com
 ([fe80::cdfc:b9aa:9d19:5d09]) by BYAPR11MB3447.namprd11.prod.outlook.com
 ([fe80::cdfc:b9aa:9d19:5d09%3]) with mapi id 15.20.1361.019; Wed, 28 Nov 2018
 19:21:56 +0000
From:   <Dave.Carroll@microchip.com>
To:     <gustavo@embeddedor.com>, <aacraid@microsemi.com>
CC:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 03/41] scsi: aacraid: aachba: Mark expected switch
 fall-throughs
Thread-Topic: [PATCH 03/41] scsi: aacraid: aachba: Mark expected switch
 fall-throughs
Thread-Index: AQHUhtJxVONJUqdCt0WHjYQfGhqPAaVlkS6A
Date:   Wed, 28 Nov 2018 19:21:56 +0000
Message-ID: <BYAPR11MB3447D45FA7EF566F4C80DDFD88D10@BYAPR11MB3447.namprd11.prod.outlook.com>
References: <cover.1543374820.git.gustavo@embeddedor.com>
 <fba277107d0b94bdd6e7cabf1d17e0fb0b6e13d8.1543374820.git.gustavo@embeddedor.com>
In-Reply-To: <fba277107d0b94bdd6e7cabf1d17e0fb0b6e13d8.1543374820.git.gustavo@embeddedor.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Dave.Carroll@microchip.com; 
x-originating-ip: [207.109.165.140]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR11MB3077;6:gM4Q7F9oiqWewg3+YNana27bNAbYiBd4h1RmuGbG07k6ynOF9MD7NOiyWZxkAlYn3U+JeVt/NL8fviYdwQu0K001PIEdRkHqm/3sq33DdGR3YB+VYn9nzNPw7UUiyEmHRZ8HilgzXqDjKjWd0bKoA+uiSgVXJMmRk6BWQyea+vzoxodimLM2JsFjwAdJN9Mj9rFmtqh9aBgPFTdemTPC7W28TAscQ+Br1gb4CYpkAJ2djsT6lk5juzQ/1msPeGNWtQCV1rPqxO1/9y9rudYl25fE3KMCriPlBbxbEL+guGIJatooc7gL1S929ywHuUv+8/iYtgcboK/fOw2Pde4OK1HFrFlTshuRxeniWk0MO3sbAqlojtTpvWRDZVD6MMRoLmfY0cDwcn1U9m48LnHohsBXuhwx6AJFhMgAv1rhA95OimnVrPnNk7olXlZ6ubw4Ih2rTk687QiO7Jv4xndgMg==;5:zQZ/d0g9DTnD5ZlvddDphCBVDacACSQsP0OU728b2lt4jdajZiTRw8X8RbwZcJ58ZK7UKh+Gd1+GDhAfTolOr41SKP/Y9vr3E+huqCyZJe/Dcy5JpP5qXKmSMOFgsZ3D8x5eMPgJRAj98MwVkjoLblR3vkfh7DQyc2CvQiisqLo=;7:iOI6ydJxolnONZwR5WTKGfjiPZp1sKiQCaJHCrlxPrUJ/Rzz9FOO8D6u+ZeyK0VcAQK5t4lL9130ci5dvkwTcI80BE302qhHDUTOykrJvGnK1oE6IcTa5YnkHgtDDlsZDuLLODdSgyn+AafOaMgT8w==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 72dd25fb-9238-4fd6-300f-08d65566c312
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR11MB3077;
x-ms-traffictypediagnostic: BYAPR11MB3077:
x-microsoft-antispam-prvs: <BYAPR11MB3077937494612DB16FFE43C788D10@BYAPR11MB3077.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231443)(999002)(944501410)(52105112)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BYAPR11MB3077;BCL:0;PCL:0;RULEID:;SRVR:BYAPR11MB3077;
x-forefront-prvs: 0870212862
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(366004)(39860400002)(136003)(189003)(199004)(13464003)(25786009)(33656002)(86362001)(68736007)(81156014)(81166006)(8936002)(229853002)(11346002)(71190400001)(486006)(256004)(72206003)(476003)(14454004)(71200400001)(478600001)(97736004)(55016002)(6246003)(5660300001)(54906003)(53936002)(4326008)(9686003)(446003)(8676002)(66066001)(7696005)(76176011)(53546011)(99286004)(6506007)(106356001)(6436002)(102836004)(7736002)(110136005)(6116002)(3846002)(316002)(74316002)(26005)(186003)(2906002)(105586002)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR11MB3077;H:BYAPR11MB3447.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: i/PFNfPtyprj4MpLhIaeskHNjPPZ7XPpxffloWMaMSOPs6CpRv4x99vbuy1+h3N5hxFYcTygqeg8yzjHmS6ZjUZvrqb9FLaAPpffmyiq3y1oFLEDyZKUE0Z/xtFl+hgUpcUfrCBzbbhT8ecjxikS787kuCfLk0Z2fSN3c7HMs12TWqXJsuraDQm8EhveAsMBOdoS+aZD1xXtfiHwvxBjoo+nQeNynDxNat+AlfnPmMrDfs3kDGpuGGNjuW/HxO1oQAcrjNK37ENNTXxUd3jHfk0Vi9mTnhNJii25xaIhUGxZKC6LLwUbZCO0aGjyv9UYf8TLvWsEMrsxmaEYp8a5v0raG7mjtRtdB+IsNG2uiQg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 72dd25fb-9238-4fd6-300f-08d65566c312
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2018 19:21:56.6184
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3077
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
> Subject: [PATCH 03/41] scsi: aacraid: aachba: Mark expected switch fall-
> throughs
>=20
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases wher=
e
> we are expecting to fall through.
>=20
> Also, a break statement is properly aligned.
>=20
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
Reviewed-by: Dave Carroll <david.carroll@microsemi.com>
