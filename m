Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A452EC282CC
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 20:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BBB5218D2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 20:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="AShQVu9A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbfBHUJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 15:09:04 -0500
Received: from mail-eopbgr800114.outbound.protection.outlook.com ([40.107.80.114]:44951
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726211AbfBHUJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 15:09:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=raqfwCt8+wo22dH89sYfYzNDyByvcxD2aS+JQQ9fgRc=;
 b=AShQVu9AuQnahAz4V+LBatqnRc/GTJXa2bHk5FiOJSinEfrngGz6B4tfdCPYaggxfMHITyoZBsdUjaak4k4DSg75MxLRT7kTv1OAhlPkv3oEHm0k3fGbV+iKCjJCarL9TEMhrWqJyvDT7xEErGrtgf9FFGw89quryr8uA/Xko6U=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1536.namprd22.prod.outlook.com (10.174.170.161) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.19; Fri, 8 Feb 2019 20:08:54 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636%9]) with mapi id 15.20.1580.019; Fri, 8 Feb 2019
 20:08:54 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Tom Li <tomli@tomli.me>
CC:     James Hogan <jhogan@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhc@lemote.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Alexandre Oliva <lxoliva@fsfla.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] On the Current Troubles of Mainlining Loongson Platform
 Drivers
Thread-Topic: [RFC] On the Current Troubles of Mainlining Loongson Platform
 Drivers
Thread-Index: AQHUv4iaADGqjKpPI06v8WRtTh6JiaXWVScA
Date:   Fri, 8 Feb 2019 20:08:54 +0000
Message-ID: <20190208200852.wcywd7yfcq7zwzve@pburton-laptop>
References: <20190208083038.GA1433@localhost.localdomain>
In-Reply-To: <20190208083038.GA1433@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR11CA0064.namprd11.prod.outlook.com
 (2603:10b6:a03:80::41) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1536;6:zZn3SIzMqneFyq2A8Q4L/PZcjlWLHxTVoHri4i49aaGY+c3o8ExFufv3seuHiOmM8SBnqDLQY35fS31nnZJsPvasAI2foxLlX3h2boRDA29FqG1YcDpsqlTbAkMzxaXtBjPC3UQ5TqSMIrkNmG//QsL2qFVjmS/v//kSAetwjR2u+sTVDo0735T6/5TpJYcq2wuNWIZU8zbd5aJp4UUMH0e2HalbWTTU5i6BgAKNXqtZok6jYRFqlcTwBIMLwvD8UGWXUfdWg+VZtmsfWfNQport84MKbc6JlgTq9OPAS/hr1RS9DsVUuUOKDbztXYTPoOvmOWMHXCPbDgI6aF7ghXNQFLXxNceOC/Rc+aC6upGB6KXxCtCxRzVQtCxaRGDZeUQaJyvlFTjfuAw5n/7cA2mJHXooVeLE1SKwfuFOyuv2cYp1Euh/aeVpmSqXuxjVg5WIhD6aorS6ZRDsTCYjEw==;5:fgTqAtt6tLmPbqIsbnrX3MQR793s09jXxkOWqAMsPw2h1Q9g0/ZLisY9wPTuwixVP78YKy4nWyg/RaPcekeufJZEG9gJxvP5WiteVHW+eFvaHT1S7r5qUWbsZ0pu68ne/OBXlvcgte/0jGabOfdp5ZN7Ti0rarIAHTcuOJF8hKaexuT3sI9hDkM96CVdvesBMvgJLDV2x7G/cQyXcaj7Aw==;7:2L1R2xbPckCs5/RPI/03tO7LBeoSbgEpMSUf6GYWHBMFVH4C17kDhIDcOVQ2gEaJ9C8qYeu7EH1MmvfrdF7lo82fMyRvotTmvEIaTu9UC/GSnPLKdmsIy31xHzKs1EooBgLkDZf8R19Ghqmw6DBFJA==
x-ms-office365-filtering-correlation-id: 3e2e585e-9b8a-43db-1bb7-08d68e013ff1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1536;
x-ms-traffictypediagnostic: MWHPR2201MB1536:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MWHPR2201MB1536D134D4E6B4DBF8FCDA38C1690@MWHPR2201MB1536.namprd22.prod.outlook.com>
x-forefront-prvs: 094213BFEA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(376002)(136003)(346002)(39840400004)(396003)(366004)(51444003)(189003)(199004)(66066001)(71190400001)(71200400001)(9686003)(97736004)(53936002)(6512007)(105586002)(99286004)(6306002)(44832011)(6916009)(486006)(476003)(106356001)(14454004)(4326008)(81156014)(6436002)(6116002)(42882007)(966005)(33716001)(26005)(1076003)(11346002)(256004)(81166006)(14444005)(25786009)(386003)(6506007)(68736007)(76176011)(7736002)(58126008)(8936002)(6246003)(305945005)(102836004)(186003)(229853002)(316002)(33896004)(8676002)(478600001)(52116002)(54906003)(6486002)(3846002)(446003)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1536;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dJUD18gERv/uyeYC+UcJecsDCw6+EChwUiqlhXMKKxz+BAtl5u6TK31bfsVhjCegqqQOrFQsxn4xSG3kR8AiKxwyNL/z/tpm1Ji4OG/RIxkus4P1tsLAG7P++Gn8MZqa3h3Eaf9rgdN/KSdy6KssOJfY76iLV+/j1AIHK5eq50N1Pcs9p6pchF3UytyhIB0Kmmk1OYzHF8460IK6ZKiah4i0T83La/nx08h0GMW6JwrGUBMiy88n9W3aVYIVov79CQ3n2jn87zJAnr0y8wVguHf3kKiVHHmacGQDQYOvgb7XpDNHlw/ywxpvac+GpawalRzlqWNAvuxkDXbcnECAS9FT5vLCQ6W4S9K6hNjLpixCRjq7yR+qlAqBS+Xp38xwWrqrgxjSCKvIET6cZ5QzM63aReeewRBOC6x2acgmeDE=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6668C8AF95730748ABCB4C72E233E229@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e2e585e-9b8a-43db-1bb7-08d68e013ff1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2019 20:08:53.7810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1536
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

On Fri, Feb 08, 2019 at 04:30:39PM +0800, Tom Li wrote:
> Hello, Greg, Ralf, Paul, James, Alexandre and Huacai
>=20
> Many years ago when I was still in the middle scheool, I got a Loongson
> Yeeloong laptop to explore the world of non-x86 world, as Geert Uytterhoe=
ven
> once said, there's lots of Linux beyond IA-32. At that time I've noticed =
there
> was no platform driver for the laptop. I just assumed that nobody bothere=
d
> mainlining it and everyone were using Alexandre Oliva's tree. I've diffed
> his tree, got the patches, discovered and fixed two minor bugs and submit=
ted
> to Alexandre, and called it a day.
>=20
> Years later, I stared at my machine, and found Alexandre Oliva has stoppe=
d
> maintaining his tree, yet there is still no platform driver in the mainli=
ne.
> So I decided that submitting the Yeeloong driver to the mainline kernel i=
s
> the my current personal project of this year. I only work for myself for =
fun,
> not for profit. I see Loongson as an interesting non-x86 platform, but I =
do
> not work for Loongson, do not explictly support them, nor supported by th=
em
> in any way.
>=20
> Reviewing the previous E-mails and patches at Linux/MIPS mailing list, I'=
ve
> noticed that, from 2009 to 2019, in a 10-year span, there have been at le=
ast
> 3 attempts by 3 people to submit the platform driver for Yeeloong laptop =
to
> the Linux/MIPS tree, all implicitly rejected. This is not meant to be a
> criticism for maintainers' hard work and high quality standard, but rathe=
r,
> I think it shows a serious challenge on development of platform drivers t=
hat
> worth discussing. since there's even more unsubmitted platform drivers fo=
r
> more devices, especially Loongson3. We need to find a solution both for
> short-term and long-term further development of these platform drivers.
>=20
> Here, I give a quick summary about the situation, and see what can I/we
> do about it. Digging into the mailing list, in the hindsight, it's clear
> to see the fate of this platform driver. In December 2009, Wu Zhangin
> submitted a refined version of the initial platform driver to the mailing
> list.
>=20
> His intention was to create a MIPS-equivalent version of the x86 platform
> drivers, as he said,
>=20
> > I like the folks did under drivers/platform/x86/ ;) which
> > will be better to maintain. for all of these drivers are really only
> > YeeLoong platform specific ;)
>=20
> However, Ralf Baechle commented, that
>=20
> > You split old, big driver into several individual drivers - good.
> [...]
> > Experience has shown that drivers for a particular subsystem are best
> > combined in a single menu, in a single directory. Otherwise any changes
> > to subsystem's internal APIs will become a major pain.
>=20
> Dmitry Torokhov gave another response,
>=20
> > Umm, it still mixes up bunch of stuff not directly related to input.
> > I'd vote for drivers/platform/mips (since we have a few of kitchen-sink
> > style drivers for x86-based laptops in drivers/platform/x86).
>=20
> This discussion is frozen without any progress in the following years.
>=20
> For example, when the driver was resubmitted to James Hogan in late 2018,
> he noted, possibly without knowledge of the discussion in 2009,
>=20
> > I can't help thinking it would be better to separate this into separate
> > drivers for each part (backlight, power supply etc), and move them into
> > the appropriate driver directories (drivers/power/supply,
> > drivers/video/backlight etc). That way each part would get proper revie=
w
> > from the appropriate maintainers (or at least they should be Cc'd).
> >=20
> > Is there a particular reason for it to be a single driver?
>=20
> So I think it's the time to restart this discussion. Should the driver be
> submitted as a platform driver, or be splitted and merged into various
> subsystems? I've considered reasons from both sides.

Right off the bat, let me express my whole-hearted agreement with James
& the question he asked in that quote. If there is a good reason for
some things to be one large driver then we can discuss that, but so far I
don't believe anybody has given one - nobody replied to James' mail that
you quote [1].

It looks to me like in 2009 someone did the work to split the driver up,
which shows that it's possible, but the drivers were placed under
arch/mips which is not where they belong. They should individually be
placed at the right points under drivers/, and submitted to the relevant
subsystem maintainers.

To address the particular quote you give from Dmitry Torokhov on the
yeeloong_hotkey driver - just because the driver as-is includes a bunch
of non-input related things doesn't mean that it should or has to. From
a look at the 2009 submission it seems to mix a bunch of policy into the
kernel which really ought to be elsewhere. Generally the input driver
reports that a key was pressed & something in userland decides what to
do with it, whereas this driver seems to attempt to bypass that & prod
at unrelated hardware all by itself.

> Unsolved problems still remains, however. First, how to solve the coordin=
ation
> problem? Linux/MIPS is a relatively low-volume and slow list, what to do =
if the
> unmerged MIPS patches becomes a blocker for other drivers?

Anyone watching will have noticed that Ralf was only intermittently
active for quite a while, and has more recently he's been absent due to
ill health. Correspondingly there was a time when patches sent to
linux-mips didn't go anywhere quickly. Towards the end of 2017 James
Hogan stepped up & things started moving again, and more recently I've
been maintaining arch/mips/. The number of patches being applied has
increased, the frequency of pull requests has increased & stopped being
so last minute, and hopefully responses on the mailing list have become
more regular.

So if unmerged arch/mips/ patches are holding you up, ping me, but
preferrably make sure code being added actually belongs under arch/mips/
first.

On Loongson patches in particular there's a recurring theme in which
patches are submitted, review comments are provided, they're ignored &
the patches are later submitted again without addressing the review
comments. That's not universally true of all Loongson-related patches,
but there are plenty of examples of it. Of course when resubmitted the
patches still don't get merged, because they still have unaddressed
problems.

The seeming lack of documentation for particular Loongson-based
machines, lack of English documentation for the CPU cores & lack of
detailed errata information all contribute to difficulties too. For a
recent example see the loongson_llsc_mb() workaround currently in the
mips-fixes branch - we got there in the end but it took a surprising
amount of back & forth effort to obtain enough information about what
the CPU bug actually is.

I want to be clear that I absolutely want Linux to have good support for
Loongson hardware, but that doesn't mean I'll merge things before
they're of sufficient quality & it doesn't mean I'll try to merge things
that really belong under the care of other maintainers.

> Second, we already have a hwmon driver under drivers/platform/mips,
> should we put a warning that says new drivers under this directory
> shouldn't be written?

Personally I see no reason for that hwmon driver to live under
drivers/platform/mips rather than drivers/hwmon. All that does is bypass
the attention of the drivers/hwmon/ maintainers who would be best placed
to offer input & ensure the driver is actually any good.

> Third, if we agree to create drivers/platform/loongson in the future,
> how can we ask the maintainers of other subsystems to review the
> drivers in it?

I think that question should prompt another - if we have maintainers for
various driver subsystems, why not place the drivers under their care in
the already established directories?

> I think Google bypassed the problem because they have lots of kernel
> developers, but not us. Does anyone know more about Chromebook's
> development procedures? Also, if we want drivers/platform/loongson and
> its own tree, what are the procedures to get them created?

I can't speak to Google's intentions or methods, but would expect the
procedure to be approximately:

  1) Have a generally agreed upon good reason for the new directory.

  2) Have someone willing & able to maintain it, preferrably with a good
     track record of contributions to the kernel.

  3) Ideally submit it for inclusion in linux-next.

  4) Send a pull request to Linus.

  5) Wait & see if he accepts or says no.

I think this particular case falls down at step 1.

Thanks,
    Paul

[1] https://lore.kernel.org/linux-mips/20180124115833.GC5446@saruman/
