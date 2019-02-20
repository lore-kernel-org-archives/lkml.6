Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 660A3C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 05:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B75320C01
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 05:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="p5Pf9NdM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbfBTFsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 00:48:05 -0500
Received: from mail-eopbgr140083.outbound.protection.outlook.com ([40.107.14.83]:2875
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726297AbfBTFsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 00:48:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HuYbhJLKr5r1DYFvRLABnzza9KoH6uMoHeOHgqjYdwQ=;
 b=p5Pf9NdM+7D1prhYqRu0mPoLoMHoGb8BtoPIjjGntvOP1AtdiN9T9g5JlRyFBru5ybRbsfbWWMofkMkR34pD3MhP0Qmxjzu4ovA3E0vz3/ctjliCaivsu569RAnmNrv4bn5DVmJ67fjBEXk0/qYzB3TKezlT6K/na5Ikd1a3KDg=
Received: from AM6PR04MB4215.eurprd04.prod.outlook.com (52.135.168.141) by
 AM6PR04MB4278.eurprd04.prod.outlook.com (52.135.168.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Wed, 20 Feb 2019 05:46:18 +0000
Received: from AM6PR04MB4215.eurprd04.prod.outlook.com
 ([fe80::e944:6749:3ee6:4e08]) by AM6PR04MB4215.eurprd04.prod.outlook.com
 ([fe80::e944:6749:3ee6:4e08%5]) with mapi id 15.20.1622.020; Wed, 20 Feb 2019
 05:46:18 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V3 2/4] firmware: imx: enable imx scu general irq function
Thread-Topic: [PATCH V3 2/4] firmware: imx: enable imx scu general irq
 function
Thread-Index: AQHUyAC3FYrF6Xg4T0Ow/94gotmP4KXoLAWw
Date:   Wed, 20 Feb 2019 05:46:18 +0000
Message-ID: <AM6PR04MB42155AF83E6DA131886045B8807D0@AM6PR04MB4215.eurprd04.prod.outlook.com>
References: <1550545569-7197-1-git-send-email-Anson.Huang@nxp.com>
 <1550545569-7197-2-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1550545569-7197-2-git-send-email-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 780d9482-f588-4aad-2811-08d696f6bc88
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4278;
x-ms-traffictypediagnostic: AM6PR04MB4278:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;AM6PR04MB4278;23:gugDFMtQMoUjdDwA9WbiqFfvUya7XdFE8YOI3y1Iu?=
 =?us-ascii?Q?4mqbfs1+05y5KwLAlcYBono615+gl8aGFKQZnVVX6BUsY+sdVr69DDDHrDOI?=
 =?us-ascii?Q?Rz0AoyJRHHYNpsBMwgN8zD9PdjA6ZIoKfpzW7e/iGSMGea2RsQ5ZdIOc0NH8?=
 =?us-ascii?Q?gTfgZHi93a/myVc2hPEhC+YKpqahMdtKeldv1J73KjriSXvlfgrCIrRe9NVm?=
 =?us-ascii?Q?t8cgM7KNyG9Y0NYAo2YrDSqZ2o9pjcJixr3vGIwOIkK9Ue1S3wPcTwzHjV20?=
 =?us-ascii?Q?op2mkIDZNFEuCxqPGM/YFacE4xtKhh2RxMeN4bmbFrfKstKkljZRH2ktayak?=
 =?us-ascii?Q?1a0NSLEOI1G8zNBxW8T4jlGibGJJ9o7uXchP7Br5ZvuU9wE/N6ejvKeVrg5l?=
 =?us-ascii?Q?LaSaOJ8eednpRjRydc6oel39Qv0xua2KBW81o2CF6nrU6UGfqGnq9HmclM7s?=
 =?us-ascii?Q?H3HS9QTsxWiEZ9ML9QhjvazC3s2LAgZN+Nx/kFkcbGJmrU6KLga07hjYsscX?=
 =?us-ascii?Q?PH6G56xRZ19CQ6hTd1HDY9rOiHkrMCN8aLF3ypnR21cagjejKTAR0cm+B3rv?=
 =?us-ascii?Q?4xQP84QZCSOVvr1IYd05zVtDE01pOOlosvMWFxT2YAtNlR8D/0Ojq+BaHOFP?=
 =?us-ascii?Q?q3GYxMHtrqcGgvB1kc7WUtu54Gbf+2fSGob6MnCsMd6GxuIz6Z8xQd994sVR?=
 =?us-ascii?Q?/KOkP5J19GqtKSayeAOan6UmW1pfS8sNJzeELv7j4acYK3LP1RE8RVr46WTx?=
 =?us-ascii?Q?rEn+/c8X/oY5HIbosfLEiLkQel4GGfv6eIWgMP7wtNH+74g9zh1OxLsANjgD?=
 =?us-ascii?Q?p0EkTR93PGZmtezQI31VZbjdQ5g++cFeF6QlyxGFj1wc12hd1IGUXQIYF85c?=
 =?us-ascii?Q?OaH9sytyWSsxb7pkQsfqG63UOfa9QVabIbiNlrjFPhAI+iEQBFy19n8W9pYH?=
 =?us-ascii?Q?EYfkS6s1Gi1oY9Q2FBt4cHY34ZgT9AkO/6eFJhZvice+OCxjj6hOpQbeD5JI?=
 =?us-ascii?Q?udix+PU9vEUqO3n2gWRap6tZfzp1DH6YVCXfIbghlv9mi7ns3sp207F1WV4l?=
 =?us-ascii?Q?hFbCOmAS8HHpiX6gg/Ebd40yirWES4ncl/4/G5uXcgwLmzftOM2hXeXIfxnQ?=
 =?us-ascii?Q?eBaD2gBkH6e9e7OF5j1oWZGE7u0/TZuTY5Z05TabaLNBizgIEE5UFawgA49i?=
 =?us-ascii?Q?su846zj2PULT7D9yZmmGUipMX9r7Nn0FxMFHuq8E9DvjhmrUziH7wuecBuOY?=
 =?us-ascii?Q?JIVMJyN0ETAFsRFD4dn5+BdtIeAB73W2H03omizex/1+rYVtry/fl0Q3FXrJ?=
 =?us-ascii?Q?Fspatv1cK6d7pnN9NwOVOo=3D?=
x-microsoft-antispam-prvs: <AM6PR04MB42780107F33690237C56D957807D0@AM6PR04MB4278.eurprd04.prod.outlook.com>
x-forefront-prvs: 0954EE4910
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(396003)(136003)(346002)(39860400002)(199004)(189003)(6436002)(26005)(55016002)(76176011)(7696005)(186003)(2906002)(33656002)(53936002)(14454004)(102836004)(97736004)(2201001)(86362001)(7416002)(110136005)(5660300002)(66066001)(9686003)(6506007)(2501003)(6116002)(99286004)(71200400001)(71190400001)(316002)(3846002)(476003)(256004)(14444005)(68736007)(106356001)(25786009)(446003)(11346002)(229853002)(44832011)(305945005)(4326008)(105586002)(81156014)(478600001)(81166006)(6246003)(8936002)(74316002)(7736002)(8676002)(486006)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4278;H:AM6PR04MB4215.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yqIZmH54xzThcPTuIh5YuSeNQj9Ehg5ugjmFUQZfeapUlsZCNnhLdDsrPN8t54bZ28EHAnTIedRojJcL7pL65d5uBCA4JYbGwOMm0lwI8GKZ33YoUHN6FIC9bs63hc3sjr3w0J+LGx0gSt0BvHeR/8KIpbd1cQIWNl3yWjr87szXO4vMSq2RseHn+b1zOj51KFszxtBNRTxAXpHzqiKMGOFVNJZG0A2s4LPI4NGi6TyyhJU1vI3wnyLMDI3mjHmSm0QQGkN+qFwBGI+06WNGH8A8rxE8CD3w+A5SvT0nkQCvmjsBSZ8vGMG5kdzRjJHeHyUY1z6wSymqV+Ros7RIdFZl2tBx3qJjrmz4ZtzMofNeBqopt6JVIwUY05HYG9NT/Icd2L3E6QuBmcKgtC1akvzPC9YgL+7a0hRAGeZ0EFQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 780d9482-f588-4aad-2811-08d696f6bc88
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2019 05:46:18.7413
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4278
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Anson Huang
> Sent: Tuesday, February 19, 2019 11:11 AM
>=20
> The System Controller Firmware (SCFW) controls RTC, thermal and WDOG etc.=
,
> these resources' interrupt function are managed by SCU. When any IRQ
> pending, SCU will notify Linux via MU general interrupt channel #3, and L=
inux
> kernel needs to call SCU APIs to get IRQ status and notify each module to
> handle the interrupt.
>=20
> Since there is no data transmission for SCU IRQ notification, so doorbell=
 mode
> is used for this MU channel, and SCU driver will use notifier mechanism t=
o
> broadcast to every module which registers the SCU block notifier.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> No change since V2.
> ---
>  drivers/firmware/imx/imx-scu.c   | 101
> +++++++++++++++++++++++++++++++++++++++
>  include/linux/firmware/imx/sci.h |   3 ++
>  2 files changed, 104 insertions(+)
>=20
> diff --git a/drivers/firmware/imx/imx-scu.c b/drivers/firmware/imx/imx-sc=
u.c
> index 2bb1a19..e93bea5 100644
> --- a/drivers/firmware/imx/imx-scu.c
> +++ b/drivers/firmware/imx/imx-scu.c
> @@ -7,6 +7,7 @@
>   *
>   */
>=20
> +#include <dt-bindings/firmware/imx/rsrc.h>
>  #include <linux/err.h>
>  #include <linux/firmware/imx/types.h>
>  #include <linux/firmware/imx/ipc.h>
> @@ -21,6 +22,8 @@
>=20
>  #define SCU_MU_CHAN_NUM		8
>  #define MAX_RX_TIMEOUT		(msecs_to_jiffies(30))
> +#define IMX_SC_IRQ_FUNC_STATUS	2
> +#define IMX_SC_IRQ_NUM_GROUP	6
>=20
>  struct imx_sc_chan {
>  	struct imx_sc_ipc *sc_ipc;
> @@ -77,7 +80,23 @@ static int imx_sc_linux_errmap[IMX_SC_ERR_LAST] =3D {
>  	-EIO,	 /* IMX_SC_ERR_FAIL */
>  };
>=20
> +struct imx_sc_msg_irq_get_status {
> +	struct imx_sc_rpc_msg hdr;
> +	union {
> +		struct {
> +			u16 resource;
> +			u8 group;
> +			u8 reserved;
> +		} send;

} __packed req

> +		struct {
> +			u32 status;
> +		} receive;

resp

> +	} data;
> +} __packed;

No need __packed anymore

> +
>  static struct imx_sc_ipc *imx_sc_ipc_handle;
> +static struct work_struct imx_sc_general_irq_work; static
> +BLOCKING_NOTIFIER_HEAD(imx_scu_notifier_chain);
>=20
>  static inline int imx_sc_to_linux_errno(int errno)  { @@ -194,6 +213,86 =
@@
> int imx_scu_call_rpc(struct imx_sc_ipc *sc_ipc, void *msg, bool have_resp=
)  }
> EXPORT_SYMBOL(imx_scu_call_rpc);
>=20
> +int imx_scu_register_notifier(struct notifier_block *nb) {
> +	return blocking_notifier_chain_register(&imx_scu_notifier_chain, nb);
> +} EXPORT_SYMBOL(imx_scu_register_notifier);
> +
> +int imx_scu_unregister_notifier(struct notifier_block *nb) {
> +	return blocking_notifier_chain_unregister(&imx_scu_notifier_chain,
> +nb); } EXPORT_SYMBOL(imx_scu_unregister_notifier);
> +
> +static int imx_scu_notifier_call_chain(unsigned long status, u8 *group)
> +{
> +	return blocking_notifier_call_chain(&imx_scu_notifier_chain,
> +					    status, (void *)group);
> +}
> +
> +static void imx_scu_general_irq_work_handler(struct work_struct *work)
> +{
> +	struct imx_sc_msg_irq_get_status msg;
> +	struct imx_sc_rpc_msg *hdr =3D &msg.hdr;
> +	u32 irq_status;
> +	int ret;
> +	u8 i;
> +
> +	for (i =3D 0; i < IMX_SC_IRQ_NUM_GROUP; i++) {
> +		hdr->ver =3D IMX_SC_RPC_VERSION;
> +		hdr->svc =3D IMX_SC_RPC_SVC_IRQ;
> +		hdr->func =3D IMX_SC_IRQ_FUNC_STATUS;
> +		hdr->size =3D 2;
> +
> +		msg.data.send.resource =3D IMX_SC_R_MU_1A;

Please make sure if it's fixed to MU_1A.

> +		msg.data.send.group =3D i;
> +
> +		ret =3D imx_scu_call_rpc(imx_sc_ipc_handle, &msg, true);
> +		if (ret) {
> +			pr_err("get irq status failed, ret %d\n", ret);
> +			return;
> +		}
> +
> +		irq_status =3D msg.data.receive.status;
> +		if (!irq_status)
> +			continue;
> +
> +		imx_scu_notifier_call_chain(irq_status, &i);
> +	}
> +}
> +
> +static void imx_scu_rxdb_callback(struct mbox_client *c, void *msg) {
> +	schedule_work(&imx_sc_general_irq_work);
> +}
> +
> +static int imx_scu_enable_general_irq_channel(struct device *dev) {
> +	struct mbox_client *cl;
> +	struct mbox_chan *ch;
> +	int ret =3D 0;
> +
> +	cl =3D devm_kzalloc(dev, sizeof(*cl), GFP_KERNEL);
> +	if (!cl)
> +		return -ENOMEM;
> +
> +	cl->dev =3D dev;
> +	cl->rx_callback =3D imx_scu_rxdb_callback;
> +
> +	/* SCU general IRQ uses general interrupt channel 3 */
> +	ch =3D mbox_request_channel_byname(cl, "gi3");
> +	if (IS_ERR(ch)) {
> +		ret =3D PTR_ERR(ch);
> +		dev_err(dev, "failed to request mbox chan gi3, ret %d\n", ret);
> +		return ret;

return PTR_ERR(ch)

> +	}
> +
> +	INIT_WORK(&imx_sc_general_irq_work,
> imx_scu_general_irq_work_handler);
> +
> +	return ret;
> +}
> +
>  static int imx_scu_probe(struct platform_device *pdev)  {
>  	struct device *dev =3D &pdev->dev;
> @@ -246,6 +345,8 @@ static int imx_scu_probe(struct platform_device
> *pdev)
>=20
>  	imx_sc_ipc_handle =3D sc_ipc;
>=20
> +	imx_scu_enable_general_irq_channel(dev);
> +

Check return in case a failure

Regards
Dong Aisheng

>  	dev_info(dev, "NXP i.MX SCU Initialized\n");
>=20
>  	return devm_of_platform_populate(dev); diff --git
> a/include/linux/firmware/imx/sci.h b/include/linux/firmware/imx/sci.h
> index ebc5509..9d608db 100644
> --- a/include/linux/firmware/imx/sci.h
> +++ b/include/linux/firmware/imx/sci.h
> @@ -15,4 +15,7 @@
>=20
>  #include <linux/firmware/imx/svc/misc.h>  #include
> <linux/firmware/imx/svc/pm.h>
> +
> +int imx_scu_register_notifier(struct notifier_block *nb); int
> +imx_scu_unregister_notifier(struct notifier_block *nb);
>  #endif /* _SC_SCI_H */
> --
> 2.7.4

