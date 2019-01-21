Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57743C3713C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 22:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13EB42089F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 22:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dell.com header.i=@dell.com header.b="WAcHRzAh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727449AbfAUWGH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 17:06:07 -0500
Received: from esa5.dell-outbound.iphmx.com ([68.232.153.95]:45985 "EHLO
        esa5.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725993AbfAUWGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 17:06:06 -0500
X-Greylist: delayed 663 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Jan 2019 17:06:06 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpout;
  t=1548108364; x=1579644364;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=J74y2g9u0fXH+G5ITTxnCjtiq+iMFpCZOehWxkA+TGA=;
  b=WAcHRzAhjBldeqJzwSTd4d49DgE6PMv0TQST0lGWcPQGDfQQToWM0tFd
   9RiAgUYoTh1E6RA8v3RdFIEsh4eJL+61IoFZbfq8DzfzMh+H2rJ1MRaC6
   IbH+gZth7sExwIAm3Bt85rhXPXCbLGjVTDNkt0RBpVXk4817Uvw7EVCyd
   U=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2ECAACnPkZchyeV50NiGgEBAQEBAgE?=
 =?us-ascii?q?BAQEHAgEBAQGBUQUBAQEBCwGDaycKjBFfiwiCDYkliVSFCBSBZwsBAYRsAoJ?=
 =?us-ascii?q?iIjQJDQEDAQECAQECAQECEAEBARUJCCkvgjoigm8BAQEBAxIoPwwEAgEIEQQ?=
 =?us-ascii?q?BAR8QIS4IAgQBDQUIGoMAgWoDFZ8FPQKBbokHAQEBgh6EAwGDew2CHYxBgha?=
 =?us-ascii?q?EI4JXgXcBEgEDhXwCoW0zBwKOYoMxIJIULYlXhjSKPgIEAgQFAhSBRjdncXC?=
 =?us-ascii?q?DPIInDgkTjVQBNkABMYhMgR+BHwEB?=
X-IPAS-Result: =?us-ascii?q?A2ECAACnPkZchyeV50NiGgEBAQEBAgEBAQEHAgEBAQGBU?=
 =?us-ascii?q?QUBAQEBCwGDaycKjBFfiwiCDYkliVSFCBSBZwsBAYRsAoJiIjQJDQEDAQECA?=
 =?us-ascii?q?QECAQECEAEBARUJCCkvgjoigm8BAQEBAxIoPwwEAgEIEQQBAR8QIS4IAgQBD?=
 =?us-ascii?q?QUIGoMAgWoDFZ8FPQKBbokHAQEBgh6EAwGDew2CHYxBghaEI4JXgXcBEgEDh?=
 =?us-ascii?q?XwCoW0zBwKOYoMxIJIULYlXhjSKPgIEAgQFAhSBRjdncXCDPIInDgkTjVQBN?=
 =?us-ascii?q?kABMYhMgR+BHwEB?=
Received: from mx0a-00154901.pphosted.com ([67.231.149.39])
  by esa5.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Jan 2019 15:55:02 -0600
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0LLt2md038651;
        Mon, 21 Jan 2019 16:55:02 -0500
Received: from esa6.dell-outbound2.iphmx.com (esa6.dell-outbound2.iphmx.com [68.232.154.99])
        by mx0a-00154901.pphosted.com with ESMTP id 2q5myb8gk9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Jan 2019 16:55:02 -0500
From:   <Mario.Limonciello@dell.com>
Received: from ausc60ps301.us.dell.com ([143.166.148.206])
  by esa6.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 22 Jan 2019 03:54:39 +0600
X-LoopCount0: from 10.166.132.195
X-IronPort-AV: E=Sophos;i="5.56,504,1539666000"; 
   d="scan'208";a="1248591341"
To:     <2pi@mok.nu>, <dvhart@infradead.org>, <andy@infradead.org>,
        <mjg59@srcf.ucam.org>, <pali.rohar@gmail.com>
CC:     <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/3] platform/x86: wmi: use MODULE_DEVICE_TABLE() instead
 of MODULE_ALIAS()
Thread-Topic: [PATCH 3/3] platform/x86: wmi: use MODULE_DEVICE_TABLE() instead
 of MODULE_ALIAS()
Thread-Index: AQHUr+4ZwsJyy7tq2EGFpDfat+iVT6W6R6yw
Date:   Mon, 21 Jan 2019 21:54:38 +0000
Message-ID: <1c6498f0ba50440c98281531e98e221d@ausx13mpc120.AMER.DELL.COM>
References: <cover.1547827336.git.2pi@mok.nu>
 <e468c28f030e93ec54010878f222c56541d6af00.1547827336.git.2pi@mok.nu>
In-Reply-To: <e468c28f030e93ec54010878f222c56541d6af00.1547827336.git.2pi@mok.nu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.242.75]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-21_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901210171
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Mattias Jacobsson <2pi@mok.nu>
> Sent: Saturday, January 19, 2019 5:56 AM
> To: Limonciello, Mario; dvhart@infradead.org; andy@infradead.org;
> mjg59@srcf.ucam.org; pali.rohar@gmail.com
> Cc: 2pi@mok.nu; platform-driver-x86@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [PATCH 3/3] platform/x86: wmi: use MODULE_DEVICE_TABLE() instead=
 of
> MODULE_ALIAS()
>=20
>=20
> [EXTERNAL EMAIL]
>=20
> WMI drivers can if they have specified an array of struct wmi_device_id
> use the MODULE_DEVICE_TABLE() macro to automatically generate the
> appropriate MODULE_ALIAS() output.
>=20
> Change all driver that have specified an array of struct wmi_device_id
> to use MODULE_DEVICE_TABLE() instead of MODULE_ALIAS().
>=20
> Signed-off-by: Mattias Jacobsson <2pi@mok.nu>

No concerns to the Dell pieces I'm on assuming other patches in series acce=
pted.

Reviewed-by: Mario Limonciello <mario.limonciello@dell.com>

> ---
>  drivers/platform/x86/dell-smbios-wmi.c       | 2 +-
>  drivers/platform/x86/dell-wmi-descriptor.c   | 2 +-
>  drivers/platform/x86/dell-wmi.c              | 4 ++--
>  drivers/platform/x86/huawei-wmi.c            | 3 +--
>  drivers/platform/x86/intel-wmi-thunderbolt.c | 2 +-
>  drivers/platform/x86/wmi-bmof.c              | 2 +-
>  6 files changed, 7 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/platform/x86/dell-smbios-wmi.c b/drivers/platform/x8=
6/dell-
> smbios-wmi.c
> index cf2229ece9ff..c3ed3c8c17b9 100644
> --- a/drivers/platform/x86/dell-smbios-wmi.c
> +++ b/drivers/platform/x86/dell-smbios-wmi.c
> @@ -277,4 +277,4 @@ void exit_dell_smbios_wmi(void)
>  	wmi_driver_unregister(&dell_smbios_wmi_driver);
>  }
>=20
> -MODULE_ALIAS("wmi:" DELL_WMI_SMBIOS_GUID);
> +MODULE_DEVICE_TABLE(wmi, dell_smbios_wmi_id_table);
> diff --git a/drivers/platform/x86/dell-wmi-descriptor.c
> b/drivers/platform/x86/dell-wmi-descriptor.c
> index 072821aa47fc..14ab250b7d5a 100644
> --- a/drivers/platform/x86/dell-wmi-descriptor.c
> +++ b/drivers/platform/x86/dell-wmi-descriptor.c
> @@ -207,7 +207,7 @@ static struct wmi_driver dell_wmi_descriptor_driver =
=3D {
>=20
>  module_wmi_driver(dell_wmi_descriptor_driver);
>=20
> -MODULE_ALIAS("wmi:" DELL_WMI_DESCRIPTOR_GUID);
> +MODULE_DEVICE_TABLE(wmi, dell_wmi_descriptor_id_table);
>  MODULE_AUTHOR("Mario Limonciello <mario.limonciello@dell.com>");
>  MODULE_DESCRIPTION("Dell WMI descriptor driver");
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/platform/x86/dell-wmi.c b/drivers/platform/x86/dell-=
wmi.c
> index 16c7f3d9a335..0602aba62b3f 100644
> --- a/drivers/platform/x86/dell-wmi.c
> +++ b/drivers/platform/x86/dell-wmi.c
> @@ -50,8 +50,6 @@ MODULE_LICENSE("GPL");
>=20
>  static bool wmi_requires_smbios_request;
>=20
> -MODULE_ALIAS("wmi:"DELL_EVENT_GUID);
> -
>  struct dell_wmi_priv {
>  	struct input_dev *input_dev;
>  	u32 interface_version;
> @@ -738,3 +736,5 @@ static void __exit dell_wmi_exit(void)
>  	wmi_driver_unregister(&dell_wmi_driver);
>  }
>  module_exit(dell_wmi_exit);
> +
> +MODULE_DEVICE_TABLE(wmi, dell_wmi_id_table);
> diff --git a/drivers/platform/x86/huawei-wmi.c b/drivers/platform/x86/hua=
wei-
> wmi.c
> index 59872f87b741..52fcac5b393a 100644
> --- a/drivers/platform/x86/huawei-wmi.c
> +++ b/drivers/platform/x86/huawei-wmi.c
> @@ -201,8 +201,7 @@ static struct wmi_driver huawei_wmi_driver =3D {
>=20
>  module_wmi_driver(huawei_wmi_driver);
>=20
> -MODULE_ALIAS("wmi:"WMI0_EVENT_GUID);
> -MODULE_ALIAS("wmi:"AMW0_EVENT_GUID);
> +MODULE_DEVICE_TABLE(wmi, huawei_wmi_id_table);
>  MODULE_AUTHOR("Ayman Bagabas <ayman.bagabas@gmail.com>");
>  MODULE_DESCRIPTION("Huawei WMI hotkeys");
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/platform/x86/intel-wmi-thunderbolt.c
> b/drivers/platform/x86/intel-wmi-thunderbolt.c
> index 9ded8e2af312..4dfa61434a76 100644
> --- a/drivers/platform/x86/intel-wmi-thunderbolt.c
> +++ b/drivers/platform/x86/intel-wmi-thunderbolt.c
> @@ -88,7 +88,7 @@ static struct wmi_driver intel_wmi_thunderbolt_driver =
=3D {
>=20
>  module_wmi_driver(intel_wmi_thunderbolt_driver);
>=20
> -MODULE_ALIAS("wmi:" INTEL_WMI_THUNDERBOLT_GUID);
> +MODULE_DEVICE_TABLE(wmi, intel_wmi_thunderbolt_id_table);
>  MODULE_AUTHOR("Mario Limonciello <mario.limonciello@dell.com>");
>  MODULE_DESCRIPTION("Intel WMI Thunderbolt force power driver");
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/platform/x86/wmi-bmof.c b/drivers/platform/x86/wmi-b=
mof.c
> index c4530ba715e8..8751a13134be 100644
> --- a/drivers/platform/x86/wmi-bmof.c
> +++ b/drivers/platform/x86/wmi-bmof.c
> @@ -119,7 +119,7 @@ static struct wmi_driver wmi_bmof_driver =3D {
>=20
>  module_wmi_driver(wmi_bmof_driver);
>=20
> -MODULE_ALIAS("wmi:" WMI_BMOF_GUID);
> +MODULE_DEVICE_TABLE(wmi, wmi_bmof_id_table);
>  MODULE_AUTHOR("Andrew Lutomirski <luto@kernel.org>");
>  MODULE_DESCRIPTION("WMI embedded Binary MOF driver");
>  MODULE_LICENSE("GPL");
> --
> 2.20.1

