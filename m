Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753314AbeDQMsT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 08:48:19 -0400
Received: from mail-sn1nam02on0054.outbound.protection.outlook.com ([104.47.36.54]:33180
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752796AbeDQMsR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 08:48:17 -0400
From: Radhey Shyam Pandey <radheys@xilinx.com>
To: Vinod Koul <vinod.koul@intel.com>
CC: "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "Appana Durga Kedareswara Rao" <appanad@xilinx.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "'RADHEYCS@GMAIL.COM'" <RADHEYCS@GMAIL.COM>
Subject: RE: [RFC 5/6] dmaengine: xilinx_dma: Program interrupt delay timeout
Thread-Topic: [RFC 5/6] dmaengine: xilinx_dma: Program interrupt delay timeout
Thread-Index: AQHTym7m/FvHP37H0EyBh1KYjLHUhaP7VWyAgAmlbQA=
Date: Tue, 17 Apr 2018 12:48:14 +0000
Message-ID: <BN6PR02MB3282D496EC4D004A5CE37570C7B70@BN6PR02MB3282.namprd02.prod.outlook.com>
References: <1522665546-10035-1-git-send-email-radheys@xilinx.com>
 <1522665546-10035-6-git-send-email-radheys@xilinx.com>
 <20180411091159.GA6014@localhost>
In-Reply-To: <20180411091159.GA6014@localhost>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=radheys@xilinx.com;
x-originating-ip: [182.72.145.30]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR02MB2324;7:hOXhX/c09VC3NmJTMCklXrSbnSwS0OiK8Y4mwNhza9iq2T3nDNve3Zszqt485tb95Za4EcMabcAOKnfGim1k1wvSgqc8fur53A9GoYkF2S3Wgh+6iFrq6Sxohswzgv3yemI02uJTmrA0vJEmJVygQBNRnRAWjeNokWZ/rJL8oWFLAksJwj0v80zulVrbq1rdWY09vIGOGVRLRbZ9y9Qvn+JIhzX7ot3mJ20HluQBH1oCfJ5QTQDQix/Q72neA4/j
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(366004)(346002)(396003)(39860400002)(39380400002)(376002)(13464003)(199004)(189003)(54906003)(105586002)(3280700002)(2906002)(25786009)(68736007)(33656002)(5250100002)(26005)(4326008)(7736002)(3846002)(102836004)(6116002)(316002)(66066001)(305945005)(3660700001)(14454004)(186003)(2900100001)(74316002)(97736004)(99286004)(55016002)(6436002)(53546011)(6506007)(55236004)(6916009)(59450400001)(486006)(7696005)(76176011)(106356001)(229853002)(478600001)(6246003)(81166006)(86362001)(81156014)(39060400002)(8676002)(8936002)(53936002)(11346002)(446003)(476003)(9686003)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR02MB2324;H:BN6PR02MB3282.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:BN6PR02MB2324;
x-ms-traffictypediagnostic: BN6PR02MB2324:
x-microsoft-antispam-prvs: <BN6PR02MB23246214A7680019705AFC1DC7B70@BN6PR02MB2324.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(258649278758335)(192813158149592)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231232)(944501327)(52105095)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:BN6PR02MB2324;BCL:0;PCL:0;RULEID:;SRVR:BN6PR02MB2324;
x-forefront-prvs: 0645BEB7AA
x-microsoft-antispam-message-info: BqVQ+ep9CfvUT1bipLXAPay1oYrhLX93GaXFcDtFvdG5EnpoUIyiijR2mAzX9+QX1LyIFzJVNcUZbIrdOPEwLU+IALJH1vSn++xKT4/TM4wZNgyJeiajizolW2e2BjylOQooD+UeHpH2ZN+DxMky+tiyzwgSc0G66+cbwNKhqAEDkydyLBrAKHOYhr4MPmrn
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: d40c657b-c2dd-45c1-5d22-08d5a4617c42
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d40c657b-c2dd-45c1-5d22-08d5a4617c42
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2018 12:48:14.5675
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2324
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3HCmNPl015514

Hi Vinod,

> -----Original Message-----
> From: Vinod Koul [mailto:vinod.koul@intel.com]
> Sent: Wednesday, April 11, 2018 2:42 PM
> To: Radhey Shyam Pandey <radheys@xilinx.com>
> Cc: dan.j.williams@intel.com; michal.simek@xilinx.com; Appana Durga
> Kedareswara Rao <appanad@xilinx.com>; Radhey Shyam Pandey
> <radheys@xilinx.com>; lars@metafoo.de; dmaengine@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: Re: [RFC 5/6] dmaengine: xilinx_dma: Program interrupt delay
> timeout
> 
> On Mon, Apr 02, 2018 at 04:09:05PM +0530, Radhey Shyam Pandey wrote:
> > Program IRQDelay for AXI DMA. The interrupt timeout mechanism causes
> > the DMA engine to generate an interrupt after the delay time period
> > has expired. It enables dmaengine to respond in real-time even though
> > interrupt coalescing is configured.
> 
> again you are doing this only for axieth_connected, why is that?
The initial application was axieth but yes delay timeout feature may
be needed for other use cases as well. We can make delay timeout
an optional DT property. Is that fine? 

> 
> >
> > Signed-off-by: Radhey Shyam Pandey <radheys@xilinx.com>
> > ---
> >  drivers/dma/xilinx/xilinx_dma.c |   16 ++++++++++++++--
> >  1 files changed, 14 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/dma/xilinx/xilinx_dma.c
> b/drivers/dma/xilinx/xilinx_dma.c
> > index 518465e..ab8f1b0 100644
> > --- a/drivers/dma/xilinx/xilinx_dma.c
> > +++ b/drivers/dma/xilinx/xilinx_dma.c
> > @@ -161,8 +161,12 @@
> >  /* AXI DMA Specific Masks/Bit fields */
> >  #define XILINX_DMA_MAX_TRANS_LEN	GENMASK(22, 0)
> >  #define XILINX_DMA_CR_COALESCE_MAX	GENMASK(23, 16)
> > +#define XILINX_DMA_CR_DELAY_MAX		GENMASK(31, 24)
> >  #define XILINX_DMA_CR_CYCLIC_BD_EN_MASK	BIT(4)
> >  #define XILINX_DMA_CR_COALESCE_SHIFT	16
> > +#define XILINX_DMA_CR_DELAY_SHIFT	24
> > +#define XILINX_DMA_CR_WAITBOUND_DFT	254
> > +
> >  #define XILINX_DMA_BD_SOP		BIT(27)
> >  #define XILINX_DMA_BD_EOP		BIT(26)
> >  #define XILINX_DMA_COALESCE_MAX		255
> > @@ -1294,6 +1298,12 @@ static void xilinx_dma_start_transfer(struct
> xilinx_dma_chan *chan)
> >  		reg &= ~XILINX_DMA_CR_COALESCE_MAX;
> >  		reg |= chan->desc_pendingcount <<
> >  				  XILINX_DMA_CR_COALESCE_SHIFT;
> > +
> > +		if (chan->xdev->has_axieth_connected) {
> > +			reg  &= ~XILINX_DMA_CR_DELAY_MAX;
> > +			reg  |= XILINX_DMA_CR_WAITBOUND_DFT <<
> > +					XILINX_DMA_CR_DELAY_SHIFT;
> > +		}
> >  		dma_ctrl_write(chan, XILINX_DMA_REG_DMACR, reg);
> >  	}
> >
> > @@ -1508,7 +1518,8 @@ static irqreturn_t xilinx_dma_irq_handler(int irq,
> void *data)
> >  		}
> >  	}
> >
> > -	if (status & XILINX_DMA_DMASR_DLY_CNT_IRQ) {
> > +	if (!chan->xdev->has_axieth_connected && (status &
> > +			XILINX_DMA_DMASR_DLY_CNT_IRQ)) {
> >  		/*
> >  		 * Device takes too long to do the transfer when user
> requires
> >  		 * responsiveness.
> > @@ -1516,7 +1527,8 @@ static irqreturn_t xilinx_dma_irq_handler(int irq,
> void *data)
> >  		dev_dbg(chan->dev, "Inter-packet latency too long\n");
> >  	}
> >
> > -	if (status & XILINX_DMA_DMASR_FRM_CNT_IRQ) {
> > +	if (status & (XILINX_DMA_DMASR_FRM_CNT_IRQ |
> > +		      XILINX_DMA_DMASR_DLY_CNT_IRQ)) {
> >  		spin_lock(&chan->lock);
> >  		xilinx_dma_complete_descriptor(chan);
> >  		chan->idle = true;
> > --
> > 1.7.1
> >
> 
> --
> ~Vinod
