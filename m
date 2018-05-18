Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752106AbeERQaF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 12:30:05 -0400
Received: from mail-sn1nam02on0048.outbound.protection.outlook.com ([104.47.36.48]:18737
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751450AbeERQaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 12:30:03 -0400
From: Nadav Amit <namit@vmware.com>
To: Borislav Petkov <bp@alien8.de>
CC: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Denys Vlasenko <dvlasenk@redhat.com>
Subject: Re: [PATCH 2/6] x86: bug: prevent gcc distortions
Thread-Topic: [PATCH 2/6] x86: bug: prevent gcc distortions
Thread-Index: AQHT7jbL50o+w3m6PkeKHm2HX6GyP6Q1H7KAgAAEMwCAACDIAIAAShCAgAASAACAAAGeAIAAAhWAgAAKDYA=
Date: Fri, 18 May 2018 16:29:59 +0000
Message-ID: <2176DA84-C064-487F-A062-03A95884F15E@vmware.com>
References: <20180517161402.78089-1-namit@vmware.com>
 <20180517161402.78089-3-namit@vmware.com>
 <20180518075853.GD12217@hirez.programming.kicks-ass.net>
 <20180518081354.GA11379@gmail.com> <20180518101114.GB17285@pd.tnic>
 <A0A24A0C-7ED5-40DA-A017-7FE292F57939@vmware.com>
 <20180518154044.GE17285@pd.tnic>
 <30EDFE9B-CA25-42EE-A57F-E3054B84223E@vmware.com>
 <20180518155359.GF17285@pd.tnic>
In-Reply-To: <20180518155359.GF17285@pd.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [208.91.2.2]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN2PR05MB2445;7:gGV9At6fR/UeBlP8Vqmok0ksc1wRoKeniOTuBWf7zUPKXwD49H2HL0Dy4Ted435OvZQ0n7MUpSMcOgLBz29FtMEuW+OYOOkQmgii9PzVgyBh/cDiDdGXMB5m3tg1TSuiWqZlnfEUwfM0LN6iVE4K9OFI+S6YviZxq/DT43GFQYv9LzYMoxBVUoeVQ8NTh3l9OvMXp2mcJcON+Qi6mOPs/V0pNMHu2u4N43ZZuUpCWhPvZQtbN1RpSgqCD/+UR6Ni;20:YMnrwoQtO1GZptyHaG4z08dWFM7+8UpEuzapdimdmsVHhFNGNQYqeIQNvNKyf3epD0BreRAcbcSekqz/hN+4YhwO7xiif0Hb9oU8nDLwbsVGhcyvAGHBxzo6sWdHGgI3sSyZIdQLWQW3+FBGiyhDbQeFgXiC5udkT2xnlXiY37s=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN2PR05MB2445;
x-ms-traffictypediagnostic: SN2PR05MB2445:
x-microsoft-antispam-prvs: <SN2PR05MB244547F2A90511F767011F22D0900@SN2PR05MB2445.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SN2PR05MB2445;BCL:0;PCL:0;RULEID:;SRVR:SN2PR05MB2445;
x-forefront-prvs: 0676F530A9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39860400002)(39380400002)(346002)(376002)(199004)(189003)(102836004)(26005)(6506007)(14454004)(3280700002)(6346003)(7736002)(2900100001)(25786009)(82746002)(3660700001)(478600001)(33656002)(105586002)(5250100002)(5660300001)(229853002)(8676002)(81156014)(81166006)(6512007)(186003)(7416002)(2906002)(305945005)(6436002)(36756003)(76176011)(6486002)(8936002)(6246003)(53936002)(6116002)(83716003)(4326008)(6916009)(476003)(93886005)(316002)(11346002)(2616005)(3846002)(68736007)(66066001)(99286004)(446003)(106356001)(86362001)(486006)(97736004)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN2PR05MB2445;H:SN2PR05MB2654.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com;
x-microsoft-antispam-message-info: uD3u9gzsLMFuISR/4bMpx/7RFqFfFctqFr5kNIFKQdW7zmMPTPhZ84+ssHQERS7PZ+SskkCXdHYPhFCgjBadjy8i/8GQWavPp1VvX5DvnsC86SH4eLahBHhTp2/uZuEAW4MUEE5oKntAibt8AbtL1PJ2BQhsnzpTCWu4GK2ondz5Wo3H3wpiDYleAXuP0vv4
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <BC2E078E1078C14BBC7A4FAB09D0A546@namprd05.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 21d97d0a-8525-47af-2722-08d5bcdc9984
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21d97d0a-8525-47af-2722-08d5bcdc9984
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2018 16:29:59.5319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR05MB2445
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4IGUBsh001027

Borislav Petkov <bp@alien8.de> wrote:

> On Fri, May 18, 2018 at 03:46:33PM +0000, Nadav Amit wrote:
>> In case you didn’t read the cover-letter: the patch-set does give a 2%
>> performance improvement for #PF-MADV_DONTNEED microbenchmark loop.
> 
> I saw it but *micro*-benchmark doesn't tell me a whole lot. If that
> "improvement" is not visible in real workloads/benchmarks, then I'm just
> as unimpressed.

Funny. I found in my mailbox that you once wrote me: "It is a dumb idea, it
doesn't bring us anything besides some superficial readability which you
don't really need.”

To the point, I think you exaggerate with the effect of the patch on the
code readability: it is not much uglier than it was before, and the change
is in a very specific point in the code.
