Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 453EAC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E75BE2086D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="psrZDwyp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E75BE2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=diasemi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbeLMONm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 09:13:42 -0500
Received: from mail1.bemta26.messagelabs.com ([85.158.142.112]:41938 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727707AbeLMONl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 09:13:41 -0500
Received: from [85.158.142.194] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-b.eu-central-1.aws.symcld.net id 12/3B-18492-F09621C5; Thu, 13 Dec 2018 14:13:35 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WTf0wTZxjHeXs/epoee3vgeGRizJmZobSjkJl
  bSJYNk+WSbcnmMv9YyOa1HG2T9oDeNVazLIxNF0TnGDOyyob8GCFAYgQUtcwpSpSqXaRzQzfC
  CDUKbIQM9kOx23ocuO2/z/t8v+/3ed4378sQ3CKdzcghTQ4oko+nV5Oep9O32h7zciX5zYmNw
  pFEnBS6fxhEQnS6nRCOtg6RQm/sACWEP/3KJMTPNtLC/MFLSBiLDtHCtasjlHBjcdgsXI1oz1
  vEo1U3SPH0WBsSWwemTGJPZw0t9t38kBQ7uv4wi/M96181v0l5FWd5aCflGY9sq6jODZ3vriO
  q0J/8frSKIfFxAmINT+1HqxkOHzbB+5OXCGORQPD7mVZCd9FYgPorP9G6kIkPIzj/YwulLwh8
  joCLF86kFIbJwC/B+Birb8jEL8NM7GvS4AL4rumKyWj3JESSo0uhLJbgzvwc0pnDL0Dil1mzH
  rMKF8PtloBeRjgHFt7rWrITOAtuJ5qWYgBjaBv4hjB4DUxN/kUZfhmGq0eRUc+D698nlpmH9t
  EwZXAOjDTVIn18wLdoONk5uxz6CjR91EgYQhxBdW8LvZIUPZEkDRagrXbvMlfAbPeA2eD10Hl
  wYrk+RsCD3ncNXgfj4x1mIzRJQV98gTRO7IK5z6+bP0Z54f+czuA8OBb5lTZ4C7Q3zxDhpQuz
  wvBnCfIYIjvRs86A1+3R/JLXZ3Pk59scjkLbM7aCwq12aY/NaZeDNpesaAEppdqlXapd3e13+
  Urtiqz1oNQTLK2kfj6NHja7B9FaxsSvYYMF1hIu3VleutsjqZ63A0GfrA6idQzDA7vo5ko4a0
  B2y6Eyry/1jldkYCx8Jjusy6xaIflVr9uQoqiQOXWtpoFgLtf81khwpFKuyNlZ7OO6FetWT1B
  5FLTyJ0ZQTnYGi9LS0jhLhRzwe7X/69Moi0F8BhvTUyxeRXvUbzo1iik1iq/PpI+iSf9K2VVI
  e+KNym3bJ6zHY6e+wKKLmKu/3MjVxSf/LnIdOoeqlE3J+1bL1JZwmcq8s+H1mdfSLxSVThT37
  xk61H9gR02ydlqsey6SF9rkOFuZu+GTfX0THdGyWx9MHlmI9sfn7r7lP3nPs3an6dvcwaDbvm
  Avutj1YtoUv69++82GE19uznAW86TqkRybiYAq/QMnxxoLDgQAAA==
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-13.tower-239.messagelabs.com!1544710415!2255613!1
X-Originating-IP: [104.47.14.54]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.14.24; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 21955 invoked from network); 13 Dec 2018 14:13:35 -0000
Received: from mail-vi1eur04lp2054.outbound.protection.outlook.com (HELO EUR04-VI1-obe.outbound.protection.outlook.com) (104.47.14.54)
  by server-13.tower-239.messagelabs.com with AES256-SHA256 encrypted SMTP; 13 Dec 2018 14:13:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com; s=selector1-diasemi-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/e14pt0UpNUI5B9UVCst1O+LdlnkpbBfgXJkrAnGKKc=;
 b=psrZDwyp3S9ftkndTHBWhatAczJPyDyZuYHrPXhoTwDyj+tSrX3BaqFIuhIIAECBiIYDcUaeNT8bnsruUvKZSPYKsOi+hp76wDi6jMt0fYqPMkjpT15jk6999mpU2URYuGoePXuzrdu3nfR5d2aY8Y2rHlY02zWvx0K3nxGAKWo=
Received: from AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM (10.169.154.17) by
 AM5PR1001MB1203.EURPRD10.PROD.OUTLOOK.COM (10.169.155.147) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Thu, 13 Dec 2018 14:13:34 +0000
Received: from AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::915f:2c34:17a1:da64]) by AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::915f:2c34:17a1:da64%10]) with mapi id 15.20.1425.016; Thu, 13 Dec
 2018 14:13:34 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "sre@kernel.org" <sre@kernel.org>
CC:     Sameer Nanda <snanda@chromium.org>,
        "bleung@chromium.org" <bleung@chromium.org>,
        "gwendal@chromium.org" <gwendal@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "groeck@chromium.org" <groeck@chromium.org>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        "kernel@collabora.com" <kernel@collabora.com>,
        Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>
Subject: RE: [PATCH v3 1/2] power: supply: add input voltage limit property
Thread-Topic: [PATCH v3 1/2] power: supply: add input voltage limit property
Thread-Index: AQHUktzE1+feJ175xEu2FDJ71BlvIKV8tfeg
Date:   Thu, 13 Dec 2018 14:13:34 +0000
Message-ID: <AM5PR1001MB0994B12D02798D56BC1C550780A00@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
References: <20181213120944.30967-1-enric.balletbo@collabora.com>
In-Reply-To: <20181213120944.30967-1-enric.balletbo@collabora.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.240.73.196]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM5PR1001MB1203;6:z7iQymmFQ7hqtfbWl/2+PFCwYa3BteYV008BB4Asz1alyehitMrtVwAWl+NqJQ/pAZCE9mqu699ggPYJKiKXCT+Gsg1t93aavVz2bi2Hklx4ooptoHtAZ/PUIHDHdiwpa71Gx2mJbU47nat469PIBojnPpek9ZSDtU1G38b3+GyveW0XXkD6B7PfqoCu51eriMvhx1T1y6Ff1Lszb8SGW2XlAS4keYuucuBsniR+7N2m1OtiWv/0Ruk7TNzT1ADXx6gVEq45qbB5h33m3GG4KKBr4zpchWeBSlAM1++VZpcih9SJ/pTQil1KdxUjMV0bqNNm9ZcpoNI/74/+aT3wj6iafGIOiOw8MQ09M8mqKX7zF1TRzfScX+AXW8IJZxs7N8izsV/2W34HsDzvmjH/YPSuy53wmiigPiTRRGOINOmtICnM8FiWGiy+L6snz/3RsKcideKqsqje4wDFeVEl8w==;5:hwU3BC3vK5kP+2vDBqSrzQ2BZlLNgIKaCJaHbdPhdRIzcTWdKjNx1dSm0RaS5hfplCtfOIozgsh0EZV30l53UaZY1BQBundXAjCETOZsF06Z9CdNbXSYGrLKym3Mka3MlQCBv3ZLRBtmYtGZ0sCu2wJ7sqGTuPBHYXn5AlCNfi4=;7:PwBePct1ojA0dKYfVtdnc+elzYwdZUZ6NYBCiXMDjhn8EwEBOYJYN38CrkCPOQm7QohHh/omFPft8YQAwl6HPzeFyNeyax6uuqqbnfJZqdAAmM6uFQm7ywqKpYuny88DY3xaZeo2FsjKqr86ZoJdSw==
x-ms-office365-filtering-correlation-id: 235eecf9-0dc2-494a-c108-08d661052af0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR1001MB1203;
x-ms-traffictypediagnostic: AM5PR1001MB1203:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-microsoft-antispam-prvs: <AM5PR1001MB1203D27C989625E58CBE0DBAA7A00@AM5PR1001MB1203.EURPRD10.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(3231475)(944501520)(52105112)(93006095)(93001095)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:AM5PR1001MB1203;BCL:0;PCL:0;RULEID:;SRVR:AM5PR1001MB1203;
x-forefront-prvs: 088552DE73
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(396003)(346002)(376002)(50944005)(189003)(199004)(305945005)(33656002)(6506007)(446003)(26005)(99286004)(53546011)(5660300001)(55016002)(102836004)(68736007)(110136005)(8676002)(74316002)(54906003)(81156014)(66066001)(81166006)(6246003)(7416002)(7696005)(486006)(7736002)(186003)(11346002)(53936002)(9686003)(4326008)(316002)(76176011)(2906002)(71190400001)(71200400001)(25786009)(229853002)(478600001)(86362001)(3846002)(6116002)(2201001)(106356001)(2501003)(105586002)(97736004)(14444005)(256004)(72206003)(14454004)(8936002)(476003)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR1001MB1203;H:AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: gaShBC0UvPfk+zeEhQ/t51oakfGvXFisw234PZQ4ZujYk697mEEspX68K518A8WJo2bimJPqteZ9IsU/IigzOs1DcHEcx/aR2rL8b/Ez9Zkgc//x+9eiD5k30kGlUsbwRxT2M6rPZz/EhpQLSVuTFphXjdryU7Ms9gS4KUp52Dvv2eTTQf1P4mq9Z9LLH4/vgYIj27UIkRVUvtkYcNfUwaZYX1XRmWSUjDalvh4pHchcuKTiaFXsipN24WwmqypM+mDtqEJTm4vnG15eV9j9G3UMJGwSM4aC8rwB7mS9mam7j6FR5uwV9IdlXVCBGnr+
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 235eecf9-0dc2-494a-c108-08d661052af0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2018 14:13:34.1484
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR1001MB1203
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 December 2018 12:10, Enric Balletbo i Serra wrote:

> This is part of the Pixel C's thermal management strategy to effectively =
limit the
> input power to 5V 3A when the screen is on. When the screen is on, the di=
splay,
> the CPU, and the GPU all contribute more heat to the system than while th=
e
> screen is off, and we made a tradeoff to throttle the charger in order to=
 give
> more of the thermal budget to those other components.
>=20
> So there's nothing fundamentally broken about the hardware that would cau=
se
> the Pixel C to malfunction if we were charging at 9V or 12V instead of 5V=
 when
> the screen is on, ie if userspace doesn't change this.
>=20
> What would happen is that you wouldn't meet Google's skin temperature tar=
gets
> on the system if the charger was allowed to run at 9V or 12V with the scr=
een on.
>=20
> For folks hacking on Pixel Cs (which is now outside of Google's official =
support
> window for Android) and customizing their own kernel and userspace this w=
ould
> be acceptable, but we wanted to expose this feature in the power supply
> properties because the feature does exist in the Emedded Controller firmw=
are of
> the Pixel C and all of Google's Chromebooks with USB-C made since 2015 in=
 case
> someone running an up to date kernel wanted to limit the charging power f=
or
> thermal or other reasons.
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
> Changes in v3:
> - Improve commit log and documentation with Benson comments.
>=20
> Changes in v2:
> - Document the new property in ABI/testing/sysfs-class-power.
> - Add the Reviewed-by Guenter Roeck tag.
>=20
>  Documentation/ABI/testing/sysfs-class-power | 15 +++++++++++++++
> Documentation/power/power_supply_class.txt  |  2 ++
>  drivers/power/supply/power_supply_sysfs.c   |  1 +
>  include/linux/power_supply.h                |  1 +
>  4 files changed, 19 insertions(+)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-class-power
> b/Documentation/ABI/testing/sysfs-class-power
> index 5e23e22dce1b..6dee5c105a28 100644
> --- a/Documentation/ABI/testing/sysfs-class-power
> +++ b/Documentation/ABI/testing/sysfs-class-power
> @@ -335,6 +335,21 @@ Description:
>  		Access: Read, Write
>  		Valid values: Represented in microamps
>=20
> +What:		/sys/class/power_supply/<supply_name>/input_voltage_limit
> +Date:		Nov 2018
> +Contact:	linux-pm@vger.kernel.org
> +Description:
> +		This entry configures the incoming VBUS voltage limit currently
> +		set in the supply. Normally this is configured based on
> +		system-level knowledge or user input (e.g. This is part of the
> +		Pixel C's thermal management strategy to effectively limit the
> +		input power to 5V when the screen is on to meet Google's skin
> +		temperature targets). Note that this feature should not be
> +		used for safety critical things.
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
> 2.19.2

