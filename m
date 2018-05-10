Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965700AbeEJOUG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 10:20:06 -0400
Received: from mail-eopbgr670136.outbound.protection.outlook.com ([40.107.67.136]:10735
        "EHLO CAN01-TO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965516AbeEJOUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 10:20:02 -0400
From: "Stephen  Bates" <sbates@raithlin.com>
To: Jerome Glisse <jglisse@redhat.com>
CC: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>,
        "Logan Gunthorpe" <logang@deltatee.com>,
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
Thread-Index: AQHT21soiBVnp6SJuEuLCiH6kBzTLKQk+zIAgACHcYCAAJmxAIAABkiAgAAoBgCAAAW2gIAAA0YAgAAHvYCAAAGOgIAACKoAgACuAYCAAGxLgP//vUwAgABrwID//6HiAIAAesGAgADzGoA=
Date: Thu, 10 May 2018 14:20:00 +0000
Message-ID: <405531AE-8315-4A4F-9B0C-8DBE49BFCAB4@raithlin.com>
References: <20180508133407.57a46902@w520.home>
 <5fc9b1c1-9208-06cc-0ec5-1f54c2520494@deltatee.com>
 <20180508141331.7cd737cb@w520.home>
 <d70cf286-f7b7-99a5-1042-022506298fed@deltatee.com>
 <20180508205005.GC15608@redhat.com>
 <7FFB9603-DF9F-4441-82E9-46037CB6C0DE@raithlin.com>
 <a1a36f88-fbfb-b5ee-6dcb-5c5bb96132dd@amd.com>
 <1775CC56-4651-422F-953A-18E024D3717C@raithlin.com>
 <20180509160722.GB4140@redhat.com>
 <366A8132-B88A-40F7-BDE3-DA542E45FC0C@raithlin.com>
 <20180509174952.GC4140@redhat.com>
In-Reply-To: <20180509174952.GC4140@redhat.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.d.0.180505
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sbates@raithlin.com;
x-originating-ip: [70.65.250.31]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;YTXSPR01MB023;7:dG7wma3xmgTCgrr0zLLfj9MwOBtXCATGRkk7Z24S4b2ekurWHCGOTjpE4BHXAe5FJKaX50/dusGrdknPG5LyGvoxaauDuojV+Uw6bGBJYen9CAudT2Y+SJAcDiBdm07D4Qb+CPdylh+9/a4b9HPXj6zAnbcPz3iz9j8606MiyykCRRiBCN8nTUMeX3tW6hQMrCXxhmF/QGKGPRiQJOJa69Lt7e8oA6RBR/pOaiDHK5okZq59DAuDge9NEXqpnQuT
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(2017052603328)(7153060)(7193020);SRVR:YTXSPR01MB023;
x-ms-traffictypediagnostic: YTXSPR01MB023:
x-microsoft-antispam-prvs: <YTXSPR01MB023F1036BCA81B040625EC7AA980@YTXSPR01MB023.CANPRD01.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123564045)(2016111802025)(20161123558120)(6043046)(6072148)(201708071742011);SRVR:YTXSPR01MB023;BCL:0;PCL:0;RULEID:;SRVR:YTXSPR01MB023;
x-forefront-prvs: 066898046A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39830400003)(376002)(346002)(396003)(39380400002)(189003)(199004)(81166006)(81156014)(97736004)(11346002)(14454004)(106356001)(105586002)(3660700001)(8936002)(2906002)(6506007)(83716003)(6916009)(3846002)(68736007)(6116002)(2616005)(476003)(446003)(8676002)(7736002)(99286004)(305945005)(102836004)(186003)(5250100002)(86362001)(7416002)(5660300001)(26005)(25786009)(82746002)(478600001)(76176011)(3280700002)(33656002)(4326008)(6486002)(53936002)(6246003)(6436002)(8666007)(229853002)(2900100001)(93886005)(58126008)(316002)(66066001)(486006)(54906003)(36756003)(6512007);DIR:OUT;SFP:1102;SCL:1;SRVR:YTXSPR01MB023;H:YTXPR0101MB2045.CANPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: RxZtqftJEk00I2MNG0RUwAO5W52U/ssdvU64qwPm5APag+9hbsMk8FC1Et02LqDl8cNesnL5yib0lmg4YBnWKgfPv4t9tECpOdIYmAQEUlfiEc8SbvXukrD2Bx62bJWtGKMPfbMrsV2j7M0wKTIipx8wZqwlDpEwuI8KgSyww5rty3T/CdRY8eg9q0Xxj+3e
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <88BFB02BD50775468182FF5860ACE23A@CANPRD01.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 0fed9e8a-756c-4d46-f565-08d5b6811d5a
X-OriginatorOrg: raithlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fed9e8a-756c-4d46-f565-08d5b6811d5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2018 14:20:00.1236
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 18519031-7ff4-4cbb-bbcb-c3252d330f4b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YTXSPR01MB023
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4AEKBnU003421

Hi Jerome

> As it is tie to PASID this is done using IOMMU so looks for caller
> of amd_iommu_bind_pasid() or intel_svm_bind_mm() in GPU the existing
>  user is the AMD GPU driver see:
    
Ah thanks. This cleared things up for me. A quick search shows there are still no users of intel_svm_bind_mm() but I see the AMD version used in that GPU driver.

One thing I could not grok from the code how the GPU driver indicates which DMA events require ATS translations and which do not. I am assuming the driver implements someway of indicating that and its not just a global ON or OFF for all DMAs? The reason I ask is that I looking at if NVMe was to support ATS what would need to be added in the NVMe spec above and beyond what we have in PCI ATS to support efficient use of ATS (for example would we need a flag in the submission queue entries to indicate a particular IO's SGL/PRP should undergo ATS).

Cheers

Stephen    
