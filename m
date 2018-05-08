Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932687AbeEHVmf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 17:42:35 -0400
Received: from mail-eopbgr660134.outbound.protection.outlook.com ([40.107.66.134]:63140
        "EHLO CAN01-QB1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932460AbeEHVmb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 17:42:31 -0400
From: "Stephen  Bates" <sbates@raithlin.com>
To: Alex Williamson <alex.williamson@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>
CC: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>,
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
Thread-Index: AQHT21soiBVnp6SJuEuLCiH6kBzTLKQk+zIAgACHcYCAAJmxAIAABkiAgAAoBgCAAAW2gIAAA0YAgAAHvYCAAAGOgIAABt+AgAABmICAAApggP//n96A
Date: Tue, 8 May 2018 21:42:27 +0000
Message-ID: <354F7407-0DC7-470C-B9AA-74FDF9C46B08@raithlin.com>
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
In-Reply-To: <20180508152631.50fd583c@w520.home>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.d.0.180505
x-originating-ip: [70.65.250.31]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;YTXPR0101MB1294;7:REwkqVvnVkXQ7U4pm+pEAF8mjVfVxrNHDfeYkXE0EzgcBBSQJfWDwjXZ1RleW163asGqlfjPxC+F9e2uEcZqhT/HGPiQS5hDDhI8FoIf/qZV1Q85gsaVZySX5aZgQ86Mjp7uu2onWGKr7XvtJ8WEbBvXnHWuiNCogIWMFIOiscBZsUptSxQSgEfMVS+Ja11ll9KkYDZmpvucsA3/Ww5fNY1y0MZLSvui0cLpz/BQGiuUEwKSq2X7XwP5h9BKAaR2
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:YTXPR0101MB1294;
x-ms-traffictypediagnostic: YTXPR0101MB1294:
x-microsoft-antispam-prvs: <YTXPR0101MB1294E5DF66C11A8BF8237281AA9A0@YTXPR0101MB1294.CANPRD01.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(6043046)(6072148)(201708071742011);SRVR:YTXPR0101MB1294;BCL:0;PCL:0;RULEID:;SRVR:YTXPR0101MB1294;
x-forefront-prvs: 0666E15D35
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39830400003)(366004)(346002)(396003)(376002)(39380400002)(199004)(189003)(6506007)(76176011)(2616005)(25786009)(66066001)(486006)(97736004)(81156014)(14454004)(36756003)(476003)(105586002)(5660300001)(33656002)(8676002)(561944003)(93886005)(7416002)(99286004)(229853002)(305945005)(8936002)(7736002)(106356001)(478600001)(81166006)(6486002)(6436002)(102836004)(26005)(8666007)(446003)(186003)(316002)(2900100001)(3846002)(82746002)(83716003)(3280700002)(2906002)(4326008)(53936002)(68736007)(6512007)(86362001)(6116002)(3660700001)(110136005)(54906003)(58126008)(5250100002)(6346003)(11346002)(6246003);DIR:OUT;SFP:1102;SCL:1;SRVR:YTXPR0101MB1294;H:YTXPR0101MB2045.CANPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sbates@raithlin.com;
x-microsoft-antispam-message-info: 9dap89rQ2VgqFY+zpqEVVxAj0BqUDaR/xHgS2AeomUaZELNvSBwZ6o7PGY6PSMfDOGfi0nVvo3KCb682SC8bvbHt/DnxJ2+O5S6+lhGU5IUDDEoFcEQdr+3lvd7BdMaTeKQYkiUx8AsqKoedtXgMROK6ZFxF0ZbNYfNi4LXqamUdhnmL78dRwr8k/M5TJQH+
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <ED737D195D26F846959455EA0A690DCD@CANPRD01.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: d86f6740-2190-41a2-90dc-08d5b52c984a
X-OriginatorOrg: raithlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d86f6740-2190-41a2-90dc-08d5b52c984a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2018 21:42:27.9755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 18519031-7ff4-4cbb-bbcb-c3252d330f4b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YTXPR0101MB1294
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w48LgfQQ013687

Hi Alex

>    But it would be a much easier proposal to disable ACS when the IOMMU is
>    not enabled, ACS has no real purpose in that case.

I guess one issue I have with this is that it disables IOMMU groups for all Root Ports and not just the one(s) we wish to do p2pdma on. 
    
>    The IOMMU and P2P are already not exclusive, we can bounce off the
>    IOMMU or make use of ATS as we've previously discussed.  We were
>    previously talking about a build time config option that you didn't
>    expect distros to use, so I don't think intervention for the user to
>    disable the IOMMU if it's enabled by default is a serious concern
>    either.

ATS definitely makes things more interesting for the cases where the EPs support it. However I don't really have a handle on how common ATS support is going to be in the kinds of devices we have been focused on (NVMe SSDs and RDMA NICs mostly). 
    
> What you're trying to do is enabled direct peer-to-peer for endpoints
>  which do not support ATS when the IOMMU is enabled, which is not
>  something that necessarily makes sense to me. 

As above the advantage of leaving the IOMMU on is that it allows for both p2pdma PCI domains and IOMMU groupings PCI domains in the same system. It is just that these domains will be separate to each other.

>  So that leaves avoiding bounce buffers as the remaining IOMMU feature

I agree with you here that the devices we will want to use for p2p will probably not require a bounce buffer and will support 64 bit DMA addressing.
    
> I'm still not seeing why it's terribly undesirable to require devices to support
> ATS if they want to do direct P2P with an IOMMU enabled.

I think the one reason is for the use-case above. Allowing IOMMU groupings on one domain and p2pdma on another domain....
    
Stephen
    
