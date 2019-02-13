Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E35C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9364421872
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392469AbfBMWdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 17:33:23 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:33531 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728708AbfBMWdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 17:33:22 -0500
Received: from oxbaltgw00.schlund.de ([172.19.246.6]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N95mL-1h6vJ11dcl-0169yT; Wed, 13 Feb 2019 23:33:12 +0100
Date:   Wed, 13 Feb 2019 23:33:11 +0100 (CET)
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Message-ID: <1278623750.602548.1550097191567@email.ionos.de>
In-Reply-To: <87tvh7v8yd.fsf@anholt.net>
References: <20190213003324.15224-1-eric@anholt.net>
 <20190213003324.15224-2-eric@anholt.net>
 <648bbc3e-6690-9b05-cae5-bf81edbec74a@i2se.com> <87tvh7v8yd.fsf@anholt.net>
Subject: Re: [PATCH 2/2] soc: bcm: bcm2835-pm: Fix error paths of
 initialization.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev47
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:DqYO30DjaNHimC3rWe2Bs3YBnZMLZYdE4l/CtepfnpKTvvQIVcz
 Uz/VxVAUshlJDI90DG1qTZBQB2EHTpnrR/dyNY6jcdMPp2Nm0GsmyBGUlixi0YVYYkYSGfl
 AUPU9v+HiBdg+82ec/s40HjcK2CYJCL4imcCHraDb7VfB+p4afplTrzfkckYCDnRotnMj31
 +Zxq8YbGTN8r24gx5Wilg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lkLhe2+p65M=:zN8LflAYN4T935rhvTqBlb
 B3IqtSknE9nmtNxVbNAdqSDL48yTeo6PATztadycIpFgjW6E1UxvinNLbz8YQCcd7QuyuZok4
 AykWOPqaSFyLT4IuWUt2IwOs7AoNxS4XZ7zhz0vdzyBg/dSseciB9PYvzDua1rE2giJuJUX/I
 oRAz22jtrheafDRwycE85E9pDQ6NZZHj22cjDqp3VKEl+xcQOSSMV5CwHkDMspQUCorug+mZK
 +BDrMBlp6gcMWXISTGbZ6D0+XOfhdS4VJXIg2qytox1v0Y6G2da2VJGAdmq9zLM5oY1Px8ScW
 NIQzni/cdWPDbnsFxTDJRMoTpMNEvt77t/snjAIXfrwOwEZ+RwsbSKcMD+m79dNSpR9CCrxDb
 /cZR7xQ2ou+prjhaBPIHa5/KpPN8RdpdZkWdncHH+o79uIVO9/zmbnhpdmOTPLKgMixFBoh7I
 LZtSGIma8NwpM8onebowleAGp4bkBESVDUtDw5RMkey66vxJoBGkDlNiDCNHmH8aXGnOg93wv
 YHyJClQuzXCSPxTQjG7AAETGlqPJjXkLrD5A7FRj4eL5iNZSTJlYC26+e4GrHVX5AQIO2ZmbY
 x4BZP8sB+DO8V0yehrSRaqVTQ6vH/lEd7gwmKvY2eAxAbPYZ7ntBf/SkNZ2a7fMWL3KwWppUt
 J5imzIZp7SHrsniS4RbE8WZcX5P7OJnWCXl7ki9ic/H6pTl2Qxsc8RGzu7oDSXSgaYmv/MVIw
 wYciWO9dG9r0xrS+E2jGIQ1D3pYRsE8YtJXX0DBMUOC0x+uf4D0LZTXTmTE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Eric Anholt <eric@anholt.net> hat am 13. Februar 2019 um 19:28 geschrieben:
> 
> 
> Stefan Wahren <stefan.wahren@i2se.com> writes:
> 
> > Hi Eric,
> >
> > Am 13.02.19 um 01:33 schrieb Eric Anholt:
> >> The clock driver may probe after ours and so we need to pass the
> >> -EPROBE_DEFER out.  Fix the other error path while we're here.
> >>
> >> Signed-off-by: Eric Anholt <eric@anholt.net>
> >> Fixes: 670c672608a1 ("soc: bcm: bcm2835-pm: Add support for power domains under a new binding.")
> >> ---
> >>  drivers/soc/bcm/bcm2835-power.c | 30 +++++++++++++++++++++++++-----
> >>  1 file changed, 25 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/soc/bcm/bcm2835-power.c b/drivers/soc/bcm/bcm2835-power.c
> >> index 4a1b99b773c0..11f9469423f7 100644
> >> --- a/drivers/soc/bcm/bcm2835-power.c
> >> +++ b/drivers/soc/bcm/bcm2835-power.c
> >> @@ -485,7 +485,7 @@ static int bcm2835_power_pd_power_off(struct generic_pm_domain *domain)
> >>  	}
> >>  }
> >>  
> >> -static void
> >> +static int
> >>  bcm2835_init_power_domain(struct bcm2835_power *power,
> >>  			  int pd_xlate_index, const char *name)
> >>  {
> >> @@ -493,6 +493,12 @@ bcm2835_init_power_domain(struct bcm2835_power *power,
> >>  	struct bcm2835_power_domain *dom = &power->domains[pd_xlate_index];
> >>  
> >>  	dom->clk = devm_clk_get(dev->parent, name);
> >> +	if (IS_ERR(dom->clk)) {
> >> +		int ret = PTR_ERR(dom->clk);
> >> +
> >> +		if (ret == -EPROBE_DEFER)
> >> +			return ret;
> > is it safe to proceed in the other error cases?
> > Even it would be more consistent with clk_prepare_enable() to print an
> > error here.
> 
> Yes, not all domains have a clk, so we want to ignore the other error.

But shouldn't we set dom->clk to NULL instead of keeping the error pointer? AFAIK clk_prepare_enable is aware of NULL instead of error pointer.

> And we shouldn't print for defers, generally.

Sure, i wanted to refer to all the other error cases.

Stefan
