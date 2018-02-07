Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753597AbeBGJj2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 04:39:28 -0500
Received: from mail-eopbgr20081.outbound.protection.outlook.com ([40.107.2.81]:9088
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753456AbeBGJj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 04:39:26 -0500
From: Vadim Pasternak <vadimp@mellanox.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>
CC: Arnd Bergmann <arnd@arndb.de>,
        "platform-driver-x86@vger.kernel.org"
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] platform/mellanox: mlxreg-hotplug: Fix uninitialized
 variable
Thread-Topic: [PATCH] platform/mellanox: mlxreg-hotplug: Fix uninitialized
 variable
Thread-Index: AQHTn/O63+WT4NlsbkmrfFu37e/vvqOYruAw
Date: Wed, 7 Feb 2018 09:39:22 +0000
Message-ID: <AM4PR05MB3330B66B4D7077DA6EAB882EA2FC0@AM4PR05MB3330.eurprd05.prod.outlook.com>
References: <1517994724-5931-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1517994724-5931-1-git-send-email-geert@linux-m68k.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vadimp@mellanox.com;
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM4PR05MB1650;7:XMl238lsc50jfPjVwAj7HiK1DBC607XCgZB4bOesIRE1ASI43oKCxlDj8Jy2iCnJToIFOape0XFLIsLalz/LE4ClaIz9ABif9U9ML97qsWiyBUGsv1hugqNzby1W9tTPSJ7xuEH/cXOd75Sp65uVKlsM9ObyuhYz3LQapIi5c/7M8nM0dHhJ2TTnFVgI5C/m0/vzuAjh691qHr2NNYJNxULsxENvr5pMMWJCM5uLQlWHqLHA/NeSqx5rVmjuyNor
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d270d216-e2bc-48ad-f28d-08d56e0eab10
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:AM4PR05MB1650;
x-ms-traffictypediagnostic: AM4PR05MB1650:
x-microsoft-antispam-prvs: <AM4PR05MB1650117D345DB91A30FB3E10A2FC0@AM4PR05MB1650.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231101)(2400082)(944501161)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:AM4PR05MB1650;BCL:0;PCL:0;RULEID:;SRVR:AM4PR05MB1650;
x-forefront-prvs: 0576145E86
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(346002)(376002)(39380400002)(396003)(199004)(189003)(13464003)(6436002)(53546011)(54906003)(3846002)(110136005)(2906002)(5660300001)(316002)(59450400001)(5250100002)(186003)(106356001)(25786009)(81166006)(2900100001)(6116002)(8676002)(7696005)(6506007)(102836004)(105586002)(66066001)(76176011)(8936002)(14454004)(33656002)(4326008)(229853002)(53936002)(81156014)(26005)(86362001)(575784001)(97736004)(3280700002)(3660700001)(478600001)(9686003)(55016002)(74316002)(7736002)(305945005)(68736007)(6246003)(99286004)(2950100002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR05MB1650;H:AM4PR05MB3330.eurprd05.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: oycgnSdbafHML+rymFv214OL+JJYScTMft3vMyyJVpRVKLB4C86BNzu7lxont+gLyumo1aIPtQokUJQJVxDMaw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d270d216-e2bc-48ad-f28d-08d56e0eab10
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2018 09:39:22.1092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR05MB1650
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w179dWgv026852



> -----Original Message-----
> From: Geert Uytterhoeven [mailto:geert@linux-m68k.org]
> Sent: Wednesday, February 07, 2018 11:12 AM
> To: Andy Shevchenko <andy@infradead.org>; Darren Hart
> <dvhart@infradead.org>; Vadim Pasternak <vadimp@mellanox.com>
> Cc: Arnd Bergmann <arnd@arndb.de>; platform-driver-x86@vger.kernel.org;
> linux-kernel@vger.kernel.org; Geert Uytterhoeven <geert@linux-m68k.org>
> Subject: [PATCH] platform/mellanox: mlxreg-hotplug: Fix uninitialized variable
> 
> With gcc-4.1.2:
> 
>     drivers/platform/mellanox/mlxreg-hotplug.c: In function
> ‘mlxreg_hotplug_health_work_helper’:
>     drivers/platform/mellanox/mlxreg-hotplug.c:347: warning: ‘ret’ is used
> uninitialized in this function
> 
> Indeed, if mlxreg_core_item.count is zero, ret is used uninitialized.
> 
> While this is unlikely to happen (it is set to ARRAY_SIZE(...) in x86 board files),
> this is done in another source file, so fix this by preinitializing ret to zero.
> 
> Fixes: c6acad68eb2dbffd ("platform/mellanox: mlxreg-hotplug: Modify to use a
> regmap interface")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Acked-by: Vadim Pasternak <vadimp@mellanox.com>

> ---
>  drivers/platform/mellanox/mlxreg-hotplug.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/mellanox/mlxreg-hotplug.c
> b/drivers/platform/mellanox/mlxreg-hotplug.c
> index 0dfa1ca0d05b0217..313cf8ad77bf68ce 100644
> --- a/drivers/platform/mellanox/mlxreg-hotplug.c
> +++ b/drivers/platform/mellanox/mlxreg-hotplug.c
> @@ -300,7 +300,7 @@ mlxreg_hotplug_health_work_helper(struct
> mlxreg_hotplug_priv_data *priv,  {
>  	struct mlxreg_core_data *data = item->data;
>  	u32 regval;
> -	int i, ret;
> +	int i, ret = 0;
> 
>  	for (i = 0; i < item->count; i++, data++) {
>  		/* Mask event. */
> --
> 2.7.4
