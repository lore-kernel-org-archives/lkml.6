Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933185AbeCBUvt (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 15:51:49 -0500
Received: from mail-eopbgr660135.outbound.protection.outlook.com ([40.107.66.135]:39520
        "EHLO CAN01-QB1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933051AbeCBUvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 15:51:46 -0500
From: "Stephen  Bates" <sbates@raithlin.com>
To: Christoph Hellwig <hch@infradead.org>
CC: Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@kernel.dk>,
        "Alex Williamson" <alex.williamson@redhat.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Steve Wise <swise@opengridcomputing.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?utf-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Max Gurtovoy <maxg@mellanox.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 10/10] nvmet: Optionally use PCI P2P memory
Thread-Topic: [PATCH v2 10/10] nvmet: Optionally use PCI P2P memory
Thread-Index: AQHTsO2FaiSytyZxbkuik0deJPQRE6O7N/eAgABu34CAAA+TgIAAAe2AgAAMXICAADd+AP//juQAgACC8gD//4uzgIABgZoA///eAgA=
Date: Fri, 2 Mar 2018 20:51:42 +0000
Message-ID: <F7179402-E931-45DB-903E-5D92608A464E@raithlin.com>
References: <20180228234006.21093-11-logang@deltatee.com>
 <749e3752-4349-0bdf-5243-3d510c2b26db@grimberg.me>
 <40d69074-31a8-d06a-ade9-90de7712c553@deltatee.com>
 <5649098f-b775-815b-8b9a-f34628873ff4@grimberg.me>
 <20180301184249.GI19007@ziepe.ca>
 <edaf476a-cfe9-0598-1aa5-14802a9a1477@deltatee.com>
 <20180301224540.GL19007@ziepe.ca>
 <77591162-4CCD-446E-A27C-1CDB4996ACB7@raithlin.com>
 <20180301234930.GG14799@localhost.localdomain>
 <6B6A0FD9-14F5-4AF2-A74A-DAA562C34AB9@raithlin.com>
 <20180302155322.GA5934@infradead.org>
In-Reply-To: <20180302155322.GA5934@infradead.org>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.a.0.180210
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sbates@raithlin.com;
x-originating-ip: [70.65.224.121]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;YTXPR0101MB1872;6:90mZ+j/2J4zskfsS7wQ9xIxzbxHERbosn26l0bxx/fiPlctZ6oK5dAqEnJzH1rR+9IlqViUYU/TvALHnUdksyzaPyW7pnJHiD9gyd3Zybbz+JSCm24cwGKiyChCzNkpT+3iMdT+94+Cfa0KjvD67sbdcze+FEVyDjmDexkDQM2EjG79J90KZvNjGXJi8yqhNMDV6KtAuSni9iOIx2LS6p1xE/jULOLDfmHSC8tAz1iOVzZNq/PteGDE1PmV5VXxKMQTj2PMma48rYfcvYioC4XYt4Vkz+ad5z98DVakCCiGF0sUlkEs3jomi8ROcHMdILxXhZ9k2Ogo42o02i6n0Ad1HnQqCkibMxhUdClxlqoEvNaeB1jHJWPhCWm/CYrXz;5:sYinrYrLn04QC+Kzyg+KT8ZOCQr6mRjPIIv1cXxrY55J77Atxv3SHDGBjDhyPdu2JE7Po1uq6IYN7M0cffwUJQRNW7mhvhOFX/ijbI415ZJFYREBsoWurYy0Hh2lJeoRkyiaNJnVWDXiPIZQPEkCG5nMjMoxBl9/seNfDA3eQE0=;24:Z0lGeu/8czYB5eE6v1h5ZS2/bvyZhJSrEzNA7gBi1LxdPJ1glVfVItvJDSGFj2UImXltBU/AyKRVa/BmTEzVdowLky2SwcmG+rFDFLJZV0E=;7:G8Qse5B/wxMB26KmlFq59++bvsoaZN3vyroXwU/oLtwzyfY2HcuHk4W3oKvm121G/SLYkymo5ddQgBfowPJlYdbxJT2y8PlMtzAkdDKpIS0aBiT5EPZJC+tOiF7dl775BT7IWKZjYZboapExOnScfuNHbKQKsZUEIHm0LEFCBV/MW1OWSKfxz6J/X19ixydjlbYoT9Ge/XfQRvYO0FXTpnONFml1yOrUB3M09jRouBfUypeQD/Q7zXXmOg3MdWb7
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: 891868b5-17e0-46ab-42ab-08d5807f679b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:YTXPR0101MB1872;
x-ms-traffictypediagnostic: YTXPR0101MB1872:
x-microsoft-antispam-prvs: <YTXPR0101MB18727F8AB7D4C593E9313A09AAC50@YTXPR0101MB1872.CANPRD01.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231220)(944501243)(52105095)(10201501046)(6041288)(20161123562045)(20161123558120)(20161123560045)(2016111802025)(20161123564045)(6043046)(6072148)(201708071742011);SRVR:YTXPR0101MB1872;BCL:0;PCL:0;RULEID:;SRVR:YTXPR0101MB1872;
x-forefront-prvs: 05991796DF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(39830400003)(366004)(396003)(346002)(189003)(199004)(51914003)(82746002)(6306002)(3660700001)(54906003)(3280700002)(6116002)(7736002)(305945005)(8558605004)(58126008)(6512007)(6506007)(102836004)(26005)(68736007)(14454004)(2906002)(93886005)(3846002)(2950100002)(4326008)(229853002)(5660300001)(8936002)(6246003)(97736004)(8676002)(105586002)(6916009)(106356001)(81156014)(81166006)(99286004)(316002)(33656002)(66066001)(5250100002)(53936002)(76176011)(86362001)(53376002)(186003)(25786009)(7416002)(966005)(6436002)(2900100001)(36756003)(6486002)(83716003)(478600001)(15398625002)(19623455009);DIR:OUT;SFP:1102;SCL:1;SRVR:YTXPR0101MB1872;H:YTXPR0101MB2045.CANPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: mcO6ExD6MlZeTbt57mWHFwwF9HT6QJei5mIWtutqOA+YjxI76gk09SnwlNFnA1VmcwqtDlKMkPxgwG8jACFr3i0W4X2wRR6PRX4GHbL5moR3/qI2WlFocBOULdhl+q0TBBjZIuXpV2YTPDKF7LR1PsQzyoQDpv8CZuempgxWGYI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <8E49611D39222C488A2D4E7EA032409A@CANPRD01.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-OriginatorOrg: raithlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 891868b5-17e0-46ab-42ab-08d5807f679b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2018 20:51:42.9442
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 18519031-7ff4-4cbb-bbcb-c3252d330f4b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YTXPR0101MB1872
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w22Ksw1M016415

>    http://nvmexpress.org/wp-content/uploads/NVM-Express-1.3-Ratified-TPs.zip

@Keith - my apologies.

@Christoph - thanks for the link

So my understanding of when the technical content surrounding new NVMe Technical Proposals (TPs) was wrong. I though the TP content could only be discussed once disclosed in the public standard. I have now learnt that once the TPs are ratified they are publically available!

However, as Logan pointed out, PMRs are not relevant to this series so let's defer discussion on how to support them to a later date!

Stephen
    
