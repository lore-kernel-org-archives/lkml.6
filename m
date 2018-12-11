Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C3DC6783B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0479A20880
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="GTNP++FE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0479A20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbeLKS7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 13:59:55 -0500
Received: from mail-eopbgr820097.outbound.protection.outlook.com ([40.107.82.97]:19021
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726329AbeLKS7y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 13:59:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lWdxF8KHzlLQaJz9X7sFtS/aX8RjE9rd56u1Ow4lPXk=;
 b=GTNP++FEZNd1Yo3HTaaxKczkLX9jGF0wFuMQCxhwiv6EJFiIVZTo5h5oLccxE7fTax+Q2ujiIsGSgxExKlUuJsAtPKCGXK2pntw7IShFjpfI78uY8Tg455Gb1y58WyIfI8hj+irkphp+e7hG0rf8c6t6zBolE7CQCqW3c22GXvA=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1262.namprd22.prod.outlook.com (10.174.162.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.18; Tue, 11 Dec 2018 18:59:50 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::2d92:328e:af42:2985]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::2d92:328e:af42:2985%4]) with mapi id 15.20.1404.026; Tue, 11 Dec 2018
 18:59:50 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Firoz Khan <firoz.khan@linaro.org>
CC:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Subject: Re: [PATCH v4 3/7] mips: rename macros and files from '64' to 'n64'
Thread-Topic: [PATCH v4 3/7] mips: rename macros and files from '64' to 'n64'
Thread-Index: AQHUjSNJ15+cZub/wUiwPpyZjNjVYqV4aUcAgADYI4CAAKuugA==
Date:   Tue, 11 Dec 2018 18:59:49 +0000
Message-ID: <20181211185947.gnaachztyh3ils7o@pburton-laptop>
References: <1544073508-13720-1-git-send-email-firoz.khan@linaro.org>
 <1544073508-13720-4-git-send-email-firoz.khan@linaro.org>
 <20181210195144.dvprpyxyddusyb5c@pburton-laptop>
 <CALxhOng7EzAd2zHKAOj3ipEd6y=DpS2JGo34s4V_cWVgmLjPwg@mail.gmail.com>
In-Reply-To: <CALxhOng7EzAd2zHKAOj3ipEd6y=DpS2JGo34s4V_cWVgmLjPwg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR21CA0070.namprd21.prod.outlook.com
 (2603:10b6:300:db::32) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1262;6:7EXaCOX7Xz+pzPUj/2rlmKsEook19ORHnm1oEQ8E6tgy0HfkkeFWW3MMUIODAZv+4q6ntjRM1c88ftgRnDXP+Vee7kjsWYCUudkuD8G14LsR6Sv6W+CllkMQYDOiXOPz0LHerx0jsRrnxAvOu85MMD9gnOR/D03I8IvFjpSvGEDnxGMhgOGJfL4qOUJTYXTfPGDZp3XxU+lzDFbT2y8BMxMgY3n7Ik+Snhakg8UIaE+1Wd7fqhtUj3O5Ad213Rugaqs7X7uiCgT4AQWDodN9PK6u8L2ovCPdbOIODdZ9UkB7wqXj+M2hf00rVNAvzFVe6C0CxdYHKygztP1a3mgPMuCbvXhLLhl/D8eujWNstbMzGIRU4P9vyE1XZGpfeIiGcI3M+mtTxSMLGaY15q5PVfiOL56jPwBS8GbfurXAOxXT0j07E1BwLn6J3dOQ6KL2HMyYR0q8BFrhHRlf8471ag==;5:3NrDODHGH5aw1xUF2X1P/xV7n2EHQABo1SOGhDp5EIxDhquVNfoYBlWPtDY9fErUZZ/FZa9s5w1FGzQr6utpCOzfs89+nHvQ8esMM1GLY9gzbx+HZIuY3CX2AcyfTXX8RiZYBOuLrPhFKGCnYuq3ft9mpK2S0gIEHc648K20nao=;7:YwQ/cUt2LLXPJxT8iRNfTfw3jy5H4wAJ1FiXkcmpbhWW4OMwo6tqN7fPJVI0R44zxPgfPlv1Oil68wvRcIoVj59zKzYg0zKYvXQkCcnBcPXIH9sNMkv2fw6E0QHEeNLbAeCrphHldfC3r0IK7BU/7w==
x-ms-office365-filtering-correlation-id: 9a365f1c-94ba-4e4b-b3fa-08d65f9ad35c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1262;
x-ms-traffictypediagnostic: MWHPR2201MB1262:
x-microsoft-antispam-prvs: <MWHPR2201MB1262B0004FEC1B0B474629AEC1A60@MWHPR2201MB1262.namprd22.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230017)(999002)(6040522)(2401047)(5005006)(8121501046)(93006095)(10201501046)(3002001)(3231472)(944501520)(52105112)(148016)(149066)(150057)(6041310)(20161123560045)(2016111802025)(20161123562045)(20161123558120)(20161123564045)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1262;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1262;
x-forefront-prvs: 08831F51DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(346002)(136003)(376002)(366004)(396003)(39840400004)(189003)(199004)(102836004)(6486002)(386003)(6506007)(93886005)(316002)(186003)(8936002)(6436002)(26005)(8676002)(229853002)(76176011)(7416002)(81166006)(52116002)(81156014)(33896004)(25786009)(305945005)(7736002)(58126008)(14454004)(68736007)(54906003)(99286004)(508600001)(42882007)(66066001)(2906002)(53936002)(446003)(39060400002)(11346002)(33716001)(6246003)(256004)(476003)(44832011)(6916009)(486006)(5660300001)(3846002)(105586002)(6116002)(106356001)(97736004)(4326008)(71200400001)(71190400001)(1076002)(6512007)(9686003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1262;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: efR2LZ0HlyLw+dH95J1A1QnJVJblyYScAyCd03beRcmhOMAL+UNESlu+XztYjtynctuc8dEXYzKtyy61+RrOZv/zdoK56he6U1FbiEvknwBn5NUOMTih/CRUb2zQD2eGo4x97UlSRMuW36qjOo85Ve9uLHwhoJc3EUiPg9OnrAAbwGw2IR+5gZT8qIghq0ELbRxkLJbWaARg9B8K2+zm9olvRBrD7Z38DSMr27rdjaEZEpk+DuIGyIT7f4j1V5q0nrKii1wp8XLkz3x0ip5ifyKswmY65/ddBQQZdQ6Uf6ShdujRTSrLCcAd8vbatbEg
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B559AA0ECC8F3A43A0A5597C9EC3422C@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a365f1c-94ba-4e4b-b3fa-08d65f9ad35c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2018 18:59:49.8927
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1262
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Firoz,

On Tue, Dec 11, 2018 at 02:15:19PM +0530, Firoz Khan wrote:
> > > diff --git a/arch/mips/include/uapi/asm/sgidefs.h b/arch/mips/include=
/uapi/asm/sgidefs.h
> > > index 26143e3..0364eec 100644
> > > --- a/arch/mips/include/uapi/asm/sgidefs.h
> > > +++ b/arch/mips/include/uapi/asm/sgidefs.h
> > > @@ -40,6 +40,6 @@
> > >   */
> > >  #define _MIPS_SIM_ABI32              1
> > >  #define _MIPS_SIM_NABI32     2
> > > -#define _MIPS_SIM_ABI64              3
> > > +#define _MIPS_SIM_ABIN64     3
> >
> > Whilst I agree with changing our own definitions & filenames to use n64=
,
> > this macro actually reflects naming used by the toolchain. ie:
> >
> >     $ mips-linux-gcc -mips64 -mabi=3D64 -dM -E - </dev/null | grep ABI6=
4
> >     #define _ABI64 3
> >     #define _MIPS_SIM _ABI64
> >
> > Our macro here is used to compare against _MIPS_SIM provided by the
> > toolchain, so for consistency I think we should keep the same name for
> > the macro that the toolchain uses.
>=20
> Will this below change will help?
>=20
>  #define _MIPS_SIM_ABI32              1
>  #define _MIPS_SIM_NABI32            2
>  #define _MIPS_SIM_ABI64              3
> +#define _MIPS_SIM_ABIN64           _MIPS_SIM_ABI64

Hmm, I think I'd prefer that we just keep using _MIPS_SIM_ABI64.

Side note - this snippet of code shows another inconsistency... we have
_MIPS_SIM_NABI32 whilst the toolchain uses _ABIN32... No need to worry
about that here though. In short let's leave _MIPS_SIM_* alone in this
series.

Thanks,
    Paul
