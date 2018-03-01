Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163602AbeCAX5s (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 18:57:48 -0500
Received: from mail-eopbgr660126.outbound.protection.outlook.com ([40.107.66.126]:48048
        "EHLO CAN01-QB1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1163538AbeCAX5p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 18:57:45 -0500
From: "Stephen  Bates" <sbates@raithlin.com>
To: Keith Busch <keith.busch@intel.com>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Logan Gunthorpe <logang@deltatee.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Bjorn Helgaas <bhelgaas@google.com>, Max Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        =?utf-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Steve Wise <swise@opengridcomputing.com>
Subject: Re: [PATCH v2 10/10] nvmet: Optionally use PCI P2P memory
Thread-Topic: [PATCH v2 10/10] nvmet: Optionally use PCI P2P memory
Thread-Index: AQHTsO2FaiSytyZxbkuik0deJPQRE6O7N/eAgABu34CAAA+TgIAAAe2AgAAMXICAADd+AP//juQAgACC8gD//4zyAA==
Date: Thu, 1 Mar 2018 23:57:43 +0000
Message-ID: <CE2A5D93-E735-4414-8DC1-B308B74A1C5B@raithlin.com>
References: <20180228234006.21093-1-logang@deltatee.com>
 <20180228234006.21093-11-logang@deltatee.com>
 <749e3752-4349-0bdf-5243-3d510c2b26db@grimberg.me>
 <40d69074-31a8-d06a-ade9-90de7712c553@deltatee.com>
 <5649098f-b775-815b-8b9a-f34628873ff4@grimberg.me>
 <20180301184249.GI19007@ziepe.ca>
 <edaf476a-cfe9-0598-1aa5-14802a9a1477@deltatee.com>
 <20180301224540.GL19007@ziepe.ca>
 <77591162-4CCD-446E-A27C-1CDB4996ACB7@raithlin.com>
 <20180301234930.GG14799@localhost.localdomain>
In-Reply-To: <20180301234930.GG14799@localhost.localdomain>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.a.0.180210
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sbates@raithlin.com;
x-originating-ip: [70.65.224.121]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;YTXPR0101MB1887;7:NkRRksvIT1kE60Y1VcL23L1aWqw7iMYHj/UQXpDNbCDWnStU/kDnX3ZAEHgK+KL3eNMEEhfar8bK6JMCuBx0CBLurXbB/E3UsSEpVhLB0EkUijBAFwWy/e+5SEYCZFYVKx4PZxVclFnfYATl1Wiqiq8hnVv9X0AJgiff3o9Qp8vniwleJ5162sCVe4zZWizkSA9Ll/KQOjaX3vbsAo77EOsIHrq3Gm9Q+EmyRnYeIXhhCRkonsroxuEGEbftIfPO
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: 5d9973e0-6c02-4088-dee0-08d57fd0394c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:YTXPR0101MB1887;
x-ms-traffictypediagnostic: YTXPR0101MB1887:
x-microsoft-antispam-prvs: <YTXPR0101MB1887CE5EA7ECB3EB3C2C9712AAC60@YTXPR0101MB1887.CANPRD01.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3002001)(3231220)(944501233)(52105095)(93006095)(93001095)(10201501046)(6041288)(20161123558120)(2016111802025)(20161123560045)(20161123562045)(20161123564045)(6072148)(6043046)(201708071742011);SRVR:YTXPR0101MB1887;BCL:0;PCL:0;RULEID:;SRVR:YTXPR0101MB1887;
x-forefront-prvs: 05986C03E0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(39830400003)(39380400002)(376002)(366004)(189003)(199004)(93886005)(66066001)(3846002)(8676002)(6116002)(2900100001)(81166006)(33656002)(105586002)(6486002)(7416002)(53936002)(2950100002)(6512007)(81156014)(6436002)(6916009)(106356001)(478600001)(5660300001)(14454004)(8936002)(186003)(82746002)(2906002)(3280700002)(316002)(58126008)(86362001)(54906003)(7736002)(26005)(99286004)(76176011)(6506007)(83716003)(102836004)(97736004)(6246003)(305945005)(229853002)(25786009)(36756003)(3660700001)(4326008)(5250100002)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:YTXPR0101MB1887;H:YTXPR0101MB2045.CANPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 9J5jXaqCY2KKnQzZLqMtCp0RsKOXQmdN/MEDiW5MS6aHr1Nj+AMjYPuPv3M+d/oYXsJio/lSjPOBYnrbfhvlvPPD5MDF1noccD7HIdWKolTWOzl53j9ykwQiiMvTBCBfnscvi4OCxgASYNPxc0ueLBc/vKD3RmR7vSU2azi/vFw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <A6AEA8246C026D45A1B4CAD6C57A79FD@CANPRD01.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-OriginatorOrg: raithlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d9973e0-6c02-4088-dee0-08d57fd0394c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2018 23:57:43.3276
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 18519031-7ff4-4cbb-bbcb-c3252d330f4b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YTXPR0101MB1887
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w21Nvw1c002015

> We don't want to lump these all together without knowing which region you're allocating from, right?

In all seriousness I do agree with you on these Keith in the long term. We would consider adding property flags for the memory as it is added to the p2p core and then the allocator could evolve to intelligently dish it out. Attributes like endurance, latency and special write commit requirements could all become attributes in time. Perhaps one more reason for a central entity for p2p memory allocation so this code does not end up having to go into many different drivers?

Stephen
    
