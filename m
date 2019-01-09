Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68788C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39A69206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729964AbfAIJ3y convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 04:29:54 -0500
Received: from [223.203.96.18] ([223.203.96.18]:57136 "EHLO
        barracuda02.hxt-semitech.com" rhost-flags-FAIL-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728041AbfAIJ3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 04:29:53 -0500
X-ASG-Debug-ID: 1547026188-107606139f16e190001-xx1T2L
Received: from HXTBJIDCEMVIW01.hxtcorp.net ([10.128.0.14]) by barracuda02.hxt-semitech.com with ESMTP id BEmb9ExinCQaW2e6 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Wed, 09 Jan 2019 17:29:49 +0800 (CST)
X-Barracuda-Envelope-From: yuanyuan.zhao@hxt-semitech.com
Received: from HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15) by
 HXTBJIDCEMVIW01.hxtcorp.net (10.128.0.14) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 9 Jan 2019 17:29:42 +0800
Received: from HXTBJIDCEMVIW02.hxtcorp.net ([fe80::3e:f4ff:7927:a6f6]) by
 HXTBJIDCEMVIW02.hxtcorp.net ([fe80::3e:f4ff:7927:a6f6%12]) with mapi id
 15.00.1395.000; Wed, 9 Jan 2019 17:29:42 +0800
From:   "Zhao, Yuanyuan" <yuanyuan.zhao@hxt-semitech.com>
To:     Marc Zyngier <marc.zyngier@arm.com>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Zheng, Joey" <yu.zheng@hxt-semitech.com>,
        "Wang, Dongsheng" <dongsheng.wang@hxt-semitech.com>
Subject: RE: [RESEND 1/1] gic: its: Make sure a LPI is discarded before free.
Thread-Topic: [RESEND 1/1] gic: its: Make sure a LPI is discarded before free.
X-ASG-Orig-Subj: RE: [RESEND 1/1] gic: its: Make sure a LPI is discarded before free.
Thread-Index: AQHUp+8DksFLG785G0++VUmPBlsY5qWmkCdg
Date:   Wed, 9 Jan 2019 09:29:41 +0000
Message-ID: <c81f42aa93904353bbeac590da7b0945@HXTBJIDCEMVIW02.hxtcorp.net>
References: <e37e3f5e0146be65c60092a457ca5c82e25581a0.1545292748.git.yuanyuan.zhao@hxt-semitech.com>
 <20190109074324.6445118d@why.wild-wind.fr.eu.org>
In-Reply-To: <20190109074324.6445118d@why.wild-wind.fr.eu.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.65.11.40]
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Barracuda-Connect: UNKNOWN[10.128.0.14]
X-Barracuda-Start-Time: 1547026189
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA384
X-Barracuda-URL: https://192.168.50.102:443/cgi-mod/mark.cgi
X-Barracuda-Scan-Msg-Size: 2035
X-Virus-Scanned: by bsmtpd at hxt-semitech.com
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.5000 1.0000 0.0000
X-Barracuda-Spam-Score: 0.60
X-Barracuda-Spam-Status: No, SCORE=0.60 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=ISO2022JP_CHARSET, MARKETING_SUBJECT
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.65376
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
        0.60 MARKETING_SUBJECT      Subject contains popular marketing words
        -0.00 ISO2022JP_CHARSET      ISO-2022-JP message
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc:

Thank you for your reply. 

As you said, APIs such as free_irq will deactivate irq
before free it. But deactivation is not forced by every API,
for example irq_dispose_mapping.  So I think it's better to check 
that irq was deactivated as expected.

BRs,
Yuanyuan


> -----Original Message-----
> From: Marc Zyngier [mailto:marc.zyngier@arm.com]
> Sent: 2019年1月9日 15:43
> To: Zhao, Yuanyuan <yuanyuan.zhao@hxt-semitech.com>
> Cc: tglx@linutronix.de; jason@lakedaemon.net; linux-
> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; Zheng, Joey
> <yu.zheng@hxt-semitech.com>; Wang, Dongsheng <dongsheng.wang@hxt-
> semitech.com>
> Subject: Re: [RESEND 1/1] gic: its: Make sure a LPI is discarded before free.
> 
> On Wed, 9 Jan 2019 11:53:27 +0800
> Zhao Yuanyuan <yuanyuan.zhao@hxt-semitech.com> wrote:
> 
> Hi Zhao,
> 
> > Its device will be removed after all events be freed.
> > Undisarded events can lead to unpredictable behaviar.
> >
> > Signed-off-by: Zhao Yuanyuan <yuanyuan.zhao@hxt-semitech.com>
> > ---
> >  drivers/irqchip/irq-gic-v3-its.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/irqchip/irq-gic-v3-its.c
> > b/drivers/irqchip/irq-gic-v3-its.c
> > index db20e99..4fee008 100644
> > --- a/drivers/irqchip/irq-gic-v3-its.c
> > +++ b/drivers/irqchip/irq-gic-v3-its.c
> > @@ -2572,6 +2572,10 @@ static void its_irq_domain_free(struct
> irq_domain *domain, unsigned int virq,
> >  								virq + i);
> >  		u32 event = its_get_event_id(data);
> >
> > +		/* Discard irq before free */
> > +		if (irqd_is_activated(d))
> > +			its_send_discard(its_dev, event);
> > +
> >  		/* Mark interrupt index as unused */
> >  		clear_bit(event, its_dev->event_map.lpi_map);
> >
> 
> But we already do send a discard on deactivate, which logically happens
> before we free the domain. So what are you fixing here?
> 
> Thanks,
> 
> 	M.
> --
> Without deviation from the norm, progress is not possible.
