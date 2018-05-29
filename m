Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936718AbeE2PEd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 11:04:33 -0400
Received: from lelnx193.ext.ti.com ([198.47.27.77]:29162 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965033AbeE2PEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 11:04:21 -0400
Subject: Re: [RFC 2/6] dmaengine: xilinx_dma: Pass AXI4-Stream control words
 to netdev dma client
To: Radhey Shyam Pandey <radheys@xilinx.com>,
        Vinod Koul <vinod.koul@intel.com>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Appana Durga Kedareswara Rao <appanad@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
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
 <MWHPR02MB3293486390485A6FCCEA7DECC7910@MWHPR02MB3293.namprd02.prod.outlook.com>
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <99581088-7ef8-6fac-c934-91eadddfb04e@ti.com>
Date: Tue, 29 May 2018 18:04:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <MWHPR02MB3293486390485A6FCCEA7DECC7910@MWHPR02MB3293.namprd02.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2018-05-17 09:39, Radhey Shyam Pandey wrote:
>> Well, let's see where this is going to go when I can send the patches
>> for review.
> Thanks all. @Peter: If we have metadata patchset ready may be good
> to send an RFC?

Sorry for the delay, I got distracted by this:
http://www.ti.com/lit/pdf/spruid7 Chapter 10.

I have given some tough to the metadata attach patches.
In my case the 'metadata' is more like private data section within the
DMA descriptor (10.1.2.2.1) which is used by the remote peripheral and
the driver for the given peripheral and it is optional.

I liked the idea of treating it as metadata as it gives more generic API
which can be adopted by other drivers if they need something similar.

Another issue I have with the attach metadata way is that it would
require one memcpy to copy the data to the DMA descriptor and in high
throughput case it is not acceptable.

For me probably a .get_private_area / .put_private_area like API would
be desirable where I can give the pointer of the 'metadata' are (and
size) to the user.

But these can co-exist in my opinion and DMA drivers can opt to
implement none, either or both of the callbacks.

In couple of days I can update the metadata patches I have atm and send
as RFC.

Is there anything from your side I should take into account when doing that?

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
