Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 626C3C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2090B20672
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:28:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2090B20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbeLLW2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 17:28:39 -0500
Received: from mail-eopbgr730111.outbound.protection.outlook.com ([40.107.73.111]:46208
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726983AbeLLW2j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 17:28:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+TepAXeOfcMJiJ4xmHWm+2RZby95nAxT7mYQlU05dcI=;
 b=Qx5m5HttBg60VIguyJi0Irh9UCcjlSKQaDY6+NC5A0W3Ctn8bS7dDa4ZQWm+M/4vWxcOXCs1Nd1G86RmPKc/1dZK+5WdXoNJoR+aarL4FfbehXrHH5e2tQRqpRt9bPETVgdHK1yGhCiPxUNBm7olj2Naf06qcpXNyZpDUlS6948=
Received: from CY4PR2201MB1272.namprd22.prod.outlook.com (10.171.216.146) by
 CY4PR2201MB1272.namprd22.prod.outlook.com (10.171.216.146) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.19; Wed, 12 Dec 2018 22:28:35 +0000
Received: from CY4PR2201MB1272.namprd22.prod.outlook.com
 ([fe80::e8df:d0e6:2ff4:3936]) by CY4PR2201MB1272.namprd22.prod.outlook.com
 ([fe80::e8df:d0e6:2ff4:3936%4]) with mapi id 15.20.1404.026; Wed, 12 Dec 2018
 22:28:35 +0000
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
Thread-Index: AQHUjSNJ15+cZub/wUiwPpyZjNjVYqV4aUcAgADYI4CAAKuugIAAoKeAgAEsAwA=
Date:   Wed, 12 Dec 2018 22:28:35 +0000
Message-ID: <20181212222834.2zf3rb67fxfcmwuw@pburton-laptop>
References: <1544073508-13720-1-git-send-email-firoz.khan@linaro.org>
 <1544073508-13720-4-git-send-email-firoz.khan@linaro.org>
 <20181210195144.dvprpyxyddusyb5c@pburton-laptop>
 <CALxhOng7EzAd2zHKAOj3ipEd6y=DpS2JGo34s4V_cWVgmLjPwg@mail.gmail.com>
 <20181211185947.gnaachztyh3ils7o@pburton-laptop>
 <CALxhOngErLD7+CEhgSPwQUnGg7YEFTcH-v6dhR0j55SvEg1FoA@mail.gmail.com>
In-Reply-To: <CALxhOngErLD7+CEhgSPwQUnGg7YEFTcH-v6dhR0j55SvEg1FoA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR15CA0046.namprd15.prod.outlook.com
 (2603:10b6:300:ad::32) To CY4PR2201MB1272.namprd22.prod.outlook.com
 (2603:10b6:910:61::18)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR2201MB1272;6:wJM3jE8tRY3knfLh1jP9Mmne2X8xh/3MtR/t/vwStsF9O4gOZWwI8Y4/NMeVntVTOtE9v7GQAvY0l1VVu0epZlK5XrhdZ3bgKgAHlwjZuXtQROsqaf3WKYw939fjs6JU8RKpy4gQ4eZrUruc7Cz3pbkE7kIwMCu33kmLTDsEVY0H6XrHjFUOboP8MsfN4mlXXJ++yokkJNE8UcZhpC25c3ML0n0o+jm1v4csGMgigk00LR5hHhq6hXuimuCxrzz/GK1sH59wkliJmejI82yp+uXsOZj9GjG/ycKa/pWYWYKhWt3gycoo3zHH2kKs8C9BV3XTK7egUJaard9FqVMXuJREZIOGF+4cX4HOrjCrxbGbzF7uLRHDPO5OsU6ZiuAlGRnXEecHHKjDn6XuM1tfiKJbRGDU+mR2IkgkOANuddE3sTk8P1CpBwSEeAidVqY4zLNHMrvACXsWEod/wKDOhw==;5:gGNf0PMfJq6dr696DJtALlGtm4bNuBj68etvRxfnybctEYrBXDr6xO2zqGQ5nDzPqXLPjnp0ugNcL9XZLwvp5JQ0TpngSRL+NieVHHz3z4MOiyWMOm0FkAAxyCStpRjKp2lWs0e+fzZjG226AYFS/UR2Pcg2AWWaTVs5AFM7Jr8=;7:kb/XMVYyL6uopgNsTH8hlTUOVMRWBW2oOTxOMsrLm/VSYv0/gR7tF6F4YliwOIhX7Dqoa5NTMLkwoq8P2OImoymiQsgSTdmHjeeL1ntWRGlEOEZEF875gfvHHsP3hQOwbO96Q4BhT6LaHs1n7lpK7A==
x-ms-office365-filtering-correlation-id: 1c88e2b2-a690-4c73-0cb3-08d6608127bf
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CY4PR2201MB1272;
x-ms-traffictypediagnostic: CY4PR2201MB1272:
x-microsoft-antispam-prvs: <CY4PR2201MB1272E245142C72F577CDDD61C1A70@CY4PR2201MB1272.namprd22.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230020)(999002)(6040522)(2401047)(5005006)(8121501046)(93006095)(3002001)(3231475)(944501520)(52105112)(10201501046)(148016)(149066)(150057)(6041310)(20161123564045)(2016111802025)(20161123560045)(20161123562045)(20161123558120)(6043046)(201708071742011)(7699051)(76991095);SRVR:CY4PR2201MB1272;BCL:0;PCL:0;RULEID:;SRVR:CY4PR2201MB1272;
x-forefront-prvs: 0884AAA693
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(136003)(346002)(376002)(396003)(39850400004)(366004)(199004)(189003)(69234005)(7416002)(71190400001)(6916009)(6246003)(14444005)(81166006)(186003)(8936002)(486006)(105586002)(44832011)(26005)(256004)(6116002)(102836004)(53936002)(476003)(68736007)(3846002)(229853002)(1076002)(39060400002)(81156014)(6512007)(8676002)(99286004)(5660300001)(33716001)(71200400001)(25786009)(76176011)(4326008)(7736002)(106356001)(305945005)(97736004)(446003)(2906002)(9686003)(66066001)(33896004)(6436002)(42882007)(14454004)(58126008)(386003)(11346002)(6506007)(508600001)(6486002)(93886005)(316002)(52116002)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR2201MB1272;H:CY4PR2201MB1272.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: X9CJqHmaN/Evb3EHxxNc3vj7HgKLbybdImbQhG8Az40b/tVCT9x95I3n/xFnto138GLE+Fix3WunaaeBh8ute8f67H3uTqS79z7cOrUFKvEd3IJtDD0Y71SvCa+SDN0vq/V48yO1D4K4Ift/YCTp09w7cVw9w+tfJpzWS4on58q7WYlSR9b8qausJZtfJUsxil63KGwpleQtj8u5alN1vUm1q1HeaKnRgQaWqUOU1Q15JPNWAFyziiUw1YPXhtfShAtQKI48Zg8tY9AsIYZ3s/HJCufIz8oZSGnq6YE0Nj4luDjGIEi9RnUWDWrQo8y1
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0EE10DEB37FD5141B5FE9B65B9446384@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c88e2b2-a690-4c73-0cb3-08d6608127bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2018 22:28:35.7446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR2201MB1272
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Firoz,

On Wed, Dec 12, 2018 at 10:04:47AM +0530, Firoz Khan wrote:
> > > Will this below change will help?
> > >
> > >  #define _MIPS_SIM_ABI32              1
> > >  #define _MIPS_SIM_NABI32            2
> > >  #define _MIPS_SIM_ABI64              3
> > > +#define _MIPS_SIM_ABIN64           _MIPS_SIM_ABI64
> >
> > Hmm, I think I'd prefer that we just keep using _MIPS_SIM_ABI64.
>=20
> Sure, I think '64' to 'n64' conversion must be remove it from this patch
> series.I can send v5 without '64' to 'n64' conversion.
>=20
> If we rename '64' to 'n64' in half of the place and this _MIPS_SIM_ABI64
> if we half to keep it in same looks not good (according to me).
>=20
> (FYI, This macro name - _MIPS_SIM_ABIN64 must be _MIPS_SIM_NABI64
> and defintion will be:
> +#define _MIPS_SIM_NABI64           _MIPS_SIM_ABI64)
>=20
> So If you confirm I can send v5 without '64' to 'n64' conversion (not jus=
t above
> one, completely from this patch series). Or uou can take a call just
> keep this macro -
> _MIPS_SIM_ABI64 as it is and change it rest of the place.

Let's just go ahead & leave everything as 64, and I'll do the 64 -> n64
rename later. I hoped whilst you were adding n64-specific code this
would be an easy change, but at this point let's just prioritize getting
the series applied without the naming change so it can sit in -next for
a while before the merge window.

Thanks,
    Paul
