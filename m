Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2F7C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DDBC208E7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="ZpBUAsIh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DDBC208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=diasemi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728726AbeLEWOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 17:14:05 -0500
Received: from mail1.bemta25.messagelabs.com ([195.245.230.130]:16912 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727358AbeLEWOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 17:14:05 -0500
Received: from [46.226.53.50] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-c.eu-west-1.aws.symcld.net id 02/C1-12179-8AD480C5; Wed, 05 Dec 2018 22:14:00 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WSaUwTURSFebN1IFTHgnIlgKEucWEKRU0mEYk
  aTZooRv+pqcsAA23SlqbTKqAmoDYgVcSIiogBDQpi4oKguOFeQIEqkLgiKE0UFE1wiWCidjrg
  8mu+d89557735tK4qo0Kp4VMu2Cz8CY1FUQYYgPnslVJtD6ur5XkLpScI7mDr70UV36vneQ8n
  vMK7ltXPsZ1Xi2juBJPI8b9ut6g4B5Xf8EWBequlHYrdLU1uyldYV0N0n2ujVpFrCONluSMzE
  2kof18PWZtmJ6ZmzeIctDglAIURBPMORwqrvUR0kLFFGNwtKpqdPEGQdHHVrwABdIUw8GB5l5
  K4lDmGIL6Eb1kwpmHGBQOl5GSEMIkgevdZVI2rYQm51kkczzkHs1TSEww0+Bl0X5/kJLhoe5I
  r7+uYuZBx8Vh/95AZj4MNJYQEiMmEr7knvEfAmfC4Lm3HJMYGAYqr3twmSdCf99PUvYL0LLjK
  ZLrMdD2xDvK0dCdM+aPhI5yF5IuAMwzCjpf7BgVkuBm3n5S5pcIWqstY0Ge7z8UMnNQ6XISMi
  dAe+9lH9M+tsLXoWS5HAU1e18Tcn4PDp/yd476I6Cx+yQpC3so+LbXTRQhtvSfy8kc4/snQ5T
  Mc+DU8fd4qf/BJkDLES9RgYgaxCXbjOkGu5k3mlhtXByr1caz8f4vp+Gz2RSN4GC3CKKd1Wr4
  LaJGzDKnmFI1FsFei3xjlmpt3tyADlWn30GTaUw9Uem6pdCrxiVnpGYZeNGw0eYwCeIdFEHTa
  lAOLaf1qgk2IV3ITDOafLM6JgMdrA5VTl/hk5WilTeLxnRZeoCiw8OUUZLASILBYfmzbWzKO1
  BkeIgSBQQEqIKtgs1stP+vD6AwGqlDlGullGCjxf4nfcDXGPM1NtVhUmM7/1cKz0H3Z94a2V7
  gvr1wjXXkbosjf7jJNTg+ZmPjhn7dEseCnwn7Eme/mtL+5GnKo5766DVpZsJdkRi0NHHG6fnZ
  a2MiBi4tO7Hu7aRT1Z2TLzjXFy5Ida0eFA8HxG496zhoc7qzex7q1zs23TjTtS360i7nkuLEx
  VEhH6YW692Vns3ehE62dpaaEA28djZuE/nfbSNPf+ADAAA=
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-26.tower-302.messagelabs.com!1544048038!3631994!1
X-Originating-IP: [104.47.9.51]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.14.24; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 8135 invoked from network); 5 Dec 2018 22:13:58 -0000
Received: from mail-ve1eur03lp2051.outbound.protection.outlook.com (HELO EUR03-VE1-obe.outbound.protection.outlook.com) (104.47.9.51)
  by server-26.tower-302.messagelabs.com with AES256-GCM-SHA384 encrypted SMTP; 5 Dec 2018 22:13:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com; s=selector1-diasemi-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ExmsrBMhhuajeNTbxdmpm+2L3lbygCvlmyMvhd1Y46k=;
 b=ZpBUAsIhRxw8corWpuC/np/fhPi69wpQYUMjD1eHQs9nb+PqP7dARmlcFd2BNcH6KpcMHFIiS8RUnxTyEW16gqXoZgRmJ4CDBgIIqnW729ByGSjU0xj2f4RdLPZFHiQTHJJo95s+5JuWX0lmpk91gHN7h0GswAyNI+OdYsHfS1w=
Received: from HE1PR1001MB1002.EURPRD10.PROD.OUTLOOK.COM (10.168.129.142) by
 HE1PR1001MB1356.EURPRD10.PROD.OUTLOOK.COM (10.171.98.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.17; Wed, 5 Dec 2018 22:13:54 +0000
Received: from HE1PR1001MB1002.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2045:83f0:b61c:5907]) by HE1PR1001MB1002.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2045:83f0:b61c:5907%4]) with mapi id 15.20.1404.019; Wed, 5 Dec 2018
 22:13:54 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Rob Herring <robh@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>
Subject: RE: [PATCH] regulator: Use of_node_name_eq for node name comparisons
Thread-Topic: [PATCH] regulator: Use of_node_name_eq for node name comparisons
Thread-Index: AQHUjNPlnthFXI+HoUyseNfjnoYgyqVwtVuA
Date:   Wed, 5 Dec 2018 22:13:54 +0000
Message-ID: <HE1PR1001MB1002F9F69B07DC91E0387A4180A80@HE1PR1001MB1002.EURPRD10.PROD.OUTLOOK.COM>
References: <20181205195050.4759-21-robh@kernel.org>
In-Reply-To: <20181205195050.4759-21-robh@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.225.80.80]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR1001MB1356;6:86QB2JvPwC5f2ddzX3D9642KVx36Sk8n5XEdNAEkjI1A6qt4RaGyjv4IiZWTdF3aPoc/Sx+mO5lGDB4eZueF+DRsgOBaT/BK1uexkQAlzz+apgCK2XW79hNjsrIOzvvkwI9yYvNTB/uX+wQzMGdLyMAxl2UG1W5qxa8XvXPLK71H2wsLKnPS0HMNmBRJb/dXMZaoalkeFKg32JYqGKAsmbfEUXgmSDCUIUccidq2T/Gs9CL8Yd+LRt9TUNj7BG2++FQpTphn12i695iTVMkysXKN266fJw4+/GD57gMPKDic9S4wldt6tbzCRwrJ1PtXDAqaQ3/+btZnXsa3heV0iwANySKkds1ddKKzMf40vn2t5ldSxs3VEOOK2B6OYkSJiTvhYCZqyDcAhvLvvyrYnimanTmv8CP/zvc/TViyTyG0fv/TFkdRT42TYAOI8zRmyHa93I/mAW+2OmijAaGuFw==;5:bYOxlYClEnOku16YPQm/FTCy5/N6xQ6ViG4FdcVVQaRk5R1maSKGyvIWecGwfyn0uVgAXK4ZHt20ATtzysQCJotww8Wie42gauHgvXaKzJ1QNzsoP4XcslJU7aAoKeNe3WIcFGJKsvxPVVcqiP14oxYLA1UfkzhhHR/7ap1Cess=;7://57vvhsIte6GHq9LlKpc7bGTzLu4tVLR2j/R4hJ2AaKErYwesEiraym3fT4kXghqacb26/w3IE11XKmsvoQWu1blAmYyb2AuykDhdKdKQYDjdogrVivKXH4CHggB0P5nvtkBEsaJRyHuCW2Ziw8cw==
x-ms-office365-filtering-correlation-id: 4b4c0d7f-9d40-4ea7-0867-08d65afef1b8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:HE1PR1001MB1356;
x-ms-traffictypediagnostic: HE1PR1001MB1356:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ld-processed: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c,ExtAddr
x-microsoft-antispam-prvs: <HE1PR1001MB13563983BB18E40AE0701E2EA7A80@HE1PR1001MB1356.EURPRD10.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302103)(93006095)(93001095)(3002001)(10201501046)(3231455)(999002)(944501520)(52105112)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:HE1PR1001MB1356;BCL:0;PCL:0;RULEID:;SRVR:HE1PR1001MB1356;
x-forefront-prvs: 08770259B4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39850400004)(396003)(366004)(376002)(346002)(189003)(199004)(55016002)(39060400002)(6436002)(86362001)(54906003)(110136005)(575784001)(6246003)(229853002)(74316002)(8936002)(2501003)(66066001)(5660300001)(25786009)(14454004)(97736004)(53936002)(9686003)(105586002)(8676002)(106356001)(81156014)(81166006)(99286004)(55236004)(33656002)(7736002)(478600001)(476003)(71190400001)(71200400001)(26005)(14444005)(256004)(53546011)(6506007)(102836004)(7696005)(3846002)(305945005)(2906002)(6116002)(2201001)(486006)(186003)(76176011)(446003)(68736007)(316002)(11346002)(4326008)(72206003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR1001MB1356;H:HE1PR1001MB1002.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: /VMxkKYFRFWeOglLWyjCRq3W1CHtZxEWv+ndjI5TB9aWseAJUd/cUmXEyG8q0dmYkncu06kitURsLeI19lA34BXEefax1MEwP5rA8Pl5MjYfngyXyaC8d8TKreXYmGiXOLX2LEfk7n1KXMv1YqUVDCV69Pd4K0SgNGJNVjnDH7G1uwRpT+9fHoteVKmE3ZQ/Z/PS6iQUY6xNp5K04HQJjxn6eSBY+RLHxmkx2vDrGkLZZcoQVINiKC45PFbXJtd+8jjE9iuh/tm+XCycnn6Im57hPnfeiA9DDXq8FhJ4hWJg0vaIlbd66opkJF50yVe5AwG86gxlZWTuxS/c9kHK8uC4beY6mdEFaHhbQTeWTMo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b4c0d7f-9d40-4ea7-0867-08d65afef1b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2018 22:13:54.2336
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR1001MB1356
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05 December 2018 19:51, Rob Herring wrote:

> Convert string compares of DT node names to use of_node_name_eq helper
> instead. This removes direct access to the node name pointer.
>=20
> For instances using of_node_cmp, this has the side effect of now using ca=
se
> sensitive comparisons. This should not matter for any FDT based system wh=
ich all
> of these are.
>=20
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Support Opensource <support.opensource@diasemi.com>
> Cc: Sangbeom Kim <sbkim73@samsung.com>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: linux-samsung-soc@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

For da9052 regulator driver:

Acked-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>

> ---
>  drivers/regulator/88pm8607.c               | 2 +-
>  drivers/regulator/da9052-regulator.c       | 2 +-
>  drivers/regulator/max8997-regulator.c      | 2 +-
>  drivers/regulator/mc13xxx-regulator-core.c | 2 +-
>  drivers/regulator/qcom-rpmh-regulator.c    | 2 +-
>  drivers/regulator/s5m8767.c                | 2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/regulator/88pm8607.c b/drivers/regulator/88pm8607.c =
index
> fd86446e499b..28f55248eb90 100644
> --- a/drivers/regulator/88pm8607.c
> +++ b/drivers/regulator/88pm8607.c
> @@ -328,7 +328,7 @@ static int pm8607_regulator_dt_init(struct
> platform_device *pdev,
>  		return -ENODEV;
>  	}
>  	for_each_child_of_node(nproot, np) {
> -		if (!of_node_cmp(np->name, info->desc.name)) {
> +		if (of_node_name_eq(np, info->desc.name)) {
>  			config->init_data =3D
>  				of_get_regulator_init_data(&pdev->dev, np,
>  							   &info->desc);
> diff --git a/drivers/regulator/da9052-regulator.c b/drivers/regulator/da9=
052-
> regulator.c
> index 37e4025203e3..207cb3859dcc 100644
> --- a/drivers/regulator/da9052-regulator.c
> +++ b/drivers/regulator/da9052-regulator.c
> @@ -435,7 +435,7 @@ static int da9052_regulator_probe(struct platform_dev=
ice
> *pdev)
>  			return -ENODEV;
>=20
>  		for_each_child_of_node(nproot, np) {
> -			if (!of_node_cmp(np->name,
> +			if (of_node_name_eq(np,
>  					 regulator->info->reg_desc.name)) {
>  				config.init_data =3D of_get_regulator_init_data(
>  					&pdev->dev, np,
> diff --git a/drivers/regulator/max8997-regulator.c b/drivers/regulator/ma=
x8997-
> regulator.c
> index 3bf5ddfaaea8..4d2487279a0a 100644
> --- a/drivers/regulator/max8997-regulator.c
> +++ b/drivers/regulator/max8997-regulator.c
> @@ -925,7 +925,7 @@ static int max8997_pmic_dt_parse_pdata(struct
> platform_device *pdev,
>  	pdata->regulators =3D rdata;
>  	for_each_child_of_node(regulators_np, reg_np) {
>  		for (i =3D 0; i < ARRAY_SIZE(regulators); i++)
> -			if (!of_node_cmp(reg_np->name, regulators[i].name))
> +			if (of_node_name_eq(reg_np, regulators[i].name))
>  				break;
>=20
>  		if (i =3D=3D ARRAY_SIZE(regulators)) {
> diff --git a/drivers/regulator/mc13xxx-regulator-core.c
> b/drivers/regulator/mc13xxx-regulator-core.c
> index 65eb1e0350cf..2243138d8a58 100644
> --- a/drivers/regulator/mc13xxx-regulator-core.c
> +++ b/drivers/regulator/mc13xxx-regulator-core.c
> @@ -186,7 +186,7 @@ struct mc13xxx_regulator_init_data
> *mc13xxx_parse_regulators_dt(
>  		for (i =3D 0; i < num_regulators; i++) {
>  			if (!regulators[i].desc.name)
>  				continue;
> -			if (!of_node_cmp(child->name,
> +			if (of_node_name_eq(child,
>  					 regulators[i].desc.name)) {
>  				p->id =3D i;
>  				p->init_data =3D of_get_regulator_init_data( diff --
> git a/drivers/regulator/qcom-rpmh-regulator.c b/drivers/regulator/qcom-rp=
mh-
> regulator.c
> index 39ccf53fdeb3..b2c2d01d1637 100644
> --- a/drivers/regulator/qcom-rpmh-regulator.c
> +++ b/drivers/regulator/qcom-rpmh-regulator.c
> @@ -410,7 +410,7 @@ static int rpmh_regulator_init_vreg(struct rpmh_vreg
> *vreg, struct device *dev,
>  	vreg->dev =3D dev;
>=20
>  	for (rpmh_data =3D pmic_rpmh_data; rpmh_data->name; rpmh_data++)
> -		if (!strcmp(rpmh_data->name, node->name))
> +		if (of_node_name_eq(node, rpmh_data->name))
>  			break;
>=20
>  	if (!rpmh_data->name) {
> diff --git a/drivers/regulator/s5m8767.c b/drivers/regulator/s5m8767.c in=
dex
> 219b9afda0cb..654f65abcb5a 100644
> --- a/drivers/regulator/s5m8767.c
> +++ b/drivers/regulator/s5m8767.c
> @@ -561,7 +561,7 @@ static int s5m8767_pmic_dt_parse_pdata(struct
> platform_device *pdev,
>  	pdata->opmode =3D rmode;
>  	for_each_child_of_node(regulators_np, reg_np) {
>  		for (i =3D 0; i < ARRAY_SIZE(regulators); i++)
> -			if (!of_node_cmp(reg_np->name, regulators[i].name))
> +			if (of_node_name_eq(reg_np, regulators[i].name))
>  				break;
>=20
>  		if (i =3D=3D ARRAY_SIZE(regulators)) {
> --
> 2.19.1

