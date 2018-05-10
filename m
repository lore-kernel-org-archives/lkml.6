Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751906AbeEJSlR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 14:41:17 -0400
Received: from mail-eopbgr660099.outbound.protection.outlook.com ([40.107.66.99]:45624
        "EHLO CAN01-QB1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750980AbeEJSlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 14:41:12 -0400
From: "Stephen  Bates" <sbates@raithlin.com>
To: Jerome Glisse <jglisse@redhat.com>
CC: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>,
        "Logan Gunthorpe" <logang@deltatee.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "Christoph Hellwig" <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jason Gunthorpe <jgg@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Subject: Re: [PATCH v4 04/14] PCI/P2PDMA: Clear ACS P2P flags for all devices
 behind switches
Thread-Topic: [PATCH v4 04/14] PCI/P2PDMA: Clear ACS P2P flags for all devices
 behind switches
Thread-Index: AQHT21soiBVnp6SJuEuLCiH6kBzTLKQk+zIAgACHcYCAAJmxAIAABkiAgAAoBgCAAAW2gIAAA0YAgAAHvYCAAAGOgIAACKoAgACuAYCAAGxLgIAAM6EAgAFRXwD//7LJAIAAa6GA///eVgA=
Date: Thu, 10 May 2018 18:41:09 +0000
Message-ID: <B525870A-B25E-46BB-B501-DAA39F1741DC@raithlin.com>
References: <20180508133407.57a46902@w520.home>
 <5fc9b1c1-9208-06cc-0ec5-1f54c2520494@deltatee.com>
 <20180508141331.7cd737cb@w520.home>
 <d70cf286-f7b7-99a5-1042-022506298fed@deltatee.com>
 <20180508205005.GC15608@redhat.com>
 <7FFB9603-DF9F-4441-82E9-46037CB6C0DE@raithlin.com>
 <a1a36f88-fbfb-b5ee-6dcb-5c5bb96132dd@amd.com>
 <4e0d0b96-ab02-2662-adf3-fa956efd294c@deltatee.com>
 <2fc61d29-9eb4-d168-a3e5-955c36e5d821@amd.com>
 <94C8FE12-7FC3-48BD-9DCA-E6A427E71810@raithlin.com>
 <20180510144137.GA3652@redhat.com>
In-Reply-To: <20180510144137.GA3652@redhat.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.d.0.180505
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sbates@raithlin.com;
x-originating-ip: [70.73.168.51]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;YTXPR0101MB1744;7:yOutajXIyMTr18JOln20DBYmxBBsG0KmEe/a79TIs5kErYMzfPYZpHNx6F2RXohj8D04/tHpikNRKZbRMnzr0gc2loaNavwCEVguZ02tOFqPOgNFvSMu3nFnP3L1v6zTEx8pQw7A+3M86UaQF42XNnQU9GRC4TwbO8+FUEDOTfA1ZgeMG8SmsGF1vJkECd8eI3Er4MVqp+yYQtMeY15j+V0HuAZSB8GN4ZcC3Tg43fqpfCKdE0opAS/4xC6sKKq3
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(2017052603328)(7153060)(7193020);SRVR:YTXPR0101MB1744;
x-ms-traffictypediagnostic: YTXPR0101MB1744:
x-microsoft-antispam-prvs: <YTXPR0101MB17440124513FE8E6E88FFE97AA980@YTXPR0101MB1744.CANPRD01.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(158342451672863);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(2016111802025)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(6072148)(6043046)(201708071742011);SRVR:YTXPR0101MB1744;BCL:0;PCL:0;RULEID:;SRVR:YTXPR0101MB1744;
x-forefront-prvs: 066898046A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(39380400002)(366004)(39830400003)(189003)(199004)(7736002)(81166006)(2906002)(316002)(81156014)(3660700001)(3846002)(11346002)(6116002)(54906003)(14454004)(2900100001)(82746002)(26005)(5660300001)(6916009)(229853002)(36756003)(305945005)(97736004)(6246003)(2616005)(8936002)(476003)(68736007)(53936002)(8666007)(58126008)(446003)(3280700002)(93886005)(7416002)(8676002)(486006)(6512007)(83716003)(105586002)(106356001)(102836004)(4326008)(86362001)(478600001)(25786009)(76176011)(6436002)(186003)(5250100002)(33656002)(551934003)(6506007)(66066001)(6486002)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:YTXPR0101MB1744;H:YTXPR0101MB2045.CANPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 19yyJrq4ASRbP+eWNv7pCyqdjtfMNlmUpbAlCr9Bf5pmEnyxohp0JaOfFpANLfAZKyIjEpD7UGQ4DrFs5JcL3J0nbXkkt8uBYuocrK/btbXtx/s6DNad9rLVz1DPpj5Hz7lXMYejLXlMyjrpIKBTMOExVg1XfP3IhZl/MfAa0eEY8/sqOdTzYmYThip/I9cp
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <C8BCC7676B5EED4588E9B4EA9FC88ECD@CANPRD01.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: c17b7d19-f51e-4f3a-8d50-08d5b6a598cb
X-OriginatorOrg: raithlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c17b7d19-f51e-4f3a-8d50-08d5b6a598cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2018 18:41:09.1504
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 18519031-7ff4-4cbb-bbcb-c3252d330f4b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YTXPR0101MB1744
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4AIfPn6003903

Hi Jerome

>    Note on GPU we do would not rely on ATS for peer to peer. Some part
>    of the GPU (DMA engines) do not necessarily support ATS. Yet those
>    are the part likely to be use in peer to peer.

OK this is good to know. I agree the DMA engine is probably one of the GPU components most applicable to p2pdma.
    
>    We (ake GPU people aka the good guys ;)) do no want to do peer to peer
>    for performance reasons ie we do not care having our transaction going
>    to the root complex and back down the destination. At least in use case
>    i am working on this is fine.

If the GPU people are the good guys does that make the NVMe people the bad guys ;-). If so, what are the RDMA people??? Again good to know.
    
>    Reasons is that GPU are giving up on PCIe (see all specialize link like
>    NVlink that are popping up in GPU space). So for fast GPU inter-connect
>    we have this new links. 

I look forward to Nvidia open-licensing NVLink to anyone who wants to use it ;-). Or maybe we'll all just switch to OpenGenCCIX when the time comes.
    
>    Also the IOMMU isolation do matter a lot to us. Think someone using this
>    peer to peer to gain control of a server in the cloud.
    
I agree that IOMMU isolation is very desirable. Hence the desire to ensure we can keep the IOMMU on while doing p2pdma if at all possible whilst still delivering the desired performance to the user.

Stephen    
