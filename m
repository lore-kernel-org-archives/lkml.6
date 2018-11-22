Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69972C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 12:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E8E7204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 12:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="OfeiyhJ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E8E7204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=caviumnetworks.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395031AbeKVW4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 17:56:06 -0500
Received: from mail-eopbgr680059.outbound.protection.outlook.com ([40.107.68.59]:10584
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729105AbeKVW4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 17:56:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1IJJyz5jaay7XnksiddVojbTHJ+KUgawhUqoUtfz1I=;
 b=OfeiyhJ8Y1JY7FjPV+W4ya67Mw1Qu7MgPrud603FraDDZCo27HuFTA3ISMNuTli091krbodZav8PWQmR6XlO8SLmXEnYq53xkUGAUyGEafaAgPDNkWwp57x4iFmxQIbnUgnQJZGtu+bVA44m8hYpJl+CezU6qadSzSUiNuSx9+4=
Received: from BYAPR07MB4373.namprd07.prod.outlook.com (52.135.224.16) by
 BYAPR07MB5061.namprd07.prod.outlook.com (52.135.239.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.20; Thu, 22 Nov 2018 12:16:54 +0000
Received: from BYAPR07MB4373.namprd07.prod.outlook.com
 ([fe80::db8:4dba:8bb:3f5]) by BYAPR07MB4373.namprd07.prod.outlook.com
 ([fe80::db8:4dba:8bb:3f5%3]) with mapi id 15.20.1361.016; Thu, 22 Nov 2018
 12:16:54 +0000
From:   Yury Norov <ynorov@caviumnetworks.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Florian Weimer <fweimer@redhat.com>
CC:     "Norov, Yuri" <Yuri.Norov@cavium.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>
Subject: Re: [PATCH v2] UAPI: move RENAME_* definitions to separated file
Thread-Topic: [PATCH v2] UAPI: move RENAME_* definitions to separated file
Thread-Index: AQHUe+maZLYYsimik0+i7t/nnXCYJqVO3sCAgAzj4QA=
Date:   Thu, 22 Nov 2018 12:16:54 +0000
Message-ID: <20181122121642.GB17424@yury-thinkpad>
References: <20181114071346.31210-1-ynorov@caviumnetworks.com>
 <20181114072559.GA16695@yury-thinkpad>
In-Reply-To: <20181114072559.GA16695@yury-thinkpad>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR04CA0079.eurprd04.prod.outlook.com
 (2603:10a6:803:64::14) To BYAPR07MB4373.namprd07.prod.outlook.com
 (2603:10b6:a02:c0::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yuri.Norov@cavium.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [50.233.148.155]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR07MB5061;6:QL6SpPVdFsaucpxIefoFYlk3q4g89yZByJI97lPOOriS5h7hHw8hbDTx0Bsf+t7KmmByXEarpHMHIYXwlU+s9d7+sOLPH+6IX3u8nURGNgG5fEOxksdMiv7kZW4HP3/bcXRFCoHS3D+TkywfgPIc7bk5IlLDHneGHLNarI52BncLEbdbq7nyVwx9SUwF+03pnTcUtE1YHiBSfAhjAO9OFpGsF9idWsnv43zKiBoO0vTJ76boE9uN7KGkSqSCUPR/f/LIBo9NCUVlGEfYYMeLf1AyRF/WBxoWxn+OoUSkUPYrTh9f3TBFsYsAXEfo0cqHdKeQIzQsDb15hJSBiDPgAMXSasmCk5EW4yhrZmQWSuCankVgYXTePmTK+RNFeZ4yOHcXtq3ptuVfWv4boNlhnLWVLVz6Ek4r4z52vWgUiVyQnqjN0Qtdpd+nLK0/8h3iuX4EdXFCOCb9XC3JQDCSjw==;5:46tR/7dhial1+FZWmBNk4o3jC0NgDmAgaVtgzhANNtkl705qfE5HIx9569LXsgB32hjFaEf1uOjTrM1f1DERq4PH80wItkf8jxEuvW6V7lt0c3DFW70+a1StfZM4IUAHLFVvspllLuq+wp0Ifw6A8XtYHl5fpzoIUDiZLifs+6k=;7:nVnZ8FnLCE9kN0tHdHK4vRS4XVcCA15ntuVvkvcSe180fzsqRvmDYxxpDkdeE2OtCFs6OsORRyk3xPcdoMstJXVf+hzfLdOpKW7en9qZFIvhSrYAaSdDhb2MOnWsZRYgnAO0/KcgP0I4qdOYRvYrKg==
x-ms-office365-filtering-correlation-id: 5197e83f-5984-4b55-1b48-08d6507463cc
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB5061;
x-ms-traffictypediagnostic: BYAPR07MB5061:
x-microsoft-antispam-prvs: <BYAPR07MB50617B98315D941D50D6B0FAE3DB0@BYAPR07MB5061.namprd07.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(3231442)(944501410)(52105112)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BYAPR07MB5061;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB5061;
x-forefront-prvs: 0864A36BBF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(136003)(346002)(376002)(39860400002)(366004)(396003)(189003)(199004)(53754006)(42882007)(66066001)(11346002)(486006)(446003)(305945005)(7736002)(4326008)(478600001)(476003)(72206003)(966005)(6306002)(6246003)(6512007)(71200400001)(71190400001)(97736004)(14454004)(33896004)(25786009)(53936002)(26005)(106356001)(76176011)(8936002)(186003)(2900100001)(6436002)(1076002)(81166006)(33656002)(6486002)(81156014)(105586002)(102836004)(8676002)(229853002)(99286004)(3846002)(9686003)(6506007)(6116002)(386003)(5660300001)(316002)(33716001)(53546011)(110136005)(52116002)(54906003)(2906002)(256004)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5061;H:BYAPR07MB4373.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: rEHwFgY9/edbJVqh06WKBILwvE2TZZwHMFcBdjQlH3pbk7gBrs8Uc9OsunYm9jSUYyq5F1//pGnXqxyT900iFTh94urIsdzz9cnTLimk0XfzVVpzIgTPoOQSbP7RVs/iAE0STs8eYqlYTQDDRXn1yOSZwWkbGVYmZJqqLWks6Rf6moOTGPQZZzzTViywMrgI3cocvh0cNAyov28dTSC5lfERRWPbawVBvaXz2h+w4KQ+X3oBFKJo9AQ3LqABktG9pme4224OYx4mPaw0s6WE/mK4RLsHWQSW3sCll0F1AEIggd/IG2byuB4xTSG1ml0qcFyD6A00C3My57EITF0hXh2XiaNZU3j0BtQYVk9RKlU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3FF69DDBBFCB0F47AD9E8CDD916C5696@namprd07.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5197e83f-5984-4b55-1b48-08d6507463cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2018 12:16:54.3065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5061
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping?

On Wed, Nov 14, 2018 at 07:26:07AM +0000, Yury Norov wrote:
> Hi all,=20
>=20
> It seems that I forgot to rename guards in v2. This is the correct
> version. My apologize for noise.
>=20
> Yury
>=20
> >From 61215b1cb559e69fb57f2a82864e72e3a1ef4b12 Mon Sep 17 00:00:00 2001
> From: Yury Norov <ynorov@caviumnetworks.com>
> Date: Wed, 14 Nov 2018 09:51:49 +0300
> To: Andrew Morton <akpm@linux-foundation.org>,
> 	Alexander Viro <viro@zeniv.linux.org.uk>,
> 	Florian Weimer <fweimer@redhat.com>
> CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
> 	linux-api@vger.kernel.org, libc-alpha@sourceware.org
> Subject: [PATCH v2] UAPI: move RENAME_* definitions to separated file
>=20
> Discussion:
> https://lore.kernel.org/lkml/20180702084622.GA15274@yury-thinkpad/
>=20
> Although RENAME_* macros are exposed in kernel headers, they are not
> used by glibc. That's because linux/fs.h which hosts RENAME_* is
> considered unsuitable by glibc developers:
>=20
> As Florian Weimer wrote:
>=20
> > <linux/fs.h> undefines and defines macros not mentioned in the standard=
s
> > (and it even contains a few unrelated structs), so we cannot include it
> > without _GNU_SOURCE.
> >
> > It might be possible to include it only for _GNU_SOURCE, but there are =
a
> > lot of things in <linux/fs.h>, so that does not seem to be particularly
> > advisable.
>=20
> In this patch RENAME_* is removed to a separated header file that
> conforms the standards and therefore is suitable for inclusion by glibc.
>=20
> v2:
>  - rename dedicated file to 'rename-flags.h', as requested by Florian.
>=20
> Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
> ---
>  include/uapi/linux/fs.h           |  4 +---
>  include/uapi/linux/rename-flags.h | 12 ++++++++++++
>  2 files changed, 13 insertions(+), 3 deletions(-)
>  create mode 100644 include/uapi/linux/rename-flags.h
>=20
> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index 73e01918f996..34c308203746 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -39,9 +39,7 @@
>  #define SEEK_HOLE	4	/* seek to the next hole */
>  #define SEEK_MAX	SEEK_HOLE
> =20
> -#define RENAME_NOREPLACE	(1 << 0)	/* Don't overwrite target */
> -#define RENAME_EXCHANGE		(1 << 1)	/* Exchange source and dest */
> -#define RENAME_WHITEOUT		(1 << 2)	/* Whiteout source */
> +#include <linux/rename-flags.h>
> =20
>  struct file_clone_range {
>  	__s64 src_fd;
> diff --git a/include/uapi/linux/rename-flags.h b/include/uapi/linux/renam=
e-flags.h
> new file mode 100644
> index 000000000000..7178f0565657
> --- /dev/null
> +++ b/include/uapi/linux/rename-flags.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +#ifndef _UAPI_LINUX_RENAME_FLAGS_H
> +#define _UAPI_LINUX_RENAME_FLAGS_H
> +
> +/*
> + * Definitions for rename syscall family.
> + */
> +#define RENAME_NOREPLACE	(1 << 0)	/* Don't overwrite target */
> +#define RENAME_EXCHANGE		(1 << 1)	/* Exchange source and dest */
> +#define RENAME_WHITEOUT		(1 << 2)	/* Whiteout source */
> +
> +#endif /* _UAPI_LINUX_RENAME_FLAGS_H */
> --=20
> 2.17.1
