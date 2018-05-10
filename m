Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751474AbeEJSoa (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 14:44:30 -0400
Received: from mail-eopbgr670105.outbound.protection.outlook.com ([40.107.67.105]:35324
        "EHLO CAN01-TO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750762AbeEJSo1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 14:44:27 -0400
From: "Stephen  Bates" <sbates@raithlin.com>
To: Jerome Glisse <jglisse@redhat.com>,
        =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>
CC: Logan Gunthorpe <logang@deltatee.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "Christoph Hellwig" <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jason Gunthorpe <jgg@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Subject: Re: [PATCH v4 04/14] PCI/P2PDMA: Clear ACS P2P flags for all devices
 behind switches
Thread-Topic: [PATCH v4 04/14] PCI/P2PDMA: Clear ACS P2P flags for all devices
 behind switches
Thread-Index: AQHT21soiBVnp6SJuEuLCiH6kBzTLKQk+zIAgACHcYCAAJmxAIAABkiAgAAoBgCAAAW2gIAAA0YAgAAHvYCAAAGOgIAACKoAgACuAYCAAGxLgP//vUwAgABrwID//6HiAIAAesGAgADzGoCAAGdPAIAACGQA///aLgA=
Date: Thu, 10 May 2018 18:44:25 +0000
Message-ID: <0E894398-041D-4FA6-966F-BB37866A9AF2@raithlin.com>
References: <d70cf286-f7b7-99a5-1042-022506298fed@deltatee.com>
 <20180508205005.GC15608@redhat.com>
 <7FFB9603-DF9F-4441-82E9-46037CB6C0DE@raithlin.com>
 <a1a36f88-fbfb-b5ee-6dcb-5c5bb96132dd@amd.com>
 <1775CC56-4651-422F-953A-18E024D3717C@raithlin.com>
 <20180509160722.GB4140@redhat.com>
 <366A8132-B88A-40F7-BDE3-DA542E45FC0C@raithlin.com>
 <20180509174952.GC4140@redhat.com>
 <405531AE-8315-4A4F-9B0C-8DBE49BFCAB4@raithlin.com>
 <73b6a454-bf84-1640-0b5e-137d03c0ad8c@amd.com>
 <20180510145946.GB3652@redhat.com>
In-Reply-To: <20180510145946.GB3652@redhat.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.d.0.180505
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sbates@raithlin.com;
x-originating-ip: [70.73.168.51]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;YTXPR0101MB0781;7:E1r2wIMRkNrB/lWA3w0j9g2IvCglCX0f7ny7dIcQDQzF4XZ0alEZJOj7rOLo390kMTQwDWRVEs9fkSpYWvEuSjwnQT12oKddEWEI7zvS4gk4zPlhRgCRFVe41jgyjWQxim1vsJih1sIlqSPfSRw1Cac7Cn8HRyYttXXLQjdcGXw2GDNPk14zkUVmVxQOHwbel0Q9y6JO4Wef+kN0//xXy2xlwC/iE2vxYcHAxKd0uy/GDXg3Adv4IPhH1PtIw6+X
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(2017052603328)(7153060)(7193020);SRVR:YTXPR0101MB0781;
x-ms-traffictypediagnostic: YTXPR0101MB0781:
x-microsoft-antispam-prvs: <YTXPR0101MB07817E405914E009A29E6F95AA980@YTXPR0101MB0781.CANPRD01.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(2016111802025)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(6043046)(6072148)(201708071742011);SRVR:YTXPR0101MB0781;BCL:0;PCL:0;RULEID:;SRVR:YTXPR0101MB0781;
x-forefront-prvs: 066898046A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39830400003)(376002)(39380400002)(346002)(199004)(189003)(14454004)(486006)(558084003)(66066001)(110136005)(5660300001)(93886005)(7416002)(97736004)(68736007)(83716003)(58126008)(54906003)(446003)(86362001)(5250100002)(2616005)(316002)(82746002)(33656002)(476003)(6512007)(53936002)(81166006)(2906002)(7736002)(305945005)(81156014)(36756003)(105586002)(3660700001)(26005)(76176011)(4326008)(102836004)(8936002)(8666007)(106356001)(478600001)(3846002)(6116002)(6436002)(6486002)(6246003)(11346002)(25786009)(6506007)(2900100001)(99286004)(229853002)(186003)(8676002)(3280700002);DIR:OUT;SFP:1102;SCL:1;SRVR:YTXPR0101MB0781;H:YTXPR0101MB2045.CANPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: mMA/P/WS+Ux97bWbyqEfWnH3wf6VBc1ZHHTH9NiVv7ye+RgVVk9NJiirKDBh/ANZQwmAQZsCnONcI+9JdPaC2ncar7Gb+Lyo4bEvulprCVVTfyitR4ylZAM2N8SO5tvhGs7nQUxbf1oJCuoUpyMbk4nxT0uT908z5QgHIuGY8m3zfgrCiWxefz3EdNqg91r5
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <808447B90BCF854BAE074328755F387B@CANPRD01.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 3c3898e7-e17f-464b-0a06-08d5b6a60db2
X-OriginatorOrg: raithlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c3898e7-e17f-464b-0a06-08d5b6a60db2
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2018 18:44:25.2610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 18519031-7ff4-4cbb-bbcb-c3252d330f4b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YTXPR0101MB0781
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4AIiZf3004792

Hi Jerome

>    Hopes this helps understanding the big picture. I over simplify thing and
>    devils is in the details.
    
This was a great primer thanks for putting it together. An LWN.net article perhaps ;-)??

Stephen
    
