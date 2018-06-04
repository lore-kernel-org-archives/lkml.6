Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753283AbeFDHCd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 03:02:33 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:31331 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753234AbeFDHCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 03:02:25 -0400
X-IronPort-AV: E=Sophos;i="5.49,475,1520870400";
   d="scan'208";a="80561949"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "bigeasy@linutronix.de" <bigeasy@linutronix.de>
CC: "daniel@bristot.me" <daniel@bristot.me>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "nab@linux-iscsi.org" <nab@linux-iscsi.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "acme@kernel.org" <acme@kernel.org>,
        "williams@redhat.com" <williams@redhat.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "lclaudio@redhat.com" <lclaudio@redhat.com>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH 1/2] target: drop spin_lock_assert() + irqs_disabled()
 combo checks
Thread-Topic: [PATCH 1/2] target: drop spin_lock_assert() + irqs_disabled()
 combo checks
Thread-Index: AQHTwsrsqCEWewSC6ECDLarfjY9t96PipIuAgALRYQCAAFD2AIAAAnuAgAAExgCAX855AIAKgboA
Date: Mon, 4 Jun 2018 07:02:15 +0000
Message-ID: <92633c987a900acf5e7defb481d347a9e5b1253d.camel@wdc.com>
References: <20180322093745.GC4229@kernel.org>
         <20180323155513.dwbgvblenlji33as@linutronix.de>
         <1521822325.2535.5.camel@wdc.com>
         <CA+55aFxVkuntSektVmwXktzvfEezdDTAM_zj4DJdp3qJxWf8aA@mail.gmail.com>
         <20180323171736.bcyi2oiolge4l6hl@linutronix.de>
         <20180326111359.180f1604@gandalf.local.home>
         <20180328101553.uduqsdbxwnxrhl7a@linutronix.de>
         <c9f5df1e54bb2bd8f3f0aef86a55deb11888a6a4.camel@wdc.com>
         <20180328151433.elhw6kgxdxq6fn6b@linutronix.de>
         <86c1243e-8733-c94d-d8ff-5c299b8266a6@wdc.com>
         <20180528143518.f46hyhi5r5jd3oxe@linutronix.de>
In-Reply-To: <20180528143518.f46hyhi5r5jd3oxe@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [178.117.55.239]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0223;7:KNZQeFtYlJJwvSXcc+5mnZ5hKFd7T5Rww9ZRWYp5WrNaHcGI2FWby6ZNxNXFJOPusGoJym5XGHDidaaXg8cqxE/snTWP5Z0YCUPPSax9d2JcaINO/t1fYoT0l7f8EwqciofIvAx4N5ad3WdIs5tAKgo+lgZxN8XZv9swynWMXCg1tE9qXrQKbCDJlvJXdxA3MmsTlJy6donLRAgbSo73UHs2U5sgcko0RPnrdvAzYOY1B/8wEV5MJziSw3bijfcx;20:OuBuX1FaTlBSl/x2pLGYfRCbVCrG+MuVCGEWKszB5j/9HCSbt5Psdrp8m8gkq1Ee/6cewZLbJr9aPIkmRYT5owjYwb/sro4gUGo9W4gW9Zf81JHtc433DXHND/k/sy7DveecIv2+qakMzDD6Yoit5arHIJVaEqlLfDl0L56WlZM=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0223;
x-ms-traffictypediagnostic: MWHPR04MB0223:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB02232987B8B2D1E7CA93D46198670@MWHPR04MB0223.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB0223;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0223;
x-forefront-prvs: 069373DFB6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(366004)(376002)(396003)(346002)(199004)(189003)(93886005)(6512007)(5640700003)(316002)(6436002)(66066001)(486006)(6486002)(53936002)(25786009)(5660300001)(36756003)(7416002)(2900100001)(106356001)(1730700003)(2501003)(5250100002)(229853002)(97736004)(8676002)(54906003)(81156014)(81166006)(305945005)(118296001)(186003)(3280700002)(3660700001)(7736002)(86362001)(26005)(8936002)(6506007)(102836004)(4326008)(6916009)(53546011)(76176011)(99286004)(59450400001)(446003)(72206003)(2616005)(105586002)(476003)(11346002)(3846002)(2906002)(2351001)(6246003)(68736007)(478600001)(14454004)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0223;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 2ZpcQY0gfxr0MmDcJmWPkvDY9ePLKlHW+MPmUHRsQm1z/gZfVfqx4fler/BK6H7DpshzZT6RkJGIgZ+n4eiKJ5l9//y2cEy3MXqDLZQ3MxmvhLGHnNVfJJUAVSG4Agg9Pb2ypeXHisvbQdDn0FGQrApytGqDq8F6jiYLMK1L03JZgTbi62Flh9NNantL4uHP
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <2B0C44F68D3CC04DBEBD1BC21910647A@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 24fe6079-27b0-4248-d834-08d5c9e91a88
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24fe6079-27b0-4248-d834-08d5c9e91a88
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2018 07:02:15.0969
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w5472mJk023760

On Mon, 2018-05-28 at 16:35 +0200, bigeasy@linutronix.de wrote:
> On 2018-03-28 08:31:38 [-0700], Bart Van Assche wrote:
> > On 03/28/18 08:14, bigeasy@linutronix.de wrote:
> > > On 2018-03-28 15:05:41 [+0000], Bart Van Assche wrote:
> > > > The names of the two functions touched by patch 1/2 start with a double
> > > > underscore. That by itself is already a hint that these should be called with
> > > > a lock held (I know that this is not a universal convention in the Linux
> > > > kernel). I'm fine either way - either with patch 1/2 as posted or patch 1/2
> > > > with the above comment added.
> > > 
> > > Okay. In that case let me update 1/2.
> > > But 2/2 with the comment as Steven suggested is still a no no for you?
> > 
> > Although I'm not enthusiast about patch 2/2, if others agree with that patch
> > I'm fine with that patch being sent upstream.
> 
> I've been waiting for something to happen but nobody replied.
> Bart, you were fine with 1/2 as posted but not too happy about 2/2.
> Assuming we keep 1/2 as is and I remove just the
> "WARN_ON_ONCE(!irqs_disabled());" from 2/2 (keeping the
> assert_spin_locked()), would that improve your mood? Lockdep would still
> perform full validation, yell if __transport_check_aborted_status() was
> invoked without locking and also yell abut missing IRQ-save at locking
> time of ->t_state_lock).

Would adding WARN_ON_ONCE(!irqs_disabled()) work fine with an RT kernel?

Thanks,

Bart.
