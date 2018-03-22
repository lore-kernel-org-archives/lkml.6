Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751755AbeCVW5j (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 18:57:39 -0400
Received: from mail-eopbgr660123.outbound.protection.outlook.com ([40.107.66.123]:21807
        "EHLO CAN01-QB1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751531AbeCVW5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 18:57:35 -0400
From: "Stephen  Bates" <sbates@raithlin.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Logan Gunthorpe <logang@deltatee.com>,
        Sinan Kaya <okaya@codeaurora.org>,
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
        =?utf-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v3 01/11] PCI/P2PDMA: Support peer-to-peer memory
Thread-Topic: [PATCH v3 01/11] PCI/P2PDMA: Support peer-to-peer memory
Thread-Index: AQHTujlZo8bTZRn+4ECdETRRU1rPhqPNgjSAgADeTICAABJggIAAD1YAgAAHVACAAAJxAIAACW8AgAAO3oCAAAopgIAACqIA//+kE4CAAG7lAIANjCGA
Date: Thu, 22 Mar 2018 22:57:32 +0000
Message-ID: <C90AA66C-FFC6-4CCA-B959-7BBECA65509C@raithlin.com>
References: <24d8e5c2-065d-8bde-3f5d-7f158be9c578@deltatee.com>
 <52cbbbc4-c488-f83f-8d02-14d455b4efd7@codeaurora.org>
 <3e738f95-d73c-4182-2fa1-8664aafb1ab7@deltatee.com>
 <703aa92c-0c1c-4852-5887-6f6e6ccde0fb@codeaurora.org>
 <a0af83f8-2cbc-862b-6f8b-231991527cfc@deltatee.com>
 <3ea80992-a0fc-08f2-d93d-ae0ec4e3f4ce@codeaurora.org>
 <4eb6850c-df1b-fd44-3ee0-d43a50270b53@deltatee.com>
 <757fca36-dee4-e070-669e-f2788bd78e41@codeaurora.org>
 <4f761f55-4e9a-dccb-d12f-c59d2cd689db@deltatee.com>
 <BB94077B-7EB3-49C4-862D-BF77D0A692CC@raithlin.com>
 <20180313230850.GA45763@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180313230850.GA45763@bhelgaas-glaptop.roam.corp.google.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.b.0.180311
x-originating-ip: [208.118.126.250]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;YTXPR0101MB1294;7:uzQ/HI7usgEvU89gWM1IEyIV9nHtYQOB7HouTXHSJ2KO199TWKRIcJt0GYsNKy/22BKs/bguaZjh44q7zGJEtd6/az6zbVazF/sWVk1hOr6OscEysExteZ/uH9bE5jDi0kcFbRaycjQQSaMhNqroT9wSCueSHyDTkbhGcpieU/BjYjPF1olub+MRvkuAdgx31zirIpxJSIvKas2XyfGRKPub1z/I5oJ8aFpciNIyP2tWeuel1pjo2fc4vem2vjg5
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 6e3c3ac9-b06a-4c87-7a91-08d590484b86
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(3008032)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:YTXPR0101MB1294;
x-ms-traffictypediagnostic: YTXPR0101MB1294:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sbates@raithlin.com;
x-microsoft-antispam-prvs: <YTXPR0101MB1294D9C14BDB8F81234B99EAAAA90@YTXPR0101MB1294.CANPRD01.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6041310)(20161123560045)(20161123558120)(20161123564045)(2016111802025)(20161123562045)(6043046)(6072148)(201708071742011);SRVR:YTXPR0101MB1294;BCL:0;PCL:0;RULEID:;SRVR:YTXPR0101MB1294;
x-forefront-prvs: 0619D53754
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39830400003)(39380400002)(346002)(366004)(396003)(376002)(199004)(189003)(54906003)(99286004)(25786009)(58126008)(14454004)(68736007)(5660300001)(4326008)(5250100002)(33656002)(2900100001)(66066001)(6512007)(11346002)(446003)(76176011)(105586002)(106356001)(6486002)(6436002)(305945005)(7416002)(3280700002)(93886005)(26005)(53936002)(3660700001)(36756003)(2906002)(82746002)(83716003)(186003)(478600001)(59450400001)(6246003)(3846002)(86362001)(97736004)(229853002)(6506007)(6916009)(8936002)(81166006)(81156014)(6116002)(7736002)(102836004)(316002)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:YTXPR0101MB1294;H:YTXPR0101MB2045.CANPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 9c8oQD3eL5+HhviUDcHM2/Jv6uEdnH6iCs4D6eiAQnjvquLOiz8MaXNh+olWZB4E9mHrk6uLFagstgF3FJEohUiUTqRfbtMiNB6WJOfPlUiX7Bjk4RM8XkdrcOlWWAieDRZxXsFz3I/Bhmx0h3w9R6RnYruKKKMI95XzCQVW9KzvZdWdecHA20hoob1Wd0tPeCwPDz1nryVqPZZmd2CeeyZpQZWWxZH8IHHRzge/iMQRJ43eQ68pC3JlR46tksQgRzuOxuBaO4PNgEzcpr69ddBaWpVxKwCn6eCABUZh0nJ6KQoM/NesF/k7dWlLFY7y6CiDBQ7ZPbT1ufpPKMalxQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <C230FA4F71874149A1702A62C570C193@CANPRD01.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-OriginatorOrg: raithlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e3c3ac9-b06a-4c87-7a91-08d590484b86
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2018 22:57:32.1161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 18519031-7ff4-4cbb-bbcb-c3252d330f4b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YTXPR0101MB1294
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2MMvjx2004166

>  I've seen the response that peers directly below a Root Port could not
> DMA to each other through the Root Port because of the "route to self"
> issue, and I'm not disputing that.  

Bjorn 

You asked me for a reference to RTS in the PCIe specification. As luck would have it I ended up in an Irish bar with Peter Onufryk this week at OCP Summit. We discussed the topic. It is not explicitly referred to as "Route to Self" and it's certainly not explicit (or obvious) but r6.2.8.1 of the PCIe 4.0 specification discusses error conditions for virtual PCI bridges. One of these conditions (given in the very first bullet in that section) applies to a request that is destined for the same port it came in on. When this occurs the request must be terminated as a UR.

Stephen
