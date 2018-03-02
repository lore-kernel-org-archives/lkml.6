Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164909AbeCBRjE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 12:39:04 -0500
Received: from g2t2354.austin.hpe.com ([15.233.44.27]:45506 "EHLO
        g2t2354.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1946772AbeCBRjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 12:39:02 -0500
From: "Kani, Toshi" <toshi.kani@hpe.com>
To: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>, "hch@lst.de" <hch@lst.de>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "jglisse@redhat.com" <jglisse@redhat.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "maxg@mellanox.com" <maxg@mellanox.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "keith.busch@intel.com" <keith.busch@intel.com>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "oliveroh@au1.ibm.com" <oliveroh@au1.ibm.com>
Subject: Re: [PATCH v2 00/10] Copy Offload in NVMe Fabrics with P2P PCI Memory
Thread-Topic: [PATCH v2 00/10] Copy Offload in NVMe Fabrics with P2P PCI
 Memory
Thread-Index: AQHTsO2SauImX1OM+UWgCf/w5DnppaO6wDuAgAAAYICAAQJ2gIAAFIKAgAABk4CAAAOhgIAAFJIAgAAG2oCAAADQAIABNwIA///9QACAABgkAA==
Date: Fri, 2 Mar 2018 17:38:58 +0000
Message-ID: <1520015040.2693.38.camel@hpe.com>
References: <20180228234006.21093-1-logang@deltatee.com>
         <1519876489.4592.3.camel@kernel.crashing.org>
         <1519876569.4592.4.camel@au1.ibm.com>
         <CAPcyv4h7mcFphv3j_vW-CGxXa2pjQgLqpBOLzHuTzAFzygai-Q@mail.gmail.com>
         <1519936477.4592.23.camel@au1.ibm.com>
         <1519936815.4592.25.camel@au1.ibm.com> <20180301205315.GJ19007@ziepe.ca>
         <1519942012.4592.31.camel@au1.ibm.com>
         <CA+55aFy-oAiFJ3WDx4giR1enj65y-YJnZZhY6geFw0ygFyKXfQ@mail.gmail.com>
         <1519943658.4592.34.camel@kernel.crashing.org>
         <1520010446.2693.19.camel@hpe.com>
         <CA+55aFztf2D4NwEkRxnJkD6kK62CWKxmERbALMGoMgFEGLEJZA@mail.gmail.com>
In-Reply-To: <CA+55aFztf2D4NwEkRxnJkD6kK62CWKxmERbALMGoMgFEGLEJZA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=toshi.kani@hpe.com;
x-originating-ip: [15.219.147.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AT5PR8401MB0353;7:4j7SDDbuN5iH8dyYhrB6n1zwQd/OXQEDNp1F7qXYhs+eFLYHIALd0H9sAYWl7KU9leUwsWMD2RbqBqoExD3M1vQHfMDNkyqDmjpOH2/G/BnqizlokZbWbbAfM3jXloqx5nhQpnJO9lGBJnJjCNWx55cS4cAUaIpFrc+OgMiXv6dNLeTBNnzY6Cxxizy/DWJtxyE8IDYwiPut1Nkdi4B7lF5c6kIdTWAZJJFNqqSExtCsGT0Zuv/BpJaqAsLDTTvX
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e0d037fb-75f0-4bb0-d809-08d580647a80
x-microsoft-antispam: UriScan:(222181515654134);BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989060)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:AT5PR8401MB0353;
x-ms-traffictypediagnostic: AT5PR8401MB0353:
x-microsoft-antispam-prvs: <AT5PR8401MB0353BD7CBDB5258F2C46502E82C50@AT5PR8401MB0353.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(227479698468861)(222181515654134);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(3002001)(3231220)(944501242)(52105095)(93006095)(93001095)(10201501046)(6055026)(6041288)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:AT5PR8401MB0353;BCL:0;PCL:0;RULEID:;SRVR:AT5PR8401MB0353;
x-forefront-prvs: 05991796DF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(39380400002)(376002)(346002)(396003)(189003)(377424004)(199004)(36756003)(99286004)(76176011)(2900100001)(97736004)(3660700001)(316002)(478600001)(54906003)(68736007)(81156014)(81166006)(1730700003)(26005)(8676002)(6116002)(59450400001)(186003)(6506007)(102836004)(53546011)(3846002)(93886005)(6246003)(6486002)(7736002)(2501003)(4326008)(229853002)(86362001)(6436002)(3280700002)(305945005)(105586002)(5250100002)(8936002)(5660300001)(2906002)(5640700003)(7416002)(6512007)(14454004)(103116003)(66066001)(53936002)(6916009)(2950100002)(25786009)(2351001)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:AT5PR8401MB0353;H:AT5PR8401MB1297.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: xxRSHtSoDM+ibcBnfF7IVC3k6bhJo2ioPUoLZrUoCuPsswoN79CtF368Lg4J0eEpdwROiyMNN4PPML8XIB7QZw/OVEXy98ftxod4qUzsvfb0G8MiF+rth+hhhRz/8E5A2F0F5QYFXGYQM0vY6ub46NZ0UfP/UNZSZNL4qZtC3NA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <DF9DA41A243442459170B104F083FDB9@NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e0d037fb-75f0-4bb0-d809-08d580647a80
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2018 17:38:58.2204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB0353
X-OriginatorOrg: hpe.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w22HdDCn029761

On Fri, 2018-03-02 at 08:57 -0800, Linus Torvalds wrote:
> On Fri, Mar 2, 2018 at 8:22 AM, Kani, Toshi <toshi.kani@hpe.com> wrote:
> > 
> > FWIW, this thing is called MTRRs on x86, which are initialized by BIOS.
> 
> No.
> 
> Or rather, that's simply just another (small) part of it all - and an
> architected and documented one at that.
> 
> Like the page table caching entries, the memory type range registers
> are really just "secondary information". They don't actually select
> between PCIe and RAM, they just affect the behavior on top of that.
> 
> The really nitty-gritty stuff is not architected, and generally not
> documented outside (possibly) the BIOS writer's guide that is not made
> public.
> 
> Those magical registers contain details like how the DRAM is
> interleaved (if it is), what the timings are, where which memory
> controller handles which memory range, and what are goes to PCIe etc.
> 
> Basically all the actual *steering* information is very much hidden
> away from the kernel (and often from the BIOS too). The parts we see
> at a higher level are just tuning and tweaks.
> 
> Note: the details differ _enormously_ between different chips. The
> setup can be very different, with things like Knights Landing having
> the external cache that can also act as local memory that isn't a
> cache but maps at a different physical address instead etc. That's the
> kind of steering I'm talking about - at a low level how physical
> addresses get mapped to different cache partitions, memory
> controllers, or to the IO system etc.

Right, MRC code is not documented publicly, and it is very much CPU
dependent.  It programs address decoders and maps DRAMs to physical
address as you described.  MTRRs have nothing to do with this memory
controller setting.  That said, MTRRs specify CPU's memory access type,
such as UC and WB.

Thanks,
-Toshi
