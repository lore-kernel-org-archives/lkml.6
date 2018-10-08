Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B904C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 09:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B7F92086D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 09:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="h8gBbIyZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B7F92086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbeJHQZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 12:25:42 -0400
Received: from mail-eopbgr50051.outbound.protection.outlook.com ([40.107.5.51]:57227
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726330AbeJHQZm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 12:25:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QGUW8+QLSgV8YyFkjg75naNuYdCLE8bNb59WCVf9/8w=;
 b=h8gBbIyZhQJ18eRnZei1zhD882t5itfDr0CLyWaCH/QgZpI1uaarsnfFd+3s0JSiaAHqW1hSrzg3dfLQeIKviPMTONXsh8RLl6lNK3DtaM+OoPYN0G8Ocmm8FfwydzDAns7WEExkTjAcYnKwH6YvWXZjshhVsiwbu8qhIhc32ng=
Received: from AM3PR04MB338.eurprd04.prod.outlook.com (10.242.110.15) by
 AM3PR04MB1155.eurprd04.prod.outlook.com (10.163.6.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.28; Mon, 8 Oct 2018 09:14:55 +0000
Received: from AM3PR04MB338.eurprd04.prod.outlook.com
 ([fe80::571:37d5:61c4:ab37]) by AM3PR04MB338.eurprd04.prod.outlook.com
 ([fe80::571:37d5:61c4:ab37%2]) with mapi id 15.20.1207.024; Mon, 8 Oct 2018
 09:14:55 +0000
From:   Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>
To:     "Y.b. Lu" <yangbo.lu@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lunn <andrew@lunn.ch>
CC:     "Y.b. Lu" <yangbo.lu@nxp.com>
Subject: RE: [v3, 3/6] net: dpaa2: fix dependency of config FSL_DPAA2_ETH
Thread-Topic: [v3, 3/6] net: dpaa2: fix dependency of config FSL_DPAA2_ETH
Thread-Index: AQHUXttJ0+nSBMELbUCOvqzgwMWnRqUVD+Kw
Date:   Mon, 8 Oct 2018 09:14:54 +0000
Message-ID: <AM3PR04MB338724B3CCC55D187C08AD094E60@AM3PR04MB338.eurprd04.prod.outlook.com>
References: <20181008074430.34379-1-yangbo.lu@nxp.com>
 <20181008074430.34379-3-yangbo.lu@nxp.com>
In-Reply-To: <20181008074430.34379-3-yangbo.lu@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ruxandra.radulescu@nxp.com; 
x-originating-ip: [213.233.90.125]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB1155;6:2UyLW7p+bvZYtdyFH8HI+pfSBnZfQfs2nXaBKiBfCgIFo/ZWxUcSXCHDsjwD1RCfpZcdmqaKw8XFXf5kf2Voplz3RmMr9gD3YLOxEqlGV//x2sCxiEQY5eFErdlnGl+KvFXIeFBWNSoUCV1jwavDULJix9PiUkgB0eA2pFde8tGgO3dJiamVoFI7l0jf9vSvNllR3EqQsb0lxEYOvLN32LGTgpU4vm4ozeQvN3t806gBQFfv1reBu4JycBqj1BynxllUnj19jP4eVCUmfxHo3MA2zaoD7jJmgse8w6LjVTJhnH9G0/I7sbACD4CkegSKVcTyNYhow+eV4nHxfx3aIgpPSFgOy3e/d//B3iNNvWO5G0EBWieG6Q88ZOQA/+056Wkz5YZyMlKBppI+SqEn0b5S6Gasy04fMlGjcs2NbUtzMuD4Y6Wc0dk7q/H+3qOdXhmN9/z4+lyviGXLz9ttvg==;5:++/nTqw50H8BlOtYjJ1//eV7rkIFWSVUZTobgcqui4sUemivWrjdyU7VOJCnAr7EEPtby+4vgcXrHcuXKwR2ahgfKJIh+c0/gBOCucyPf5+0V/5vA5CjQsNQaS2FyJiZrv5ujpexTGisZ9lkAij70yg7GBGtSsdEoMIQnw+VxXE=;7:5HNqtFyh/FuM6n7C2gX01OfhqhjLDzhyrCZV+HehKMbKeh2qbxHavk2CkXVO90G95V3Myu/V5yRFpo/eUlafNbr25ETHqQC/Q8LCRB2QCpd0KD3HodmU9UvdxuSRLhZehBm9z+kDD/SX+llm+2n+8pDLfdaD6ECHOmNyMj0Pi3s4iZsBIdTiwdshHdHq6GgCMuWoG29VD8Se5PoHZ3L/h9H9ovDmTFr1/CeqePPABaN2tWpqPocGO0mNFhdOOj5i
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 8004f9ea-a010-4301-265e-08d62cfe8310
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1155;
x-ms-traffictypediagnostic: AM3PR04MB1155:
x-microsoft-antispam-prvs: <AM3PR04MB1155CFFE22B154132D16CB9494E60@AM3PR04MB1155.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991055);SRVR:AM3PR04MB1155;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1155;
x-forefront-prvs: 081904387B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(136003)(346002)(396003)(39860400002)(189003)(13464003)(199004)(6506007)(53546011)(74316002)(33656002)(14454004)(105586002)(186003)(97736004)(26005)(66066001)(9686003)(53936002)(106356001)(6436002)(99286004)(25786009)(7736002)(55016002)(4326008)(316002)(305945005)(39060400002)(6246003)(110136005)(102836004)(2906002)(2900100001)(86362001)(2201001)(7696005)(76176011)(11346002)(3846002)(68736007)(5660300001)(446003)(6116002)(71200400001)(71190400001)(476003)(5250100002)(478600001)(486006)(81166006)(81156014)(2501003)(256004)(229853002)(8676002)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1155;H:AM3PR04MB338.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ArncDT1OkaYTCHB/G8OYjpkSye2XjK7rXmpxTDpF/m7aa5C3utaoD9FrJaHJRznZqsTdC6yzEfHVjHMsaZt1gVMvLqUzHL6ozKIclAOX2bEtvFOFht7tCvDc3BjQAcp2pL1/3cKxyyZZQoyqKM+yT5wSqdxOt3+9UefkJo0az7iKX/bvGPVo3rv+N63MRov5EaN/U/Caq0WzA06AjcB9mjFsdF+iKMQqLwTVushE6QJfxrlU+8sIWiPKxXomD4YGFxX8y8edEoRE7kZg+m+0YsPsNbKVt0di2JVPrVy3nAPHwV0GXT/BvSKp3fOuyoyv+fqdntboZCt4rmIC7J4mJpYn+Ch2RfM6dSmkMjJN/eQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8004f9ea-a010-4301-265e-08d62cfe8310
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2018 09:14:55.0442
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1155
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Yangbo Lu <yangbo.lu@nxp.com>
> Sent: Monday, October 8, 2018 10:44 AM
> To: linux-kernel@vger.kernel.org; devel@driverdev.osuosl.org;
> netdev@vger.kernel.org; Richard Cochran <richardcochran@gmail.com>;
> David S . Miller <davem@davemloft.net>; Ioana Ciocoi Radulescu
> <ruxandra.radulescu@nxp.com>; Greg Kroah-Hartman
> <gregkh@linuxfoundation.org>; Andrew Lunn <andrew@lunn.ch>
> Cc: Y.b. Lu <yangbo.lu@nxp.com>
> Subject: [v3, 3/6] net: dpaa2: fix dependency of config FSL_DPAA2_ETH
>=20
> The NETDEVICES dependency and ETHERNET dependency hadn't
> been required since dpaa2-eth was moved out of staging.
> Also allowed COMPILE_TEST for dpaa2-eth.
>=20
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> ---
> Changes for v3:
> 	- Added this patch.
> ---
>  drivers/net/ethernet/freescale/dpaa2/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/freescale/dpaa2/Kconfig
> b/drivers/net/ethernet/freescale/dpaa2/Kconfig
> index 67e6461..a7f365d 100644
> --- a/drivers/net/ethernet/freescale/dpaa2/Kconfig
> +++ b/drivers/net/ethernet/freescale/dpaa2/Kconfig
> @@ -1,7 +1,7 @@
>  config FSL_DPAA2_ETH
>  	tristate "Freescale DPAA2 Ethernet"
>  	depends on FSL_MC_BUS && FSL_MC_DPIO
> -	depends on NETDEVICES && ETHERNET
> +	depends on ARCH_LAYERSCAPE || COMPILE_TEST

Dependency on ARCH_LAYERSCAPE and COMPILE_TEST (for some architectures)
is already implied through FSL_MC_BUS.

Thanks,
Ioana

