Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754617AbeEUVmc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 17:42:32 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:10744 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754393AbeEUVmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 17:42:25 -0400
X-IronPort-AV: E=Sophos;i="5.49,427,1520870400";
   d="scan'208";a="181797259"
From: Adam Manzanares <Adam.Manzanares@wdc.com>
To: Jeff Moyer <jmoyer@redhat.com>
CC: "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>, "bcrl@kvack.org" <bcrl@kvack.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "pombredanne@nexb.com" <pombredanne@nexb.com>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "jack@suse.cz" <jack@suse.cz>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "rgoldwyn@suse.com" <rgoldwyn@suse.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-aio@kvack.org" <linux-aio@kvack.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>
Subject: Re: [PATCH v5 0/5] AIO add per-command iopriority
Thread-Topic: [PATCH v5 0/5] AIO add per-command iopriority
Thread-Index: AQHT8R0g5NEFuHrm2Ua9FGsIz2NiwKQ6qoFggAAMcAA=
Date: Mon, 21 May 2018 21:42:22 +0000
Message-ID: <9791140b-1674-0e36-cbd9-f2bf8b6b25f5@wdc.com>
References: <20180521160147.2372-1-adam.manzanares@wdc.com>
 <x49fu2kvi9q.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x49fu2kvi9q.fsf@segfault.boston.devel.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Adam.Manzanares@wdc.com;
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR04MB0170;7:bWmHzc0uYHEARs2+4ErwOqV6No4h3mN7Rf6B/VQTv0mm26IA1x5PvYxdWTG0c6hq4t+rplzwMYlkAbUYMc4Gpxt2wvRRcG4QtG1j+FPBEwAxJQd4brc4zRuXtYJ2Vs5qaNr55Q7EWbLBziAuCiaLIipsTt0ar4FuteZnwVoh8/tsHgCvnI69Qh1hcYrW1SRU+unhYQk56urfeRc7srF8bz5nfunvs9zSKm4K0EGdifW2xLBVQs6jISZP5Y7KLhbA;20:kVAmGQ6w4vrB9P0QwjKT/xEszfx3m8xxlWNEPmOxJ/JtZAedrBmyU1HKzeqRVLMbXvlI5ic6xBozX7/5FksYHqMLIa0H5rpZM4KgcHhS0w/5JxBILlLfolkr9aoBpxBk9Jxp2m4TYDSLUel2m0wkhCKd4vdWGj9vP022asv16MA=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR04MB0170;
x-ms-traffictypediagnostic: DM5PR04MB0170:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <DM5PR04MB01704DEE85614333666BB54EF0950@DM5PR04MB0170.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DM5PR04MB0170;BCL:0;PCL:0;RULEID:;SRVR:DM5PR04MB0170;
x-forefront-prvs: 06793E740F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(366004)(346002)(39860400002)(376002)(199004)(189003)(229853002)(305945005)(81156014)(2900100001)(81166006)(6246003)(54906003)(5660300001)(105586002)(2906002)(66066001)(59450400001)(6512007)(316002)(6436002)(72206003)(6306002)(966005)(8676002)(36756003)(26005)(53936002)(7416002)(6486002)(6916009)(76176011)(102836004)(8936002)(186003)(3846002)(106356001)(6116002)(3660700001)(6506007)(31686004)(53546011)(3280700002)(25786009)(7736002)(476003)(14454004)(478600001)(99286004)(5250100002)(4326008)(68736007)(31696002)(446003)(486006)(11346002)(86362001)(97736004)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR04MB0170;H:DM5PR04MB0282.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: B+0wV4lbSgOKDymUEnOWniH4lUgjQvfPduuDWii5GXRgv9HMKRIMIRr5FWvWVFKyN4Gba2XsLhn78l6vXGOiOwmd3HkEccQze98RRvVpwLVNW/CQWlWgMv2rn/oOkrVFkhsc5BWl+/52ZCbWwU6AUxDcePoT2OaJpEpoto7u9FDK9dEfmZOyZeK9CpitTkD4
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <43084E3A8FBF734AA54DCA567ADE63B2@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 763348e1-89e2-4cd5-4dc9-08d5bf63bc35
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 763348e1-89e2-4cd5-4dc9-08d5bf63bc35
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2018 21:42:22.2445
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0170
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4LLgcUo007399



On 5/21/18 1:57 PM, Jeff Moyer wrote:
> Hi, Adam,
> 
> adam.manzanares@wdc.com writes:
> 
>> From: Adam Manzanares <adam.manzanares@wdc.com>
>>
>> This is the per-I/O equivalent of the ioprio_set system call.
>> See the following link for performance implications on a SATA HDD:
>> https://lkml.org/lkml/2016/12/6/495
>>
>> First patch factors ioprio_check_cap function out of ioprio_set system call to
>> also be used by the aio ioprio interface.
>>
>> Second patch converts kiocb ki_hint field to a u16 to avoid kiocb bloat.
>>
>> Third patch passes ioprio hint from aio iocb to kiocb and inititalizes kiocb
>> ioprio value appropriately when it is not explicitly set.
>>
>> Fourth patch enables the feature for blkdev.
>>
>> Fifth patch enables the feature for iomap direct IO
>>
>> Note: this work is based on top of linux-vfs/for-next
> 
> I'll cook up a libaio test case.  Can you put together a man-pages
> update for this?

Hello Jeff,

I'll send out a man-pages update soon.

Thanks,
Adam

> 
> Thanks!
> Jeff
> 
