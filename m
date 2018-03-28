Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752105AbeC1CYy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 22:24:54 -0400
Received: from mail-ve1eur01on0049.outbound.protection.outlook.com ([104.47.1.49]:27335
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751059AbeC1CYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 22:24:52 -0400
From: Anson Huang <anson.huang@nxp.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>
CC: dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH 2/2] clocksource/drivers/imx-tpm: add different counter
 width support
Thread-Topic: [PATCH 2/2] clocksource/drivers/imx-tpm: add different counter
 width support
Thread-Index: AQHTxQxDVZdX0D/3Bky7nau1uoVCeKPk7Jqg
Date: Wed, 28 Mar 2018 02:24:47 +0000
Message-ID: <AM3PR04MB1315EAC1F314804EA79ACE29F5A30@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1522050461-19043-1-git-send-email-Anson.Huang@nxp.com>
 <1522050461-19043-2-git-send-email-Anson.Huang@nxp.com>
 <e6e6026c-37bb-35ff-bf1b-a00d47e0aa2e@linaro.org>
In-Reply-To: <e6e6026c-37bb-35ff-bf1b-a00d47e0aa2e@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB0789;7:+vSK6bGJo3FzgQZOnrOcCObViMMnGOANiRoVBnrzyhW+6A32geJ9rFhdI9OdtP14pOkVqJjPwHQllmYbvbU92AJM42XvPC27SyinD9qh6eFQGbyS/q+tjcrgZfd5VVrKW7Q4v4GBr2ip8wcLFDTow3mRMVMsckUAOp0dhG5grS6lljqy4ZrukBsfYN+NxJ6EOJjczsktW9bMlyvByOf9imAm4/PAsGQoFg+nyY5M/aPrS7OXAl1QmK2IBftqzTwL
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c8d2b9d3-6b4d-413f-7c8b-08d59453139a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB0789;
x-ms-traffictypediagnostic: AM3PR04MB0789:
x-microsoft-antispam-prvs: <AM3PR04MB078930AC7C82A7A2AA6876CFF5A30@AM3PR04MB0789.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(148322886591682)(9452136761055)(189930954265078)(185117386973197)(45079756050767)(81227570615382);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231221)(944501327)(52105095)(6055026)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:AM3PR04MB0789;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB0789;
x-forefront-prvs: 06259BA5A2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(396003)(346002)(39380400002)(366004)(13464003)(199004)(189003)(54906003)(7696005)(2900100001)(6436002)(99286004)(2501003)(3846002)(6116002)(97736004)(53546011)(3660700001)(110136005)(486005)(486005)(6506007)(7736002)(105586002)(26005)(74316002)(81156014)(68736007)(5250100002)(305945005)(3280700002)(81166006)(476003)(6246003)(11346002)(6636002)(186003)(55016002)(8936002)(66066001)(102836004)(14454004)(2906002)(9686003)(4326008)(76176011)(59450400001)(6306002)(478600001)(53936002)(86362001)(229853002)(575784001)(8676002)(106356001)(5660300001)(25786009)(33656002)(316002)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB0789;H:AM3PR04MB1315.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: OZw5ORKJFGty4Wgvkla5+8xpAmM20XeZYeafwgS4eRpgMDHswEKV4hfCy4wQ+Q1VtLtAftb0ttA4NUZY9O0Pu5Q6WVruFBmkTqyp6dbgPu4xnuE9hFulRLY3dpcNHtExqOvSx5glsKZo/5z9u7QRhWoDwr7XjAzIcgOv0ox9LXCTwsy9HT7T9wq11YcCU3IeGhkNJcWREiYp2Wn1nXyZCtLGzQRHHmg+pkBBI0SYW/nkfOZnCCmRJkEDl4TxkWZN2sHcSrE7fK2UgeNndxKFLjn1DmxQ1NNit83GuF8xEDpSILFjThR7D3hwR9b8EA4yH7Ap6QSvlwklC1KjLXlCMQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8d2b9d3-6b4d-413f-7c8b-08d59453139a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2018 02:24:47.4420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB0789
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2S2P1h3027007



Anson Huang
Best Regards!


> -----Original Message-----
> From: Daniel Lezcano [mailto:daniel.lezcano@linaro.org]
> Sent: Monday, March 26, 2018 10:11 PM
> To: Anson Huang <anson.huang@nxp.com>; tglx@linutronix.de;
> robh+dt@kernel.org; mark.rutland@arm.com; A.s. Dong
> <aisheng.dong@nxp.com>
> Cc: dl-linux-imx <linux-imx@nxp.com>; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org
> Subject: Re: [PATCH 2/2] clocksource/drivers/imx-tpm: add different counter
> width support
> 
> On 26/03/2018 09:47, Anson Huang wrote:
> > Different TPM modules have different width counters which is 16-bit or
> > 32-bit, the counter width can be read from TPM_PARAM register
> > bit[23:16], this patch adds dynamic check for counter width to support
> > both 16-bit and 32-bit TPM modules.
> >
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> 
> Are you sure you shouldn't use a prescalar with 16b and reduce its rating? What
> will be the duration of the clocksource before wrapping up?
 
The duration currently is 0xffff / 8MHz, ~8.2mS, yes, it is too short, I will make the prescalar
higher to increase the duration. 

> 
> Also, can you do the change to prevent computing the mask at each
> 'read_count' call ?

I think we can just return the value read from the CNT register, even the width
is 16, the upper 16 bits always 0, so it does NOT matter, I will remove the mask computation
in V2 patch.

Thanks.

Anson.

> 
> > ---
> >  drivers/clocksource/timer-imx-tpm.c | 19 +++++++++++++------
> >  1 file changed, 13 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/clocksource/timer-imx-tpm.c
> > b/drivers/clocksource/timer-imx-tpm.c
> > index 7403e49..5063b77 100644
> > --- a/drivers/clocksource/timer-imx-tpm.c
> > +++ b/drivers/clocksource/timer-imx-tpm.c
> > @@ -17,6 +17,9 @@
> >  #include <linux/of_irq.h>
> >  #include <linux/sched_clock.h>
> >
> > +#define TPM_PARAM			0x4
> > +#define TPM_PARAM_WIDTH_SHIFT		16
> > +#define TPM_PARAM_WIDTH_MASK		(0xff << 16)
> >  #define TPM_SC				0x10
> >  #define TPM_SC_CMOD_INC_PER_CNT		(0x1 << 3)
> >  #define TPM_SC_CMOD_DIV_DEFAULT		0x3
> > @@ -33,6 +36,7 @@
> >  #define TPM_C0SC_CHF_MASK		(0x1 << 7)
> >  #define TPM_C0V				0x24
> >
> > +static int counter_width;
> >  static void __iomem *timer_base;
> >  static struct clock_event_device clockevent_tpm;
> >
> > @@ -66,7 +70,7 @@ static struct delay_timer tpm_delay_timer;
> >
> >  static inline unsigned long tpm_read_counter(void)  {
> > -	return readl(timer_base + TPM_CNT);
> > +	return readl(timer_base + TPM_CNT) & GENMASK(counter_width - 1, 0);
> >  }
> >
> >  static unsigned long tpm_read_current_timer(void) @@ -85,10 +89,11 @@
> > static int __init tpm_clocksource_init(unsigned long rate)
> >  	tpm_delay_timer.freq = rate;
> >  	register_current_timer_delay(&tpm_delay_timer);
> >
> > -	sched_clock_register(tpm_read_sched_clock, 32, rate);
> > +	sched_clock_register(tpm_read_sched_clock, counter_width, rate);
> >
> >  	return clocksource_mmio_init(timer_base + TPM_CNT, "imx-tpm",
> > -				     rate, 200, 32, clocksource_mmio_readl_up);
> > +				     rate, 200, counter_width,
> > +				     clocksource_mmio_readl_up);
> >  }
> >
> >  static int tpm_set_next_event(unsigned long delta, @@ -153,8 +158,8
> > @@ static int __init tpm_clockevent_init(unsigned long rate, int irq)
> >
> >  	clockevent_tpm.cpumask = cpumask_of(0);
> >  	clockevent_tpm.irq = irq;
> > -	clockevents_config_and_register(&clockevent_tpm,
> > -					rate, 300, 0xfffffffe);
> > +	clockevents_config_and_register(&clockevent_tpm, rate, 300,
> > +					GENMASK(counter_width - 1, 1));
> >
> >  	return ret;
> >  }
> > @@ -199,6 +204,8 @@ static int __init tpm_timer_init(struct device_node
> *np)
> >  		goto err_per_clk_enable;
> >  	}
> >
> > +	counter_width = (readl(timer_base + TPM_PARAM) &
> TPM_PARAM_WIDTH_MASK)
> > +		>> TPM_PARAM_WIDTH_SHIFT;
> >  	/*
> >  	 * Initialize tpm module to a known state
> >  	 * 1) Counter disabled
> > @@ -220,7 +227,7 @@ static int __init tpm_timer_init(struct device_node
> *np)
> >  		     timer_base + TPM_SC);
> >
> >  	/* set MOD register to maximum for free running mode */
> > -	writel(0xffffffff, timer_base + TPM_MOD);
> > +	writel(GENMASK(counter_width - 1, 0), timer_base + TPM_MOD);
> >
> >  	rate = clk_get_rate(per) >> 3;
> >  	ret = tpm_clocksource_init(rate);
> >
> 
> 
> --
> 
> <https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fwww.li
> naro.org%2F&data=02%7C01%7CAnson.Huang%40nxp.com%7C34d41253162e
> 4956105a08d593236499%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0
> %7C636576702585890585&sdata=td%2FN%2BpDuc%2BeFn5SZjAS6u6v6NgCQ
> AcZkNr9KS%2B8XiK0%3D&reserved=0> Linaro.org │ Open source software for
> ARM SoCs
> 
> Follow Linaro:
> <https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fwww.f
> acebook.com%2Fpages%2FLinaro&data=02%7C01%7CAnson.Huang%40nxp.co
> m%7C34d41253162e4956105a08d593236499%7C686ea1d3bc2b4c6fa92cd99c
> 5c301635%7C0%7C0%7C636576702585890585&sdata=CePZL2guHTui9SbxWpY
> S2V%2FRqTZsIUEgPVLz6m8794E%3D&reserved=0> Facebook |
> <https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Ftwitter
> .com%2F%23!%2Flinaroorg&data=02%7C01%7CAnson.Huang%40nxp.com%7C
> 34d41253162e4956105a08d593236499%7C686ea1d3bc2b4c6fa92cd99c5c301
> 635%7C0%7C0%7C636576702585890585&sdata=f37TVduDxk3ihZ8NQA2O1Mq
> LBB5wdLLhbehnQLkQKFA%3D&reserved=0> Twitter |
> <https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fwww.li
> naro.org%2Flinaro-blog%2F&data=02%7C01%7CAnson.Huang%40nxp.com%7C
> 34d41253162e4956105a08d593236499%7C686ea1d3bc2b4c6fa92cd99c5c301
> 635%7C0%7C0%7C636576702585890585&sdata=%2BAOgLPpZHN%2FjX66pyo8
> TW5RhybKrPYaijWs4z8OYP48%3D&reserved=0> Blog
