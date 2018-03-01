Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162124AbeCAVc3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 16:32:29 -0500
Received: from mail-eopbgr670126.outbound.protection.outlook.com ([40.107.67.126]:13543
        "EHLO CAN01-TO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1161792AbeCAVcY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 16:32:24 -0500
From: "Stephen  Bates" <sbates@raithlin.com>
To: Alex Williamson <alex.williamson@redhat.com>
CC: Bjorn Helgaas <helgaas@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
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
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v2 04/10] PCI/P2PDMA: Clear ACS P2P flags for all devices
 behind switches
Thread-Topic: [PATCH v2 04/10] PCI/P2PDMA: Clear ACS P2P flags for all devices
 behind switches
Thread-Index: AQHTsO2G6rmrD21g1EKzg35eF0OenKO7rTOA//+Y6gCAAJ6tgP//jY+A
Date: Thu, 1 Mar 2018 21:32:20 +0000
Message-ID: <EE1B4EB7-D3C0-4916-81CE-E647222D03E4@raithlin.com>
References: <20180228234006.21093-1-logang@deltatee.com>
 <20180228234006.21093-5-logang@deltatee.com>
 <20180301180257.GH13722@bhelgaas-glaptop.roam.corp.google.com>
 <0D05579B-789C-4A19-B3A2-C1A630BE31C0@raithlin.com>
 <20180301142155.5966c4c0@w520.home>
In-Reply-To: <20180301142155.5966c4c0@w520.home>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.a.0.180210
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sbates@raithlin.com;
x-originating-ip: [70.65.224.121]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;YTXPR0101MB0989;6:7v8aVKK4Cx91RhqbJf4Xcc+2T6gq2UytnZeDBlLHh4y7rxbnrk/T+tv/yauq9fI5deSciVE5xpq5AkmAoia5RbkOw4JMaMXIARYQrAf07HUu2wf2b1lwuTYlsb6AGdpr/gdTI2ySxacpkMbW1joAm9V351SoyeC+Rewhk8zHVtefamXVStlqeDLfq/C2bwcSYj+rzq3x2Z2V1sdc0sq/I3HJKZoVSC/5Ewb8l+nQe+5gTOnNVRN7KvVXTv9627WvstgCS7tzJMZ5FETErKG99SuV8Z3JsI1o2waeQbSVjYMypLxz8ZDb+QdXaG6Gbuq/BVmkSihMLZLInW3mzqzTQ7CQd4TCMUm+sKh+Qa4eqcg0QmGfKC3WVyG2O1U/izvJ;5:pqcy2/Zs9OY3spNfMAjQyJ4YE2PD9CXlVLRpDH+z1eWIaiQGEGaq7rrbjpTuWVLKAEYIZKPUbUNXebcn/X+RSspvn2vGcMyFBSz2a2F3Hbl2GN0S1Swae0l14YRtMDxJMP8pDmilN2sCZ3NMNLptO/NPyus7KIiJO4NradzreKg=;24:Y+TVG7p0WvOAhl5jYDGLUuZRWhh8tt6bDVoZXhnVJ6m5bwdJoj/ctxKpBVKGeyRM5K+L4KlBwEkaNdG5ueiaRjw1smGXVfNDcneI4ur2CnU=;7:cc9dTgDgzfWaYjbOUXOp82BJkTaYjAKw8sfSIplr97lmU3HwNIQgyfR6Nk6N3SJKvjOZlFF9q9SHRwAq7COCf4h7VSYC22VjivAyMiZNjQtGiqe0yRtEOjAKoapdSouGWL+UHMAPKQQJPPZUZE5rWxsg/Ag24sOt/R6jQWbE9CN8Dc+mzw6bAJTFZcf3LLx3rioy9q8VPHySYIpmyoSrsVmzru8AlWPZSewIsHnRx0MiBB0tggIACpP195Qs+Sw/
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: cdeed6be-1cf7-43c8-a0c3-08d57fbbea3f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:YTXPR0101MB0989;
x-ms-traffictypediagnostic: YTXPR0101MB0989:
x-microsoft-antispam-prvs: <YTXPR0101MB0989C894EAEF8B45A3829563AAC60@YTXPR0101MB0989.CANPRD01.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3002001)(3231220)(944501231)(52105095)(93006095)(93001095)(10201501046)(6041288)(20161123560045)(20161123564045)(20161123562045)(2016111802025)(20161123558120)(6043046)(6072148)(201708071742011);SRVR:YTXPR0101MB0989;BCL:0;PCL:0;RULEID:;SRVR:YTXPR0101MB0989;
x-forefront-prvs: 05986C03E0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39830400003)(396003)(39380400002)(346002)(376002)(189003)(199004)(4326008)(3280700002)(2906002)(97736004)(6116002)(5250100002)(106356001)(93886005)(6916009)(2900100001)(229853002)(83716003)(66066001)(6512007)(53936002)(2950100002)(82746002)(86362001)(81156014)(6246003)(6436002)(8936002)(8676002)(6486002)(81166006)(68736007)(305945005)(7416002)(102836004)(7736002)(316002)(33656002)(5660300001)(3660700001)(36756003)(105586002)(76176011)(14454004)(54906003)(3846002)(478600001)(186003)(26005)(6506007)(99286004)(58126008)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:YTXPR0101MB0989;H:YTXPR0101MB2045.CANPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: iiUoH3haK7dkaP/WlJvTdMOGCt4otagI6hAu3XSxbLzYI52iC4l/E6ZIldGftPsUHpPdQ/gzrA5KR+1qx0aUZ1NIiMRnpZ/zUfT2+Y46lCikjaD967veoUm3RYdkOBggsRDwh/orrx6eg51Yns41djEE2+teqkWgP8jQmtb26/A=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <6EA528C75EDB254F991BBE0327689534@CANPRD01.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-OriginatorOrg: raithlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdeed6be-1cf7-43c8-a0c3-08d57fbbea3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2018 21:32:20.7818
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 18519031-7ff4-4cbb-bbcb-c3252d330f4b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YTXPR0101MB0989
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w21LWbtM024943

> your kernel provider needs to decide whether they favor device assignment or p2p

Thanks Alex! The hardware requirements for P2P (switch, high performance EPs) are such that we really only expect CONFIG_P2P_DMA to be enabled in specific instances and in those instances the users have made a decision to favor P2P over IOMMU isolation. Or they have setup their PCIe topology in a way that gives them IOMMU isolation where they want it and P2P where they want it.

Stephen
 
