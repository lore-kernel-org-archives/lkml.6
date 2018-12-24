Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76B6C64E79
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 15:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D0FC2184A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 15:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="R4FJeajG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725790AbeLXPnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 10:43:06 -0500
Received: from mail-eopbgr710120.outbound.protection.outlook.com ([40.107.71.120]:33472
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725616AbeLXPnG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 10:43:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uye2qo+BK3P6hzpafXGXDkJWwBDXlwZHX9KS2U0igZI=;
 b=R4FJeajGLOgz3/M28mdGVm/nc/kqN4+1qaF3GfuiZzO60cBBNu5ntIgPApUtWZsrgYHQ8ZUvwg2xXpoZLT+CRze+pcxkwHicrQEnop6SfxduHDK7VZVlMMTJbMepC34vhDIfNO1r3X9BOq/dWR+I3is8jG6QBeOJom/tUomqjhM=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1037.namprd22.prod.outlook.com (10.174.167.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.21; Mon, 24 Dec 2018 15:43:01 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::c07a:a95:8ba9:8435]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::c07a:a95:8ba9:8435%9]) with mapi id 15.20.1446.026; Mon, 24 Dec 2018
 15:43:01 +0000
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
Thread-Index: AQHUlXtT5YTLq052+E6wpTcC1lM1kqWB3BwAgAAIcYCAAAY6AIAAB4eAgAe0mwCAABC3AIAADwWAgARNEIA=
Date:   Mon, 24 Dec 2018 15:43:00 +0000
Message-ID: <20181224154255.rjrickousqbfvdjs@pburton-laptop>
References: <20181213174834.kxdy6fphaeoivqgh@pburton-laptop>
 <20181216200833.27928-1-paul.burton@mips.com>
 <93a3c76b-f4ba-57ae-9d80-6e945b4f3181@denx.de>
 <20181216213901.hpll7wqzhqvfgkfy@pburton-laptop>
 <28a1d4ae-493d-8bbc-46f7-ad41ca04d782@denx.de>
 <20181216222815.4t4xhaiy6rvfaogq@pburton-laptop>
 <78839e8c-0278-6060-0dd2-a84a19258a8a@denx.de>
 <20181221210818.g3kbv7bnr577dane@pburton-laptop>
 <0266be47-75c8-6a1b-dfec-129c5b7bbf8f@denx.de>
In-Reply-To: <0266be47-75c8-6a1b-dfec-129c5b7bbf8f@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0023.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::35) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.197.89.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1037;6:Eh4Fwu2yZebqTjKpf8qk0ax0XtU67kEElwYXLLHn2YJac5tXifsjSpMu8sdEOuGJwjX0w6sKiAFllUlXCVxuVsvPO9lTqQlYEyMQzEwqH3EDJ0p24n0kHXdKHrv1Wlorpd6z/n8/s237Is6CtIqhwj3qKBnobFJH9F586VdgPDbIouhiNkxDH1qp4FobJSxPRmk9ZnUK0L4D4JQUxTtWdZXMN8llhKyrgHRQyqImgjA/h8FXtRvvZ7H3+PWVunhO1mvA/Lvp1vMq2Cjcmks7657cCLMqfvTtBnxhkB9HcZKSO81RCzjCrGECvzzxbL4d0wGaWPQnSrLjGV1W93On7FnAKzQZOIrNLUPy0KUrhoEMpn8E06aQiDotffKkffKQZ/IRWrQaX1pIG/xN8Y5jph42Zjn+JozyKGxiG1FTIlhmpXoraaqZldfUhxTvAsinuBAi+ne/qUuYrD22ry4YKw==;5:cM5GpRNqrIq1BlmnjWfHoMB/WQAVBebjbz4Migy/4jDYLQX/++m6OmABlpV99e8S64TFCU4qZmMe+VC7icVBUHHTw5s2B60+C1qCny4mrT93HGf/NKmk8rVLyddEpUokKvseb+33LcKIuDJl4eqReR9GHrkD2hAM+rq0FkEl62E=;7:Y3Fr2EQGdrwFx+H2Tg1lzlBJXQpkBSv8PqX0oCcy741A9FNetcHgDPMSeXjozhNM+vXwqxoPfwSPB9wotpX4+Ldru7zpEos+MvBFrUzi/9WjTY8K3i8bjqIPA+tgX9EYl+jZiSj0dWqfFvTMNs8m4g==
x-ms-office365-filtering-correlation-id: c05b80d1-4806-4e3b-81e2-08d669b67be2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600098)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1037;
x-ms-traffictypediagnostic: MWHPR2201MB1037:
x-microsoft-antispam-prvs: <MWHPR2201MB1037BC4735E24A0A50A8D267C1BB0@MWHPR2201MB1037.namprd22.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(908002)(999002)(5005026)(6040522)(8220043)(2401047)(8121501046)(93006095)(3231475)(944501520)(52105112)(3002001)(10201501046)(6041310)(2016111802025)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1037;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1037;
x-forefront-prvs: 0896BFCE6C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(346002)(39840400004)(366004)(136003)(396003)(376002)(199004)(189003)(66066001)(256004)(76176011)(53936002)(44832011)(102836004)(6346003)(6916009)(486006)(33896004)(97736004)(26005)(99286004)(52116002)(14444005)(6512007)(386003)(508600001)(6506007)(8936002)(5660300001)(446003)(25786009)(9686003)(8676002)(6116002)(81156014)(81166006)(3846002)(33716001)(71190400001)(71200400001)(105586002)(106356001)(68736007)(2906002)(316002)(54906003)(58126008)(7736002)(305945005)(11346002)(476003)(42882007)(229853002)(93886005)(39060400002)(6436002)(186003)(6246003)(6486002)(1076003)(14454004)(4326008)(3716004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1037;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: galCTNR9ExyNOf/SMc92TOv5jEOsOGh7IMhJ2Rut1UG0rjLI2QHkw3wXF9oPcmdYcJHjYQaZ6bKrbl76jhgH3pVlxJF1iQhXg/VaxyvEbjjaHVzDQJFLZOXPcFlZdSKK1IUKI7HcyskiAq+A2wN5gOIyWGfqX/jWArZAGjtJ/kvkGQzNVYcnO+4oRiMNIsDTWOqY4ZaonNuPRWv2Jfye8yjHOmivR0xu2K8e1Bdwu3efJegohYl9CUwWzQbkcdW4NOrays5FBj0YaULrSEU2Rxy/raSohx20SirSbejwWbO6dvjy640fBEfq6Zw0zJ0n
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9FEFA0B66E4750498F17B727F327F74D@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c05b80d1-4806-4e3b-81e2-08d669b67be2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2018 15:43:00.9345
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1037
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek,

On Fri, Dec 21, 2018 at 11:02:03PM +0100, Marek Vasut wrote:
> >> I shared the entire testcase, which now fails on AM335x due to this
> >> revert. Is there any progress on a proper fix from your side which doe=
s
> >> not break the AM335x ?
> >=20
> > No.
> >=20
> > Let's be clear - I didn't break your AM335x system, your broken patch
> > says that Daniel did with a commit applied back in v4.10. As such I
> > don't consider it my responsibility to fix your problem at all, I don't
> > have any access to the hardware anyway & I won't be buying hardware to
> > fix a bug for you.
> >=20
> > Despite all that I did write a patch which I expect would have solved
> > the problem for both of us, which is linked *twice* in the quoted email=
s
> > above & which as far as I can tell you *still* have not tested. I can
> > only surmise that you're trying deliberately to be annoying at this
> > point.
> >=20
> > If you want to try the patch I already wrote, and confirm whether it
> > actually works for you, then let's talk. Otherwise we're done here.
>=20
> Understood. However I did test your patch, but it was generating
> spurious IRQs and overruns (ttyS ttyS2: 91 input overrun(s)) on the
> AM335x, so that's not a proper solution.

OK, thanks for testing, and let's figure out what's going on. Since the
revert is in now I'd suggest starting from there - ie. approximately
from the code we've had since v4.10.

> I even brought the CI20 V2 I have back to life (yes, I bought one). The
> patch Ezequiel posted did fix the problem on the CI20, and did not break
> the AM335x, so I'd prefer if it was revisited instead of a heavy-handed
> revert.

As I described in an earlier email & on IRC, Ezequiel's one-liner does
not address all of the problems listed in my revert's commit message.
But again, since the revert is now in I suggest starting from there.

As neither a maintainer or significant contributor to
drivers/tty/serial, nor the author of the patch applied in v4.10 which
you say broke AM335x, nor someone with access to the affected hardware,
I'm probably not the best placed person to help you here - all I can do
is offer general debug suggestions. With that in mind, here are some
questions & ideas I have:

 1) Your message for commit f6aa5beb45be ("serial: 8250: Fix clearing
    FIFOs in RS485 mode again") suggests that the problem you're seeing
    is specific to the __do_stop_tx_rs485() path. Does changing only
    __do_stop_tx_rs485() to clear the FIFOs without disabling them,
    without modifying other users of serial8250_clear_fifos(), fix your
    problem? ie. does the following work?

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/=
8250_port.c
index f776b3eafb96..18d2a1a93f03 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1458,17 +1458,21 @@ static void serial8250_stop_rx(struct uart_port *po=
rt)
 }
=20
 static void __do_stop_tx_rs485(struct uart_8250_port *p)
 {
+	unsigned char fcr;
+
 	serial8250_em485_rts_after_send(p);
=20
 	/*
 	 * Empty the RX FIFO, we are not interested in anything
 	 * received during the half-duplex transmission.
 	 * Enable previously disabled RX interrupts.
 	 */
 	if (!(p->port.rs485.flags & SER_RS485_RX_DURING_TX)) {
-		serial8250_clear_fifos(p);
+		fcr =3D serial_port_in(&p->port, UART_FCR);
+		serial_port_out(&p->port, UART_FCR,
+				fcr | UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT);
=20
 		p->ier |=3D UART_IER_RLSI | UART_IER_RDI;
 		serial_port_out(&p->port, UART_IER, p->ier);
 	}

    Based on the comment above maybe leaving UART_FCR_CLEAR_XMIT out of
    that might make sense too..?

    Having __do_stop_tx_rs485() not share the FIFO clearing code with
    other callers may make sense given that so far as I can see
    __do_stop_tx_rs485() runs whilst the port is in use & other callers
    of serial8250_clear_fifos() do not.

 2) In an earlier email you said "The problem the original patch fixed
    was that too many bits were cleared in the FCR on OMAP3/AM335x".
    Could you clarify which bits we're talking about? From the AM335x
    reference manual I can only see the DMA_MODE bit & the
    [RT]X_FIFO_TRIG fields. Do you know which are problematic & why? In
    your commit message you mention the AM335x UART swallowing &
    retransmitting bytes - which field changing causes that?

> And I'd prefer to keep this thread alive, since I am still convinced
> that the FIFO handling code is wrong. Moreover, considering the UME bit
> on JZ4780 in FCR, the original code should confuse the UART on the
> JZ4780 too, although this might be hidden by some other surrounding code
> specific to the 8250 core on the JZ4780.

For completeness, as I said in an earlier email in the thread and as
we've since discussed on IRC, this is incorrect because
ingenic_uart_serial_out() unconditionally sets the UME bit. As such the
UME bit is not a problem, and JZ4780 works fine both before your patch &
after the revert.

Thanks,
    Paul
