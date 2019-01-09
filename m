Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF52C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D250D214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="L6TznElq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731620AbfAIOiw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 09:38:52 -0500
Received: from mail1.bemta26.messagelabs.com ([85.158.142.114]:39759 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731192AbfAIOiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 09:38:51 -0500
Received: from [85.158.142.201] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-b.eu-central-1.aws.symcld.net id C0/6E-19000-777063C5; Wed, 09 Jan 2019 14:38:47 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJJsWRWlGSWpSXmKPExsWSoc9rrlvObhZ
  j8GOrlMWplj3sFlcuHmKymPrwCZvF3vMfmS2+Xelgsri8aw6bReeuflaLDd/XMjpweGz43MTm
  0XrpL5vHzll32T0WbCr12LSqk81j39tlbB7rt1xl8fi8SS6AI4o1My8pvyKBNePF8gdMBW/YK
  /au3sLewLiFrYuRi4NFYD2zxNczV8AcIYEpTBKrPvYzQTgPGCVuXJ0GlOHkYBOwkJh84gFYlY
  jAfkaJs5OXsYM4zAINTBILOt4zgVQJC4RKrLl3kB3EFhEIkzj+ZjILhG0kcbVrOlCcA2ihisS
  imTUgYV6BRInXn86CtQoJuElM2f0FzOYUcJd42XiEGcRmFJCV+NK4GsxmFhCXuPVkPliNhICA
  xJI955khbFGJl4//sULUp0qcbLrBCBHXkTh7/QmUrSQxb+4RKFtW4tL8bkaQ+yUEWtklzly/z
  wKR8JV4MXUPC0TiDqNE26MXcJMe3V0KZVtILOluhWqwkTj3YDuUXSBx5d4Kdojmh8wSLZc/Qp
  0qI7G5cw4bhP2BVWLzc16Il5MlPsw9yz6BUXcWku8gbB2JBbs/sUHY2hLLFr5mngUOMUGJkzO
  fsCxgZFnFaJlUlJmeUZKbmJmja2hgoGtoaKxrqmtoYqKXWKWbpJdaqpucmldSlAiU1UssL9Yr
  rsxNzknRy0st2cQITHYphawTdjAuWZ5+iFGSg0lJlHfLd9MYIb6k/JTKjMTijPii0pzU4kOMM
  hwcShK8q1jNYoQEi1LTUyvSMnOAaRcmLcHBoyTCa8oGlOYtLkjMLc5Mh0idYtTlOLDo4VxmIZ
  a8/LxUKXHetyAzBECKMkrz4EbAcsAlRlkpYV5GBgYGIZ6C1KLczBJU+VeM4hyMSsK8m0Cm8GT
  mlcBtegV0BBPQEYcYTUCOKElESEk1MF7P2H6rSDecd02zsuub+wwdVq4a1xsOFVRsSHBY5+Bk
  wHXS2MhnXljCgxkT/P5dYTqsY+5jvXT9hCWLjs9pLlm0cNq0GVZvn049favAQ4ZvB3da3w9Z1
  wnfH7kzKu7ovaN2/o+jlf/9lsu3b/7vl9C4GbCmR3tX5Q/xfoXr8y13H2o/L/SyeKcSS3FGoq
  EWc1FxIgDDLiO5/AMAAA==
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-13.tower-246.messagelabs.com!1547044726!94500!1
X-Originating-IP: [104.47.13.55]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 16270 invoked from network); 9 Jan 2019 14:38:47 -0000
Received: from mail-he1eur04lp2055.outbound.protection.outlook.com (HELO EUR04-HE1-obe.outbound.protection.outlook.com) (104.47.13.55)
  by server-13.tower-246.messagelabs.com with AES256-SHA256 encrypted SMTP; 9 Jan 2019 14:38:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com; s=selector1-diasemi-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WT8PCtI4s0SlZFYWoCOTtHzxKEZD87NXQOHnOM9TAX4=;
 b=L6TznElqa0O24EGN58bQ56UcxPO1jJKI+up2lQu2CYfHf/FMkuoIcZSK4sg9NfK4cOvBNMDxCs1NLS3ZnMIpXMEHT8tLHXExm8KhcSyxTkXhgjaiZWmdQxsNNFVW3h1oAblVJxADk4sX/IOXc2S3y9vpAs92GFSna4iV9oYl7/E=
Received: from AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM (10.169.154.17) by
 AM5PR1001MB1204.EURPRD10.PROD.OUTLOOK.COM (10.169.155.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.13; Wed, 9 Jan 2019 14:38:44 +0000
Received: from AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::98b1:b963:cf3:a5e9]) by AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::98b1:b963:cf3:a5e9%9]) with mapi id 15.20.1516.010; Wed, 9 Jan 2019
 14:38:44 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
CC:     Akshu Agrawal <Akshu.Agrawal@amd.com>,
        Daniel Kurtz <djkurtz@google.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>
Subject: RE: [PATCH 0/2] ASoC: da7219: Improvements to DAI clocks handling in
 driver
Thread-Topic: [PATCH 0/2] ASoC: da7219: Improvements to DAI clocks handling in
 driver
Thread-Index: AQHUqCWFvHqfj/z2x0+hUPaV2GWBWKWnAR5w
Date:   Wed, 9 Jan 2019 14:38:44 +0000
Message-ID: <AM5PR1001MB099499F06884D00319A061EE808B0@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
References: <cover.1546876084.git.Adam.Thomson.Opensource@diasemi.com>
In-Reply-To: <cover.1546876084.git.Adam.Thomson.Opensource@diasemi.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.225.80.228]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM5PR1001MB1204;6:YI9qBFF8hKJL1ee2fGbKxtBvJrastM3PH3CiR3K31/QynhQDSsj6MU00qmKXH6HPBLFsDmxAufg2CKPbIC/AxB6jXWyWNAT135LCeUAknbDNhA2u22b9LibIOkla63HOK6vG6OaMaM/rbNpTOPFoh41uNAQRs4U3rMh+YNbwJnts3hOlflL77J3IUQrCv6QUxVh/AAplWJETE9QWeW+MxVrJtoWEHINGwPdMWj7Vn+ztSyky7Dw/T4nCvYs41Chgx6eLGi1EkKVN8RFPj9aLRJwM8cO0/pnGb2Ufxwh1UCa9/E+GTRL2sd8YPJfPi4RRxEwNKrQvz0+qbQ23NKq9xS5LUxYq5CvuaGPQjY+hNm5vfoSUQm/N3MAna0PHM++x2oX/RTmO3KskwORCnMh/zT+zFiRZl3HLdjk62IEmGcP0Lze9JtbRex6w1IJpkqWnKBsiJDEnm9uC/rGYp2+ELg==;5:+ZrRD+9ZxCdV42RMK+5D+JFSC7DZRQov2cAes1XyUnu5DQLf6l/aA/Q6XloPExLVi+4nQG2b7j7TSbhnDPgV0ctb7mH12tbduaD+J7SQgbTl7BE9+eMhyjaOo3xRxch9S/kZ8ZJe0arb7wO8dEHyabmyfosu4wbyKlukA6pXLJONAzTQjZMpEptalQUkry2NuAq5KJntL38DwMaMqatFUg==;7:TSq0FXlfZpLlR2R9H5j8TGpOe3OhSU5FlXSInF9NN6FW7AjvPYQyC7og84W9d3u6Jw9F5MPkAu0dgT8vtFFpt1P/JD/OoMb3nhNCGU5AvblbbFiBiymZYYQfVfiNm48PCdlfsVqb4ASVkNwXzqlrCQ==
x-ms-office365-filtering-correlation-id: 4bb96cfa-3937-4c6e-48fc-08d67640284c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR1001MB1204;
x-ms-traffictypediagnostic: AM5PR1001MB1204:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ld-processed: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c,ExtAddr
x-microsoft-antispam-prvs: <AM5PR1001MB12046F7689917F841B6A8782A78B0@AM5PR1001MB1204.EURPRD10.PROD.OUTLOOK.COM>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(823302103)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(3002001)(6041310)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:AM5PR1001MB1204;BCL:0;PCL:0;RULEID:;SRVR:AM5PR1001MB1204;
x-forefront-prvs: 0912297777
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(396003)(376002)(136003)(346002)(199004)(189003)(66066001)(71190400001)(316002)(6116002)(486006)(54906003)(110136005)(97736004)(105586002)(5660300001)(25786009)(3846002)(7696005)(106356001)(86362001)(305945005)(99286004)(256004)(33656002)(478600001)(72206003)(68736007)(14454004)(81166006)(81156014)(8936002)(8676002)(7736002)(9686003)(74316002)(476003)(6436002)(446003)(11346002)(186003)(55016002)(229853002)(39060400002)(107886003)(6246003)(6506007)(26005)(76176011)(102836004)(55236004)(53546011)(53936002)(2906002)(71200400001)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR1001MB1204;H:AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: d5fVEMcPTl62es4jEDf5aIHQjGlT4f0dnMc+7G99qx+AvkBLSkA4uIQ3VKUGekuVPBrqsGJxr8OXjQlrT0zW6RrqnbXSJP7KXjPmfMYqkIv34SOJ16DXPUlnQ80l+TWKVGdcKU5zEu2Dzo8u2KU1Dat617yxLTVVULd4I89+pWS0Qscf89JVyUvczOJciWfej8WMZqf3UYLAe5NYf9iyTxMYusayMcAbib7Val9fqO7k1QX1507UHDMqg0krjPpM1/LGEB/BFNnQ1BBJvGAeW0u8dKwxzmQMugg057qjUtWu4fouy2OS+Q+6trSsIHCv
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bb96cfa-3937-4c6e-48fc-08d67640284c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2019 14:38:44.4482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR1001MB1204
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08 January 2019 09:13, Adam Thomson wrote:

> This small patchset provides improvements to CCF based clock handling rel=
ating
> to the DAI clocks. In the first patch MCLK is made parent of DAI clocks, =
if MCLK
> has been provided to the driver, which means that MCLK will automatically=
 be
> enabled as a prerequisite to DAI clocks. The second patch adds the abilit=
y to read
> the WCLK rate provided by the codec when DAI clocks are featured. This is=
 more
> useful than the returned rate simply being the rate of the parent clock, =
which in
> this case would be MCLK.

Apologies for repeat submissions. Had some glitches with mail servers here.
=20
> Adam Thomson (2):
>   ASoC: da7219: MCLK should be enabled before DAI clocks
>   ASoC: da7219: Add recalc_rate function to return DAI clock rate
>=20
>  sound/soc/codecs/da7219.c | 77
> ++++++++++++++++++++++++++++++++++++++++-------
>  sound/soc/codecs/da7219.h |  1 +
>  2 files changed, 67 insertions(+), 11 deletions(-)
>=20
> --
> 1.9.1
