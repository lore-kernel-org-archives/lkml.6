Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751698AbeEKWZF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 18:25:05 -0400
Received: from mail-eopbgr660104.outbound.protection.outlook.com ([40.107.66.104]:15447
        "EHLO CAN01-QB1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750972AbeEKWZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 18:25:03 -0400
From: "Stephen  Bates" <sbates@raithlin.com>
To: Logan Gunthorpe <logang@deltatee.com>,
        =?iso-8859-1?Q?Christian_K=F6nig?= <christian.koenig@amd.com>,
        Jerome Glisse <jglisse@redhat.com>
CC: Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        "Bjorn Helgaas" <helgaas@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Max Gurtovoy <maxg@mellanox.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v4 04/14] PCI/P2PDMA: Clear ACS P2P flags for all devices
 behind switches
Thread-Topic: [PATCH v4 04/14] PCI/P2PDMA: Clear ACS P2P flags for all devices
 behind switches
Thread-Index: AQHT21soiBVnp6SJuEuLCiH6kBzTLKQk+zIAgACHcYCAAJmxAIAABkiAgAAoBgCAAAW2gIAAA0YAgAAHvYCAAAGOgIAACKoAgACuAYCAAGxLgIAAM6EAgAFRXwD//7LJAIAAipIA//+mRQCAAGXZAIABBdKAgAB0IICAAABxAIAAbW6N
Date: Fri, 11 May 2018 22:24:59 +0000
Message-ID: <YTXPR0101MB2045DC0248A9B125CA276969AA9F0@YTXPR0101MB2045.CANPRD01.PROD.OUTLOOK.COM>
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
 <868B49CE-4F0E-4A48-BE78-12149F85F1A4@raithlin.com>
 <8113cba8-62b9-1801-7a77-f82be223b183@deltatee.com>
 <cf2b92c9-7c5b-f19c-b5b1-2f2d435296d1@amd.com>
 <53fa38ce-40dd-6bc1-9b83-c6ccf228b755@deltatee.com>,<A50EA568-81E7-4AD7-8C1B-1029FEA92F49@raithlin.com>
In-Reply-To: <A50EA568-81E7-4AD7-8C1B-1029FEA92F49@raithlin.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sbates@raithlin.com;
x-originating-ip: [70.65.250.31]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;YTXPR0101MB0861;7:9NSHzJfNkq49dXe8Qyd4wgtU1Xfs7qTo4+z9zBhI5fTTn8nKrH6sfDFy2ncMDaUdcY1DGVK3YfIACUNt+xBOwnktH0tm7oHxiu0oUeAUncv4ndQYpZFrVll59QouvXZ7dbfyzJWzXCL9feraZKNp6b17iIcWn060Vz/yEQ/sDAc6l1Eywaq4C9mKxCwnUQ2hP7SaC6SZphjPieAO19Zo5M0cZuRcItxYB61ZPyKG4UtVBUbskenTWXY27lZCXwZL
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(2017052603328)(7153060)(7193020);SRVR:YTXPR0101MB0861;
x-ms-traffictypediagnostic: YTXPR0101MB0861:
x-microsoft-antispam-prvs: <YTXPR0101MB0861A0F717F1B04600D300AEAA9F0@YTXPR0101MB0861.CANPRD01.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123564045)(2016111802025)(20161123558120)(6072148)(6043046)(201708071742011);SRVR:YTXPR0101MB0861;BCL:0;PCL:0;RULEID:;SRVR:YTXPR0101MB0861;
x-forefront-prvs: 06691A4183
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(376002)(366004)(396003)(39830400003)(199004)(189003)(97736004)(478600001)(2900100001)(66066001)(3280700002)(33656002)(3660700001)(2906002)(966005)(6116002)(3846002)(55016002)(6306002)(105586002)(106356001)(14454004)(99286004)(6246003)(9686003)(8676002)(25786009)(4326008)(486006)(8936002)(53936002)(5660300001)(8666007)(229853002)(316002)(7696005)(81166006)(81156014)(93886005)(7736002)(26005)(5250100002)(6506007)(102836004)(86362001)(11346002)(68736007)(74316002)(110136005)(446003)(305945005)(7416002)(186003)(54906003)(476003)(76176011)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:YTXPR0101MB0861;H:YTXPR0101MB2045.CANPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 6wtHzYywVa12l3lUNLt0FJXYizRqAQNrhcY/JQyBF4ossnwRzbLznTFvvxLgC0xyGeuKm4DeW3QQ6/PLPhK7CsSAbxZiNtD/Cc7TjPIlbEOOCGu6K6cMnn4OoK7+21PBnbcIPlzr3Wek/bb/Hfhy+Br094EE64SD9k35QwwEt3bMB94C2y5/Bo/5Ctmy1OO/
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 222d56dd-221d-4a17-2249-08d5b78e089a
X-OriginatorOrg: raithlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 222d56dd-221d-4a17-2249-08d5b78e089a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2018 22:24:59.9570
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 18519031-7ff4-4cbb-bbcb-c3252d330f4b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YTXPR0101MB0861
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4BMPBLd014769

All

> Alex (or anyone else) can you point to where IOVA addresses are generated?

A case of RTFM perhaps (though a pointer to the code would still be appreciated).

https://www.kernel.org/doc/Documentation/Intel-IOMMU.txt

Some exceptions to IOVA
-----------------------
Interrupt ranges are not address translated, (0xfee00000 - 0xfeefffff).
The same is true for peer to peer transactions. Hence we reserve the
address from PCI MMIO ranges so they are not allocated for IOVA addresses.

Cheers

Stephen
