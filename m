Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CEB4C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 19:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A40982089D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 19:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="aRDbUQPo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A40982089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933649AbeGITAl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 15:00:41 -0400
Received: from mail-ve1eur01on0051.outbound.protection.outlook.com ([104.47.1.51]:4992
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933626AbeGITAj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 15:00:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bfy9LAoGlTp3WC8x5a7n8fPbVlk8KgWZAx8Ku7ErP9I=;
 b=aRDbUQPo3JkzkyEKQI6nF9ZuREIDhIaQvBdv+0yE7GflOhFuHva9KQSL0aiUovc205VrLvuR4n9/hI0lATJ8pGWLEy/6B7PrM6BMwZJnSbzSeA/1/nAV5/+6sb77EEgsU6dbGh2Lwzj+gXB5aZUdvdmkjsd6fOGVtC0S8RiDULY=
Received: from HE1PR04MB3289.eurprd04.prod.outlook.com (10.170.255.157) by
 HE1PR04MB1212.eurprd04.prod.outlook.com (10.162.249.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.19; Mon, 9 Jul 2018 19:00:35 +0000
Received: from HE1PR04MB3289.eurprd04.prod.outlook.com
 ([fe80::882f:418e:1cfa:786e]) by HE1PR04MB3289.eurprd04.prod.outlook.com
 ([fe80::882f:418e:1cfa:786e%4]) with mapi id 15.20.0930.016; Mon, 9 Jul 2018
 19:00:35 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/4] pwm: fsl-ftm: Added a dedicated IP interface clock
Thread-Topic: [PATCH v2 1/4] pwm: fsl-ftm: Added a dedicated IP interface
 clock
Thread-Index: AQHT/14eon3OMNqy9UmcYn13+b0vSKSHUHEAgAAdtnA=
Date:   Mon, 9 Jul 2018 19:00:34 +0000
Message-ID: <HE1PR04MB32897C3E284B8E4B1A5530CB89440@HE1PR04MB3289.eurprd04.prod.outlook.com>
References: <20180608192237.11063-1-shenwei.wang@nxp.com>
 <20180709170926.GF26651@ulmo>
In-Reply-To: <20180709170926.GF26651@ulmo>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shenwei.wang@nxp.com; 
x-originating-ip: [64.157.242.222]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR04MB1212;7:a4e5W8Hl8356RKFiF5OXqp6DvfQ2/0kcml0ZqT4Dgra2ZWzoDsjC0msfy+THbzXhqQRUFTLv3m+flXmpH1yZkY0ZzCjN6opVxHtYTOcHtpQZRSE6dmLDFEQ4DEveE+xZpMQE3qPJgoODUHcWOkZwKz4HCbJySU6MHpWPdTkjtbfK/t7HGmIyy7JhjODpDiFEVdjrUZg1uNZMXocfqbVECfVGdWM29LjpOA3JG30GfzFIyfVfEdCM4fHQn5eySLNE
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 98542807-818c-4000-4271-08d5e5ce408f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1212;
x-ms-traffictypediagnostic: HE1PR04MB1212:
x-microsoft-antispam-prvs: <HE1PR04MB1212446D05DB65D6FAABDA0989440@HE1PR04MB1212.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:HE1PR04MB1212;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1212;
x-forefront-prvs: 07283408BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(366004)(136003)(396003)(199004)(189003)(13464003)(76176011)(6506007)(5660300001)(53546011)(2900100001)(316002)(5250100002)(54906003)(186003)(26005)(68736007)(9686003)(8936002)(229853002)(256004)(106356001)(86362001)(102836004)(7696005)(99286004)(6916009)(55016002)(2906002)(6436002)(478600001)(446003)(8676002)(105586002)(97736004)(81156014)(44832011)(39060400002)(66066001)(33656002)(4326008)(25786009)(486006)(6246003)(53936002)(6116002)(3846002)(14454004)(476003)(11346002)(305945005)(74316002)(81166006)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1212;H:HE1PR04MB3289.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: R3qTWbeMTSQmDaliwYMUZ/im+tEkRyBWuTUAZnFKcz4ppLMWlrQOeFZ7u/g8oZk7DevV4tmjpjf54EkMriDiwQTSgL/gNNx2aqVV1piMqe5p5JeUF11dv69BRHJp+gfJwfS0VWO146b42e1340INqKri+wtvX7inJeFuoTBQ3shsS/V5luUf52FzAITyjYorEafS2e6QgF01pOIRq9gC9DkpM2p/LHr4C6TrilJBfnUDXqJgROZGlfzPlaAxBek7tn94uhhEmQORD++bo7XF4heY4maaC02r5qd4yim+i+WtA08RA0F6YmzGVqb28wGInE10nILcsQFO28zfLZU9InuXpIVxY3Xz/lKWE1fbgPg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98542807-818c-4000-4271-08d5e5ce408f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2018 19:00:34.9835
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1212
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you, Thierry.=20
Have you also reviewed and accepted the other 3 patches in this serial?

Regards,
Shenwei

-----Original Message-----
From: Thierry Reding [mailto:thierry.reding@gmail.com]=20
Sent: Monday, July 9, 2018 12:09 PM
To: Shenwei Wang <shenwei.wang@nxp.com>
Cc: linux-pwm@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>; linux-kern=
el@vger.kernel.org
Subject: Re: [PATCH v2 1/4] pwm: fsl-ftm: Added a dedicated IP interface cl=
ock

On Fri, Jun 08, 2018 at 02:22:34PM -0500, shenwei.wang@nxp.com wrote:
> The current driver assumes that the ftm_sys clock works as one of the=20
> clock sources for the IP block as well as the IP interface clock. This=20
> assumption does not apply any more on the latest i.MX8x SoC family. On=20
> i.MX8x SoCs, a dedicated IP interface clock is introduced and it must=20
> be enabled before accessing any FTM registers. Moreover, the clock can=20
> not be used as the source clock for the FTM IP block. This patch=20
> introduces the ipg_clk as the dedicated IP interface clock and by=20
> default it is the same as the ftm_sys clock if not specified.
>=20
> Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
> ---
>  drivers/pwm/pwm-fsl-ftm.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)

Applied, thanks.

Thierry
