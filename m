Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756009AbeEAQjM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 12:39:12 -0400
Received: from mail-sn1nam02on0074.outbound.protection.outlook.com ([104.47.36.74]:28197
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755849AbeEAQjL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 12:39:11 -0400
From: Nadav Amit <namit@vmware.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
CC: Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Suboptimal inline heuristics due to non-code sections
Thread-Topic: Suboptimal inline heuristics due to non-code sections
Thread-Index: AQHT4RiofuDjvDQvpEaROOrOTLYHiaQa4bMAgAAgoACAABFUgA==
Date: Tue, 1 May 2018 16:39:09 +0000
Message-ID: <042668BD-8912-44D4-9CA1-9ABA2F094709@vmware.com>
References: <A74E4351-A9FA-434D-AD47-3A509F802FFB@vmware.com>
 <20180501134020.fonel3x6plea5xdt@treble>
 <CA+55aFz-11bMkZHWdiiwys32H5jvB4gATvUHT0Vx6pJkFYLb4w@mail.gmail.com>
In-Reply-To: <CA+55aFz-11bMkZHWdiiwys32H5jvB4gATvUHT0Vx6pJkFYLb4w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [208.91.2.2]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN2PR05MB2718;7:cSY8MO7VCdv3hkAXC6yHQrJKyKK5++2LdecUl6F7mTx1ECqfMzUAUYv1P+DRcPhxBAOLWHa4XXNlYobFgtB+AaGWt0j/GywXENShf0Hn6g2YLdYhcNHkWvzU88UA1jTrltPyD+3fYqph48wOKiT5KR3p2QdA8Jz6pnNYXZZ4bUIrQSOxDs1FhtIAtSrG+uvdtNCJPnvU6/BARIfSSlP0WcxRAg2IFd4rN5JWreGcgaege1QD4cci5573qv6obZtZ;20:RE6y1hZ6+FsXpf0asm+kc/CCYOwmr2c5YVvsRtOML2zRgKkYjdGgqIlePeq9MYxjCP5ro78Hp2wbucag3N9upJpUku++akMa0+rQJ+6A+N27fCFWQl9IZfRLnZV91WUz+GgPnigySaTYau7NXghpooaSmGWXnroGtUE1VbwGghw=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN2PR05MB2718;
x-ms-traffictypediagnostic: SN2PR05MB2718:
x-microsoft-antispam-prvs: <SN2PR05MB27186E54C793294FD6AC7F44D0810@SN2PR05MB2718.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:SN2PR05MB2718;BCL:0;PCL:0;RULEID:;SRVR:SN2PR05MB2718;
x-forefront-prvs: 06592CCE58
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(39380400002)(366004)(39860400002)(189003)(199004)(8936002)(6506007)(106356001)(5660300001)(6246003)(97736004)(3846002)(53936002)(54906003)(86362001)(83716003)(53546011)(76176011)(229853002)(6916009)(5250100002)(105586002)(6436002)(316002)(6486002)(6116002)(6512007)(14454004)(25786009)(82746002)(8676002)(36756003)(81166006)(186003)(2906002)(446003)(6346003)(2616005)(7736002)(11346002)(99286004)(478600001)(26005)(2900100001)(476003)(3660700001)(81156014)(66066001)(4326008)(33656002)(68736007)(102836004)(486006)(305945005)(3280700002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN2PR05MB2718;H:SN2PR05MB2654.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com;
x-microsoft-antispam-message-info: ZggEL5FhkDnR2xJay32//7IMZHcO2tyHlhaLb5G9vIyUAcV8uNjsCKHfgNS1f9qfPEwyeASMHZjbRZwO8lHzLz3dkQ0Vd1kHuiuUr3RKokwcSuIO4Fi2nNBwcjGHSxpU1y32lOaD4QYowjzINKU1ICHJafy4Hm3dLCEFZ3WhSb6Z9QeqwjqL52PZA1dr1csT
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <D0FB3A97C1AAAA48AE51EE774C0FC492@namprd05.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: e7d7aa76-a9ac-4b84-365f-08d5af821037
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7d7aa76-a9ac-4b84-365f-08d5af821037
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2018 16:39:09.3544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR05MB2718
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w41GdIx7012494

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Tue, May 1, 2018 at 6:40 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> 
>> But if I remove the section completely by removing the
>> pushsection/popsection, then copy_overflow() gets inlined.
> 
>> So GCC's inlining decisions are somehow influenced by the existence of
>> some random empty section.  This definitely seems like a GCC bug to me.
> 
> I think gcc uses the size of the string to approximate the size of an
> inline asm.
> 
> So I don't think it's the "empty section" that makes gcc do this, I think
> it's literally "our inline asms _look_ big”.

I didn’t think about that.

Playing with the code a bit more, it seems that it is actually related to
the number of “new-lines” in the inline assembly. Removing 4 new-lines from
_BUG_FLAGS (those that can be removed without breaking assembly) eliminated
most of the non-inlined versions of copy_overflow().

Would it be reasonable to remove new-lines in such cases?

Regards,
Nadav
