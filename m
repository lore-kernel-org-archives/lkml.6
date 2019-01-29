Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74E4C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83A2D20857
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NkPWoUHo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbfA2IkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 03:40:00 -0500
Received: from mail-eopbgr60048.outbound.protection.outlook.com ([40.107.6.48]:52130
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725298AbfA2Ij7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 03:39:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9Ta6RzBgouqTDLezt98HLbcHm+BRTSWIEq1OUC9hyo=;
 b=NkPWoUHoYVbGV5oUI+1wNuNoxzg5RqnxagzCxUjdADw9ATAsv6akWmGdC2K4LgCMMyLbQoYgJqErIS/2Zfo9psBCqAahDDqcq5Z6ULHKwkjVe+GN3ove5WeAQgOoqxnx7oJQ/7zZwRw6DlZi1uQcGWnUu4Z78ajKgAy9wKNPRBA=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB5776.eurprd04.prod.outlook.com (20.178.127.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Tue, 29 Jan 2019 08:39:55 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::a1c2:cc79:80f3:3bcb]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::a1c2:cc79:80f3:3bcb%5]) with mapi id 15.20.1558.023; Tue, 29 Jan 2019
 08:39:55 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Mark Brown <broonie@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Boris Brezillon <bbrezillon@kernel.org>
Subject: RE: linux-next: build warning after merge of the spi tree
Thread-Topic: linux-next: build warning after merge of the spi tree
Thread-Index: AQHUt3a62Ee70mxZo0K+W97/inGmg6XFz85QgAAaEQCAAAFpYA==
Date:   Tue, 29 Jan 2019 08:39:55 +0000
Message-ID: <VI1PR04MB57268573920A23B333CBE68799970@VI1PR04MB5726.eurprd04.prod.outlook.com>
References: <20190129130237.677e5ac8@canb.auug.org.au>
        <VI1PR04MB57262F1ADEEC151C11E0F48499970@VI1PR04MB5726.eurprd04.prod.outlook.com>
 <20190129192658.72c88d0b@canb.auug.org.au>
In-Reply-To: <20190129192658.72c88d0b@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB5776;6:OkkpKGMwONjdSJ2Yu3uTmNSwuTafAjAk1zsO7bXbWvK1XyLc2QciPvFj/rYT7QICI1cl67eQtgeZUpfSke3yDdjYxNsOSXthl3S5aVGkT5mmqJOZdV1zyZs8/L8mUuRWzDnTwzpoPyu5HO0aP/NXvjIKqreO+NTE9F21zH5MoCh2Kr8sct7hafF4TIPYuOWwyY0N2Co1l+LEox27agG0OyEEWN/23AeNyAuFC3BiIXh3M0mB7C32GFBq7oaxF00RGbND9ptVfHPiOOU639WEsaSMxtlBoUMTyyDFim0dZjuA5gBKSSQU8mS3ZvSKpiAfFjJMOcGYxm8nJD0yHdWEHyHdD6BJK/WHkMT7oQChNW228YPRUhOhmnMLdmOzvY0x2L90517+HsL1ooXR9DJq7N6KTTZDEh47H94prl6kAQprkPjE1DBBEe063N7w8+8k7bxhmJiDjgaRJXD445ogFg==;5:4y7ooSjlvF+qv9Yu+avEzWkXlhAiUXKcMLTX+xgHGxV9vufG/Mu9L1n0VVqJuRQnzDZswJkDdRfknlxEMXs6cDkVWwn5yPbzX7t/PmYW6B5lh3zHgYa3Rm6m2IGmV6fq8Xn3KF8WcgqGvMz+8os5aqn7fmj0KdrUns+2Q2DMTl6DUvxXIV881LHlfwkxXcs4feyFDIaI0oC4vM5fRDL/Uw==;7:SMTsI+zKW4jWQXpwpQ1V4fBjKfBdAgjP1mW7UIY5y3IgBiT2EG8o+V0FqpY2w1USyYSiBHwJFhpQFpepXERf7bU+dzjpa+8o8izM1oUvGNExQTfLgepwU1Os+/Y1RGzWkYh6JdgXx0tKv8kfgiksHQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: e41fa2e6-08aa-4ac9-8594-08d685c55842
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5776;
x-ms-traffictypediagnostic: VI1PR04MB5776:
x-microsoft-antispam-prvs: <VI1PR04MB57763ADA99AD9E2AC3EBA0CA99970@VI1PR04MB5776.eurprd04.prod.outlook.com>
x-forefront-prvs: 093290AD39
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(376002)(396003)(39860400002)(346002)(13464003)(199004)(189003)(9686003)(105586002)(305945005)(7736002)(55016002)(3846002)(4326008)(966005)(106356001)(68736007)(6916009)(86362001)(97736004)(76176011)(14454004)(478600001)(2906002)(6306002)(54906003)(229853002)(6436002)(81166006)(81156014)(6116002)(8936002)(74316002)(25786009)(6506007)(446003)(486006)(26005)(71200400001)(8676002)(14444005)(53936002)(7696005)(71190400001)(6246003)(102836004)(256004)(33656002)(316002)(53546011)(66066001)(476003)(11346002)(99286004)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5776;H:VI1PR04MB5726.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ExfiQMDaLq8snUL48VDBKskfw09yzDrlHmbJhhWKDggak3lzoQOnyhnvXeHjc3YOEu3NN+sCXzgS/gfQL4BYKtjwlY/qeyUe+s8OHFDVlwDpDtRk0oimlTHqVAiwbtbyB0W+qWAnqpPVaj47/PZ0VguUTtzGZ6Ltaj3sil6gtOnpjBmhRw9mrwggk/4MMDqmusvaGPfI/STMNqC+ATdlbvZAVr6WcWK6ix2p1tRnxpLSAFu8OKK6UnfLzzrTw12XSFeDQtgJjjIUdHOisDO7qQVi80kfJcakFIcEDR/lJNnCiQuPJtLR/b0h5oigQz/6dz7y3fsdZiP2DQGDkPwOD9WXvRe/5vsNjSMiHmeojLkShOmdYQljgelmwTM/C4vOlyJQUfVkcFUIhSvB3WW5MqkKOaLSspe/m0qQvqMjV34=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e41fa2e6-08aa-4ac9-8594-08d685c55842
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2019 08:39:55.3478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5776
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

> -----Original Message-----
> From: Stephen Rothwell [mailto:sfr@canb.auug.org.au]
> Sent: Tuesday, January 29, 2019 1:57 PM
> To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> Cc: Mark Brown <broonie@kernel.org>; Linux Next Mailing List <linux-
> next@vger.kernel.org>; Linux Kernel Mailing List <linux-kernel@vger.kerne=
l.org>;
> Frieder Schrempf <frieder.schrempf@kontron.de>; Boris Brezillon
> <bbrezillon@kernel.org>
> Subject: Re: linux-next: build warning after merge of the spi tree
>=20
> Hi Yogesh,
>=20
> On Tue, 29 Jan 2019 06:57:51 +0000 Yogesh Narayan Gaur
> <yogeshnarayan.gaur@nxp.com> wrote:
> >
> > > WARNING: modpost: missing MODULE_LICENSE() in
> > > drivers/spi/spi-nxp-fspi.o see include/linux/module.h for more
> > > information
> > >
> > Can someone help in pointing out that why above warning message is comi=
ng
> for mentioned commit.
> > Below MODULE_LICENSE string is present in the above mentioned file,
> drivers/spi/spi-nxp-fspi.c.
> >     MODULE_LICENSE("GPL v2");
>=20
> The version in linux-next has no such line.
>=20
Yes, somehow this missing line was appended to the commit message instead o=
f the actual in patchwork, also being pointed out by Frieder in his reply.
Sorry for this.

I have send fix patch for this warning message [1]. Please check the patch =
and apply.

--
Regards,
Yogesh Gaur

[1] https://patchwork.ozlabs.org/patch/1032586/

> --
> Cheers,
> Stephen Rothwell
