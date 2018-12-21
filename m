Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11FBBC43612
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 21:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE07C21929
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 21:09:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="DpkNb6lc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391965AbeLUVJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 16:09:15 -0500
Received: from mail-eopbgr760132.outbound.protection.outlook.com ([40.107.76.132]:34067
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388154AbeLUVJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 16:09:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aipltux6pkM0tJlvbDmp7vIX/wgF3iSrkQhRStBm8YQ=;
 b=DpkNb6lcO/fl0O8ji9flKBL3QktH9NmEOGN6qQhFIHnQDNp+tpNGs5RWo7O804FZNHdAYZAv1r1l41/hHn8V4YUXRdCHKBUiBEmbqeW69pCTFfTISISLqPrqY8HA+u8WChIT0elNIBMsjiXq8tTzKr5+tTq+h0sb7uAMg+gKY5w=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1040.namprd22.prod.outlook.com (10.174.169.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.19; Fri, 21 Dec 2018 21:08:30 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::c07a:a95:8ba9:8435]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::c07a:a95:8ba9:8435%9]) with mapi id 15.20.1446.020; Fri, 21 Dec 2018
 21:08:30 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Marek Vasut <marex@denx.de>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Burton <pburton@wavecomp.com>,
        Daniel Jedrychowski <avistel@gmail.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: Re: [PATCH] Revert "serial: 8250: Fix clearing FIFOs in RS485 mode
 again"
Thread-Topic: [PATCH] Revert "serial: 8250: Fix clearing FIFOs in RS485 mode
 again"
Thread-Index: AQHUlXtT5YTLq052+E6wpTcC1lM1kqWB3BwAgAAIcYCAAAY6AIAAB4eAgAe0mwCAABC3AA==
Date:   Fri, 21 Dec 2018 21:08:30 +0000
Message-ID: <20181221210818.g3kbv7bnr577dane@pburton-laptop>
References: <20181213174834.kxdy6fphaeoivqgh@pburton-laptop>
 <20181216200833.27928-1-paul.burton@mips.com>
 <93a3c76b-f4ba-57ae-9d80-6e945b4f3181@denx.de>
 <20181216213901.hpll7wqzhqvfgkfy@pburton-laptop>
 <28a1d4ae-493d-8bbc-46f7-ad41ca04d782@denx.de>
 <20181216222815.4t4xhaiy6rvfaogq@pburton-laptop>
 <78839e8c-0278-6060-0dd2-a84a19258a8a@denx.de>
In-Reply-To: <78839e8c-0278-6060-0dd2-a84a19258a8a@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CWLP265CA0297.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:5d::21) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.197.89.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1040;6:CXgqKOLvT9GoA4hu5bnxb+uUmyLe4eSN0rCerjsecF2GdWbYzOlaBF/4OT5hHlYgkA1yfDYwZTBIMQEYMecgdV98lXorLoBFCtxMo3IJASPJWXTspYwKFmxQ+v4OQkq/7Kxgn4ob7XBMHUJ/ptJzvLDCm0vupgCglndGXt38l9AGDqIs2A8uV3ootZz2C+ooZwmteppUCxZnNdmS/bX5T3SNFDj6xNbbB9TubXgykK7ESA+nGh4uDuTfq/KVxFgjl9IEABP+Hmm6y/YJyr++oJJ66/q6kderbhU5c91zQnD13SS9n5t4pJ2nYbx4nw6HqxmxpDu0zFi7A1j7Pj1c/ig0pEfuBukO1qyPv7AMX+zofTizIPzkyk7p+3fcPdeGMGChA1pukON9zVaCHj1VDG6Y4GJnjnIVJy0/LN5zfzpOU/h/TobVKjKO1GebsXIyXwdlPn6+TcK2fD/ZZodFfA==;5:YURGSGjmXQV3J89hYjHjQ1Jj4aOMqINshmU/DMNAUfDb0gF4sIXGJX0P0iSWV4GjzB07CkrPU9svJpnQ0s+bfZtMWB1m/TUDEDM61DiIM1vWKvsCxWQGgZW11ICSYvkSNWMW3L4YgX2RqOySvfYCLwTyVBtP55aKcXGtkMW40fc=;7:2yDz+e5Cp08Z91DKvmpMCie4w6UNeS4WK4F/yodf9k0ZXN4mxYZDrGUEUCGzMznVWRZN8XMovh3Q0X2UvIst71yVq0Wgs4EfT2t7rS+8ckmXKkrHGBCnr94mSQ7O+oUOgrD+Btiq+DEVc8C3WUvrpw==
x-ms-office365-filtering-correlation-id: de287360-4a2a-4ae6-10af-08d667887508
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1040;
x-ms-traffictypediagnostic: MWHPR2201MB1040:
x-microsoft-antispam-prvs: <MWHPR2201MB104030C9C032786E2FC5B8CAC1B80@MWHPR2201MB1040.namprd22.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(5005026)(6040522)(2401047)(8121501046)(3002001)(10201501046)(93006095)(3231475)(944501520)(52105112)(149066)(150057)(6041310)(2016111802025)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1040;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1040;
x-forefront-prvs: 0893636978
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(396003)(366004)(376002)(346002)(39840400004)(136003)(199004)(189003)(42882007)(6246003)(9686003)(6306002)(446003)(6512007)(52116002)(25786009)(11346002)(106356001)(14444005)(256004)(66066001)(71200400001)(476003)(6506007)(53936002)(71190400001)(33716001)(93886005)(1076003)(105586002)(305945005)(7736002)(39060400002)(508600001)(6436002)(486006)(33896004)(316002)(81166006)(26005)(6916009)(81156014)(54906003)(5660300001)(58126008)(8936002)(386003)(2906002)(229853002)(97736004)(6116002)(3846002)(68736007)(4326008)(99286004)(44832011)(53546011)(76176011)(6486002)(14454004)(966005)(8676002)(102836004)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1040;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 0g4+VgdNtJIRyvTlNU1njIQOYwZihhW50Ejm4CahmuAjV8jCiEIdbSOHNVfiI8hbxNiPwLF3j8khGMg437H7QvzG+Z+bQFZcE+/WdVQ2AEbK05FTGdUPnB6/Lby4ysb9udtKaq5v+g39xtu7IK+t/IV7GHyvfGBYEk3pN2NvRLi4P1vzsUr+/089vXw9SY/cxVXg5kFbAnAz7KzpsGyg1boeB6cDhsZIksQoxR387BtW2s4G3OnkEkdAcChxM5vnGYrqQoIqAhU+v+ZsBb3BHD//qAEyuy11n9UPq63PWJG19hLWus1wym46hi+KaJ54
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <482416DD55D0374C9214F154210B2320@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de287360-4a2a-4ae6-10af-08d667887508
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2018 21:08:30.2765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1040
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek,

On Fri, Dec 21, 2018 at 09:08:28PM +0100, Marek Vasut wrote:
> On 12/16/2018 11:28 PM, Paul Burton wrote:
> > On Sun, Dec 16, 2018 at 11:01:18PM +0100, Marek Vasut wrote:
> >>>>> I did suggest an alternative approach which would rename
> >>>>> serial8250_clear_fifos() and split it into 2 variants - one that
> >>>>> disables FIFOs & one that does not, then use the latter in
> >>>>> __do_stop_tx_rs485():
> >>>>>
> >>>>> https://lore.kernel.org/lkml/20181213014805.77u5dzydo23cm6fq@pburto=
n-laptop/
> >>>>>
> >>>>> However I have no access to the OMAP3 hardware that Marek's patch w=
as
> >>>>> attempting to fix & have heard nothing back with regards to him tes=
ting
> >>>>> that approach, so here's a simple revert that fixes the Ingenic JZ4=
780.
> >>>>>
> >>>>> I've marked for stable back to v4.10 presuming that this is how far=
 the
> >>>>> broken patch may be backported, given that this is where commit
> >>>>> 2bed8a8e7072 ("Clearing FIFOs in RS485 emulation mode causes subseq=
uent
> >>>>> transmits to break") that it tried to fix was introduced.
> >>>>
> >>>> OK, I tested this on AM335x / OMAP3 and the system is again broken, =
so
> >>>> that's a NAK.
> >>>
> >>> To be clear - what did you test? This revert or the patch linked to
> >>> above?
> >>>
> >>> This revert would of course reintroduce your RS485 issue because it j=
ust
> >>> undoes your change.
> >>
> >> The revert. Which of the two patches do you need me to test.
> >=20
> > The one in the email I sent on Thursday 13th at 01:48:06 UTC, linked to
> > at lore.kernel.org in the quote right above:
> >=20
> > https://lore.kernel.org/lkml/20181213014805.77u5dzydo23cm6fq@pburton-la=
ptop/
> >=20
> > You replied with comments on the patch, you just never tested it or
> > never told me if you did. The lack of response means I don't know
> > whether that potential patch even still works for your system, hence th=
e
> > revert.
>=20
> I shared the entire testcase, which now fails on AM335x due to this
> revert. Is there any progress on a proper fix from your side which does
> not break the AM335x ?

No.

Let's be clear - I didn't break your AM335x system, your broken patch
says that Daniel did with a commit applied back in v4.10. As such I
don't consider it my responsibility to fix your problem at all, I don't
have any access to the hardware anyway & I won't be buying hardware to
fix a bug for you.

Despite all that I did write a patch which I expect would have solved
the problem for both of us, which is linked *twice* in the quoted emails
above & which as far as I can tell you *still* have not tested. I can
only surmise that you're trying deliberately to be annoying at this
point.

If you want to try the patch I already wrote, and confirm whether it
actually works for you, then let's talk. Otherwise we're done here.

Thanks,
    Paul
