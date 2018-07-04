Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.9 required=3.0 tests=DKIM_SIGNED,MAILING_LIST_MULTI,
	SPF_PASS,T_DKIM_INVALID,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA77C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31B60219E7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DicBNxDe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31B60219E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752819AbeGDQPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 12:15:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53288 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752173AbeGDQPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 12:15:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=F0VDFAnSCUzVa//KeRhwEVaPcdYEnWIIgU1rjQ9FjL8=; b=DicBNxDew9CY1jcdfr3Zfk9Ej
        nVO/O+aPlVD+jsPoMsCegfDbEjsas3drpkMsB2WAyTa9FzY6pnCfUl8C8V7b9CeUdahnvBvq/Sm5C
        dRS0HZ9Rsf9FXGXJQQ5IEM5KrtnlySoLKJo/F0J8wCQrHy/b5qmpM0V5nQADAi3gjSwrrMON5Yqw+
        oO5uhUPs2wL2ApFnwLVEYdehTS4gPeyQm5lgjBNj/TpnuF53fxqpe2nBT/QHNRvU2CzU0iGU9TbF7
        GasTcFL7OBAVGwGNkzYOeBf2cRYvEfBDAdKJtV075B1kAyH5L3mdFM6Ru4lu7gZko2Lq8o380tysj
        vdFiiQD8A==;
Received: from [179.182.160.95] (helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fakRM-0004Ls-8X; Wed, 04 Jul 2018 16:15:36 +0000
Date:   Wed, 4 Jul 2018 13:15:32 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Thomas Hollstegge <thomas.hollstegge@gmail.com>
Cc:     linux-media@vger.kernel.org, Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sean Young <sean@mess.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Stefan =?UTF-8?B?QnLDvG5z?= <stefan.bruens@rwth-aachen.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] si2168: Set TS clock mode and frequency
Message-ID: <20180704131532.628ee1c6@coco.lan>
In-Reply-To: <1526149500-9256-1-git-send-email-thomas.hollstegge@gmail.com>
References: <1526149500-9256-1-git-send-email-thomas.hollstegge@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, 12 May 2018 20:24:58 +0200
Thomas Hollstegge <thomas.hollstegge@gmail.com> escreveu:

> Some devices require a higher TS clock frequency to demodulate some
> muxes. This adds two optional parameters to control the TS clock
> frequency mode as well as the frequency.
> 
> Signed-off-by: Thomas Hollstegge <thomas.hollstegge@gmail.com>
> ---
>  drivers/media/dvb-frontends/si2168.c      | 20 +++++++++++++++++++-
>  drivers/media/dvb-frontends/si2168.h      |  8 ++++++++
>  drivers/media/dvb-frontends/si2168_priv.h |  2 ++
>  3 files changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/dvb-frontends/si2168.c b/drivers/media/dvb-frontends/si2168.c
> index 324493e..b05e677 100644
> --- a/drivers/media/dvb-frontends/si2168.c
> +++ b/drivers/media/dvb-frontends/si2168.c
> @@ -92,13 +92,15 @@ static int si2168_ts_bus_ctrl(struct dvb_frontend *fe, int acquire)
>  	dev_dbg(&client->dev, "%s acquire: %d\n", __func__, acquire);
>  
>  	/* set TS_MODE property */
> -	memcpy(cmd.args, "\x14\x00\x01\x10\x10\x00", 6);
> +	memcpy(cmd.args, "\x14\x00\x01\x10\x00\x00", 6);
>  	if (acquire)
>  		cmd.args[4] |= dev->ts_mode;
>  	else
>  		cmd.args[4] |= SI2168_TS_TRISTATE;
>  	if (dev->ts_clock_gapped)
>  		cmd.args[4] |= 0x40;
> +	cmd.args[4] |= (dev->ts_clock_mode & 0x03) << 4;
> +


Hmm... looking at this patch and on the next one, it seems that the
clock mode is either 1 (AUTO) or 2 (MANUAL), right?

If so, I would just do, instead:

	if (dev->ts_clock_freq)
		cmd.args[4] = SI2168_TS_CLOCK_MODE_AUTO_ADAPT << 4;
	else
		cmd.args[4] = SI2168_TS_CLOCK_MODE_MANUAL << 4;

And get rid of dev->ts_clock_mode parameter.

That seems more error-prune, as just specifying ts_clock_freq is
enough for the driver to do the right thing.

>  	cmd.wlen = 6;
>  	cmd.rlen = 4;
>  	ret = si2168_cmd_execute(client, &cmd);
> @@ -398,6 +400,18 @@ static int si2168_set_frontend(struct dvb_frontend *fe)
>  	if (ret)
>  		goto err;
>  
> +	/* set TS frequency */
> +	if (dev->ts_clock_freq) {
> +		memcpy(cmd.args, "\x14\x00\x0d\x10", 4);
> +		cmd.args[4] = ((dev->ts_clock_freq / 10000) >> 0) & 0xff;
> +		cmd.args[5] = ((dev->ts_clock_freq / 10000) >> 8) & 0xff;
> +		cmd.wlen = 6;
> +		cmd.rlen = 4;
> +		ret = si2168_cmd_execute(client, &cmd);
> +		if (ret)
> +			goto err;
> +	}
> +
>  	memcpy(cmd.args, "\x14\x00\x08\x10\xd7\x05", 6);
>  	cmd.args[5] |= dev->ts_clock_inv ? 0x00 : 0x10;
>  	cmd.wlen = 6;
> @@ -806,6 +820,10 @@ static int si2168_probe(struct i2c_client *client,
>  	dev->ts_mode = config->ts_mode;
>  	dev->ts_clock_inv = config->ts_clock_inv;
>  	dev->ts_clock_gapped = config->ts_clock_gapped;
> +	dev->ts_clock_mode = config->ts_clock_mode;
> +	if (dev->ts_clock_mode == 0)
> +		dev->ts_clock_mode = SI2168_TS_CLOCK_MODE_AUTO_ADAPT;
> +	dev->ts_clock_freq = config->ts_clock_freq;
>  	dev->spectral_inversion = config->spectral_inversion;
>  
>  	dev_info(&client->dev, "Silicon Labs Si2168-%c%d%d successfully identified\n",
> diff --git a/drivers/media/dvb-frontends/si2168.h b/drivers/media/dvb-frontends/si2168.h
> index d519edd..3f52ee8 100644
> --- a/drivers/media/dvb-frontends/si2168.h
> +++ b/drivers/media/dvb-frontends/si2168.h
> @@ -47,6 +47,14 @@ struct si2168_config {
>  	/* TS clock gapped */
>  	bool ts_clock_gapped;
>  
> +	/* TS clock mode */
> +#define SI2168_TS_CLOCK_MODE_AUTO_ADAPT	0x01
> +#define SI2168_TS_CLOCK_MODE_MANUAL	0x02
> +	u8 ts_clock_mode;
> +
> +	/* TS clock frequency (for manual mode) */
> +	u32 ts_clock_freq;
> +
>  	/* Inverted spectrum */
>  	bool spectral_inversion;
>  };
> diff --git a/drivers/media/dvb-frontends/si2168_priv.h b/drivers/media/dvb-frontends/si2168_priv.h
> index 2d362e1..8173d6c 100644
> --- a/drivers/media/dvb-frontends/si2168_priv.h
> +++ b/drivers/media/dvb-frontends/si2168_priv.h
> @@ -48,6 +48,8 @@ struct si2168_dev {
>  	u8 ts_mode;
>  	bool ts_clock_inv;
>  	bool ts_clock_gapped;
> +	u8 ts_clock_mode;
> +	u32 ts_clock_freq;
>  	bool spectral_inversion;
>  };
>  



Thanks,
Mauro
