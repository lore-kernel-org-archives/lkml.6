Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A14B4C43612
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 21:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C42B206A2
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 21:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="OfZRoNrx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730916AbeLPVbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 16:31:38 -0500
Received: from mail-eopbgr760137.outbound.protection.outlook.com ([40.107.76.137]:47040
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727256AbeLPVbi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 16:31:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bhXtwXYbvb8iQtLcfpJ5SElzJptMboXecV1kKbyHV/4=;
 b=OfZRoNrxmoFOIOIZx9171Agh4nPHIHyj4gicmNt8s3+ogpfjjLB+gpZzoX9R8AoVK2T+eMUR2emo/oY7sVVYTCY/tJyc97VCD+/qRcRggF0ZlGuqiOIrYG/bRwDyaQeoQmFqfPuVy7sujuRJZwPwuEKiX3Qc3QD4QfXUQd0opvo=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1551.namprd22.prod.outlook.com (10.174.170.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.20; Sun, 16 Dec 2018 21:31:35 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::c07a:a95:8ba9:8435]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::c07a:a95:8ba9:8435%7]) with mapi id 15.20.1425.021; Sun, 16 Dec 2018
 21:31:35 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Marek Vasut <marex@denx.de>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Burton <pburton@wavecomp.com>,
        Daniel Jedrychowski <avistel@gmail.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Subject: Re: [PATCH] Revert "serial: 8250: Fix clearing FIFOs in RS485 mode
 again"
Thread-Topic: [PATCH] Revert "serial: 8250: Fix clearing FIFOs in RS485 mode
 again"
Thread-Index: AQHUlXtT5YTLq052+E6wpTcC1lM1kqWB0eqAgAAQjYA=
Date:   Sun, 16 Dec 2018 21:31:34 +0000
Message-ID: <20181216213133.kwe24pif3v4wcgwp@pburton-laptop>
References: <20181213174834.kxdy6fphaeoivqgh@pburton-laptop>
 <20181216200833.27928-1-paul.burton@mips.com>
 <f5a76d73-862f-3ebc-cd07-effc5c432103@denx.de>
In-Reply-To: <f5a76d73-862f-3ebc-cd07-effc5c432103@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR05CA0048.namprd05.prod.outlook.com
 (2603:10b6:a03:74::25) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2601:647:4100:4687:84d1:277a:c6e5:ae34]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1551;6:xH2JIR15kOAb6KkV3MvC8QDqpCOtkAd6HGhOdeYCaZaD8Lj5hnNXUUa7wVkgyOA2CFn9YrG8daRjj6LFCZmnMo2hDotscR9pM/Koaxkbdy/mwpvZnUn0qGO1SwIxYFB6Bh5QYjSE/oQMINm93XMifJ8HcIUjl6P4WJGPhvT8ZzKZn9U2VmMww7eIH5ToQ84DT1vt9Jj78zUd9BA4nI9Za/05QXTBO0tKEIeCFExuWLR6p4pYf67EEWWtClLiXpMrCfruk5r3ldoRefoERzeSHaG0a4gwhap6xGiRtYzQPOMtRZgbTgrMUJ4tCGZSI5cbwd5Y5CvQOonUhasWEu6WHsg9bHrsszFx/UFvRDf1re6Qb4Enms2uw4MV6jLod2xsJqpcPECuoMaMAMeqDJrjM2gNKiF4+kvyCvGUpgDwdXkHE1I4UtdJhfdxkZIDXLdNx/Y4uNBoOt5Pg+5ooxeOWg==;5:bLI46w5ytsfuPZbJqSlSnxjQhvaL3TCZoz+ERMPgTGJRLFrrcdNtyfwm5rhxUcBcTixJUuX1D0aQY/CHYOyO51xMckxGmIDpQoA4DzCd6IBNe/AqlcW5TuHMJDkRqwCqrw1a43K8Kqp3OllFlWB+hwQolArcXJ9cuzsw7GSb/TE=;7:C3818yN79nZHNdToSNpz/73dEOzcYu1K/CT3W7m58+Hyx04kTYAiro5JItFwm166Fr7bJ5e3Yffn6KuvYyr06yFSoJGYa47FkQubPL/mYA/9whOeLC/1OzR0gWe96oSWBIPuoGFNYldK3ZxXtShwjg==
x-ms-office365-filtering-correlation-id: e91d015a-acb3-409c-753f-08d6639dda83
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1551;
x-ms-traffictypediagnostic: MWHPR2201MB1551:
x-microsoft-antispam-prvs: <MWHPR2201MB1551F903B3E676E7359AD801C1A30@MWHPR2201MB1551.namprd22.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(5005020)(6040522)(2401047)(8121501046)(3002001)(3231475)(944501520)(52105112)(10201501046)(93006095)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(2016111802025)(20161123562045)(20161123558120)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1551;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1551;
x-forefront-prvs: 0888B1D284
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(136003)(376002)(346002)(396003)(366004)(39830400003)(199004)(189003)(52314003)(81156014)(256004)(6506007)(6436002)(106356001)(7736002)(81166006)(58126008)(14444005)(11346002)(6116002)(8936002)(54906003)(6512007)(316002)(105586002)(6916009)(9686003)(6306002)(25786009)(1076002)(71200400001)(71190400001)(486006)(68736007)(6486002)(446003)(305945005)(14454004)(6246003)(53936002)(39060400002)(4326008)(44832011)(476003)(229853002)(8676002)(186003)(33716001)(966005)(2906002)(5660300001)(102836004)(99286004)(97736004)(42882007)(508600001)(386003)(33896004)(76176011)(52116002)(46003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1551;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: IHQdMDFbMQkH2HzywfbupvJA72co6m3rQYMZ9/vpYxbOjLtJiY0qv+e59CIpUikJ5W0PjP1Q7s+dJ7s/69Plq2viHygTJC6pCj8sxLv4Zgzhe4OwcpbvDLXJDcv0dx3U3fYIfNxgxjeoCvbBp61i8h5Mz5Emd0bpboqgZZ1lVwXiewbittmBsBkkc5IhtkZ1cLfyDrc5FiTrP5QfE42xkeDe1OJEsScBw/84NyefZ7Jx2CryfpqVTuz0t9WR2FiMYeB8PiIbRLhRTt09yPWE8ASYgBHRIpw/h1agctbFZINyqPRfrUcVrPTJ8ZG06KmN
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5BE0F6BB5B7C8A4F9E9B5ACF9E3759B0@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e91d015a-acb3-409c-753f-08d6639dda83
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2018 21:31:34.9379
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1551
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek,

On Sun, Dec 16, 2018 at 09:32:19PM +0100, Marek Vasut wrote:
> I am unable to test it on such a short notice as I'm currently ill, so I
> cannot tell if your change breaks the OMAP3/AM335x boards or not. Given
> that there are very few CI20 boards in use, I'd like to ask you for some
> extra time to investigate this on the OMAP3 too.

I'm sorry to hear that you're ill, but your patch is getting awfully
close to becoming part of a stable kernel release & it causes
regressions. Even if it didn't break a board I use, I think the patch
would be broken & risky for the reasons I outlined in my revert's commit
message.

Ultimately it's Greg's decision but it sounds like you're asking me to
say it's OK to break the JZ4780 in a stable kernel with a patch that I
think would be risky anyway, and I won't do that.

> btw what strikes me as curious is that this patch emerged shortly after
> Ezequiel re-posted the CI20 U-Boot patches after an year-long hiatus, is
> it somehow related ?

Not at all - I regularly test on Ci20 & found this breakage whilst
testing Paul Cercueil's Ingenic TCU patchset v8 [1]. Using a Ci20 with
mainline kernels doesn't rely on Ezequiel's U-Boot work, and indeed I
generally boot using my ci20-usb-boot tool [2] so U-Boot isn't involved
at all.

Now my Ci20 testing isn't automated so it tends to happen mostly when
there are obvious changes to the board or SoC support, but it should
become more automated soon. Kevin Hilman just got a Ci40 working with
kernelci.org infrastructure & I hope we can get Ci20 & other boards
included soon too, either via existing kernelci.org labs or by setting
up a new one.

Thanks,
    Paul

[1] https://lore.kernel.org/linux-mips/20181212220922.18759-1-paul@crapouil=
lou.net/T/#t
[2] https://github.com/paulburton/ci20-tools
