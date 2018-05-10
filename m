Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966635AbeEJRLU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 13:11:20 -0400
Received: from mail-eopbgr660114.outbound.protection.outlook.com ([40.107.66.114]:45954
        "EHLO CAN01-QB1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966425AbeEJRLR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 13:11:17 -0400
From: "Stephen  Bates" <sbates@raithlin.com>
To: Logan Gunthorpe <logang@deltatee.com>,
        =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>,
        "Jerome Glisse" <jglisse@redhat.com>
CC: Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jason Gunthorpe <jgg@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v4 04/14] PCI/P2PDMA: Clear ACS P2P flags for all devices
 behind switches
Thread-Topic: [PATCH v4 04/14] PCI/P2PDMA: Clear ACS P2P flags for all devices
 behind switches
Thread-Index: AQHT21soiBVnp6SJuEuLCiH6kBzTLKQk+zIAgACHcYCAAJmxAIAABkiAgAAoBgCAAAW2gIAAA0YAgAAHvYCAAAGOgIAACKoAgACuAYCAAGxLgIAAM6EAgAFRXwD//7LJAIAAipIA//+mRQA=
Date: Thu, 10 May 2018 17:11:14 +0000
Message-ID: <868B49CE-4F0E-4A48-BE78-12149F85F1A4@raithlin.com>
References: <20180423233046.21476-5-logang@deltatee.com>
 <20180507231306.GG161390@bhelgaas-glaptop.roam.corp.google.com>
 <e58e8d27-42a5-ca69-3b68-c409a2922cd1@amd.com>
 <0b4183ef-e720-204b-9e85-b9eaf7a4136a@deltatee.com>
 <a943a92d-15cd-fb2d-21c3-5e5cfccd9eff@amd.com>
 <3584a6ac-95c7-5d23-1859-aee30605776e@deltatee.com>
 <20180508133407.57a46902@w520.home>
 <5fc9b1c1-9208-06cc-0ec5-1f54c2520494@deltatee.com>
 <20180508141331.7cd737cb@w520.home>
 <d70cf286-f7b7-99a5-1042-022506298fed@deltatee.com>
 <20180508205005.GC15608@redhat.com>
 <7FFB9603-DF9F-4441-82E9-46037CB6C0DE@raithlin.com>
 <a1a36f88-fbfb-b5ee-6dcb-5c5bb96132dd@amd.com>
 <4e0d0b96-ab02-2662-adf3-fa956efd294c@deltatee.com>
 <2fc61d29-9eb4-d168-a3e5-955c36e5d821@amd.com>
 <94C8FE12-7FC3-48BD-9DCA-E6A427E71810@raithlin.com>
 <f0101988-cf82-7ffb-2aca-d3b8d2f4b504@deltatee.com>
In-Reply-To: <f0101988-cf82-7ffb-2aca-d3b8d2f4b504@deltatee.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.d.0.180505
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sbates@raithlin.com;
x-originating-ip: [70.73.168.51]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;YTXPR0101MB2144;7:KdrMx2NgwH5DmzS8GRYuLGMYCvdmH2DqdwH5V9ShDmq37Af9anPrMl1IkxBGD5mUqdOxUFwa7ylbScIHoRQRBzUlluKhdX30liFCcn9JDF42jBNGAaGSyeyIRGYOo99mM5jEJV9rFNST2MmqonCCKnd9zYN+i23K//SQ23fnwy8qYcVsftcUvqPxi36xERSEVet96PeI5NzXv8cK/8Eln2FgZiaYY3Bin2dIWRh1hsTpUfInwf8MG0g83jnJi5H5
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(2017052603328)(7153060)(7193020);SRVR:YTXPR0101MB2144;
x-ms-traffictypediagnostic: YTXPR0101MB2144:
x-microsoft-antispam-prvs: <YTXPR0101MB214458A31CFA1815129E8A9BAA980@YTXPR0101MB2144.CANPRD01.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(2016111802025)(20161123564045)(20161123562045)(20161123560045)(6072148)(6043046)(201708071742011);SRVR:YTXPR0101MB2144;BCL:0;PCL:0;RULEID:;SRVR:YTXPR0101MB2144;
x-forefront-prvs: 066898046A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(366004)(376002)(396003)(39830400003)(189003)(199004)(82746002)(476003)(76176011)(110136005)(316002)(5660300001)(4326008)(54906003)(58126008)(6486002)(6436002)(6506007)(11346002)(97736004)(68736007)(446003)(99286004)(6246003)(5250100002)(186003)(93886005)(26005)(102836004)(25786009)(2616005)(2900100001)(486006)(229853002)(53936002)(7416002)(86362001)(33656002)(3846002)(305945005)(3280700002)(7736002)(14454004)(478600001)(3660700001)(6116002)(551934003)(105586002)(2906002)(106356001)(81166006)(6512007)(36756003)(8676002)(81156014)(8666007)(83716003)(66066001)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:YTXPR0101MB2144;H:YTXPR0101MB2045.CANPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 8OKc+ldhY9FTIzQVXOiCmuYjnQOQNK+HgYi4EsQ8AKtHG5JARnN8noSXL5f2HMgcmmKeVs2BKel6MSVTRqGqsepDdGC2lb+NoJjLumpsvOr9dI/fTnnMj8eIWqJHTtkHuW4XBunZbYbQYeb4j5RGoQ0nK3Hr3vxJ+AA3ak6Bay6BoR8Xf1kNj6wIAQEJOHFj
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <269C6C062D058B4E801135E0899060A7@CANPRD01.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 19a85380-8719-4b07-7dd0-08d5b699097c
X-OriginatorOrg: raithlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19a85380-8719-4b07-7dd0-08d5b699097c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2018 17:11:14.7573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 18519031-7ff4-4cbb-bbcb-c3252d330f4b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YTXPR0101MB2144
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4AHBQau020007

> Not to me. In the p2pdma code we specifically program DMA engines with
> the PCI bus address. 

Ah yes of course. Brain fart on my part. We are not programming the P2PDMA initiator with an IOVA but with the PCI bus address...

> So regardless of whether we are using the IOMMU or
> not, the packets will be forwarded directly to the peer. If the ACS
>  Redir bits are on they will be forced back to the RC by the switch and
>  the transaction will fail. If we clear the ACS bits, the TLPs will go
>  where we want and everything will work (but we lose the isolation of ACS).

Agreed.
    
>    For EPs that support ATS, we should (but don't necessarily have to)
>    program them with the IOVA address so they can go through the
>    translation process which will allow P2P without disabling the ACS Redir
>    bits -- provided the ACS direct translation bit is set. (And btw, if it
>    is, then we lose the benefit of ACS protecting against malicious EPs).
>    But, per above, the ATS transaction should involve only the IOVA address
>    so the ACS bits not being set should not break ATS.
    
Well we would still have to clear some ACS bits but now we can clear only for translated addresses.

Stephen
    
