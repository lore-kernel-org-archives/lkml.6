Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751879AbeEKVuJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 17:50:09 -0400
Received: from mail-eopbgr670131.outbound.protection.outlook.com ([40.107.67.131]:35690
        "EHLO CAN01-TO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750876AbeEKVuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 17:50:06 -0400
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
Thread-Index: AQHT21soiBVnp6SJuEuLCiH6kBzTLKQk+zIAgACHcYCAAJmxAIAABkiAgAAoBgCAAAW2gIAAA0YAgAAHvYCAAAGOgIAACKoAgACuAYCAAGxLgIAAM6EAgAFRXwD//7LJAIAAipIA//+mRQCAAGXZAIABBdKAgAB0IICAAABxAA==
Date: Fri, 11 May 2018 21:50:03 +0000
Message-ID: <A50EA568-81E7-4AD7-8C1B-1029FEA92F49@raithlin.com>
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
 <53fa38ce-40dd-6bc1-9b83-c6ccf228b755@deltatee.com>
In-Reply-To: <53fa38ce-40dd-6bc1-9b83-c6ccf228b755@deltatee.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.d.0.180505
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sbates@raithlin.com;
x-originating-ip: [70.65.250.31]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;YTXPR0101MB2079;7:n1mA30nrmyKPjOAMozsrShBlzPdyoD/Io7xz5Xaivw2pQ5BqcbyVpkWlXblR0aDkfH7bGwfP8AfI7o45S5df6ZbzH+mX+X8xtW/WagcCynoMFXfJPnAzJ9MUEStnREjepnGdFsyFUZ8LBPzRJtYKSlLEblp4qEMhtJISmuDs69+FLiJpFiO+izWr8GSdWh6I+SsGD+rHjoNCVwz2+gvWKv5Mip1/E0QobuwhczpmQ7XkOHIasmrTFTErusztl6Md
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:YTXPR0101MB2079;
x-ms-traffictypediagnostic: YTXPR0101MB2079:
x-microsoft-antispam-prvs: <YTXPR0101MB2079992EBE4BAA9C12336789AA9F0@YTXPR0101MB2079.CANPRD01.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(6043046)(201708071742011);SRVR:YTXPR0101MB2079;BCL:0;PCL:0;RULEID:;SRVR:YTXPR0101MB2079;
x-forefront-prvs: 06691A4183
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(39380400002)(376002)(366004)(39830400003)(189003)(199004)(83716003)(26005)(102836004)(82746002)(36756003)(5250100002)(7416002)(25786009)(105586002)(186003)(3846002)(106356001)(6116002)(6506007)(54906003)(14454004)(3660700001)(5660300001)(110136005)(486006)(316002)(2900100001)(3280700002)(476003)(58126008)(8676002)(4326008)(93886005)(97736004)(229853002)(33656002)(6486002)(6246003)(81166006)(53936002)(7736002)(2906002)(66066001)(6436002)(76176011)(86362001)(11346002)(305945005)(2616005)(446003)(6512007)(81156014)(8666007)(478600001)(68736007)(8936002)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:YTXPR0101MB2079;H:YTXPR0101MB2045.CANPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: ChHmlybsk5OFjbZ6uFRk5XPeUIBAFYgJfTiPuBgSR4VyfYeNNCRy6GKOIvWTsdzY8Y8H3MHNUwzPJAvAut03TyzMOPIvB4yneJpcbj/1AWCv9QVo7Xsmd1KaG5Bt9EHIddFrGcQqU89k+Y7kqTJ9YK2ygC9Hc3Rel5m6ev8kFvmB9/2d2g/YPRWX8KgNM7ud
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <DC3E61092ABA4247AB109785116EA6C5@CANPRD01.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 2b3df92a-5dda-47e0-b23b-08d5b789270e
X-OriginatorOrg: raithlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b3df92a-5dda-47e0-b23b-08d5b789270e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2018 21:50:03.5532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 18519031-7ff4-4cbb-bbcb-c3252d330f4b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YTXPR0101MB2079
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4BLoC2F014653

>    I find this hard to believe. There's always the possibility that some 
>    part of the system doesn't support ACS so if the PCI bus addresses and 
>    IOVA overlap there's a good chance that P2P and ATS won't work at all on 
>    some hardware.

I tend to agree but this comes down to how IOVA addresses are generated in the kernel. Alex (or anyone else) can you point to where IOVA addresses are generated? As Logan stated earlier, p2pdma bypasses this and programs the PCI bus address directly but other IO going to the same PCI EP may flow through the IOMMU and be programmed with IOVA rather than PCI bus addresses.
    
> I prefer 
>    the option to disable the ACS bit on boot and let the existing code put 
>    the devices into their own IOMMU group (as it should already do to 
>    support hardware that doesn't have ACS support).
    
+1

Stephen
    
