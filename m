Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF842ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A1FE2147C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="YZz0jifM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A1FE2147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388702AbeIUCeC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 22:34:02 -0400
Received: from mail-co1nam03on0113.outbound.protection.outlook.com ([104.47.40.113]:11008
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733291AbeIUCeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 22:34:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dPfpAqjgkn2CtgJ2CxzuxBnF2pubZTRylM7NX3X5WnM=;
 b=YZz0jifMkBIfJl3zZpIGNSZOpphrBwWoUCfC8SH3lD+rSrwiTpUaSWdVHMg9VmOv9lEiXdsIqP1DkidqgorW/hPkNCMBA7om1dMAR53M+7k5La8CkXe6iII7weGPZ5NVSc7B9RAw1wAdWiMY5F7MG2QMfP3w194RiUP5u6SsoCI=
Received: from BYAPR08MB4934.namprd08.prod.outlook.com (20.176.255.143) by
 BYAPR08MB5016.namprd08.prod.outlook.com (20.177.125.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.17; Thu, 20 Sep 2018 20:48:37 +0000
Received: from BYAPR08MB4934.namprd08.prod.outlook.com
 ([fe80::d9a4:818:86af:8981]) by BYAPR08MB4934.namprd08.prod.outlook.com
 ([fe80::d9a4:818:86af:8981%5]) with mapi id 15.20.1143.017; Thu, 20 Sep 2018
 20:48:37 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Firoz Khan <firoz.khan@linaro.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?iso-8859-2?Q?Rafa=B3_Mi=B3ecki?= <zajec5@gmail.com>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Subject: Re: [PATCH 0/3] System call table generation support
Thread-Topic: [PATCH 0/3] System call table generation support
Thread-Index: AQHUTAZndJ66Nr5INkGiO2D9iPvZmKT0vIcAgASOZ4CAAGObgA==
Date:   Thu, 20 Sep 2018 20:48:37 +0000
Message-ID: <20180920204833.gpypjjxcmxjupls6@pburton-laptop>
References: <1536914314-5026-1-git-send-email-firoz.khan@linaro.org>
 <20180917171720.wda5qrl7hyyacmwl@pburton-laptop>
 <CAK8P3a1=BriZ7hgzgK4QpAT00MBEtXaKOSU+vdHN1=5owB9i4A@mail.gmail.com>
In-Reply-To: <CAK8P3a1=BriZ7hgzgK4QpAT00MBEtXaKOSU+vdHN1=5owB9i4A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR14CA0037.namprd14.prod.outlook.com
 (2603:10b6:404:13f::23) To BYAPR08MB4934.namprd08.prod.outlook.com
 (2603:10b6:a03:6a::15)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR08MB5016;6:2oEZWc4jfbQ0UiotguOkK1AR1kMrXNwpIK790PLhyPoKkX9C70I+pgFLH0MRxc/Cj8W1NuJ3ZpZo6lNlehwHzLe9sJgKnv9FhQFCGgG3qj0GfhxkUK4XpJ2SwtnFLlWAdCPXD3IOcmL7PbOg0e5P3jFq+iC2S6sOw4kSjV1Io4u5oCUX8dQXgYBbOOJQlpwEF1cxI0HnNZTLB+/H1SS7ws09rQWp7JFdMwDTiyMUrhma6c9gh1A3W1zvefy72TBFPjIlz6bCGCbVmvGq9PanAzqa2ovceB7TqzppmoKyvL35Ry8n6CQ0m2/Z60VPwSJPlWNDLjzy60ld2Beu6wkTsW91Zj4Mv7kaJ0nx8CHMHKBnLOlf8BGe6L5VAZ/2BstHdLdDIG2XqabIbJireh1NGr+4wzZCN+4lbkScE0BLDAcHz6VhXNl2ivisaAncDQm2fg2cbgnUpNpti4oedwdHgQ==;5:KjWFb7jTahXQ9OA1VtUbyKh4qLV86go/U/TCQimJ4DvpHlUYleduGXmRks0D5+s2IaTF2dlvUWiklmUitrn+8Jl5qX/F4COAmkmUV70A/yWN24JwfL6mLlHa7rAAJLr9jX/ZdX9W5TPbe/2H42X8yPRbovFTEPob2FITOIZXuqI=;7:0/bczRFmVog+dpuMuL3CsOuf+l8JVFKApcmDW9uXWRHdpfXt4c9zxnlioYHm01H3Y56PrGAjuSLLPJBKIMeEtpa9iZOJL1E6PklRzcvetlgm7usQ8axaRySY0lz0WBFOrXjf/Xbo1YzTQUeWpvCb2AHSKVOQp1vpOCa3XuUGuIHy047gaUPpCT5wk1cM58pH7QGoxTfVQ6S70G2GMY9p7qXEuVDG7EKnZjQ4NnaCgQtHEIdNl4waeQ5Ifpq8DovZ
x-ms-office365-filtering-correlation-id: 3d2ad5c2-c596-4a4a-33ea-08d61f3a6fd4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB5016;
x-ms-traffictypediagnostic: BYAPR08MB5016:
x-microsoft-antispam-prvs: <BYAPR08MB5016AE10A86C8F240F3F3E43C1130@BYAPR08MB5016.namprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(84791874153150);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(3231355)(944501410)(52105095)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699051);SRVR:BYAPR08MB5016;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB5016;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(366004)(136003)(346002)(376002)(39840400004)(396003)(199004)(189003)(2900100001)(6486002)(446003)(4326008)(99286004)(2906002)(6306002)(54906003)(25786009)(316002)(39060400002)(6916009)(6246003)(53936002)(8936002)(478600001)(97736004)(106356001)(58126008)(81166006)(966005)(7416002)(6512007)(9686003)(14454004)(105586002)(6116002)(3846002)(81156014)(305945005)(7736002)(6436002)(33896004)(66066001)(1076002)(229853002)(476003)(68736007)(11346002)(52116002)(42882007)(256004)(14444005)(486006)(33716001)(386003)(26005)(102836004)(53546011)(76176011)(186003)(6506007)(5660300001)(8676002)(5250100002)(44832011)(71200400001)(71190400001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB5016;H:BYAPR08MB4934.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: fdzdNNLGJq+jRS6HQK33uM5BPfychguSOMYpm//wpIt0vJK+ujmnVdQOjR5UjyhvWEUL50DuHEVWycmnQx66OP21aZPfM5cj2coLmbOvmcl12R48QeQm5z5maffhRv7y0+2uPC4aJD7tMTSAOs7f8WZVGRqGou6JlK7n3ZC9sDro1P8JTZNEcQBLGCbE7iTHByogvH5m6H6x0iTgeh4ZB8KqLzhWOHXRasdi3OhR6OJ1n42M2CWMekkmHFwQbpEloxfn9Z5hRPqS8Wx+c4+nsg5kaLCP+K7dR0Bj/QZei4AwFWZ44rMQn/iJdBEqHkkZjVXnpnYXA8B8IuLpaPZ1aVfUeNjiVFxy16+2gGaQ5zg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-2"
Content-ID: <574F09FB11710046BB4B89F6CAD92D8D@namprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d2ad5c2-c596-4a4a-33ea-08d61f3a6fd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 20:48:37.2331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB5016
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Thu, Sep 20, 2018 at 07:52:03AM -0700, Arnd Bergmann wrote:
> On Mon, Sep 17, 2018 at 10:17 AM Paul Burton <paul.burton@mips.com> wrote=
:
> > On Fri, Sep 14, 2018 at 02:08:31PM +0530, Firoz Khan wrote:
> > > The purpose of this patch series is:
> > > 1. We can easily add/modify/delete system call by changing entry
> > > in syscall.tbl file. No need to manually edit many files.
> > >
> > > 2. It is easy to unify the system call implementation across all
> > > the architectures.
> > >
> > > The system call tables are in different format in all architecture
> > > and it will be difficult to manually add or modify the system calls
> > > in the respective files manually. To make it easy by keeping a script
> > > and which'll generate the header file and syscall table file so this
> > > change will unify them across all architectures.
> >
> > Interesting :)
> >
> > I actually started on something similar recently with the goals of
> > reducing the need to adjust both asm/unistd.h & the syscall entry table=
s
> > when adding syscalls, clean up asm/unistd.h a bit & make it
> > easier/cleaner to add support for nanoMIPS & the P32 ABI.
> >
> > My branch still needed some work but it's here if you're interested:
> >
> >     git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git wip-mi=
ps-syscalls
> >
> >     https://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/log/=
?h=3Dwip-mips-syscalls
>=20
> This looks like a very nice approach that we would probably prefer if we =
wanted
> to do it only for mips. The way Firoz did it makes sense in the context o=
f doing
> it the same way on all architectures, where usually the information is mo=
re
> accessible to human readers by using the number as the primary key.

Yup, I completely agree that moving all this towards being common
infrastructure for all architectures is a worthy goal :)

> Speaking of nanoMIPS, what is your plan for the syscall ABI there?
> I can see two ways of approaching it:
>=20
> a) keep all the MIPSisms in the data structures, and just use a subset of
>     o32 that drops all the obsolete entry points
> b) start over and stay as close as possible to the generic ABI, using the
>     asm-generic versions of both the syscall table and the uapi header
>     files instead of the traditional version.

We've taken option b in our current downstream kernel & that's what I
hope we'll get upstream too. There's no expectation that we'll ever need
to mix pre-nanoMIPS & nanoMIPS ISAs or their associated ABIs across the
kernel/user boundary so it's felt like a great opportunity to clean up &
standardise.

Getting nanoMIPS/p32 support submitted upstream is on my to-do list, but
there's a bunch of prep work to get in first & of course that to-do list
is forever growing. Hopefully in the next couple of cycles.

Thanks,
    Paul
