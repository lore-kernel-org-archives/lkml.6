Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753666AbeE3R36 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 13:29:58 -0400
Received: from mail-by2nam01on0079.outbound.protection.outlook.com ([104.47.34.79]:52327
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751817AbeE3R3y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 13:29:54 -0400
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
Thread-Index: AQHTym7m2V209m7Mdku6MMzd169mt6P7VJGAgAmMXFCAACC9AIAADoKAgAADQwCAAA9+gIAAEQmAgAD0/ICAAG4+gIABel0AgAdZ2ICAAGMogIAj6UOAgBNwBwCAAawZwA==
Date: Wed, 30 May 2018 17:29:47 +0000
Message-ID: <DM6PR02MB43612FF66323449C7D2B4FDCC76C0@DM6PR02MB4361.namprd02.prod.outlook.com>
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
 <99581088-7ef8-6fac-c934-91eadddfb04e@ti.com>
In-Reply-To: <99581088-7ef8-6fac-c934-91eadddfb04e@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=radheys@xilinx.com;
x-originating-ip: [183.83.203.7]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR02MB4443;7:DAP239DUQjcp5dK/LRoRxzyOa9kx4BgrKztwchnaZL6IdO5x0iVDXWszVOYfx1xb5iakxGMG+3i7hRVHmfbPWF0/OpFZQn6NHxF+kxXyIoKX1jdLikGf7eC9mtjFS8Vi+tiJpkbgra3rgmwWWBJb+eFuqJKu3kWerADqRBeT482kaBbgCCp1cgePT6QR8hj3S6l7NgrILlEOrp6nJDz2x4C4sPfO60r4/HufKBghgTfHw6DRpGO3IgLrbHIKfg1H
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(346002)(376002)(396003)(366004)(13464003)(189003)(199004)(26005)(7696005)(478600001)(81166006)(5660300001)(4326008)(106356001)(99286004)(966005)(25786009)(305945005)(105586002)(97736004)(8936002)(86362001)(14454004)(7736002)(11346002)(476003)(446003)(53936002)(229853002)(486006)(33656002)(6246003)(9686003)(6306002)(55016002)(74316002)(5250100002)(3846002)(6116002)(66066001)(6436002)(54906003)(110136005)(5890100001)(93886005)(316002)(2906002)(186003)(76176011)(53546011)(102836004)(8676002)(2900100001)(68736007)(1720100001)(3280700002)(59450400001)(3660700001)(6506007)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4443;H:DM6PR02MB4361.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM6PR02MB4443;
x-ms-traffictypediagnostic: DM6PR02MB4443:
x-microsoft-antispam-prvs: <DM6PR02MB4443804ECC028B1ED4C54C9AC76C0@DM6PR02MB4443.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(31051911155226)(9452136761055)(258649278758335)(192813158149592)(106291317490208)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DM6PR02MB4443;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4443;
x-forefront-prvs: 0688BF9B46
x-microsoft-antispam-message-info: uSBffaP+1NxfqIihqF1G7PsO9w1Pm8cKzLvDLCUVGvkk0PnTASe9azSDYVkU5V77wJUOpofqXhhYOtyI954HqY+M7j+lUqGNMBLrTRrcD4K0Kk56Huh26Sh9Ljeo7f275lPIKQYYuinWwBbbyPe70Xjydb1Q2t+fjZe75ojepBy7lpNqTmoGK6zHy13FISTz
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 5f7608d6-cd36-4b3f-188e-08d5c652f12b
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f7608d6-cd36-4b3f-188e-08d5c652f12b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2018 17:29:47.6222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4443
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4UHUD3C003006

Hi,

> -----Original Message-----
> From: Peter Ujfalusi [mailto:peter.ujfalusi@ti.com]
> Sent: Tuesday, May 29, 2018 8:35 PM
> To: Radhey Shyam Pandey <radheys@xilinx.com>; Vinod Koul
> <vinod.koul@intel.com>
> Cc: Lars-Peter Clausen <lars@metafoo.de>; michal.simek@xilinx.com; linux-
> kernel@vger.kernel.org; dmaengine@vger.kernel.org;
> dan.j.williams@intel.com; Appana Durga Kedareswara Rao
> <appanad@xilinx.com>; linux-arm-kernel@lists.infradead.org
> Subject: Re: [RFC 2/6] dmaengine: xilinx_dma: Pass AXI4-Stream control words
> to netdev dma client
> 
> Hi,
> 
> On 2018-05-17 09:39, Radhey Shyam Pandey wrote:
> >> Well, let's see where this is going to go when I can send the patches
> >> for review.
> > Thanks all. @Peter: If we have metadata patchset ready may be good
> > to send an RFC?
> 
> Sorry for the delay, I got distracted by this:
> http://www.ti.com/lit/pdf/spruid7 Chapter 10.
> 
> I have given some tough to the metadata attach patches.
> In my case the 'metadata' is more like private data section within the
> DMA descriptor (10.1.2.2.1) which is used by the remote peripheral and
> the driver for the given peripheral and it is optional.
> 
> I liked the idea of treating it as metadata as it gives more generic API
> which can be adopted by other drivers if they need something similar.
> 
> Another issue I have with the attach metadata way is that it would
> require one memcpy to copy the data to the DMA descriptor and in high
> throughput case it is not acceptable.

I think memcpy is needed (alternative?) if dma engine doesn’t directly
update metadata buffers i.e in RX, we need to copy metadata from 
dma descriptor fields to client allocated metadata buffer (sideband/
metadata info is part of Buffer descriptor fields) 

memcpy(app_w, hw->app, sizeof(u32) * XILINX_DMA_NUM_APP_WORDS);

Descriptor Fields
Address Space               Offset          Name Description
20h                                  APP0           User Application Field 0
24h                                  APP1           User Application Field 1
...
30h                                 APP5           User Application Field 5

> 
> For me probably a .get_private_area / .put_private_area like API would
> be desirable where I can give the pointer of the 'metadata' are (and
> size) to the user.
> 
> But these can co-exist in my opinion and DMA drivers can opt to
> implement none, either or both of the callbacks.
> 
> In couple of days I can update the metadata patches I have atm and send
> as RFC.
> 
> Is there anything from your side I should take into account when doing that?
I think a generic interface to attach/share metadata buffer b/w client and the
dmaengine driver is good enough. Is metadata patchset (early version) 
available in TI external repos? 

Thanks,
Radhey

> 
> - Péter
> 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
