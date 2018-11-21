Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB44C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 22:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B23BF206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 22:11:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B23BF206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=diasemi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389999AbeKVIsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 03:48:08 -0500
Received: from mail1.bemta25.messagelabs.com ([195.245.230.4]:19248 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387621AbeKVIsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 03:48:07 -0500
Received: from [46.226.52.98] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-a.eu-west-1.aws.symcld.net id F1/20-09000-628D5FB5; Wed, 21 Nov 2018 22:11:50 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WTbUxTVxjHOb23txel5ljAPjYWYxP9sHEbLtm
  SSzITdS65zpeoyxLfNr3Qu7ZbW7rei+K+DFSmFZ1EfAPUqoASULfgS3CWxVWJUCsK6nQMdEiD
  UrPMAMqMRu3tBV++/c/z+z/P+Z+Tc2jCMEKZaLFQFn0ewWWhxpFGe8lNZsadJyuzDlaM5/ZGb
  5Dc8b9DiAvHjhJcVXULyZ1q36blKnc1a7gbv+2nuKHtlxDXE26huMiVTi3X8bxNx105L89K4a
  uKOki+qacG8dXBAQ3fWO+n+NO3NpN8XcOIjh9qzFisW6F1enLzC9doHcVd5ZR3h7FwpLOLKkI
  VaVvROJrEvxAQ9FdrlYUB79bAiQsPCHXRhyDWWqzbipJpCnNQ3voPpYA0vBvBhe4jiRYC+wnY
  Uv4MKa5UPA+un9iY0Gn4c/jvp0ekqrPh+JmDiUkkng4DTTcJReuxALFQW8JvwLPh57o98R1oO
  hnPgZLbVqWMsBmGixsSdgIboSsa0CgaMIaa4DVC1ekw0PdSq/pFaNtwB6n1TLh6O4qUkYCnwa
  Zhs1o2Q2egFCnxAf9FQen1LVoVLITgi3ukCroRnPO/IsYGnaoIjGoOakpLSFV74bI/PBooA+q
  39442Rwi49vTIaMMU6LhbRqnAT8HO2kFKPXEePD5wVVeGMivfOZ2qM+HQ+UFK1R/C0cOPiMrE
  hU2EtoooeQiR9YjL9TntDtktOF0Mm5XFsGw2w+Z8xGRnf2wVfmAEq1jArBMlmWGtwjrJKq135
  7lsVo8oN6L4I7R5Q71NqP2YPYQm0xpLup767slKw4TcfNt6hyA5VvsKXKIUQlNo2gL63I44m+
  gT7WLhN05X/CWPYaBTLGn6mQrWS17BLTntKgojhj4b8e8jDKQn3yOajHpWMWHF5CjwvBkx9h8
  6kdmUqkdJSUmGFK/oczvl93kMGWlkSdVPUqakOD3ym51i8RCaeAhzZEgJIQtvkakI8aGslkCo
  t7+E/H8o5/C0F7Pyvny8YO5gV/rynO+XLWh9ZmOWu1m+Obm2rNn945L2nOfOvPy1Xw2ffPXnw
  lD0sz8uTwrf3dwXfPir0GeyaQLfls6/Z+7ZsWTVF2zG1Iu1s7+O3Kfr+henf3pxUaP8ibh0f0
  PVw38zxq++Ja552f17/8mmSxZScgjsB4RPEl4D3+xQZAoEAAA=
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-17.tower-262.messagelabs.com!1542838309!2474228!1
X-Originating-IP: [23.103.133.212]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.14.24; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 6478 invoked from network); 21 Nov 2018 22:11:50 -0000
Received: from mail-vi1eur04lp0212.outbound.protection.outlook.com (HELO EUR04-VI1-obe.outbound.protection.outlook.com) (23.103.133.212)
  by server-17.tower-262.messagelabs.com with AES256-SHA256 encrypted SMTP; 21 Nov 2018 22:11:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com; s=selector1-diasemi-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vz/o3skC1lafWG563om7VmjDEzDR5rxs0KuG4EsnIVo=;
 b=NTkI1Iz9+XNRcYa21CZOFTiH3YIYbm4lM221fmgtOZu8SZ1L6CDfTm6vxnpHhNTwIs0pSDZTryu0BL8s1+DVfwd/61UCiIEy2B8vZQ35gNruofaMpAP3NdqKu6ajxUFslLY+1RbtUxdzkum4wAjgrQBK5phAMDcm/4IbB5VBXWo=
Received: from AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM (10.169.154.17) by
 AM5PR1001MB1185.EURPRD10.PROD.OUTLOOK.COM (10.169.155.141) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.14; Wed, 21 Nov 2018 22:11:48 +0000
Received: from AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::40df:60cd:e157:799f]) by AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::40df:60cd:e157:799f%3]) with mapi id 15.20.1339.029; Wed, 21 Nov 2018
 22:11:47 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "sre@kernel.org" <sre@kernel.org>
CC:     Sameer Nanda <snanda@chromium.org>,
        "gwendal@chromium.org" <gwendal@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "groeck@chromium.org" <groeck@chromium.org>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "bleung@chromium.org" <bleung@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Subject: RE: [PATCH 1/2] power: supply: add input voltage limit property.
Thread-Topic: [PATCH 1/2] power: supply: add input voltage limit property.
Thread-Index: AQHUga/DsCATfi0QpEOEAMwL2ud2VaVaypxQ
Date:   Wed, 21 Nov 2018 22:11:47 +0000
Message-ID: <AM5PR1001MB0994B41A3CE03A098C4DC83680DA0@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
References: <20181121153444.24747-1-enric.balletbo@collabora.com>
In-Reply-To: <20181121153444.24747-1-enric.balletbo@collabora.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.225.80.65]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM5PR1001MB1185;6:SojQTFdHgs0LPrMJXWNEe9A+UFpf/Txvki4aKBjspnaoTxyN3RQBHJU2RmgZ25UFJsHLMfSEfB/3N06NIhKbKioKIm5eQQQw2iFQD9y92lHqKt8rCU7tTSanmuHBFTNOmQSN7Juh8io12TE+QJnHaGYxxfFwZjngT741I9sWaknaVWE/+AleXvzGAFe/IiSsd3l9UfOHKrNYN6buzfyDL0H268pOP/hEgt1t1SwAikS1OwdeeaRoq3i8/qAiNQmhvBtUoL9ky9oScBxN7wmmexlmX3EDGZcJa/R9ItnaoclGPVtEbIBdb3ML5FYBqvW+faqqRxE52/30kdJoQ5EO0DpNdgN8lYaK9LPUlbbHu08I+G5W/xB4AkbuC/E/f4PObv8SK244PwxKAZeIlJjEHKRdw+pW5ZJP4ok+HM+IYpWiaL+5YdgPSbzIzW4E/B1h6TZXtSz5iIAz/t+rqOrsFg==;5:MeEwhUxH7M4NfJ1/6Fr/suFUHwZ+M71iVj+pNm94X4k7p2Tkjs2vUTOkGUI4LoxDK2ERhGnw/aoJnMAXHPgWX8Z1+HzWqHJgInQ09YpmP6ecQv/YdwXDG347medXXE7aTwBavmGAUf7Cx0x06s1muqZUaL3xW9x/N/+63nHhdgk=;7:XK5qNpBw6ZxRrEI2uhq18t+HXfRk+/4/FoY8wyrfrpEws01VyIxGWK8sWuCPMKkzdGm+RTlU7Bf5Fe+IY7ydu0FehNAj3QSXU1UrGPvI8cP/Z+x+XshWfVvuiKP75tD7Ez8284Huh89Pu2L9y33xdg==
x-ms-office365-filtering-correlation-id: 1999d665-406a-4daf-2a26-08d64ffe548b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM5PR1001MB1185;
x-ms-traffictypediagnostic: AM5PR1001MB1185:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-microsoft-antispam-prvs: <AM5PR1001MB1185B7170BF8042DB1DDD811A7DA0@AM5PR1001MB1185.EURPRD10.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231442)(944501410)(52105112)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:AM5PR1001MB1185;BCL:0;PCL:0;RULEID:;SRVR:AM5PR1001MB1185;
x-forefront-prvs: 08635C03D4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(396003)(39850400004)(136003)(199004)(189003)(53546011)(8936002)(7736002)(6506007)(105586002)(99286004)(2201001)(305945005)(486006)(86362001)(106356001)(33656002)(6246003)(446003)(7696005)(2900100001)(11346002)(74316002)(66066001)(4326008)(76176011)(14444005)(476003)(102836004)(316002)(478600001)(6436002)(110136005)(55016002)(54906003)(68736007)(72206003)(256004)(229853002)(2906002)(97736004)(2501003)(9686003)(5660300001)(6116002)(3846002)(55236004)(8676002)(53936002)(186003)(81166006)(81156014)(7416002)(25786009)(71190400001)(71200400001)(14454004)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR1001MB1185;H:AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: IqlHTSfqDq5Uu1nNGjS5mcH2F2Y7+zeLNY6dsWQNruXZL2pDfeiPdlSGkjH8O6yRB47a2JJNjnf4HubTd6dKSscg0VYdeyOtu2mMBOlJj8ICZeSy8uKA87lgOyZnMGeJjz2lx8A/v83+7NW7pvSu4xNOt+3RVbQiJh9mt+rSZvGZcFzvKpDa5ISUozwYUtMqEM9En9P2UmSGTTGYZMeGzp1Uw79Q62ZDmLIxLIVNvkiWMKAKg5lqZAKJBe25q/c10mA51gtdhVbHfi070EzmF8TvbufrX4XUSOswvKHb7J2HJ8chadbXms4BGi0i8ORi+ou0JwNEUrjkUbwiiTFQUb9orqWfD7nYf95GNTiupRs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1999d665-406a-4daf-2a26-08d64ffe548b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2018 22:11:47.7416
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR1001MB1185
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 November 2018 15:35, Enric Balletbo i Serra wrote:

> We have a problem with USBPD chargers which under certain conditions=20
> can result in system overheating if the voltage provided by the USBPD=20
> port is too high. While the preferred means to control this would be=20
> through devicetree or ACPI settings, this is not always possible, and=20
> we need to have a means to set a voltage limit.
>=20
> This patch exposes a new property, similar to input current limit, to=20
> re-configure the maximum voltage from the external supply at runtime=20
> based on system-level knowledge or user input.

I think we should be adding new documentation to the following file for any=
 property changes:

Documentation/ABI/testing/sysfs-class-power

Sebastian can maybe comment further though.=20
=20
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>=20
>  Documentation/power/power_supply_class.txt | 2 ++=20
> drivers/power/supply/power_supply_sysfs.c  | 1 +
>  include/linux/power_supply.h               | 1 +
>  3 files changed, 4 insertions(+)
>=20
> diff --git a/Documentation/power/power_supply_class.txt
> b/Documentation/power/power_supply_class.txt
> index 300d37896e51..7b4be615b4f8 100644
> --- a/Documentation/power/power_supply_class.txt
> +++ b/Documentation/power/power_supply_class.txt
> @@ -137,6 +137,8 @@ power supply object.
>=20
>  INPUT_CURRENT_LIMIT - input current limit programmed by charger.=20
> Indicates the current drawn from a charging source.
> +INPUT_VOLTAGE_LIMIT - input voltage limit programmed by charger.
> +Indicates the voltage limit from a charging source.
>=20
>  CHARGE_CONTROL_LIMIT - current charge control limit setting=20
> CHARGE_CONTROL_LIMIT_MAX - maximum charge control limit setting diff=20
> --git a/drivers/power/supply/power_supply_sysfs.c
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
> diff --git a/include/linux/power_supply.h=20
> b/include/linux/power_supply.h index f80769175c56..608ba88e32ee 100644
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
