Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756196AbeEAQq3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 12:46:29 -0400
Received: from mail-by2nam03on0073.outbound.protection.outlook.com ([104.47.42.73]:19008
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755544AbeEAQq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 12:46:28 -0400
From: Nadav Amit <namit@vmware.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
CC: Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Suboptimal inline heuristics due to non-code sections
Thread-Topic: Suboptimal inline heuristics due to non-code sections
Thread-Index: AQHT4RiofuDjvDQvpEaROOrOTLYHiaQa4bMAgAAgoACAABFUgIAAAgkA
Date: Tue, 1 May 2018 16:46:25 +0000
Message-ID: <8E8FD6A0-DA57-4523-A16F-C68167C2B5ED@vmware.com>
References: <A74E4351-A9FA-434D-AD47-3A509F802FFB@vmware.com>
 <20180501134020.fonel3x6plea5xdt@treble>
 <CA+55aFz-11bMkZHWdiiwys32H5jvB4gATvUHT0Vx6pJkFYLb4w@mail.gmail.com>
 <042668BD-8912-44D4-9CA1-9ABA2F094709@vmware.com>
In-Reply-To: <042668BD-8912-44D4-9CA1-9ABA2F094709@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [208.91.2.2]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN2PR05MB2734;7:7UMnPFKOZkz/TVSp4TvjcJG5uP0rdO/n3Vd2c2hDoMoz2iKCXZ3LojiR7BhKY1H8pSmK2ZsTbzxE/IUBzLQL3WNba0rc4pjioFkU5jNcMS60w/Q60Ru1wxhQKkNj7DC9Wcragv1X4ARXhphwiDMbZ83h8QNSLetQZibiQSti28FBCMGmlNmJig99Jt13DgpW0/aA1gA7bSKJcRG6uUOpTwfgLE8XD3TnObefvVgqIso33+OKrY/t3uNz0wSo5AQU;20:iSnqEa7W2Y2iG4M7fibeNaAdhgp7T0NuXn7wMtuaIOfwdR5HNuL1/toljM9E/MUFbtzfd4c9+jFa2fM8qPOu108hLppzTcPFaUItlQrxFcoVLwXtPZg0VPi9ycxe9rnb1g7Zkp8z+qrAfulq6S2+VTKJSpoRzcUxViMJo/KC6KU=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:SN2PR05MB2734;
x-ms-traffictypediagnostic: SN2PR05MB2734:
x-microsoft-antispam-prvs: <SN2PR05MB27345EF97C01F12925E29575D0810@SN2PR05MB2734.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(61668805478150);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(3002001)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:SN2PR05MB2734;BCL:0;PCL:0;RULEID:;SRVR:SN2PR05MB2734;
x-forefront-prvs: 06592CCE58
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(39860400002)(39380400002)(396003)(346002)(189003)(199004)(6486002)(68736007)(86362001)(3280700002)(2906002)(486006)(6512007)(4326008)(3660700001)(25786009)(478600001)(305945005)(97736004)(6436002)(2616005)(476003)(83716003)(446003)(5250100002)(36756003)(3846002)(14454004)(6116002)(229853002)(11346002)(316002)(106356001)(105586002)(26005)(81156014)(2900100001)(66066001)(82746002)(6916009)(99286004)(6346003)(81166006)(8936002)(8676002)(102836004)(5660300001)(76176011)(6246003)(186003)(33656002)(6506007)(93886005)(7736002)(53546011)(53936002)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN2PR05MB2734;H:SN2PR05MB2654.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com;
x-microsoft-antispam-message-info: 0RVWNOzc0dHOTaB8ecsC84U/2n25EJzRwXKUFqhPf0t4/bWoEFQCbpYN2ABKCFTygYqVeXVtJbbl5fimCq6pZn5MPp/50iYJ8ivQdGW+lPKcuMQv2R25gxQ5NRCcrhP6+QENEPBw6bsDQK/OwzCTuBIEvpg4hjsx38ZwuuHjleye5722jQdsKGyA5XeOdaiz
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <06CBB867A8A874419915203CC5AC6EAF@namprd05.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: d698de44-387e-4f6b-a32e-08d5af831428
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d698de44-387e-4f6b-a32e-08d5af831428
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2018 16:46:25.5026
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR05MB2734
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w41Gkb2p013684

Nadav Amit <namit@vmware.com> wrote:

> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
>> On Tue, May 1, 2018 at 6:40 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>> 
>>> But if I remove the section completely by removing the
>>> pushsection/popsection, then copy_overflow() gets inlined.
>> 
>>> So GCC's inlining decisions are somehow influenced by the existence of
>>> some random empty section.  This definitely seems like a GCC bug to me.
>> 
>> I think gcc uses the size of the string to approximate the size of an
>> inline asm.
>> 
>> So I don't think it's the "empty section" that makes gcc do this, I think
>> it's literally "our inline asms _look_ big”.
> 
> I didn’t think about that.
> 
> Playing with the code a bit more, it seems that it is actually related to
> the number of “new-lines” in the inline assembly. Removing 4 new-lines from
> _BUG_FLAGS (those that can be removed without breaking assembly) eliminated
> most of the non-inlined versions of copy_overflow().
> 
> Would it be reasonable to remove new-lines in such cases?

My bad. It’s not the new-line. Let me do some more digging.

Nadav
