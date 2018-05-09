Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934527AbeEIMgF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 08:36:05 -0400
Received: from mail-eopbgr670136.outbound.protection.outlook.com ([40.107.67.136]:52583
        "EHLO CAN01-TO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932875AbeEIMf7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 08:35:59 -0400
From: "Stephen  Bates" <sbates@raithlin.com>
To: Alex Williamson <alex.williamson@redhat.com>,
        Don Dutile <ddutile@redhat.com>
CC: Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jason Gunthorpe <jgg@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>,
        =?utf-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>
Subject: Re: [PATCH v4 04/14] PCI/P2PDMA: Clear ACS P2P flags for all devices
 behind switches
Thread-Topic: [PATCH v4 04/14] PCI/P2PDMA: Clear ACS P2P flags for all devices
 behind switches
Thread-Index: AQHT21soiBVnp6SJuEuLCiH6kBzTLKQl+8wA//+fHICAAM6PgP//ogsAgACAHoCAAA+NgIAAbhQA
Date: Wed, 9 May 2018 12:35:56 +0000
Message-ID: <B5BFCF39-6BB4-4E45-B805-C8FCC8B79EF3@raithlin.com>
References: <20180423233046.21476-1-logang@deltatee.com>
 <20180423233046.21476-5-logang@deltatee.com>
 <CAPcyv4g+5N_n03J-VhmJfrr60Sqk95ZapLKBkwSsGvV4nQ+ZRw@mail.gmail.com>
 <64C231F5-DE36-415F-B308-3A423B0BBACB@raithlin.com>
 <15433946-f7f5-f610-4e80-380fb59920e5@redhat.com>
 <3C9FB262-A93C-4C8F-B1E0-85C6D6F78BC2@raithlin.com>
 <c5f30ced-7bbf-9420-db1a-72519fc78b3a@redhat.com>
 <20180508180157.7c7b393f@w520.home>
In-Reply-To: <20180508180157.7c7b393f@w520.home>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.d.0.180505
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sbates@raithlin.com;
x-originating-ip: [70.65.250.31]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;YTOPR0101MB2217;7:hEU+oilHx0kFJ/NvVzGfbG91h20TzJ2UnNNtlLljhrTIw8wPjBUoHOSAFczZKbmruz1UQdyqZ1LUClI5qf97JaBkg8GdXxUiF2xzci/PFLveA8lbzOZpfbxFg8OolhSsDY+nPvaedon7dQZ23tpTqW0TT8ZL8c8/6FhXcdj4fHzS7iAHKRvMEnczVkd2uHSvv3WdLccHW+bGZt8Je/WwqEiknZtlqF/nGGaZ5U+IkViRfV7j0zBBcNwt4yktBuRt
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(2017052603328)(7153060)(7193020);SRVR:YTOPR0101MB2217;
x-ms-traffictypediagnostic: YTOPR0101MB2217:
x-microsoft-antispam-prvs: <YTOPR0101MB221784A572B32A11AE355062AA990@YTOPR0101MB2217.CANPRD01.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(2016111802025)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(6043046)(6072148)(201708071742011);SRVR:YTOPR0101MB2217;BCL:0;PCL:0;RULEID:;SRVR:YTOPR0101MB2217;
x-forefront-prvs: 0667289FF8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(366004)(376002)(39830400003)(39380400002)(199004)(189003)(2616005)(53936002)(66066001)(8666007)(86362001)(110136005)(82746002)(6486002)(229853002)(102836004)(478600001)(68736007)(8936002)(81166006)(81156014)(99286004)(83716003)(5660300001)(11346002)(486006)(6246003)(446003)(316002)(7416002)(3660700001)(6436002)(6512007)(58126008)(76176011)(54906003)(6506007)(476003)(6116002)(97736004)(36756003)(14454004)(3846002)(26005)(4326008)(25786009)(33656002)(186003)(2900100001)(3280700002)(93886005)(5250100002)(7736002)(105586002)(305945005)(106356001)(2906002)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:YTOPR0101MB2217;H:YTOPR0101MB2043.CANPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: kZA4b0/qJNh+TKBNyoqkfNS1KFcplAwpWxwTfdtiPEm9PaLKcyeoW94D5hWO6sioXyAfOMTYkHOJVyQtNRRnZ3mDc+V9CmvlNrMvax74jjmnKfr3+FDD+bfuAf4R+T2XoSFMsNbEgwz57PxOHUUQwdo8BQBeijG0D6aHIlMNG5kNKd8AHoNkWpu/L9Of3pFd
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <1637E91BB2F65F4B8ECDBB1A7D276542@CANPRD01.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: eb6083cb-95a3-4b2c-3294-08d5b5a96992
X-OriginatorOrg: raithlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb6083cb-95a3-4b2c-3294-08d5b5a96992
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2018 12:35:56.7301
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 18519031-7ff4-4cbb-bbcb-c3252d330f4b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YTOPR0101MB2217
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w49CaCCK004333

Hi Alex and Don

>    Correct, the VM has no concept of the host's IOMMU groups, only the
>   hypervisor knows about the groups, 

But as I understand it these groups are usually passed through to VMs on a pre-group basis by the hypervisor? So IOMMU group 1 might be passed to VM A and IOMMU group 2 passed to VM B. So I agree the VM is not aware of IOMMU groupings but it is impacted by them in the sense that if the groupings change the PCI topology presented to the VM needs to change too.

Stephen
