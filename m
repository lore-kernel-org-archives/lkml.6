Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163084AbeCAXOw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 18:14:52 -0500
Received: from mail-eopbgr670124.outbound.protection.outlook.com ([40.107.67.124]:45238
        "EHLO CAN01-TO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1162910AbeCAXOt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 18:14:49 -0500
From: "Stephen  Bates" <sbates@raithlin.com>
To: Logan Gunthorpe <logang@deltatee.com>,
        Bjorn Helgaas <helgaas@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
        =?utf-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v2 01/10] PCI/P2PDMA: Support peer to peer memory
Thread-Topic: [PATCH v2 01/10] PCI/P2PDMA: Support peer to peer memory
Thread-Index: AQHTsO2GlGV4YX1/W0e8HoNGK6xZcKO7pjEAgAAVyYCAAEReAIAAAb+A//+M4gA=
Date: Thu, 1 Mar 2018 23:14:46 +0000
Message-ID: <9B84B347-2CCF-4250-89ED-B29892E76597@raithlin.com>
References: <20180228234006.21093-1-logang@deltatee.com>
 <20180228234006.21093-2-logang@deltatee.com>
 <20180301173752.GE13722@bhelgaas-glaptop.roam.corp.google.com>
 <b81503c2-9f07-b5f6-df06-64d1fdc53386@deltatee.com>
 <20180301230032.GA74737@bhelgaas-glaptop.roam.corp.google.com>
 <b3121c36-4ef5-0d8e-e8ef-418b48de9589@deltatee.com>
In-Reply-To: <b3121c36-4ef5-0d8e-e8ef-418b48de9589@deltatee.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.a.0.180210
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sbates@raithlin.com;
x-originating-ip: [70.65.224.121]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;YTXPR0101MB2175;7:UdM+EHI5Xv9KyIoJOBCYE6ydac7j0ynOuYaFrHNnSHymrlz4xsj3gysGh8XoueoqasroRJLsvCGKRXayS8Roqx5CrI+Fer/dVYlgIXAKkqMuGMRti/7MnHuK4gYFYWsOwp5LHqF/y+V6cjXMU8cCu1uKvWLdUjVaa/HoKBEsx0al0avhPr6NvhEnToyjhOBKfqrLwQqiG5eZ8oOJsNYmDBkyMJ99zv9L6wrIjckEV3DU1g3YO9Z0gJ2C+EUdBi6E
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: 36cf24ec-216c-4639-c7ee-08d57fca3997
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:YTXPR0101MB2175;
x-ms-traffictypediagnostic: YTXPR0101MB2175:
x-microsoft-antispam-prvs: <YTXPR0101MB2175889896DD8C97BC21BA4EAAC60@YTXPR0101MB2175.CANPRD01.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(278428928389397);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231220)(944501232)(52105095)(93006095)(93001095)(6041288)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(2016111802025)(6072148)(6043046)(201708071742011);SRVR:YTXPR0101MB2175;BCL:0;PCL:0;RULEID:;SRVR:YTXPR0101MB2175;
x-forefront-prvs: 05986C03E0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(396003)(39380400002)(39830400003)(189003)(199004)(478600001)(4326008)(36756003)(3280700002)(2900100001)(2950100002)(3660700001)(5660300001)(14454004)(25786009)(551934003)(2906002)(83716003)(82746002)(102836004)(68736007)(86362001)(3846002)(26005)(105586002)(5250100002)(186003)(106356001)(6246003)(76176011)(58126008)(229853002)(110136005)(53936002)(66066001)(316002)(93886005)(54906003)(6436002)(8936002)(97736004)(6506007)(81156014)(81166006)(99286004)(8676002)(6116002)(6486002)(6512007)(33656002)(7416002)(7736002)(59450400001)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:YTXPR0101MB2175;H:YTXPR0101MB2045.CANPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: b6nqf85giztSHlp+D75/4a9F2PQfcoWpGsMR1nZiMXNjIbmSYfDnAgK3D/IR1FBK+CI8E0aJDBIVuYT3XoVSgyZr6HeGLgA+2lKTygbyH/l7V5uR+7wHHWjJpXL0TXtYJETuH/JTMj5o62yCXlzS20GDRXUgsnSpMTleV+DzTGU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <F9761AF79384A74ABA750F9C634F06A9@CANPRD01.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-OriginatorOrg: raithlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36cf24ec-216c-4639-c7ee-08d57fca3997
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2018 23:14:46.8225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 18519031-7ff4-4cbb-bbcb-c3252d330f4b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YTXPR0101MB2175
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w21NEwdY024206

> I'm pretty sure the spec disallows routing-to-self so doing a P2P 
> transaction in that sense isn't going to work unless the device 
> specifically supports it and intercepts the traffic before it gets to 
> the port.

This is correct. Unless the device intercepts the TLP before it hits the root-port then this would be considered a "route to self" violation and an error event would occur. The same holds for the downstream port on a PCI switch (unless route-to-self violations are disabled which violates the spec but which I have seen done in certain applications).
    
Stephen
    
    
    
