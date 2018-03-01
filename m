Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033818AbeCASKD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 13:10:03 -0500
Received: from mail-eopbgr670097.outbound.protection.outlook.com ([40.107.67.97]:43462
        "EHLO CAN01-TO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1033196AbeCASKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 13:10:00 -0500
From: "Stephen  Bates" <sbates@raithlin.com>
To: "benh@au1.ibm.com" <benh@au1.ibm.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jason Gunthorpe <jgg@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        =?utf-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Oliver OHalloran <oliveroh@au1.ibm.com>
Subject: Re: [PATCH v2 00/10] Copy Offload in NVMe Fabrics with P2P PCI Memory
Thread-Topic: [PATCH v2 00/10] Copy Offload in NVMe Fabrics with P2P PCI
 Memory
Thread-Index: AQHTsO2GEDgA2h38ikWGpBGerXYMdKO6wDyAgAAAX4CAAHk0gA==
Date: Thu, 1 Mar 2018 18:09:58 +0000
Message-ID: <B4151146-0490-40D4-BB0A-4FC9DE5841A4@raithlin.com>
References: <20180228234006.21093-1-logang@deltatee.com>
 <1519876489.4592.3.camel@kernel.crashing.org>
 <1519876569.4592.4.camel@au1.ibm.com>
In-Reply-To: <1519876569.4592.4.camel@au1.ibm.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.a.0.180210
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sbates@raithlin.com;
x-originating-ip: [70.65.224.121]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;YTXPR0101MB1374;7:ezud7qeYcBiS8K9SI1Z6b3sHPxN14JafUGh6JukL2v82G1UJ5NQTZxkd0rPMUyngUw6MjwOIkxFrCr7GMPM0ckg8aM26sepK2qycP1qJ1BpQbeIxeOL04QPvhQIyalfn254vNSOpOCR1kQfuMm2/f2aSZyhBz6hJvSKTlj2ERLH8Ybi4UJdu/pCTOeBe6w+p4jBRqwWGIFeV55JxrPkbPbzQ9US1KtGU2uhfamdqFX73ZoJJx7pdSbMVidJ8wgks
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: 77d2326a-1236-42d9-ec7f-08d57f9fa4cb
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:YTXPR0101MB1374;
x-ms-traffictypediagnostic: YTXPR0101MB1374:
x-microsoft-antispam-prvs: <YTXPR0101MB1374C066B365620DBD836C0CAAC60@YTXPR0101MB1374.CANPRD01.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3231220)(944501230)(52105095)(10201501046)(93006095)(93001095)(3002001)(6041288)(20161123564045)(20161123560045)(2016111802025)(20161123562045)(20161123558120)(6072148)(6043046)(201708071742011);SRVR:YTXPR0101MB1374;BCL:0;PCL:0;RULEID:;SRVR:YTXPR0101MB1374;
x-forefront-prvs: 05986C03E0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39830400003)(366004)(376002)(396003)(39380400002)(199004)(189003)(82746002)(66066001)(6512007)(186003)(53936002)(229853002)(6246003)(3280700002)(3660700001)(6436002)(25786009)(68736007)(2201001)(83716003)(4326008)(99286004)(5660300001)(6486002)(478600001)(8676002)(33656002)(2501003)(305945005)(81156014)(76176011)(5250100002)(58126008)(7736002)(97736004)(81166006)(316002)(8936002)(14454004)(36756003)(2900100001)(7416002)(106356001)(6116002)(102836004)(2906002)(3846002)(54906003)(105586002)(110136005)(26005)(2950100002)(6506007)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:YTXPR0101MB1374;H:YTXPR0101MB2045.CANPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: I/oGuIfdUa5qc9BeJKZHa/NWQxnfGj5gCR8oF3OUDFpq4ct91+xPSNRoOMj4HfvtR+xXmMUBWXkHSTRoea5rcY3goRy76iLB6EXxN8HEL6b5Ofp2Auj00MKgUjkUDGdaed8/rMktfOiFN9ZM9HwMsQb/6JTMStQPz33OmF30DcM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <BE9423C2497B2D42829F0043A0C1D971@CANPRD01.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-OriginatorOrg: raithlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77d2326a-1236-42d9-ec7f-08d57f9fa4cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2018 18:09:58.3523
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 18519031-7ff4-4cbb-bbcb-c3252d330f4b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YTXPR0101MB1374
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w21IAExO001076

>> So Oliver (CC) was having issues getting any of that to work for us.
>> 
>> The problem is that acccording to him (I didn't double check the latest
>> patches) you effectively hotplug the PCIe memory into the system when
>> creating struct pages.
>> 
>> This cannot possibly work for us. First we cannot map PCIe memory as
>> cachable. (Note that doing so is a bad idea if you are behind a PLX
>> switch anyway since you'd ahve to manage cache coherency in SW).
>   
>   Note: I think the above means it won't work behind a switch on x86
>   either, will it ?
 
Ben 

We have done extensive testing of this series and its predecessors using PCIe switches from both Broadcom (PLX) and Microsemi. We have also done testing on x86_64, ARM64 and ppc64el based ARCH with varying degrees of success. The series as it currently stands only works on x86_64 but modified (hacky) versions have been made to work on ARM64. The x86_64 testing has been done on a range of (Intel) CPUs, servers, PCI EPs (including RDMA NICs from at least three vendors, NVMe SSDs from at least four vendors and P2P devices from four vendors) and PCI switches.

I do find it slightly offensive that you would question the series even working. I hope you are not suggesting we would submit this framework multiple times without having done testing on it....

Stephen
