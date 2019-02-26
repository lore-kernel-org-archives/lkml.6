Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDDC7C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 08:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81E952147C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 08:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="XXU7ce/v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbfBZIrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 03:47:46 -0500
Received: from mail-eopbgr1310123.outbound.protection.outlook.com ([40.107.131.123]:14653
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725908AbfBZIrq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 03:47:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQNkpQIm/AWP3M6fmpN4ICC7AC4oELWkYoBYxEevT0Y=;
 b=XXU7ce/vhbhH8eRwd5c0U5fQyQNat0an8ZsaC6nBoowieglAxS4Vje1cxlJrPJll+Qkppiex4hXmIMehz1/9LFHRPruQA2Yd4HuKM6sRY41x30fSWC7NlxGTHchskqF6d4nJLPHhUdHzrS26MJqOlQCfwAnkZWjHAF9hjlYSkcI=
Received: from TY2PR01MB4812.jpnprd01.prod.outlook.com (20.179.170.147) by
 TY2PR01MB3515.jpnprd01.prod.outlook.com (20.178.133.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Tue, 26 Feb 2019 08:47:37 +0000
Received: from TY2PR01MB4812.jpnprd01.prod.outlook.com
 ([fe80::44b:a054:4954:f819]) by TY2PR01MB4812.jpnprd01.prod.outlook.com
 ([fe80::44b:a054:4954:f819%2]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 08:47:37 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Spyridon Papageorgiou <spapageorgiou@de.adit-jv.com>,
        "mathias.nyman@intel.com" <mathias.nyman@intel.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "yasano@jp.adit-jv.com" <yasano@jp.adit-jv.com>,
        "REE erosca@DE.ADIT-JV.COM" <erosca@DE.ADIT-JV.COM>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb: host: xhci-rcar: Add XHCI_TRUST_TX_LENGTH quirk
Thread-Topic: [PATCH] usb: host: xhci-rcar: Add XHCI_TRUST_TX_LENGTH quirk
Thread-Index: AQHUx3V44GG2oJMDgkW3P8w4U6w2ZKXxzycQ
Date:   Tue, 26 Feb 2019 08:47:37 +0000
Message-ID: <TY2PR01MB481290611E1686E51697FCFFD87B0@TY2PR01MB4812.jpnprd01.prod.outlook.com>
References: <20190218102633.11738-1-spapageorgiou@de.adit-jv.com>
In-Reply-To: <20190218102633.11738-1-spapageorgiou@de.adit-jv.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [124.210.22.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 45470d44-47d5-407e-5091-08d69bc70f6e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:TY2PR01MB3515;
x-ms-traffictypediagnostic: TY2PR01MB3515:
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-microsoft-exchange-diagnostics: 1;TY2PR01MB3515;20:7MXVB8+pLb8R3+jvdKBykG/MIF2j6PVOG7vzP4DJFrY1l0D1r9dx4ozn+gjrpX1mTZWkneqsJ5rXHeuYiVmUKe2oKa8K8UT243Lk+2TixfUeFQ9RKHd+ElTF9hl41bQ2yw6RQxoqcVMFy/p1UMQ5r3/icxcBr+ZDvRfBaHCol1U=
x-microsoft-antispam-prvs: <TY2PR01MB35158640E33C54F2228373CBD87B0@TY2PR01MB3515.jpnprd01.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(376002)(346002)(136003)(39860400002)(199004)(189003)(8676002)(71200400001)(71190400001)(2906002)(478600001)(229853002)(25786009)(5660300002)(11346002)(476003)(316002)(2501003)(486006)(53936002)(86362001)(52536013)(110136005)(6246003)(446003)(33656002)(6116002)(3846002)(4326008)(76176011)(7696005)(186003)(99286004)(105586002)(106356001)(81156014)(81166006)(6506007)(53546011)(55236004)(102836004)(26005)(14454004)(74316002)(68736007)(9686003)(14444005)(54906003)(8936002)(256004)(66066001)(55016002)(6436002)(7736002)(305945005)(97736004);DIR:OUT;SFP:1102;SCL:1;SRVR:TY2PR01MB3515;H:TY2PR01MB4812.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ilv+w0q9ZyHk3vvLOesEMizLo7hyp/bK7Nq+0pRBZLN0KLygJX4/KjPRIdjYVpkb2RrUZE33Uaxs3tJkEHJ3iba3g9ftiNTdxS/rzwO2lYuzPB6EuM872EE7hDMGW/fBq63MY5kWo4QXaUe3/Pan+95SdkEBChfMUK7Qh2B1j6hKdRGP9a1EPpThZ9FVQzZkiv7hP3Q0pi2+T6HKNk0k7/XEc7/4P2K9cs7JY/hRnq/E8GGwrelqWF5NVBVDO4JBFuJvTfNyfWMK9+QOAfjNsbJUjs6ItiGTV2XNACCal/UlifsLwForNmkNmGmomm+dsh5cB+flMRuBijho25ig7GZ3d//MJRTBG8jRH8AYTllJO9AhbLVTKPQ0Lu52jRzdrRI4o0yM3X++l9vbuaryMHAogOVjmikLCepeqbXy6T8=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45470d44-47d5-407e-5091-08d69bc70f6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 08:47:37.6897
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3515
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> From: Spyridon Papageorgiou, Sent: Monday, February 18, 2019 7:27 PM
> To: mathias.nyman@intel.com
> Cc: gregkh@linuxfoundation.org; yasano@jp.adit-jv.com; REE erosca@DE.ADIT=
-JV.COM <erosca@DE.ADIT-JV.COM>;
> linux-usb@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH] usb: host: xhci-rcar: Add XHCI_TRUST_TX_LENGTH quirk
>=20
> From: Yasushi Asano <yasano@jp.adit-jv.com>
>=20
> When plugging BUFFALO LUA4-U3-AGT USB3.0 to Gigabit Ethernet LAN
> Adapter, warning messages filled up dmesg.
>=20
> [  101.098287] xhci-hcd ee000000.usb: WARN Successful completion on short=
 TX for slot 1 ep 4: needs XHCI_TRUST_TX_LENGTH
> quirk?
> [  101.117463] xhci-hcd ee000000.usb: WARN Successful completion on short=
 TX for slot 1 ep 4: needs XHCI_TRUST_TX_LENGTH
> quirk?
> [  101.136513] xhci-hcd ee000000.usb: WARN Successful completion on short=
 TX for slot 1 ep 4: needs XHCI_TRUST_TX_LENGTH
> quirk?
>=20
> Adding the XHCI_TRUST_TX_LENGTH quirk resolves the issue.
>=20
> Signed-off-by: Yasushi Asano <yasano@jp.adit-jv.com>
> Signed-off-by: Spyridon Papageorgiou <spapageorgiou@de.adit-jv.com>

Thank you for the patch!

I don't know why R-Car xHCI needs this quirk though...
However, other xHCI controllers [1] also seem unclear why this quirk needs.
So,

Acked-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Best regards,
Yoshihiro Shimoda

[1]
---
commit da99706689481717998d1d48edd389f339eea979
Author: Daniel Thompson <daniel.thompson@linaro.org>
Date:   Thu Dec 21 15:06:15 2017 +0200

    usb: xhci: Add XHCI_TRUST_TX_LENGTH for Renesas uPD720201
---
commit d2f48f05cd2a2a0a708fbfa45f1a00a87660d937
Author: Corentin Labbe <clabbe.montjoie@gmail.com>
Date:   Fri Jun 9 14:48:41 2017 +0300

    usb: xhci: ASMedia ASM1042A chipset need shorts TX quirk
---
commit 2597fe99bb0259387111d0431691f5daac84f5a5
Author: Huang Rui <ray.huang@amd.com>
Date:   Tue Aug 19 15:17:57 2014 +0300

    usb: xhci: amd chipset also needs short TX quirk
---

> ---
>  drivers/usb/host/xhci-rcar.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/usb/host/xhci-rcar.c b/drivers/usb/host/xhci-rcar.c
> index a6e463715779..671bce18782c 100644
> --- a/drivers/usb/host/xhci-rcar.c
> +++ b/drivers/usb/host/xhci-rcar.c
> @@ -246,6 +246,7 @@ int xhci_rcar_init_quirk(struct usb_hcd *hcd)
>  	if (!xhci_rcar_wait_for_pll_active(hcd))
>  		return -ETIMEDOUT;
>=20
> +	xhci->quirks |=3D XHCI_TRUST_TX_LENGTH;
>  	return xhci_rcar_download_firmware(hcd);
>  }
>=20
> --
> 2.20.1

