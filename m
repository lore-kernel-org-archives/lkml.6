Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932722AbeEHWZM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 18:25:12 -0400
Received: from mail-eopbgr670110.outbound.protection.outlook.com ([40.107.67.110]:14108
        "EHLO CAN01-TO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932611AbeEHWZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 18:25:09 -0400
From: "Stephen  Bates" <sbates@raithlin.com>
To: Logan Gunthorpe <logang@deltatee.com>,
        Alex Williamson <alex.williamson@redhat.com>
CC: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>,
        "Bjorn Helgaas" <helgaas@kernel.org>,
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
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v4 04/14] PCI/P2PDMA: Clear ACS P2P flags for all devices
 behind switches
Thread-Topic: [PATCH v4 04/14] PCI/P2PDMA: Clear ACS P2P flags for all devices
 behind switches
Thread-Index: AQHT21soiBVnp6SJuEuLCiH6kBzTLKQk+zIAgACHcYCAAJmxAIAABkiAgAAoBgCAAAW2gIAAA0YAgAAHvYCAAAGOgIAABt+AgAABmICAAApggP//n96AgABqfgCAAAHhgP//n4wA
Date: Tue, 8 May 2018 22:25:06 +0000
Message-ID: <C3CEE4DB-A001-4E4C-B9B9-4B160E4C5367@raithlin.com>
References: <20180423233046.21476-1-logang@deltatee.com>
 <20180423233046.21476-5-logang@deltatee.com>
 <20180507231306.GG161390@bhelgaas-glaptop.roam.corp.google.com>
 <e58e8d27-42a5-ca69-3b68-c409a2922cd1@amd.com>
 <0b4183ef-e720-204b-9e85-b9eaf7a4136a@deltatee.com>
 <a943a92d-15cd-fb2d-21c3-5e5cfccd9eff@amd.com>
 <3584a6ac-95c7-5d23-1859-aee30605776e@deltatee.com>
 <20180508133407.57a46902@w520.home>
 <5fc9b1c1-9208-06cc-0ec5-1f54c2520494@deltatee.com>
 <20180508141331.7cd737cb@w520.home>
 <d70cf286-f7b7-99a5-1042-022506298fed@deltatee.com>
 <20180508144341.0441b676@w520.home>
 <a524127a-3557-3dff-971c-dfe94ba5a01c@deltatee.com>
 <20180508152631.50fd583c@w520.home>
 <354F7407-0DC7-470C-B9AA-74FDF9C46B08@raithlin.com>
 <20180508160336.0935ddde@w520.home>
 <20905682-9440-7d4b-0260-99d3dc794c3d@deltatee.com>
In-Reply-To: <20905682-9440-7d4b-0260-99d3dc794c3d@deltatee.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.d.0.180505
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sbates@raithlin.com;
x-originating-ip: [70.65.250.31]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;YTXPR0101MB2190;7:jE2bHCsQLsnX4OqEtaKQvCDRAaE1FEsXisOut17eqrJ0JTY1tMjlo9CxaGYKTgH5KtV5Q1Aw/pN9i02x0+3WUEYacahyQnBz9C2oU+6UCMZ1uYDMGkT6TlrvqEk8kdSIpYawR+pr4/+b2ADdtM4cunK+eFq/kW3M4SBelWghlJVQdVsLLx/6PVe1FWxUwBa9hWSWsEoS20zB9qs7uHVEm+HdCJaZFB8JTrA4zuNxZRGa66lgPKn3fmALL7vN3+Hq
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:YTXPR0101MB2190;
x-ms-traffictypediagnostic: YTXPR0101MB2190:
x-microsoft-antispam-prvs: <YTXPR0101MB21900F4CE556D3AE1CA94DC2AA9A0@YTXPR0101MB2190.CANPRD01.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(2016111802025)(6043046)(6072148)(201708071742011);SRVR:YTXPR0101MB2190;BCL:0;PCL:0;RULEID:;SRVR:YTXPR0101MB2190;
x-forefront-prvs: 0666E15D35
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(39830400003)(396003)(346002)(376002)(78114003)(189003)(199004)(6436002)(53936002)(6246003)(76176011)(33656002)(6486002)(105586002)(106356001)(2906002)(4326008)(36756003)(305945005)(446003)(93886005)(3280700002)(5660300001)(97736004)(2900100001)(316002)(14454004)(58126008)(110136005)(476003)(11346002)(229853002)(2616005)(7416002)(26005)(25786009)(68736007)(186003)(6512007)(3660700001)(8936002)(54906003)(86362001)(66066001)(7736002)(8666007)(82746002)(81156014)(8676002)(6116002)(81166006)(6506007)(83716003)(3846002)(102836004)(478600001)(5250100002)(486006)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:YTXPR0101MB2190;H:YTXPR0101MB2045.CANPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: sfghWDKHye4ZGXf7gWXUEdXvjiRUNBAWnkwNTPbisbhMs4nE0FII2qCoI7zASpregt1VIK9YFhji1Chkvx26ldRWK50qLBKizU/HqY7/cB+aHmNvA+LM7j7hsLuMxvt2MdX3usGbjhhAT4tsOg+C0WFUNABel0N1qNzLDJxCaf+tyQB2/Qtw1fT7oD4PoL35
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <D47BEDBD514959418998B2F27B79E08B@CANPRD01.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 277b61d2-c0ac-410f-9abb-08d5b5328d79
X-OriginatorOrg: raithlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 277b61d2-c0ac-410f-9abb-08d5b5328d79
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2018 22:25:06.8248
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 18519031-7ff4-4cbb-bbcb-c3252d330f4b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YTXPR0101MB2190
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w48MPJBT017279

>    Yeah, so based on the discussion I'm leaning toward just having a
>    command line option that takes a list of BDFs and disables ACS for them.
>    (Essentially as Dan has suggested.) This avoids the shotgun.

I concur that this seems to be where the conversation is taking us.

@Alex - Before we go do this can you provide input on the approach? I don't want to re-spin only to find we are still not converging on the ACS issue....

Thanks

Stephen
    
