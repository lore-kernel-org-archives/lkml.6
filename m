Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A154C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 13:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD0632146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 13:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="r7GUlAOS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbfBSN56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 08:57:58 -0500
Received: from mail1.bemta25.messagelabs.com ([195.245.230.131]:14945 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725805AbfBSN55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 08:57:57 -0500
Received: from [46.226.53.50] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-c.eu-west-1.aws.symcld.net id 5F/3F-25691-36B0C6C5; Tue, 19 Feb 2019 13:57:55 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WSa0gUURTHvTOz46w5dV0tT5ZSSwWZs7lGZZR
  Q9EWIoEg/FIWN7ri7OI7bzm6t0UPDrFZ6IIi1ZZqEihbVapAWvnqQmlkZGL1oSaLsoZgZYWW7
  M9vr2/+c3/+ex+UwpK6NjmEEl0OwS7yop8Moy2JmJZc1RdyaWHmPSr515guZXOYbpJPHHx8mk
  vtbztCrqdRmz4vQ1OJvO1O99Ufo1M/euA3UFo1VysxzbddYWiaaQm3tWlfb3btEAXIzbhTGUP
  gSCbW9w5pAoMPHCLhSNEaowTMEQ987/IGWobERzn4YRgEdhdeCu+UgHTCRuIAA96tJMgAicQ6
  c7DtKqSYRng4W0apOgvILVYqm8Hzoqm1QirJ4Gxy/NaH4dTgbbg+MKw20eAUUDhQreYRjYayw
  QalP4mh/zUrlLWAM52/0kaqeDu9e/9So/gw41PYxVM0nQO/AIFK1HmqeeDSqjoVHlSXB/Hpor
  PqpLAP4KYI3JeNBEA+NN5sJFRSzcOxLcfC1CLWNz4MdZsOznnJSNXVr4FNNv0ZdJwtGKnqDpj
  ioP+qjVNMDEi6PTRLqPglQdX2UPoEWev5Zz/MPUvUiqDn3nvQoXxYBXacGqSpE1aNlmXar2eL
  I5a0iZ0xM5IzGJC4p0cgtMfC7uSyD4OR2CbKDMxr4XbJBzs/NEk0GSXB4kf+YTLYu8hp6U2fu
  RDMZQj+dzUbiVt3UzDxTvoWXLRl2pyjInWg2w+iBTQvzswi7YBZc2VbRf5G/MTDh+ig2J4BZ2
  cbnylaziroRx7RX+ypIHSXlSUJMNHta6zfhgMnilP6U+H3Xj1BsTCSLQkJCdOE2wZ5rdfzPh1
  A0g/SRrDvQKtwqOf50GvIPQfiH8EzmBIZw8H9RTAFKWGDzdt/cd3ahc1OH9kDTyvj0eUnP9zl
  Hdlyd1rvp7VTf3hPv7k9cv1iXIr2MKnDtj9j58HR6/mjtlpHNsKPnzsaKWR65ujVqOHJzXKG5
  6HxLeeuqr61859dZ6aUb5rSWNfV7u3xvq5fifJNkKk1ZHjJtzJTxcI9nXcOMtNH5c380r9FTs
  oU3xpN2mf8F7bNxqNIDAAA=
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-19.tower-302.messagelabs.com!1550584674!2053791!1
X-Originating-IP: [104.47.8.59]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 28223 invoked from network); 19 Feb 2019 13:57:55 -0000
Received: from mail-am5eur03lp2059.outbound.protection.outlook.com (HELO EUR03-AM5-obe.outbound.protection.outlook.com) (104.47.8.59)
  by server-19.tower-302.messagelabs.com with AES256-GCM-SHA384 encrypted SMTP; 19 Feb 2019 13:57:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com; s=selector1-diasemi-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJisnW9v+7o0BaMO1CprcoQbtpFIWLwWwGMSnhgqpIs=;
 b=r7GUlAOSBkOI5PtlxWH4m3/x3A98UXx/DGH3SAScnBFhS1Y3zssGdPn1DXFd/hW7F8OLpSMhqlnvrN82hZgAanhqTAyl6HzAt+cPr9LRxxgxMOW7sM1pkbXHAskEM8m7laVXkkZPUO3T6YML/n2Ozqmt1FTqVOdHl7n397Zzxjs=
Received: from VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM (20.177.62.92) by
 VI1PR10MB2272.EURPRD10.PROD.OUTLOOK.COM (20.177.62.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Tue, 19 Feb 2019 13:57:53 +0000
Received: from VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::11b1:dc26:b933:c0]) by VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::11b1:dc26:b933:c0%2]) with mapi id 15.20.1622.020; Tue, 19 Feb 2019
 13:57:53 +0000
From:   Steve Twiss <stwiss.opensource@diasemi.com>
To:     Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
CC:     Steve Twiss <stwiss.opensource@diasemi.com>,
        Krystian Garbaciak <krystian.garbaciak@diasemi.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] regulator: da9063: Select maximum current in specific
 range for set_current_limit
Thread-Topic: [PATCH 2/2] regulator: da9063: Select maximum current in
 specific range for set_current_limit
Thread-Index: AQHUyFd6+CjsJQ3tfUCbg24rzoky8qXnJJCA
Date:   Tue, 19 Feb 2019 13:57:53 +0000
Message-ID: <VI1PR10MB23529E779CAA7C5710A13018FE7C0@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
References: <20190219133101.20892-1-axel.lin@ingics.com>
 <20190219133101.20892-2-axel.lin@ingics.com>
In-Reply-To: <20190219133101.20892-2-axel.lin@ingics.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.240.73.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9e2702ff-9377-44af-a144-08d696723e32
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:VI1PR10MB2272;
x-ms-traffictypediagnostic: VI1PR10MB2272:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;VI1PR10MB2272;23:/dKA+cnyBnDPukBPAhi4g69kjpSVVqcmcbQYHytNx?=
 =?us-ascii?Q?40VYlb+NlC0/mS9/7Pi4ChbzeYb5w5oXwY/V8CcgoqeRmZ3pPUlADNmiHUQE?=
 =?us-ascii?Q?MqfBytkgtCnhhTlFI5UpzQQD6drvULeU5D+oM/cjSc+PfuC1njylIXQFpTF+?=
 =?us-ascii?Q?CDky90mNduKmaKYio7g9w0SxQ+9J4zvf6J80XKvu7XstcfBM112WEc2sTk0S?=
 =?us-ascii?Q?TGGBF3ncnz7W/L92kLd3vJxRdyGcgJ5Jbm6hkQUMmtyfoQjSyrts/4Qkeg9b?=
 =?us-ascii?Q?MRQAGjvcSSqVeIwTAUXrqbgsRHE5bunaY6a9A5kOzOAb0BntfdSDRmjpXOX1?=
 =?us-ascii?Q?OOXq0oG1ZMnj6W49wZOdHh8oFalaV5LnjsG6Tdq2vnewBN7fTe+EQ8T3awAJ?=
 =?us-ascii?Q?yknrBIvIkV43HzbnstLGuIIDDTpKlzHQjlY4ENkMdqSzLOML+t1aIOuo6Yus?=
 =?us-ascii?Q?W/OrwMuoMv7DQGTjbAP4HTSkgyXA5pxtioq1w1Uv1r5zLXBCftPKn2IQHdgY?=
 =?us-ascii?Q?qMPaXFYhIvDednBJwzrnLJSZ91OPDhhGpaUyeCA7iyuYFRsKYGSHwtFBY2Wk?=
 =?us-ascii?Q?hutMBMTaUlcxaEeMfwUdJ4X1TT6tHkKTcRhyfRu4IPGhl/c4zlcQegrjzwRi?=
 =?us-ascii?Q?RaX8yKxz3+h9FXM+UUbWphijOhT+abeK9GRK0OIT/ay8yRL1NfLOHi67j/gg?=
 =?us-ascii?Q?D+hRacS5oetllir1WYxlCPl1Go80QiA9wjOVB0LR608C1tcB206h8lglgpe3?=
 =?us-ascii?Q?BFyD+5ufRUWeYVa+9gkKJtA9xUSIFpgUqYEoaU5g9yfMEctxSJuJCLnzHTnx?=
 =?us-ascii?Q?1ERCZa8D/ErBQuGfkH3Tbk4zjVbCZb1BuJfKLPyaIKrlZQk4hdDxL8gTvuc/?=
 =?us-ascii?Q?QCNMWFVf1e6+b2qSdPRbleMqS35wZNVCtLBzYVUZ8BV7hgWiDXokWq7oWA5H?=
 =?us-ascii?Q?hhAFLQz/OAzweUrMrbigF6EB1GIjPTsF/h3Ih4CeYc0d+QIXvsd07p+JEY+G?=
 =?us-ascii?Q?lvpllxI4m0ws/0/blXx0rynoeFLbEPMEiWikejxpErzxgAy52fTLDm2H5Ihe?=
 =?us-ascii?Q?raO/Uzp2WaYBeyoj3VoXpAPr0LRPBAdBZtSSWHhFbWFMcSbMzIRFmPTQgYij?=
 =?us-ascii?Q?xxOopQOFCvBCmxLQ8aa5EoekcjkSv2uZK3EAsk+FYZx5ZnwGSO9xkYe7rk2a?=
 =?us-ascii?Q?yNn4OH/CDaZNE5P6x3gcNIca+wrwPXZxI+9HMOwuaj+FIMFV6KTX8YK1A=3D?=
 =?us-ascii?Q?=3D?=
x-microsoft-antispam-prvs: <VI1PR10MB227209B11C71B18C96C380F7F57C0@VI1PR10MB2272.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 09538D3531
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(39850400004)(346002)(396003)(366004)(199004)(189003)(54906003)(97736004)(316002)(106356001)(105586002)(102836004)(4326008)(71200400001)(7696005)(71190400001)(14454004)(6246003)(99286004)(76176011)(6506007)(53546011)(478600001)(66066001)(5660300002)(229853002)(305945005)(26005)(6436002)(74316002)(9686003)(8936002)(55016002)(53936002)(81156014)(8676002)(81166006)(7736002)(6116002)(446003)(33656002)(86362001)(25786009)(256004)(3846002)(14444005)(186003)(2906002)(11346002)(476003)(110136005)(68736007)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR10MB2272;H:VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /q/xgvKgtMvPLt7uRBAvC4jFGV53VNhm3SWlZ5YjbhZiifIdlJG5xeWkn+QlBkEcNtucW/ywJK60m9lGwrwyENOjA/V3tGN1DlNn0U3WVl3g2OjSg1h/dW+ebc7ZimyUijblztSSOzl/GBTrWYx0sG3wVyEhT9ezSm2iRe3RUm+Rj1nHZS+KH0IrMHnzDD7IH0+rvdI3FdaFYos1AXVNh9p6jOvGjJvL84NgIBGlrXpSKUqAmLm4lmERbxZqxv4coze3Yg6m7SxvWjTP61hlQOutisQtmM0GdS0AFQCzdm1BEwA65ZSF/D1f7YmzwbOBL24T6PNM4gqa39VcPk9ox4iG2D+2LPdev8+rcK0lskH4LbwdlxJlxVWG24qCTCX2AGtinCgKCGWjdbFfgsnBdrAz3YEwUsw1kxvoQXAZVio=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e2702ff-9377-44af-a144-08d696723e32
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2019 13:57:53.2256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2272
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 February 2019 13:31, Axel Lin wrote:

> To: Mark Brown <broonie@kernel.org>
> Subject: [PATCH 2/2] regulator: da9063: Select maximum current in specifi=
c range for set_current_limit
>=20
> Selecting the minimal value is only true for voltage regulators.
> For current regulators the maximum in the given range should be
> selected instead.
>=20
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  drivers/regulator/da9063-regulator.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9=
063-
> regulator.c
> index 85c45577bad1..a83bbd3dbc37 100644
> --- a/drivers/regulator/da9063-regulator.c
> +++ b/drivers/regulator/da9063-regulator.c
> @@ -167,7 +167,7 @@ static int da9063_set_current_limit(struct regulator_=
dev
> *rdev,
>  	const struct da9063_regulator_info *rinfo =3D regl->info;
>  	int n, tval;
>=20
> -	for (n =3D 0; n < rinfo->n_current_limits; n++) {
> +	for (n =3D rinfo->n_current_limits - 1; n >=3D 0; n--) {
>  		tval =3D rinfo->current_limits[n];
>  		if (tval >=3D min_uA && tval <=3D max_uA)
>  			return regmap_field_write(regl->ilimit, n);

Acked-by: Steve Twiss <stwiss.opensource@diasemi.com>
