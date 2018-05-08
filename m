Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756002AbeEHVfP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 17:35:15 -0400
Received: from mail-eopbgr670115.outbound.protection.outlook.com ([40.107.67.115]:35900
        "EHLO CAN01-TO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755716AbeEHVfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 17:35:12 -0400
From: "Stephen  Bates" <sbates@raithlin.com>
To: Jerome Glisse <jglisse@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>
CC: Alex Williamson <alex.williamson@redhat.com>,
        =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>,
        "Bjorn Helgaas" <helgaas@kernel.org>,
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
Thread-Index: AQHT21soiBVnp6SJuEuLCiH6kBzTLKQk+zIAgACHcYCAAJmxAIAABkiAgAAoBgCAAAW2gIAAA0YAgAAHvYCAAAGOgIAACKoA//+n/4A=
Date: Tue, 8 May 2018 21:35:08 +0000
Message-ID: <F2F18B0F-8083-4A2C-AD21-58E460F5FD1B@raithlin.com>
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
In-Reply-To: <20180508205005.GC15608@redhat.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.d.0.180505
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sbates@raithlin.com;
x-originating-ip: [70.65.250.31]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;YTXPR0101MB0829;7:7CFm4cKRlQikXp+OtDANQpb8DL2AMkKGzAXheauQO1bmMVYqXGgat1ehrfK8M6NX1bZwjAAuAYAcI9q3QGFU6CG+qDp/xQA+0IIbpVA8qB3Ag4AE6Bs3ZKWWbeLZZu12kp0NVwf7JWjOLTWeXLpkhi6VsFxrfiuoxYJUpXdb+xzIN+PUDwBd8OoU0hX5L5MKgQhs5kxYHfSHSQCIPJ676+4vWx5ky5Mwb9yDVzlUmFckCbmPrvG1SFYLxG10t+l+
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:YTXPR0101MB0829;
x-ms-traffictypediagnostic: YTXPR0101MB0829:
x-microsoft-antispam-prvs: <YTXPR0101MB08296D21144EE739C1197095AA9A0@YTXPR0101MB0829.CANPRD01.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123562045)(2016111802025)(20161123560045)(20161123564045)(20161123558120)(6043046)(6072148)(201708071742011);SRVR:YTXPR0101MB0829;BCL:0;PCL:0;RULEID:;SRVR:YTXPR0101MB0829;
x-forefront-prvs: 0666E15D35
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39830400003)(346002)(39380400002)(396003)(366004)(189003)(199004)(5660300001)(5250100002)(2906002)(33656002)(36756003)(3280700002)(25786009)(26005)(93886005)(110136005)(316002)(53936002)(66066001)(54906003)(58126008)(3660700001)(82746002)(186003)(6116002)(3846002)(4326008)(229853002)(8666007)(86362001)(102836004)(6246003)(6506007)(6436002)(97736004)(8936002)(478600001)(83716003)(2900100001)(106356001)(305945005)(105586002)(14454004)(99286004)(6486002)(68736007)(7736002)(8676002)(81156014)(81166006)(486006)(476003)(6512007)(2616005)(11346002)(7416002)(76176011)(446003)(59450400001);DIR:OUT;SFP:1102;SCL:1;SRVR:YTXPR0101MB0829;H:YTXPR0101MB2045.CANPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:3;A:1;
x-microsoft-antispam-message-info: XP5ErPwqynH6qVAQz/yvhexkAziKe+7J9Gj6051Wd8FhHc4jDYhVg1NhwLREOkhGcMnGhcojWLrUdzTs0qgoRonAnjMWK5E36IzaJiqiVb7N4uRvsnfL/NO+Yi+SrCPoSTZkHeMxZlAf2iK3dD5qvkZkHpVquItPA2teu8MTI21G7UjAa5bXCOFFQhbW59nv
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <A03863A98E0E564E87464F30DC62598A@CANPRD01.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 6ef1c870-4af7-4922-c9ab-08d5b52b921a
X-OriginatorOrg: raithlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ef1c870-4af7-4922-c9ab-08d5b52b921a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2018 21:35:08.1149
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 18519031-7ff4-4cbb-bbcb-c3252d330f4b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YTXPR0101MB0829
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w48LZIhL013647

Hi Jerome

>    I think there is confusion here, Alex properly explained the scheme
>   PCIE-device do a ATS request to the IOMMU which returns a valid
>    translation for a virtual address. Device can then use that address
>    directly without going through IOMMU for translation.

This makes sense and to be honest I now understand ATS and its interaction with ACS a lot better than I did 24 hours ago ;-).

>    ATS is implemented by the IOMMU not by the device (well device implement
>    the client side of it). Also ATS is meaningless without something like
>    PASID as far as i know.
    
I think it's the client side that is what is important to us. Not many EPs support ATS today and it's not clear if many will in the future.  So assuming we want to do p2pdma between devices (some of) which do NOT support ATS how best do we handle the ACS issue? Disabling the IOMMU seems a bit strong to me given this impacts all the PCI domains in the system and not just the domain we wish to do P2P on.

Stephen
