Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965244AbeEJOQa (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 10:16:30 -0400
Received: from mail-eopbgr670124.outbound.protection.outlook.com ([40.107.67.124]:17888
        "EHLO CAN01-TO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751632AbeEJOQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 10:16:27 -0400
From: "Stephen  Bates" <sbates@raithlin.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>,
        "Logan Gunthorpe" <logang@deltatee.com>,
        Jerome Glisse <jglisse@redhat.com>
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
Thread-Index: AQHT21soiBVnp6SJuEuLCiH6kBzTLKQk+zIAgACHcYCAAJmxAIAABkiAgAAoBgCAAAW2gIAAA0YAgAAHvYCAAAGOgIAACKoAgACuAYCAAGxLgIAAM6EAgAFRXwD//7LJAA==
Date: Thu, 10 May 2018 14:16:25 +0000
Message-ID: <94C8FE12-7FC3-48BD-9DCA-E6A427E71810@raithlin.com>
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
In-Reply-To: <2fc61d29-9eb4-d168-a3e5-955c36e5d821@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.d.0.180505
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sbates@raithlin.com;
x-originating-ip: [70.65.250.31]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;YTXPR0101MB2208;7:ISRYmJlqp2f3h4wmrkRK0P1Fw1XVWF140UgKnVFLTc1lev65KSyQNUx0gJkbGegACMfN8ewauSAT3zQhQRJt6Bbn3uXgfTy/8WzV93ckrbB55y2zmTsc81Q0XoCP7zP1ZUYvACGXiVLXvqjVoK5v0f/LMwqk5mwIlKJmb1WcXbC9q9P3oDzbl5iF3HKkOdXSUpLcpZqxdIH7sKMbZwB/FNhg81+sMGxiMFAH087Wj7DpKwPX3uuydX7nLAppV6ga
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:YTXPR0101MB2208;
x-ms-traffictypediagnostic: YTXPR0101MB2208:
x-microsoft-antispam-prvs: <YTXPR0101MB22089A0CD8164338A2F08657AA980@YTXPR0101MB2208.CANPRD01.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123564045)(2016111802025)(20161123558120)(6043046)(6072148)(201708071742011);SRVR:YTXPR0101MB2208;BCL:0;PCL:0;RULEID:;SRVR:YTXPR0101MB2208;
x-forefront-prvs: 066898046A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(366004)(346002)(376002)(39830400003)(199004)(189003)(5660300001)(106356001)(82746002)(76176011)(8666007)(6506007)(3660700001)(3280700002)(36756003)(86362001)(7416002)(7736002)(59450400001)(305945005)(316002)(476003)(551934003)(6512007)(8936002)(93886005)(110136005)(4326008)(5250100002)(105586002)(8676002)(14454004)(102836004)(33656002)(99286004)(2616005)(81156014)(53936002)(81166006)(58126008)(68736007)(6246003)(486006)(6436002)(3846002)(478600001)(2900100001)(186003)(26005)(2906002)(11346002)(66066001)(25786009)(6486002)(229853002)(54906003)(446003)(83716003)(97736004)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:YTXPR0101MB2208;H:YTXPR0101MB2045.CANPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: GotIUAyq4g4xIBdVvcM6KTrjk4ZP5rbFq6SPaG09IpprNscBY+ECcboNJA3Jb+f3IrjyMxsbPM0eloLu9qFgrUJBxBxRuYJk9GPV6tzXnyCkejaMA3FoRLXJ0HkJpp+qA0SdYOx6ysob7JyAiqG+o945a2zmDF9ezwvM+2mwHNxzps/A1s4f65G6b5UEIZLb
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <4858772BB9243E4A80EF7F3CBE813FD7@CANPRD01.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: cde41a96-a94e-4cbb-5b72-08d5b6809d34
X-OriginatorOrg: raithlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cde41a96-a94e-4cbb-5b72-08d5b6809d34
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2018 14:16:25.1066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 18519031-7ff4-4cbb-bbcb-c3252d330f4b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YTXPR0101MB2208
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4AEGq5n003389

Hi Christian

> Why would a switch not identify that as a peer address? We use the PASID 
>    together with ATS to identify the address space which a transaction 
>    should use.

I think you are conflating two types of TLPs here. If the device supports ATS then it will issue a TR TLP to obtain a translated address from the IOMMU. This TR TLP will be addressed to the RP and so regardless of ACS it is going up to the Root Port. When it gets the response it gets the physical address and can use that with the TA bit set for the p2pdma. In the case of ATS support we also have more control over ACS as we can disable it just for TA addresses (as per 7.7.7.7.2 of the spec).
    
 >   If I'm not completely mistaken when you disable ACS it is perfectly 
 >   possible that a bridge identifies a transaction as belonging to a peer 
 >   address, which isn't what we want here.
   
You are right here and I think this illustrates a problem for using the IOMMU at all when P2PDMA devices do not support ATS. Let me explain:

If we want to do a P2PDMA and the DMA device does not support ATS then I think we have to disable the IOMMU (something Mike suggested earlier). The reason is that since ATS is not an option the EP must initiate the DMA using the addresses passed down to it. If the IOMMU is on then this is an IOVA that could (with some non-zero probability) point to an IO Memory address in the same PCI domain. So if we disable ACS we are in trouble as we might MemWr to the wrong place but if we enable ACS we lose much of the benefit of P2PDMA. Disabling the IOMMU removes the IOVA risk and ironically also resolves the IOMMU grouping issues.

So I think if we want to support performant P2PDMA for devices that don't have ATS (and no NVMe SSDs today support ATS) then we have to disable the IOMMU. I know this is problematic for AMDs use case so perhaps we also need to consider a mode for P2PDMA for devices that DO support ATS where we can enable the IOMMU (but in this case EPs without ATS cannot participate as P2PDMA DMA iniators).

Make sense?

Stephen
 
    
    
