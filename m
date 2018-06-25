Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51FFEC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF8B525655
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="hIgV9ST5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF8B525655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754690AbeFYJGH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 05:06:07 -0400
Received: from mail-eopbgr680078.outbound.protection.outlook.com ([40.107.68.78]:50849
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754245AbeFYJGF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 05:06:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ey2yn2IxyTf8AFNe2BaAPc8TH6SuASWj9Pa21E6Zb+k=;
 b=hIgV9ST5Clbnjqm6wpUB5/fIcXybYv8nttembe6kQLhpXfpnSQpPihCNkg1lPNaxL3iZM4/I88eNKY7Zk0IssrW3YXw/xVhFUzSFA1QlNEO0fBODjamH6fy3z2dLxa2zBUHfBfeGSfJaWa5mN3R+vh3922C9Jx3+PxiKvOFjbL8=
Received: from SN1PR02MB1693.namprd02.prod.outlook.com (10.162.129.23) by
 SN1PR02MB1693.namprd02.prod.outlook.com (10.162.129.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.24; Mon, 25 Jun 2018 09:06:01 +0000
Received: from SN1PR02MB1693.namprd02.prod.outlook.com
 ([fe80::40cd:bd4b:87bf:d382]) by SN1PR02MB1693.namprd02.prod.outlook.com
 ([fe80::40cd:bd4b:87bf:d382%2]) with mapi id 15.20.0884.024; Mon, 25 Jun 2018
 09:05:58 +0000
From:   Appana Durga Kedareswara Rao <appanad@xilinx.com>
To:     Radhey Shyam Pandey <radheys@xilinx.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Michal Simek <michals@xilinx.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "lars@metafoo.de" <lars@metafoo.de>
CC:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Radhey Shyam Pandey <radheys@xilinx.com>
Subject: RE: [PATCH 2/2] dmaengine: xilinx_dma: Enable VDMA S2MM vertical flip
 support
Thread-Topic: [PATCH 2/2] dmaengine: xilinx_dma: Enable VDMA S2MM vertical
 flip support
Thread-Index: AQHUAukZBUWyfiLpwkOgwpMVtT5SSKRwwTPA
Date:   Mon, 25 Jun 2018 09:05:58 +0000
Message-ID: <SN1PR02MB16933049734FBC759F8D8F48DC4A0@SN1PR02MB1693.namprd02.prod.outlook.com>
References: <1528875288-9140-1-git-send-email-radhey.shyam.pandey@xilinx.com>
 <1528875288-9140-3-git-send-email-radhey.shyam.pandey@xilinx.com>
In-Reply-To: <1528875288-9140-3-git-send-email-radhey.shyam.pandey@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=appanad@xilinx.com; 
x-originating-ip: [182.72.145.30]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR02MB1693;7:3v0GFeeU+Lfk1egZO6+02FI9Qhloo8ADkKDc/JLk7TR1t0Uw0jpgyWxbCOorns7vEzX6BGL7bzcVbHyejgxfbA3FH3cgX/jHk5xcJLl1oWhqbKNE/Ja4TyTAJLvDMaY8fOj5pETYuirGyXlwsFAZ2rH99yKETMnmFyMTQH5g3jtar9zCNJM1yweZDrQyZdSxWnjS+1h6l0tpfjEqKnL9LSqgqLZIP63jOBEIm4/ARBTDHlFk5mflqXmob1zx9IkO
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: e17e28b8-7794-44e9-d9eb-08d5da7adddc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:SN1PR02MB1693;
x-ms-traffictypediagnostic: SN1PR02MB1693:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <SN1PR02MB1693A01FA353BF4DC35BFF4CDC4A0@SN1PR02MB1693.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:SN1PR02MB1693;BCL:0;PCL:0;RULEID:;SRVR:SN1PR02MB1693;
x-forefront-prvs: 0714841678
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(39380400002)(366004)(376002)(346002)(189003)(199004)(6506007)(97736004)(102836004)(76176011)(7736002)(9686003)(66066001)(305945005)(7696005)(5660300001)(8676002)(81156014)(68736007)(8936002)(81166006)(478600001)(3660700001)(3280700002)(74316002)(33656002)(14454004)(2906002)(110136005)(316002)(54906003)(105586002)(53936002)(2900100001)(3846002)(99286004)(106356001)(6116002)(2501003)(2201001)(446003)(107886003)(476003)(11346002)(4326008)(486006)(5250100002)(6436002)(86362001)(575784001)(55016002)(25786009)(26005)(6246003)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR02MB1693;H:SN1PR02MB1693.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: NCRSpfdGdo0kciDI0zXTwY1KvwrtMj5G22PCK/SDBYZl5H6v+70pnqwH10u6oUoQuHDXbYcW0NhwOS1q8NcoVtWyVGzfs1uPemYl0Y8rSevSbwchWK8scv7uMoS54W1/TEFXtWsToJDNjjxDs2HfbLCiQ2pEun+tsBn9zMD2D81jX0+FKCC9RRiICs95KDOUCwbM6leL1kNADcflp+ZG17L7bUzGi9IiZO3jSgZEbh1AGFSTHrcG52Jpbuy9ElejMGxjUgRu9S/Vp5/DN8LYXl4JFR0Le0bZZmI6LkrwqwskKBzC4MBU5N717evi+gcJK4UCnjCfAoZlHPSb/Nb2vPUWaxhafJSJowlMbPQ1hsU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e17e28b8-7794-44e9-d9eb-08d5da7adddc
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2018 09:05:58.4959
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR02MB1693
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


<Snip>
>=20
> Vertical flip state is exported in xilinx_vdma_config and depending on IP
> configuration(c_enable_vert_flip) vertical flip state is programmed in
> hardware.
>=20
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Acked-by: Kedareswara rao Appana <appanad@xilinx.com> =20

> ---
>  drivers/dma/xilinx/xilinx_dma.c |   22 ++++++++++++++++++++++
>  include/linux/dma/xilinx_dma.h  |    2 ++
>  2 files changed, 24 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/dma/xilinx/xilinx_dma.c
> b/drivers/dma/xilinx/xilinx_dma.c index 27b5235..c124423 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -115,6 +115,9 @@
>  #define XILINX_VDMA_REG_START_ADDRESS(n)	(0x000c + 4 * (n))
>  #define XILINX_VDMA_REG_START_ADDRESS_64(n)	(0x000c + 8 * (n))
>=20
> +#define XILINX_VDMA_REG_ENABLE_VERTICAL_FLIP	0x00ec
> +#define XILINX_VDMA_ENABLE_VERTICAL_FLIP	BIT(0)
> +
>  /* HW specific definitions */
>  #define XILINX_DMA_MAX_CHANS_PER_DEVICE	0x20
>=20
> @@ -340,6 +343,7 @@ struct xilinx_dma_tx_descriptor {
>   * @start_transfer: Differentiate b/w DMA IP's transfer
>   * @stop_transfer: Differentiate b/w DMA IP's quiesce
>   * @tdest: TDEST value for mcdma
> + * @has_vflip: S2MM vertical flip
>   */
>  struct xilinx_dma_chan {
>  	struct xilinx_dma_device *xdev;
> @@ -376,6 +380,7 @@ struct xilinx_dma_chan {
>  	void (*start_transfer)(struct xilinx_dma_chan *chan);
>  	int (*stop_transfer)(struct xilinx_dma_chan *chan);
>  	u16 tdest;
> +	bool has_vflip;
>  };
>=20
>  /**
> @@ -1092,6 +1097,14 @@ static void xilinx_vdma_start_transfer(struct
> xilinx_dma_chan *chan)
>  				desc->async_tx.phys);
>=20
>  	/* Configure the hardware using info in the config structure */
> +	if (chan->has_vflip) {
> +		reg =3D dma_read(chan,
> XILINX_VDMA_REG_ENABLE_VERTICAL_FLIP);
> +		reg &=3D ~XILINX_VDMA_ENABLE_VERTICAL_FLIP;
> +		reg |=3D config->vflip_en;
> +		dma_write(chan,
> XILINX_VDMA_REG_ENABLE_VERTICAL_FLIP,
> +			  reg);
> +	}
> +
>  	reg =3D dma_ctrl_read(chan, XILINX_DMA_REG_DMACR);
>=20
>  	if (config->frm_cnt_en)
> @@ -2105,6 +2118,8 @@ int xilinx_vdma_channel_set_config(struct
> dma_chan *dchan,
>  	}
>=20
>  	chan->config.frm_cnt_en =3D cfg->frm_cnt_en;
> +	chan->config.vflip_en =3D cfg->vflip_en;
> +
>  	if (cfg->park)
>  		chan->config.park_frm =3D cfg->park_frm;
>  	else
> @@ -2428,6 +2443,13 @@ static int xilinx_dma_chan_probe(struct
> xilinx_dma_device *xdev,
>  		chan->direction =3D DMA_DEV_TO_MEM;
>  		chan->id =3D chan_id;
>  		chan->tdest =3D chan_id - xdev->nr_channels;
> +		chan->has_vflip =3D of_property_read_bool(node,
> +					"xlnx,enable-vert-flip");
> +		if (chan->has_vflip) {
> +			chan->config.vflip_en =3D dma_read(chan,
> +				XILINX_VDMA_REG_ENABLE_VERTICAL_FLIP)
> &
> +				XILINX_VDMA_ENABLE_VERTICAL_FLIP;
> +		}
>=20
>  		chan->ctrl_offset =3D XILINX_DMA_S2MM_CTRL_OFFSET;
>  		if (xdev->dma_config->dmatype =3D=3D XDMA_TYPE_VDMA) { diff
> --git a/include/linux/dma/xilinx_dma.h b/include/linux/dma/xilinx_dma.h
> index 34b98f2..5b6e61e 100644
> --- a/include/linux/dma/xilinx_dma.h
> +++ b/include/linux/dma/xilinx_dma.h
> @@ -27,6 +27,7 @@
>   * @delay: Delay counter
>   * @reset: Reset Channel
>   * @ext_fsync: External Frame Sync source
> + * @vflip_en:  Vertical Flip enable
>   */
>  struct xilinx_vdma_config {
>  	int frm_dly;
> @@ -39,6 +40,7 @@ struct xilinx_vdma_config {
>  	int delay;
>  	int reset;
>  	int ext_fsync;
> +	bool vflip_en;
>  };
>=20
>  int xilinx_vdma_channel_set_config(struct dma_chan *dchan,
> --
> 1.7.1

