Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B7FC43444
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3C00206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="X8yib86d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730939AbfAJSLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 13:11:13 -0500
Received: from mail-eopbgr740139.outbound.protection.outlook.com ([40.107.74.139]:35568
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729882AbfAJSLN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 13:11:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zu1/m0VA3LLtJOeXZRfOfxu9hfV2NiNOraPGhsVGou8=;
 b=X8yib86d55NaL2DvIVAynu5uGEsuyCxfth0hk+c+TrGCxx9BK/PA0+JYG4Yrj4N8aPUM9J0HjhvakF9udNZFkDbS60YqgD7ygEIQwoau6R1zyFqJrgN0IUEcHnvITo2KR+733EZCU664Ff/UJ4bdTV7AHcwlYlzBozg+hwhCpNk=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1312.namprd22.prod.outlook.com (10.174.162.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Thu, 10 Jan 2019 18:11:08 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::595e:ffcc:435b:9110]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::595e:ffcc:435b:9110%4]) with mapi id 15.20.1516.015; Thu, 10 Jan 2019
 18:11:08 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
CC:     "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Burton <pburton@wavecomp.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] kbuild: Disable LD_DEAD_CODE_DATA_ELIMINATION with ftrace
 & GCC <= 4.7
Thread-Topic: [PATCH] kbuild: Disable LD_DEAD_CODE_DATA_ELIMINATION with
 ftrace & GCC <= 4.7
Thread-Index: AQHUqHFXHrragMJ1IkS80PCtgAJbBqWnv7qAgAEPGAA=
Date:   Thu, 10 Jan 2019 18:11:07 +0000
Message-ID: <20190110181106.otlwmiznvq2l67iv@pburton-laptop>
References: <CAMuHMdUw9LMVb-8RSNVBEcDMVB9SFOdfF+kb20=gxJiWF1x8sQ@mail.gmail.com>
 <20190109231539.24613-1-paul.burton@mips.com>
 <CAK7LNAReiEzF1nS8WR_yUmi-boJnfLWw5bjUvL2rDEAYnxwCzw@mail.gmail.com>
In-Reply-To: <CAK7LNAReiEzF1nS8WR_yUmi-boJnfLWw5bjUvL2rDEAYnxwCzw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR11CA0037.namprd11.prod.outlook.com
 (2603:10b6:a03:80::14) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1312;6:VwWBH3TQW6hTKJzJLI2skRvoEub393GDxCJNyBQelal3BVEOM+9dplpldTLX6rmnEovtNVIGhAyCJ4M43h1SxYlyATHCx4JwU2t6ci5ceM4uupXg87H4XDPWOg1ibIeWA66mjJb4XnHkIvtax/jbh1Z0wZizi4BARDT1+8RCFQK5+MjBlR8JgWuXOZlnGwzADSmA0o8A/PbEGNQgad/S1BQS6v5zF8PBZyFx0736DqZRkLxXW+psGuzoJsyUgJIKKAdj+1zrE/EzccIyPWxoLaCZcqaYoKTlCEvRCpwhzPG55YrkNvryhvJ0ttIirDl1nNE7qgjbpYq1QCjdOfX4xjbEULXd29i+VVYNvUYsJiRd0PSu7TMTMKQrzjAfquuBx7qlv3YfR1/d9JHl0vsmwZXbu9njtgRERq1Kakhl+fxeUt/0sNSXRQupbwyA4nLVFPkPYx7wre2IAZMG4GxUEQ==;5:I1V/gMYC8UFhI5RvKlrpo19/WVGAnzun1Ml/TSXkc8KQLEY7CYpKReqJIXpbcPq10qkT1EYAAFKsKIPuISoEFQMuUl/kGe2z94/ao8KIKQqhj7+8ZQiOmVu5TMu4ScAbWO0fFfOOk+5Hiq+N72TkUfAuLU0WALdLgTGXStdey0b+kyaTpZtW+HqDJFixkd60py73NvggYC7znyEQ/vvMsQ==;7:lzrIr3MqD1tPG7O9r2eSxTcO4qlqX9gfP6zbinNCMGNaRXcswfhijOiakX+ufegh3ngoJKg4Vkf2kQAESdabN+vEu3L0MiNo5Djsqd0I1gpeSfv8ByYgAGNVE4VzsLFF4c8KHsSqAcf/6Bm2TSf9ZA==
x-ms-office365-filtering-correlation-id: a12f1282-470f-459e-198d-08d67726fe2b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1312;
x-ms-traffictypediagnostic: MWHPR2201MB1312:
x-microsoft-antispam-prvs: <MWHPR2201MB1312FC978E56B4AC9EB62787C1840@MWHPR2201MB1312.namprd22.prod.outlook.com>
x-forefront-prvs: 0913EA1D60
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(136003)(39840400004)(366004)(376002)(346002)(396003)(189003)(199004)(51914003)(33716001)(229853002)(9686003)(6512007)(6486002)(66066001)(6436002)(68736007)(1076003)(14454004)(478600001)(97736004)(106356001)(105586002)(25786009)(26005)(42882007)(6246003)(2906002)(5660300001)(4326008)(476003)(8936002)(11346002)(446003)(6506007)(53546011)(81156014)(305945005)(81166006)(6916009)(316002)(54906003)(8676002)(7736002)(33896004)(386003)(102836004)(76176011)(99286004)(52116002)(14444005)(256004)(58126008)(44832011)(53936002)(6116002)(3846002)(486006)(39060400002)(71200400001)(186003)(71190400001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1312;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Mq3V7kC4OY6lg1dxcxqUH6h8cygffIomNMAiJc8Zys/oKYuQ44OXBXC1VNIgheLMG2JF0ZS3v7hLqpjSkdMULIxfTQcKCeBhcDSLsUkeCFm4/vpGqqyX2dMzm9PcXtvBKIXhjh55rd9F6zWPTxzYwG36wI/rwSLUfkq8sSGV2j/U350OmIIMd85kfBiSPWs9bZfbBoWaRSDS7MQzQX5YD0pFsUZDixdW78bTajv07JWZqDTiTrBF0tIc5BWlTL9lmRlmX0lRyx4oZrYlzpHQDka9078XsjHgG4sAUpDWYqeArzWlzb8oBHz6KTOSRrqf7bsiqKEJOp2VSSs0QR2WGiqPNIzRGGXSruGWFArRPJDjUM7fvLlhVxt3sf5in/T+jeHMaG1Xk4c8mRbjf5x5w0Ye6u5l3v1bIJni/8HN+MqRPp+9SzpkEM59VGx4HRogsaIXcThrRaz/bofksK8ReA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <62C085429D23EA4CB13A8E6912BAE915@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a12f1282-470f-459e-198d-08d67726fe2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2019 18:11:07.8966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1312
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

On Thu, Jan 10, 2019 at 11:00:49AM +0900, Masahiro Yamada wrote:
> On Thu, Jan 10, 2019 at 8:16 AM Paul Burton <paul.burton@mips.com> wrote:
> > When building using GCC 4.7 or older, -ffunction-sections & the -pg fla=
g
> > used by ftrace are incompatible. This causes warnings or build failures
> > (where -Werror applies) such as the following:
> >
> >   arch/mips/generic/init.c:
> >     error: -ffunction-sections disabled; it makes profiling impossible
> >
> > This used to be taken into account by the ordering of calls to cc-optio=
n
> > from within the top-level Makefile, which was introduced by commit
> > 90ad4052e85c ("kbuild: avoid conflict between -ffunction-sections and
> > -pg on gcc-4.7"). Unfortunately this was broken when the
> > CONFIG_LD_DEAD_CODE_DATA_ELIMINATION cc-option check was moved to
> > Kconfig in commit e85d1d65cd8a ("kbuild: test dead code/data eliminatio=
n
> > support in Kconfig"), because the flags used by this check no longer
> > include -pg.
> >
> > Fix this by not allowing CONFIG_LD_DEAD_CODE_DATA_ELIMINATION to be
> > enabled at the same time as ftrace/CONFIG_FUNCTION_TRACER when building
> > using GCC 4.7 or older.
> >
> > Signed-off-by: Paul Burton <paul.burton@mips.com>
> > Fixes: e85d1d65cd8a ("kbuild: test dead code/data elimination support i=
n Kconfig")
> > Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> > Cc: Nicholas Piggin <npiggin@gmail.com>
> > Cc: stable@vger.kernel.org # v4.19+
> > ---
> >  init/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/init/Kconfig b/init/Kconfig
> > index d47cb77a220e..c787f782148d 100644
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -1124,6 +1124,7 @@ config LD_DEAD_CODE_DATA_ELIMINATION
> >         bool "Dead code and data elimination (EXPERIMENTAL)"
> >         depends on HAVE_LD_DEAD_CODE_DATA_ELIMINATION
> >         depends on EXPERT
> > +       depends on !FUNCTION_TRACER || !CC_IS_GCC || GCC_VERSION >=3D 4=
0800
> >         depends on $(cc-option,-ffunction-sections -fdata-sections)
> >         depends on $(ld-option,--gc-sections)
> >         help
>=20
> Thanks for the fix.
>=20
> I prefer this explicit 'depends on'.
>=20
> Relying on the order of $(call cc-option, ...) in Makefile is fragile.
>=20
> We raise the compiler minimum version from time to time.
> So, this 'depends on' will eventually go away in the future.
>=20
> BTW, which one do you think more readable?
>=20
> depends on !FUNCTION_TRACER || !CC_IS_GCC || GCC_VERSION >=3D 40800
>=20
>     OR
>=20
> depends on !(FUNCTION_TRACER && CC_IS_GCC && GCC_VERSION < 40800)

Thanks - yes I agree it's nice that this is more explicit than the
ordering we previously relied upon.

I personally don't mind either of the 2 options above - let me know if
you'd like me to submit a v2 using your second option.

Thanks,
    Paul
