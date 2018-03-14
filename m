Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751753AbeCNOFL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 10:05:11 -0400
Received: from mail-eopbgr660099.outbound.protection.outlook.com ([40.107.66.99]:21783
        "EHLO CAN01-QB1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750827AbeCNOFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 10:05:09 -0400
From: "Stephen  Bates" <sbates@raithlin.com>
To: Bjorn Helgaas <helgaas@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>
CC: Sinan Kaya <okaya@codeaurora.org>,
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
        =?utf-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "Alex Williamson" <alex.williamson@redhat.com>
Subject: Re: [PATCH v3 01/11] PCI/P2PDMA: Support peer-to-peer memory
Thread-Topic: [PATCH v3 01/11] PCI/P2PDMA: Support peer-to-peer memory
Thread-Index: AQHTujlZo8bTZRn+4ECdETRRU1rPhqPNgjSAgADeTICAABJggIAAD1YAgAAHVACAAAJxAIAACW8AgAAO3oCAAAopgIAACqIA//+kE4CAAG7lAIAAA38AgAA8KICAAFYtgA==
Date: Wed, 14 Mar 2018 14:05:06 +0000
Message-ID: <45A47A71-B435-4DFA-8925-8EB91CEAB230@raithlin.com>
References: <3e738f95-d73c-4182-2fa1-8664aafb1ab7@deltatee.com>
 <703aa92c-0c1c-4852-5887-6f6e6ccde0fb@codeaurora.org>
 <a0af83f8-2cbc-862b-6f8b-231991527cfc@deltatee.com>
 <3ea80992-a0fc-08f2-d93d-ae0ec4e3f4ce@codeaurora.org>
 <4eb6850c-df1b-fd44-3ee0-d43a50270b53@deltatee.com>
 <757fca36-dee4-e070-669e-f2788bd78e41@codeaurora.org>
 <4f761f55-4e9a-dccb-d12f-c59d2cd689db@deltatee.com>
 <BB94077B-7EB3-49C4-862D-BF77D0A692CC@raithlin.com>
 <20180313230850.GA45763@bhelgaas-glaptop.roam.corp.google.com>
 <8de5d3dd-a78f-02d5-0eea-4365364143b6@deltatee.com>
 <20180314025639.GA50067@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180314025639.GA50067@bhelgaas-glaptop.roam.corp.google.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.b.0.180311
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sbates@raithlin.com;
x-originating-ip: [70.65.224.121]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;YTXPR0101MB1677;7:OkyCiN/H4SB7NjT7+mAVhyofJTc1weK6cWcE6R1XLcTTdBk77Ct//lvx/if6EZ1FEdl5lgEyobVNfc/PDKU6QXm+6WL/lcx895+S4bkIc8zPExWtjpiFppJD1+iguLAkImtf6lWVsawC1u41M70+sbG+KKDwPB9C+uIwKe1hZ4dlDdnQERMmjETqSc2KNk0IyNQZG5xlcHgJ+1eggWQg2k3NPA/MzvfUDnMkeQFttE6K8BxdOAlS1tkmAw4/GB5J
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: 7e32bc84-822a-4fc1-487c-08d589b496f0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(3008032)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:YTXPR0101MB1677;
x-ms-traffictypediagnostic: YTXPR0101MB1677:
x-microsoft-antispam-prvs: <YTXPR0101MB1677D1067D76A7297590C0D4AAD10@YTXPR0101MB1677.CANPRD01.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501244)(52105095)(3002001)(10201501046)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(2016111802025)(6072148)(6043046)(201708071742011);SRVR:YTXPR0101MB1677;BCL:0;PCL:0;RULEID:;SRVR:YTXPR0101MB1677;
x-forefront-prvs: 0611A21987
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(396003)(39380400002)(39830400003)(199004)(189003)(6116002)(2950100002)(2900100001)(66066001)(229853002)(106356001)(2906002)(110136005)(36756003)(14454004)(54906003)(3846002)(97736004)(33656002)(3280700002)(6486002)(58126008)(76176011)(478600001)(6246003)(305945005)(93886005)(6506007)(7736002)(6512007)(53936002)(25786009)(8936002)(82746002)(4326008)(8676002)(81166006)(6436002)(26005)(86362001)(105586002)(81156014)(5250100002)(316002)(186003)(3660700001)(5660300001)(99286004)(7416002)(68736007)(83716003)(102836004);DIR:OUT;SFP:1102;SCL:1;SRVR:YTXPR0101MB1677;H:YTXPR0101MB2045.CANPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: pA8UtUFSFW1Tx/lOaTi8GB8D8NfPyalGfcCvZszQsq+Fu77URISyKJZCjC1XvvXRKoQ8UNZ7G5xBuqM9qDaH1ENIISqBYlNGGuuFdyFjiW9UD3eGOMjXOUiQAk/LU+KkG8E4vDi2LTptc3u5PmcNB/PfI2J3QW6drFbr4oAwW5IRhZo1LGhzmxDztPXbV0WnWxeOlBxUL6Ky6eRJ308fE8yxV3afTXcB5hd6+r5IVla6JgjaTxjrr4QFs5EiqpwrKWIeNhamSxgZNR0P5LoTejxm3VzL9uN5WNqKsxEqaP8N8F99vWRXHJqBrEzCnj2d322DmclCQiSIzLAsBmbvvw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <4EAE1FFD2D16CE4CBB709CC99D67468E@CANPRD01.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-OriginatorOrg: raithlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e32bc84-822a-4fc1-487c-08d589b496f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2018 14:05:06.0991
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 18519031-7ff4-4cbb-bbcb-c3252d330f4b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YTXPR0101MB1677
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2EE5IMN009069

>I assume you want to exclude Root Ports because of multi-function
>  devices and the "route to self" error.  I was hoping for a reference
>  to that so I could learn more about it.

Apologies Bjorn. This slipped through my net. I will try and get you a reference for RTS in the next couple of days.
    
> While I was looking for it, I found sec 6.12.1.2 (PCIe r4.0), "ACS
> Functions in SR-IOV Capable and Multi-Function Devices", which seems
> relevant.  It talks about "peer-to-peer Requests (between Functions of
> the device)".  Thay says to me that multi-function devices can DMA
> between themselves.
    
I will go take a look. Appreciate the link.

Stephen 
