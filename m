Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752758AbeC1Bqh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 21:46:37 -0400
Received: from mail-db5eur01on0051.outbound.protection.outlook.com ([104.47.2.51]:63322
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752628AbeC1Bqc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 21:46:32 -0400
From: Anson Huang <anson.huang@nxp.com>
To: Rob Herring <robh@kernel.org>
CC: "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH 1/2] clocksource/drivers/imx-tpm: correct some registers
 operation flow
Thread-Topic: [PATCH 1/2] clocksource/drivers/imx-tpm: correct some registers
 operation flow
Thread-Index: AQHTxd09nmvyQLD/BkCuYlMRPtwewaPk4TEw
Date: Wed, 28 Mar 2018 01:46:28 +0000
Message-ID: <AM3PR04MB1315C539A913E1185CF04E40F5A30@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1522050461-19043-1-git-send-email-Anson.Huang@nxp.com>
 <20180327150647.l3qyrngxehpdwm7e@rob-hp-laptop>
In-Reply-To: <20180327150647.l3qyrngxehpdwm7e@rob-hp-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB1492;7:EiGjUopXDJow0wI/PdThEzAnHr9BiyGwFHSFQqzvUmllvXZjoHamUgBMQ8oWQA5Jd81n3dyUxmOq0R2FTuFi7dMy7FSibUBSfoXZuCKQeFb9/Svgzvc47ZrGJP+mGvOLL0f6V2I2cZE1wh6TuFFEJtEtxcD3ENCnfVNyElJM+wC86KsJapxUGZb584CKtkmWxWTOtSRcLSAfH13/f/lWqERdQjiAoiev4KAN0c+zL/zuUUXY0EDBV/tk5GM18afo
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4670958b-c021-407c-2866-08d5944db92c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1492;
x-ms-traffictypediagnostic: AM3PR04MB1492:
x-microsoft-antispam-prvs: <AM3PR04MB14921CB198D747829D3652A8F5A30@AM3PR04MB1492.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(189930954265078)(185117386973197)(788757137089)(45079756050767);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231221)(944501327)(52105095)(6055026)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:AM3PR04MB1492;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1492;
x-forefront-prvs: 06259BA5A2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(366004)(346002)(39860400002)(39380400002)(199004)(189003)(13464003)(5660300001)(105586002)(7736002)(2900100001)(97736004)(53936002)(305945005)(74316002)(3660700001)(9686003)(229853002)(68736007)(86362001)(3280700002)(575784001)(5250100002)(3846002)(81156014)(81166006)(316002)(478600001)(8676002)(6116002)(6246003)(33656002)(8936002)(106356001)(45080400002)(102836004)(6916009)(186003)(25786009)(6436002)(53546011)(11346002)(6506007)(446003)(76176011)(26005)(66066001)(54906003)(99286004)(59450400001)(486005)(486005)(4326008)(7696005)(55016002)(14454004)(2906002)(476003)(6306002)(966005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1492;H:AM3PR04MB1315.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: phtnV333ytMSAMdGmz/7PS4peqgCYsm7rFwzErjYHMOTeyfFNkdDtHjnVedVyv1hT7CiEoETlneZ8bDv6VTsRtYB62//1dcdGP0LUqgYGJbi9sMjWkyUj7micHaUcaDJtV7/Pl5MW504BZl8AlGF13ZHxwxtQ+CNZSsHdqAy9n4EBVmPUJEyLwkEui2oSmIOi4VTkFOKG8kLAT0eGSqT3zHFyi38L57TBc77bYUmAgS7lQ7xagBbPNN3kaXXU3Ux5YdEigKDmLfYOYDBLJzno0Dqcprd9ln/zQ8AagxjvLhmowv7dvEmEphKztT8OcQkghc+4iRSwjK/F/x3DhWHkg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4670958b-c021-407c-2866-08d5944db92c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2018 01:46:28.2384
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1492
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2S1kiLI023495



Anson Huang
Best Regards!


> -----Original Message-----
> From: Rob Herring [mailto:robh@kernel.org]
> Sent: Tuesday, March 27, 2018 11:07 PM
> To: Anson Huang <anson.huang@nxp.com>
> Cc: daniel.lezcano@linaro.org; tglx@linutronix.de; mark.rutland@arm.com; A.s.
> Dong <aisheng.dong@nxp.com>; dl-linux-imx <linux-imx@nxp.com>;
> linux-kernel@vger.kernel.org; devicetree@vger.kernel.org
> Subject: Re: [PATCH 1/2] clocksource/drivers/imx-tpm: correct some registers
> operation flow
> 
> On Mon, Mar 26, 2018 at 03:47:40PM +0800, Anson Huang wrote:
> > According to i.MX7ULP reference manual, TPM_SC_CPWMS can ONLY be
> > written when counter is disabled, TPM_SC_TOF is write-1-clear,
> > TPM_C0SC_CHF is also write-1-clear, correct these registers
> > initialization flow;
> >
> > Replace incorret clock name igp with ipg.
> 
> incorrect
> 
> This looks like an unrelated change.
> 
> >
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/timer/nxp,tpm-timer.txt |  2 +-
> 
> Though you have the same typo, this should be a separate change from the
> driver.
 
Thanks, I will do separate patches to fix the typo.

Anson.

> 
> >  drivers/clocksource/timer-imx-tpm.c                       | 10
> ++++++++--
> >  2 files changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/timer/nxp,tpm-timer.txt
> > b/Documentation/devicetree/bindings/timer/nxp,tpm-timer.txt
> > index b4aa7dd..f82087b 100644
> > --- a/Documentation/devicetree/bindings/timer/nxp,tpm-timer.txt
> > +++ b/Documentation/devicetree/bindings/timer/nxp,tpm-timer.txt
> > @@ -15,7 +15,7 @@ Required properties:
> >  - interrupts :	Should be the clock event device interrupt.
> >  - clocks :	The clocks provided by the SoC to drive the timer, must contain
> >  		an entry for each entry in clock-names.
> > -- clock-names : Must include the following entries: "igp" and "per".
> > +- clock-names : Must include the following entries: "ipg" and "per".
> >
> >  Example:
> >  tpm5: tpm@40260000 {
> > diff --git a/drivers/clocksource/timer-imx-tpm.c
> > b/drivers/clocksource/timer-imx-tpm.c
> > index 21bffdc..7403e49 100644
> > --- a/drivers/clocksource/timer-imx-tpm.c
> > +++ b/drivers/clocksource/timer-imx-tpm.c
> > @@ -20,6 +20,7 @@
> >  #define TPM_SC				0x10
> >  #define TPM_SC_CMOD_INC_PER_CNT		(0x1 << 3)
> >  #define TPM_SC_CMOD_DIV_DEFAULT		0x3
> > +#define TPM_SC_TOF_MASK			(0x1 << 7)
> >  #define TPM_CNT				0x14
> >  #define TPM_MOD				0x18
> >  #define TPM_STATUS			0x1c
> > @@ -29,6 +30,7 @@
> >  #define TPM_C0SC_MODE_SHIFT		2
> >  #define TPM_C0SC_MODE_MASK		0x3c
> >  #define TPM_C0SC_MODE_SW_COMPARE	0x4
> > +#define TPM_C0SC_CHF_MASK		(0x1 << 7)
> >  #define TPM_C0V				0x24
> >
> >  static void __iomem *timer_base;
> > @@ -179,7 +181,7 @@ static int __init tpm_timer_init(struct device_node
> *np)
> >  	ipg = of_clk_get_by_name(np, "ipg");
> >  	per = of_clk_get_by_name(np, "per");
> >  	if (IS_ERR(ipg) || IS_ERR(per)) {
> > -		pr_err("tpm: failed to get igp or per clk\n");
> > +		pr_err("tpm: failed to get ipg or per clk\n");
> >  		ret = -ENODEV;
> >  		goto err_clk_get;
> >  	}
> > @@ -205,9 +207,13 @@ static int __init tpm_timer_init(struct device_node
> *np)
> >  	 * 4) Channel0 disabled
> >  	 * 5) DMA transfers disabled
> >  	 */
> > +	/* make sure counter is disabled */
> >  	writel(0, timer_base + TPM_SC);
> > +	/* TOF is W1C */
> > +	writel(TPM_SC_TOF_MASK, timer_base + TPM_SC);
> >  	writel(0, timer_base + TPM_CNT);
> > -	writel(0, timer_base + TPM_C0SC);
> > +	/* CHF is W1C */
> > +	writel(TPM_C0SC_CHF_MASK, timer_base + TPM_C0SC);
> >
> >  	/* increase per cnt, div 8 by default */
> >  	writel(TPM_SC_CMOD_INC_PER_CNT | TPM_SC_CMOD_DIV_DEFAULT,
> > --
> > 2.7.4
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe devicetree"
> > in the body of a message to majordomo@vger.kernel.org More majordomo
> > info at
> > https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fvger
> > .kernel.org%2Fmajordomo-info.html&data=02%7C01%7CAnson.Huang%40nx
> p.com
> > %7C9de93358525a4e55fd7e08d593f45e3b%7C686ea1d3bc2b4c6fa92cd99c5
> c301635
> > %7C0%7C0%7C636577600126807143&sdata=D1NrhkZ2nret5XXTDoszUslt3W
> FjS0pMGh
> > NA1Ws2mcM%3D&reserved=0
