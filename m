Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751386AbeDSLki (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 07:40:38 -0400
Received: from lelnx193.ext.ti.com ([198.47.27.77]:40184 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751092AbeDSLkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 07:40:36 -0400
Subject: Re: [RFC 2/6] dmaengine: xilinx_dma: Pass AXI4-Stream control words
 to netdev dma client
To: Lars-Peter Clausen <lars@metafoo.de>,
        Radhey Shyam Pandey <radheys@xilinx.com>,
        Vinod Koul <vinod.koul@intel.com>
CC: "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Appana Durga Kedareswara Rao <appanad@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
References: <1522665546-10035-1-git-send-email-radheys@xilinx.com>
 <1522665546-10035-3-git-send-email-radheys@xilinx.com>
 <20180411090854.GY6014@localhost>
 <BN6PR02MB32825FDF8601D8A310C2270BC7B70@BN6PR02MB3282.namprd02.prod.outlook.com>
 <7f549d2e-fc96-8c7e-d839-edb86ae088a5@metafoo.de>
 <4ba085c7-5256-6c8a-5697-c0d5736a6e46@ti.com>
 <1fc10bec-5c2c-98f1-1d5b-b768dea844ed@metafoo.de>
 <78828d31-e4cd-5211-f1b6-8918ac38f599@ti.com>
 <e5a6c1ad-e263-7b9d-a5e2-744884c9d6de@metafoo.de>
 <a6ac9ca8-91b4-c7b1-0f0c-c04dd10048e2@ti.com>
 <d7432292-cedd-7d61-f219-8b63eb6c1d50@metafoo.de>
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <8c7a5ac8-0747-9dad-f6e5-74890b64f618@ti.com>
Date: Thu, 19 Apr 2018 14:40:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <d7432292-cedd-7d61-f219-8b63eb6c1d50@metafoo.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2018-04-18 16:06, Lars-Peter Clausen wrote:
>> Hrm, true, but it is hardly the metadata use case. It is more like
>> different DMA transfer type.
> 
> When I look at this with my astronaut architect view from high high up above
> I do not see a difference between metadata and multi-planar data.

I tend to disagree.

> Both split the data that is sent to the peripheral into multiple
> sub-streams, each carrying part of the data. I'm sure there are peripherals
> that interleave data and metadata on the same data stream. Similar to how we
> have left and right channel interleaved in a audio stream.

Slimbus, S/PDIF?

> What about metadata that is not contiguous and split into multiple segments.
> How do you handle passing a sgl to the metadata interface? And then it
> suddenly looks quite similar to the normal DMA descriptor interface.

Well, the metadata is for the descriptor. The descriptor describe the
data transfer _and_ can convey additional information. Nothing is
interleaved, the data and the descriptor are different things. It is
more like TCP headers detached from the data (but pointing to it).

> But maybe that's just one abstraction level to high.

I understand your point, but at the end the metadata needs to end up in
the descriptor which is describing the data that is going to be moved.

The descriptor is not sent as a separate DMA trasnfer, it is part of the
DMA transfer, it is handled internally by the DMA.

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
