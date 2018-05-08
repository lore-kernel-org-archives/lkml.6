Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932611AbeEHV15 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 17:27:57 -0400
Received: from mail-eopbgr660126.outbound.protection.outlook.com ([40.107.66.126]:13448
        "EHLO CAN01-QB1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756043AbeEHV1s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 17:27:48 -0400
From: "Stephen  Bates" <sbates@raithlin.com>
To: Don Dutile <ddutile@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "Christoph Hellwig" <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jason Gunthorpe <jgg@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>,
        =?utf-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>
Subject: Re: [PATCH v4 04/14] PCI/P2PDMA: Clear ACS P2P flags for all devices
 behind switches
Thread-Topic: [PATCH v4 04/14] PCI/P2PDMA: Clear ACS P2P flags for all devices
 behind switches
Thread-Index: AQHT21soiBVnp6SJuEuLCiH6kBzTLKQl+8wA//+fHICAAM6PgP//ogsA
Date: Tue, 8 May 2018 21:27:45 +0000
Message-ID: <3C9FB262-A93C-4C8F-B1E0-85C6D6F78BC2@raithlin.com>
References: <20180423233046.21476-1-logang@deltatee.com>
 <20180423233046.21476-5-logang@deltatee.com>
 <CAPcyv4g+5N_n03J-VhmJfrr60Sqk95ZapLKBkwSsGvV4nQ+ZRw@mail.gmail.com>
 <64C231F5-DE36-415F-B308-3A423B0BBACB@raithlin.com>
 <15433946-f7f5-f610-4e80-380fb59920e5@redhat.com>
In-Reply-To: <15433946-f7f5-f610-4e80-380fb59920e5@redhat.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.d.0.180505
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sbates@raithlin.com;
x-originating-ip: [70.65.250.31]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;YTXPR0101MB1725;7:lss/U0V4bt7Rq7FXxeWadLMD4f9d5Qtv48q6f5s/vlRpv9cgWhkqZBIL7rvG4JcUMYEsivi+LNdZru+v9+kc8lRz12PIquzr3IOA3CfEtemXsV6HvMNzHDO6cYlNoHCQWtp5/2HrJpN8+6QAVp5LbAzAp9pxNGPrjlBZQVTFMXv+B/QlMx2FalZvpZjwwqOWwBqdvGFlpgn8LgSAn3PN9VZDVI1f9Robxd3yjx3fvaA53dTOXP4QtsEcx/O+lqYw
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:YTXPR0101MB1725;
x-ms-traffictypediagnostic: YTXPR0101MB1725:
x-microsoft-antispam-prvs: <YTXPR0101MB17257AE61FB377D0D4ECB99AAA9A0@YTXPR0101MB1725.CANPRD01.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(2016111802025)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(6072148)(6043046)(201708071742011);SRVR:YTXPR0101MB1725;BCL:0;PCL:0;RULEID:;SRVR:YTXPR0101MB1725;
x-forefront-prvs: 0666E15D35
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(376002)(346002)(396003)(39830400003)(189003)(199004)(51914003)(110136005)(83716003)(81156014)(7416002)(25786009)(59450400001)(5660300001)(305945005)(478600001)(81166006)(8936002)(8666007)(8676002)(6506007)(6116002)(3846002)(93886005)(446003)(11346002)(58126008)(86362001)(5250100002)(82746002)(2616005)(4326008)(476003)(2906002)(3660700001)(316002)(3280700002)(54906003)(7736002)(486006)(14454004)(68736007)(53936002)(6512007)(6246003)(26005)(105586002)(229853002)(6436002)(33656002)(186003)(97736004)(36756003)(6486002)(102836004)(66066001)(99286004)(2900100001)(76176011)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:YTXPR0101MB1725;H:YTXPR0101MB2045.CANPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: lONCMaeFuOu6Yplkmq793PEA5TNnVJsJI6Ma02eS/nkdmxHe7JfvNSWqJp+MLnM5zaUIFLivc5FYUOGP9ZIVJE9uEONnm7qD0f/7Y4l5FR5To3ORtGKKzNz+dUJijZLf8yANeD3FC7OlZu68xa93iBWPb4dq0WWgJRvddEPCo9e84CBTbR4KsC5i5wmL8mgI
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <6ABD44D415AE6949AEE8F86759BEA511@CANPRD01.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: bdda0cef-b271-4401-6466-08d5b52a8a47
X-OriginatorOrg: raithlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdda0cef-b271-4401-6466-08d5b52a8a47
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2018 21:27:45.4106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 18519031-7ff4-4cbb-bbcb-c3252d330f4b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YTXPR0101MB1725
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w48LSqtc013592

Hi Don

>Well, p2p DMA is a function of a cooperating 'agent' somewhere above the two devices.
>    That agent should 'request' to the kernel that ACS be removed/circumvented (p2p enabled) btwn two endpoints.
>    I recommend doing so via a sysfs method.

Yes we looked at something like this in the past but it does hit the IOMMU grouping issue I discussed earlier today which is not acceptable right now. In the long term, once we get IOMMU grouping callbacks to VMs we can look at extending p2pdma in this way. But I don't think this is viable for the initial series. 

    
>            So I don't understand the comments why VMs should need to know.

As I understand it VMs need to know because VFIO passes IOMMU grouping up into the VMs. So if a IOMMU grouping changes the VM's view of its PCIe topology changes. I think we even have to be cognizant of the fact the OS running on the VM may not even support hot-plug of PCI devices.
    
> Is there a thread I need to read up to explain /clear-up the thoughts above?

If you search for p2pdma you should find the previous discussions. Thanks for the input!

Stephen
    
    
