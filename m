Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965157AbeEIPlu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 11:41:50 -0400
Received: from mail-eopbgr660097.outbound.protection.outlook.com ([40.107.66.97]:15543
        "EHLO CAN01-QB1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935397AbeEIPlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 11:41:47 -0400
From: "Stephen  Bates" <sbates@raithlin.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>,
        "Jerome Glisse" <jglisse@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>
CC: Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
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
Thread-Index: AQHT21soiBVnp6SJuEuLCiH6kBzTLKQk+zIAgACHcYCAAJmxAIAABkiAgAAoBgCAAAW2gIAAA0YAgAAHvYCAAAGOgIAACKoAgACuAYCAAGxLgP//vUwA
Date: Wed, 9 May 2018 15:41:44 +0000
Message-ID: <1775CC56-4651-422F-953A-18E024D3717C@raithlin.com>
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
 <7FFB9603-DF9F-4441-82E9-46037CB6C0DE@raithlin.com>
 <a1a36f88-fbfb-b5ee-6dcb-5c5bb96132dd@amd.com>
In-Reply-To: <a1a36f88-fbfb-b5ee-6dcb-5c5bb96132dd@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.d.0.180505
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sbates@raithlin.com;
x-originating-ip: [70.65.250.31]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;YTOPR0101MB1964;7:no9J8QesCWwfsX6xY3a5C5mq/FoXxngR8DoaQSl7JyhoiSswRYTAbr0IbJsXlo3rSKfC2zmAItdv/BBFztyCMuWHDxF+ez1rj1nVWGUvDwAeU94yJezze/R4gvPrc+pn1DTKf90kL+2aYNOTIAbNdHVl5IElk+w4s/ES3wbiVXDrt55jB/uNy4LBhHoHvvlcpAZXAFeuwDSo40/FaL7CeTOfRus8SxZvbP5MX3sWF3zkRXN4KqXco3pnh7y3h/O4
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(2017052603328)(7153060)(7193020);SRVR:YTOPR0101MB1964;
x-ms-traffictypediagnostic: YTOPR0101MB1964:
x-microsoft-antispam-prvs: <YTOPR0101MB1964A2451E64E166DDF3B2A7AA990@YTOPR0101MB1964.CANPRD01.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(2016111802025)(6072148)(6043046)(201708071742011);SRVR:YTOPR0101MB1964;BCL:0;PCL:0;RULEID:;SRVR:YTOPR0101MB1964;
x-forefront-prvs: 0667289FF8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39830400003)(366004)(39380400002)(396003)(199004)(189003)(4326008)(81156014)(81166006)(7416002)(8936002)(5660300001)(6506007)(3846002)(305945005)(6246003)(8676002)(7736002)(66066001)(486006)(186003)(25786009)(110136005)(36756003)(97736004)(83716003)(99286004)(6512007)(53936002)(82746002)(5250100002)(33656002)(86362001)(6486002)(476003)(11346002)(2906002)(446003)(316002)(76176011)(93886005)(6436002)(2900100001)(26005)(3660700001)(59450400001)(229853002)(58126008)(102836004)(54906003)(6116002)(14454004)(105586002)(8666007)(3280700002)(478600001)(2616005)(68736007)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:YTOPR0101MB1964;H:YTOPR0101MB2043.CANPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: Z5yIwRvSTOtsUObDtnGA+PvTLY4U6XYy7EfsQGp5rhys/vv1HOapGAkjV4v8cBfpQXd16HJyydCT4rHLoREPGbOaPY5RMp41KjyLVy1Db41NjXDcld3yhQLoWp7Vu27rvq18yrtRZa/QsvruPP5Q8xTReVDSLAfdvQQYWJTdkp9GaK4ZTrPwXb/bMZcJw7Ac
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <215EC96ED56B2D49A092AB3D81AEB91E@CANPRD01.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: fbdb0ec1-a6e2-4f22-c389-08d5b5c35e7a
X-OriginatorOrg: raithlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbdb0ec1-a6e2-4f22-c389-08d5b5c35e7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2018 15:41:45.0209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 18519031-7ff4-4cbb-bbcb-c3252d330f4b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YTOPR0101MB1964
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w49FftPZ016094

Christian

>    Interesting point, give me a moment to check that. That finally makes 
>    all the hardware I have standing around here valuable :)
    
Yes. At the very least it provides an initial standards based path for P2P DMAs across RPs which is something we have discussed on this list in the past as being desirable.

BTW I am trying to understand how an ATS capable EP function determines when to perform an ATS Translation Request (ATS TR). Is there an upstream example of the driver for your APU that uses ATS? If so, can you provide a pointer to it. Do you provide some type of entry in the submission queues for commands going to the APU to indicate if the address associated with a specific command should be translated using ATS or not? Or do you simply enable ATS and then all addresses passed to your APU that miss the local cache result in a ATS TR?

Your feedback would be useful and I initiate discussions within the NVMe community on where we might go with ATS...

Thanks

Stephen
