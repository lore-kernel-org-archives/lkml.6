Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934710AbeEIMi6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 08:38:58 -0400
Received: from mail-eopbgr660129.outbound.protection.outlook.com ([40.107.66.129]:27669
        "EHLO CAN01-QB1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932875AbeEIMiz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 08:38:55 -0400
From: "Stephen  Bates" <sbates@raithlin.com>
To: Logan Gunthorpe <logang@deltatee.com>,
        Dan Williams <dan.j.williams@intel.com>,
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
        =?utf-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v4 04/14] PCI/P2PDMA: Clear ACS P2P flags for all devices
 behind switches
Thread-Topic: [PATCH v4 04/14] PCI/P2PDMA: Clear ACS P2P flags for all devices
 behind switches
Thread-Index: AQHT21soiBVnp6SJuEuLCiH6kBzTLKQk+zIAgACHcYCAAJmxAIAABkiAgAAoBgCAAAW2gIAAA0YAgAAHvYCAAAGOgIAABt+AgAABmICAAApggP//n96AgABqfgCAAAHhgIAABhYAgAAH84CAAAQigIAAe+sA
Date: Wed, 9 May 2018 12:38:53 +0000
Message-ID: <BFD17865-3125-469C-B736-9A60D9B35B63@raithlin.com>
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
 <20180508163206.7d3bf383@w520.home>
 <CAPcyv4i1ksiu1pExF=EE21P2Wz1a9LaDaG247oG_WSbYgcR93g@mail.gmail.com>
 <2ce7908d-1422-55f8-aeba-94ccce2cb484@deltatee.com>
In-Reply-To: <2ce7908d-1422-55f8-aeba-94ccce2cb484@deltatee.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.d.0.180505
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sbates@raithlin.com;
x-originating-ip: [70.65.250.31]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;YTOPR0101MB2202;7:/YJ/AGrM/ao0SiG4+EJqadBdJvl1YTpWO2WN+yv3S6GM/nl7hthqZt04PxS09v9IoKXTfsFHaXaDnGO64citkmt88pF0RjxTrPV3pwSemwgvdzLG/qwyw4zoRIFI+lV7EG9ZHhElro35zMpVHltMf6fHUVxVqdaBWssNYfW1RdbTc0z11ViK1qtRaEts+3kzU/TUFmOG8HhM8hLCpLFSLMZzs2ONlYTLCqImoFEhZqmpxOLaXzVI1BudGHbeNnuJ
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:YTOPR0101MB2202;
x-ms-traffictypediagnostic: YTOPR0101MB2202:
x-microsoft-antispam-prvs: <YTOPR0101MB2202BAAD0345444E33480A39AA990@YTOPR0101MB2202.CANPRD01.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(21532816269658);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(2016111802025)(20161123564045)(20161123562045)(20161123560045)(6072148)(6043046)(201708071742011);SRVR:YTOPR0101MB2202;BCL:0;PCL:0;RULEID:;SRVR:YTOPR0101MB2202;
x-forefront-prvs: 0667289FF8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(376002)(366004)(39830400003)(396003)(189003)(199004)(6512007)(97736004)(8666007)(8676002)(86362001)(33656002)(3660700001)(3280700002)(2906002)(81156014)(8936002)(14454004)(81166006)(58126008)(53936002)(106356001)(316002)(4326008)(105586002)(110136005)(305945005)(68736007)(7736002)(36756003)(93886005)(54906003)(26005)(446003)(186003)(76176011)(478600001)(102836004)(59450400001)(82746002)(486006)(2616005)(11346002)(6246003)(25786009)(7416002)(2900100001)(6506007)(5660300001)(476003)(6116002)(6486002)(83716003)(3846002)(66066001)(5250100002)(99286004)(229853002)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:YTOPR0101MB2202;H:YTOPR0101MB2043.CANPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 4Uqa89nHtTRYPj475iZ0wd+4PnGWWCdYHE4J+wlz4KwThMtzo1aTE0rDuCXN2BjcNsLuh0JHddl1/GKsFfFbMN2h48IPHubBQx0jD3vi8yVcqB+VFLb/k0PppI/yUtS2r8ILhULCVNL1cRL8mSN70qioymGYN+3iSB/07H73QF9Z6L2Qxdg9aK8QjpQSkWQt
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <BEC5B1025BBC05479443BE8390322518@CANPRD01.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: a657985d-0624-4eb5-0714-08d5b5a9d2a6
X-OriginatorOrg: raithlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a657985d-0624-4eb5-0714-08d5b5a9d2a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2018 12:38:53.0364
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 18519031-7ff4-4cbb-bbcb-c3252d330f4b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YTOPR0101MB2202
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w49Cd3kt004356

Hi Logan

>    Yeah, I'm having a hard time coming up with an easy enough solution for
>    the user. I agree with Dan though, the bus renumbering risk would be
>    fairly low in the custom hardware seeing the switches are likely going
>    to be directly soldered to the same board with the CPU.
    
I am afraid that soldered down assumption may not be valid. More and more PCIe cards with PCIe switches on them are becoming available and people are using these to connect servers to arrays of NVMe SSDs which may make the topology more dynamic.

Stephen
