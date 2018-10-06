Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 657A0C64EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 07:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D0BC208E7
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 07:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="4vu+L315"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D0BC208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbeJFOMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 10:12:15 -0400
Received: from mail-cys01nam02on0054.outbound.protection.outlook.com ([104.47.37.54]:5664
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726913AbeJFOMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 10:12:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mWLNgjf0N0yKSG7RbaACYCLmMs1Js5qWC2FUzxKrdfM=;
 b=4vu+L315Auk6+DfoG8aqOXs+nK8gRqnlvE0v/qRaLsQYSWyQ00kZ+p5FOzyU3uAOgdyaaKkXIHF98HOjvogYmzkPIpzFWhURdd2qb/KRVvne7hp40Vb0sUZ7jXWcSULLCDtdgc8Rr8/RWczfIw+jw7CYKm7BAva2jl+Gcu0t7hw=
Received: from SN4PR0201MB3630.namprd02.prod.outlook.com (10.167.129.156) by
 SN4PR0201MB3615.namprd02.prod.outlook.com (10.167.129.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.26; Sat, 6 Oct 2018 07:09:42 +0000
Received: from SN4PR0201MB3630.namprd02.prod.outlook.com
 ([fe80::7986:71f2:1fd9:78fb]) by SN4PR0201MB3630.namprd02.prod.outlook.com
 ([fe80::7986:71f2:1fd9:78fb%5]) with mapi id 15.20.1207.024; Sat, 6 Oct 2018
 07:09:40 +0000
From:   Radhey Shyam Pandey <radheys@xilinx.com>
To:     Vinod <vkoul@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Michal Simek <michals@xilinx.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Appana Durga Kedareswara Rao <appanad@xilinx.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 2/2] dmaengine: xilinx_dma: Add Xilinx AXI MCDMA
 Engine driver support
Thread-Topic: [RFC PATCH 2/2] dmaengine: xilinx_dma: Add Xilinx AXI MCDMA
 Engine driver support
Thread-Index: AQHUKPZukvXPl7piA0qQMqMVS2XYUqTKelqAgEetcsA=
Date:   Sat, 6 Oct 2018 07:09:40 +0000
Message-ID: <SN4PR0201MB363074E44B3E6A67B9D5ECD4C7E40@SN4PR0201MB3630.namprd02.prod.outlook.com>
References: <1533059173-21405-1-git-send-email-radhey.shyam.pandey@xilinx.com>
 <1533059173-21405-3-git-send-email-radhey.shyam.pandey@xilinx.com>
 <20180821154635.GG2388@vkoul-mobl>
In-Reply-To: <20180821154635.GG2388@vkoul-mobl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
x-originating-ip: [183.83.157.228]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN4PR0201MB3615;6:3LoyO8PFTAMN2VY29hDKwK/Iyom0lRI3VqknHZQwDl3fD0WPsS1KmBVMnK9WLhE86WZo0LWRpTem12yDW8sWPFT4hiRlQ8ILjzSZiCpMzu+DrRE3jC6ENBVCJNkHruqAoUxM6XM3B3rgYXVDMhDYJD3PAejN513NDqd4ODD7mAPKl33VudGHdriMYPBDSDxbeesJeEp4RWb4AtqgRHyXLb0uT2sbzNeXvpLO6FS13LePpkSG8BDQuy5nOnrfqfqgzjv9FK0X0zEFAf2u+FIwFtY+VaMRlDiy3eA1mfK+Dyy69PvbPB0Bue6RVa5wriv6XGN87+YEBimtoBpAgrZzRX6uTMKu5KsticMDHMqJt9HhWx72F+f04zX02ofHTDSP6tq9lSWcN45wm3sqdHWoR+G8Qd1aV5H8PmlcQAk/DZoRc7uyGGl9W2hrHrX4zfM2O8cYVIS34uiGPGZrLOI9OA==;5:KfOunQc3yvJujJdxtFysckPryb7/cOR51A2tuwiAeiBOpklop8ThYxyFoU1eb0BMlxAGYoH2SJqRdLjI/NrzgJjTnZERYwxTdzHqIbZ/Zo9j7/EzCyaaXvfrfpDncs9AGyasWCNg39DwesmtTULqpPciyolyAgySf2KDE+lpIMU=;7:bQ7Ank0Sagka9blTiwduGFbyoKJnXAvxeKdHpNdCD9gIXiQxq/RZk9cLgdm5bf37hVcBEmL8OOT8HioOsn2ApTGnZlLsRSgieC3DTJ1IwrACQDT0EcOrqzhf1lM2BXDhCKPbDsHV5E9Daga7nu2ENTYJ4pHNdxR7HZ0jHKEU8cFVC+fZGUggLCSYkkGO3zU2d1RzEx05gHsWaWkODjacN/tinCrTNtC+/5hx3tmhHIU6Z2TQROdkaNyj8SWhd7Qo
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(136003)(366004)(39860400002)(376002)(346002)(396003)(199004)(189003)(51914003)(14444005)(217873002)(229853002)(256004)(25786009)(186003)(26005)(81166006)(53936002)(81156014)(102836004)(9686003)(55016002)(97736004)(551934003)(476003)(33656002)(486006)(6436002)(446003)(71200400001)(11346002)(71190400001)(8676002)(8936002)(76176011)(6246003)(99286004)(316002)(106356001)(74316002)(7696005)(5660300001)(105586002)(54906003)(2906002)(305945005)(7736002)(53546011)(5250100002)(68736007)(6506007)(6916009)(86362001)(4326008)(478600001)(2900100001)(66066001)(3846002)(6116002)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN4PR0201MB3615;H:SN4PR0201MB3630.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: d0eb1f8f-39bc-4fa2-1951-08d62b5aaf0b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN4PR0201MB3615;
x-ms-traffictypediagnostic: SN4PR0201MB3615:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=radheys@xilinx.com; 
x-microsoft-antispam-prvs: <SN4PR0201MB3615B7ECC2CA8569C2BBEC72C7E40@SN4PR0201MB3615.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(3002001)(10201501046)(6055026)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991055);SRVR:SN4PR0201MB3615;BCL:0;PCL:0;RULEID:;SRVR:SN4PR0201MB3615;
x-forefront-prvs: 0817737FD1
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: L1OdZD1YB0sBSyCQ5CPKpcnIWFgWasUv4iPYv7hUNfTy6/3ZkKT3E8ObWEUS6MfFEagW5Urpj/cYL+nlg8eI+UbrWB+1Yw2oV48ZgdmIyjPr+yJh63PaaYIV1ifDakqHrcOHOYgRkNhK0XvXdIZH/SRwOLjq6MrH8iZfrOmbcG5ghd3O7/2VafJ9ewMaMhE9NSMncCJ+bOPy2ygbTiGN4eP97DOT3xJkiGvic/y/7/Y9V88FJ6E0VPBBgUjuD+3GKYxfaKBWSKCZcOMKC9gWsC5XZm3TOm1Y/IqYOjocCg2oAT9NT7p4vKGj1kE2YRQ15b/w1Bt26/t/huxdjO0lfN1A9UP8GEDH97E2k7duFEs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0eb1f8f-39bc-4fa2-1951-08d62b5aaf0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2018 07:09:40.1844
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB3615
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review.

> On 31-07-18, 23:16, Radhey Shyam Pandey wrote:
> >  struct xilinx_dma_config {
> > @@ -402,6 +470,7 @@ struct xilinx_dma_config {
> >  	int (*clk_init)(struct platform_device *pdev, struct clk **axi_clk,
> >  			struct clk **tx_clk, struct clk **txs_clk,
> >  			struct clk **rx_clk, struct clk **rxs_clk);
> > +	irqreturn_t (*irq_handler)(int irq, void *data);
>=20
> this sounds like a preparatory change?

Yes, I will split it in a separate patch.
>=20
> > +	} else if (chan->xdev->dma_config->dmatype =3D=3D
> XDMA_TYPE_AXIMCDMA) {
> > +		/* Allocate the buffer descriptors. */
> > +		chan->seg_mv =3D dma_zalloc_coherent(chan->dev,
> > +						  sizeof(*chan->seg_mv) *
> > +						  XILINX_DMA_NUM_DESCS,
> > +						  &chan->seg_p,
> GFP_KERNEL);
> > +		if (!chan->seg_mv) {
> > +			dev_err(chan->dev,
> > +				"unable to allocate channel %d descriptors\n",
> > +				chan->id);
> > +			return -ENOMEM;
> > +		}
> > +		for (i =3D 0; i < XILINX_DMA_NUM_DESCS; i++) {
> > +			chan->seg_mv[i].hw.next_desc =3D
> > +			lower_32_bits(chan->seg_p + sizeof(*chan->seg_mv) *
> > +				((i + 1) % XILINX_DMA_NUM_DESCS));
> > +			chan->seg_mv[i].hw.next_desc_msb =3D
> > +			upper_32_bits(chan->seg_p + sizeof(*chan->seg_mv) *
> > +				((i + 1) % XILINX_DMA_NUM_DESCS));
> > +			chan->seg_mv[i].phys =3D chan->seg_p +
> > +				sizeof(*chan->seg_v) * i;
> > +			list_add_tail(&chan->seg_mv[i].node,
> > +				      &chan->free_seg_list);
> > +		}
>=20
> only change with this and previous one seems to be use of seg_mv instead
> of seg_v right? if so, can you try to modularise this..
Agree. I will modularise it.

>=20
> >  /**
> > + * xilinx_mcdma_start_transfer - Starts MCDMA transfer
> > + * @chan: Driver specific channel struct pointer
> > + */
> > +static void xilinx_mcdma_start_transfer(struct xilinx_dma_chan *chan)
> > +{
> > +	struct xilinx_dma_tx_descriptor *head_desc, *tail_desc;
> > +	struct xilinx_axidma_tx_segment *tail_segment;
> > +	u32 reg;
> > +
> > +	if (chan->err)
> > +		return;
> > +
> > +	if (!chan->idle)
> > +		return;
> > +
> > +	if (list_empty(&chan->pending_list))
> > +		return;
>=20
> okay i was thinking that we need lock here, but then this is called with
> lock held, worth mentioning in the comment though..
Ok. Will add.

>=20
> > +static irqreturn_t xilinx_mcdma_irq_handler(int irq, void *data)
> > +{
> > +	struct xilinx_dma_chan *chan =3D data;
> > +	u32 status, ser_offset, chan_sermask, chan_offset =3D 0, chan_id;
> > +
> > +	if (chan->direction =3D=3D DMA_DEV_TO_MEM)
> > +		ser_offset =3D XILINX_MCDMA_RXINT_SER_OFFSET;
> > +	else
> > +		ser_offset =3D XILINX_MCDMA_TXINT_SER_OFFSET;
> > +
> > +	/* Read the channel id raising the interrupt*/
> > +	chan_sermask =3D dma_ctrl_read(chan, ser_offset);
> > +	chan_id =3D ffs(chan_sermask);
> > +
> > +	if (!chan_id)
> > +		return IRQ_NONE;
> > +
> > +	if (chan->direction =3D=3D DMA_DEV_TO_MEM)
> > +		chan_offset =3D XILINX_DMA_MAX_CHANS_PER_DEVICE / 2;
> > +
> > +	chan_offset =3D chan_offset + (chan_id - 1);
> > +	chan =3D chan->xdev->chan[chan_offset];
> > +	/* Read the status and ack the interrupts. */
> > +	status =3D dma_ctrl_read(chan,
> XILINX_MCDMA_CHAN_SR_OFFSET(chan->tdest));
> > +	if (!(status & XILINX_MCDMA_IRQ_ALL_MASK))
> > +		return IRQ_NONE;
> > +
> > +	dma_ctrl_write(chan, XILINX_MCDMA_CHAN_SR_OFFSET(chan-
> >tdest),
> > +		       status & XILINX_MCDMA_IRQ_ALL_MASK);
> > +
> > +	if (status & XILINX_MCDMA_IRQ_ERR_MASK) {
> > +		dev_err(chan->dev, "Channel %p has errors %x cdr %x tdr
> %x\n",
> > +			chan, dma_ctrl_read(chan,
> > +			XILINX_MCDMA_CH_ERR_OFFSET),
> dma_ctrl_read(chan,
> > +			XILINX_MCDMA_CHAN_CDESC_OFFSET(chan->tdest)),
> > +			dma_ctrl_read(chan,
> > +				      XILINX_MCDMA_CHAN_TDESC_OFFSET
> > +				      (chan->tdest)));
>=20
> this looks very hard to read, please start each dma_ctrl_read() from a
> new line to make it better

Ok . will change.
>=20
> > +		chan->err =3D true;
> > +	}
> > +
> > +	if (status & XILINX_MCDMA_IRQ_DELAY_MASK) {
> > +		/*
> > +		 * Device takes too long to do the transfer when user requires
> > +		 * responsiveness.
> > +		 */
> > +		dev_dbg(chan->dev, "Inter-packet latency too long\n");
>=20
> so we just log it..?
For now yes. It will be used later when MCDMA is used by the network client=
.

>=20
> > +	}
> > +
> > +	if (status & XILINX_MCDMA_IRQ_IOC_MASK) {
> > +		spin_lock(&chan->lock);
> > +		xilinx_dma_complete_descriptor(chan);
> > +		chan->idle =3D true;
> > +		chan->start_transfer(chan);
> > +		spin_unlock(&chan->lock);
> > +	}
> > +
> > +	tasklet_schedule(&chan->tasklet);
> > +	return IRQ_HANDLED;
> > +
>=20
> bogus empty line...
Will fix.
>=20
> > +static struct dma_async_tx_descriptor *xilinx_mcdma_prep_slave_sg(
> > +	struct dma_chan *dchan, struct scatterlist *sgl, unsigned int sg_len,
> > +	enum dma_transfer_direction direction, unsigned long flags,
> > +	void *context)
>=20
> indent is pretty bad here too :(
Will fix.
>=20
> > +{
> > +	struct xilinx_dma_chan *chan =3D to_xilinx_chan(dchan);
> > +	struct xilinx_dma_tx_descriptor *desc;
> > +	struct xilinx_aximcdma_tx_segment *segment =3D NULL;
> > +	u32 *app_w =3D (u32 *)context;
> > +	struct scatterlist *sg;
> > +	size_t copy;
> > +	size_t sg_used;
> > +	unsigned int i;
> > +
> > +	if (!is_slave_direction(direction))
> > +		return NULL;
> > +
> > +	/* Allocate a transaction descriptor. */
> > +	desc =3D xilinx_dma_alloc_tx_descriptor(chan);
> > +	if (!desc)
> > +		return NULL;
> > +
> > +	dma_async_tx_descriptor_init(&desc->async_tx, &chan->common);
> > +	desc->async_tx.tx_submit =3D xilinx_dma_tx_submit;
> > +
> > +	/* Build transactions using information in the scatter gather list */
> > +	for_each_sg(sgl, sg, sg_len, i) {
> > +		sg_used =3D 0;
> > +
> > +		/* Loop until the entire scatterlist entry is used */
> > +		while (sg_used < sg_dma_len(sg)) {
> > +			struct xilinx_aximcdma_desc_hw *hw;
> > +
> > +			/* Get a free segment */
> > +			segment =3D xilinx_aximcdma_alloc_tx_segment(chan);
> > +			if (!segment)
> > +				goto error;
> > +
> > +			/*
> > +			 * Calculate the maximum number of bytes to transfer,
> > +			 * making sure it is less than the hw limit
> > +			 */
> > +			copy =3D min_t(size_t, sg_dma_len(sg) - sg_used,
> > +				     XILINX_DMA_MAX_TRANS_LEN);
> > +			hw =3D &segment->hw;
> > +
> > +			/* Fill in the descriptor */
> > +			xilinx_aximcdma_buf(chan, hw, sg_dma_address(sg),
> > +					    sg_used);
> > +			hw->control =3D copy;
> > +
> > +			if (chan->direction =3D=3D DMA_MEM_TO_DEV) {
> > +				if (app_w)
>=20
> why not make condition as: chan->direction =3D=3D DMA_MEM_TO_DEV &&
> app_w
Ok . will change.

>=20
> > +					memcpy(hw->app, app_w, sizeof(u32)
> *
> > +					       XILINX_DMA_NUM_APP_WORDS);
> > +			}
> > +
> > +			sg_used +=3D copy;
> > +			/*
> > +			 * Insert the segment into the descriptor segments
> > +			 * list.
> > +			 */
> > +			list_add_tail(&segment->node, &desc->segments);
> > +		}
> > +	}
> > +
> > +	segment =3D list_first_entry(&desc->segments,
> > +				   struct xilinx_aximcdma_tx_segment, node);
> > +	desc->async_tx.phys =3D segment->phys;
> > +
> > +	/* For the last DMA_MEM_TO_DEV transfer, set EOP */
> > +	if (chan->direction =3D=3D DMA_MEM_TO_DEV) {
> > +		segment->hw.control |=3D XILINX_MCDMA_BD_SOP;
> > +		segment =3D list_last_entry(&desc->segments,
> > +					  struct xilinx_aximcdma_tx_segment,
> > +					  node);
> > +		segment->hw.control |=3D XILINX_MCDMA_BD_EOP;
> > +	}
> > +
> > +	return &desc->async_tx;
> > +
> > +error:
> > +	xilinx_dma_free_tx_descriptor(chan, desc);
>=20
> will it free the ones allocated here or all descriptors?

It will free single descriptor and all its segments.
>=20
> >  /**
> >   * xilinx_dma_prep_slave_sg - prepare descriptors for a DMA_SLAVE
> transaction
> > @@ -2422,12 +2827,16 @@ static int xilinx_dma_chan_probe(struct
> xilinx_dma_device *xdev,
> >
> >  	if (of_device_is_compatible(node, "xlnx,axi-vdma-mm2s-channel") ||
> >  	    of_device_is_compatible(node, "xlnx,axi-dma-mm2s-channel") ||
> > -	    of_device_is_compatible(node, "xlnx,axi-cdma-channel")) {
> > +	    of_device_is_compatible(node, "xlnx,axi-cdma-channel") ||
> > +	    of_device_is_compatible(node, "xlnx,axi-mcdma-mm2s-channel")) {
>=20
> this is not scaling, maybe you should use data with each
> compatible to check for specific things..
Yes, we can reuse axidma s2mm and mm2 channel nodes. MCDMA stuff can
be selectively programmed based on xilinx_dma_config.dmatype.

>=20
> > +static const struct xilinx_dma_config aximcdma_config =3D {
> > +	.dmatype =3D XDMA_TYPE_AXIMCDMA,
> > +	.clk_init =3D axidma_clk_init,
> > +	.irq_handler =3D xilinx_mcdma_irq_handler,
> > +};
> >  static const struct xilinx_dma_config axicdma_config =3D {
> >  	.dmatype =3D XDMA_TYPE_CDMA,
> >  	.clk_init =3D axicdma_clk_init,
> > +	.irq_handler =3D xilinx_dma_irq_handler,
>=20
> this should be in preparatory patch
Yes.
> --
> ~Vinod
