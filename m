Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932422AbeEWK0b (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 06:26:31 -0400
Received: from mail-ve1eur01on0077.outbound.protection.outlook.com ([104.47.1.77]:49760
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932391AbeEWK01 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 06:26:27 -0400
From: Robin Gong <yibin.gong@nxp.com>
To: "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC: "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "vinod.koul@intel.com" <vinod.koul@intel.com>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH v1] dma: imx-sdma: add virt-dma support
Thread-Topic: [PATCH v1] dma: imx-sdma: add virt-dma support
Thread-Index: AQHTwbZRQFd8gKZYyk6iiiOUnMCFSKQ75psAgAIdB4A=
Date: Wed, 23 May 2018 10:26:23 +0000
Message-ID: <1527099973.3990.37.camel@nxp.com>
References: <1521735499-29138-1-git-send-email-yibin.gong@nxp.com>
         <20180522100948.6xsq3unhyyyd7zz3@pengutronix.de>
In-Reply-To: <20180522100948.6xsq3unhyyyd7zz3@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.18.5.2-0ubuntu3.2 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR04MB2984;7:4gpOTWUiuJYIelROsSoLR7CV+XdKWJHkLiEFh+VAHjzBwObOv7MVHz3D78yt6JAt4iCc7XjinXldsImvOkMEE1yDdSyOZko+yr+AJgatmwDOhphUd5TB8uMNQaDL4Dxq2V63b3VTtIk1XXVMs1PQYApyC2bYsJYuRlATqyAWlLJAajTFa7CI4jO44xF+fCmh364msyJe21/lj4PpRA+j8+kheh0RAY4OPKkXUvmm+a6V3HyLex/CNmN1auoymjYI
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR04MB2984;
x-ms-traffictypediagnostic: DB6PR04MB2984:
x-microsoft-antispam-prvs: <DB6PR04MB2984B61B8E0E80C7473D616E896B0@DB6PR04MB2984.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(189930954265078)(185117386973197)(258649278758335)(45079756050767);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DB6PR04MB2984;BCL:0;PCL:0;RULEID:;SRVR:DB6PR04MB2984;
x-forefront-prvs: 06818431B9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39380400002)(366004)(376002)(39860400002)(346002)(189003)(199004)(377424004)(966005)(478600001)(2616005)(45080400002)(5640700003)(6486002)(3280700002)(186003)(105586002)(106356001)(305945005)(97736004)(14454004)(103116003)(66066001)(551934003)(26005)(3660700001)(6916009)(229853002)(6436002)(102836004)(11346002)(446003)(2351001)(76176011)(6116002)(3846002)(54906003)(5660300001)(86362001)(575784001)(316002)(81166006)(81156014)(68736007)(8676002)(50226002)(8936002)(476003)(36756003)(99286004)(486006)(2501003)(5250100002)(6246003)(59450400001)(2906002)(6306002)(25786009)(53946003)(6506007)(53936002)(6512007)(7736002)(2900100001)(4326008)(76704002)(99106002)(559001)(579004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR04MB2984;H:DB6PR04MB3223.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: NSxTD9cIsf77wdomaIA0ttPh6MGKEftTKDzHQVKttrJoqzkeNe/MmB7pFz3xiWj6xoxl/NSPRxXVhFJdFj2IE+n7y3QCf3GPQmA9ZNRPP3ALuiaRm+UclsMmAOT/k870q8eHJQhM4N9S2qRgUF1ALQGhE+ErA6PpFitZD9Nx0j6pIoZUarHPD/nI+NdA2Mke
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <76817B9741E99547AF5339BCD14EDD16@eurprd04.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 40f4b470-9345-46dd-3489-08d5c097a1f2
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40f4b470-9345-46dd-3489-08d5c097a1f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2018 10:26:23.1142
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB2984
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4NAQcnF018697

On 二, 2018-05-22 at 12:09 +0200, Sascha Hauer wrote:
> Hi Robin,
> 
> Several comments inside.
> 
> Sascha
> 
> On Fri, Mar 23, 2018 at 12:18:19AM +0800, Robin Gong wrote:
> > 
> > The legacy sdma driver has below limitations or drawbacks:
> >   1. Hardcode the max BDs number as "PAGE_SIZE / sizeof(*)", and
> > alloc
> >      one page size for one channel regardless of only few BDs
> > needed
> >      most time. But in few cases, the max PAGE_SIZE maybe not
> > enough.
> >   2. One SDMA channel can't stop immediatley once channel disabled
> > which
> >      means SDMA interrupt may come in after this channel
> > terminated.There
> >      are some patches for this corner case such as commit
> > "2746e2c389f9",
> >      but not cover non-cyclic.
> > 
> > The common virt-dma overcomes the above limitations. It can alloc
> > bd
> > dynamically and free bd once this tx transfer done. No memory
> > wasted or
> > maximum limititation here, only depends on how many memory can be
> > requested
> > from kernel. For No.2, such issue can be workaround by checking if
> > there
> > is available descript("sdmac->desc") now once the unwanted
> > interrupt
> > coming. At last the common virt-dma is easier for sdma driver
> > maintain.
> > 
> > Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> > ---
> >  drivers/dma/Kconfig    |   1 +
> >  drivers/dma/imx-sdma.c | 395 +++++++++++++++++++++++++++++++----
> > --------------
> >  2 files changed, 253 insertions(+), 143 deletions(-)
> > 
> > diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> > index 27df3e2..c4ce43c 100644
> > --- a/drivers/dma/Kconfig
> > +++ b/drivers/dma/Kconfig
> > @@ -247,6 +247,7 @@ config IMX_SDMA
> >  	tristate "i.MX SDMA support"
> >  	depends on ARCH_MXC
> >  	select DMA_ENGINE
> > +	select DMA_VIRTUAL_CHANNELS
> >  	help
> >  	  Support the i.MX SDMA engine. This engine is integrated
> > into
> >  	  Freescale i.MX25/31/35/51/53/6 chips.
> > diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> > index ccd03c3..df79e73 100644
> > --- a/drivers/dma/imx-sdma.c
> > +++ b/drivers/dma/imx-sdma.c
> > @@ -48,6 +48,7 @@
> >  #include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
> >  
> >  #include "dmaengine.h"
> > +#include "virt-dma.h"
> >  
> >  /* SDMA registers */
> >  #define SDMA_H_C0PTR		0x000
> > @@ -291,10 +292,19 @@ struct sdma_context_data {
> >  	u32  scratch7;
> >  } __attribute__ ((packed));
> >  
> > -#define NUM_BD (int)(PAGE_SIZE / sizeof(struct
> > sdma_buffer_descriptor))
> > -
> >  struct sdma_engine;
> >  
> > +struct sdma_desc {
> > +	struct virt_dma_desc	vd;
> > +	struct list_head	node;
> > +	unsigned int		num_bd;
> > +	dma_addr_t		bd_phys;
> > +	unsigned int		buf_tail;
> > +	unsigned int		buf_ptail;
> > +	struct sdma_channel	*sdmac;
> > +	struct sdma_buffer_descriptor *bd;
> > +};
> > +
> >  /**
> >   * struct sdma_channel - housekeeping for a SDMA channel
> >   *
> > @@ -310,19 +320,17 @@ struct sdma_engine;
> >   * @num_bd		max NUM_BD. number of descriptors
> > currently handling
> >   */
> >  struct sdma_channel {
> > +	struct virt_dma_chan		vc;
> > +	struct list_head		pending;
> >  	struct sdma_engine		*sdma;
> > +	struct sdma_desc		*desc;
> >  	unsigned int			channel;
> >  	enum dma_transfer_direction		direction;
> >  	enum sdma_peripheral_type	peripheral_type;
> >  	unsigned int			event_id0;
> >  	unsigned int			event_id1;
> >  	enum dma_slave_buswidth		word_size;
> > -	unsigned int			buf_tail;
> > -	unsigned int			buf_ptail;
> > -	unsigned int			num_bd;
> >  	unsigned int			period_len;
> > -	struct sdma_buffer_descriptor	*bd;
> > -	dma_addr_t			bd_phys;
> >  	unsigned int			pc_from_device,
> > pc_to_device;
> >  	unsigned int			device_to_device;
> >  	unsigned long			flags;
> > @@ -330,15 +338,12 @@ struct sdma_channel {
> >  	unsigned long			event_mask[2];
> >  	unsigned long			watermark_level;
> >  	u32				shp_addr, per_addr;
> > -	struct dma_chan			chan;
> > -	spinlock_t			lock;
> > -	struct dma_async_tx_descriptor	desc;
> >  	enum dma_status			status;
> >  	unsigned int			chn_count;
> >  	unsigned int			chn_real_count;
> > -	struct tasklet_struct		tasklet;
> >  	struct imx_dma_data		data;
> >  	bool				enabled;
> Usage of this variable is removed in this patch, but not the variable
> itself.
Yes, will remove the usless 'enabled' in v2.
> 
> > 
> > +	u32				bd_size_sum;
> This variable is never used for anything.
Yes, it's not for significative use but debug to see how many current
bds used.
> 
> > 
> >  };
> >  
> >  #define IMX_DMA_SG_LOOP		BIT(0)
> > @@ -398,6 +403,9 @@ struct sdma_engine {
> >  	u32				spba_start_addr;
> >  	u32				spba_end_addr;
> >  	unsigned int			irq;
> > +	/* channel0 bd */
> > +	dma_addr_t			bd0_phys;
> > +	struct sdma_buffer_descriptor	*bd0;
> >  };
> >  
> >  static struct sdma_driver_data sdma_imx31 = {
> > @@ -553,6 +561,8 @@ MODULE_DEVICE_TABLE(of, sdma_dt_ids);
> >  #define SDMA_H_CONFIG_ACR	BIT(4)  /* indicates if AHB freq
> > /core freq = 2 or 1 */
> >  #define SDMA_H_CONFIG_CSM	(3)       /* indicates which
> > context switch mode is selected*/
> >  
> > +static void sdma_start_desc(struct sdma_channel *sdmac);
> > +
> >  static inline u32 chnenbl_ofs(struct sdma_engine *sdma, unsigned
> > int event)
> >  {
> >  	u32 chnenbl0 = sdma->drvdata->chnenbl0;
> > @@ -597,14 +607,7 @@ static int sdma_config_ownership(struct
> > sdma_channel *sdmac,
> >  
> >  static void sdma_enable_channel(struct sdma_engine *sdma, int
> > channel)
> >  {
> > -	unsigned long flags;
> > -	struct sdma_channel *sdmac = &sdma->channel[channel];
> > -
> >  	writel(BIT(channel), sdma->regs + SDMA_H_START);
> > -
> > -	spin_lock_irqsave(&sdmac->lock, flags);
> > -	sdmac->enabled = true;
> > -	spin_unlock_irqrestore(&sdmac->lock, flags);
> >  }
> >  
> >  /*
> > @@ -632,7 +635,7 @@ static int sdma_run_channel0(struct sdma_engine
> > *sdma)
> >  static int sdma_load_script(struct sdma_engine *sdma, void *buf,
> > int size,
> >  		u32 address)
> >  {
> > -	struct sdma_buffer_descriptor *bd0 = sdma->channel[0].bd;
> > +	struct sdma_buffer_descriptor *bd0 = sdma->bd0;
> This change seems to be an orthogonal change. Please make this a
> separate patch.
It's something related with virtual dma support, because in virtual
dma framework, all bds should be allocated dynamically if they used.
but bd0 is a specail case since it's must and basic for load sdma
firmware and context for other channels. So here alloc 'bd0' for other
channels.
> 
> > 
> >  	void *buf_virt;
> >  	dma_addr_t buf_phys;
> >  	int ret;
> > @@ -691,23 +694,16 @@ static void sdma_event_disable(struct
> > sdma_channel *sdmac, unsigned int event)
> >  static void sdma_update_channel_loop(struct sdma_channel *sdmac)
> >  {
> >  	struct sdma_buffer_descriptor *bd;
> > +	struct sdma_desc *desc = sdmac->desc;
> >  	int error = 0;
> >  	enum dma_status	old_status = sdmac->status;
> > -	unsigned long flags;
> > -
> > -	spin_lock_irqsave(&sdmac->lock, flags);
> > -	if (!sdmac->enabled) {
> > -		spin_unlock_irqrestore(&sdmac->lock, flags);
> > -		return;
> > -	}
> > -	spin_unlock_irqrestore(&sdmac->lock, flags);
> >  
> >  	/*
> >  	 * loop mode. Iterate over descriptors, re-setup them and
> >  	 * call callback function.
> >  	 */
> > -	while (1) {
> > -		bd = &sdmac->bd[sdmac->buf_tail];
> > +	while (desc) {
> 'desc' seems to be used as a loop counter here, but this variable is
> never assigned another value, so I assume it's just another way to
> say
> "skip the loop if desc is NULL". When 'desc' NULL you won't get into
> this function at all though, so this check for desc seems rather
> pointless.
Good catch, should check 'sdmac->desc' here instead of 'desc' since in
the following 'sdmac->desc' may be set to NULL by sdma_terminate_all
during folllowing spin_unlock and spin_lock narrow window. Will improve
it in V2.
> 
> > 
> > +		bd = &desc->bd[desc->buf_tail];
> >  
> >  		if (bd->mode.status & BD_DONE)
> >  			break;
> > @@ -726,8 +722,8 @@ static void sdma_update_channel_loop(struct
> > sdma_channel *sdmac)
> >  		sdmac->chn_real_count = bd->mode.count;
> >  		bd->mode.status |= BD_DONE;
> >  		bd->mode.count = sdmac->period_len;
> > -		sdmac->buf_ptail = sdmac->buf_tail;
> > -		sdmac->buf_tail = (sdmac->buf_tail + 1) % sdmac-
> > >num_bd;
> > +		desc->buf_ptail = desc->buf_tail;
> > +		desc->buf_tail = (desc->buf_tail + 1) % desc-
> > >num_bd;
> >  
> >  		/*
> >  		 * The callback is called from the interrupt
> > context in order
> > @@ -735,15 +731,16 @@ static void sdma_update_channel_loop(struct
> > sdma_channel *sdmac)
> >  		 * SDMA transaction status by the time the client
> > tasklet is
> >  		 * executed.
> >  		 */
> > -
> > -		dmaengine_desc_get_callback_invoke(&sdmac->desc,
> > NULL);
> > +		spin_unlock(&sdmac->vc.lock);
> > +		dmaengine_desc_get_callback_invoke(&desc->vd.tx,
> > NULL);
> > +		spin_lock(&sdmac->vc.lock);
> >  
> >  		if (error)
> >  			sdmac->status = old_status;
> >  	}
> >  }
> >  
> > -static void mxc_sdma_handle_channel_normal(unsigned long data)
> > +static void mxc_sdma_handle_channel_normal(struct sdma_channel
> > *data)
> >  {
> >  	struct sdma_channel *sdmac = (struct sdma_channel *) data;
> >  	struct sdma_buffer_descriptor *bd;
> > @@ -754,8 +751,8 @@ static void
> > mxc_sdma_handle_channel_normal(unsigned long data)
> >  	 * non loop mode. Iterate over all descriptors, collect
> >  	 * errors and call callback function
> >  	 */
> > -	for (i = 0; i < sdmac->num_bd; i++) {
> > -		bd = &sdmac->bd[i];
> > +	for (i = 0; i < sdmac->desc->num_bd; i++) {
> > +		bd = &sdmac->desc->bd[i];
> >  
> >  		 if (bd->mode.status & (BD_DONE | BD_RROR))
> >  			error = -EIO;
> > @@ -766,10 +763,6 @@ static void
> > mxc_sdma_handle_channel_normal(unsigned long data)
> >  		sdmac->status = DMA_ERROR;
> >  	else
> >  		sdmac->status = DMA_COMPLETE;
> > -
> > -	dma_cookie_complete(&sdmac->desc);
> > -
> > -	dmaengine_desc_get_callback_invoke(&sdmac->desc, NULL);
> >  }
> >  
> >  static irqreturn_t sdma_int_handler(int irq, void *dev_id)
> > @@ -785,13 +778,24 @@ static irqreturn_t sdma_int_handler(int irq,
> > void *dev_id)
> >  	while (stat) {
> >  		int channel = fls(stat) - 1;
> >  		struct sdma_channel *sdmac = &sdma-
> > >channel[channel];
> > -
> > -		if (sdmac->flags & IMX_DMA_SG_LOOP)
> > -			sdma_update_channel_loop(sdmac);
> > -		else
> > -			tasklet_schedule(&sdmac->tasklet);
> > +		struct sdma_desc *desc;
> > +
> > +		spin_lock(&sdmac->vc.lock);
> > +		desc = sdmac->desc;
> > +		if (desc) {
> > +			if (sdmac->flags & IMX_DMA_SG_LOOP) {
> > +				sdma_update_channel_loop(sdmac);
> > +			} else {
> > +				mxc_sdma_handle_channel_normal(sdm
> > ac);
> > +				vchan_cookie_complete(&desc->vd);
> > +				if (!list_empty(&sdmac->pending))
> > +					list_del(&desc->node);
> What does this list_empty check protect you from? It looks like when
> the
> list really is empty then it's a bug in your internal driver logic.
Yes, no need here check local sdmac->pending since I directly start
setup next desc flowing in isr instead of local tasklet and virt_dma
framework will handle all lists such as desc_issued/desc_completed etc.
Will remove sdmac->pending in V2.
> 
> > 
> > +				 sdma_start_desc(sdmac);
> Whitespace damage here.
Will fix in V2.
> 
> > 
> > +			}
> > +		}
> >  
> >  		__clear_bit(channel, &stat);
> > +		spin_unlock(&sdmac->vc.lock);
> >  	}
> >  
> >  	return IRQ_HANDLED;
> > @@ -897,7 +901,7 @@ static int sdma_load_context(struct
> > sdma_channel *sdmac)
> >  	int channel = sdmac->channel;
> >  	int load_address;
> >  	struct sdma_context_data *context = sdma->context;
> > -	struct sdma_buffer_descriptor *bd0 = sdma->channel[0].bd;
> > +	struct sdma_buffer_descriptor *bd0 = sdma->bd0;
> >  	int ret;
> >  	unsigned long flags;
> >  
> > @@ -946,7 +950,7 @@ static int sdma_load_context(struct
> > sdma_channel *sdmac)
> >  
> >  static struct sdma_channel *to_sdma_chan(struct dma_chan *chan)
> >  {
> > -	return container_of(chan, struct sdma_channel, chan);
> > +	return container_of(chan, struct sdma_channel, vc.chan);
> >  }
> >  
> >  static int sdma_disable_channel(struct dma_chan *chan)
> > @@ -954,15 +958,10 @@ static int sdma_disable_channel(struct
> > dma_chan *chan)
> >  	struct sdma_channel *sdmac = to_sdma_chan(chan);
> >  	struct sdma_engine *sdma = sdmac->sdma;
> >  	int channel = sdmac->channel;
> > -	unsigned long flags;
> >  
> >  	writel_relaxed(BIT(channel), sdma->regs +
> > SDMA_H_STATSTOP);
> >  	sdmac->status = DMA_ERROR;
> >  
> > -	spin_lock_irqsave(&sdmac->lock, flags);
> > -	sdmac->enabled = false;
> > -	spin_unlock_irqrestore(&sdmac->lock, flags);
> > -
> >  	return 0;
> >  }
> >  
> > @@ -1097,42 +1096,101 @@ static int
> > sdma_set_channel_priority(struct sdma_channel *sdmac,
> >  	return 0;
> >  }
> >  
> > -static int sdma_request_channel(struct sdma_channel *sdmac)
> > +static int sdma_alloc_bd(struct sdma_desc *desc)
> >  {
> > -	struct sdma_engine *sdma = sdmac->sdma;
> > -	int channel = sdmac->channel;
> > -	int ret = -EBUSY;
> > +	u32 bd_size = desc->num_bd * sizeof(struct
> > sdma_buffer_descriptor);
> > +	int ret = 0;
> > +	unsigned long flags;
> >  
> > -	sdmac->bd = dma_zalloc_coherent(NULL, PAGE_SIZE, &sdmac-
> > >bd_phys,
> > +	desc->bd = dma_zalloc_coherent(NULL, bd_size, &desc-
> > >bd_phys,
> >  					GFP_KERNEL);
> > -	if (!sdmac->bd) {
> > +	if (!desc->bd) {
> >  		ret = -ENOMEM;
> >  		goto out;
> >  	}
> >  
> > -	sdma->channel_control[channel].base_bd_ptr = sdmac-
> > >bd_phys;
> > -	sdma->channel_control[channel].current_bd_ptr = sdmac-
> > >bd_phys;
> > +	spin_lock_irqsave(&desc->sdmac->vc.lock, flags);
> > +	desc->sdmac->bd_size_sum += bd_size;
> > +	spin_unlock_irqrestore(&desc->sdmac->vc.lock, flags);
> >  
> > -	sdma_set_channel_priority(sdmac,
> > MXC_SDMA_DEFAULT_PRIORITY);
> > -	return 0;
> >  out:
> > -
> >  	return ret;
> >  }
> >  
> > -static dma_cookie_t sdma_tx_submit(struct dma_async_tx_descriptor
> > *tx)
> > +static void sdma_free_bd(struct sdma_desc *desc)
> >  {
> > +	u32 bd_size = desc->num_bd * sizeof(struct
> > sdma_buffer_descriptor);
> >  	unsigned long flags;
> > -	struct sdma_channel *sdmac = to_sdma_chan(tx->chan);
> > -	dma_cookie_t cookie;
> >  
> > -	spin_lock_irqsave(&sdmac->lock, flags);
> > +	if (desc->bd) {
> > +		dma_free_coherent(NULL, bd_size, desc->bd, desc-
> > >bd_phys);
> > +
> > +		spin_lock_irqsave(&desc->sdmac->vc.lock, flags);
> > +		desc->sdmac->bd_size_sum -= bd_size;
> > +		spin_unlock_irqrestore(&desc->sdmac->vc.lock,
> > flags);
> > +	}
> > +}
> > +
> > +static int sdma_request_channel0(struct sdma_engine *sdma)
> > +{
> > +	int ret = 0;
> > +
> > +	sdma->bd0 = dma_zalloc_coherent(NULL, PAGE_SIZE, &sdma-
> > >bd0_phys,
> > +					GFP_KERNEL);
> > +	if (!sdma->bd0) {
> > +		ret = -ENOMEM;
> > +		goto out;
> > +	}
> >  
> > -	cookie = dma_cookie_assign(tx);
> > +	sdma->channel_control[0].base_bd_ptr = sdma->bd0_phys;
> > +	sdma->channel_control[0].current_bd_ptr = sdma->bd0_phys;
> >  
> > -	spin_unlock_irqrestore(&sdmac->lock, flags);
> > +	sdma_set_channel_priority(&sdma->channel[0],
> > MXC_SDMA_DEFAULT_PRIORITY);
> > +out:
> >  
> > -	return cookie;
> > +	return ret;
> > +}
> > +
> > +static struct sdma_desc *to_sdma_desc(struct
> > dma_async_tx_descriptor *t)
> > +{
> > +	return container_of(t, struct sdma_desc, vd.tx);
> > +}
> > +
> > +static void sdma_desc_free(struct virt_dma_desc *vd)
> > +{
> > +	struct sdma_desc *desc = container_of(vd, struct
> > sdma_desc, vd);
> > +
> > +	if (desc) {
> Depending on the position of 'vd' in struct sdma_desc 'desc' will
> always
> be non-NULL, even if 'vd' is NULL.
> 
> I think this test is unnecessary since this function should never be
> called with an invalid pointer. If it is, then the caller really
> deserved the resulting crash.
Yes, will remove it.
> 
> > 
> > +		sdma_free_bd(desc);
> > +		kfree(desc);
> > +	}
> > +}
> > +
> > +static int sdma_terminate_all(struct dma_chan *chan)
> > +{
> > +	struct sdma_channel *sdmac = to_sdma_chan(chan);
> > +	unsigned long flags;
> > +	LIST_HEAD(head);
> > +
> > +	spin_lock_irqsave(&sdmac->vc.lock, flags);
> > +	vchan_get_all_descriptors(&sdmac->vc, &head);
> > +	while (!list_empty(&sdmac->pending)) {
> > +		struct sdma_desc *desc = list_first_entry(&sdmac-
> > >pending,
> > +			struct sdma_desc, node);
> > +
> > +		 list_del(&desc->node);
> > +		 spin_unlock_irqrestore(&sdmac->vc.lock, flags);
> > +		 sdmac->vc.desc_free(&desc->vd);
> > +		 spin_lock_irqsave(&sdmac->vc.lock, flags);
> > +	}
> list_for_each_entry_safe?
Will remove here all while(sdmac->pending) checking.No need here. 
> 
> > 
> > +
> > +	if (sdmac->desc)
> > +		sdmac->desc = NULL;
> The test is unnecesary.
This 'NULL' is meaningful in case that dma done interrupt come after
terminate as you know sdma will actually stop after current transfer
done.
> > 
> > +	spin_unlock_irqrestore(&sdmac->vc.lock, flags);
> > +	vchan_dma_desc_free_list(&sdmac->vc, &head);
> > +	sdma_disable_channel_with_delay(chan);
> > +
> > +	return 0;
> >  }
> >  
> >  static int sdma_alloc_chan_resources(struct dma_chan *chan)
> > @@ -1168,18 +1226,11 @@ static int sdma_alloc_chan_resources(struct
> > dma_chan *chan)
> >  	if (ret)
> >  		goto disable_clk_ipg;
> >  
> > -	ret = sdma_request_channel(sdmac);
> > -	if (ret)
> > -		goto disable_clk_ahb;
> > -
> >  	ret = sdma_set_channel_priority(sdmac, prio);
> >  	if (ret)
> >  		goto disable_clk_ahb;
> >  
> > -	dma_async_tx_descriptor_init(&sdmac->desc, chan);
> > -	sdmac->desc.tx_submit = sdma_tx_submit;
> > -	/* txd.flags will be overwritten in prep funcs */
> > -	sdmac->desc.flags = DMA_CTRL_ACK;
> > +	sdmac->bd_size_sum = 0;
> >  
> >  	return 0;
> >  
> > @@ -1195,7 +1246,7 @@ static void sdma_free_chan_resources(struct
> > dma_chan *chan)
> >  	struct sdma_channel *sdmac = to_sdma_chan(chan);
> >  	struct sdma_engine *sdma = sdmac->sdma;
> >  
> > -	sdma_disable_channel(chan);
> > +	sdma_terminate_all(chan);
> >  
> >  	if (sdmac->event_id0)
> >  		sdma_event_disable(sdmac, sdmac->event_id0);
> > @@ -1207,12 +1258,43 @@ static void sdma_free_chan_resources(struct
> > dma_chan *chan)
> >  
> >  	sdma_set_channel_priority(sdmac, 0);
> >  
> > -	dma_free_coherent(NULL, PAGE_SIZE, sdmac->bd, sdmac-
> > >bd_phys);
> > -
> >  	clk_disable(sdma->clk_ipg);
> >  	clk_disable(sdma->clk_ahb);
> >  }
> >  
> > +static struct sdma_desc *sdma_transfer_init(struct sdma_channel
> > *sdmac,
> > +				enum dma_transfer_direction
> > direction, u32 bds)
> > +{
> > +	struct sdma_desc *desc;
> > +
> > +	desc = kzalloc((sizeof(*desc)), GFP_KERNEL);
> > +	if (!desc)
> > +		goto err_out;
> > +
> > +	sdmac->status = DMA_IN_PROGRESS;
> > +	sdmac->direction = direction;
> > +	sdmac->flags = 0;
> > +	sdmac->chn_count = 0;
> > +	sdmac->chn_real_count = 0;
> > +
> > +	desc->sdmac = sdmac;
> > +	desc->num_bd = bds;
> > +	INIT_LIST_HEAD(&desc->node);
> > +
> > +	if (sdma_alloc_bd(desc))
> > +		goto err_desc_out;
> > +
> > +	if (sdma_load_context(sdmac))
> > +		goto err_desc_out;
> > +
> > +	return desc;
> > +
> > +err_desc_out:
> > +	kfree(desc);
> > +err_out:
> > +	return NULL;
> > +}
> > +
> >  static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
> >  		struct dma_chan *chan, struct scatterlist *sgl,
> >  		unsigned int sg_len, enum dma_transfer_direction
> > direction,
> > @@ -1223,35 +1305,24 @@ static struct dma_async_tx_descriptor
> > *sdma_prep_slave_sg(
> >  	int ret, i, count;
> >  	int channel = sdmac->channel;
> >  	struct scatterlist *sg;
> > +	struct sdma_desc *desc;
> >  
> > -	if (sdmac->status == DMA_IN_PROGRESS)
> > +	if (!chan)
> >  		return NULL;
> > -	sdmac->status = DMA_IN_PROGRESS;
> > -
> > -	sdmac->flags = 0;
> >  
> > -	sdmac->buf_tail = 0;
> > -	sdmac->buf_ptail = 0;
> > -	sdmac->chn_real_count = 0;
> > +	desc = sdma_transfer_init(sdmac, direction, sg_len);
> > +	if (!desc)
> > +		goto err_out;
> >  
> >  	dev_dbg(sdma->dev, "setting up %d entries for channel
> > %d.\n",
> >  			sg_len, channel);
> >  
> > -	sdmac->direction = direction;
> >  	ret = sdma_load_context(sdmac);
> >  	if (ret)
> >  		goto err_out;
> >  
> > -	if (sg_len > NUM_BD) {
> > -		dev_err(sdma->dev, "SDMA channel %d: maximum
> > number of sg exceeded: %d > %d\n",
> > -				channel, sg_len, NUM_BD);
> > -		ret = -EINVAL;
> > -		goto err_out;
> > -	}
> > -
> > -	sdmac->chn_count = 0;
> >  	for_each_sg(sgl, sg, sg_len, i) {
> > -		struct sdma_buffer_descriptor *bd = &sdmac->bd[i];
> > +		struct sdma_buffer_descriptor *bd = &desc->bd[i];
> >  		int param;
> >  
> >  		bd->buffer_addr = sg->dma_address;
> > @@ -1262,7 +1333,7 @@ static struct dma_async_tx_descriptor
> > *sdma_prep_slave_sg(
> >  			dev_err(sdma->dev, "SDMA channel %d:
> > maximum bytes for sg entry exceeded: %d > %d\n",
> >  					channel, count, 0xffff);
> >  			ret = -EINVAL;
> > -			goto err_out;
> > +			goto err_bd_out;
> >  		}
> >  
> >  		bd->mode.count = count;
> > @@ -1307,10 +1378,11 @@ static struct dma_async_tx_descriptor
> > *sdma_prep_slave_sg(
> >  		bd->mode.status = param;
> >  	}
> >  
> > -	sdmac->num_bd = sg_len;
> > -	sdma->channel_control[channel].current_bd_ptr = sdmac-
> > >bd_phys;
> > +	return vchan_tx_prep(&sdmac->vc, &desc->vd, flags);
> >  
> > -	return &sdmac->desc;
> > +err_bd_out:
> > +	sdma_free_bd(desc);
> > +	kfree(desc);
> >  err_out:
> >  	sdmac->status = DMA_ERROR;
> >  	return NULL;
> > @@ -1326,39 +1398,32 @@ static struct dma_async_tx_descriptor
> > *sdma_prep_dma_cyclic(
> >  	int num_periods = buf_len / period_len;
> >  	int channel = sdmac->channel;
> >  	int ret, i = 0, buf = 0;
> > +	struct sdma_desc *desc;
> >  
> >  	dev_dbg(sdma->dev, "%s channel: %d\n", __func__, channel);
> >  
> > -	if (sdmac->status == DMA_IN_PROGRESS)
> > -		return NULL;
> > -
> > -	sdmac->status = DMA_IN_PROGRESS;
> > +	/* Now allocate and setup the descriptor. */
> > +	desc = sdma_transfer_init(sdmac, direction, num_periods);
> > +	if (!desc)
> > +		goto err_out;
> >  
> > -	sdmac->buf_tail = 0;
> > -	sdmac->buf_ptail = 0;
> > -	sdmac->chn_real_count = 0;
> > +	desc->buf_tail = 0;
> > +	desc->buf_ptail = 0;
> >  	sdmac->period_len = period_len;
> > -
> >  	sdmac->flags |= IMX_DMA_SG_LOOP;
> > -	sdmac->direction = direction;
> > +
> >  	ret = sdma_load_context(sdmac);
> >  	if (ret)
> >  		goto err_out;
> >  
> > -	if (num_periods > NUM_BD) {
> > -		dev_err(sdma->dev, "SDMA channel %d: maximum
> > number of sg exceeded: %d > %d\n",
> > -				channel, num_periods, NUM_BD);
> > -		goto err_out;
> > -	}
> > -
> >  	if (period_len > 0xffff) {
> >  		dev_err(sdma->dev, "SDMA channel %d: maximum
> > period size exceeded: %zu > %d\n",
> >  				channel, period_len, 0xffff);
> > -		goto err_out;
> > +		goto err_bd_out;
> >  	}
> >  
> >  	while (buf < buf_len) {
> > -		struct sdma_buffer_descriptor *bd = &sdmac->bd[i];
> > +		struct sdma_buffer_descriptor *bd = &desc->bd[i];
> >  		int param;
> >  
> >  		bd->buffer_addr = dma_addr;
> > @@ -1366,7 +1431,7 @@ static struct dma_async_tx_descriptor
> > *sdma_prep_dma_cyclic(
> >  		bd->mode.count = period_len;
> >  
> >  		if (sdmac->word_size > DMA_SLAVE_BUSWIDTH_4_BYTES)
> > -			goto err_out;
> > +			goto err_bd_out;
> >  		if (sdmac->word_size ==
> > DMA_SLAVE_BUSWIDTH_4_BYTES)
> >  			bd->mode.command = 0;
> >  		else
> > @@ -1389,10 +1454,10 @@ static struct dma_async_tx_descriptor
> > *sdma_prep_dma_cyclic(
> >  		i++;
> >  	}
> >  
> > -	sdmac->num_bd = num_periods;
> > -	sdma->channel_control[channel].current_bd_ptr = sdmac-
> > >bd_phys;
> > -
> > -	return &sdmac->desc;
> > +	return vchan_tx_prep(&sdmac->vc, &desc->vd, flags);
> > +err_bd_out:
> > +	sdma_free_bd(desc);
> > +	kfree(desc);
> >  err_out:
> >  	sdmac->status = DMA_ERROR;
> >  	return NULL;
> > @@ -1432,26 +1497,74 @@ static enum dma_status
> > sdma_tx_status(struct dma_chan *chan,
> >  {
> >  	struct sdma_channel *sdmac = to_sdma_chan(chan);
> >  	u32 residue;
> > +	struct virt_dma_desc *vd;
> > +	struct sdma_desc *desc;
> > +	enum dma_status ret;
> > +	unsigned long flags;
> >  
> > -	if (sdmac->flags & IMX_DMA_SG_LOOP)
> > -		residue = (sdmac->num_bd - sdmac->buf_ptail) *
> > +	ret = dma_cookie_status(chan, cookie, txstate);
> > +	if (ret == DMA_COMPLETE && txstate) {
> > +		residue = sdmac->chn_count - sdmac-
> > >chn_real_count;
> > +		return ret;
> > +	}
> > +
> > +	spin_lock_irqsave(&sdmac->vc.lock, flags);
> > +	vd = vchan_find_desc(&sdmac->vc, cookie);
> > +	desc = to_sdma_desc(&vd->tx);
> You should use 'vd' only after you have made sure it is valid (though
> I
> see it causes no harm in this case, but let's be nice to the readers
> of
> this code)
Ok, will move desc = to_sdma_desc(&vd->tx) into the below if(vd)... 
> 
> > 
> > +	if (vd) {
> > +		if (sdmac->flags & IMX_DMA_SG_LOOP)
> > +			residue = (desc->num_bd - desc->buf_ptail) 
> > *
> >  			   sdmac->period_len - sdmac-
> > >chn_real_count;
> > -	else
> > +		else
> > +			residue = sdmac->chn_count - sdmac-
> > >chn_real_count;
> > +	} else if (sdmac->desc && sdmac->desc->vd.tx.cookie ==
> > cookie) {
> >  		residue = sdmac->chn_count - sdmac-
> > >chn_real_count;
> > +	} else {
> > +		residue = 0;
> > +	}
> > +	ret = sdmac->status;
> > +	spin_unlock_irqrestore(&sdmac->vc.lock, flags);
> >  
> >  	dma_set_tx_state(txstate, chan->completed_cookie, chan-
> > >cookie,
> >  			 residue);
> >  
> > -	return sdmac->status;
> > +	return ret;
> > +}
> > +
> > +static void sdma_start_desc(struct sdma_channel *sdmac)
> > +{
> > +	struct virt_dma_desc *vd = vchan_next_desc(&sdmac->vc);
> > +	struct sdma_desc *desc;
> > +	struct sdma_engine *sdma = sdmac->sdma;
> > +	int channel = sdmac->channel;
> > +
> > +	if (!vd) {
> > +		sdmac->desc = NULL;
> > +		return;
> > +	}
> > +	sdmac->desc = desc = to_sdma_desc(&vd->tx);
> > +	/*
> > +	 * Do not delete the node in desc_issued list in cyclic
> > mode, otherwise
> > +	 * the desc alloced will never be freed in
> > vchan_dma_desc_free_list
> > +	 */
> > +	if (!(sdmac->flags & IMX_DMA_SG_LOOP)) {
> > +		list_add_tail(&sdmac->desc->node, &sdmac-
> > >pending);
> > +		list_del(&vd->node);
> > +	}
> > +	sdma->channel_control[channel].base_bd_ptr = desc-
> > >bd_phys;
> > +	sdma->channel_control[channel].current_bd_ptr = desc-
> > >bd_phys;
> > +	sdma_enable_channel(sdma, sdmac->channel);
> >  }
> >  
> >  static void sdma_issue_pending(struct dma_chan *chan)
> >  {
> >  	struct sdma_channel *sdmac = to_sdma_chan(chan);
> > -	struct sdma_engine *sdma = sdmac->sdma;
> > +	unsigned long flags;
> >  
> > -	if (sdmac->status == DMA_IN_PROGRESS)
> > -		sdma_enable_channel(sdma, sdmac->channel);
> > +	spin_lock_irqsave(&sdmac->vc.lock, flags);
> > +	if (vchan_issue_pending(&sdmac->vc) && !sdmac->desc)
> > +		sdma_start_desc(sdmac);
> > +	spin_unlock_irqrestore(&sdmac->vc.lock, flags);
> >  }
> >  
> >  #define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V1	34
> > @@ -1657,7 +1770,7 @@ static int sdma_init(struct sdma_engine
> > *sdma)
> >  	for (i = 0; i < MAX_DMA_CHANNELS; i++)
> >  		writel_relaxed(0, sdma->regs + SDMA_CHNPRI_0 + i *
> > 4);
> >  
> > -	ret = sdma_request_channel(&sdma->channel[0]);
> > +	ret = sdma_request_channel0(sdma);
> >  	if (ret)
> >  		goto err_dma_alloc;
> >  
> > @@ -1819,22 +1932,17 @@ static int sdma_probe(struct
> > platform_device *pdev)
> >  		struct sdma_channel *sdmac = &sdma->channel[i];
> >  
> >  		sdmac->sdma = sdma;
> > -		spin_lock_init(&sdmac->lock);
> > -
> > -		sdmac->chan.device = &sdma->dma_device;
> > -		dma_cookie_init(&sdmac->chan);
> >  		sdmac->channel = i;
> > -
> > -		tasklet_init(&sdmac->tasklet,
> > mxc_sdma_handle_channel_normal,
> > -			     (unsigned long) sdmac);
> > +		sdmac->status = DMA_IN_PROGRESS;
> > +		sdmac->vc.desc_free = sdma_desc_free;
> > +		INIT_LIST_HEAD(&sdmac->pending);
> >  		/*
> >  		 * Add the channel to the DMAC list. Do not add
> > channel 0 though
> >  		 * because we need it internally in the SDMA
> > driver. This also means
> >  		 * that channel 0 in dmaengine counting matches
> > sdma channel 1.
> >  		 */
> >  		if (i)
> > -			list_add_tail(&sdmac->chan.device_node,
> > -					&sdma-
> > >dma_device.channels);
> > +			vchan_init(&sdmac->vc, &sdma->dma_device);
> >  	}
> >  
> >  	ret = sdma_init(sdma);
> > @@ -1879,7 +1987,7 @@ static int sdma_probe(struct platform_device
> > *pdev)
> >  	sdma->dma_device.device_prep_slave_sg =
> > sdma_prep_slave_sg;
> >  	sdma->dma_device.device_prep_dma_cyclic =
> > sdma_prep_dma_cyclic;
> >  	sdma->dma_device.device_config = sdma_config;
> > -	sdma->dma_device.device_terminate_all =
> > sdma_disable_channel_with_delay;
> > +	sdma->dma_device.device_terminate_all =
> > sdma_terminate_all;
> >  	sdma->dma_device.src_addr_widths = SDMA_DMA_BUSWIDTHS;
> >  	sdma->dma_device.dst_addr_widths = SDMA_DMA_BUSWIDTHS;
> >  	sdma->dma_device.directions = SDMA_DMA_DIRECTIONS;
> > @@ -1939,7 +2047,8 @@ static int sdma_remove(struct platform_device
> > *pdev)
> >  	for (i = 0; i < MAX_DMA_CHANNELS; i++) {
> >  		struct sdma_channel *sdmac = &sdma->channel[i];
> >  
> > -		tasklet_kill(&sdmac->tasklet);
> > +		tasklet_kill(&sdmac->vc.task);
> > +		sdma_free_chan_resources(&sdmac->vc.chan);
> >  	}
> >  
> >  	platform_set_drvdata(pdev, NULL);
> > -- 
> > 2.7.4
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fl
> > ists.infradead.org%2Fmailman%2Flistinfo%2Flinux-arm-
> > kernel&data=02%7C01%7Cyibin.gong%40nxp.com%7C3323f6aae75e45a3155f08
> > d5bfcc314f%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63662580608
> > 2347660&sdata=5eDirTg4boJfw0zu320d9GZTeeDwnfCPfHFY8HXt1nI%3D&reserv
> > ed=0
> > 
