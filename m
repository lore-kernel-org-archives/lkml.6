Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753105AbeDQM27 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 08:28:59 -0400
Received: from mail-sn1nam02on0072.outbound.protection.outlook.com ([104.47.36.72]:12896
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752087AbeDQM25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 08:28:57 -0400
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
Subject: RE: [RFC 4/6] dmaengine: xilinx_dma: Freeup active list based on
 descriptor completion bit
Thread-Topic: [RFC 4/6] dmaengine: xilinx_dma: Freeup active list based on
 descriptor completion bit
Thread-Index: AQHTym7jpd5Sj2JFfE2h6FzaUbI5DaP7VSmAgAmZbjA=
Date: Tue, 17 Apr 2018 12:28:52 +0000
Message-ID: <BN6PR02MB3282D60BCF6A4B40BCC7A5B8C7B70@BN6PR02MB3282.namprd02.prod.outlook.com>
References: <1522665546-10035-1-git-send-email-radheys@xilinx.com>
 <1522665546-10035-5-git-send-email-radheys@xilinx.com>
 <20180411091102.GZ6014@localhost>
In-Reply-To: <20180411091102.GZ6014@localhost>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=radheys@xilinx.com;
x-originating-ip: [182.72.145.30]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR02MB2370;7:WmtUxtM6HFF476u1cJRJplh3lo8qAK4GsU/4vb3FVMR3XSE1lxABovM+Fn4fZ0HAMYYOAaOjaxDujMmcpfEBMlOPisuUoApwrlNjr0oz19obZLlkJpIJFXlocW2lrNoubkX+k1raL8X6z8Vp4dcRnT7ArBCfmjMKVwNgwwCgHfhldohcJOViIRaHfCCyjyyef4c9M5q2dMZIV0zvWax1JjVRtOHSgH6nRNh5bSaBFmDlcNCMu1KRUvd4UOc0hkHf
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(366004)(39380400002)(39860400002)(13464003)(199004)(189003)(74316002)(53936002)(6916009)(305945005)(4326008)(9686003)(2900100001)(6436002)(25786009)(5250100002)(11346002)(476003)(7736002)(3660700001)(8936002)(3280700002)(2906002)(55016002)(81156014)(8676002)(81166006)(446003)(486006)(14454004)(54906003)(575784001)(86362001)(316002)(7696005)(76176011)(105586002)(53546011)(102836004)(55236004)(59450400001)(39060400002)(33656002)(186003)(5660300001)(229853002)(6116002)(478600001)(66066001)(97736004)(6506007)(6246003)(106356001)(68736007)(99286004)(26005)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR02MB2370;H:BN6PR02MB3282.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:BN6PR02MB2370;
x-ms-traffictypediagnostic: BN6PR02MB2370:
x-microsoft-antispam-prvs: <BN6PR02MB2370DA145B8B0D6AD364A684C7B70@BN6PR02MB2370.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(258649278758335)(192813158149592)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231232)(944501327)(52105095)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BN6PR02MB2370;BCL:0;PCL:0;RULEID:;SRVR:BN6PR02MB2370;
x-forefront-prvs: 0645BEB7AA
x-microsoft-antispam-message-info: 63CylYm7pKjUWdJ64ImmulBzBwp7+At9d7xnv7hHVXjhUjJ5VkRT85sdN51wBsIBTZ015HkqO5B2SHmTMpa9ENlJTTTuEnt+lsb/IUB7JEd6d4qZaNH/P87sMTMoqi8MnpUIbkMO2dmN9VHPwmWxN/ag0bORONIbAO+hi/N7hWdtw99/kgNdckrTcIcpxEdO
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: d42e3f2f-9c6f-44d8-3190-08d5a45ec7ae
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d42e3f2f-9c6f-44d8-3190-08d5a45ec7ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2018 12:28:52.5818
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2370
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3HCT53x011986

Hi  Vinod,

> -----Original Message-----
> From: Vinod Koul [mailto:vinod.koul@intel.com]
> Sent: Wednesday, April 11, 2018 2:41 PM
> To: Radhey Shyam Pandey <radheys@xilinx.com>
> Cc: dan.j.williams@intel.com; michal.simek@xilinx.com; Appana Durga
> Kedareswara Rao <appanad@xilinx.com>; Radhey Shyam Pandey
> <radheys@xilinx.com>; lars@metafoo.de; dmaengine@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: Re: [RFC 4/6] dmaengine: xilinx_dma: Freeup active list based on
> descriptor completion bit
> 
> On Mon, Apr 02, 2018 at 04:09:04PM +0530, Radhey Shyam Pandey wrote:
> > AXIDMA IP sets completion bit to 1 when the transfer is completed. Read
> > this bit to move descriptor from active list to the done list. This feature
> > is needed when interrupt delay timeout and IRQThreshold is enabled i.e
> > Dly_IrqEn is triggered w/o completing Interrupt Threshold.
> >
> > Signed-off-by: Radhey Shyam Pandey <radheys@xilinx.com>
> > ---
> >  drivers/dma/xilinx/xilinx_dma.c |   18 ++++++++++++++----
> >  1 files changed, 14 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/dma/xilinx/xilinx_dma.c
> b/drivers/dma/xilinx/xilinx_dma.c
> > index 36e1ab9..518465e 100644
> > --- a/drivers/dma/xilinx/xilinx_dma.c
> > +++ b/drivers/dma/xilinx/xilinx_dma.c
> > @@ -103,6 +103,7 @@
> >  #define XILINX_DMA_PARK_PTR_RD_REF_SHIFT	0
> >  #define XILINX_DMA_PARK_PTR_RD_REF_MASK		GENMASK(4,
> 0)
> >  #define XILINX_DMA_REG_VDMA_VERSION		0x002c
> > +#define XILINX_DMA_COMP_MASK			BIT(31)
> >
> >  /* Register Direct Mode Registers */
> >  #define XILINX_DMA_REG_VSIZE			0x0000
> > @@ -1387,16 +1388,25 @@ static void xilinx_dma_issue_pending(struct
> dma_chan *dchan)
> >  static void xilinx_dma_complete_descriptor(struct xilinx_dma_chan *chan)
> >  {
> >  	struct xilinx_dma_tx_descriptor *desc, *next;
> > +	struct xilinx_axidma_tx_segment *seg;
> >
> >  	/* This function was invoked with lock held */
> >  	if (list_empty(&chan->active_list))
> >  		return;
> >
> >  	list_for_each_entry_safe(desc, next, &chan->active_list, node) {
> > -		list_del(&desc->node);
> > -		if (!desc->cyclic)
> > -			dma_cookie_complete(&desc->async_tx);
> > -		list_add_tail(&desc->node, &chan->done_list);
> > +
> > +		seg = list_last_entry(&desc->segments,
> > +				      struct xilinx_axidma_tx_segment, node);
> > +		if ((seg->hw.status & XILINX_DMA_COMP_MASK) ||
> > +			(!chan->xdev->has_axieth_connected)) {
> 
> why the second case ? That is not expalined in log?
In the current implementation, delay timeout is enabled only for
has_axieth_connected usecase. For ethernet, we need real-time processing
while still having benefit of interrupt coalescing. Example: In RX interrupt
coalescing is set to 0x3.  Without delay timeout, DMA engine will wait for
all frames and then issue completion interrupt. In ethernet usecase, this
can introduce huge latencies. Delay timeout interrupt will trigger if delay
time period has expired and we can notify dma client with received frames.

The second case is added to keep the previous implementation as is.(i.e when
Delay timeout interrupt is not enabled - move all active desc to done list). 
Sure I will add a description for it in the commit log.

> 
> > +			list_del(&desc->node);
> > +			if (!desc->cyclic)
> > +				dma_cookie_complete(&desc->async_tx);
> > +			list_add_tail(&desc->node, &chan->done_list);
> > +		} else {
> > +			break;
> > +		}
> >  	}
> >  }
> >
> > --
> > 1.7.1
> >
> 
> --
> ~Vinod
