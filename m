Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162862AbeCAXA5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 18:00:57 -0500
Received: from mail-eopbgr670093.outbound.protection.outlook.com ([40.107.67.93]:15047
        "EHLO CAN01-TO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1162686AbeCAXAy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 18:00:54 -0500
From: "Stephen  Bates" <sbates@raithlin.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Logan Gunthorpe <logang@deltatee.com>
CC: Sagi Grimberg <sagi@grimberg.me>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <keith.busch@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, Max Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        =?utf-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "Alex Williamson" <alex.williamson@redhat.com>,
        Steve Wise <swise@opengridcomputing.com>
Subject: Re: [PATCH v2 10/10] nvmet: Optionally use PCI P2P memory
Thread-Topic: [PATCH v2 10/10] nvmet: Optionally use PCI P2P memory
Thread-Index: AQHTsO2FaiSytyZxbkuik0deJPQRE6O7N/eAgABu34CAAA+TgIAAAe2AgAAMXICAADd+AP//juQA
Date: Thu, 1 Mar 2018 23:00:51 +0000
Message-ID: <77591162-4CCD-446E-A27C-1CDB4996ACB7@raithlin.com>
References: <20180228234006.21093-1-logang@deltatee.com>
 <20180228234006.21093-11-logang@deltatee.com>
 <749e3752-4349-0bdf-5243-3d510c2b26db@grimberg.me>
 <40d69074-31a8-d06a-ade9-90de7712c553@deltatee.com>
 <5649098f-b775-815b-8b9a-f34628873ff4@grimberg.me>
 <20180301184249.GI19007@ziepe.ca>
 <edaf476a-cfe9-0598-1aa5-14802a9a1477@deltatee.com>
 <20180301224540.GL19007@ziepe.ca>
In-Reply-To: <20180301224540.GL19007@ziepe.ca>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.a.0.180210
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sbates@raithlin.com;
x-originating-ip: [70.65.224.121]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;YTXPR0101MB2174;7:d6AAoYhjdYRJfi8weMKRAm14ZjXxS5vW2sIgp5th10OxI1Ig5l0bwwixub9JP2XisEDV37po/uVN2VMq9mGydIAtTVlsPc1J0jvL4hYGyIuW0v0BaJ1v4Udi9YfwNQLjNDWUK5SJNgcBiyb+Ne91FWcl3CAZkXLaoH/8zKYYxhoN3MYCqQPq7n9JEbxdSUlwkMRMquT7EJXJhq4rv8l7RWRkZixczHEmItEZfZascWEkLSyW8hH0a4IEA3cT7mG6
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: ef9d28e1-a1fc-4e36-79f3-08d57fc84780
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:YTXPR0101MB2174;
x-ms-traffictypediagnostic: YTXPR0101MB2174:
x-microsoft-antispam-prvs: <YTXPR0101MB217435972A7CF7441F0E5F40AAC60@YTXPR0101MB2174.CANPRD01.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231220)(944501232)(93006095)(93001095)(6041288)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(2016111802025)(6072148)(6043046)(201708071742011);SRVR:YTXPR0101MB2174;BCL:0;PCL:0;RULEID:;SRVR:YTXPR0101MB2174;
x-forefront-prvs: 05986C03E0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39380400002)(366004)(396003)(39830400003)(189003)(199004)(2906002)(3280700002)(5250100002)(26005)(186003)(478600001)(6506007)(36756003)(102836004)(6486002)(2900100001)(2950100002)(53936002)(68736007)(97736004)(6246003)(6436002)(6512007)(76176011)(66066001)(14454004)(33656002)(3660700001)(99286004)(3846002)(305945005)(7736002)(5660300001)(7416002)(6116002)(4326008)(86362001)(58126008)(25786009)(54906003)(110136005)(83716003)(81166006)(229853002)(81156014)(93886005)(82746002)(106356001)(105586002)(8936002)(8676002)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:YTXPR0101MB2174;H:YTXPR0101MB2045.CANPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: ha+DeyNo5MUMyRap5JTzhpEMtbyifRhWiF91xT4tPjd6kFAvSiiYj7NHmF54rmwQSP6kod9XYwlF3e2aOobfCLhKB3x5uOAIcdi5UQc4RkJTOaliVw/vym9WNWCMbtvDX8mEoGe4qKtuIr43RfqTRwGb3Jmn433Pi8vJi8s1DMg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <FC9903984427174ABC03C58E2DA1289A@CANPRD01.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-OriginatorOrg: raithlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef9d28e1-a1fc-4e36-79f3-08d57fc84780
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2018 23:00:51.1488
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 18519031-7ff4-4cbb-bbcb-c3252d330f4b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YTXPR0101MB2174
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w21N14kT022771

>> We'd prefer to have a generic way to get p2pmem instead of restricting
>> ourselves to only using CMBs. We did work in the past where the P2P memory
 >> was part of an IB adapter and not the NVMe card. So this won't work if it's
  >> an NVMe only interface.
    
 > It just seems like it it making it too complicated.

I disagree. Having a common allocator (instead of some separate allocator per driver) makes things simpler.

> Seems like a very subtle and hard to debug performance trap to leave
> for the users, and pretty much the only reason to use P2P is
> performance... So why have such a dangerous interface?

P2P is about offloading the memory and PCI subsystem of the host CPU and this is achieved no matter which p2p_dev is used.

Stephen
    
