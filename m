Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07A2C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 22:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3462206BA
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 22:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="Bnd+68Dl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730968AbeLPW2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 17:28:23 -0500
Received: from mail-eopbgr800110.outbound.protection.outlook.com ([40.107.80.110]:13949
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728203AbeLPW2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 17:28:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QizI+fERciXbVWKscPoX1thdiT+eJ+eJ1XtSGhcEcAY=;
 b=Bnd+68DlAoqtjdrTci0vSn7ZsbKxTVhlvTe/r7MYU08eG43fXaS9FjqKYHSM9dKTC6LomWMlCKqNVUaVFhP2EOuLXRZTqluAv9nzlfd7rTm2kC1efAXCvcNbaAQNOBeYbw+Ft4cPK9Z6dM4I2J+liI+YDpP1ufSN+9TbxhsxyyY=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1502.namprd22.prod.outlook.com (10.174.170.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.20; Sun, 16 Dec 2018 22:28:17 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::c07a:a95:8ba9:8435]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::c07a:a95:8ba9:8435%7]) with mapi id 15.20.1425.021; Sun, 16 Dec 2018
 22:28:17 +0000
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
Thread-Index: AQHUlXtT5YTLq052+E6wpTcC1lM1kqWB3BwAgAAIcYCAAAY6AIAAB4eA
Date:   Sun, 16 Dec 2018 22:28:17 +0000
Message-ID: <20181216222815.4t4xhaiy6rvfaogq@pburton-laptop>
References: <20181213174834.kxdy6fphaeoivqgh@pburton-laptop>
 <20181216200833.27928-1-paul.burton@mips.com>
 <93a3c76b-f4ba-57ae-9d80-6e945b4f3181@denx.de>
 <20181216213901.hpll7wqzhqvfgkfy@pburton-laptop>
 <28a1d4ae-493d-8bbc-46f7-ad41ca04d782@denx.de>
In-Reply-To: <28a1d4ae-493d-8bbc-46f7-ad41ca04d782@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR04CA0002.namprd04.prod.outlook.com
 (2603:10b6:a03:40::15) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2601:647:4100:4687:84d1:277a:c6e5:ae34]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1502;6:RpzBMhmrHQmelgSMZmiVcrozT8f8KyY6moz2+uP0HvgOHAQNOb3REXuzJk2RaowjMuP6w13Y9WoJrQP5lyHvycPEi6HLjbdO5VDE+GdLq0e+4GLw7wMSxGwmlzqaxS1ocnds7k3RUvJJSR7dtGOp4cTg+5aBnnAcMXf5fdxjPGY3sHb/1AM3jvz6FDuD+Nx6YASA+783ljuBgQ02GwrLpbVLcCewMoc4PC3bqsUskNc6ey1VP2QK8K8iVbE/iM0/VJWxdT0Rx3LC78P9bS/jyhr6XBZ0nyAg4YInuv4Pj8eV8mT1vEM1hwHrY3isy7cs4x7hEfUgf882XvtpZ0ClkmaNhfrmCssyUsTi8O5YA/wq/thYaAyQV32MGkf1VrDZj1RnQ7K9J9x+0m8wnReMavMJ9Fn6nHDmkBJRxOFMmZHe0Ow27whm+z+L6nzOuPenadW47TE68KQZ0Fmm7pBpTA==;5:jW68788BbBIox1DtUPvZqhOHYgA/t0+7TA4y62gGqdN6jSuB/WGzyEX6sYv9+D4brNxm8jnt8NppmMgLfB9S8pwTbsE5ymcFT3dVZEpBBO9lJIApZ+1724euCsD5372R5F0xEQKqVKGfe3wDWOkZ8YRIWtDukdDezQ/goW502rg=;7:q+5ThVk8NcePqA64unmstIwsdyKnzstufubrTHj3uGTUXzx60uGxEstv4GybzJ+p/F8KW5a+5BoHAz6L2G8I20QJyJuJVe/ZQtNwhgLORTSC6HLjYfX0+AHBYoqwyIiwYvQ3X+fcGVS27C6GQ4Xm1Q==
x-ms-office365-filtering-correlation-id: a9c4b859-6af6-492f-7643-08d663a5c64d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1502;
x-ms-traffictypediagnostic: MWHPR2201MB1502:
x-microsoft-antispam-prvs: <MWHPR2201MB1502554D97B22BE4D38B06AFC1A30@MWHPR2201MB1502.namprd22.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(5005020)(6040522)(2401047)(8121501046)(3231475)(944501520)(52105112)(93006095)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(20161123562045)(2016111802025)(20161123558120)(20161123564045)(20161123560045)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1502;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1502;
x-forefront-prvs: 0888B1D284
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(39830400003)(366004)(346002)(376002)(396003)(136003)(189003)(199004)(5660300001)(76176011)(2906002)(1076002)(71200400001)(6246003)(39060400002)(6306002)(4326008)(446003)(52116002)(11346002)(68736007)(9686003)(6512007)(186003)(386003)(486006)(53936002)(46003)(102836004)(14444005)(256004)(6506007)(14454004)(508600001)(42882007)(44832011)(476003)(106356001)(33716001)(25786009)(33896004)(54906003)(7736002)(6486002)(6916009)(966005)(8936002)(105586002)(81166006)(81156014)(8676002)(316002)(58126008)(99286004)(305945005)(6436002)(71190400001)(6116002)(229853002)(93886005)(97736004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1502;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ZLGarRAm4wWmacUDdfCHstKy0lQuYccK/WLDdE2jVNdQyyb1Hcc9jihCDkEbjoTJJvj1gp/F6FuvHVtEXpYR/zOHJJRAEFz0ks2PsODQBIzfWUiSE2LwCx1gaTjI4QyoeWreceoIQREq8PWpifxpDofc2tHIRXr6BiAjo7HjP54+bynEj1jYFvQ8114ZErWkir9he4pUlN1/ZPpL4ARcPmVhuT/dMe1j0h5V+OXGCM3WdcKw9upWe7TlOzS92E3TP9RGjFD9VxMj2GgoO46k476GsABGEVu1QHUO1ouO90X248EPKC6UAzSdRg5dBBbH
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DA0C4268FD6E894792F1C2D310A6C236@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9c4b859-6af6-492f-7643-08d663a5c64d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2018 22:28:17.0972
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1502
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek,

On Sun, Dec 16, 2018 at 11:01:18PM +0100, Marek Vasut wrote:
> >>> I did suggest an alternative approach which would rename
> >>> serial8250_clear_fifos() and split it into 2 variants - one that
> >>> disables FIFOs & one that does not, then use the latter in
> >>> __do_stop_tx_rs485():
> >>>
> >>> https://lore.kernel.org/lkml/20181213014805.77u5dzydo23cm6fq@pburton-=
laptop/
> >>>
> >>> However I have no access to the OMAP3 hardware that Marek's patch was
> >>> attempting to fix & have heard nothing back with regards to him testi=
ng
> >>> that approach, so here's a simple revert that fixes the Ingenic JZ478=
0.
> >>>
> >>> I've marked for stable back to v4.10 presuming that this is how far t=
he
> >>> broken patch may be backported, given that this is where commit
> >>> 2bed8a8e7072 ("Clearing FIFOs in RS485 emulation mode causes subseque=
nt
> >>> transmits to break") that it tried to fix was introduced.
> >>
> >> OK, I tested this on AM335x / OMAP3 and the system is again broken, so
> >> that's a NAK.
> >=20
> > To be clear - what did you test? This revert or the patch linked to
> > above?
> >=20
> > This revert would of course reintroduce your RS485 issue because it jus=
t
> > undoes your change.
>=20
> The revert. Which of the two patches do you need me to test.

The one in the email I sent on Thursday 13th at 01:48:06 UTC, linked to
at lore.kernel.org in the quote right above:

https://lore.kernel.org/lkml/20181213014805.77u5dzydo23cm6fq@pburton-laptop=
/

You replied with comments on the patch, you just never tested it or
never told me if you did. The lack of response means I don't know
whether that potential patch even still works for your system, hence the
revert.

Thanks,
    Paul
