Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965503AbeEIQai (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 12:30:38 -0400
Received: from mail-eopbgr670139.outbound.protection.outlook.com ([40.107.67.139]:60364
        "EHLO CAN01-TO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934914AbeEIQaf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 12:30:35 -0400
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
Thread-Index: AQHT21soiBVnp6SJuEuLCiH6kBzTLKQk+zIAgACHcYCAAJmxAIAABkiAgAAoBgCAAAW2gIAAA0YAgAAHvYCAAAGOgIAACKoAgACuAYCAAGxLgP//vUwAgABrwID//6HiAA==
Date: Wed, 9 May 2018 16:30:32 +0000
Message-ID: <366A8132-B88A-40F7-BDE3-DA542E45FC0C@raithlin.com>
References: <a943a92d-15cd-fb2d-21c3-5e5cfccd9eff@amd.com>
 <3584a6ac-95c7-5d23-1859-aee30605776e@deltatee.com>
 <20180508133407.57a46902@w520.home>
 <5fc9b1c1-9208-06cc-0ec5-1f54c2520494@deltatee.com>
 <20180508141331.7cd737cb@w520.home>
 <d70cf286-f7b7-99a5-1042-022506298fed@deltatee.com>
 <20180508205005.GC15608@redhat.com>
 <7FFB9603-DF9F-4441-82E9-46037CB6C0DE@raithlin.com>
 <a1a36f88-fbfb-b5ee-6dcb-5c5bb96132dd@amd.com>
 <1775CC56-4651-422F-953A-18E024D3717C@raithlin.com>
 <20180509160722.GB4140@redhat.com>
In-Reply-To: <20180509160722.GB4140@redhat.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.d.0.180505
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sbates@raithlin.com;
x-originating-ip: [70.65.250.31]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;YTOPR0101MB1177;7:eZA0lNJN+UqPq1LfAkfG8H+6TaiGdIKfw3qMvpiD4Uk9fqa6CI0F2zuLjOc+PdVxY9tnphT3FXK8bgd/w3XOruZFDAgzfdL0/PFJ3E5XDA0AvpwyCZIufm5Ewz0NRsL/CzN8UlcDtLReFqREwF861mOdTlM6wl6uEaXIcuJdRZXQQ3QMG+m8Qh4SJa7kkwczHighM1LHjahmonYPJb4z+RlS8NCEv4AnqhrjInHDD9egGpNNUkJeKBM+LdCO9lt4
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(2017052603328)(7153060)(7193020);SRVR:YTOPR0101MB1177;
x-ms-traffictypediagnostic: YTOPR0101MB1177:
x-microsoft-antispam-prvs: <YTOPR0101MB117710289137767285DF696CAA990@YTOPR0101MB1177.CANPRD01.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(17755550239193);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(6043046)(201708071742011);SRVR:YTOPR0101MB1177;BCL:0;PCL:0;RULEID:;SRVR:YTOPR0101MB1177;
x-forefront-prvs: 0667289FF8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(396003)(346002)(39380400002)(39830400003)(189003)(199004)(66066001)(58126008)(76176011)(99286004)(2900100001)(2906002)(14454004)(2616005)(476003)(316002)(6916009)(26005)(3280700002)(102836004)(186003)(446003)(6486002)(11346002)(97736004)(6246003)(3846002)(6506007)(6116002)(106356001)(105586002)(93886005)(8666007)(5660300001)(8676002)(486006)(81156014)(8936002)(81166006)(229853002)(53936002)(36756003)(6436002)(86362001)(6512007)(478600001)(25786009)(82746002)(54906003)(68736007)(3660700001)(305945005)(4326008)(83716003)(7736002)(5250100002)(33656002)(7416002);DIR:OUT;SFP:1102;SCL:1;SRVR:YTOPR0101MB1177;H:YTOPR0101MB2043.CANPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: kzK4g5t+YlZzuwrKxLQ4+Qkw24OuDMhrsfGCymjwHGTsO9I6iLFdamn4IaV/u5xB8XXqO6BdIfY7nZFHGtoO/jo7n8dOoKYvXuc6WFJaj0+tag+PMgbYeRsQP4Jzep8n/v2DVEpuUS3apO9dRmA1hbuzg5OnZd58V/ykG3UiC34h7Yo6K3oJ+dYk4+qAFJi2
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <38BD6DAD15D12C479FC425A716586BE9@CANPRD01.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: d2911c50-e081-44ad-3d03-08d5b5ca2fa2
X-OriginatorOrg: raithlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2911c50-e081-44ad-3d03-08d5b5ca2fa2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2018 16:30:32.9351
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 18519031-7ff4-4cbb-bbcb-c3252d330f4b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YTOPR0101MB1177
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w49GUg64019936

Hi Jerome

> Now inside that page table you can point GPU virtual address
> to use GPU memory or use system memory. Those system memory entry can
> also be mark as ATS against a given PASID.
    
Thanks. This all makes sense. 

But do you have examples of this in a kernel driver (if so can you point me too it) or is this all done via user-space? Based on my grepping of the kernel code I see zero EP drivers using in-kernel ATS functionality right now...

Stephen
    
