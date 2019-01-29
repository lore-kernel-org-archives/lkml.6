Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147FCC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9BC02087F
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="DggUPO1n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729396AbfA2UJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 15:09:47 -0500
Received: from mail-eopbgr750129.outbound.protection.outlook.com ([40.107.75.129]:60096
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727229AbfA2UJq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 15:09:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yJQtleUq3yiL3hu/ArSCi9Yh5NdG+6QL9LtU8WnN+Vs=;
 b=DggUPO1n35n+kOigQ7fmR8/tIpeGLhuOVYQRnQDod9BgXfnNV6f8GUvecgmDA6hOS/x3MBpCPT8aahc7m6IEwvh0OmdGwtnlYO+O/7PqhF2mGbJWVL+QB6EFKMTVLVPAPIDWf4EpNkiy1ECeVgdPih8zvj2JfEbKJQJti7O/P9k=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1582.namprd22.prod.outlook.com (10.174.167.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.19; Tue, 29 Jan 2019 20:09:07 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636%9]) with mapi id 15.20.1558.023; Tue, 29 Jan 2019
 20:09:07 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Nishad Kamdar <nishadkamdar@gmail.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        NeilBrown <neil@brown.name>, Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, Joe Perches <joe@perches.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MIPS: Select PINCTRL_RT2880 when RALINK is enabled
Thread-Topic: [PATCH] MIPS: Select PINCTRL_RT2880 when RALINK is enabled
Thread-Index: AQHUt+bkNR8KLJ2FGECDdb70JPYxtKXGrSqA
Date:   Tue, 29 Jan 2019 20:09:07 +0000
Message-ID: <20190129200905.vnb3amouxq6o57fn@pburton-laptop>
References: <20190129152522.GA24872@nishad>
In-Reply-To: <20190129152522.GA24872@nishad>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR02CA0063.namprd02.prod.outlook.com
 (2603:10b6:a03:54::40) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1582;6:UtDWYpe7x0b5z9L9mQ4b7J8jeTg8MmooBEYA5wL3Wp3Mq52PbkGfRbCWWcPcOsmVek/vDwjV0jkY/gcZaxsaVXEfl5XYVHLEX8NOH1eEE+h+5s0Xek7jC7540kkEZoUmw7WUrygfqFOcvj913/Wvfd4ZDArSEGqNbr26aJTvKa4XgBt+8v6x3bScFGQ1V7e2oZjqHYg/7rdnZP927cQd+x8cJ4ryqR7vvWy8RbMAaKHdT7pjmMVw66zbanLbigu62g+tZ6MEkFRCXplnvWf6JQ2oYzOBLsY9pXJ1cEL4V0jteeuUI/tMtYk+lHjIOrOhAu4swe7clxVNOY0XkdAwndV+WBzA8P5eW29Z6cE7zjxSuEfGJPW4ob7l67KVVR0TF1GpnKyNZSHCqyDbGoce5pHMxtlM0vUyxgyTt7e8PvJzRyhQocjIKRezcXzr4T7hCEm0dQxF2MVrQXmSVwc8xA==;5:I0WhWJ8OZbK4uxnRWqgJm1nlQvOKxqSWaDON1383RV/ZLwJqaX6DXtSOw+o1gcGgMtR0FrCVJoDxpK2fvYZTOVBS5mYwV4jiLyuF+V1i0zR1wPc8pUv+8ZoKQqZghH9B66JTinikfZSSTnLT3VJ58bphO5nVG1wQ8Wm/nxQRh/be/hhwA80SWxQ53RCNc2NnWrL9YLU7zV7chkgdAN8tDw==;7:xsfrMjiHJn1m+1w9SrLDj1IB1qCBdFLUMWchYIJzpEmwXEmeqjEUyGEtqDcoUszdTNCgVG5kedO5ksIlfPnQHN/cNkqwxtvW3AwhS2ietMB0A87CuH56ea/jWZhirliiPR4Hf8GSUipwS06ijzWlRQ==
x-ms-office365-filtering-correlation-id: fbd46eba-dc03-459d-7de8-08d686259f7d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1582;
x-ms-traffictypediagnostic: MWHPR2201MB1582:
x-microsoft-antispam-prvs: <MWHPR2201MB1582301CC877BE1B2FA1F000C1970@MWHPR2201MB1582.namprd22.prod.outlook.com>
x-forefront-prvs: 093290AD39
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(396003)(346002)(39850400004)(366004)(376002)(136003)(189003)(199004)(386003)(6506007)(2906002)(102836004)(4744005)(97736004)(105586002)(8936002)(6116002)(3846002)(33716001)(7416002)(256004)(476003)(1411001)(446003)(26005)(25786009)(1076003)(305945005)(11346002)(8676002)(81166006)(186003)(66066001)(106356001)(81156014)(42882007)(6916009)(52116002)(9686003)(6512007)(486006)(6246003)(14454004)(99286004)(6436002)(4326008)(58126008)(53936002)(478600001)(76176011)(33896004)(39060400002)(44832011)(7736002)(71190400001)(71200400001)(68736007)(316002)(6486002)(54906003)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1582;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +eRIWNlwAM61e8BwR4iQFudLnssU1OOz+mGTJckCuSXZhBuNCI3fm7Y45ttIrKas1NWPnp8Gf8t0hqN7SCgszDU3sgFAAvx+UqY9lwjg+bUMv8/2cD0xGhqkG5Ul3tl0xF7nk+fPLFd5O8FWqZ4RdLx5XHpW7goxUjY9LFxa8R2zOJCFY/tCWzDKB57gdtLa4t+skaNgaGXtX7JfMt3lvdiJro+C2Rlv+KtJE2uv/afuv8ypm2bvhAFGPUKnjgUXiD6rZxjbX0s0nNOY2lAtKN+pO3sq6T5DK7L3o4kU4lyxaRQmWtcTpftl+/3espeT30i2Opj3L2IGHY8s6UKXeDabWaHzkiuxyEZPZUjRXtcBaMeiva7Zztr4nfa+4WTaJDxvdRnQqD0OYsYhEG5iZV8LlZ1j0LkXAct0lsFfAOA=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <335B6EC3D6EAD047885765D40FEEF4B3@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbd46eba-dc03-459d-7de8-08d686259f7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2019 20:09:06.6592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1582
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nishad,

On Tue, Jan 29, 2019 at 08:55:27PM +0530, Nishad Kamdar wrote:
> This patch selects config PINCTRL_RT2880 when config RALINK is
> enabled as per drivers/staging/mt7621-pinctrl/TODO list. PINCTRL
> is also selected when RALINK is enabled to avoid config dependency
> warnings.
>=20
> Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> ---
>  arch/mips/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index e2fc88da0223..cea529cf6284 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -623,6 +623,8 @@ config RALINK
>  	select CLKDEV_LOOKUP
>  	select ARCH_HAS_RESET_CONTROLLER
>  	select RESET_CONTROLLER
> +	select PINCTRL
> +	select PINCTRL_RT2880
> =20
>  config SGI_IP22
>  	bool "SGI IP22 (Indy/Indigo2)"

Wouldn't this also require selecting STAGING? Perhaps that's why it
wasn't done in the first place?

Thanks,
    Paul
