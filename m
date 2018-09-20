Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96DEFECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 14:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 324F021532
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 14:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="o2IR7Dq9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 324F021532
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733109AbeITUYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 16:24:15 -0400
Received: from mail-cys01nam02on0108.outbound.protection.outlook.com ([104.47.37.108]:18160
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730984AbeITUYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 16:24:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qQJYzRknnC82hGfiQdk6kPvB4jFuXUGlPilQ4mRNuQE=;
 b=o2IR7Dq9qfoSvcOJ8SDyyG5vEhusbbycG+QS1+AkatIYD0cTLufrZalZ4vtyXRNnxrcnEm6b0s1OUMB3oN1t8PdYGBxGIApo/rIb5Kdd9/tPARH8IfRCxlZx2W+DSQ7gmPl06Lkr+MaiWf+CyKMUhG95TZW6jWAE6LhPDfJSNWk=
Received: from BN6PR21MB0161.namprd21.prod.outlook.com (10.173.200.7) by
 BN6PR21MB0819.namprd21.prod.outlook.com (10.173.204.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Thu, 20 Sep 2018 14:40:20 +0000
Received: from BN6PR21MB0161.namprd21.prod.outlook.com
 ([fe80::2dba:ece1:ce16:551a]) by BN6PR21MB0161.namprd21.prod.outlook.com
 ([fe80::2dba:ece1:ce16:551a%4]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 14:40:20 +0000
From:   Haiyang Zhang <haiyangz@microsoft.com>
To:     YueHaibing <yuehaibing@huawei.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "dmitry.tarnyagin@lockless.no" <dmitry.tarnyagin@lockless.no>,
        "wg@grandegger.com" <wg@grandegger.com>,
        "mkl@pengutronix.de" <mkl@pengutronix.de>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "hsweeten@visionengravers.com" <hsweeten@visionengravers.com>,
        "madalin.bucur@nxp.com" <madalin.bucur@nxp.com>,
        "pantelis.antoniou@gmail.com" <pantelis.antoniou@gmail.com>,
        "claudiu.manoil@nxp.com" <claudiu.manoil@nxp.com>,
        "leoyang.li@nxp.com" <leoyang.li@nxp.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "sammy@sammy.net" <sammy@sammy.net>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "nico@fluxnic.net" <nico@fluxnic.net>,
        "steve.glendinning@shawell.net" <steve.glendinning@shawell.net>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "grygorii.strashko@ti.com" <grygorii.strashko@ti.com>,
        "w-kwok2@ti.com" <w-kwok2@ti.com>,
        "m-karicheri2@ti.com" <m-karicheri2@ti.com>,
        "t.sailer@alumni.ethz.ch" <t.sailer@alumni.ethz.ch>,
        "jreuter@yaina.de" <jreuter@yaina.de>,
        KY Srinivasan <kys@microsoft.com>,
        "wei.liu2@citrix.com" <wei.liu2@citrix.com>,
        "paul.durrant@citrix.com" <paul.durrant@citrix.com>,
        "arvid.brodin@alten.se" <arvid.brodin@alten.se>,
        "pshelar@ovn.org" <pshelar@ovn.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "linux-hams@vger.kernel.org" <linux-hams@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "dev@openvswitch.org" <dev@openvswitch.org>
Subject: RE: [PATCH net-next 17/22] hv_netvsc: fix return type of
 ndo_start_xmit function
Thread-Topic: [PATCH net-next 17/22] hv_netvsc: fix return type of
 ndo_start_xmit function
Thread-Index: AQHUUOBQeas9dNOwnEmY1OLbKFqIU6T5PTTg
Date:   Thu, 20 Sep 2018 14:40:20 +0000
Message-ID: <BN6PR21MB016115A6ACD7D2685DC0070DCA130@BN6PR21MB0161.namprd21.prod.outlook.com>
References: <20180920123306.14772-1-yuehaibing@huawei.com>
 <20180920123306.14772-18-yuehaibing@huawei.com>
In-Reply-To: <20180920123306.14772-18-yuehaibing@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=haiyangz@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-09-20T14:40:19.3313342Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [96.61.92.94]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR21MB0819;6:Df10tiN0FquZb2r7xgEd1rQcWDCVgFPuIUHmGzBE7wSCrZLaD2N2jedwHAyUIUF47cDjo34ZlmLiKyDiK6JqDS5JeV6j+3khuIFnG1QXzOgdzIRjbmr5NeOSABnL2WVr3KhPQ8u2j0F8dgy2GmTbx7kRwxsoPmzN0MC/Sb19MtXIA/vdmmkCt1gcqQ8l8RVH3Nnp8UcU8XynQytg7POTNUKwZJnyehk5nX/U2IwDljvTFYBJmwmREGr++pJvmkHYY6fJtd1axrI8ZBzxT9+fWDikh7MM1piUOu0k8IOOdP9ooCIppWpr9qi1Q/HJy1ecedKyZdSsCNdgiQJ1LfkVkPcTbRwWe/S/lLavXgULtG7Bz6l53IFJUzA52uTecCXGsUt8rqP3CFAwVOiGJ/TqlNjF6R3tDPk6UjvBw88tRfNzS/QcTA3aKEA7cGXJEkziTJC1lavHfn6iVBK9DcZ0vA==;5:rrRDrdzeTawu2w6jgcpLAxIUk+LK/Evr2G/hw2aLPrV8v958Hr/54ZOAB5EFSNKjmd0do71S0KI8ixBeTp/0YsYoGs/KLgLJwne7ZOHg/3KazndhMbF595fAUS4FFkW8hOvcAVcNEqwYsWjGAhnQAXQ0B/eOhqFcTeimndtF7HA=;7:hxab18o42vSGSdhlRq7F6TYgb1GRldZ8fWYQHCJvsbWB5pGuGzm6kw2TFA58y9Pmb7tnFIlb3JYrS0KboPWotZWUKNlDP4zQTAgstxHi1nH68dcQVhrxUYtc5m5fUGP2XvvkynbmI69R3l+ylApk+1K7jRj+yNyE414tSWnWDWjix9yLYO0Hb2dBWSS20kBxCKkgEvNiQ7X3uUaQn58DUZI0Jr8sWoUmSG1usK+Dgv6xvLik4KVIjDIEcK2LVBRa
x-ms-office365-filtering-correlation-id: 9fc486b9-8904-49e1-72c8-08d61f06fdcb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:BN6PR21MB0819;
x-ms-traffictypediagnostic: BN6PR21MB0819:
x-microsoft-antispam-prvs: <BN6PR21MB0819AC1E675852DB8E405EB1CA130@BN6PR21MB0819.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(192813158149592)(185117386973197)(85827821059158)(31051911155226)(70601490899591)(9452136761055)(258649278758335)(65623756079841)(58134797142442)(216315784871565);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:BN6PR21MB0819;BCL:0;PCL:0;RULEID:;SRVR:BN6PR21MB0819;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(346002)(366004)(39860400002)(396003)(189003)(199004)(13464003)(33656002)(66066001)(39060400002)(8676002)(2900100001)(6246003)(81156014)(486006)(81166006)(476003)(446003)(3846002)(11346002)(6116002)(10090500001)(2906002)(7696005)(478600001)(71190400001)(71200400001)(5660300001)(10290500003)(5250100002)(2501003)(76176011)(102836004)(105586002)(4326008)(7406005)(25786009)(6436002)(7416002)(186003)(256004)(6346003)(229853002)(26005)(106356001)(54906003)(53936002)(305945005)(110136005)(74316002)(68736007)(8936002)(9686003)(53546011)(7736002)(6506007)(55016002)(316002)(97736004)(86612001)(14454004)(1511001)(86362001)(99286004)(22452003)(8990500004)(2201001)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR21MB0819;H:BN6PR21MB0161.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haiyangz@microsoft.com; 
x-microsoft-antispam-message-info: dIsat0q71iW8F9eRy5zRCz5ay0srq4jelbjEB1XtGMqAC0Jz7VGAf3d3iJSan2ojiPsH1b1JuEiaCYZB9FQE9s/3Cwdp/aSewmCaL2M8pza8HK6Hr+jryCMIUT3NfyaARS3k67V1mGl7enh9IEq0uKBkM8ZUFtz0tOdGqWJBdEyeKLesdG28+wJ7zkffptvLmhzaxpnCfzmDvuPojQ9YAeyQY8nv+Yag+fjlgOgA7rB3s5GEZ6367JFYKuzEmE7qEmaptx41mmGPgdAkWIItK7wTA/50RtalrTzDVXENi+KZbmbdc1573+kE9zmXJ+Hws+Ylxv/Hzf936afahWqczSUinGV7vHimUwSr59Vhb98=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fc486b9-8904-49e1-72c8-08d61f06fdcb
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 14:40:20.6666
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR21MB0819
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: YueHaibing <yuehaibing@huawei.com>
> Sent: Thursday, September 20, 2018 8:33 AM
> To: davem@davemloft.net; dmitry.tarnyagin@lockless.no;
> wg@grandegger.com; mkl@pengutronix.de; michal.simek@xilinx.com;
> hsweeten@visionengravers.com; madalin.bucur@nxp.com;
> pantelis.antoniou@gmail.com; claudiu.manoil@nxp.com; leoyang.li@nxp.com;
> linux@armlinux.org.uk; sammy@sammy.net; ralf@linux-mips.org;
> nico@fluxnic.net; steve.glendinning@shawell.net; f.fainelli@gmail.com;
> grygorii.strashko@ti.com; w-kwok2@ti.com; m-karicheri2@ti.com;
> t.sailer@alumni.ethz.ch; jreuter@yaina.de; KY Srinivasan <kys@microsoft.c=
om>;
> Haiyang Zhang <haiyangz@microsoft.com>; wei.liu2@citrix.com;
> paul.durrant@citrix.com; arvid.brodin@alten.se; pshelar@ovn.org
> Cc: linux-kernel@vger.kernel.org; netdev@vger.kernel.org; linux-
> can@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linuxppc-
> dev@lists.ozlabs.org; linux-mips@linux-mips.org; linux-omap@vger.kernel.o=
rg;
> linux-hams@vger.kernel.org; devel@linuxdriverproject.org; linux-
> usb@vger.kernel.org; xen-devel@lists.xenproject.org; dev@openvswitch.org;
> YueHaibing <yuehaibing@huawei.com>
> Subject: [PATCH net-next 17/22] hv_netvsc: fix return type of ndo_start_x=
mit
> function
>=20
> The method ndo_start_xmit() is defined as returning an 'netdev_tx_t', whi=
ch is
> a typedef for an enum type, so make sure the implementation in this drive=
r has
> returns 'netdev_tx_t' value, and change the function return type to netde=
v_tx_t.
>=20
> Found by coccinelle.
>=20
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/net/hyperv/netvsc_drv.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_=
drv.c
> index 3af6d8d..056c472 100644
> --- a/drivers/net/hyperv/netvsc_drv.c
> +++ b/drivers/net/hyperv/netvsc_drv.c
> @@ -511,7 +511,8 @@ static int netvsc_vf_xmit(struct net_device *net, str=
uct
> net_device *vf_netdev,
>  	return rc;
>  }
>=20
> -static int netvsc_start_xmit(struct sk_buff *skb, struct net_device *net=
)
> +static netdev_tx_t
> +netvsc_start_xmit(struct sk_buff *skb, struct net_device *net)
>  {
>  	struct net_device_context *net_device_ctx =3D netdev_priv(net);
>  	struct hv_netvsc_packet *packet =3D NULL; @@ -528,8 +529,11 @@
> static int netvsc_start_xmit(struct sk_buff *skb, struct net_device *net)
>  	 */
>  	vf_netdev =3D rcu_dereference_bh(net_device_ctx->vf_netdev);
>  	if (vf_netdev && netif_running(vf_netdev) &&
> -	    !netpoll_tx_running(net))
> -		return netvsc_vf_xmit(net, vf_netdev, skb);
> +	    !netpoll_tx_running(net)) {
> +		ret =3D netvsc_vf_xmit(net, vf_netdev, skb);
> +		if (ret)
> +			return NETDEV_TX_BUSY;

For error case, please just return NETDEV_TX_OK. We are not sure if the=20
error can go away after retrying, returning NETDEV_TX_BUSY may cause=20
infinite retry from the upper layer.

Thanks,
- Haiyang
