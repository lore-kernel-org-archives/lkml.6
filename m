Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932480AbeEHOZR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 10:25:17 -0400
Received: from mail-eopbgr660100.outbound.protection.outlook.com ([40.107.66.100]:44304
        "EHLO CAN01-QB1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932193AbeEHOZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 10:25:13 -0400
From: "Stephen  Bates" <sbates@raithlin.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>,
        "Bjorn Helgaas" <helgaas@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        "Alex Williamson" <alex.williamson@redhat.com>
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
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v4 04/14] PCI/P2PDMA: Clear ACS P2P flags for all devices
 behind switches
Thread-Topic: [PATCH v4 04/14] PCI/P2PDMA: Clear ACS P2P flags for all devices
 behind switches
Thread-Index: AQHT21soiBVnp6SJuEuLCiH6kBzTLKQk+zIAgACHcYCAABLOAA==
Date: Tue, 8 May 2018 14:25:10 +0000
Message-ID: <479F2F93-903B-4A8A-8989-A4BD0E5E1471@raithlin.com>
References: <20180423233046.21476-1-logang@deltatee.com>
 <20180423233046.21476-5-logang@deltatee.com>
 <20180507231306.GG161390@bhelgaas-glaptop.roam.corp.google.com>
 <e58e8d27-42a5-ca69-3b68-c409a2922cd1@amd.com>
In-Reply-To: <e58e8d27-42a5-ca69-3b68-c409a2922cd1@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.c.0.180410
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sbates@raithlin.com;
x-originating-ip: [70.65.250.31]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;YTXPR0101MB0781;7:tWkmYY1HCzg3gno61gZCoKjBCUizK8krcouBy5gD+ZM5vgxxtC0f0yaSToYy65+JJHjcVv2HZmKIWIyMo997sCFnCLYoU52maJ46R9Iy7GHYPgYPnLbyvhJ/SFZjQ9YsFG/vpWKzPTyoXkaRaX9skUPhDe3JCdA2MGFt6YnI0E14UzIgNDTY2JLN7cei5pBa072MBlr1mR3x/3p3aTiYHbMWb7i2+l6wPzT5/45f0bPWexmODNA0NW2VNesWhM6q
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:YTXPR0101MB0781;
x-ms-traffictypediagnostic: YTXPR0101MB0781:
x-microsoft-antispam-prvs: <YTXPR0101MB078142484AB8110D1E5F18C5AA9A0@YTXPR0101MB0781.CANPRD01.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(192374486261705)(100405760836317);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123562045)(20161123558120)(2016111802025)(20161123564045)(20161123560045)(6043046)(6072148)(201708071742011);SRVR:YTXPR0101MB0781;BCL:0;PCL:0;RULEID:;SRVR:YTXPR0101MB0781;
x-forefront-prvs: 0666E15D35
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(346002)(376002)(39830400003)(39380400002)(189003)(199004)(2616005)(82746002)(66066001)(5660300001)(7416002)(5250100002)(83716003)(446003)(58126008)(97736004)(86362001)(110136005)(316002)(68736007)(33656002)(54906003)(486006)(476003)(14454004)(11346002)(186003)(8666007)(53936002)(4326008)(36756003)(7736002)(6512007)(305945005)(81156014)(8936002)(26005)(2906002)(76176011)(6506007)(3660700001)(81166006)(106356001)(59450400001)(102836004)(105586002)(3280700002)(6116002)(6486002)(229853002)(478600001)(3846002)(2900100001)(99286004)(6246003)(25786009)(6436002)(8676002)(93886005);DIR:OUT;SFP:1102;SCL:1;SRVR:YTXPR0101MB0781;H:YTXPR0101MB2045.CANPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: DBwkeQLayZvkFFI7F3ED4jTW+AJrGm3Lvv/xfYlKWjGvuG6g+FyHIovOV8aTShYI/Rgwthb3PS4jq0KrMc++bOY/5TzRhG/+i1VCu4UOZOf8Bn7cAHZbAjPJcpYai20zyj1y2BE/EoJg2COJHBHicMR5gFrKjm9Nm83VGyXFA6x/XP6ps855zFIWo0ZZgfRB
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <3CD50565E70F874B8651DD7C38C3ECA2@CANPRD01.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: f297e2fe-0333-4f8a-1060-08d5b4ef8182
X-OriginatorOrg: raithlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f297e2fe-0333-4f8a-1060-08d5b4ef8182
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2018 14:25:10.5136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 18519031-7ff4-4cbb-bbcb-c3252d330f4b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YTXPR0101MB0781
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w48EQdaN019456

    
Hi Christian

> AMD APUs mandatory need the ACS flag set for the GPU integrated in the 
> CPU when IOMMU is enabled or otherwise you will break SVM.

OK but in this case aren't you losing (many of) the benefits of P2P since all DMAs will now get routed up to the IOMMU before being passed down to the destination PCIe EP?

> Similar problems arise when you do this for dedicated GPU, but we 
> haven't upstreamed the support for this yet.

Hmm, as above. With ACS enabled on all downstream ports any P2P enabled DMA will be routed to the IOMMU which removes a lot of the benefit. 
    
> So that is a clear NAK from my side for the approach.

Do you have an alternative? This is the approach we arrived it after a reasonably lengthy discussion on the mailing lists. Alex, are you still comfortable with this approach?
    
> And what exactly is the problem here?
 
We had a pretty lengthy discussion on this topic on one of the previous revisions. The issue is that currently there is no mechanism in the IOMMU code to inform VMs if IOMMU groupings change. Since p2pdma can dynamically change its topology (due to PCI hotplug) we had to be cognizant of the fact that ACS settings could change. Since there is no way to currently handle changing ACS settings and hence IOMMU groupings the consensus was to simply disable ACS on all ports in a p2pdma domain. This effectively makes all the devices in the p2pdma domain part of the same IOMMU grouping. The plan will be to address this in time and add a mechanism for IOMMU grouping changes and notification to VMs but that's not part of this series. Note you are still allowed to have ACS functioning on other PCI domains so if you do not a plurality of IOMMU groupings you can still achieve it (but you can't do p2pdma across IOMMU groupings, which is safe).

> I'm currently testing P2P with  GPUs in different IOMMU domains and at least with AMD IOMMUs that works perfectly fine.

Yup that should work though again I have to ask are you disabling ACS on the ports between the two peer devices to get the p2p benefit? If not you are not getting all the performance benefit (due to IOMMU routing), if you are then there are obviously security implications between those IOMMU domains if they are assigned to different VMs. And now the issue is if new devices are added and the p2p topology needed to change there would be no way to inform the VMs of any IOMMU group change. 

Cheers

Stephen
    
