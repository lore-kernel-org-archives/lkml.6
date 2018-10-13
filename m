Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB3AC28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 13:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC1E82098A
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 13:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="YJA7I342"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC1E82098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=caviumnetworks.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbeJMVUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 17:20:30 -0400
Received: from mail-by2nam01on0087.outbound.protection.outlook.com ([104.47.34.87]:28574
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726163AbeJMVUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 17:20:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QYZMcMaYupzc498MbX046W/2052N4+mvrogmt3YNDMY=;
 b=YJA7I342YPFl3SACK6/TnGMzXunGHjG4+VjQjOO2PR2KIB3pclrhtZeor0WSjVM8etHVWaJJ1RqCJNotG1TxmZ52zpVIcUaEG+4WPw2JN+s7O+NnFbQspyJcV6OmhD71bZu6+3lHGI+SStpElABT2bcpOs1ccaQTbJ0nBny6pnk=
Received: from BYAPR07MB4373.namprd07.prod.outlook.com (52.135.224.16) by
 BYAPR07MB4359.namprd07.prod.outlook.com (52.135.224.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.25; Sat, 13 Oct 2018 13:43:13 +0000
Received: from BYAPR07MB4373.namprd07.prod.outlook.com
 ([fe80::c8af:ce09:4079:f807]) by BYAPR07MB4373.namprd07.prod.outlook.com
 ([fe80::c8af:ce09:4079:f807%2]) with mapi id 15.20.1228.020; Sat, 13 Oct 2018
 13:43:13 +0000
From:   Yury Norov <ynorov@caviumnetworks.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
CC:     Eugene Syromiatnikov <esyr@redhat.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Pavel Machek <pavel@ucw.cz>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Joseph Myers <joseph@codesourcery.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "Ellcey, Steve" <Steve.Ellcey@cavium.com>,
        "Kapoor, Prasun" <Prasun.Kapoor@cavium.com>,
        Andreas Schwab <schwab@suse.de>,
        Alexander Graf <agraf@suse.de>,
        Bamvor Zhangjian <bamv2005@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Adam Borowski <kilobyte@angband.pl>,
        Manuel Montezelo <manuel.montezelo@gmail.com>,
        James Hogan <james.hogan@imgtec.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Pinski <pinskia@gmail.com>,
        Lin Yongting <linyongting@huawei.com>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Wookey <wookey@wookware.org>, Mark Brown <broonie@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Florian Weimer <fweimer@redhat.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        Nathan_Lynch <Nathan_Lynch@mentor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>,
        Ramana Radhakrishnan <ramana.gcc@googlemail.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>
Subject: Re: [PATCH v9 00/24] ILP32 for ARM64
Thread-Topic: [PATCH v9 00/24] ILP32 for ARM64
Thread-Index: AQHT7O6apmdUMTjqyEuLxJG41cI5NKUZa/7tgAAYSwCAA9a7AIAAeumAgABFiYA=
Date:   Sat, 13 Oct 2018 13:43:12 +0000
Message-ID: <20181013134303.GA12721@yury-thinkpad>
References: <20180516081910.10067-1-ynorov@caviumnetworks.com>
 <20180724173957.GA22106@yury-thinkpad>
 <20181010141017.GA2881@asgard.redhat.com>
 <20181010153655.GA212880@arrakis.emea.arm.com>
 <20181013021416.GE21972@asgard.redhat.com>
 <20181013093411.o3id6yzkspsxr5jt@mbp>
In-Reply-To: <20181013093411.o3id6yzkspsxr5jt@mbp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P189CA0012.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::25) To BYAPR07MB4373.namprd07.prod.outlook.com
 (2603:10b6:a02:c0::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yuri.Norov@cavium.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [212.58.114.41]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR07MB4359;6:62UJBia7lmybvEUtW8Rwq6/M+2Wgr2gHJ9j3Z8gkwJF/FwX2khKE9c/gTwlAfhGmcvSSxk+0JVrwrMTMot252nD9O6iEERNeDBLX2NhU+KgzZd15RFktnp/xI0JQxsuIMh7TfQp4tMpLlATJ4vx7TTOQzwSZmCleTRd1SL3B7GeJc5Qo6FPfGYMiuIvVf3qwt0w8+GOfb6Dlh/1Mxkmj7OurDTK0NSHK3peR0DiJQeyzMJM1ydgMNBZv/TzpQOcVnU/mkI4l6jPgGOeDj/k/Ixr0K/Y0wh6bJR/5JhgKhMKgUotPhsSAlCLfcyMJgLB6DF/8+eJXRST07cXOp7NxGosXF55Vmh7Eufknnxfwvemn6l0s1Sp4tu4mMrYdcMniCGqAZL86piHAMTuvjCq17+WbJQCPF1oHOJ3EjGEeX3i52E19w17JuyzGy+Kz2B5pcoVdmWgZbf8i/JsA+QTWCQ==;5:Vj/mNVfb6eUgS483OnO7Z9ImnArQ1qxa6GXL7xkuxqUuKF0epc0Hjj/Y0yUE6xGUlje0sbmHsI3GYJAoM0ls46X09MKapYqyPs6bBDO5jUbRna+cGCxovMKnUsSp6n6tCbGZYWhyNpDOiyBTMWXUcr4oNvOPs7PmjdZQ2MiLPdM=;7:muW6tQAd3c8W6E3YhlEmUCx7PooKWsr1f7yowK48xguo41vVYoaJPnDzYYmZQIOpb4Y/ZQCTdmTjjir9q2qWwC9ptdRz6lvu5s9lKBglwZsroLF13Z45G2/RwWCsajNZ/5/LY75/GinRufUgNonEsZBLIJYB7JFvZGFRI/IbaMV+2p6godgSaV81pKnECoakTXVpEOZP9B6zFiLVFQyjBddtaVfsEvQVrH7KqyaQvlSSwJHmVe0gFXAiuWnj5bPy
x-ms-office365-filtering-correlation-id: ad8b8979-0225-438c-cb45-08d63111d16a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB4359;
x-ms-traffictypediagnostic: BYAPR07MB4359:
x-microsoft-antispam-prvs: <BYAPR07MB43593A677D2F3078A86AE527E3E30@BYAPR07MB4359.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(53098968806563);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(4982022)(52105095)(3002001)(10201501046)(93006095)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991067);SRVR:BYAPR07MB4359;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB4359;
x-forefront-prvs: 082465FB26
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(346002)(39860400002)(396003)(366004)(376002)(136003)(189003)(199004)(14454004)(6246003)(2900100001)(11346002)(3846002)(4326008)(68736007)(6116002)(53936002)(486006)(476003)(446003)(6306002)(305945005)(9686003)(316002)(6512007)(7736002)(25786009)(71200400001)(256004)(966005)(8936002)(72206003)(71190400001)(1076002)(81166006)(478600001)(81156014)(14444005)(8676002)(6916009)(39060400002)(5660300001)(42882007)(6506007)(386003)(33716001)(76176011)(229853002)(186003)(102836004)(6486002)(26005)(33896004)(5250100002)(66066001)(105586002)(2906002)(7406005)(106356001)(52116002)(33656002)(97736004)(93886005)(54906003)(99286004)(7416002)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4359;H:BYAPR07MB4373.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: jsSdcJmhhFDw36IeUcUNvxHaHJHIqWa/rZN3TGewSwc0m+je4ZuFMz/1HJGUUEsgJuBM64PGs4VJnFWPTYbVPFAZADczx0f37hKaPyEV/WNtUkY0AHduvT4SouBLk0yuYpKiE91owHl/Rb2JQWNpUoOOE/1KwPYaFVIAflOyNJcXe4NkNnPwI9DGqEwmXmrM3CH8LzWfrecoW9M9TyJfCat76er/pH70184TLPpNGXbwdgd+1fDGpaZEBzJVc4cLcc3HE8SfAaHcw7JRqdMIPHG00qH+Kkgjj8Gg0/5ghBFm1Ea5E0VEMBAJ5BA7qUVnXretF9SJvu1CAbzcI5Q/auKMl5stvwkaAx4pK+biZao=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <93FE0310E155A04AA98A37E4988E636C@namprd07.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad8b8979-0225-438c-cb45-08d63111d16a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2018 13:43:13.0955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4359
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 13, 2018 at 10:34:11AM +0100, Catalin Marinas wrote:
>=20
> Lines: 73
>=20
> External Email
>=20
> On Sat, Oct 13, 2018 at 04:14:16AM +0200, Eugene Syromiatnikov wrote:
> > On Wed, Oct 10, 2018 at 04:36:56PM +0100, Catalin Marinas wrote:
> > > On Wed, Oct 10, 2018 at 04:10:21PM +0200, Eugene Syromiatnikov wrote:
> > > > I have some questions regarding AArch64 ILP32 implementation for wh=
ich I
> > > > failed to find an answer myself:
> > > >  * How ptrace() tracer is supposed to distinguish between ILP32 and=
 LP64
> > > >    tracees? For MIPS N32 and x32 this is possible based on syscall
> > > >    number, but for AArch64 ILP32 I do not see such a sign. There's =
also
> > > >    ARM_ip is employed for signalling entering/exiting, I wonder whe=
ther
> > > >    it's possible to employ it also for signalling tracee's personal=
ity.
> > >
> > > With the current implementation, I don't think you can distinguish. F=
rom
> > > the kernel perspective, the register set is the same. What is the
> > > use-case for this?
> >
> > Err, a ptrace()-based tracer trying to trace a process, for example?
>=20
> I first thought it wouldn't matter for ptrace-based tracers since the
> syscall numbers are (mostly) the same. But the arguments layout in
> register is indeed different, so I see your point now about having to
> distinguish.
>=20
> > > We could add a new regset to expose the ILP32 state (NT_ARM_..., I ca=
n't
> > > think of a name now but probably not PER* as this implies PER_LINUX_.=
..
> > > which is independent from TIF_32BIT_*).
> >
> > So that would require an additional ptrace() call on each syscall stop,
> > is that correct?
>=20
> The ILP32 state does not change at run-time, so it could only do a
> ptrace() call once and save the information. No need to re-read it on
> each syscall stop.
>=20
> We could set a high bit in the syscall number reported to the ptrace
> caller (though not changing the syscall ABI) but I haven't thought of
> other consequences. For example, can the ptrace caller change the
> syscall number?

I believe, /proc/PID/auxv is enough to distinguish between arm64, ilp32
and aarch32 ABis. If no, I think it's better to do it there.

I don't have ILP32 machine available at the moment, but I'll check it soon.=
=20

> > > >  * What's the reasoning behind capping syscall arguments to 32 bit?=
 x32
> > > >    and MIPS N32 do not have such a restriction (and do not need spe=
cial
> > > >    wrappers for syscalls that pass 64-bit values as a result, excep=
t
> > > >    when they do,  as it is the case for preadv2 on x32); moreover, =
that
> > > >    would lead to insurmountable difficulties for AArch64 ILP32 trac=
ers
> > > >    that try to trace LP64 tracees, as it would be impossible to pas=
s
> > > >    64-bit addresses to process_vm_{read,write} or ptrace PEEK/POKE.
> > >
> > > We've attempted in earlier versions to allow a mix of 32 and 64-bit
> > > register values from ILP32 but it got pretty complicated. The entry c=
ode
> > > would need to know which registers need zeroing of the top 32-bit
> >
> > If kernel specifies 64-bit wide registers for syscalls, then it's the
> > caller's (libc's) responsibility to properly sign-extend arguments when
> > needed, and glibc, for example, already has proper type definitions tha=
t
> > aimed to handle this.
>=20
> We tried, see my other reply.

A couple of links to recall the story:
https://www.spinics.net/lists/linux-s390/msg11593.html
http://linux-kernel.2935.n7.nabble.com/RFC6-PATCH-v6-00-21-ILP32-for-ARM64-=
td1345105.html

Cover-letter of the series has links to previous discussions.

I would also notice that even if we pass 64-bit parameters in a single
register, we cannot avoid using the compat layer. It looks more natural
not to split the 64-bit register, but from performance point of view
there is almost no difference, either we split registers or not (2.6%
for empty syscall, as I measured). And the cost of overcomplication was
considered too much. So we chose to stick to more standard compat layer
and gain in maintainability.=20

Yury

