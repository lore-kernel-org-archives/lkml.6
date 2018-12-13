Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3671CC67872
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 20:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4F0220851
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 20:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="Cy/Tnnqq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4F0220851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbeLMUPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 15:15:48 -0500
Received: from mail-eopbgr780119.outbound.protection.outlook.com ([40.107.78.119]:20160
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726355AbeLMUPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 15:15:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OYSJppRypAbfSqsaVGV1DpWHTN0hqm0x7bkPHXNLG/o=;
 b=Cy/TnnqqRknZ+35W78oqUXzZvGZ+wHvx37I6MRKroNPf9NAgS52qZ5j5wwLHVvdCBDOuU4Eg9alB6ampkSB8CBOxy2I2jmI12gtyDqpoQdIbb6/ezKKKFywst1Cw7b2bMQ7ndjORFzwSOtL92ZiYasdXNoDriQcB2UXNH+sZ+CU=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1150.namprd22.prod.outlook.com (10.174.166.39) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Thu, 13 Dec 2018 20:15:41 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::c07a:a95:8ba9:8435]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::c07a:a95:8ba9:8435%7]) with mapi id 15.20.1425.016; Thu, 13 Dec 2018
 20:15:41 +0000
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
Thread-Index: AQHUjSNJ15+cZub/wUiwPpyZjNjVYqV4aUcAgADYI4CAAKuugIAAoKeAgAEsAwCAAK6QgIAAvqMA
Date:   Thu, 13 Dec 2018 20:15:41 +0000
Message-ID: <20181213201540.ae6pxtm2xmrxnaaa@pburton-laptop>
References: <1544073508-13720-1-git-send-email-firoz.khan@linaro.org>
 <1544073508-13720-4-git-send-email-firoz.khan@linaro.org>
 <20181210195144.dvprpyxyddusyb5c@pburton-laptop>
 <CALxhOng7EzAd2zHKAOj3ipEd6y=DpS2JGo34s4V_cWVgmLjPwg@mail.gmail.com>
 <20181211185947.gnaachztyh3ils7o@pburton-laptop>
 <CALxhOngErLD7+CEhgSPwQUnGg7YEFTcH-v6dhR0j55SvEg1FoA@mail.gmail.com>
 <20181212222834.2zf3rb67fxfcmwuw@pburton-laptop>
 <CALxhOnht8H6r38bwm7xqbHuJs6dvLB03GCKyws2cif1mEE+sKA@mail.gmail.com>
In-Reply-To: <CALxhOnht8H6r38bwm7xqbHuJs6dvLB03GCKyws2cif1mEE+sKA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR19CA0067.namprd19.prod.outlook.com
 (2603:10b6:300:94::29) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1150;6:u5yWjmAX2D/hMNyr+AIwkZsveiP6LE2MJON8YGHrIkPyD68bRX1oI1/BhD0u2Sub7zYJFGI7OZkmHs0iR1MRK7bzomXeZAe4RpF7xKpDdYS8PmmGb9TXHeB3QTXDjqB9ov9lPUZaWa12HXE34174rgPOIWsPLrNeoqxw5sNjqSZzaNeqYN99/rsmog+ADlhNneyuunD0bugggJHLjRw55+YtMuyP5VOvSZa3XBbswXJIcXHnu8f+e4x7V2LCJbZ8q1XOy3TWANJqKGtkCsUwQ8OnnnzYp4q5PzmMvizW8lOF9JHnZunMaqeLe6lQhXjaAXLgKF9Yqjd4d5w+uTgYfiTYmpzA/uGQSZ9y3pRePxBgkpNKIQzehQvILQT3PeUJI7Y0nvpZO4+iAcMQwfJdY5+BmE3XcYh9zbi9VehOynVGC8GU6qP/6Ledh2TlC+dt5xpJekwWRf1KZ3xRLxeHxg==;5:qJaIhRXbWustMt05zwIyvF6zL7xG+BDRUo7FWEby0xNfsvkRXIBQmClmMDrp7vNfPxV4WyQUVC1/notXDP+m0cHpUiI+7HM6oGZgnbr4aQt+BLxGMIt5Yo1y4hkWk77K0Bm6LRNyHfgMiZUMzF4O3rZPFuneKROvzwDIHgHjwpI=;7:lp7U7MQL9za4aDghL95SvqHdxqoK+4ddEqlnOkZz+dVP6jmRWYATBOJl930wtNRLwq8b7iE5ZUkqkIDrnF1rBsyWTIa3i5X/hGBf+GK8Pmioyf+7RzIplfcmTbi0vgs32URLk/xQnciuaMPzSNPUjQ==
x-ms-office365-filtering-correlation-id: d8224f74-5472-479c-964b-08d66137c0fb
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1150;
x-ms-traffictypediagnostic: MWHPR2201MB1150:
x-microsoft-antispam-prvs: <MWHPR2201MB115010CE2194C44F78ACB930C1A00@MWHPR2201MB1150.namprd22.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(3231475)(944501520)(52105112)(93006095)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1150;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1150;
x-forefront-prvs: 088552DE73
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(376002)(346002)(366004)(396003)(39840400004)(136003)(199004)(189003)(7416002)(305945005)(44832011)(256004)(14444005)(66066001)(7736002)(25786009)(186003)(81156014)(316002)(53936002)(6512007)(6246003)(54906003)(9686003)(68736007)(8936002)(39060400002)(8676002)(81166006)(6306002)(5660300001)(486006)(102836004)(58126008)(476003)(26005)(42882007)(93886005)(71190400001)(52116002)(76176011)(386003)(6506007)(446003)(2906002)(4326008)(71200400001)(11346002)(97736004)(6916009)(105586002)(14454004)(33896004)(99286004)(1076002)(6116002)(229853002)(966005)(33716001)(6486002)(3846002)(508600001)(6436002)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1150;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: xmad1FMKTQB+y0Ug1BDE0Edxo2sCMptoH7wKVCrgBjfXKFQ1lDzalDtI03PwQoZK9HNWn6oL6Z4VTm436v54tUmOZaEVIPE5XtQQpMP+AVBRiXdIkV03OyLQ8qgviVOlAkHW55VgDTwd7U4JoWV90w/CN6jsnUYTdD1JWdblsSuOqcrUey9Yk0STOtr+zXAem4v4ccpvjYt9Rh8ImbeB5wt+w+xbH3vrfkqNUIhAHcQ0fAcg/9I2HxvAbVF4hkr8mT2UIIn6pztHeCtVQhTc157iiJOyCOe2MTuWbphyqijpOaKIkTq+32cxgMM3cATF
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <49E9E6D96F297A4DB4F2CB168090837C@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8224f74-5472-479c-964b-08d66137c0fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2018 20:15:41.2093
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Firoz,

On Thu, Dec 13, 2018 at 02:23:21PM +0530, Firoz Khan wrote:
> > > So If you confirm I can send v5 without '64' to 'n64' conversion (not=
 just above
> > > one, completely from this patch series). Or uou can take a call just
> > > keep this macro -
> > > _MIPS_SIM_ABI64 as it is and change it rest of the place.
> >
> > Let's just go ahead & leave everything as 64, and I'll do the 64 -> n64
> > rename later. I hoped whilst you were adding n64-specific code this
> > would be an easy change, but at this point let's just prioritize gettin=
g
> > the series applied without the naming change so it can sit in -next for
> > a while before the merge window.
>=20
> I'll keep the macro - _MIPS_SIM_ABI64 same and will not change the rest
> of the patch series. Unfortunately, reverting back to 64 from n64 has lot=
s of
> work.

I've applied v5 but undone the change from __NR_64_* to __NR_N64_*
because it's part of the UAPI & a github code search showed that it's
actually used.

Could you take a look at this branch & check that you're OK with it
before I push it to mips-next?

  git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git test-syscall=
s

  https://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/log/?h=3Dt=
est-syscalls

Thanks,
    Paul
