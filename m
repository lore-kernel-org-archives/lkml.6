Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752446AbeCXP2s (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 11:28:48 -0400
Received: from mail-eopbgr660118.outbound.protection.outlook.com ([40.107.66.118]:18160
        "EHLO CAN01-QB1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752302AbeCXP2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 11:28:45 -0400
From: "Stephen  Bates" <sbates@raithlin.com>
To: Bjorn Helgaas <helgaas@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>
CC: Sinan Kaya <okaya@codeaurora.org>,
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
        =?utf-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "Alex Williamson" <alex.williamson@redhat.com>
Subject: Re: [PATCH v3 01/11] PCI/P2PDMA: Support peer-to-peer memory
Thread-Topic: [PATCH v3 01/11] PCI/P2PDMA: Support peer-to-peer memory
Thread-Index: AQHTujlZo8bTZRn+4ECdETRRU1rPhqPNgjSAgADeTICAABJggIAAD1YAgAAHVACAAAJxAIAACW8AgAAO3oCAAAopgIAACqIA//+kE4CAAG7lAIANjCGAgAIVYACAAAJeAIAAYfGAgABN7gA=
Date: Sat, 24 Mar 2018 15:28:43 +0000
Message-ID: <121026DC-40C7-4F4E-BE27-BDA652BDEB6A@raithlin.com>
References: <a0af83f8-2cbc-862b-6f8b-231991527cfc@deltatee.com>
 <3ea80992-a0fc-08f2-d93d-ae0ec4e3f4ce@codeaurora.org>
 <4eb6850c-df1b-fd44-3ee0-d43a50270b53@deltatee.com>
 <757fca36-dee4-e070-669e-f2788bd78e41@codeaurora.org>
 <4f761f55-4e9a-dccb-d12f-c59d2cd689db@deltatee.com>
 <BB94077B-7EB3-49C4-862D-BF77D0A692CC@raithlin.com>
 <20180313230850.GA45763@bhelgaas-glaptop.roam.corp.google.com>
 <C90AA66C-FFC6-4CCA-B959-7BBECA65509C@raithlin.com>
 <20180323215046.GC210003@bhelgaas-glaptop.roam.corp.google.com>
 <dc414fa5-1af9-0ba7-e12e-4cd9df313119@deltatee.com>
 <20180324034947.GE210003@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180324034947.GE210003@bhelgaas-glaptop.roam.corp.google.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.b.0.180311
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sbates@raithlin.com;
x-originating-ip: [70.65.224.121]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;YTOPR0101MB0762;7:WISGhpmlndfEXA1t9pwFskMLJxwHbXizS8yTx81gL1aHJ1I+oibY39OxGh1RVUdSmuu1GS1iUGS1rRsMraPxDZoykbRf3iZRWqsze1/nv0AexeqfPuZ6wRxdFQUHgG5kmDM0zIj49D+pJ36zTn+UdZSr8NoR9MDuUn17hzOJTXQCXlSJIqtVQQydfvkWbPaI4R/nTdQYsZE9uguk8rDcmAfeoYT5m08YRMthdvsoDgjHTgTIuDuSvnWrZVeQfsvO
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 3010346b-1b94-4f84-e15c-08d5919bed66
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(3008032)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:YTOPR0101MB0762;
x-ms-traffictypediagnostic: YTOPR0101MB0762:
x-microsoft-antispam-prvs: <YTOPR0101MB07622B77D27601A5EAAF4DA7AAAF0@YTOPR0101MB0762.CANPRD01.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501327)(52105095)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(2016111802025)(6043046)(6072148)(201708071742011);SRVR:YTOPR0101MB0762;BCL:0;PCL:0;RULEID:;SRVR:YTOPR0101MB0762;
x-forefront-prvs: 0621E7E436
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(39830400003)(396003)(376002)(346002)(199004)(189003)(86362001)(8676002)(5250100002)(316002)(81166006)(81156014)(105586002)(8936002)(99286004)(54906003)(2900100001)(110136005)(36756003)(6486002)(93886005)(229853002)(2616005)(6506007)(106356001)(58126008)(53936002)(6512007)(6436002)(186003)(26005)(6246003)(66066001)(82746002)(76176011)(68736007)(102836004)(4326008)(7416002)(2906002)(5660300001)(11346002)(305945005)(7736002)(6116002)(3280700002)(25786009)(3846002)(97736004)(33656002)(14454004)(478600001)(3660700001)(446003)(83716003);DIR:OUT;SFP:1102;SCL:1;SRVR:YTOPR0101MB0762;H:YTOPR0101MB2043.CANPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: rPTrF7RTE/aENh1h7q80bnr0h2veA6zR43TUn2pd1Pjn0hEt9sjzgaS9VTdTuKY9o2lKBRXsi/aADcd7YVYw+ei7rNzbrPYkPzmKUvHqok+MN+6Z7iE5LHyADtLpC+19nwKCxCM2cfwG6VCWSYVEqajoGBpvcSCtKcbv5/z4Ny1MnMyZ6ewJ74z63jfE4s6cy78PUamdcnKmYW/KwGOU2fHmBjX2HvkwJjT9Q1wu6NTc7po9Z3QvFCjpBSVzn6KAAyuCZyWNuRA2udWnjnGpTR8PVo0+EZc8L1nS8Fee2bauJzFMbbHFOiCNvroZMdAS3oU1m0UKuRjR7mvTcLG2og==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <40F4DE2D03BE0945B1840DC8069596E8@CANPRD01.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-OriginatorOrg: raithlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3010346b-1b94-4f84-e15c-08d5919bed66
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2018 15:28:43.0756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 18519031-7ff4-4cbb-bbcb-c3252d330f4b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YTOPR0101MB0762
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2OFSrQ6004878

> That would be very nice but many devices do not support the internal
> route. 

But Logan in the NVMe case we are discussing movement within a single function (i.e. from a NVMe namespace to a NVMe CMB on the same function). Bjorn is discussing movement between two functions (PFs or VFs) in the same PCIe EP. In the case of multi-function endpoints I think the standard requires those devices to support internal DMAs for transfers between those functions (but does not require it within a function).

So I think the summary is:

1. There is no requirement for a single function to support internal DMAs but in the case of NVMe we do have a protocol specific way for a NVMe function to indicate it supports via the CMB BAR. Other protocols may also have such methods but I am not aware of them at this time.

2. For multi-function end-points I think it is a requirement that DMAs *between* functions are supported via an internal path but this can be over-ridden by ACS when supported in the EP.

3. For multi-function end-points there is no requirement to support internal DMA within each individual function (i.e. a la point 1 but extended to each function in a MF device). 

Based on my review of the specification I concur with Bjorn that p2pdma between functions in a MF end-point should be assured to be supported via the standard. However if the p2pdma involves only a single function in a MF device then we can only support NVMe CMBs for now. Let's review and see what the options are for supporting this in the next respin.

Stephen
