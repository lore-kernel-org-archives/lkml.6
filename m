Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935053AbeEINM6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 09:12:58 -0400
Received: from mail-eopbgr670094.outbound.protection.outlook.com ([40.107.67.94]:52069
        "EHLO CAN01-TO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934784AbeEINMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 09:12:55 -0400
From: "Stephen  Bates" <sbates@raithlin.com>
To: Jerome Glisse <jglisse@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>
CC: Alex Williamson <alex.williamson@redhat.com>,
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
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v4 04/14] PCI/P2PDMA: Clear ACS P2P flags for all devices
 behind switches
Thread-Topic: [PATCH v4 04/14] PCI/P2PDMA: Clear ACS P2P flags for all devices
 behind switches
Thread-Index: AQHT21soiBVnp6SJuEuLCiH6kBzTLKQk+zIAgACHcYCAAJmxAIAABkiAgAAoBgCAAAW2gIAAA0YAgAAHvYCAAAGOgIAACKoAgACuAYA=
Date: Wed, 9 May 2018 13:12:53 +0000
Message-ID: <7FFB9603-DF9F-4441-82E9-46037CB6C0DE@raithlin.com>
References: <20180423233046.21476-5-logang@deltatee.com>
 <20180507231306.GG161390@bhelgaas-glaptop.roam.corp.google.com>
 <e58e8d27-42a5-ca69-3b68-c409a2922cd1@amd.com>
 <0b4183ef-e720-204b-9e85-b9eaf7a4136a@deltatee.com>
 <a943a92d-15cd-fb2d-21c3-5e5cfccd9eff@amd.com>
 <3584a6ac-95c7-5d23-1859-aee30605776e@deltatee.com>
 <20180508133407.57a46902@w520.home>
 <5fc9b1c1-9208-06cc-0ec5-1f54c2520494@deltatee.com>
 <20180508141331.7cd737cb@w520.home>
 <d70cf286-f7b7-99a5-1042-022506298fed@deltatee.com>
 <20180508205005.GC15608@redhat.com>
In-Reply-To: <20180508205005.GC15608@redhat.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.d.0.180505
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sbates@raithlin.com;
x-originating-ip: [70.65.250.31]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;YTOPR0101MB1913;7:zoQDbILiRJAhhXFlHVKyQ3qtqxUJPBNJXVBChwQN73GFxLiHL5NMfBoDCs2v8EO58UUz0jC+MBGGxYyw7rttE90gUz1Bnpg3oDEy4CsYD7lZIDtpHGCT0dijynXu4EdFcvyET6TB30562RRX+DNNstqLHoVxqrPT1F+11WizO4ESORhqZwS4z0EGPFJjk6xmgsBq3Vc7Fduu6Ybv3rcKikBwTEPVDi87H0POXdIlSpmqPI8LSfh/vBr96XE8uaLZ
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:YTOPR0101MB1913;
x-ms-traffictypediagnostic: YTOPR0101MB1913:
x-microsoft-antispam-prvs: <YTOPR0101MB19132C6852A39EA4C2C988C4AA990@YTOPR0101MB1913.CANPRD01.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(192374486261705);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123564045)(20161123562045)(2016111802025)(20161123558120)(20161123560045)(6072148)(6043046)(201708071742011);SRVR:YTOPR0101MB1913;BCL:0;PCL:0;RULEID:;SRVR:YTOPR0101MB1913;
x-forefront-prvs: 0667289FF8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(376002)(396003)(39830400003)(366004)(189003)(199004)(3280700002)(3846002)(68736007)(82746002)(3660700001)(58126008)(6116002)(5250100002)(97736004)(110136005)(54906003)(6486002)(5660300001)(26005)(102836004)(186003)(93886005)(2906002)(316002)(36756003)(66066001)(7416002)(53936002)(76176011)(99286004)(478600001)(83716003)(486006)(105586002)(6506007)(229853002)(2900100001)(446003)(59450400001)(106356001)(4326008)(8666007)(6512007)(7736002)(33656002)(2616005)(8936002)(6436002)(6246003)(476003)(14454004)(11346002)(81166006)(8676002)(81156014)(25786009)(86362001)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:YTOPR0101MB1913;H:YTOPR0101MB2043.CANPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: qW6OxSwOTnGNc51MX2Af2KRH7qiPJuk6W5JjNkd4LrmvLFFdPogqKfa6DJeYTF81cxP8BkL9A5xj69IUStnsblyDnqRpJpaqUIxzOC3rxWZQVhyrTcDFVV81bfklOHo37PhmBbGanuc//MH1xhdw6pU/67+aPfhsBv0MK6YR22+qbXcfnBxY09OqLAfLJcxA
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <3EC9F89D08826A49BADA38D4D9976C09@CANPRD01.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 94552ccb-caa2-47ff-a853-08d5b5ae92c1
X-OriginatorOrg: raithlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94552ccb-caa2-47ff-a853-08d5b5ae92c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2018 13:12:53.3270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 18519031-7ff4-4cbb-bbcb-c3252d330f4b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YTOPR0101MB1913
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w49DDVO8008081

Jerome and Christian
    
> I think there is confusion here, Alex properly explained the scheme
> PCIE-device do a ATS request to the IOMMU which returns a valid
> translation for a virtual address. Device can then use that address
> directly without going through IOMMU for translation.

So I went through ATS in version 4.0r1 of the PCI spec. It looks like even a ATS translated TLP is still impacted by ACS though it has a separate control knob for translated address TLPs (see 7.7.7.2 of 4.0r1 of the spec). So even if your device supports ATS a P2P DMA will still be routed to the associated RP of the domain and down again unless we disable ACS DT P2P on all bridges between the two devices involved in the P2P DMA. 

So we still don't get fine grained control with ATS and I guess we still have security issues because a rogue or malfunctioning EP could just as easily issue TLPs with TA set vs not set.

> Also ATS is meaningless without something like PASID as far as i know.
    
ATS is still somewhat valuable without PSAID in the sense you can cache IOMMU address translations at the EP. This saves hammering on the IOMMU as much in certain workloads.

Interestingly Section 7.7.7.2 almost mentions that Root Ports that support ATS AND can implement P2P between root ports should advertise "ACS Direct Translated P2P (T)" capability. This ties into the discussion around P2P between route ports we had a few weeks ago...

Stephen    
