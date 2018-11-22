Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D923C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 16:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C42D420818
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 16:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="swBUPb8N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C42D420818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=diasemi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403938AbeKWDfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 22:35:02 -0500
Received: from mail1.bemta26.messagelabs.com ([85.158.142.6]:42777 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389344AbeKWDfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 22:35:02 -0500
Received: from [85.158.142.98] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-6.bemta.az-a.eu-central-1.aws.symcld.net id 34/A5-08814-55FD6FB5; Thu, 22 Nov 2018 16:54:45 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WTa0wTWRSAe2em0xE7Ziggx2qJNpIYpQ3ouo4
  xJruumzRmfceYiK8BhnaSMrDtENFohCVGXcQYgaxSFR+IBgwmgIqAxtQnpYhUURFQK7Ur+ENj
  FR+bmJ3pgO7+mXz3fOeee87NHQo3fCSNFF8g8S6Rc5rJGKLnduVcy5pnI+mpjYFk9q/QfYI91
  +dFrG+4Bmc9p24SbOPdfVq2svwKxt5vOUKykdIbiB3w3SRZf0dAy3b/065jO1qln/Q2T2E3YW
  seqEa2U21DmK2hdi9pa+rZTdjO1n3U2SINSSt067SCmJFbsFnrKDtRpcu7nVRw8dMNvBB5jX+
  iGIpgzuMQPBvQKgsDU47Bl6+fMXUxiOB8v0c24yiSYaHsznNSEfFMBYJr/SejAmeu4hB+uUzh
  OOY38AdqdArHM0vh1q4QUnk2BB4Eo3GCSYY9zZ1RphkOivxNmMIG5mc4PRKIxscxi6DLNxjdi
  xgTvC+qw9WzEuFJqCqaDwwD1W1duMoJMDT4Vavm89D+x2OkxlOg85HSAyXzNNg/uEANmyBQVY
  KUWYDpJeH6mwGdKpaCt7gaU0U/gkMlHdhYoZa/g4TKLFSX7BrlPOgOXR/NSYLaUiVH2ezH4UP
  b0GjVKVAabhwVx0h4VVFMqCNnwtujnboDKKXyP9OpnALHW9+RKs+CmhOv8crojcVC++EQcRwR
  tYjNcAl2h5TDCU5LWmqqJS1tjkX5WrltFs7K51syeVFycbK0clvcVvfWnExnllXkpQYkP8Ks3
  zXjm9GBM3YvmkRh5gT62Y6RdMOEjNysrQ7O7djkynfybi+aQlFmoJ8OyC7Wxdv5gmzBKb/kMQ
  2U3hxPJz+VNe3O43Lcgl1VPmShLvr3HsINhJgr8sZE+q5Sg1GSHPnitxJj/0MAmYxxNNJoNAZ
  9Hu/KEaT/+2GUSCFzHH1PqaIXROnbScNyE5jchMkfUZqQuO/KWIg0El2x8WXMrwvrXdLk/aV1
  pkvio0/mcPbIjL716f0JRfBL8eHP4eFwysMfiideiO2jV1p2rmojlmd3FpX1zdvwuHxhJKNG6
  PGkoq7tvZO7Ikv21a/1BTlf+Y+LE3bObeltelEfOpi7qNWuX+LYsHpzYuy2puD85U/AM3WPab
  pWuGwm3A4ubSbucnP/AsDGSf4KBAAA
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-9.tower-223.messagelabs.com!1542905685!1566146!1
X-Originating-IP: [213.199.154.53]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.14.24; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 22406 invoked from network); 22 Nov 2018 16:54:45 -0000
Received: from mail-ve1eur02lp0053.outbound.protection.outlook.com (HELO EUR02-VE1-obe.outbound.protection.outlook.com) (213.199.154.53)
  by server-9.tower-223.messagelabs.com with AES256-SHA256 encrypted SMTP; 22 Nov 2018 16:54:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com; s=selector1-diasemi-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E8tvlh3eCIbJpbvSzN/wL+daXxzbIS4ORyl9A158Pl8=;
 b=swBUPb8NJheyrKWNkJ4v2hH87LXnTPYVszCBgAhKKAd499hjWf+kOmKXN3PPD+GCqWjMoGCpjkPaYW7TZ5Kk8phkOjZJN1V8vfsOWeiAIHsords9A4cm2TJSl6/TNvjBSYxErppzbBXD7kXD7VQofTUdUedQKNz3Ss3nodMiZ80=
Received: from AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM (10.169.154.17) by
 AM5PR1001MB1154.EURPRD10.PROD.OUTLOOK.COM (10.169.155.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.26; Thu, 22 Nov 2018 16:54:43 +0000
Received: from AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::40df:60cd:e157:799f]) by AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::40df:60cd:e157:799f%3]) with mapi id 15.20.1339.029; Thu, 22 Nov 2018
 16:54:43 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "sre@kernel.org" <sre@kernel.org>
CC:     Sameer Nanda <snanda@chromium.org>,
        "gwendal@chromium.org" <gwendal@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "groeck@chromium.org" <groeck@chromium.org>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "bleung@chromium.org" <bleung@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Subject: RE: [PATCH v2 1/2] power: supply: add input voltage limit property.
Thread-Topic: [PATCH v2 1/2] power: supply: add input voltage limit property.
Thread-Index: AQHUgkvDqhVPqFDh5U2I2sMaWwTrVKVcAn0g
Date:   Thu, 22 Nov 2018 16:54:43 +0000
Message-ID: <AM5PR1001MB0994D9925D7350BC55E6D08A80DB0@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
References: <20181122101119.29194-1-enric.balletbo@collabora.com>
In-Reply-To: <20181122101119.29194-1-enric.balletbo@collabora.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.225.80.56]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM5PR1001MB1154;6:vI8dmejnVySpeNcgnM4gZbKrkRqopUNB9GVbvykcMhdjgmJuF1rL/Xzsauohq3pj+rsaBu7o4oiGBmNGw4oPvZSxkVvXUFoTbY+ZLClfg9iAL1DKxRDlqTpvQsYjYjgN5O1AzbiXvYFxVpAC4gMhFUUi1ONXlqtptczlj1i12x7WNO3TjBINFRgbeOHjPkFCvraZAPCh3EelTmoxskj/biEmkhI9on2W1C5XvPTNxhYgNlsl/60qlGSee9icq9KKQ2utgrLJt9cIsoJ7ujxFwHDEPFAx9hsNIAPLe6wEVb5gw8FAZYRyho8IvIlbInirURm8ay4MMH2xzIL9RlEiecr/vAvxFX6VB/tq4Xnj5u6nHGKzZJjg/gSRS3D8wT0A2STK1VQSzoza2jFmhMJBpJ/29dmoJHznt7VsS9rqdc+r1EJvnvK6CQG+zbuKscriYbD7z3GnRGab+5THCFqb4w==;5:GoKVjyu+39tzaqERN9s8GzGPZYvHFrSKtDMITrD3l8bnrAEB02NvoFFl7LEjRVWi03aIcEcevZRiezPQPXvwBXrJzpciMlfMrSo82h61g9Ugt5sxrLC/2UToYWMGtHSE9PTmYSTRsQJATX1V7ocJxLm7o+aq/UPN6lmvxGel10Y=;7:Q5EJN1GGKFbuFIejwpBU9+PewIp5rpzx/rK+EgWV7ijTwWx8+D5EuvyyURYNYjanPq3S2tUByYsU1tPZ5kfkAkcgJcL5QVb9gM9fgKHYRo3Nq4yLQeX0B4487NkDj7j0GFCZ5n1rj4wB4imH0LBXoA==
x-ms-office365-filtering-correlation-id: 4d7d7795-e1b0-4804-d614-08d6509b3363
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR1001MB1154;
x-ms-traffictypediagnostic: AM5PR1001MB1154:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-microsoft-antispam-prvs: <AM5PR1001MB1154DC99B097F0ECFC0AD78EA7DB0@AM5PR1001MB1154.EURPRD10.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231442)(944501410)(52105112)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:AM5PR1001MB1154;BCL:0;PCL:0;RULEID:;SRVR:AM5PR1001MB1154;
x-forefront-prvs: 0864A36BBF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(346002)(39850400004)(376002)(396003)(50944005)(199004)(189003)(55236004)(6506007)(106356001)(72206003)(102836004)(68736007)(26005)(105586002)(2501003)(9686003)(55016002)(66066001)(7736002)(33656002)(53936002)(81156014)(74316002)(81166006)(305945005)(7416002)(476003)(2900100001)(25786009)(99286004)(186003)(53546011)(486006)(8676002)(11346002)(446003)(6116002)(3846002)(76176011)(7696005)(8936002)(478600001)(229853002)(54906003)(6436002)(2201001)(316002)(14454004)(575784001)(110136005)(5660300001)(4326008)(6246003)(2906002)(71200400001)(71190400001)(14444005)(256004)(86362001)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR1001MB1154;H:AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: YPzWv4YkQigvje4JR4pP39+8i9smMYKRYqncx0tdQzeuSO17SptjH2s4VPu0iuS8yDddhZjjWjOnkJ+gAhDKZK5YOs89ZHKpK0PaR8N4N0sdSkG2YmA7WZjE6ylMS1HHuX8q9bGNm7I86vfOR///WpOJA9uzH61cLMYy/sVvI+UMleWQtkROOzabXGEroY7Y8vY/QGnxWX3al6YcTehL1Fj6qevX9/0bJri2wM6VcmisAM97iDXGoVDEQPglHYnWmXIEocm4xm8jNVOOt2gGstTNOX0kFlcnNyg0X6twIbFTel4uhPhhD+Ov5/gUHifx6nv6HJAuZ4BkWYz0dTeaRhHhFzNyKPe1AC2G4HsQgjY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d7d7795-e1b0-4804-d614-08d6509b3363
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2018 16:54:43.1056
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR1001MB1154
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 November 2018 10:11, Enric Balletbo i Serra wrote:

> We have a problem with USBPD chargers which under certain conditions can
> result in system overheating if the voltage provided by the USBPD port is=
 too
> high. While the preferred means to control this would be through devicetr=
ee or
> ACPI settings, this is not always possible, and we need to have a means t=
o set a
> voltage limit.
>=20
> This patch exposes a new property, similar to input current limit, to re-=
configure
> the maximum voltage from the external supply at runtime based on system-l=
evel
> knowledge or user input.
>=20
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Reviewed-by: Guenter Roeck <groeck@chromium.org>

Acked-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>

> ---
>=20
> Changes in v2:
> - Document the new property in ABI/testing/sysfs-class-power.
> - Add the Reviewed-by Guenter Roeck tag.
>=20
>  Documentation/ABI/testing/sysfs-class-power | 11 +++++++++++
> Documentation/power/power_supply_class.txt  |  2 ++
>  drivers/power/supply/power_supply_sysfs.c   |  1 +
>  include/linux/power_supply.h                |  1 +
>  4 files changed, 15 insertions(+)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-class-power
> b/Documentation/ABI/testing/sysfs-class-power
> index 5e23e22dce1b..4fb24b0a28df 100644
> --- a/Documentation/ABI/testing/sysfs-class-power
> +++ b/Documentation/ABI/testing/sysfs-class-power
> @@ -335,6 +335,17 @@ Description:
>  		Access: Read, Write
>  		Valid values: Represented in microamps
>=20
> +What:		/sys/class/power_supply/<supply_name>/input_voltage_limit
> +Date:		Nov 2018
> +Contact:	linux-pm@vger.kernel.org
> +Description:
> +		Details the incoming VBUS voltage limit currently set in the
> +		supply. Normally this is configured based on the type of
> +		connection made.
> +
> +		Access: Read, Write
> +		Valid values: Represented in microvolts
> +
>  What:		/sys/class/power_supply/<supply_name>/online,
>  Date:		May 2007
>  Contact:	linux-pm@vger.kernel.org
> diff --git a/Documentation/power/power_supply_class.txt
> b/Documentation/power/power_supply_class.txt
> index 300d37896e51..7b4be615b4f8 100644
> --- a/Documentation/power/power_supply_class.txt
> +++ b/Documentation/power/power_supply_class.txt
> @@ -137,6 +137,8 @@ power supply object.
>=20
>  INPUT_CURRENT_LIMIT - input current limit programmed by charger. Indicat=
es
> the current drawn from a charging source.
> +INPUT_VOLTAGE_LIMIT - input voltage limit programmed by charger.
> +Indicates the voltage limit from a charging source.
>=20
>  CHARGE_CONTROL_LIMIT - current charge control limit setting
> CHARGE_CONTROL_LIMIT_MAX - maximum charge control limit setting diff --gi=
t
> a/drivers/power/supply/power_supply_sysfs.c
> b/drivers/power/supply/power_supply_sysfs.c
> index dce24f596160..5848742ebb59 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -275,6 +275,7 @@ static struct device_attribute power_supply_attrs[] =
=3D {
>  	POWER_SUPPLY_ATTR(charge_control_limit),
>  	POWER_SUPPLY_ATTR(charge_control_limit_max),
>  	POWER_SUPPLY_ATTR(input_current_limit),
> +	POWER_SUPPLY_ATTR(input_voltage_limit),
>  	POWER_SUPPLY_ATTR(energy_full_design),
>  	POWER_SUPPLY_ATTR(energy_empty_design),
>  	POWER_SUPPLY_ATTR(energy_full),
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h =
index
> f80769175c56..608ba88e32ee 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -122,6 +122,7 @@ enum power_supply_property {
>  	POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT,
>  	POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX,
>  	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
> +	POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT,
>  	POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN,
>  	POWER_SUPPLY_PROP_ENERGY_EMPTY_DESIGN,
>  	POWER_SUPPLY_PROP_ENERGY_FULL,
> --
> 2.19.1

