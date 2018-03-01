Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161102AbeCATBi (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 14:01:38 -0500
Received: from mail-eopbgr670139.outbound.protection.outlook.com ([40.107.67.139]:20499
        "EHLO CAN01-TO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1161038AbeCATBe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 14:01:34 -0500
From: "Stephen  Bates" <sbates@raithlin.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Sagi Grimberg <sagi@grimberg.me>
CC: Logan Gunthorpe <logang@deltatee.com>,
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
Thread-Index: AQHTsO2FaiSytyZxbkuik0deJPQRE6O7N/eAgABu34CAAA+TgIAAAe2A//+P4AA=
Date: Thu, 1 Mar 2018 19:01:31 +0000
Message-ID: <88ACB0F6-DE78-400B-A42C-953B49026FA2@raithlin.com>
References: <20180228234006.21093-1-logang@deltatee.com>
 <20180228234006.21093-11-logang@deltatee.com>
 <749e3752-4349-0bdf-5243-3d510c2b26db@grimberg.me>
 <40d69074-31a8-d06a-ade9-90de7712c553@deltatee.com>
 <5649098f-b775-815b-8b9a-f34628873ff4@grimberg.me>
 <20180301184249.GI19007@ziepe.ca>
In-Reply-To: <20180301184249.GI19007@ziepe.ca>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.a.0.180210
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sbates@raithlin.com;
x-originating-ip: [70.65.224.121]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;YTXPR0101MB2175;7:wk35WZxhj423mOj3ftFUYGeNdz+wFACacE4NJL/KphH0NHLrsvN6USU4oMRztxi9TbfIpQrwEbSD3Sxk2Z1H8S+7BNw1O1xQA6MG2YiaHgbkFVYsWpfAELr/LxcvC1qcEVqAls8mKvw1R9tXW8j9on6JDiNrFBZ3W+D9B4yq1wmzg090qKtYo/2b4UjbJLPvhjnFodyqpWDIThG3AovmcF62K2SVYloRmsUP/eyPXXZxGOKhPVIpmMMGA/pAs4h4
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: 4ac8ffd1-422d-4724-6ba6-08d57fa6d86f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:YTXPR0101MB2175;
x-ms-traffictypediagnostic: YTXPR0101MB2175:
x-microsoft-antispam-prvs: <YTXPR0101MB2175DCD7E484A7AEC7CBD5DDAAC60@YTXPR0101MB2175.CANPRD01.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231220)(944501230)(93006095)(93001095)(6041288)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(2016111802025)(6072148)(6043046)(201708071742011);SRVR:YTXPR0101MB2175;BCL:0;PCL:0;RULEID:;SRVR:YTXPR0101MB2175;
x-forefront-prvs: 05986C03E0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(39830400003)(366004)(346002)(376002)(396003)(39380400002)(199004)(189003)(478600001)(4326008)(36756003)(3280700002)(2950100002)(3660700001)(14454004)(2900100001)(5660300001)(25786009)(186003)(2906002)(83716003)(102836004)(68736007)(86362001)(3846002)(26005)(105586002)(5250100002)(82746002)(106356001)(6246003)(76176011)(58126008)(316002)(110136005)(229853002)(53936002)(66066001)(93886005)(54906003)(6436002)(8936002)(97736004)(6506007)(81156014)(81166006)(8676002)(99286004)(6116002)(6486002)(6512007)(33656002)(7416002)(7736002)(59450400001)(305945005)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:YTXPR0101MB2175;H:YTXPR0101MB2045.CANPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: PKDg37yzkWtFKHYwa+y+I7DeirDq0xH3a/gbpLPflt9rE/sNrkAeS1vALJFX2em2Huu4F4+VArGdOtd96/gOLOIPmrKF84/RDc7irAESaBWRwcA1LvGOKi4m1rOnz4Y/5MMiCW4VbzafWHfC9R8CdN0zYrh3hPHYbCOaljxmzHY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <5C68F77BF855DE4FBF4EC3C4242D66B8@CANPRD01.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-OriginatorOrg: raithlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ac8ffd1-422d-4724-6ba6-08d57fa6d86f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2018 19:01:31.4351
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 18519031-7ff4-4cbb-bbcb-c3252d330f4b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YTXPR0101MB2175
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w21J1t2X022255

    
> I agree, I don't think this series should target anything other than
> using p2p memory located in one of the devices expected to participate
> in the p2p trasnaction for a first pass..

I disagree. There is definitely interest in using a NVMe CMB as a bounce buffer and in deploying systems where only some of the NVMe SSDs below a switch  have a CMB but use P2P to access all of them. Also there are some devices that only expose memory and their entire purpose is to act as a p2p device, supporting these devices would be valuable.
    
> locality is super important for p2p, so I don't think things should
>  start out in a way that makes specifying the desired locality hard.

Ensuring that the EPs engaged in p2p are all directly connected to the same PCIe switch ensures locality and (for the switches we have tested) performance. I agree solving the case where the namespace are CMB are on the same PCIe EP is valuable but I don't see it as critical to initial acceptance of the series.
    
Stephen
    
