Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932480AbeCMWcB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 18:32:01 -0400
Received: from mail-eopbgr660108.outbound.protection.outlook.com ([40.107.66.108]:6604
        "EHLO CAN01-QB1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751300AbeCMWb6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 18:31:58 -0400
From: "Stephen  Bates" <sbates@raithlin.com>
To: Logan Gunthorpe <logang@deltatee.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jason Gunthorpe <jgg@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        =?utf-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v3 01/11] PCI/P2PDMA: Support peer-to-peer memory
Thread-Topic: [PATCH v3 01/11] PCI/P2PDMA: Support peer-to-peer memory
Thread-Index: AQHTujlZo8bTZRn+4ECdETRRU1rPhqPNgjSAgADeTICAABJggIAAD1YAgAAHVACAAAJxAIAACW8AgAAO3oCAAAopgIAACqIA//+kE4A=
Date: Tue, 13 Mar 2018 22:31:55 +0000
Message-ID: <BB94077B-7EB3-49C4-862D-BF77D0A692CC@raithlin.com>
References: <20180312193525.2855-1-logang@deltatee.com>
 <20180312193525.2855-2-logang@deltatee.com>
 <59fd2f5d-177f-334a-a9c4-0f8a6ec7c303@codeaurora.org>
 <24d8e5c2-065d-8bde-3f5d-7f158be9c578@deltatee.com>
 <52cbbbc4-c488-f83f-8d02-14d455b4efd7@codeaurora.org>
 <3e738f95-d73c-4182-2fa1-8664aafb1ab7@deltatee.com>
 <703aa92c-0c1c-4852-5887-6f6e6ccde0fb@codeaurora.org>
 <a0af83f8-2cbc-862b-6f8b-231991527cfc@deltatee.com>
 <3ea80992-a0fc-08f2-d93d-ae0ec4e3f4ce@codeaurora.org>
 <4eb6850c-df1b-fd44-3ee0-d43a50270b53@deltatee.com>
 <757fca36-dee4-e070-669e-f2788bd78e41@codeaurora.org>
 <4f761f55-4e9a-dccb-d12f-c59d2cd689db@deltatee.com>
In-Reply-To: <4f761f55-4e9a-dccb-d12f-c59d2cd689db@deltatee.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.b.0.180311
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sbates@raithlin.com;
x-originating-ip: [70.65.224.121]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;YTXPR0101MB1728;7:Q6Bav6F/JZ8v1o30hZGqHjp1k/vc6xwS+aTEtxnzA+p+oA0yZGWzldGWgTv8QpLt+AUx8mVgH0QYbkWAcNpIiiIzw3CbtmGQx6/yY85lceZGRmDxQd6+sRfBU5er3rVeihQp9Jo2mSEu00Bu7RHtFIfgNQVdU6zTP39MEUCo/TVW/aT04IG7ZcWvwUCiLmxzD84XDg3o/hY41X4CQsie6VstufPw28DfOQ8RzKf6lPTMAyF0lJzXjzNmUxKl6hx/
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: 45753547-d9d3-495e-a897-08d589323a29
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(3008032)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:YTXPR0101MB1728;
x-ms-traffictypediagnostic: YTXPR0101MB1728:
x-microsoft-antispam-prvs: <YTXPR0101MB172807E48D3E11EFDA777D1AAAD20@YTXPR0101MB1728.CANPRD01.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231221)(944501244)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041310)(20161123558120)(2016111802025)(20161123562045)(20161123560045)(20161123564045)(6043046)(6072148)(201708071742011);SRVR:YTXPR0101MB1728;BCL:0;PCL:0;RULEID:;SRVR:YTXPR0101MB1728;
x-forefront-prvs: 0610D16BBE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39830400003)(396003)(376002)(346002)(366004)(39380400002)(69224002)(189003)(199004)(316002)(83716003)(102836004)(81166006)(93886005)(82746002)(81156014)(2950100002)(26005)(14454004)(76176011)(86362001)(54906003)(68736007)(6506007)(2906002)(186003)(2201001)(229853002)(5660300001)(478600001)(99286004)(110136005)(105586002)(106356001)(7736002)(305945005)(33656002)(7416002)(97736004)(3660700001)(6116002)(8676002)(58126008)(3846002)(2900100001)(4326008)(2501003)(3280700002)(6486002)(25786009)(36756003)(5250100002)(8936002)(53936002)(6246003)(6512007)(66066001)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:YTXPR0101MB1728;H:YTXPR0101MB2045.CANPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: MLJgZQ7Z+/7QvoZvR/XPu1uREIvKnCTl06Sz9+ZSBrR3qHOdDWogX9nLvTZwGZMI+Su1h236mNRbhmIJ7RUffnUrIeL1vwNFOSsHI+QaQwPnkuTfYce0f8aFQEgheoQAiX328IUAnkDv/FGGVtzW7zEaGK7C22kCm+vuj+/7xEI0WdG27G+QNDja1wKrBOjsoZbDjLzIXTDnQStVyZy6vBdSyGDHC1liQw2AfQQqdf/qTmgo557pjrsl146x6NhhWEHOkA0yDRI6zIYCFP1221q7PLm91c7GdYvDN7bAiYRnVWSa4JcijfU33qltcQESRwE0BlCsBgOrSbm4M3pdFQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <EFD005DA0C72A448A2E37DC6C4BFB51D@CANPRD01.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-OriginatorOrg: raithlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45753547-d9d3-495e-a897-08d589323a29
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2018 22:31:55.8878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 18519031-7ff4-4cbb-bbcb-c3252d330f4b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YTXPR0101MB1728
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2DMW6Rs002300

>> It sounds like you have very tight hardware expectations for this to work
>> at this moment. You also don't want to generalize this code for others and
>> address the shortcomings.
>  No, that's the way the community has pushed this work

Hi Sinan

Thanks for all the input. As Logan has pointed out the switch requirement is something that has evolved over time based on input from the community. You are more than welcome to have an opinion on this (and you have made that opinion clear ;-)). Over time the patchset may evolve from its current requirements but right now we are aligned with the feedback from the community.

Cheers

Stephen
 
