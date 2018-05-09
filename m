Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934728AbeEIMo0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 08:44:26 -0400
Received: from mail-eopbgr670098.outbound.protection.outlook.com ([40.107.67.98]:38285
        "EHLO CAN01-TO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933953AbeEIMoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 08:44:23 -0400
From: "Stephen  Bates" <sbates@raithlin.com>
To: Don Dutile <ddutile@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>
CC: Logan Gunthorpe <logang@deltatee.com>,
        =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>,
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
Thread-Index: AQHT21soiBVnp6SJuEuLCiH6kBzTLKQk+zIAgACHcYCAAJmxAIAABkiAgAAoBgCAAAW2gIAAA0YAgAAHvYCAAAGOgIAABt+AgAABmICAAApggP//n96AgABqfgCAAATvgIAAjJCA
Date: Wed, 9 May 2018 12:44:21 +0000
Message-ID: <C6D0BD3A-FA82-425A-899C-C2DBDCBC7EEC@raithlin.com>
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
 <11819753-af26-4632-8580-d4a47127a3b2@redhat.com>
In-Reply-To: <11819753-af26-4632-8580-d4a47127a3b2@redhat.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.d.0.180505
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sbates@raithlin.com;
x-originating-ip: [70.65.250.31]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;YTOPR0101MB1020;7:QJQURTDvQ3VgxwqhOYal/h9gw2PJJTZ0R82xXxc/ZA2EqFu6hsGhgoNXCDbpJctmax0Ob7ZuDEoS6j/oxkOGhkzV5hXYr+jhhgPV6YomsO2gLoChGhjwkOLZuq2KftZVU2qbXhVbKPX17FT/acN36to0dTUbMeROOdJ8U0entGjqe0Li0ThgLYNa8QqUMZWiCt2pwcDEhanBZEbWsPpD7GNfajP8hzJ6NVCBF8QHtVppXpZQ+fISiGb3hezysYni
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(2017052603328)(7153060)(7193020);SRVR:YTOPR0101MB1020;
x-ms-traffictypediagnostic: YTOPR0101MB1020:
x-microsoft-antispam-prvs: <YTOPR0101MB1020B37AFA1891809EFA3158AA990@YTOPR0101MB1020.CANPRD01.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(192374486261705);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(2016111802025)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(6072148)(6043046)(201708071742011);SRVR:YTOPR0101MB1020;BCL:0;PCL:0;RULEID:;SRVR:YTOPR0101MB1020;
x-forefront-prvs: 0667289FF8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(396003)(39830400003)(39380400002)(189003)(199004)(3280700002)(99286004)(3660700001)(6486002)(6506007)(229853002)(5250100002)(486006)(6246003)(86362001)(53936002)(26005)(33656002)(7736002)(14454004)(68736007)(2906002)(97736004)(81156014)(8936002)(6512007)(59450400001)(8676002)(8666007)(36756003)(106356001)(102836004)(105586002)(6436002)(76176011)(4326008)(66066001)(316002)(5660300001)(81166006)(478600001)(83716003)(93886005)(305945005)(58126008)(446003)(476003)(186003)(11346002)(7416002)(25786009)(110136005)(3846002)(54906003)(6116002)(82746002)(2900100001)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:YTOPR0101MB1020;H:YTOPR0101MB2043.CANPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: DBeUl/QOO9aF6T3CKM6soglZkgls2Xuq3zFlfBfbmRBLd/uUGOMlMIhXn3fZqCc5QpWG5MrHlw9SQNlThLSXVP+nVm1gSfR+IFSODdT400g0bTgjl5P+cTvb9bd2eD0lntkOsX89DgQW3gHeYSbFBuijaMiwjUb7yptoFBc74NGw//fTwU5HwOCktCvXQqBQ
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <42C078A13685944FAC4A17915C5D134F@CANPRD01.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 1e5844b6-b15b-4532-5fe7-08d5b5aa968b
X-OriginatorOrg: raithlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e5844b6-b15b-4532-5fe7-08d5b5aa968b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2018 12:44:21.6952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 18519031-7ff4-4cbb-bbcb-c3252d330f4b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YTOPR0101MB1020
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w49CiWmS004380

Hi Don

>    RDMA VFs lend themselves to NVMEoF w/device-assignment.... need a way to
>    put NVME 'resources' into an assignable/manageable object for 'IOMMU-grouping',
>    which is really a 'DMA security domain' and less an 'IOMMU grouping domain'.
    
Ha, I like your term "DMA Security Domain" which sounds about right for what we are discussing with p2pdma and ACS disablement ;-). The problem is that ACS is, in some ways, too big of hammer for what we want here in the sense that it is either on or off for the bridge or MF EP we enable/disable it for. ACS can't filter the TLPs by address or ID though PCI-SIG are having some discussions on extending ACS. That's a long term solution and won't be applicable to us for some time.

NVMe SSDs that support SR-IOV are coming to market but we can't assume all NVMe SSDs with support SR-IOV. That will probably be a pretty high end-feature...

Stephen
    
    
