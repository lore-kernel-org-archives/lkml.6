Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163572AbeCAXxV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 18:53:21 -0500
Received: from mail-eopbgr670091.outbound.protection.outlook.com ([40.107.67.91]:46080
        "EHLO CAN01-TO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1163339AbeCAXxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 18:53:18 -0500
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
Thread-Index: AQHTsO2FaiSytyZxbkuik0deJPQRE6O7N/eAgABu34CAAA+TgIAAAe2AgAAMXICAADd+AP//juQAgACC8gD//4uzgA==
Date: Thu, 1 Mar 2018 23:53:16 +0000
Message-ID: <6B6A0FD9-14F5-4AF2-A74A-DAA562C34AB9@raithlin.com>
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
x-microsoft-exchange-diagnostics: 1;YTXPR0101MB2047;7:2Gc8MnJwqqeCN+Qr0IoGl93ujvQjuUO2nNEif1x6nQEJ7p5rmZ8eXDL8hgZY2IsgoHw7dLHqK8JC3mrdqqkco246+7qG3W4OlqZnJchWA2dlr4270j40h8BAwlk03kTzPhGw3TxwcYSSXZn5ntftmIz2C5xtGF1M4aoKGvX9aOc6o7eiEqPe/qQNmNxC2lMs1kvVRd5Zn0tp2g6jBI+Qq1Dv7mfk0VvAeBKnzIl1loZhTHZyOBh2hAdAHRowSjo6
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: f2924423-4e31-4a8e-80c3-08d57fcf9a14
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:YTXPR0101MB2047;
x-ms-traffictypediagnostic: YTXPR0101MB2047:
x-microsoft-antispam-prvs: <YTXPR0101MB20470933E45F426FBE2DB620AAC60@YTXPR0101MB2047.CANPRD01.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501233)(52105095)(6041288)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(2016111802025)(6072148)(6043046)(201708071742011);SRVR:YTXPR0101MB2047;BCL:0;PCL:0;RULEID:;SRVR:YTXPR0101MB2047;
x-forefront-prvs: 05986C03E0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39830400003)(366004)(396003)(346002)(376002)(39380400002)(189003)(199004)(6486002)(68736007)(6436002)(99286004)(106356001)(93886005)(229853002)(54906003)(58126008)(316002)(105586002)(76176011)(558084003)(5660300001)(305945005)(83716003)(2906002)(53936002)(6512007)(4326008)(2950100002)(7416002)(86362001)(7736002)(6916009)(36756003)(97736004)(14454004)(478600001)(6246003)(3846002)(8676002)(25786009)(6116002)(33656002)(3660700001)(82746002)(3280700002)(81156014)(8936002)(6506007)(5250100002)(66066001)(81166006)(26005)(186003)(102836004)(2900100001);DIR:OUT;SFP:1102;SCL:1;SRVR:YTXPR0101MB2047;H:YTXPR0101MB2045.CANPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: fZbEf40CP8gaenXpq8bvlja62ZyVEV2CqTjr0gcki2cX0Yc33NxkrP7spESf70sID/xrgvRLcdgpGJue3we4jYNdRb0WYOyH+oirp+TSYvgsvgsjtxvPtyuc3WyRbBQAVe/RufJI75ySsDQEJVdNZ3vpS99BWxTwSlD8aAM1t84=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <CE5E5003231A7249BAF5D29940BCCD9E@CANPRD01.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-OriginatorOrg: raithlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2924423-4e31-4a8e-80c3-08d57fcf9a14
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2018 23:53:16.1692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 18519031-7ff4-4cbb-bbcb-c3252d330f4b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YTXPR0101MB2047
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w21NrO0X001511

> There's a meaningful difference between writing to an NVMe CMB vs PMR

When the PMR spec becomes public we can discuss how best to integrate it into the P2P framework (if at all) ;-).

Stephen

    
