Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751150AbeDSHOp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 03:14:45 -0400
Received: from mail-eopbgr10052.outbound.protection.outlook.com ([40.107.1.52]:15904
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750708AbeDSHOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 03:14:44 -0400
From: "A.s. Dong" <aisheng.dong@nxp.com>
To: Anson Huang <anson.huang@nxp.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] clocksource: imx-tpm: correct -ETIME return condition
 check
Thread-Topic: [PATCH] clocksource: imx-tpm: correct -ETIME return condition
 check
Thread-Index: AQHT16TkiTXQwlmjHUm8kiJQra+TwaQHrEoQ
Date: Thu, 19 Apr 2018 07:14:42 +0000
Message-ID: <AM0PR04MB421199C55AAD04D969B23C9180B50@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1524117883-2484-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1524117883-2484-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4260;7:pkD3juby2fSbSJ22QN5HzKlUqJgf6jUfx2oFdRRLrRNq7qxszzLS7BPbQsWuD47tpWuQ50RO6pb0suYXnLt+0nxeoRHgt9FLwb9LFQlxFVKWxWPNoC6NNuKpKWd9NZIErvR94fDqEliTKoqwRpqb2NL3YTNNoWKt2b4dszFiGs0+WiR4NboNAg2UwyfC9+4FLPY8Cg81qIqVayzo6ODNsWhZjKWmj8wj0G/BBG+Si7Mj1kSKNccLe108770h4OP0
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4260;
x-ms-traffictypediagnostic: AM0PR04MB4260:
x-microsoft-antispam-prvs: <AM0PR04MB4260984660B2DE73172BB5AE80B50@AM0PR04MB4260.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231232)(944501327)(52105095)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:AM0PR04MB4260;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4260;
x-forefront-prvs: 0647963F84
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39380400002)(376002)(39860400002)(346002)(13464003)(229853002)(305945005)(7696005)(86362001)(2906002)(8936002)(6506007)(53546011)(33656002)(59450400001)(14454004)(2201001)(8676002)(6116002)(3280700002)(3660700001)(7736002)(3846002)(99286004)(76176011)(81166006)(478600001)(110136005)(6246003)(74316002)(102836004)(476003)(26005)(2900100001)(446003)(9686003)(53936002)(11346002)(25786009)(5660300001)(4326008)(66066001)(5250100002)(6436002)(316002)(2501003)(55016002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4260;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;MLV:sfv;
x-microsoft-antispam-message-info: yZnk2LEUHW+NCOj5UFgcGU5iZhYFGmWStsOOSgoT4NhiJXGUos0yzFL4+7efDt7WyxPUXc2+taYFA4HoUtV5TWAiiSHITD16eJnVpYquQ+n58in7nOTfNwmTGo2cZZRGOirEQJ2jWoN90YGcJFsyxourMRSxAcpkMVWWu3FptaoLl3G/W34XZGKvv3fY/RoX
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 0996fabe-df4e-45cf-699f-08d5a5c538b8
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0996fabe-df4e-45cf-699f-08d5a5c538b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2018 07:14:42.0762
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4260
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3J7Ep4C009402

> -----Original Message-----
> From: Anson Huang
> Sent: Thursday, April 19, 2018 2:05 PM
> To: daniel.lezcano@linaro.org; tglx@linutronix.de; linux-
> kernel@vger.kernel.org
> Cc: dl-linux-imx <linux-imx@nxp.com>
> Subject: [PATCH] clocksource: imx-tpm: correct -ETIME return condition
> check
> 
> The additional brakets added to tpm_set_next_event's return value
> computation causes (int) forced type conversion NOT taking effect, and the
> incorrect value return will cause various system timer issue, like RCU stall etc..
> 
> This patch removes the additional brakets to make sure
> tpm_set_next_event always returns correct value.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

It's my mistake. Thanks for spotting it out.

Acked-by: Dong Aisheng <Aisheng.dong@nxp.com>

Regards
Dong Aisheng

> ---
> 	resend, since I got failure message of sending mail to linux-
> kernel@vger.kernel.org.
>  drivers/clocksource/timer-imx-tpm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clocksource/timer-imx-tpm.c b/drivers/clocksource/timer-
> imx-tpm.c
> index 05d97a6..6c83184 100644
> --- a/drivers/clocksource/timer-imx-tpm.c
> +++ b/drivers/clocksource/timer-imx-tpm.c
> @@ -114,7 +114,7 @@ static int tpm_set_next_event(unsigned long delta,
>  	 * of writing CNT registers which may cause the min_delta event got
>  	 * missed, so we need add a ETIME check here in case it happened.
>  	 */
> -	return (int)((next - now) <= 0) ? -ETIME : 0;
> +	return (int)(next - now) <= 0 ? -ETIME : 0;
>  }
> 
>  static int tpm_set_state_oneshot(struct clock_event_device *evt)
> --
> 2.7.4
