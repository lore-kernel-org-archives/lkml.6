Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756046AbeEAQyy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 12:54:54 -0400
Received: from mail-bl2nam02on0052.outbound.protection.outlook.com ([104.47.38.52]:26432
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753878AbeEAQyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 12:54:53 -0400
From: Nadav Amit <namit@vmware.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
CC: Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Suboptimal inline heuristics due to non-code sections
Thread-Topic: Suboptimal inline heuristics due to non-code sections
Thread-Index: AQHT4RiofuDjvDQvpEaROOrOTLYHiaQa4bMAgAAgoACAABFUgIAAAgkAgAABiwCAAADMgA==
Date: Tue, 1 May 2018 16:54:49 +0000
Message-ID: <883C8C03-3CB2-47A0-888E-4D53C76FB281@vmware.com>
References: <A74E4351-A9FA-434D-AD47-3A509F802FFB@vmware.com>
 <20180501134020.fonel3x6plea5xdt@treble>
 <CA+55aFz-11bMkZHWdiiwys32H5jvB4gATvUHT0Vx6pJkFYLb4w@mail.gmail.com>
 <042668BD-8912-44D4-9CA1-9ABA2F094709@vmware.com>
 <8E8FD6A0-DA57-4523-A16F-C68167C2B5ED@vmware.com>
 <CA+55aFwowsU8wVN9AY4qWdY+LBf7iW1BNBZfwpfxuOE36iiNbQ@mail.gmail.com>
In-Reply-To: <CA+55aFwowsU8wVN9AY4qWdY+LBf7iW1BNBZfwpfxuOE36iiNbQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com;
x-originating-ip: [208.91.2.2]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN2PR05MB2669;7:0NQ4JozqHUckQWDAs6u/of6fYTfZc1BdQjaE18IOg2a5E/EYhYRSg7nH5wgs9VUyR2sDyO2rkAuUnFutBXZdHhIKz725zLPbwfI2IQv6+RFik/anRHA2li5h1JpdVf+MT7P0CTR87FXpKvltSkvRmQReZNBUDflnA3rVoMqYWP7gdGLMfQbsTUUhL0HmA8h+VjuQgW7EqSnUd6kkBDEEAsmi0bxlFJ3v/6xcxifwyYKnd2H9gP4cOGv7MBycp2qj;20:tbTe3w6QcRJAec60Zcd9LvRTGjCweiXHkigEotpxBzS7KY9Zf5AlMzlKJmshTujnjRk5+fJtmXFCwkm3MunxB7Bxo/aulcB99KbBL+oFN2vqOw1twNp2gLlo1H7Dj1MFy/dnDC4ald/U+EVGQGLDDVJjU1RtfECwUoDpvq6KM08=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN2PR05MB2669;
x-ms-traffictypediagnostic: SN2PR05MB2669:
x-microsoft-antispam-prvs: <SN2PR05MB26699980BA69C9D831ED6A06D0810@SN2PR05MB2669.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(61668805478150);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231254)(944501410)(52105095)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:SN2PR05MB2669;BCL:0;PCL:0;RULEID:;SRVR:SN2PR05MB2669;
x-forefront-prvs: 06592CCE58
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(366004)(39380400002)(396003)(199004)(189003)(446003)(86362001)(76176011)(99286004)(68736007)(102836004)(8676002)(81166006)(54906003)(66066001)(2900100001)(81156014)(82746002)(486006)(5250100002)(26005)(476003)(6486002)(6512007)(316002)(11346002)(53546011)(229853002)(83716003)(6436002)(6506007)(186003)(33656002)(93886005)(2616005)(59450400001)(5660300001)(25786009)(105586002)(6116002)(3846002)(3280700002)(7736002)(478600001)(6246003)(4326008)(2906002)(305945005)(6916009)(3660700001)(53936002)(8936002)(36756003)(14454004)(106356001)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN2PR05MB2669;H:SN2PR05MB2654.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: sJjuwef6yg4PdFeUcAYNdiaNDwMRZT61rPowLvHABq79LuodwGMi3bg0MPHxFlRS3pNPqHB1+rOogv046lmb/zLDrEYhIHXfbNcAPfina+u11pYlRD9xGhsvAlC9YUr4g+/S9tjYzp1zYFVc7Aio4mC/IdM7udRjBi2jsLuvF3OYBArAnvwu5f9DSo9EW3lI
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <2587990B77FD664A861F49E68FCB8B1F@namprd05.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 6e821716-5ec1-4d25-6225-08d5af84404f
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e821716-5ec1-4d25-6225-08d5af84404f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2018 16:54:49.0169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR05MB2669
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w41Gt07Y018431

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Tue, May 1, 2018 at 9:46 AM Nadav Amit <namit@vmware.com> wrote:
> 
>> My bad. It’s not the new-line. Let me do some more digging.
> 
> From the gcc docs:
> 
>   Some targets require that GCC track the size of each instruction used
>   in order to generate correct code.  Because the final length of the
>   code produced by an @code{asm} statement is only known by the
>   assembler, GCC must make an estimate as to how big it will be.  It
>   does this by counting the number of instructions in the pattern of the
>   @code{asm} and multiplying that by the length of the longest
>   instruction supported by that processor.  (When working out the number
>   of instructions, it assumes that any occurrence of a newline or of
>   whatever statement separator character is supported by the assembler --
>   typically @samp{;} --- indicates the end of an instruction.)
> 
> so it probably counts newlines and semicolons to estimate the size.

Thanks. I probably did not have enough coffee.

I’ll work on it.

Regards,
Nadav
