Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753147AbeCEUgJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 15:36:09 -0500
Received: from mail-eopbgr670093.outbound.protection.outlook.com ([40.107.67.93]:22304
        "EHLO CAN01-TO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752861AbeCEUgG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 15:36:06 -0500
From: "Stephen  Bates" <sbates@raithlin.com>
To: Jerome Glisse <jglisse@redhat.com>
CC: Logan Gunthorpe <logang@deltatee.com>,
        Benjamin Herrenschmidt <benh@au1.ibm.com>,
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
Thread-Index: AQHTsO2GEDgA2h38ikWGpBGerXYMdKO6wDyAgAAAX4CAAO0JAIAAKJ+AgAAHPICAAAIhAIAAAgEAgAEk1QCAAH4NgIAEJ3AA
Date: Mon, 5 Mar 2018 20:36:03 +0000
Message-ID: <F78D688D-BB93-4BFB-9F2B-9809278CC25C@raithlin.com>
References: <20180228234006.21093-1-logang@deltatee.com>
 <1519876489.4592.3.camel@kernel.crashing.org>
 <1519876569.4592.4.camel@au1.ibm.com>
 <8e808448-fc01-5da0-51e7-1a6657d5a23a@deltatee.com>
 <1519936195.4592.18.camel@au1.ibm.com> <20180301205548.GA6742@redhat.com>
 <a512edf9-2d96-9229-fe60-e0ea60b3922b@deltatee.com>
 <20180301211036.GB6742@redhat.com>
 <8D3B5C26-39E0-478D-B51F-A22B3F36C4D7@raithlin.com>
 <20180302220950.GA6148@redhat.com>
In-Reply-To: <20180302220950.GA6148@redhat.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.a.0.180210
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sbates@raithlin.com;
x-originating-ip: [70.65.224.121]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;YTXPR0101MB1118;7:D7eOeRMNV4jYFFzBKff1YaVksDWzaf07TdIzMWlOZzKgKyuH9c94sv4I7aqXuslu/Zc552tO+nuCiDsXPj2Ep6DU/9qnqlWlIvVFCpdETzwmseXwP3W05MKMn9T507lMyk+2CIgrEuDWfD3VF+5uMGhDpK62B1MZKwd/NK/lrnMOfddAmLBIvOoJhucTPJRjGHck73xWOiTYQOJ3+kvjYm9XbAaB6FC5l/vLqErw4AoC3HsDci+u9EFMzhWhL+sr
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: 0ba62dcc-6396-4c19-a1e7-08d582d8b6d7
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(3008032)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603307)(7153060)(7193020);SRVR:YTXPR0101MB1118;
x-ms-traffictypediagnostic: YTXPR0101MB1118:
x-microsoft-antispam-prvs: <YTXPR0101MB11183A5090B837E389E9973AAADA0@YTXPR0101MB1118.CANPRD01.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(6041288)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(2016111802025)(6043046)(6072148)(201708071742011);SRVR:YTXPR0101MB1118;BCL:0;PCL:0;RULEID:;SRVR:YTXPR0101MB1118;
x-forefront-prvs: 06022AA85F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(39380400002)(366004)(376002)(39830400003)(51914003)(199004)(189003)(5660300001)(7416002)(229853002)(97736004)(6916009)(3280700002)(83716003)(2950100002)(2900100001)(106356001)(68736007)(36756003)(86362001)(478600001)(6116002)(99286004)(3846002)(7736002)(14454004)(76176011)(3660700001)(26005)(66066001)(82746002)(8936002)(2906002)(81156014)(59450400001)(305945005)(105586002)(6512007)(81166006)(6506007)(6486002)(33656002)(6436002)(5250100002)(186003)(58126008)(316002)(102836004)(4326008)(54906003)(6246003)(53936002)(8676002)(93886005)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:YTXPR0101MB1118;H:YTXPR0101MB2045.CANPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: IigMF50hJYOeCB+3LnaKRTkxX8UMAWJeuiVKJ5426hKVGlMXeQmHEVcqq+Vt3r6u5oidg/2i7V0zwuu6pDRTAZ+oybFc+KEsHDDMW+cajv7x08+ynta2eezNiCqOGdA3X1/iNRDRRJ3+dU3UdXPY0bbIzPpcmvwP5AspLIc/qYCDH7MSzy5+UEBK3hU/GwaqGQTNabckGxMSyKIhvwefPFND0GPjWkR7KjOxRxN4gVnf4WM80gzjd2Sy36UfN6oM1VK8EmraZZZD+cMhFtiVVhlr4qZGzzs7tq24B4Ug2ytNN8KxXcTWeo7to4BtXtoLVUvYtIF0t0KLhcKKDTWlmg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <4BC9E074A4B8F34E8851DD6201B9BF2B@CANPRD01.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-OriginatorOrg: raithlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ba62dcc-6396-4c19-a1e7-08d582d8b6d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2018 20:36:03.4143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 18519031-7ff4-4cbb-bbcb-c3252d330f4b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YTXPR0101MB1118
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w25KaFgi018784

>    Yes i need to document that some more in hmm.txt...

Hi Jermone, thanks for the explanation. Can I suggest you update hmm.txt with what you sent out?

>  I am about to send RFC for nouveau, i am still working out some bugs.

Great. I will keep an eye out for it. An example user of hmm will be very helpful.

> i will fix the MAINTAINERS as part of those.
    
Awesome, thanks.

Stephen
    
