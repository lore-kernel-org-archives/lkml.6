Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032194AbeCAP6q (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 10:58:46 -0500
Received: from mail-eopbgr660109.outbound.protection.outlook.com ([40.107.66.109]:22645
        "EHLO CAN01-QB1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1031567AbeCAP6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 10:58:43 -0500
From: "Stephen  Bates" <sbates@raithlin.com>
To: Sagi Grimberg <sagi@grimberg.me>,
        Logan Gunthorpe <logang@deltatee.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <keith.busch@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jason Gunthorpe <jgg@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        =?utf-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "Alex Williamson" <alex.williamson@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v2 08/10] nvme-pci: Add support for P2P memory in requests
Thread-Topic: [PATCH v2 08/10] nvme-pci: Add support for P2P memory in
 requests
Thread-Index: AQHTsO2D/pI4MI4aGk+ocic9Kzv7zqO7OS2A///b9AA=
Date: Thu, 1 Mar 2018 15:58:40 +0000
Message-ID: <1CE68E79-E5FD-4EE2-BD88-B3EE57E43ACE@raithlin.com>
References: <20180228234006.21093-1-logang@deltatee.com>
 <20180228234006.21093-9-logang@deltatee.com>
 <c6639530-48ba-4655-c772-7d88a030e37e@grimberg.me>
In-Reply-To: <c6639530-48ba-4655-c772-7d88a030e37e@grimberg.me>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.a.0.180210
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sbates@raithlin.com;
x-originating-ip: [70.65.224.121]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;YTXPR0101MB1407;7:Uzz1nyyFNZgoTy7Q+AIKASIVThfr+rhk9OV1Rdpct2W+DyH/ItDeR8Y5QV2extcHb7gzm3g7aouOrsgTztnr4298S3A9eFXmaYA6cPxCDEr0vKVd040Rj2u7AuvqjU2DeMwvCCuRR+tLu+OvzhFMkaNXgxnw1Y0xkNM+LaHAdJ3ubMQ1B7lAvM+nV0GbIKR3d/jYQWSyZDKuSCoMegFxSV+i43xw6gKN37hjQTxnFVrDdGuiGsO28FT40Ysc8f/G
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: 3e5154b3-0b1e-4a54-f339-08d57f8d4d91
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:YTXPR0101MB1407;
x-ms-traffictypediagnostic: YTXPR0101MB1407:
x-microsoft-antispam-prvs: <YTXPR0101MB1407DB01283D7962832DFBD0AAC60@YTXPR0101MB1407.CANPRD01.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3231220)(944501161)(52105095)(10201501046)(93006095)(93001095)(3002001)(6041288)(20161123562045)(2016111802025)(20161123558120)(20161123564045)(20161123560045)(6072148)(6043046)(201708071742011);SRVR:YTXPR0101MB1407;BCL:0;PCL:0;RULEID:;SRVR:YTXPR0101MB1407;
x-forefront-prvs: 05986C03E0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39380400002)(376002)(396003)(39830400003)(199004)(189003)(14454004)(186003)(97736004)(5660300001)(5250100002)(6486002)(7416002)(3846002)(6116002)(53936002)(7736002)(305945005)(86362001)(102836004)(5890100001)(2501003)(6512007)(2201001)(2900100001)(26005)(6436002)(478600001)(83716003)(229853002)(3280700002)(66066001)(81156014)(81166006)(68736007)(99286004)(106356001)(3660700001)(105586002)(4326008)(8676002)(58126008)(33656002)(36756003)(316002)(25786009)(110136005)(2950100002)(8936002)(54906003)(6246003)(82746002)(2906002)(76176011)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:YTXPR0101MB1407;H:YTXPR0101MB2045.CANPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: tYM0GMfCQXDHsANv6wP7SCYJyA+jZ1I2R8yu1hC4tqWKL+C0mzMJ8E5JA+TISLVQ/J1iGzVyOVfUoyXvukk6WSUcLwhtHG5rsBPkh2gJpru6980TjhO2f219IGwS2P7MY1xsgjuMMqSiKdtlb2ld15fPZtHvopDu1kwt+04ER5g=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <B26D9242624F7941AF546D1011EA83EC@CANPRD01.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-OriginatorOrg: raithlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e5154b3-0b1e-4a54-f339-08d57f8d4d91
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2018 15:58:40.9913
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 18519031-7ff4-4cbb-bbcb-c3252d330f4b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YTXPR0101MB1407
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w21FwpvV014691

> Any plans adding the capability to nvme-rdma? Should be
> straight-forward... In theory, the use-case would be rdma backend
> fabric behind. Shouldn't be hard to test either...

Nice idea Sagi. Yes we have been starting to look at that. Though again we would probably want to impose the "attached to the same PCIe switch" rule which might be less common to satisfy in initiator systems. 

Down the road I would also like to discuss the best way to use this P2P framework to facilitate copies between NVMe namespaces (on both PCIe and fabric attached namespaces) without having to expose the CMB up to user space. Wasn't something like that done in the SCSI world at some point Martin?

Stephen
    
