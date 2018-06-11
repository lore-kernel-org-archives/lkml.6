Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id PfSMIw7bHVuYegAAmS7hNA
	; Mon, 11 Jun 2018 02:14:38 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 7030060795; Mon, 11 Jun 2018 02:14:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 86DE660791;
	Mon, 11 Jun 2018 02:14:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 86DE660791
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753907AbeFKCOg (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Sun, 10 Jun 2018 22:14:36 -0400
Received: from mx.socionext.com ([202.248.49.38]:16895 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753738AbeFKCOe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 22:14:34 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 11 Jun 2018 11:14:33 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 96F44600E8;
        Mon, 11 Jun 2018 11:14:33 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Mon, 11 Jun 2018 11:14:33 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id 22D66403FD;
        Mon, 11 Jun 2018 11:14:33 +0900 (JST)
Received: from DESKTOPFLNNJ4T (unknown [10.213.132.95])
        by yuzu.css.socionext.com (Postfix) with ESMTP id EE339120139;
        Mon, 11 Jun 2018 11:14:32 +0900 (JST)
From: "Katsuhiro Suzuki" <suzuki.katsuhiro@socionext.com>
To: "'Kuninori Morimoto'" <kuninori.morimoto.gx@renesas.com>
Cc: "Mark Brown" <broonie@kernel.org>, <alsa-devel@alsa-project.org>,
        "Masami Hiramatsu" <masami.hiramatsu@linaro.org>,
        "Jassi Brar" <jaswinder.singh@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20180608080843.11097-1-suzuki.katsuhiro@socionext.com> <87h8makxt7.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87h8makxt7.wl-kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH] ASoC: audio-graph-card: add hp and mic detect gpios same as simple-card
Date: Mon, 11 Jun 2018 11:14:29 +0900
Message-ID: <007301d40129$ee1c8380$ca558a80$@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHT/v/sk6RFhax+8k+xLUCtlsNRTaRZl3KAgAC9klA=
Content-Language: ja
x-securitypolicycheck: OK by SHieldMailChecker v2.5.2
x-shieldmailcheckerpolicyversion: POLICY180220
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Morimoto-san,

Thank you for your reviewing.

> -----Original Message-----
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Sent: Monday, June 11, 2018 8:53 AM
> To: Suzuki, Katsuhiro <suzuki.katsuhiro@socionext.com>
> Cc: Mark Brown <broonie@kernel.org>; alsa-devel@alsa-project.org; Masami
Hiramatsu
> <masami.hiramatsu@linaro.org>; Jassi Brar <jaswinder.singh@linaro.org>;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] ASoC: audio-graph-card: add hp and mic detect gpios same
as
> simple-card
> 
> 
> Hi Katsuhiro-san
> 
> Thank you for your patch
> 
> > This patch adds headphone and microphone jack detection gpios as same
> > as simple-card driver. This feature move into simple-card-utils from
> > simple-card to avoid the duplicating code.
> >
> > Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
> > ---
> 
> I think it can be 2 patches ?
>  1. move function from simple-card to simple-card-utils
>  2. use it from audio-graph-card
> 

OK, I'll split this patch.


> > +static int asoc_graph_soc_card_probe(struct snd_soc_card *card)
> > +{
> > +	struct graph_card_data *priv = snd_soc_card_get_drvdata(card);
> > +	int ret;
> > +
> > +	ret = asoc_simple_card_init_hp(card, &priv->hp_jack, NULL);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret = asoc_simple_card_init_mic(card, &priv->mic_jack, NULL);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	return 0;
> > +}
> > +
> >  static int asoc_graph_card_probe(struct platform_device *pdev)
> >  {
> >  	struct graph_card_data *priv;
> > @@ -319,6 +336,7 @@ static int asoc_graph_card_probe(struct platform_device
> *pdev)
> >  	card->num_links	= num;
> >  	card->dapm_widgets = asoc_graph_card_dapm_widgets;
> >  	card->num_dapm_widgets = ARRAY_SIZE(asoc_graph_card_dapm_widgets);
> > +	card->probe	= asoc_graph_soc_card_probe;
> 
> Current simple-card is calling init_hp/init_mic from
> asoc_simple_card_dai_init(), and audio-graph-card has
> asoc_graph_card_dai_init().
> simple/audio card are doing samethings in different style.
> Thus, I want to synchronized whole simple/audio card.
> 

Indeed. I need to add more one patch.

  1. move function from simple-card to simple-card-utils
  2. change calling init_hp/mic from soc_dai_link.init() to
     soc_card.probe()
  3. use it from audio-graph-card


Regards,
--
Katsuhiro Suzuki


> Best regards
> ---
> Kuninori Morimoto
