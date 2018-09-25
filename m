Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9364EC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37D4220877
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="eLQjVx+j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37D4220877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbeIYX1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 19:27:47 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:64711 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbeIYX1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 19:27:47 -0400
X-IronPort-AV: E=Sophos;i="5.54,303,1534834800"; 
   d="scan'208";a="20580958"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 25 Sep 2018 10:19:18 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 25 Sep 2018 10:19:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LhbiIG2ikO+MPYLs9avAJglAlMnxpKR6qJ9kahhRp4Y=;
 b=eLQjVx+j/Dge/ar7QZiVspGFtjuk3rAHgr7RWxRqT+xz2/yw3bLTOZNTYFSUzoQjNsZsi9DHMHmYPhqMWaegiZB3+xJmWWGxBUEHyjcR2N+PuxJ9xeAgj2wtSfpiMxFKOkb8oKmPjYKkW2kTQDF7yvuP6JVf7D83LeRPNOS36WE=
Received: from BN6PR1101MB2130.namprd11.prod.outlook.com (10.174.112.135) by
 BN6PR1101MB2113.namprd11.prod.outlook.com (10.174.112.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.22; Tue, 25 Sep 2018 17:19:07 +0000
Received: from BN6PR1101MB2130.namprd11.prod.outlook.com
 ([fe80::389e:3b37:851c:1235]) by BN6PR1101MB2130.namprd11.prod.outlook.com
 ([fe80::389e:3b37:851c:1235%11]) with mapi id 15.20.1143.019; Tue, 25 Sep
 2018 17:19:07 +0000
From:   <Woojung.Huh@microchip.com>
To:     <f.fainelli@gmail.com>, <netdev@vger.kernel.org>
CC:     <davem@davemloft.net>, <UNGLinuxDriver@microchip.com>,
        <steve.glendinning@shawell.net>, <keescook@chromium.org>,
        <akurz@blala.de>, <hayeswang@realtek.com>,
        <kai.heng.feng@canonical.com>, <grundler@chromium.org>,
        <zhongjiang@huawei.com>, <bigeasy@linutronix.de>,
        <ran.wang_1@nxp.com>, <edumazet@google.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net 3/7] lan78xx: Check for supported Wake-on-LAN modes
Thread-Topic: [PATCH net 3/7] lan78xx: Check for supported Wake-on-LAN modes
Thread-Index: AQHUVElSRngOMbMRpUm9i69iXavPIaUBPgVg
Date:   Tue, 25 Sep 2018 17:19:07 +0000
Message-ID: <BN6PR1101MB2130115311A87CCF7D712B0FE7160@BN6PR1101MB2130.namprd11.prod.outlook.com>
References: <20180924205420.31309-1-f.fainelli@gmail.com>
 <20180924205420.31309-4-f.fainelli@gmail.com>
In-Reply-To: <20180924205420.31309-4-f.fainelli@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Woojung.Huh@microchip.com; 
x-originating-ip: [47.19.18.123]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR1101MB2113;6:yyUguSEQfhfqi5Pki39SuMvUJEidcsByu9Ja1dNy4wlymzmz2PgacN0+e22HaGxVQz28jUl6CVMWxlrwSaUSHIRHraQ1yqiFUcVsSFhmwhSDs5oTcfnDSqksK+ceM+5JyuCq/E43Vm/GybhxyZyKLuTDJoU4FW/f4xqCHUtbITgSuZEz2BHQhpTWpBc4QxvNfrSzdESBZOOBv/bnnrcCQ+VWRx52+frmKUqg1Fwge5O6c1tZ5PGZ23dql3WJROmTJYqxoCdtS/AwrYvHHquXaUBppH4PeJAMr8a1wWGqvp0kmtGiRRfv7h294s7JODkvV589SOp6yOvVywt3R8WlsRAaCsDXjgsGhlIUzAkZzNPC2rsokJVIl/HzAZi14wrnP1KLnibmd8R2OxzpPxPqG4wYlaupwtDS9TAia9XHePR9+SCJm2rAP+CseTh9hyHODcm2203sq/1565WiEDr1PA==;5:NWNrxVEOgNpsPGQZIOJhHjTjbUhptktCmDq767MdsnEFOtpOQobYy8EPoxSS+mlumt8oKbbmRuC3NhCyS/ScsHlukYo/bdZZoAYXV96TjfBxzxGUCs+N0rHOfruZsuB+eNJ2P8fsFML/eFg2Gf96Y2gr8deE/3c7ZML8FPZ1aWA=;7:ZNb24QA/hgFKJqE1pebYaYUvrSCGxCpCJyQCAe5RSzJ758v0aaKdC9UsKzD0LTzNspXBQOsr1XGUyOcwQ+X5+WAOMd8PYrM3pWy20DB0F++sctluBRO1vveObHWy+AxXMi/P3j07EhI6GgIgPsDvCq6oneKSuPAZvX8lGV3A+AglG+HCHalEj5tFZoT3oIvzwOjdaBhzKIlZCzK1x82GvZcPru94fh+PND3R1cWKTQGa0Gd16HU/dO7H86dR9Y2I
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 121798f1-4d79-412d-7052-08d6230b0055
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN6PR1101MB2113;
x-ms-traffictypediagnostic: BN6PR1101MB2113:
x-ld-processed: 3f4057f3-b418-4d4e-ba84-d55b4e897d88,ExtAddr
x-microsoft-antispam-prvs: <BN6PR1101MB2113D82BEF04F64C3465CB7EE7160@BN6PR1101MB2113.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(823301075)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(149066)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051);SRVR:BN6PR1101MB2113;BCL:0;PCL:0;RULEID:;SRVR:BN6PR1101MB2113;
x-forefront-prvs: 08062C429B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(136003)(346002)(366004)(189003)(199004)(5250100002)(5660300001)(7736002)(478600001)(305945005)(97736004)(6116002)(3846002)(6506007)(316002)(71200400001)(71190400001)(72206003)(6246003)(7696005)(8936002)(33656002)(39060400002)(99286004)(54906003)(25786009)(76176011)(4326008)(110136005)(81166006)(8676002)(68736007)(14454004)(102836004)(106356001)(53936002)(2900100001)(81156014)(486006)(66066001)(256004)(446003)(476003)(11346002)(26005)(6436002)(105586002)(229853002)(9686003)(86362001)(2501003)(74316002)(2906002)(55016002)(186003)(34290500001)(7416002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR1101MB2113;H:BN6PR1101MB2130.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: HEOFi1u+e2mAtRRvccyivZDFbu5R8zEgwOsy5Nmo0J8ptZZ2nM10s7zGi6ZsU21RTv8V6xLG6r5xElVXQ8aA7JLJ7pT9OlIE8MhGYJN0CNyGCTDnw7aTjdmIzT0JaZzuxQIC/fjAcmHDn99o1+rJwVGm2tkRweEQumBwD143ZuuZnO8LdXPdLLWTWPQNWVv34QJSdCqBm2ikM4YAloucNfMRmQgwNtxfd+JDrPsodEastHw/5aq4jWmEqeei6kAnO0vttTzFcmT39Z306+Ero+WIJEkWVc7NZ6I4PUImWdbAAZsAtCOmg8avRHzhXqQJkztBwJaml+Qg/nVBji9wEX40SiF19et22PvNjEEKe1I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 121798f1-4d79-412d-7052-08d6230b0055
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2018 17:19:07.4673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2113
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

> @@ -1415,6 +1415,9 @@ static int lan78xx_set_wol(struct net_device *netde=
v,
>  	if (wol->wolopts & WAKE_ARP)
>  		pdata->wol |=3D WAKE_ARP;
>=20
> +	if (pdata->wol =3D=3D 0)
> +		return -EINVAL;
> +
It will make function return when disabling WOL.
Is there other place handling this scenario?

>  	device_set_wakeup_enable(&dev->udev->dev, (bool)wol->wolopts);
>=20
>  	phy_ethtool_set_wol(netdev->phydev, wol);


Thanks.
Woojung
