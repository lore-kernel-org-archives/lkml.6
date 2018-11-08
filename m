Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982B4ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 18:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3687320684
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 18:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="iuglz0Ei"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3687320684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbeKIEQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 23:16:13 -0500
Received: from mail-eopbgr720108.outbound.protection.outlook.com ([40.107.72.108]:50816
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727099AbeKIEQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 23:16:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+gYm7C181WsjsJPkeWXfwpAjLCCnBEKEHNw07Nlzew=;
 b=iuglz0Ei4NSOr3f8pzmIdjOavJMMMjRKjRM12rovwsYqk5uoEFKGYcu/lQe73zGqWBOGHVyu387JAI/+t7pcuyXJiu9En/wr1PjbjRfOeacPNXHR25ReVmH9GMqjKv/64CPZh34iyW9ArU4Fj6sexnWETy5IRjgUE+2Q36hDV0Q=
Received: from MWHSPR00MB117.namprd22.prod.outlook.com (10.175.52.23) by
 MWHPR2201MB1069.namprd22.prod.outlook.com (10.174.169.143) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Thu, 8 Nov 2018 18:30:16 +0000
Received: from MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045]) by MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045%2]) with mapi id 15.20.1294.034; Thu, 8 Nov 2018
 18:30:16 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Maksym Kokhan <maksym.kokhan@globallogic.com>
CC:     "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "sergei.shtylyov@cogentembedded.com" 
        <sergei.shtylyov@cogentembedded.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Andrii Bordunov <andrew.bordunov@gmail.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mips: delete duplication of BUILTIN_DTB selection
Thread-Topic: [PATCH] mips: delete duplication of BUILTIN_DTB selection
Thread-Index: AQHUWz3bgRsL2oi9cUCrYH81tJ5YT6UOxDmAgAAKoYCAAC/xgIA0FcoAgANXHQA=
Date:   Thu, 8 Nov 2018 18:30:16 +0000
Message-ID: <20181108183014.gjzmquibbjvysui7@pburton-laptop>
References: <1538587415-24126-1-git-send-email-maksym.kokhan@globallogic.com>
 <de95ca86-014d-77f6-6e2b-24f191147487@cogentembedded.com>
 <CAMuHMdWK0CsNsq7Sb8oG4ZvNFS3S1=8O_pUQHrY54KBV7a24FQ@mail.gmail.com>
 <CAMT6-xhP=2wjsKJFumKUsUGVL6U_BynMv6RE0cxXgk6cyfjJkw@mail.gmail.com>
 <CAMT6-xji=XrteXm6KbUYLiKqSH_-RHzXzwn3zi5hYbtq_R_sRg@mail.gmail.com>
In-Reply-To: <CAMT6-xji=XrteXm6KbUYLiKqSH_-RHzXzwn3zi5hYbtq_R_sRg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR1701CA0020.namprd17.prod.outlook.com
 (2603:10b6:301:14::30) To MWHSPR00MB117.namprd22.prod.outlook.com
 (2603:10b6:300:10c::23)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1069;6:Rr6qNhOGX/48t4uxzmWJSy/UqQ7VZKwH3pyNs2d8yU1WD0NsyNvG0R4H2v0DQX33P40esPZt/DBwjwqW+Xu03ujARZCFn2zOQ7jyqNgOmzNaIqffrz7JnnLuxwLn+eKy9PBiHWAbzG7bJMIUyTnR/8xq+GUfcSJ/cg2Sq6Su/7wJjYBHDFzKffR0y+NYgBmsCS5M6g5+RtmWrBpUTuNG8aDVgMTarpTdsqqe5pry3Ffs9lTTgsHZBmHdl/aV++yVG2KZ6wRZo2hMaOwSaFw8DLytVlV9YEOqglq0O5M2/9RF/d16XVpcHuvtLJHjr5FPxaS4x9njsrB7szVhL0Oi12rR8AOoIZ/iOrNoasDztsm7tFzQ6R61isO61oLt0lxVQZbZrlTjRZQtsXb8j+g/NCdobkLVVyKkifEXlAzaOqZ7WYGv6ueilC+ROKzm0CjYYx0Khw2bZ8+UHwkqom+6CA==;5:bSRGABxqXfHc3g/JwMgE2wvsqoAAO/D7JDZRHJWYV5UexiN3ZdXsyBfOXwCYdI3rNdSLmmadJUZ+sU0OgBUc66Tsqpdlpv/JAEL5PMvLPNEEaM0E9WR3NpnYoddHmaxCmaX73AMmXzQQIZC96nQpnZMlfHnL1M9gdBL83qAKxvU=;7:2LifET/MYrsV9jb1+bBbF7TC/iSckufkfp+O0KNLE++LR7WPczNMzSViK1mzrRmoRYxToGNkV/yLFCbbJZ0da45bMp+qbNZOs+AU09BnUBtDozhXAPz+Ylzluzmdv40ThwnryyQJ4mLipMQY3WhdvA==
x-ms-office365-filtering-correlation-id: d7befda2-aa87-401e-cf9e-08d645a83a59
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1069;
x-ms-traffictypediagnostic: MWHPR2201MB1069:
x-microsoft-antispam-prvs: <MWHPR2201MB106951F54537520A2DD5B5C6C1C50@MWHPR2201MB1069.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231382)(944501410)(52105095)(10201501046)(93006095)(148016)(149066)(150057)(6041310)(2016111802025)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1069;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1069;
x-forefront-prvs: 0850800A29
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(39840400004)(136003)(396003)(346002)(376002)(366004)(189003)(199004)(71190400001)(71200400001)(105586002)(3846002)(99286004)(52116002)(33896004)(76176011)(6116002)(26005)(229853002)(186003)(6486002)(1076002)(6506007)(106356001)(256004)(14444005)(102836004)(386003)(2906002)(39060400002)(66066001)(81166006)(8936002)(93886005)(8676002)(4326008)(2900100001)(5660300001)(42882007)(81156014)(486006)(6246003)(476003)(11346002)(44832011)(7736002)(446003)(33716001)(305945005)(9686003)(6512007)(316002)(54906003)(53936002)(97736004)(58126008)(6916009)(14454004)(25786009)(6436002)(68736007)(508600001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1069;H:MWHSPR00MB117.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: EwJjpcQqFY3blrFpxBpD0cGH3S5DYxZUGKKqMifMH6ma4x7i1JVFtZJhgs3E3VhJLkEfsEQXgPw6/MKExHqxJNtnJuRDZ6b2Mit24XSjnznXtGLeYBzDNjsoEbqP2qFfnXLi5Ml1g4dIS7M4kD5+EMHeFPDCBSvHMo531+QnQnmHUX8BihZyVHWHStT1niWt/6v3NoAOGZRyuXeVp/mbt/rKzGPKkN48/M+f2kwI95f+kmn0AhnhoruC6FHLL37/xa65RngH7Uehju/EpiBl9HGfI5HuRT5/PVCcfISHFvuodHkBzFh8iF1iEgjIbQZl4QqN9E258usNUSGllf3nMCD0n4tHV/bw6GX2quHF+ls=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <66C803BA24E8F3479DEF13F6043ACF75@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7befda2-aa87-401e-cf9e-08d645a83a59
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2018 18:30:16.4818
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1069
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maksym,

On Tue, Nov 06, 2018 at 05:29:40PM +0200, Maksym Kokhan wrote:
> > > > > diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> > > > > index 3551199..71d6549 100644
> > > > > --- a/arch/mips/Kconfig
> > > > > +++ b/arch/mips/Kconfig
> > > > > @@ -539,7 +539,6 @@ config MIPS_MALTA
> > > > >       select USE_OF
> > > > >       select LIBFDT
> > > > >       select ZONE_DMA32 if 64BIT
> > > > > -     select BUILTIN_DTB
> > > > >       select LIBFDT
> > > >
> > > >     LIBFDT seems duplicated too.
> > >
> > > Using random sort order doesn't help. Keep them sorted, please?
> >
> > We are going to deal with it in the separate patch.
>=20
> Is it OK to leave this patch as it is and make another patch/patches
> for other changes or it would be better to modify it to remove
> duplication of LIBFDT too and sort this list of configs?

My preference would be that you remove all the duplicates as one patch,
then sort the selects alphabetically in a second patch. That should be
granular enough to make it easy to review, but not so fine-grained that
it becomes annoying.

Thanks,
    Paul
