Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934172AbeCBViv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 16:38:51 -0500
Received: from mail-eopbgr670120.outbound.protection.outlook.com ([40.107.67.120]:34080
        "EHLO CAN01-TO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933995AbeCBVis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 16:38:48 -0500
From: "Stephen  Bates" <sbates@raithlin.com>
To: Jerome Glisse <jglisse@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>
CC: Benjamin Herrenschmidt <benh@au1.ibm.com>,
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
        Alex Williamson <alex.williamson@redhat.com>,
        Oliver OHalloran <oliveroh@au1.ibm.com>
Subject: Re: [PATCH v2 00/10] Copy Offload in NVMe Fabrics with P2P PCI Memory
Thread-Topic: [PATCH v2 00/10] Copy Offload in NVMe Fabrics with P2P PCI
 Memory
Thread-Index: AQHTsO2GEDgA2h38ikWGpBGerXYMdKO6wDyAgAAAX4CAAO0JAIAAKJ+AgAAHPICAAAIhAIAAAgEAgAEk1QA=
Date: Fri, 2 Mar 2018 21:38:43 +0000
Message-ID: <8D3B5C26-39E0-478D-B51F-A22B3F36C4D7@raithlin.com>
References: <20180228234006.21093-1-logang@deltatee.com>
 <1519876489.4592.3.camel@kernel.crashing.org>
 <1519876569.4592.4.camel@au1.ibm.com>
 <8e808448-fc01-5da0-51e7-1a6657d5a23a@deltatee.com>
 <1519936195.4592.18.camel@au1.ibm.com> <20180301205548.GA6742@redhat.com>
 <a512edf9-2d96-9229-fe60-e0ea60b3922b@deltatee.com>
 <20180301211036.GB6742@redhat.com>
In-Reply-To: <20180301211036.GB6742@redhat.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.a.0.180210
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sbates@raithlin.com;
x-originating-ip: [70.65.224.121]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;YTXPR0101MB1312;7:3zSrt6Czejpic+k5Q1Osp99XvmT0mWXKw9GtAhfI9UWO26JtdWmqhIot/+Gsua0FKlJJN0ngEiQRgn6QkYszfsVdPtpsO/z4xgeZKlxlGXbrXb851eRNzXdtAVVzd9Rma/AiB2YwfeHtJc02OwhIXnyubfvcFIqVeNN04w2xp2LezAfsMkTi2ElVUQ8yFrew1udkWLEdgGMdT9ykyXrqG9nVC5UtTA2Umf/PNR0nrebG1twWFtttM/cSFhgThdSs
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: 1e31f900-c836-4461-224f-08d58085f8de
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:YTXPR0101MB1312;
x-ms-traffictypediagnostic: YTXPR0101MB1312:
x-microsoft-antispam-prvs: <YTXPR0101MB13128A37C4137616D9FFE7E2AAC50@YTXPR0101MB1312.CANPRD01.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(6041288)(2016111802025)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(6072148)(6043046)(201708071742011);SRVR:YTXPR0101MB1312;BCL:0;PCL:0;RULEID:;SRVR:YTXPR0101MB1312;
x-forefront-prvs: 05991796DF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39380400002)(39830400003)(396003)(366004)(199004)(189003)(305945005)(6506007)(81166006)(97736004)(81156014)(4326008)(3846002)(33656002)(93886005)(8676002)(6116002)(25786009)(105586002)(59450400001)(6246003)(7416002)(102836004)(8936002)(229853002)(82746002)(5660300001)(3660700001)(99286004)(2906002)(66066001)(106356001)(3280700002)(7736002)(2950100002)(478600001)(76176011)(86362001)(68736007)(110136005)(54906003)(6436002)(5250100002)(186003)(58126008)(6512007)(316002)(83716003)(26005)(36756003)(6486002)(53936002)(2900100001)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:YTXPR0101MB1312;H:YTXPR0101MB2045.CANPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: sATQ4mfaUERoJ14bannfFllG281RUrqmAlzjO1cyLrqrQd+T2vpYrpo4Krpn1UUwkiOUPd6sswLceUFrbarf5W4hv3faTy6a5VSvwNaw1zdRICN+IJZuZHyi++oAxFw9ihOUp/8PLqKn8MzXrce1l9COaI19DTsNivUQlEIrJ8Q=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <0AF11F09DBD48946B0DE6C3030518A52@CANPRD01.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-OriginatorOrg: raithlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e31f900-c836-4461-224f-08d58085f8de
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2018 21:38:43.6481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 18519031-7ff4-4cbb-bbcb-c3252d330f4b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YTXPR0101MB1312
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w22LeT3P005425

> It seems people miss-understand HMM :( 

Hi Jerome

Your unhappy face emoticon made me sad so I went off to (re)read up on HMM. Along the way I came up with a couple of things.

While hmm.txt is really nice to read it makes no mention of DEVICE_PRIVATE and DEVICE_PUBLIC. It also gives no indication when one might choose to use one over the other. Would it be possible to update hmm.txt to include some discussion on this? I understand that DEVICE_PUBLIC creates a mapping in the kernel's linear address space for the device memory and DEVICE_PRIVATE does not. However, like I said, I am not sure when you would use either one and the pros and cons of doing so. I actually ended up finding some useful information in memremap.h but I don't think it is fair to expect people to dig *that* deep to find this information ;-).

A quick grep shows no drivers using the HMM API in the upstream code today. Is this correct? Are there any examples of out of tree drivers that use HMM you can point me too? As a driver developer what resources exist to help me write a HMM aware driver?

The (very nice) hmm.txt document is not references in the MAINTAINERS file? You might want to fix that when you have a moment.

Stephen
