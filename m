Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D400CC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FCFF2073D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbfBLJDO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 04:03:14 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:45433 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728086AbfBLJDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 04:03:13 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gtTy6-0005hT-DZ; Tue, 12 Feb 2019 10:03:06 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gtTy4-0001GE-Kh; Tue, 12 Feb 2019 10:03:04 +0100
Date:   Tue, 12 Feb 2019 10:03:04 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org, tduszyns@gmail.com,
        mark.rutland@arm.com, alexandre.torgue@st.com,
        mcoquelin.stm32@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2 3/3] pwm: core: add consumer device link
Message-ID: <20190212090304.3j4iqj6sodtdvhr7@pengutronix.de>
References: <1549901522-15071-1-git-send-email-fabrice.gasnier@st.com>
 <1549901522-15071-4-git-send-email-fabrice.gasnier@st.com>
 <20190211190628.eisyi6wjus4ltrrn@pengutronix.de>
 <b9f1bb5c-36cd-f6e6-e6c6-a0257cf38b7e@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b9f1bb5c-36cd-f6e6-e6c6-a0257cf38b7e@st.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Fabrice,

On Tue, Feb 12, 2019 at 09:31:37AM +0100, Fabrice Gasnier wrote:
> On 2/11/19 8:06 PM, Uwe Kleine-König wrote:
> > On Mon, Feb 11, 2019 at 05:12:02PM +0100, Fabrice Gasnier wrote:
> >> @@ -943,6 +950,8 @@ struct pwm_device *devm_of_pwm_get(struct device *dev, struct device_node *np,
> >>  	if (!IS_ERR(pwm)) {
> >>  		*ptr = pwm;
> >>  		devres_add(dev, ptr);
> >> +		device_link_add(dev, pwm->chip->dev,
> >> +				DL_FLAG_AUTOREMOVE_CONSUMER);
> > 
> > IMHO it's surprising that devm_of_pwm_get() does more than of_pwm_get()
> > + devres stuff. I'd put device_link_add() into of_pwm_get().
> 
> Hi Uwe,
> 
> I also agree with this. But I think this implies modifying the API for
> of_pwm_get():
>  /**
>   * of_pwm_get() - request a PWM via the PWM framework
> + * @dev: device for PWM consumer
>   * @np: device node to get the PWM from
>   * @con_id: consumer name
> 
> It seems there aren't much of_pwm_get() users currently.
> Does this look sensible ?

In my eyes this looks sensible, yes.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
