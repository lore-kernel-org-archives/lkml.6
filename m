Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751410AbeCNTe6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 15:34:58 -0400
Received: from mail-eopbgr670098.outbound.protection.outlook.com ([40.107.67.98]:18944
        "EHLO CAN01-TO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750779AbeCNTez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 15:34:55 -0400
From: "Stephen  Bates" <sbates@raithlin.com>
To: Dan Williams <dan.j.williams@intel.com>,
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
        =?utf-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v3 01/11] PCI/P2PDMA: Support peer-to-peer memory
Thread-Topic: [PATCH v3 01/11] PCI/P2PDMA: Support peer-to-peer memory
Thread-Index: AQHTujlZo8bTZRn+4ECdETRRU1rPhqPNgjSAgADeTICAABJggIAAD1YAgAAHVACAAAJxAIAACW8AgAAO3oCAAAopgIAACqIA//+kE4CAAG7lAIAAA38AgAA8KICAAN/GAIAAKyWAgAADR4CAAAbOAP//nVEA
Date: Wed, 14 Mar 2018 19:34:53 +0000
Message-ID: <AA646409-BB63-4757-A250-CE7118D4D3B8@raithlin.com>
References: <a0af83f8-2cbc-862b-6f8b-231991527cfc@deltatee.com>
 <3ea80992-a0fc-08f2-d93d-ae0ec4e3f4ce@codeaurora.org>
 <4eb6850c-df1b-fd44-3ee0-d43a50270b53@deltatee.com>
 <757fca36-dee4-e070-669e-f2788bd78e41@codeaurora.org>
 <4f761f55-4e9a-dccb-d12f-c59d2cd689db@deltatee.com>
 <BB94077B-7EB3-49C4-862D-BF77D0A692CC@raithlin.com>
 <20180313230850.GA45763@bhelgaas-glaptop.roam.corp.google.com>
 <8de5d3dd-a78f-02d5-0eea-4365364143b6@deltatee.com>
 <20180314025639.GA50067@bhelgaas-glaptop.roam.corp.google.com>
 <112493af-ccd0-455b-6600-b50764f7ab7e@deltatee.com>
 <20180314185159.GD179719@bhelgaas-glaptop.roam.corp.google.com>
 <b75e83ad-bb83-1f8d-1751-0989cc2493f1@deltatee.com>
 <CAPcyv4g-A6fqdTahxX=aONSCgp1eEvBb=ZVMzbZUWUDmqBbj7Q@mail.gmail.com>
In-Reply-To: <CAPcyv4g-A6fqdTahxX=aONSCgp1eEvBb=ZVMzbZUWUDmqBbj7Q@mail.gmail.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.b.0.180311
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sbates@raithlin.com;
x-originating-ip: [70.73.168.51]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;YTXPR0101MB1839;6:V1MtqD3m7e4Ujk3jo4752LBCZNtbUhTlbRb3fht8xY0C6CMATTduYdHQ2GripXLFYztcPkFek1tmaTPWANynTM+iWu6ek9NVK1U+bvawKJKS8PJ1dwBTaLM+6QtYVi4tKbWruwrNt875B6DBtJAzRK65NjrHQhRBYhtGLuWzYVE4rJxpdxmW7ONsHqfkTbRH2HKqR3S0y3ryZMgPB2irQN/Bel6kiEAP4v3BSV+KZzQKQVSPLBWXzxZeGXOly/rTspXZ7suW3MTfxJV+TZlBmGbXozEJtAru4Xa5oRBrqm7EEcxUtEgycwF0ySeRtRchomKDFpJz6UYesRCLC+STwLsbNWCrqN8g9bpY87uLNFiTVBY8VWkBNbS5+WSbJRwd;5:9SizPxZB+mPNdokL2hF1+cy8jWamax1DNQGrJAvhEglh9jQTxTBbVjRiZ3aPUxxS7x6zkObfAYdleALZVROshZTU7zZDRM1Q5k3gXqP1IxSQChUP0dyDGhGTGo4b3WAKN1ryiNIy0IH6pUeE7OHD7/Id9zJZzVGI43LNhT0ZNeQ=;24:Ccn4ioUUa8lpPicoWSbkt/M2Yeehh/QvZNbsuZ7AUnfZ4vbats0TEI8LYoSrTAldcwGmCrlXqnJ/5G1DpSR5SL9Uuzvk7Pi+v5iD3s6Iw/I=;7:sM+3a3KSPRLwOMvAkhM2dbGSwnuYtlESnpO0IFhsfyhi/GXyFfrl3dhIKEbkWz52UFqKN31iR0K0KUDosxDugtNcrlfCGX8D9NQT0ZUBYVseTT7jW/rSzdcj0ecOVhMwSZGQU4pSvhLlh4G+V8V3vFHVg3x9CU2be4MzW7KrS8NG+cNMLfYTyUhnYBPsUnBreZfD/duqfWx0IzK7scXsn1XRFJ5n3AxtN/bzAd989Rjgx73i/SOLCl2HLGhAbFYB
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: 81058eac-3927-4d8f-6952-08d589e2a912
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(3008032)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:YTXPR0101MB1839;
x-ms-traffictypediagnostic: YTXPR0101MB1839:
x-microsoft-antispam-prvs: <YTXPR0101MB183939879055680533F8435BAAD10@YTXPR0101MB1839.CANPRD01.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231221)(944501244)(52105095)(93006095)(93001095)(6041310)(2016111802025)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(6072148)(6043046)(201708071742011);SRVR:YTXPR0101MB1839;BCL:0;PCL:0;RULEID:;SRVR:YTXPR0101MB1839;
x-forefront-prvs: 0611A21987
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(396003)(346002)(366004)(39830400003)(11905935001)(189003)(199004)(25786009)(6306002)(229853002)(76176011)(6512007)(5250100002)(106356001)(3846002)(33656002)(6486002)(966005)(66066001)(4326008)(6246003)(82746002)(14454004)(3280700002)(6116002)(478600001)(26005)(8936002)(5660300001)(8676002)(7416002)(36756003)(81166006)(186003)(53936002)(2950100002)(6506007)(97736004)(305945005)(102836004)(81156014)(68736007)(7736002)(2906002)(3660700001)(86362001)(58126008)(105586002)(99286004)(93886005)(6436002)(2900100001)(54906003)(316002)(110136005)(83716003);DIR:OUT;SFP:1102;SCL:1;SRVR:YTXPR0101MB1839;H:YTXPR0101MB2045.CANPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: e+PuAyaJEVjRBeWkTfLT+OdELBUTC5q+2ou3NLYUCa6SS86J7FMbOi08vGEtr2kVktjFkHtewwxhJYyfNuUzeg+Nl3jlSPT2yX0eHiLwOpfHc/AOFMZfzTK8N9tt76yC9a+piMaJH/ZLuK2+baYs4qEHlgKwELdHoX3QoYxJwLGzbSZCAWJt/RzIOQoVRBZC5Kv6EtmwKh2yPp1CGXHk6WjUyODmPPob9q6SQOaM8bRdnSylwi47KPv3KZiCAYZpDRgUuUbgke02teaBMT9+rzlXdMMt3jOmVSQvxkm+uiF8QcuyRGEt5/QfWcwrYXOFzG2bxVpiM6Wvc21jSZZxGg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <550690715E85424587140925CC90F10E@CANPRD01.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-OriginatorOrg: raithlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81058eac-3927-4d8f-6952-08d589e2a912
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2018 19:34:53.3869
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 18519031-7ff4-4cbb-bbcb-c3252d330f4b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YTXPR0101MB1839
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2EJZ4Pm018710

> P2P over PCI/PCI-X is quite common in devices like raid controllers.

Hi Dan 

Do you mean between PCIe devices below the RAID controller? Isn't it pretty novel to be able to support PCIe EPs below a RAID controller (as opposed to SCSI based devices)?

> It would be useful if those configurations were not left behind so
> that Linux could feasibly deploy offload code to a controller in the
> PCI domain.
   
Agreed. I think this would be great. Kind of like the XCOPY framework that was proposed a while back for SCSI devices [1] but updated to also include NVMe devices. That is definitely a use case we would like this framework to support.

Stephen
 
[1] https://lwn.net/Articles/592094/
