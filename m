Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A4DC43612
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 21:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED5E52082F
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 21:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="V095TpDU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730967AbeLPVjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 16:39:08 -0500
Received: from mail-eopbgr680118.outbound.protection.outlook.com ([40.107.68.118]:46509
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727256AbeLPVjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 16:39:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/6j3t2eEYU/asU1c/jp8JtCw3YCG2KRG4MiVYbDi0I=;
 b=V095TpDUY84hB2qPZU8FNa2SQCxedrX+rVXDQINDCh562AYcm7Tqw3giQ22+tpXXREHR/Vj71lDwV9CY3pjtpW36B+5sdVtXANnW0GLoIHFN0O+Gf9d2t7MOAU09pbXDEqpBPSnvfetuTNTFmQVNKaP5Zm/gIfJ4ZcUm5/+AEkY=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1023.namprd22.prod.outlook.com (10.174.167.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.20; Sun, 16 Dec 2018 21:39:03 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::c07a:a95:8ba9:8435]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::c07a:a95:8ba9:8435%7]) with mapi id 15.20.1425.021; Sun, 16 Dec 2018
 21:39:03 +0000
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
Thread-Index: AQHUlXtT5YTLq052+E6wpTcC1lM1kqWB3BwAgAAIcYA=
Date:   Sun, 16 Dec 2018 21:39:03 +0000
Message-ID: <20181216213901.hpll7wqzhqvfgkfy@pburton-laptop>
References: <20181213174834.kxdy6fphaeoivqgh@pburton-laptop>
 <20181216200833.27928-1-paul.burton@mips.com>
 <93a3c76b-f4ba-57ae-9d80-6e945b4f3181@denx.de>
In-Reply-To: <93a3c76b-f4ba-57ae-9d80-6e945b4f3181@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR02CA0040.namprd02.prod.outlook.com
 (2603:10b6:a03:54::17) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2601:647:4100:4687:84d1:277a:c6e5:ae34]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1023;6:W81VsEaWSOX6LiS+ny8KRP7gmMpNXL3q4d1z0rEdbVVNrMg/oHMH1pxFitBdythp9YSZTTemli/gk6WBOIh7YkulZdpNLcEKxPaaMZ6ytOJsp2z/XVXwXtadkW3oCBiKxYT9bWexQrMqb66yLiMepZhTM3IksVqwHrUzAK+lLx0HJM1zo62jEp/DPWWlBgLiEqMiwxzY7wSu5qtrDBJMnRFokemLIWDe8cCWrE33QeKqSRRevBoBOJSRWLrj4NoJWoVQXd6v4ZDyEPrOHu/p4hKQPJcuD6PSoGA8NPVAP5XycdkJQEZGHWA1TjYtDYewtP7e94gQSIcIuMXoWc3/e3GIX6gmUZguEhF/4LOd4Jvymy3g5QSEShpJFINXKGVg96FLOTjWcLneHQOj38qOd1HLF+AzcwtPqawTqKqsmjDzzrNsp9GdQk8962SGFmJWxeXFlMZVkw3APZsCi5n1EQ==;5:vTfvSP7y/Sv+aPyvuZp4T5j+/mUOA4weIY3tJICWaSMiwsh2EKeB+lGnv9WvAiFHedBT/2o42I4wdzOinlpBi3bXoZf9G4xCzCxI8f6D+zyi632rPq9mRdvNcLttQTKFGbnyNub+oZ+spNdlzONf8hzFKmCA1oAe4yjvDjqylNk=;7:L5/4YU1qK8zXVsBe/m3ldeyXhgw3cy5bVoWOlQ0XndnrPFn1Khz8IadK0E6gkBAxqYHKdkyKM6WtxC0IH1MW41SuHDAie4ZpbplxQGrIGd3Xkq2o+V34oVqVZH91jZzI9gp1JWFzFRywI3jvS90DnQ==
x-ms-office365-filtering-correlation-id: fa365288-fcc6-40fe-5e17-08d6639ee5a6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1023;
x-ms-traffictypediagnostic: MWHPR2201MB1023:
x-microsoft-antispam-prvs: <MWHPR2201MB1023859D8AFDD21B97E64C09C1A30@MWHPR2201MB1023.namprd22.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3231475)(944501520)(52105112)(10201501046)(93006095)(3002001)(148016)(149066)(150057)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1023;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1023;
x-forefront-prvs: 0888B1D284
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(366004)(39830400003)(396003)(346002)(376002)(136003)(199004)(189003)(52116002)(102836004)(76176011)(25786009)(14454004)(966005)(508600001)(9686003)(106356001)(6246003)(6512007)(229853002)(4326008)(53936002)(44832011)(486006)(476003)(71200400001)(71190400001)(2906002)(11346002)(14444005)(446003)(6916009)(6436002)(81166006)(8676002)(316002)(54906003)(6486002)(46003)(256004)(97736004)(99286004)(1076002)(8936002)(6306002)(6116002)(7736002)(68736007)(305945005)(58126008)(105586002)(39060400002)(5660300001)(33716001)(42882007)(33896004)(81156014)(6506007)(386003)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1023;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: CS3DVg1o+O/K5V8jEldGuR4I69waqHZ8177ux/jlewZX7C8vLOKt62GvrIMtEO9+fRH2Z7vgYeNaKI1hh7xnggRdhmR4a4vz+qOIrXeD21gvhNkHV0sWhbC7PmKsHTtNqYh6PQ+DWul/znCux6dm2QcBoloQb4RkaObMTV8LLtoCRvlypGRb0fMRvNvpRMrCd5Kj9t16rvavmk4jUpGt9Bo8VPs7Uo7MBE/4EY3uYEPPl/ZVmDZZS1vGJs4S+DSWA+H3IJRewLA7CnrhI3FKnJhI7V6h12Yv/MxE8censtGkdsidLZVqSNBqV0c7mrS8
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <78701B6ABB489D44860A568B738D665E@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa365288-fcc6-40fe-5e17-08d6639ee5a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2018 21:39:03.2121
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1023
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek,

On Sun, Dec 16, 2018 at 10:08:48PM +0100, Marek Vasut wrote:
> > I did suggest an alternative approach which would rename
> > serial8250_clear_fifos() and split it into 2 variants - one that
> > disables FIFOs & one that does not, then use the latter in
> > __do_stop_tx_rs485():
> >=20
> > https://lore.kernel.org/lkml/20181213014805.77u5dzydo23cm6fq@pburton-la=
ptop/
> >=20
> > However I have no access to the OMAP3 hardware that Marek's patch was
> > attempting to fix & have heard nothing back with regards to him testing
> > that approach, so here's a simple revert that fixes the Ingenic JZ4780.
> >=20
> > I've marked for stable back to v4.10 presuming that this is how far the
> > broken patch may be backported, given that this is where commit
> > 2bed8a8e7072 ("Clearing FIFOs in RS485 emulation mode causes subsequent
> > transmits to break") that it tried to fix was introduced.
>=20
> OK, I tested this on AM335x / OMAP3 and the system is again broken, so
> that's a NAK.

To be clear - what did you test? This revert or the patch linked to
above?

This revert would of course reintroduce your RS485 issue because it just
undoes your change.

Either way, commit f6aa5beb45be ("serial: 8250: Fix clearing FIFOs in
RS485 mode again") breaks systems that worked before it so at this late
stage in the 4.20 cycle a revert would make sense to me. If that breaks
RS85 on OMAP3 then my question would be how much can anyone really care
if nobody noticed since v4.10? And why should that lead to you breaking
the JZ4780 which has been discovered before a stable kernel release
includes the breakage?

Thanks,
    Paul
