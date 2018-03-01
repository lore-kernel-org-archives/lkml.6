Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161056AbeCASyG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 13:54:06 -0500
Received: from mail-eopbgr660097.outbound.protection.outlook.com ([40.107.66.97]:45311
        "EHLO CAN01-QB1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1034075AbeCASyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 13:54:03 -0500
From: "Stephen  Bates" <sbates@raithlin.com>
To: Bjorn Helgaas <helgaas@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>
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
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v2 04/10] PCI/P2PDMA: Clear ACS P2P flags for all devices
 behind switches
Thread-Topic: [PATCH v2 04/10] PCI/P2PDMA: Clear ACS P2P flags for all devices
 behind switches
Thread-Index: AQHTsO2G6rmrD21g1EKzg35eF0OenKO7rTOA//+Y6gA=
Date: Thu, 1 Mar 2018 18:54:01 +0000
Message-ID: <0D05579B-789C-4A19-B3A2-C1A630BE31C0@raithlin.com>
References: <20180228234006.21093-1-logang@deltatee.com>
 <20180228234006.21093-5-logang@deltatee.com>
 <20180301180257.GH13722@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180301180257.GH13722@bhelgaas-glaptop.roam.corp.google.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.a.0.180210
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sbates@raithlin.com;
x-originating-ip: [70.65.224.121]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;YTXPR0101MB1773;7:ec27+MmqoYWeXY1NWgs0zJC04jqQhzQXeiiXq/4ZIY5E4LDacoU1/H8zTBpPvaY93CWGGcA62wAxocp00WbMQ5QssgswGSwNeE0MhSi3zILX2k23PkVdrNyoKa1G7cCmPbeCe+zGKx1pNaKsyHohvzGUYOQpw4WkBvOzjMtaJsw/UZXjhPkbnBpYYcl8b5/fo9kq7RSsO2lk8lomK7eC5nHpVKVg5Be/4jWVIkHmq9ptBvpiTOlyVcUNEkwgqWKS
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: 51935fee-dad7-4bb0-ab6a-08d57fa5cbfa
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:YTXPR0101MB1773;
x-ms-traffictypediagnostic: YTXPR0101MB1773:
x-microsoft-antispam-prvs: <YTXPR0101MB1773A0E4860AFF498A73E782AAC60@YTXPR0101MB1773.CANPRD01.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(192374486261705);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231220)(944501230)(52105095)(10201501046)(3002001)(6041288)(2016111802025)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(6072148)(6043046)(201708071742011);SRVR:YTXPR0101MB1773;BCL:0;PCL:0;RULEID:;SRVR:YTXPR0101MB1773;
x-forefront-prvs: 05986C03E0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(346002)(376002)(366004)(39830400003)(396003)(39380400002)(199004)(189003)(51914003)(25786009)(7416002)(4326008)(105586002)(6512007)(6306002)(26005)(186003)(53936002)(6486002)(6506007)(6436002)(76176011)(97736004)(6246003)(102836004)(59450400001)(2906002)(68736007)(33656002)(3846002)(82746002)(6116002)(83716003)(966005)(81156014)(5660300001)(86362001)(66066001)(2900100001)(99286004)(2950100002)(478600001)(81166006)(106356001)(229853002)(8936002)(58126008)(316002)(305945005)(36756003)(5250100002)(7736002)(14454004)(3660700001)(3280700002)(110136005)(54906003)(8676002)(6606295002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:YTXPR0101MB1773;H:YTXPR0101MB2045.CANPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: yP3LYhZa+gAVTg4RKlxZh536MOI2lvsItxe8mzW7Q/DM7GKs2cq/hAnNbkb3OaoC/J/AedgB795U0Zl70LDraLAOINNaH1BZM2IXgQ+gfqXUCyq1A4fBP+6c3y36wfMexht/cKn4akiOtTJzMELU195x8Q0UH63V7uUw84tpNVU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <58846E1B81B25C4082CDBCD9FA094587@CANPRD01.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-OriginatorOrg: raithlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51935fee-dad7-4bb0-ab6a-08d57fa5cbfa
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2018 18:54:01.0702
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 18519031-7ff4-4cbb-bbcb-c3252d330f4b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YTXPR0101MB1773
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w21IsDk0019628

Thanks for the detailed review Bjorn!

>>  
>> +	  Enabling this option will also disable ACS on all ports behind
>> +	  any PCIe switch. This effictively puts all devices behind any
>> +	  switch into the same IOMMU group.

>
>  Does this really mean "all devices behind the same Root Port"?

Not necessarily. You might have a cascade of switches (i.e switches below a switch) to achieve a very large fan-out (in an NVMe SSD array for example) and we will only disable ACS on the ports below the relevant switch.

> What does this mean in terms of device security?  I assume it means,
> at least, that individual devices can't be assigned to separate VMs.

This was discussed during v1 [1]. Disabling ACS on all downstream ports of the switch means that all the EPs below it have to part of the same IOMMU grouping. However it was also agreed that as long as the ACS disable occurred at boot time (which is does in v2) then the virtualization layer will be aware of it and will perform the IOMMU group formation correctly.
    
> I don't mind admitting that this patch makes me pretty nervous, and I
> don't have a clear idea of what the implications of this are, or how
> to communicate those to end users.  "The same IOMMU group" is a pretty
> abstract idea.
    
Alex gave a good overview of the implications in [1].

Stephen 

[1] https://marc.info/?l=linux-pci&m=151512320031739&w=2
