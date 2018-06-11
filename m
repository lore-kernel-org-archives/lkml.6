Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id SRfAFC8LHlttJwAAmS7hNA
	; Mon, 11 Jun 2018 05:39:59 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 4310F60792; Mon, 11 Jun 2018 05:39:59 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A88E3606FA;
	Mon, 11 Jun 2018 05:39:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A88E3606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753982AbeFKFj4 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Mon, 11 Jun 2018 01:39:56 -0400
Received: from mx.socionext.com ([202.248.49.38]:20223 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753750AbeFKFjz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 01:39:55 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 11 Jun 2018 14:39:54 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 57F5A6006F;
        Mon, 11 Jun 2018 14:39:54 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Mon, 11 Jun 2018 14:39:54 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id E409740389;
        Mon, 11 Jun 2018 14:39:53 +0900 (JST)
Received: from DESKTOPFLNNJ4T (unknown [10.213.132.95])
        by yuzu.css.socionext.com (Postfix) with ESMTP id BBE1F120139;
        Mon, 11 Jun 2018 14:39:53 +0900 (JST)
From: "Katsuhiro Suzuki" <suzuki.katsuhiro@socionext.com>
To: "'Kuninori Morimoto'" <kuninori.morimoto.gx@renesas.com>
Cc: "Mark Brown" <broonie@kernel.org>, <alsa-devel@alsa-project.org>,
        "Masami Hiramatsu" <masami.hiramatsu@linaro.org>,
        "Jassi Brar" <jaswinder.singh@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20180611051559.18082-1-suzuki.katsuhiro@socionext.com>     <20180611051559.18082-2-suzuki.katsuhiro@socionext.com> <87tvq96gnm.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87tvq96gnm.wl-kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH v2 2/3] ASoC: simple-card: move hp and mic detection to soc_card probe
Date: Mon, 11 Jun 2018 14:39:50 +0900
Message-ID: <007401d40146$9ddaaec0$d9900c40$@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHUAUNKMw3htV1h6EmRYccv/MXyMaRZ8EuAgACXr0A=
Content-Language: ja
x-securitypolicycheck: OK by SHieldMailChecker v2.5.2
x-shieldmailcheckerpolicyversion: POLICY180220
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Morimoto-san,

> -----Original Message-----
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Sent: Monday, June 11, 2018 2:27 PM
> To: Suzuki, Katsuhiro <suzuki.katsuhiro@socionext.com>
> Cc: Mark Brown <broonie@kernel.org>; alsa-devel@alsa-project.org; Masami
Hiramatsu
> <masami.hiramatsu@linaro.org>; Jassi Brar <jaswinder.singh@linaro.org>;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v2 2/3] ASoC: simple-card: move hp and mic detection to
soc_card
> probe
> 
> 
> Hi Katsuhiro-san
> 
> > This patch moves headphone and microphone detection to probe() of
> > snd_soc_card from init() of snd_soc_dai_link. This is because init()
> > is called (and an input device /dev/input/eventX is created too)
> > twice or above if simple card has two or more DAI links.
> >
> > Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
> 
> or above ?
> 

It seems if simple card has multiple DAI links, it creates multiple input 
devices.

For example simple card has 3-links, 3 input devices /dev/input/event0,
event1, event2 are created. Is it correct?


> > -	ret = asoc_simple_card_init_hp(rtd->card, &priv->hp_jack, PREFIX);
> > -	if (ret < 0)
> > -		return ret;
> > -
> > -	ret = asoc_simple_card_init_mic(rtd->card, &priv->mic_jack, PREFIX);
> > -	if (ret < 0)
> > -		return ret;
> (snip)
> > +	ret = asoc_simple_card_init_hp(card, &priv->hp_jack, NULL);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret = asoc_simple_card_init_mic(card, &priv->mic_jack, NULL);
> > +	if (ret < 0)
> > +		return ret;
> 
> I think we want to keep "PREFIX" ?
> 

Oops... Thank you. I'll fix it.


Regards,
--
Katsuhiro Suzuki


> 
> Best regards
> ---
> Kuninori Morimoto
