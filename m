Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A68C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DB60218FE
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="okJGQZFo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfBGJB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 04:01:59 -0500
Received: from mail-eopbgr50044.outbound.protection.outlook.com ([40.107.5.44]:44559
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726186AbfBGJB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 04:01:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/UCCKlMEDt5MvX2nyOiP4en6UFw/y41ifx+m+jsi5Kg=;
 b=okJGQZFow/AX+jUhPKobjcQ4xHjZAe84SHjK8l7ffN2xg8Vjs4ev3us2GdDv1m2P5nNqFmOEnfRBYC9q7ifFTtiEo5oo/q4wPy48/fdGHWNrcrJNOYsvw5A8qY6WVLPfTudS44XhTKIDBINi8sigMigmeIZ3Sf1JRB5bwkjmIO8=
Received: from VI1PR04MB5008.eurprd04.prod.outlook.com (20.177.49.225) by
 VI1PR04MB5694.eurprd04.prod.outlook.com (20.178.126.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.19; Thu, 7 Feb 2019 09:01:55 +0000
Received: from VI1PR04MB5008.eurprd04.prod.outlook.com
 ([fe80::2d2c:455a:16e9:cd4f]) by VI1PR04MB5008.eurprd04.prod.outlook.com
 ([fe80::2d2c:455a:16e9:cd4f%2]) with mapi id 15.20.1601.016; Thu, 7 Feb 2019
 09:01:55 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Stephen Warren <swarren@nvidia.com>,
        Colin Cross <ccross@android.com>,
        Olof Johansson <olof@lixom.net>,
        Thierry Reding <treding@nvidia.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: manual merge of the tegra tree with the imx-mxs tree
Thread-Topic: linux-next: manual merge of the tegra tree with the imx-mxs tree
Thread-Index: AQHUvm6SHm1RL7N+ikO31FDPxzhOqKXUCq0A
Date:   Thu, 7 Feb 2019 09:01:55 +0000
Message-ID: <20190207090154.myin5rcs3kprostg@fsr-ub1664-175>
References: <20190207095142.5ccc4a8a@canb.auug.org.au>
In-Reply-To: <20190207095142.5ccc4a8a@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB5694;6:ksZbEV2BdjYf00IyhzGGU95mQSkapQCT7w8mQpWTlY1zYZo76IKp+G8Fo7SReKmimuK3T0A7CsaedIejYcFtOrb9zxDvi14aK7EtrYi9PHZibnSAc4k8WRjLbx2QhY+iZjR/23bo7yAuWdUzisK2xKepU+Fv2qHtshjzykXyutDc3K8OmQ4kDhaS0FN9iVhNqQv2ZLAqSFQFD9LTlVhf1ta9JyrTR1h9z+1ST5lOjCyG4LvqXjDNdhnGLe+S8/027mGktpdNHkP71j97lTeQJjPFTzwfbSUtugnC0YhNd6fEe/DQG93VEoRfdwePPazSGN4lk7ZUYgN7qgsNPGR1vE+S9dDgCSGn+ZdIWbkcK5CyrLd9HoXvdgkkSjS50IaNN34cFMw3wNf0ZFvA/6hx9ro27pRIOEYexWYfnpUEfqHssdP/Uzw0KfYhgm+7TOfX++EvqMyAm/5xIbpk+Gd4Aw==;5:qMYCbINNOfSskGETBgL0MH5y+i/d6TOKnPPxzzJ/rj/u0Id31Bu6Qjr4bJQhd0HVV7rnAkOmw/+46swxr7F/FzhYXffQto/z5xWBptgKcv+RMLGEYixkR4pHxipjwtB1MO9Ma/k9HsmTptbsiKDx5sfQTZU5DoKcoczos0SDFH9NJxw5Bq94hiKaYJZS4tPFh9udNLxge83VcJjiaFZnPg==;7:lqk4FHdkq9uSflOXyYbMsE9ZMsrMAsUlK06kSHht5fq9kbunqc/5X57r0miuYcm7LQ9N3INw98qjzNl08mgu624ToDBcrCsckSX7yEZjPqlbTmKsMlqELTKW6sKvOKfb7pL60LJrRO1MkZj9cwTN6w==
x-ms-office365-filtering-correlation-id: 7326a915-6997-4a07-7c27-08d68cdae8d6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5694;
x-ms-traffictypediagnostic: VI1PR04MB5694:
x-microsoft-antispam-prvs: <VI1PR04MB56945EB5DE0FA9CCBBD35C07F6680@VI1PR04MB5694.eurprd04.prod.outlook.com>
x-forefront-prvs: 0941B96580
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(396003)(136003)(39860400002)(366004)(376002)(346002)(53754006)(189003)(199004)(53546011)(76176011)(305945005)(33896004)(6506007)(106356001)(33716001)(6246003)(105586002)(2906002)(6916009)(6512007)(9686003)(53936002)(7736002)(186003)(11346002)(316002)(25786009)(476003)(81166006)(81156014)(8676002)(44832011)(1076003)(102836004)(4326008)(446003)(26005)(99286004)(486006)(54906003)(478600001)(229853002)(6436002)(71190400001)(71200400001)(6486002)(97736004)(256004)(66066001)(86362001)(14454004)(8936002)(3846002)(6116002)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5694;H:VI1PR04MB5008.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2QnIp14fAcu3K7Q9pL92YrCqwxDG8wBJlBNq/Oe+eDBH7vbv+7JcBSHiXifmay8uW/pfTCZIp/Ja4uN3xD/uUrae21E4mLN5L9FsKKgrb9eoR2D4aL9T1+gvmfX1zKjSBlhDSWPFziRpxCLzKaGFsPrvO58SQR1Rn+msFIQJPijOeDmsuBRnXAF3h1s7oSuk2n7u1LTzoKitzift4IlsuKKmtIKxysc02n445hm2Ux99kYo1MhA8XcMNE8BjW3JnlFWTt4B11rpxEdbb9VFS2lYeSQaKLEYHQxfTombaUjCAC8nLfwH7XyUYszFPNrhCKNW46j6MuwSltpOLu1WpS8AsaRfOcOAHJDYjB3p1mnk3pZzNWF5ugVKzcTDpKHOcu34E7RzTN3uu8GztNz6InZ2xg+4/MQOwUppJnKLNaAk=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <791CA834A472C246B4022A7108EAE047@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7326a915-6997-4a07-7c27-08d68cdae8d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2019 09:01:55.5452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5694
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-02-07 09:51:42, Stephen Rothwell wrote:
> Hi all,
>=20
> Today's linux-next merge of the tegra tree got a conflict in:
>=20
>   arch/arm64/configs/defconfig
>=20
> between commit:
>=20
>   9bd01e74c715 ("arm64: defconfig: Add i.MX8MQ boot necessary configs")
>=20
> from the imx-mxs tree and commit:
>=20
>   bc72bed682a9 ("arm64: defconfig: Enable Tegra TCU")
>=20
> from the tegra tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc arch/arm64/configs/defconfig
> index e82bc8cf1253,ad8f3dea0a74..000000000000
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@@ -323,8 -319,7 +323,9 @@@ CONFIG_SERIAL_MESON_CONSOLE=3D
>   CONFIG_SERIAL_SAMSUNG=3Dy
>   CONFIG_SERIAL_SAMSUNG_CONSOLE=3Dy
>   CONFIG_SERIAL_TEGRA=3Dy
> + CONFIG_SERIAL_TEGRA_TCU=3Dy
>  +CONFIG_SERIAL_IMX=3Dy
>  +CONFIG_SERIAL_IMX_CONSOLE=3Dy
>   CONFIG_SERIAL_SH_SCI=3Dy
>   CONFIG_SERIAL_MSM=3Dy
>   CONFIG_SERIAL_MSM_CONSOLE=3Dy

Looks fine to me.

Abel=
