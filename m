Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C4BC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57763245A8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="P7P5qVpN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57763245A8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932458AbeGCOHD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 10:07:03 -0400
Received: from mail-eopbgr730066.outbound.protection.outlook.com ([40.107.73.66]:36032
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932312AbeGCOHB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 10:07:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Phb2xf1lYk5rjXpnk6EpGbT2N3OMiPmt51O90A4njuM=;
 b=P7P5qVpNv0CjEQ+NQZASFlSEmI/JrA+uLTapzGNmOzHM7kL+wKYbpF/niIYiUp4qdriQt8g1JZqfmj8R/gw9tbXDlw5xWIq6cRYueQIsxZXFPMqvOt70O23XV1ncD5ogOjfGougE71vUDwRj0rxDBeO+lkoCsRXfy61o3l3rW3Q=
Received: from CO2PR07MB2551.namprd07.prod.outlook.com (10.166.201.14) by
 CO2PR07MB2662.namprd07.prod.outlook.com (10.166.213.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.19; Tue, 3 Jul 2018 14:06:57 +0000
Received: from CO2PR07MB2551.namprd07.prod.outlook.com
 ([fe80::b93d:f960:800b:e811]) by CO2PR07MB2551.namprd07.prod.outlook.com
 ([fe80::b93d:f960:800b:e811%7]) with mapi id 15.20.0930.016; Tue, 3 Jul 2018
 14:06:56 +0000
From:   Damian Kos <dkos@cadence.com>
To:     =?iso-8859-1?Q?Heiko_St=FCbner?= <heiko@sntech.de>
CC:     David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Sandy Huang <hjc@rock-chips.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        Lukasz Tyrala <ltyrala@cadence.com>,
        Przemyslaw Gaj <pgaj@cadence.com>,
        Scott Telford <stelford@cadence.com>,
        Quentin Schulz <quentin.schulz@bootlin.com>
Subject: RE: [PATCH 12/12] drm/rockchip: add support for CDNS MHDP IP
 controller.
Thread-Topic: [PATCH 12/12] drm/rockchip: add support for CDNS MHDP IP
 controller.
Thread-Index: AQHUErVCyoHlZCgVm0Kke5YBfxY/h6R9VXKAgAAyMdA=
Date:   Tue, 3 Jul 2018 14:06:56 +0000
Message-ID: <CO2PR07MB25512372C4FEAF1990305433CD420@CO2PR07MB2551.namprd07.prod.outlook.com>
References: <1530612152-27555-1-git-send-email-dkos@cadence.com>
 <1530612152-27555-13-git-send-email-dkos@cadence.com>
 <2647490.Uuqs1CuF1U@diego>
In-Reply-To: <2647490.Uuqs1CuF1U@diego>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZGtvc1xhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJhMjllMzViXG1zZ3NcbXNnLTVmZjg5OTRkLTdlY2EtMTFlOC04NzEyLWNjMmY3MTZkYzIzZFxhbWUtdGVzdFw1ZmY4OTk0Zi03ZWNhLTExZTgtODcxMi1jYzJmNzE2ZGMyM2Rib2R5LnR4dCIgc3o9IjM5NzUiIHQ9IjEzMTc1MTAwNDMwMzYyMjA0MSIgaD0iVkIrbFBFM0oxK1hzNFk0a2NReXRnNEFOcGcwPSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR07MB2662;7:v2SctXU76sbzmL9WSxnbrWZc9yFj85FYrU/8dvbJxZv23+s+bgpTJujhJ1E0QT6jYqSa9WlsLLrj9ni19iHN9bCbbEXIwjkawjtyJ0zvnV4jmqWW949eSxV6IZ4V4q5TwF4OFsfnS47YsnPFfyGDp+mZuGIJANi4VC1e4UC1OR9GDOHeiHrwPlZPzCg2RzgrykcTJDs3SYDsQZQYCSPW5/Re1jFTa76DX1LYJA2ENM9jqRgnP3F4OZ87/4pHqgZM;20:wvS9izyvvu+DtxNlwC3dt2JE7mpNK7whNCYP+LaKUGqLZgQ7L6deFq7wQCY32rDr3o96udKNM+qVlj2TmeydUpXYt8vty7HqZLSOjc9QBfBtGIlIeIEMGp1PlZY7iZ/ai5U6U0S+Dhm7z+nE2+a43UIo5QEg+K+AI4SbotEKR4/RoujW6TPZ1V+/YzUOKnZuqaGfdh9yWZgyUkA4+O56Nnxo1EtjpyMhVG4Bla/rsBZcOHO5gjdIrfzl7UL42Eap
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(136003)(396003)(376002)(366004)(13464003)(36092001)(189003)(199004)(3846002)(6116002)(6916009)(478600001)(66066001)(6246003)(53936002)(9686003)(97736004)(55016002)(25786009)(5660300001)(2900100001)(486006)(14444005)(256004)(446003)(7416002)(11346002)(4326008)(68736007)(476003)(105586002)(8676002)(74316002)(345774005)(305945005)(7736002)(14454004)(6506007)(26005)(86362001)(33656002)(102836004)(106356001)(186003)(53546011)(2906002)(7696005)(6436002)(76176011)(316002)(99286004)(229853002)(81166006)(81156014)(8936002)(5250100002)(54906003)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR07MB2662;H:CO2PR07MB2551.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: d1ee48bc-e96d-46de-b0e3-08d5e0ee3c59
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:CO2PR07MB2662;
x-ms-traffictypediagnostic: CO2PR07MB2662:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dkos@cadence.com; 
x-microsoft-antispam-prvs: <CO2PR07MB2662724F0FBF565E53B1050FCD420@CO2PR07MB2662.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(258649278758335)(217544274631240)(72806322054110)(228905959029699)(231250463719595);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231280)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:CO2PR07MB2662;BCL:0;PCL:0;RULEID:;SRVR:CO2PR07MB2662;
x-forefront-prvs: 0722981D2A
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: O63aTQxBLy4Zrp6e3xNxkNvrW7DA2Mb2GC630n09TnkqxNpGWT6aEhUhfaSnRsR2f90Pybo4sg4gpfZb7/QWPA7cfGENXkq9jCy4bfdlhs8djU/kPJNMOacyJdZtsIdwa0avwmXrDnWyuvhFHLanvoKSWOJ0ZTX9DBlNqI3W9+vrloGSRZdb3CJSOjB0AwlQhJX0s4S70C2YSVAwo/OAklo9degjCu/huoIchbX5sOeKy3K2vkYtdTwa0p0ysDy9L+sVl9nuOEqCfYYI+ClHbzM4Pt0HC1OCBp9KMVHQneh2BYzH19yeSW41G+gEi+do93c0O4J8QA82JPNutHrr9yEb/t80ULbJh37n0HCQYMw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1ee48bc-e96d-46de-b0e3-08d5e0ee3c59
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2018 14:06:56.1171
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR07MB2662
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

Thank you for your feedback! Initially, MHDP driver was developed as a DRM =
bridge driver and was planned to be placed in drivers/gpu/drm/bridge/cadenc=
e/mhdp.c.  However, there was already a driver for Cadence's DP controller =
developed by RockChip, but that driver uses different DRM framework. Both c=
ontrollers (including firmware) are quite different internally (MST/FEC/DSC=
 support, link training done by driver, additional commands, etc.) but they=
 have very similar register map, except for Framer/Streamer, so they appear=
 similar.

We would be more than happy to provide fully separate driver (that was basi=
cally pasted in RockChip's driver) for DP DRM bridge. Some parts can defini=
tely shared between these two drivers like code for mailbox and commands se=
nt/received by it, audio init.

Moving cdn-dp-* to drivers/gpu/drm/bridge/ was also a plan, but it seems th=
at cdn-dp-core.c use some stuff from drivers/gpu/drm/rockchip/*. cdn-dp-cor=
e driver in this case seems like a part of a bigger picture while the drive=
r that we want to upstream is standalone.

We'll move/add everything that can be shared by both drivers to drivers/gpu=
/drm/ and add new DPI/DP bridge driver as you advised and provide a new pat=
ch.

PS. Should we post patches 01-08 done in DRM helper by Quentin as a separat=
e patch, so that reviewers will not have to go through them every time when=
 we send updated version?

Regards,
Damian

-----Original Message-----
From: Heiko St=FCbner <heiko@sntech.de>=20
Sent: Tuesday, July 3, 2018 13:03
To: Damian Kos <dkos@cadence.com>
Cc: David Airlie <airlied@linux.ie>; Rob Herring <robh+dt@kernel.org>; Mark=
 Rutland <mark.rutland@arm.com>; Gustavo Padovan <gustavo@padovan.org>; Maa=
rten Lankhorst <maarten.lankhorst@linux.intel.com>; Sean Paul <seanpaul@chr=
omium.org>; Sandy Huang <hjc@rock-chips.com>; dri-devel@lists.freedesktop.o=
rg; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-ker=
nel@lists.infradead.org; linux-rockchip@lists.infradead.org; Lukasz Tyrala =
<ltyrala@cadence.com>; Przemyslaw Gaj <pgaj@cadence.com>; Scott Telford <st=
elford@cadence.com>
Subject: Re: [PATCH 12/12] drm/rockchip: add support for CDNS MHDP IP contr=
oller.

EXTERNAL MAIL


Hi Damien,

it's very cool to see collaboration from vendors on this.


Am Dienstag, 3. Juli 2018, 12:02:23 CEST schrieb Damian Kos:
>

It would be really nice to explain a bit about the added controller support=
 in the commit message, so that people reviewing the patch can get a feelin=
g for it.

> Signed-off-by: Damian Kos <dkos@cadence.com>
> ---
>  drivers/gpu/drm/rockchip/cdn-dp-core.c |  953
> +++++++++++++++++++++++++++++++-=20
> +++++++++++++++++++++++++++++++drivers/gpu/drm/rockchip/cdn-dp-core.h=20
> +++++++++++++++++++++++++++++++|
> 25 +
>  drivers/gpu/drm/rockchip/cdn-dp-reg.c  |    2 +-
>  drivers/gpu/drm/rockchip/cdn-dp-reg.h  |    4 +

From the changes below, it looks that this seems to add support for a bridg=
e chip based on that IP block. So it seems like the bridge+glue driver mode=
l would be a perfect fit for this, instead of stapling this onto the Rockch=
ip-specific driver.

So essentially, you could take the Rockchip cdn-dp driver, move the common =
parts to drivers/gpu/drm/bridge and then create separate glue drivers for b=
oth Rockchip and your external bridge IP block.

This would prevent code duplication and also allow your bridge driver to be=
 compiled without the Rockchip drm being present :-) .
And also pave the way for future socs using your DP ip block.


Nowadays we have quite a number of examples you could take as inspiration f=
or this:
- bridge/analogix/* (shared between Exynos and Rockchip right now)
- bridge/synopsys/dw-hdmi* (shared between a quite big number of users)
- bridge/synopsys/dw-mipi-dsi.c (shared between Rockchip [pending] and stm)


Thanks
Heiko



