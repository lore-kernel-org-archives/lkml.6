Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932670AbeEHOow (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 10:44:52 -0400
Received: from mail-eopbgr670122.outbound.protection.outlook.com ([40.107.67.122]:49997
        "EHLO CAN01-TO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932141AbeEHOot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 10:44:49 -0400
From: "Stephen  Bates" <sbates@raithlin.com>
To: Dan Williams <dan.j.williams@intel.com>,
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
Thread-Index: AQHT21soiBVnp6SJuEuLCiH6kBzTLKQl+8wA//+fHIA=
Date: Tue, 8 May 2018 14:44:43 +0000
Message-ID: <64C231F5-DE36-415F-B308-3A423B0BBACB@raithlin.com>
References: <20180423233046.21476-1-logang@deltatee.com>
 <20180423233046.21476-5-logang@deltatee.com>
 <CAPcyv4g+5N_n03J-VhmJfrr60Sqk95ZapLKBkwSsGvV4nQ+ZRw@mail.gmail.com>
In-Reply-To: <CAPcyv4g+5N_n03J-VhmJfrr60Sqk95ZapLKBkwSsGvV4nQ+ZRw@mail.gmail.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.c.0.180410
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sbates@raithlin.com;
x-originating-ip: [70.65.250.31]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;YTXPR0101MB1342;7:YbfraJUosNwG9BnIg8AL8xu8kTxj+AndlnUjYiK+T3l6qA7W3eJSdYrLegucmIft27VXhJNP/9w7gxGfiGOWIxOJAJsIdPAHPNyJooxYPPkMf4KSJIZ7dgBvc2SPLK1cZerDhd16o4PIr6ZqVLXPN3GmgZQKAuLWRBSTFojtkCIP5OkLJN3Sgu/1HWJSM8trDclsL4Myg0AqJEqv0AwU1Zs+LEsNItxPu2iujvgcs4B1BCk9+8AR4x6fTT2R5d4R
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:YTXPR0101MB1342;
x-ms-traffictypediagnostic: YTXPR0101MB1342:
x-microsoft-antispam-prvs: <YTXPR0101MB134255B53CDEB9DBE3BA0579AA9A0@YTXPR0101MB1342.CANPRD01.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(192374486261705);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(2016111802025)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(6072148)(6043046)(201708071742011);SRVR:YTXPR0101MB1342;BCL:0;PCL:0;RULEID:;SRVR:YTXPR0101MB1342;
x-forefront-prvs: 0666E15D35
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(366004)(39380400002)(39830400003)(199004)(189003)(2616005)(6246003)(478600001)(26005)(97736004)(486006)(2906002)(102836004)(53936002)(33656002)(6116002)(8666007)(83716003)(6306002)(6512007)(446003)(6436002)(11346002)(476003)(186003)(3846002)(3280700002)(8676002)(86362001)(81166006)(8936002)(7736002)(81156014)(4326008)(76176011)(3660700001)(106356001)(5250100002)(59450400001)(105586002)(2900100001)(6486002)(58126008)(54906003)(66066001)(14454004)(6506007)(966005)(5660300001)(68736007)(305945005)(7416002)(82746002)(229853002)(99286004)(110136005)(25786009)(316002)(36756003)(6606295002);DIR:OUT;SFP:1102;SCL:1;SRVR:YTXPR0101MB1342;H:YTXPR0101MB2045.CANPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 8Jo20T3nUsSBOxARSjslBuwdw7spgWcosRprAyb4dO2zCKZcN8XyrkETRf6j0rF1gQlva3j3UzT7OchqVFdW4LktugYdEyQega+CAyX98LMmCQThY8w7Eo0zAhVPSuYIIwvA/NbUEYgyP60vB4HbxMtPDAvd2mQyAvy7ki8aW0SAa4atSoKDI7PutC5VInOD
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <A40D802C654F474B960E4CD35F06776A@CANPRD01.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: da443437-79e3-41a5-aa36-08d5b4f23cf3
X-OriginatorOrg: raithlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da443437-79e3-41a5-aa36-08d5b4f23cf3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2018 14:44:43.9699
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 18519031-7ff4-4cbb-bbcb-c3252d330f4b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YTXPR0101MB1342
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w48EjPsB019559

Hi Dan

>    It seems unwieldy that this is a compile time option and not a runtime
>    option. Can't we have a kernel command line option to opt-in to this
>    behavior rather than require a wholly separate kernel image?
  
I think because of the security implications associated with p2pdma and ACS we wanted to make it very clear people were choosing one (p2pdma) or the other (IOMMU groupings and isolation). However personally I would prefer including the option of a run-time kernel parameter too. In fact a few months ago I proposed a small patch that did just that [1]. It never really went anywhere but if people were open to the idea we could look at adding it to the series.
  
> Why is this text added in a follow on patch and not the patch that
>  introduced the config option?

Because the ACS section was added later in the series and this information is associated with that additional functionality.
    
> I'm also wondering if that command line option can take a 'bus device
> function' address of a switch to limit the scope of where ACS is
> disabled.

By this you mean the address for either a RP, DSP, USP or MF EP below which we disable ACS? We could do that but I don't think it avoids the issue of changes in IOMMU groupings as devices are added/removed. It simply changes the problem from affecting and entire PCI domain to a sub-set of the domain. We can already handle this by doing p2pdma on one RP and normal IOMMU isolation on the other RPs in the system.

Stephen

[1] https://marc.info/?l=linux-doc&m=150907188310838&w=2
    
