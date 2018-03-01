Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163297AbeCAXc4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 18:32:56 -0500
Received: from mail-eopbgr660114.outbound.protection.outlook.com ([40.107.66.114]:55373
        "EHLO CAN01-QB1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1163266AbeCAXcu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 18:32:50 -0500
From: "Stephen  Bates" <sbates@raithlin.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: Logan Gunthorpe <logang@deltatee.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "Christoph Hellwig" <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <keith.busch@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, Max Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        =?utf-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Steve Wise <swise@opengridcomputing.com>
Subject: Re: [PATCH v2 10/10] nvmet: Optionally use PCI P2P memory
Thread-Topic: [PATCH v2 10/10] nvmet: Optionally use PCI P2P memory
Thread-Index: AQHTsO2FaiSytyZxbkuik0deJPQRE6O7N/eAgABu34CAAA+TgIAAAe2AgAAMXICAADd+AP//juQAgAB64QD//44KgA==
Date: Thu, 1 Mar 2018 23:32:46 +0000
Message-ID: <2F4ADC7B-0A78-4FA3-9DE3-B20FB0C537E7@raithlin.com>
References: <20180228234006.21093-1-logang@deltatee.com>
 <20180228234006.21093-11-logang@deltatee.com>
 <749e3752-4349-0bdf-5243-3d510c2b26db@grimberg.me>
 <40d69074-31a8-d06a-ade9-90de7712c553@deltatee.com>
 <5649098f-b775-815b-8b9a-f34628873ff4@grimberg.me>
 <20180301184249.GI19007@ziepe.ca>
 <edaf476a-cfe9-0598-1aa5-14802a9a1477@deltatee.com>
 <20180301224540.GL19007@ziepe.ca>
 <77591162-4CCD-446E-A27C-1CDB4996ACB7@raithlin.com>
 <20180301232038.GO19007@ziepe.ca>
In-Reply-To: <20180301232038.GO19007@ziepe.ca>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.a.0.180210
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sbates@raithlin.com;
x-originating-ip: [70.65.224.121]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;YTXPR0101MB1070;7:Gupy1R+cHWyyoOE4eqe5WsKKbFDEL0PI1xTBvG6Yhgy7mRTvl9GY5toHNJ29SH+MFgU7P7TA5KrlEdEDK6D7oxsqnmz3UiSdKwSy7XR1u96CuDq81i1Eul6n73C7kCDdG8uUv5phiDAgT2n3Ez1iZClfyrvyG8MfxSYnQT2PT5HkDlyFmfxSiyciszkgREdqqUkwIY7i5gED8v1lSaetp16mUExyQSRFfbi34I8+LTYoS9sA0y81T1KCXSQssjPm
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: 6854f350-5661-48d0-0980-08d57fccbd16
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:YTXPR0101MB1070;
x-ms-traffictypediagnostic: YTXPR0101MB1070:
x-microsoft-antispam-prvs: <YTXPR0101MB1070724EFF0A07EBE3E87189AAC60@YTXPR0101MB1070.CANPRD01.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231220)(944501232)(52105095)(6041288)(20161123558120)(20161123562045)(2016111802025)(20161123564045)(20161123560045)(6072148)(6043046)(201708071742011);SRVR:YTXPR0101MB1070;BCL:0;PCL:0;RULEID:;SRVR:YTXPR0101MB1070;
x-forefront-prvs: 05986C03E0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(39830400003)(346002)(376002)(396003)(189003)(199004)(82746002)(5250100002)(99286004)(3280700002)(66066001)(8936002)(8676002)(81166006)(81156014)(105586002)(305945005)(4326008)(3846002)(6116002)(83716003)(229853002)(68736007)(86362001)(6506007)(102836004)(7736002)(3660700001)(2906002)(26005)(186003)(106356001)(14454004)(6486002)(36756003)(7416002)(76176011)(53936002)(25786009)(2950100002)(6916009)(6436002)(6246003)(93886005)(5660300001)(2900100001)(54906003)(6512007)(316002)(551934003)(58126008)(33656002)(97736004)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:YTXPR0101MB1070;H:YTXPR0101MB2045.CANPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: bOj4TVTBC+q+tt7lVmslLrdj9w5TK0wYPikp+H8uwZWwli0U+bMZFnxz2j3k93NMOlWY8EJUM/uDMzJ4xb7+oxJYnzex7rQXbH86ZDGkDcTVr8IU0jQljTYFTofhn9rsj0OfCWbv4VdL46Tm3ISEJVGjKcKHVUR3hfOvPNJ3uOU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <A7076C7FD2300F44B2EB75ED79F12278@CANPRD01.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-OriginatorOrg: raithlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6854f350-5661-48d0-0980-08d57fccbd16
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2018 23:32:46.4562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 18519031-7ff4-4cbb-bbcb-c3252d330f4b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YTXPR0101MB1070
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w21Nb9Qs027184

>   No, locality matters. If you have a bunch of NICs and bunch of drives
>   and the allocator chooses to put all P2P memory on a single drive your
>   performance will suck horribly even if all the traffic is offloaded.
    
Sagi brought this up earlier in his comments about the _find_ function. We are planning to do something about this in the next version. This might be a randomization or a "user-pick" and include a rule around using the p2p_dev on the EP if that EP is part of the transaction.

Stephen


    
