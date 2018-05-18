Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751888AbeEROg0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 10:36:26 -0400
Received: from mail-by2nam01on0086.outbound.protection.outlook.com ([104.47.34.86]:56688
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750957AbeEROgY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 10:36:24 -0400
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
Thread-Index: AQHT7jbL50o+w3m6PkeKHm2HX6GyP6Q1H7KAgAAEMwCAACDIAIAAShCA
Date: Fri, 18 May 2018 14:36:21 +0000
Message-ID: <A0A24A0C-7ED5-40DA-A017-7FE292F57939@vmware.com>
References: <20180517161402.78089-1-namit@vmware.com>
 <20180517161402.78089-3-namit@vmware.com>
 <20180518075853.GD12217@hirez.programming.kicks-ass.net>
 <20180518081354.GA11379@gmail.com> <20180518101114.GB17285@pd.tnic>
In-Reply-To: <20180518101114.GB17285@pd.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [208.91.2.2]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN2PR05MB2768;7:EeNHce8leZeAztEyx7KnKAdZlcCB0jsFQglHC/AUHr0cqthhXOX9mUXXVIqO0T+n6cb+s2A+QeDy3EM9Iqium6vQo2WFF4hIeq2D9OvEM12I18DJaIY6/GB1Huh7tXn5jfq/JqRrR/V73oueq8rUygio1AXCcAyGE17xn6K9RAW5BNPyZ3cZ0xDN648pPUzOP+8u+Rso851+J8QYxvx3HdJS5tIG+EO538p74ouEXvfe/Z1PFpWvmyUSX5mOsvAM;20:DYyMlYQ/YsuM0D9EECkfHoRe5FHVFpm0W86NtdlZ8IPVXYNeJrAQA439lmO4yQXbaGlfhpEYSmmFPomPIqO5kleDEir1Q3tTFfIwB4sO5O4pwv/0KQWiGiZGD4WPvu+j9aR4HCs9pv0dqYkyX5kWc0+j05MP2zUEB7qa9ZLwht4=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN2PR05MB2768;
x-ms-traffictypediagnostic: SN2PR05MB2768:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com;
x-microsoft-antispam-prvs: <SN2PR05MB27680E091D7B04627E30774ED0900@SN2PR05MB2768.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SN2PR05MB2768;BCL:0;PCL:0;RULEID:;SRVR:SN2PR05MB2768;
x-forefront-prvs: 0676F530A9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(396003)(39380400002)(376002)(366004)(199004)(189003)(6506007)(82746002)(446003)(186003)(86362001)(59450400001)(26005)(106356001)(476003)(2616005)(97736004)(66066001)(6436002)(53936002)(76176011)(54906003)(6512007)(36756003)(83716003)(102836004)(14454004)(486006)(11346002)(6246003)(105586002)(3660700001)(25786009)(8676002)(4326008)(5660300001)(3280700002)(6916009)(99286004)(2906002)(2900100001)(3846002)(68736007)(478600001)(6116002)(316002)(93886005)(305945005)(7736002)(8936002)(7416002)(33656002)(6486002)(229853002)(81156014)(81166006)(5250100002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN2PR05MB2768;H:SN2PR05MB2654.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: v052rasSjD9z6+El83a8++vSXp8btiv1hLjbFJZDxByOgre7nWZRdfRDa05DcKu3Dw3D6gfo1wXDp3rel9k4edZa+F3vtgqEbS6XI1QL3xpvUTUW+T/NnbrB7QkTYBouWTg0VBGw8yw0UKTHeXAF2k4IJp/QKc3rtnGIKfAKNhH40SVYQNvVgKHjEHKPegUH
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <2EE64001B38820438DDF562ABAE60E06@namprd05.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 70b7ad33-870c-4a32-fb95-08d5bcccb9a9
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70b7ad33-870c-4a32-fb95-08d5bcccb9a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2018 14:36:21.5662
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR05MB2768
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4IEaVRc025791

Borislav Petkov <bp@alien8.de> wrote:

> On Fri, May 18, 2018 at 10:13:54AM +0200, Ingo Molnar wrote:
>> Yes, that's my main worry too about all these inlining changes:
>> the very, very marked reduction in the readability of assembly code.
> 
> Same reaction here: the small improvements this brings is simply not
> enough to sacrifice readability so much IMO.

I didn’t try too hard to find more affected (micro)benchmarks, but I am
pretty sure there are: pretty much all the paravirt ops are currently not
inlined, which can affect kernel operations that bang on the page-tables.

Notice that this is not an x86-specific issue. Other architectures, with
not-as-good OOOE for instance, might incur higher overheads. So I don’t
think that this issue should be ignored.
