Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752539AbeEQGjK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 02:39:10 -0400
Received: from mail-by2nam01on0056.outbound.protection.outlook.com ([104.47.34.56]:33096
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752218AbeEQGjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 02:39:07 -0400
From: Radhey Shyam Pandey <radheys@xilinx.com>
To: Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Vinod Koul <vinod.koul@intel.com>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Appana Durga Kedareswara Rao <appanad@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [RFC 2/6] dmaengine: xilinx_dma: Pass AXI4-Stream control words
 to netdev dma client
Thread-Topic: [RFC 2/6] dmaengine: xilinx_dma: Pass AXI4-Stream control words
 to netdev dma client
Thread-Index: AQHTym7m2V209m7Mdku6MMzd169mt6P7VJGAgAmMXFCAACC9AIAADoKAgAADQwCAAA9+gIAAEQmAgAD0/ICAAG4+gIABel0AgAdZ2ICAAGMogIAj6UOA
Date: Thu, 17 May 2018 06:39:02 +0000
Message-ID: <MWHPR02MB3293486390485A6FCCEA7DECC7910@MWHPR02MB3293.namprd02.prod.outlook.com>
References: <20180411090854.GY6014@localhost>
 <BN6PR02MB32825FDF8601D8A310C2270BC7B70@BN6PR02MB3282.namprd02.prod.outlook.com>
 <7f549d2e-fc96-8c7e-d839-edb86ae088a5@metafoo.de>
 <4ba085c7-5256-6c8a-5697-c0d5736a6e46@ti.com>
 <1fc10bec-5c2c-98f1-1d5b-b768dea844ed@metafoo.de>
 <78828d31-e4cd-5211-f1b6-8918ac38f599@ti.com>
 <e5a6c1ad-e263-7b9d-a5e2-744884c9d6de@metafoo.de>
 <a6ac9ca8-91b4-c7b1-0f0c-c04dd10048e2@ti.com>
 <d7432292-cedd-7d61-f219-8b63eb6c1d50@metafoo.de>
 <8c7a5ac8-0747-9dad-f6e5-74890b64f618@ti.com>
 <20180424035548.GA6014@localhost>
 <ee1dc551-7c11-6d10-651d-01bf6520f049@ti.com>
In-Reply-To: <ee1dc551-7c11-6d10-651d-01bf6520f049@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=radheys@xilinx.com;
x-originating-ip: [182.72.145.30]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR02MB2783;7:m5nGK97ieWaI3DirEWRQmF6n95Zbhw5H8WGmMGy8AKxKXhQnJV0ZezP9VKhG5eFdQserYjk+zYWT3VswyA/rCvtWBkqN5WHR0Z6DC7caJQXDpXVjAu1gayjwp+9rcSan2SZPAUKLXBdK+QnUoySM0//mrpvESprCKeR1eK+RtmkLZlgI346vEuXF+ARd/lxw8b4znlytT/+uJrDp/i/+HDKmsJvxa3EIOrRvLxfl1M6lSxdfOftMWhtCop4sQQAh
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(376002)(39380400002)(39860400002)(377424004)(199004)(189003)(13464003)(102836004)(110136005)(55236004)(99286004)(106356001)(305945005)(9686003)(105586002)(6306002)(53936002)(3280700002)(26005)(74316002)(6436002)(229853002)(7696005)(55016002)(33656002)(66066001)(966005)(3846002)(6116002)(59450400001)(68736007)(53546011)(478600001)(6506007)(2900100001)(54906003)(316002)(7736002)(76176011)(3660700001)(25786009)(486006)(186003)(446003)(8676002)(5660300001)(5250100002)(5890100001)(2906002)(14454004)(11346002)(8936002)(81166006)(97736004)(93886005)(4326008)(476003)(86362001)(6246003)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2783;H:MWHPR02MB3293.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:MWHPR02MB2783;
x-ms-traffictypediagnostic: MWHPR02MB2783:
x-microsoft-antispam-prvs: <MWHPR02MB2783D0415DCA1CD9D3BA8CB9C7910@MWHPR02MB2783.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(31051911155226)(9452136761055)(258649278758335)(192813158149592)(106291317490208)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:MWHPR02MB2783;BCL:0;PCL:0;RULEID:;SRVR:MWHPR02MB2783;
x-forefront-prvs: 067553F396
x-microsoft-antispam-message-info: YuzgouGX5Q7U8sF83eW6HNvPUPVYrbQ+CYbVKxTC4FDWBi4oZWcZ79lvX+YbVGwmLmY1KKKSEPPqCYgqlaa0CeSzgSXB+KKc7ZNuKPUnJf9glNS67zK9an4eolp4hyEdCrXRxPhO/X+GCPiBBBX7Z8QSybU965Kl6u0FMciiJX61lRVi7iIWsMfRZUTVwmGG
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 9b6e217d-2aaa-4f6b-7050-08d5bbc0e142
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b6e217d-2aaa-4f6b-7050-08d5bbc0e142
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2018 06:39:02.9042
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2783
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4H6dGAc016602

Hi,

> -----Original Message-----
> From: Peter Ujfalusi [mailto:peter.ujfalusi@ti.com]
> Sent: Tuesday, April 24, 2018 3:21 PM
> To: Vinod Koul <vinod.koul@intel.com>
> Cc: Lars-Peter Clausen <lars@metafoo.de>; Radhey Shyam Pandey
> <radheys@xilinx.com>; michal.simek@xilinx.com; linux-
> kernel@vger.kernel.org; dmaengine@vger.kernel.org;
> dan.j.williams@intel.com; Appana Durga Kedareswara Rao
> <appanad@xilinx.com>; linux-arm-kernel@lists.infradead.org
> Subject: Re: [RFC 2/6] dmaengine: xilinx_dma: Pass AXI4-Stream control words
> to netdev dma client
> 
> On 2018-04-24 06:55, Vinod Koul wrote:
> > On Thu, Apr 19, 2018 at 02:40:26PM +0300, Peter Ujfalusi wrote:
> >>
> >> On 2018-04-18 16:06, Lars-Peter Clausen wrote:
> >>>> Hrm, true, but it is hardly the metadata use case. It is more like
> >>>> different DMA transfer type.
> >>>
> >>> When I look at this with my astronaut architect view from high high up
> above
> >>> I do not see a difference between metadata and multi-planar data.
> >>
> >> I tend to disagree.
> >
> > and we will love to hear more :)
> 
> It is getting pretty off topic from the subject ;) and I'm sorry about that.
> 
> Multi-planar data is _data_, the metadata is
> parameters/commands/information on _how_ to use the data.
> It is more like a replacement or extension of:
> configure peripheral
> send data
> 
> to
> 
> send data with configuration
> 
> In both cases the same data is sent, but the configuration,
> parametrization is 'simplified' to allow per packet changes.
> 
> >>> Both split the data that is sent to the peripheral into multiple
> >>> sub-streams, each carrying part of the data. I'm sure there are peripherals
> >>> that interleave data and metadata on the same data stream. Similar to
> how we
> >>> have left and right channel interleaved in a audio stream.
> >>
> >> Slimbus, S/PDIF?
> >>
> >>> What about metadata that is not contiguous and split into multiple
> segments.
> >>> How do you handle passing a sgl to the metadata interface? And then it
> >>> suddenly looks quite similar to the normal DMA descriptor interface.
> >>
> >> Well, the metadata is for the descriptor. The descriptor describe the
> >> data transfer _and_ can convey additional information. Nothing is
> >> interleaved, the data and the descriptor are different things. It is
> >> more like TCP headers detached from the data (but pointing to it).
> >>
> >>> But maybe that's just one abstraction level to high.
> >>
> >> I understand your point, but at the end the metadata needs to end up in
> >> the descriptor which is describing the data that is going to be moved.
> >>
> >> The descriptor is not sent as a separate DMA trasnfer, it is part of the
> >> DMA transfer, it is handled internally by the DMA.
> >
> > That is bit confusing to me. I thought DMA was transparent to meta data and
> > would blindly collect and transfer along with the descriptor. So at high
> > level we are talking about two transfers (probably co-joined at hip and you
> > want to call one transfer)
> 
> At the end yes, both the descriptor and the data is going to be sent to
> the other end.
> 
> As a reference see [1]
> 
> The metadata is not a separate entity, it is part of the descriptor
> (Host Packet Descriptor - HPD).
> Each transfer (packet) is described with a HPD. The HPD have optional
> fields, like EPIB (Extended Packet Info Block), PSdata (Protocol
> Specific data).
> 
> When the DMA reads the HPD, is going to move the data described by the
> HPD to the entry point (or from the entry point to memory), copies the
> EPIB/PSdata from the HPD to a destination HPD. The other end will use
> the destination HPD to know the size of the data and to get the metadata
> from the descriptor.
> 
> In essence every entity within the Multicore Navigator system have
> pktdma, they all work in a similar way, but their capabilities might
> differ. Our entry to this mesh is via the DMA.
> 
> > but why can't we visualize this as just a DMA
> > transfers. maybe you want to signal/attach to transfer, cant we do that with
> > additional flag DMA_METADATA etc..?
> 
> For the data we need to call dmaengine_prep_slave_* to create the
> descriptor (HPD). The metadata needs to be present in the HPD, hence I
> was thinking of the attach_metadata as per descriptor API.
> 
> If separate dmaengine_prep_slave_* is used for allocating the HPD and
> place the metadata in it then the consequent dmaengine_prep_slave_* call
> must be for the data of the transfer and it is still unclear how the
> prepare call would have any idea where to look for the HPD it needs to
> update with the parameters for the data transfer.
> 
> I guess the driver could store the HPD pointer in the channel data if
> the prepare is called with DMA_METADATA and it would be mandatory that
> the next prepare is for the data portion. The driver would pick the
> pointer to the HPD we stored away and update the descriptor belonging to
> different tx_desc.
> 
> But if we are here, we could have a flag like DMA_DESCRIPTOR and let
> client drivers to allocate the whole descriptor, fill in the metadata
> and give that to the DMA driver, which will update the rest of the HPD.
> 
> Well, let's see where this is going to go when I can send the patches
> for review.
Thanks all. @Peter: If we have metadata patchset ready may be good
to send an RFC?

> 
> [1] http://www.ti.com/lit/ug/sprugr9h/sprugr9h.pdf
> 
> - Péter
> 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
