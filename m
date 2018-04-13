Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752163AbeDMV4M (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 17:56:12 -0400
Received: from mail-eopbgr660113.outbound.protection.outlook.com ([40.107.66.113]:61026
        "EHLO CAN01-QB1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751847AbeDMV4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 17:56:09 -0400
From: "Stephen  Bates" <sbates@raithlin.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Logan Gunthorpe <logang@deltatee.com>
CC: Bjorn Helgaas <helgaas@kernel.org>, Sinan Kaya <okaya@codeaurora.org>,
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
        =?utf-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Eric Wehage <Eric.Wehage@huawei.com>
Subject: Re: [PATCH v3 01/11] PCI/P2PDMA: Support peer-to-peer memory
Thread-Topic: [PATCH v3 01/11] PCI/P2PDMA: Support peer-to-peer memory
Thread-Index: AQHTujlZo8bTZRn+4ECdETRRU1rPhqPNgjSAgADeTICAFBF4AIAAL2gAgAAdXQCAAR0ogIAbL4UA
Date: Fri, 13 Apr 2018 21:56:06 +0000
Message-ID: <178FD8FA-53BA-49DA-807F-F8736157F179@raithlin.com>
References: <20180312193525.2855-1-logang@deltatee.com>
 <20180312193525.2855-2-logang@deltatee.com>
 <59fd2f5d-177f-334a-a9c4-0f8a6ec7c303@codeaurora.org>
 <24d8e5c2-065d-8bde-3f5d-7f158be9c578@deltatee.com>
 <20180326121138.00005e30@huawei.com>
 <20180326140118.GA221690@bhelgaas-glaptop.roam.corp.google.com>
 <c717eb06-1e83-f0f3-4d6c-15531aa808e0@deltatee.com>
 <20180327094701.0000300d@huawei.com>
In-Reply-To: <20180327094701.0000300d@huawei.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.c.0.180410
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sbates@raithlin.com;
x-originating-ip: [70.65.253.218]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;YTXPR0101MB1934;7:lq9dVTLn9pV4e2ZoQwRf32YWQjsL4jWBWw2rJ6QD6/AJo1Dgl4B86lb//WWnwtFfapuwgaOcTz42V0ET1R/4EQNQstDEalZGRBZJQxDoGMI7qKIq9SLR/Euf+k6NiwU29vapHWAKjEcbuLx+mQYunFFvM1mnuDk+rSZFV1QN2+ME5w3K/5Gn7Xy/G5VysilvRJ1VkEpKNa02aKu+Q9OcpqybePxZmPBVi52y7ze1OgEIEYO2GneqNcQiVzK2lL5W
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:YTXPR0101MB1934;
x-ms-traffictypediagnostic: YTXPR0101MB1934:
x-microsoft-antispam-prvs: <YTXPR0101MB19341A30D8AB6DF136B10578AAB30@YTXPR0101MB1934.CANPRD01.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231232)(944501327)(52105095)(10201501046)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(2016111802025)(6072148)(6043046)(201708071742011);SRVR:YTXPR0101MB1934;BCL:0;PCL:0;RULEID:;SRVR:YTXPR0101MB1934;
x-forefront-prvs: 0641678E68
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39830400003)(396003)(39380400002)(376002)(366004)(346002)(189003)(199004)(99286004)(6246003)(58126008)(186003)(102836004)(54906003)(4326008)(53936002)(110136005)(478600001)(106356001)(105586002)(25786009)(7416002)(83716003)(486006)(36756003)(8676002)(8936002)(86362001)(476003)(81156014)(81166006)(76176011)(5660300001)(66066001)(7736002)(97736004)(2616005)(229853002)(2900100001)(33656002)(2906002)(3280700002)(3660700001)(5250100002)(6436002)(6506007)(305945005)(14454004)(68736007)(26005)(6512007)(446003)(11346002)(316002)(93886005)(6486002)(3846002)(82746002)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:YTXPR0101MB1934;H:YTXPR0101MB2045.CANPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 1GspblcErftozeBs+6hhjS/UjlxAYNfHI6RyD2lcunxYs9cPeaq0G2KhyYcGSWgVF+7XvoG5BWhfrFzNWscZ3FHTAiXcgD25vFovfs7xdABuIVnj6uAH9koYGseJgXe93bifrJ3H2ItFTeRL5NSmtzzYeDBEQtPvB4rMGtQ9+5+BzBSMsAJDfrwjsJoPu5zO
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <F42E61E08E0A2947848C85545943ECEB@CANPRD01.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: f5a82b3a-a5c4-4fc6-02da-08d5a1895c12
X-OriginatorOrg: raithlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5a82b3a-a5c4-4fc6-02da-08d5a1895c12
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2018 21:56:06.8818
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 18519031-7ff4-4cbb-bbcb-c3252d330f4b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YTXPR0101MB1934
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3DLuHGi027985

 
>  I'll see if I can get our PCI SIG people to follow this through 

Hi Jonathan

Can you let me know if this moves forward within PCI-SIG? I would like to track it. I can see this being doable between Root Ports that reside in the same Root Complex but might become more challenging to standardize for RPs that reside in different RCs in the same (potentially multi-socket) system. I know in the past we have seem MemWr TLPS cross the QPI bus in Intel systems but I am sure that is not something that would work in all systems and must fall outside the remit of PCI-SIG ;-).

I agree such a capability bit would be very useful but it's going to be quite some time before we can rely on hardware being available that supports it.

Stephen
    
