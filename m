Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE50C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 03:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7F1E20880
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 03:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="c52uY8zp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7F1E20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbeLMDlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 22:41:40 -0500
Received: from mail-eopbgr1410138.outbound.protection.outlook.com ([40.107.141.138]:29660
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726630AbeLMDli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 22:41:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N+ri0UZGRHcd47RPhrtnkcNdwV38h2oItHNfChjKox0=;
 b=c52uY8zpVXugsDdvdRoNcRnE+OEklv+MscI+Tse2r6drr8+w0mcXRBcZQvNKeyBqzGoSbL5JeVd60dtPSl3vbR+ej6pAGvDMMY12dxw3eVHcDQkHRbeKymkNFOCgFmLrvCXe/mW0EK3dUYUU4uuNiitZDNXqPU/Ww5UkrlKDMfA=
Received: from OSAPR01MB2290.jpnprd01.prod.outlook.com (52.134.238.13) by
 OSAPR01MB1746.jpnprd01.prod.outlook.com (52.134.232.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Thu, 13 Dec 2018 03:41:35 +0000
Received: from OSAPR01MB2290.jpnprd01.prod.outlook.com
 ([fe80::a8ae:bee4:d7e7:e5b7]) by OSAPR01MB2290.jpnprd01.prod.outlook.com
 ([fe80::a8ae:bee4:d7e7:e5b7%2]) with mapi id 15.20.1425.016; Thu, 13 Dec 2018
 03:41:35 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     YueHaibing <yuehaibing@huawei.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "fengguang.wu@intel.com" <fengguang.wu@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: RE: [PATCH -next] usb: renesas_usbhs: Fix unused function warning
 when CONFIG_PM not set
Thread-Topic: [PATCH -next] usb: renesas_usbhs: Fix unused function warning
 when CONFIG_PM not set
Thread-Index: AQHUkpK+6yEVcLy11kCcGUYFJhrwx6V8BfFQ
Date:   Thu, 13 Dec 2018 03:41:35 +0000
Message-ID: <OSAPR01MB2290C7C3221C7BE4594DB31CD8A00@OSAPR01MB2290.jpnprd01.prod.outlook.com>
References: <20181213031924.12216-1-yuehaibing@huawei.com>
In-Reply-To: <20181213031924.12216-1-yuehaibing@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [211.11.155.140]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;OSAPR01MB1746;20:6jIeJHNx+buKsnZ5cBqGI/5A/0xCVNukXNNhx56KEUBcSiae1o/g04RCOr9KDPjgbCgm05tV8tfTLFeCd9QOvdkPmVFbLoJJUd9SO9DPuVmX7P5SA342RsqFvCZ1RU01lcPQPlQhc32P7GgDs5icUUob1/UGVu0247aq6Tjqsws=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: c0249dbb-d48b-4c7b-6841-08d660ace197
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:OSAPR01MB1746;
x-ms-traffictypediagnostic: OSAPR01MB1746:
x-microsoft-antispam-prvs: <OSAPR01MB17468161BF1ADE93A4822278D8A00@OSAPR01MB1746.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231475)(944501520)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:OSAPR01MB1746;BCL:0;PCL:0;RULEID:;SRVR:OSAPR01MB1746;
x-forefront-prvs: 088552DE73
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(376002)(396003)(346002)(136003)(189003)(199004)(4326008)(7736002)(6506007)(33656002)(6116002)(486006)(186003)(3846002)(106356001)(229853002)(446003)(11346002)(105586002)(305945005)(26005)(5660300001)(76176011)(2906002)(102836004)(74316002)(99286004)(7696005)(110136005)(71190400001)(71200400001)(6246003)(476003)(316002)(2501003)(6436002)(54906003)(68736007)(25786009)(345774005)(478600001)(81156014)(8676002)(81166006)(97736004)(8936002)(14444005)(9686003)(575784001)(2201001)(53936002)(86362001)(55016002)(66066001)(256004)(6306002)(966005)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:OSAPR01MB1746;H:OSAPR01MB2290.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: VCMFJD8rscN7l42xahFBy7Kr3M/Wc1S6r2sad6Fbi9vQADlc2Xy4Axb0cALyr1HwwKOlrDvzfach+sFJItaiGfADkg7Rv+b/+sQ7c0EqBYqK2Szza8WhiuvT8vrAeEcmvV4Sn7YDq7QNwfv3sMz58rsL2d94lzzLODnuli4UAEYbF1TTgSv1YhoB7LuLfFavieT2NqI8Puf4GAhwLWsLCPF0Fe4W2RIHhmrgmgm2BqmtmJAGGuYIupI8M6+wiuRWQA8KehuIs65nBVfwHvQbVTSOzeyiymcBcBCG+wTMRtTevyO37wEGG5v+A+GRShna
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0249dbb-d48b-4c7b-6841-08d660ace197
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2018 03:41:35.2960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB1746
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> From: YueHaibing, Sent: Thursday, December 13, 2018 12:19 PM
>=20
> with CONFIG_PM not set, gcc warning this:
> drivers/usb/renesas_usbhs/common.c:844:12:
>  warning: 'usbhsc_suspend' defined but not used [-Wunused-function]
> drivers/usb/renesas_usbhs/common.c:860:12:
>  warning: 'usbhsc_resume' defined but not used [-Wunused-function]
>=20
> fix this by adding #ifdef around it.
>=20
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Thank you for the patch.
However, this issue is already fixed on the Greg's usb.git / usb-next branc=
h:
https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git/commit/?h=3D=
usb-next&id=3Deaf3074e0a8c2a39c4c14aa8ef1c2ec09ace9c79

Best regards,
Yoshihiro Shimoda

