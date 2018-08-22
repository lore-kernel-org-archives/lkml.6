Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07EEBC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 13:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A59982150F
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 13:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="n3n6VOgW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A59982150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729025AbeHVQml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 12:42:41 -0400
Received: from mail-eopbgr50053.outbound.protection.outlook.com ([40.107.5.53]:4672
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728057AbeHVQmk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 12:42:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ttElWcQCyPSs3I77C7e4UhRBPmhjDxOa+MzqrvlarVI=;
 b=n3n6VOgW4tX4eZLsnbSxvEzsrDig39H3i+Ppdl/v2fRgiSfYxByHXssV3bAJw0w5082uTL62NUpttDCCcYRxpB1AMYS94nlMp9v76i2w3TCXXYIKpHLMhSNK9+jO+/Ui6VKw1Y2DBp24wjoaeAATLsyAgcGxsmbVcsb2S8jicaY=
Received: from VI1PR04MB1613.eurprd04.prod.outlook.com (10.164.84.147) by
 VI1PR04MB4478.eurprd04.prod.outlook.com (20.177.53.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.21; Wed, 22 Aug 2018 13:17:41 +0000
Received: from VI1PR04MB1613.eurprd04.prod.outlook.com
 ([fe80::7cd2:5981:f694:cb23]) by VI1PR04MB1613.eurprd04.prod.outlook.com
 ([fe80::7cd2:5981:f694:cb23%2]) with mapi id 15.20.1059.023; Wed, 22 Aug 2018
 13:17:41 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>
CC:     Lucas Stach <l.stach@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Abel Vesa <abelvesa@linux.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: Re: [RESEND v5 4/5] clk: imx: add imx composite clock
Thread-Topic: [RESEND v5 4/5] clk: imx: add imx composite clock
Thread-Index: AQHUOFW42LN/VO0spEa4W0Rc4wu0C6TJyBAAgAH8RIA=
Date:   Wed, 22 Aug 2018 13:17:40 +0000
Message-ID: <20180822131739.a2qoweu5vnakhjg6@fsr-ub1664-175>
References: <1534749367-31085-1-git-send-email-abel.vesa@nxp.com>
 <1534749367-31085-5-git-send-email-abel.vesa@nxp.com>
 <20180821065830.x5illrgyqct6h3nf@pengutronix.de>
In-Reply-To: <20180821065830.x5illrgyqct6h3nf@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4478;6:3SzhNGeNzoLritsxDh5G88Rf7siFNycIF3b/28REDs+PpxTzpMYBfaPwZyICb6Rf7gcOIHQid4JG/jq8LjsuoGQZMIsaV7sFpocTfH4GwSisbGlvcPrE2wA+r4DUFNeJxC+fjNPhTAQM2coosS2WuKV0Ab0Ve8Ed/Qm83Cy6u9PwuglvlgTBvduhfQIdFB2HTUDIKRX+es5+cxZwoPcHN3jzOqiwdK4Fgeof7CQq4TyHe6ikQrVppqsjIppsK9++NcHuq9I5tyBb9y9QU3ZTZvvsq1jONeSRWwLQlUvE2N6lxS2WdGs3n/XXy4jcGjarEh/hndJBVRANktLqkpvCD0JqLJE1mWyt8R+0QV+BSaR0HyTXjhnd6lMgQq3+so+EcDF1w/SMnqrCLqO1NsYeiyqbyagPyY92ctrm5SRE77IO7XnTg1FL3aQ5u7pe3KdFGTRG86TlVMfcWaD3u+06jg==;5:KiXmQRKg60A5CmhLzwQluETIT9wSwYnMu+5CrmKdz2smjD9SWF/DjDx0ilDNXU6Q3NJnuUZvGYAfNFx8xDyCpXnkxs6xtR3JLsoQTSRnJ4uPBI3nDgsRXZiRW/kccYA8BBir7DTPJXtZoacE31DVoqWYLBfMIYPPKxL1vnP93WA=;7:czsz3MDbcwvV4lBFwgAjDgpR7loz0dFRwPjXVLgdxmwipq1cjH4/nqudJRv8C3xeQWVgsWw3Yf5SbfC/yN4fZGfG6iLGrYIqko00G98TcJV4G4zyg//WuCKYi0Q4kFIE57iSoF/GPDWUiocMHfOs/0N0I4HpnryDFfKYSIZJ/KNzmJBvYSd6uQES3/WgLvzD2EDSgaqAMdmNf9KpJMyTpT8YG0fUGBwvjVwQUK/Bew5yxwT28OWuEVvCT0Fy1Pal
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 914fa198-444b-41a2-ad36-08d60831a3a4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4478;
x-ms-traffictypediagnostic: VI1PR04MB4478:
x-microsoft-antispam-prvs: <VI1PR04MB4478580395EADF7314E61C72F6300@VI1PR04MB4478.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(189930954265078)(45079756050767);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699016);SRVR:VI1PR04MB4478;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4478;
x-forefront-prvs: 0772E5DAD5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(39860400002)(136003)(396003)(366004)(376002)(346002)(199004)(189003)(6506007)(6486002)(6116002)(14454004)(256004)(229853002)(33716001)(11346002)(66066001)(2906002)(4326008)(446003)(6246003)(476003)(8936002)(68736007)(5250100002)(25786009)(3846002)(1076002)(14444005)(81156014)(81166006)(8676002)(486006)(99286004)(33896004)(26005)(7416002)(105586002)(97736004)(966005)(6512007)(76176011)(305945005)(7736002)(102836004)(106356001)(5660300001)(478600001)(44832011)(316002)(2900100001)(86362001)(6436002)(9686003)(6916009)(45080400002)(6306002)(53936002)(186003)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4478;H:VI1PR04MB1613.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 7R1BJezzBgoBIEXkMfxOr4EuLjL2LUeMSlhyQuLA8pouysbLGIi1eVK4cVq2p2xQLrBcNFkye6yHkis9B1CCf3+XZZe6eXe9SPq5Y5y00cmVcUQpJgCamC5tFTPbQCu/MLM9gyrAzlMcorQWZPorNUb5ezYm8RGcSszDO1yvJG2TipqqLWhUemGZTz5E9zXDijykx+9C2lOcGd++iSdqFbZgsqwaACwoPewlEJf1dwru3206pYke3eQ8TsBf2tKbT95CJ7zfze1/rAvO7mM4NH1ZCP40lWPR1n5ig9z8rehCApRKs54DNVa3IrINX4pfPo5LD4AYOENql6rYbvlSdbN5nkW8karT35JMLbc3wF4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AA3089E295398B40801E30BCAF8CD622@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 914fa198-444b-41a2-ad36-08d60831a3a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2018 13:17:40.9839
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4478
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 08:58:30AM +0200, Sascha Hauer wrote:
> On Mon, Aug 20, 2018 at 10:16:06AM +0300, Abel Vesa wrote:
> > +
> > +	val |=3D (u32)value << divider->shift;
> > +	val |=3D (u32)value << PCG_DIV_SHIFT;
> > +	clk_writel(val, divider->reg);
> > +
> > +	spin_unlock_irqrestore(divider->lock, flags);
> > +
> > +	return 0;
> > +}
>=20
> Have you tested this works? I thought those are two cascaded dividers
> and you program both to the same value. Normally you would have to
> calculate individual values for each divider which together give you the
> desired output rate.
>

My bad. Haven't properly tested it since there is no actual driver that cal=
ls
set_rate on any of those clocks at this point. Sorry about that. I'll send
another version today, where I've implemented it as I should've done from t=
he
start and I've tested it by explicitly calling the set_rate and read the va=
lue
with clk_get_rate to make sure it's fine.
=20
> Sascha
>=20
> --=20
> Pengutronix e.K.                           |                             =
|
> Industrial Linux Solutions                 | https://emea01.safelinks.pro=
tection.outlook.com/?url=3Dhttp%3A%2F%2Fwww.pengutronix.de%2F&amp;data=3D02=
%7C01%7Cabel.vesa%40nxp.com%7C722eb3cdb15849a9d19608d6073382e4%7C686ea1d3bc=
2b4c6fa92cd99c5c301635%7C0%7C0%7C636704315167487036&amp;sdata=3DQ29pmTcLbqN=
PjotCFjZ%2BldD%2FBlbYpm6fN%2BzguHixwfA%3D&amp;reserved=3D0  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    =
|
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 =
|

-- =
