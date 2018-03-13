Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932646AbeCMWpq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 18:45:46 -0400
Received: from mail-eopbgr660118.outbound.protection.outlook.com ([40.107.66.118]:26395
        "EHLO CAN01-QB1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932222AbeCMWpo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 18:45:44 -0400
From: "Stephen  Bates" <sbates@raithlin.com>
To: Sinan Kaya <okaya@codeaurora.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jason Gunthorpe <jgg@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        =?utf-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v3 01/11] PCI/P2PDMA: Support peer-to-peer memory
Thread-Topic: [PATCH v3 01/11] PCI/P2PDMA: Support peer-to-peer memory
Thread-Index: AQHTujlZo8bTZRn+4ECdETRRU1rPhqPNgjSAgADeTICAABJggIAAD1YAgAAHVACAAAJxAIAACW8AgAAO3oCAAAopgIAACqIAgAAIBID//5/mAA==
Date: Tue, 13 Mar 2018 22:45:41 +0000
Message-ID: <47F026DE-AFD0-4F63-8D39-375D3684C7B1@raithlin.com>
References: <20180312193525.2855-1-logang@deltatee.com>
 <20180312193525.2855-2-logang@deltatee.com>
 <59fd2f5d-177f-334a-a9c4-0f8a6ec7c303@codeaurora.org>
 <24d8e5c2-065d-8bde-3f5d-7f158be9c578@deltatee.com>
 <52cbbbc4-c488-f83f-8d02-14d455b4efd7@codeaurora.org>
 <3e738f95-d73c-4182-2fa1-8664aafb1ab7@deltatee.com>
 <703aa92c-0c1c-4852-5887-6f6e6ccde0fb@codeaurora.org>
 <a0af83f8-2cbc-862b-6f8b-231991527cfc@deltatee.com>
 <3ea80992-a0fc-08f2-d93d-ae0ec4e3f4ce@codeaurora.org>
 <4eb6850c-df1b-fd44-3ee0-d43a50270b53@deltatee.com>
 <757fca36-dee4-e070-669e-f2788bd78e41@codeaurora.org>
 <4f761f55-4e9a-dccb-d12f-c59d2cd689db@deltatee.com>
 <016dc910-f96a-8a60-4bda-fa24eea98ea5@codeaurora.org>
In-Reply-To: <016dc910-f96a-8a60-4bda-fa24eea98ea5@codeaurora.org>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.b.0.180311
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sbates@raithlin.com;
x-originating-ip: [70.65.224.121]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;YTXPR0101MB0719;7:BhKBblJMypkZAS5JQ4XLlzKxS4MumcuNlcqa8e8Vvc9kXOQXXqi0F7gI429JP8qeGExFWVA8q5iS6sOtgXuqDY0HeEVxPsbm18Pxo45ciVbQupegl4Mlkzs4x1g5/Q+0TqPZk2xvBUsNsgCjreRE/ms7xKUR1b5LrCY0xLbRTO+6GGUa3UEy9qJMrSQBArpO5hltBzueWp13kG930QOSKsn2SEJiX1OOTw8iKEfiiX8Ie7KA6brG3zPHFB0we0wk
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: e0f11e0e-0a7f-49c8-1209-08d58934263b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(3008032)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:YTXPR0101MB0719;
x-ms-traffictypediagnostic: YTXPR0101MB0719:
x-microsoft-antispam-prvs: <YTXPR0101MB07192051AFDC313BB827DE51AAD20@YTXPR0101MB0719.CANPRD01.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231221)(944501244)(52105095)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(2016111802025)(6043046)(6072148)(201708071742011);SRVR:YTXPR0101MB0719;BCL:0;PCL:0;RULEID:;SRVR:YTXPR0101MB0719;
x-forefront-prvs: 0610D16BBE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(39380400002)(39830400003)(396003)(199004)(189003)(6436002)(8676002)(110136005)(68736007)(6246003)(6486002)(54906003)(106356001)(316002)(229853002)(36756003)(58126008)(99286004)(81156014)(83716003)(25786009)(6506007)(53936002)(81166006)(3280700002)(4326008)(2201001)(66066001)(86362001)(102836004)(8936002)(186003)(76176011)(82746002)(305945005)(7736002)(3846002)(105586002)(97736004)(26005)(33656002)(2900100001)(14454004)(478600001)(2501003)(93886005)(6512007)(5250100002)(2906002)(7416002)(3660700001)(5660300001)(6116002)(2950100002);DIR:OUT;SFP:1102;SCL:1;SRVR:YTXPR0101MB0719;H:YTXPR0101MB2045.CANPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: PQW947wsKap9m+r1Yxtu0ywGzX175D5mpm95/T9wRYcM+yBgMy2ys2UvtxlQSvL8Ces2aG94mgraCc2ffZzPUu1Yb50JcyAbXGr0vQyzOQZoSp3i14BtY5Cjxm60rDOt0RsoqKfPT043AGZNWZPT4YwFrhzZqOAUArr3j0E+RVVAwx4KXRMbqBCHII2XvPoiR+fQv3qzWiZx9hQRIHUjdyzo5Z1ackj4q/3YpX1Jog8OFCPMIR6xh2Ny2fLaOKe3bVQdJQGbCjwutG8a8vq5Iu5APpYMT0E4erQ5VX3F7laHEt1NQWZc87MpHfnqLlDQmu2ngDQlRuRbAR0N417eEw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <CBB285235DCCC44AADEE04E9322EF6A5@CANPRD01.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-OriginatorOrg: raithlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0f11e0e-0a7f-49c8-1209-08d58934263b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2018 22:45:41.4409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 18519031-7ff4-4cbb-bbcb-c3252d330f4b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YTXPR0101MB0719
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2DMjrvU002370

Hi Sinan

>    If hardware doesn't support it, blacklisting should have been the right
>    path and I still think that you should remove all switch business from the code.
>    I did not hear enough justification for having a switch requirement
>    for P2P.
  
We disagree. As does the community based on feedback on previous version of this patch set.
  
> You are also saying that root ports have issues not because of functionality but
> because of performance. 

I have seen both.  Some systems fail in entirety to route TLPs across route ports. Others do route but with poor performance. Having a requirement for a switch is therefore a reasonable and sensible minimum criteria for enabling p2p.
    
> If you know what is bad, create a list and keep adding it. You can't assume
> universally that all root ports are broken/ have bad performance.

I actually wanted to do a blacklist originally but that idea was not accepted by the community. 
    
>    What if I come up with a very cheap/crappy switch (something like used in data
>    mining)?
> What guarantees that P2P will work with this device? You are making an
> assumption here that all switches have good performance.

A switch must support P2P or it is in violation of the PCIe specification.
    
>    I have been doing my best to provide feedback. It feels like you are throwing
>    them over the wall to be honest.

I think one issue Sinan is that a lot of your ideas have been discussed in previous versions of the series. So you are asking us to make changes which, in some cases, we know are not acceptable to others in the community. The input is welcome but it flies in the face of other input we have received. 

However if other developers feel strongly about the blacklist/whitelist and switch criteria please speak up! ;-)

Stephen

    
