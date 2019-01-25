Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 482CAC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 08:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 171EA21919
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 08:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="aI2tdL8Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbfAYIRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 03:17:07 -0500
Received: from mail-eopbgr790054.outbound.protection.outlook.com ([40.107.79.54]:54144
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726200AbfAYIRH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 03:17:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ojI+cD2nSVPQfEQkeodG+4CZhQ2yvXom5FBpe9K5B8I=;
 b=aI2tdL8YujOSJmZn4GVtlyvnF6MZo8+5hQxEvyZamzDKa1zdkLYC/Gsowc7QnRvHDHYtVq0g0Vjlbwpz9xhStB6eWMC7kj/z4qRhMiyZ50G3acYeNy144XjS7VSH/m+KSVSVJLcuaDpNSKrMB+jtdlVi8D2f9/41QkGX2R8+r4M=
Received: from SN6PR03MB4398.namprd03.prod.outlook.com (20.177.255.219) by
 SN6PR03MB3629.namprd03.prod.outlook.com (52.135.80.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.16; Fri, 25 Jan 2019 08:17:03 +0000
Received: from SN6PR03MB4398.namprd03.prod.outlook.com
 ([fe80::59c4:7034:c325:36f]) by SN6PR03MB4398.namprd03.prod.outlook.com
 ([fe80::59c4:7034:c325:36f%2]) with mapi id 15.20.1558.021; Fri, 25 Jan 2019
 08:17:03 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] watchdog: dw: use devm_watchdog_register_device()
Thread-Topic: [PATCH] watchdog: dw: use devm_watchdog_register_device()
Thread-Index: AQHUtILe/7eTCenrE02uek0ahDuG96W/oCaAgAAByoA=
Date:   Fri, 25 Jan 2019 08:17:03 +0000
Message-ID: <20190125161049.7884cda4@xhacker.debian>
References: <20190125154604.66801c6a@xhacker.debian>
        <b521625b-ffff-ba49-77d7-018ad363db36@roeck-us.net>
In-Reply-To: <b521625b-ffff-ba49-77d7-018ad363db36@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.33.119.15]
x-clientproxiedby: TY2PR02CA0057.apcprd02.prod.outlook.com
 (2603:1096:404:e2::21) To SN6PR03MB4398.namprd03.prod.outlook.com
 (2603:10b6:805:fd::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR03MB3629;6:zbELXg7jBSfyHA4AK3dQ7ea+3CWrGo2INskKmFFCNiLU59ol5cGq2tm8rjLYhInJLbF53qCN8q4kbVLbwBiMdeKdXAa+4tTKVoFV2Z0FIhu+7tDQ6udpQCKlRbWAfX27nR1xSv5YaS7qx2gLymT34sHpTHthWjw+N/pv+9+lhjc+49OmAZixs3T0wU4lEZ3WAArcRD/vt2dlkZeM9rslkAnkpikF9fTxXCWgZR/a8aPUnWxefo3FUnoS6Ex+5i3RUhwqRl3XcwNHGb8/XyZ0oLaNyQ6atYIhgiWZXkPmFjbMuBcieWU6ojmZ7ZTFXzuuaAZbaUt0oK3aSKbyjNUt3nxem8iTTCIbUCpbnPbzpReXfFdmx8kbIDPr3M2chaCzXoW1jYCuQCm3wDOKBxH9E14ZmTDEwMFKX/VQYz9keIavlgbi8wHfuSQ8HioY5fQz14Pty0Uj8Bh7DzoLbA9cFw==;5:IWXiMw8L1EzTBOfipGqoGxyZbd33OXGSQa5BaqGbtIy878yMPv/uTzvAhA8IK7v9T9J4pvLBii5Wt+rUBKb+dV4rK4NhiLImmdbSQHcc25ycuRzOrP31AuxPFIUK6irNpGQVBmi5Zpm/vWyqTd7Uku6skuynZmKAH6swvrXsSilN5ybH87QclrQRO3nLzbMy3WfWuDAhyDLi7se9S2Fy8w==;7:4EtYAvMt0NYvsMwkHymz/7adLn9/JQziAnDm9HU8poMVJDNufVEP7DgFd2WdEnyalXjzXGuzRzetARw4rZSrR62sFSxwaFGc9Clj0RPEruhN+JQWAURcG9GgCh1sIhHwz0IIETXzKwguxxuCmLCFdw==
x-ms-office365-filtering-correlation-id: 32be768c-2a5a-4bfa-9782-08d6829d7ca3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:SN6PR03MB3629;
x-ms-traffictypediagnostic: SN6PR03MB3629:
x-microsoft-antispam-prvs: <SN6PR03MB362927950EE2890219B85F3CED9B0@SN6PR03MB3629.namprd03.prod.outlook.com>
x-forefront-prvs: 0928072091
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(136003)(366004)(396003)(199004)(189003)(71190400001)(76176011)(71200400001)(316002)(54906003)(14444005)(1076003)(99286004)(256004)(2906002)(52116002)(478600001)(53936002)(66066001)(86362001)(33896004)(97736004)(6916009)(14454004)(72206003)(6246003)(9686003)(4326008)(105586002)(186003)(486006)(229853002)(6486002)(6436002)(25786009)(106356001)(3846002)(6116002)(50226002)(476003)(8936002)(26005)(6512007)(68736007)(102836004)(386003)(6506007)(53546011)(11346002)(7736002)(446003)(81156014)(8676002)(81166006)(305945005)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR03MB3629;H:SN6PR03MB4398.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 13ntzUxkK+U5P4C85SeubwS2ZRvyZrh79ZmViwUz4R1m6jkE8CdmOH+JyFOwFNe3x2nPz0JJKAkWmZkkQcejx6kCzg9vVrC9/GJbHxPlJf8DL7gn7hZGcTk8tH3NMEPzs69Szrz5IdnHNWgWwe5d5HBMFL2t9tTG3KgcZ7cjmS9vE4sErpF3CqzWuQoIdfS2AW4G6fd09AZbVHC/6jQt9GmMAxzprz4r5sR+7clm3TLwFshpxxIPpAQECcFuDg4AEXve6hAxljWIMlHMe0wuEurryC92LXA0ZaVgAHqmnQwyGoG1jTiuCWZax0dhtNyeH2WgquQzv9hjwyurU8fOftTuBhGINOdMzDHPUdxAH8b0a+pALLRAhh2+mzM0XwhuNx4yxDTxepnKzdo9+n1ip2YmEXETJVlCkV3kvQStlSk=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2512D164BD533F4C9B7FD510FDFD7507@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32be768c-2a5a-4bfa-9782-08d6829d7ca3
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2019 08:17:01.7085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3629
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 25 Jan 2019 00:04:25 -0800 Guenter Roeck wrote:

> Hi,
>=20
> On 1/24/19 11:52 PM, Jisheng Zhang wrote:
> > Use devm_watchdog_register_device() to simplify the code.
> >=20
> > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> > ---
> >   drivers/watchdog/dw_wdt.c | 3 +--
> >   1 file changed, 1 insertion(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
> > index 501aebb5b81f..c053c2de5c2f 100644
> > --- a/drivers/watchdog/dw_wdt.c
> > +++ b/drivers/watchdog/dw_wdt.c
> > @@ -303,7 +303,7 @@ static int dw_wdt_drv_probe(struct platform_device =
*pdev)
> >  =20
> >   	watchdog_set_restart_priority(wdd, 128);
> >  =20
> > -	ret =3D watchdog_register_device(wdd);
> > +	ret =3D devm_watchdog_register_device(wdd);
> >   	if (ret)
> >   		goto out_disable_clk;
> >  =20
> > @@ -318,7 +318,6 @@ static int dw_wdt_drv_remove(struct platform_device=
 *pdev)
> >   {
> >   	struct dw_wdt *dw_wdt =3D platform_get_drvdata(pdev);
> >  =20
> > -	watchdog_unregister_device(&dw_wdt->wdd);
> >   	reset_control_assert(dw_wdt->rst);
> >   	clk_disable_unprepare(dw_wdt->clk);
> >  =20
> >  =20
> Unfortunately it isn't that easy. The other two calls have to be executed=
 after
> unregistering the watchdog, meaning you would have to add devm_add_action=
()
> in the probe function to call them.

do you mean reset_control_asser() and the clk_disable_unprepare()? If yes,
does unregister the watchdog could trigger any register access? Per my
understanding, there's no register access path in the unregister. Am I
missing somthing?

Thanks
