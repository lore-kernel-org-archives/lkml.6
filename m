Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753915AbeC1PFu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 11:05:50 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:28059 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753895AbeC1PFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 11:05:47 -0400
X-IronPort-AV: E=Sophos;i="5.48,372,1517846400";
   d="scan'208";a="177761719"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>
CC: "daniel@bristot.me" <daniel@bristot.me>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "acme@kernel.org" <acme@kernel.org>,
        "nab@linux-iscsi.org" <nab@linux-iscsi.org>,
        "williams@redhat.com" <williams@redhat.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "lclaudio@redhat.com" <lclaudio@redhat.com>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH 1/2] target: drop spin_lock_assert() + irqs_disabled()
 combo checks
Thread-Topic: [PATCH 1/2] target: drop spin_lock_assert() + irqs_disabled()
 combo checks
Thread-Index: AQHTwsrsqCEWewSC6ECDLarfjY9t96PipIuAgALRYQCAAFD2AA==
Date: Wed, 28 Mar 2018 15:05:41 +0000
Message-ID: <c9f5df1e54bb2bd8f3f0aef86a55deb11888a6a4.camel@wdc.com>
References: <20180321153854.GB24312@kernel.org>
         <CA+55aFwKN_JijmCt=0S4jF8KzGPmoKNbuYF59va7U4ziJLLryA@mail.gmail.com>
         <20180322093745.GC4229@kernel.org>
         <20180323155513.dwbgvblenlji33as@linutronix.de>
         <1521822325.2535.5.camel@wdc.com>
         <CA+55aFxVkuntSektVmwXktzvfEezdDTAM_zj4DJdp3qJxWf8aA@mail.gmail.com>
         <20180323171736.bcyi2oiolge4l6hl@linutronix.de>
         <20180326111359.180f1604@gandalf.local.home>
         <20180328101553.uduqsdbxwnxrhl7a@linutronix.de>
In-Reply-To: <20180328101553.uduqsdbxwnxrhl7a@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [199.255.44.172]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB1054;7:mUK591i6JkOwE2CRhMrp1rlS4e37tFn48uX783DbalXVXfvlsp3PyHSacIcv7ioYSWQqi/vFoBphEro7QS3tMey+NNIEbf4Abltr6NZyy0zLuKTX7RnAuuKoKurkYLGZyYrDAMSCRNpt4l23O9zHc/HG1xnFPO/vslVZ4E7vQm/itK/i/cZB9l0+glEsEsTBjzbscnemPaIfZxoVoEdpNSRsCWf25baIJd1B5DAmHvUjT7uPQYttb/UawnODM1z9;20:pBB79R5qbl0GqYFRxtzAA1XuHCujv4ANWi83IXlmngsnwD/aVIGyr7CJleE1nPvrm/z15/iUmHJeZax8gZKZYWFaOSDBkXphyXu8exvRWSzWzlETt21jwB1t5h1Hgnjsv+RAUso8e6Deg1gy8EfveUJ/5Nys367C73zfNEaMGEI=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e4a23b84-61e0-4579-5ed4-08d594bd5fb8
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB1054;
x-ms-traffictypediagnostic: MWHPR04MB1054:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB10543948C43EB98991036FDA98A30@MWHPR04MB1054.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501327)(52105095)(6055026)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:MWHPR04MB1054;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB1054;
x-forefront-prvs: 06259BA5A2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39380400002)(366004)(39860400002)(346002)(199004)(189003)(377424004)(478600001)(7736002)(305945005)(2900100001)(14454004)(105586002)(25786009)(72206003)(186003)(26005)(118296001)(36756003)(66066001)(102836004)(4326008)(6436002)(2501003)(99286004)(5250100002)(6486002)(6246003)(53936002)(6116002)(6512007)(3846002)(86362001)(3280700002)(2906002)(3660700001)(7416002)(97736004)(53546011)(229853002)(486005)(8676002)(81166006)(81156014)(486005)(8936002)(93886005)(446003)(6506007)(11346002)(316002)(76176011)(68736007)(59450400001)(54906003)(476003)(110136005)(106356001)(5660300001)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB1054;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 0Bze6ShtxHA4bDjR638pD2bYl2Trarve2y4O22MQ2d0ltnpZ7+0fyecWmobUFF2pRz5fRaGj8+/+lO6efNMf1CEIqcgeQg7cjVYGnMcjICrKzpb854geOVQyku5MYkkJEYvgvBG104BfdG3FtWA7lB5F728sJt2Dg/vmZySvwtetjYilBrU6g7Spk7fqiV9nN6iy1DMxEY8guchVcTh0QMv46uWdCh5lEzGyYSBgOjoJAHBIKHrXyqnoUC4MlU6GncwAQzQlwwiCGmlrlYxNyq4XW/doyZpGOCCGqW5sW/BLRGXKoZhK8g6kgboVSNoc2zb7GtV+KQb0FZEoVOvi2w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <3E7B0C089BD03A478E5E51BA9B5236BE@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4a23b84-61e0-4579-5ed4-08d594bd5fb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2018 15:05:41.6253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB1054
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2SF5v99025303

On Wed, 2018-03-28 at 12:15 +0200, bigeasy@linutronix.de wrote:
> On 2018-03-26 11:13:59 [-0400], Steven Rostedt wrote:
> > > diff --git a/drivers/target/target_core_tmr.c b/drivers/target/target_core_tmr.c
> > > index 9c7bc1ca341a..3d35dad1de2c 100644
> > > --- a/drivers/target/target_core_tmr.c
> > > +++ b/drivers/target/target_core_tmr.c
> > 
> > Can you add a comment above the functions though?
> > 
> > /* Expects to have se_cmd->se_sess->sess_cmd_lock held */
> 
> I could. I haven't heard from Bart / Nicholas about their opinion. I
> know, we do this other places but Bart was against this kind of
> annotation in 2/2 of this thread.
> So I am waiting to hear from them :)

The names of the two functions touched by patch 1/2 start with a double
underscore. That by itself is already a hint that these should be called with
a lock held (I know that this is not a universal convention in the Linux
kernel). I'm fine either way - either with patch 1/2 as posted or patch 1/2
with the above comment added.

Bart.
