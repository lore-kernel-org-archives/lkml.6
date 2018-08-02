Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3241C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 932FE2159F
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="N3bNNaec"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 932FE2159F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732329AbeHBXsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 19:48:23 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38972 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732006AbeHBXsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 19:48:23 -0400
Received: by mail-pf1-f196.google.com with SMTP id j8-v6so2072713pff.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 14:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hDo64eeItt5T9UxE2nsFi+Bp1dQ740xkVGLMqbOAVbo=;
        b=N3bNNaecAvR+vDqNR/CH/DTW7iDT7M3ZsAXVDGWXSewAEdLDTeJmX7X0LzsQOmlcoT
         CX3Z+uuIysJ5QU4naVreQ3+8pLl4MSUSXvmTbGLF+JpgqvpG2lHUL66xijGeSpU5A/Du
         85dPGV2hS/+EUrLALxXv28o4MPF8kZKlCQ4UA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hDo64eeItt5T9UxE2nsFi+Bp1dQ740xkVGLMqbOAVbo=;
        b=B81Etd49y5Am/ALWCX9WquZZd7t3PMQbpdiUBA6zlQvuzWVHJA2sALeefocpqwjWsq
         bBV/IBbowiFzxsEvPeNqXeVph6Rjkpoo1DJ24E9XOVe0qIzU8TNeCfLntmqMPcXHCxqc
         VQvSRSZhnyDHcguzlu2NIb0XwmKjubv6njJ8wcmM5urujAso+pFVfzLhSn8fsU9Y/LaZ
         pl16jwx9j1V2g496JVr+a9ki7ayv41oNtXoupmbGA/0aQSF6OTGZ7zHiaOn8CBivfB5S
         YSu6So+nF/2wg5PzSYk3dGA3WgSUisA2x8OYB1t0ONW0iMicsBgR9VRGusoldYYpVtn+
         r57g==
X-Gm-Message-State: AOUpUlErDr5er8sO+0HouPjO1gebdLGFwZKWXKHpuUZxRhW2lB1br6Xg
        J9PXpn/QifcLyTRkYjk3m+22fresjzY=
X-Google-Smtp-Source: AAOMgpe/ohn8dIM7p/PDJbPPQ3aK9jMH0r6LiLyE7cqqStVGVlujVwaU+ClxuRegtORRBFB4VHTghQ==
X-Received: by 2002:a62:3545:: with SMTP id c66-v6mr1283947pfa.63.1533246919476;
        Thu, 02 Aug 2018 14:55:19 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id d26-v6sm6684387pfl.159.2018.08.02.14.55.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Aug 2018 14:55:18 -0700 (PDT)
Date:   Thu, 2 Aug 2018 14:53:40 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Baolin Wang <baolin.wang@linaro.org>, pavel@ucw.cz,
        rteysseyre@gmail.com, david@lechnology.com, broonie@kernel.org,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] leds: core: Introduce LED pattern trigger
Message-ID: <20180802215340.GP30024@minitux>
References: <1bf9aed83d1756dd4f81590297ce7e0b9972bf85.1533112637.git.baolin.wang@linaro.org>
 <34c87589-ccaf-e541-7acb-efcf3bd306f6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34c87589-ccaf-e541-7acb-efcf3bd306f6@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 02 Aug 14:21 PDT 2018, Jacek Anaszewski wrote:
> On 08/01/2018 11:01 AM, Baolin Wang wrote:
[..]
> > diff --git a/drivers/leds/trigger/ledtrig-pattern.c b/drivers/leds/trigger/ledtrig-pattern.c
[..]
> > +static ssize_t pattern_trig_store_pattern(struct device *dev,
> > +					  struct device_attribute *attr,
> > +					  const char *buf, size_t count)
> > +{
> > +	struct led_classdev *led_cdev = dev_get_drvdata(dev);
> > +	struct pattern_trig_data *data = led_cdev->trigger_data;
> > +	int cr, ccount, offset = 0, err = 0;
> > +
> > +	if (!data->hardware_pattern)
> > +		del_timer_sync(&data->timer);
> > +
> > +	mutex_lock(&data->lock);
> > +
> > +	data->npatterns = 0;
> > +	while (offset < count - 1 && data->npatterns < MAX_PATTERNS) {
> > +		cr = 0;
> > +		ccount = sscanf(buf + offset, "%d %d " PATTERN_SEPARATOR "%n",
> > +				&data->patterns[data->npatterns].brightness,
> > +				&data->patterns[data->npatterns].delta_t, &cr);
> 
> In case user makes a typo while constructing list of pattern tuples,
> e.g. he forgets a comma, the pattern gets silently truncated.
> 
> User is able to detect the truncation by reading pattern file,
> but it is not an immediate feedback anyway.
> 

I agree, a failure to parse the entire pattern should result in an error
returned, rather than just silently truncating the pattern.

> I propose that pattern format should require number of tuples in the
> first position which would allow to get rid of this ambiguity, since
> we could verify if the number of parsed tuples is as intended.
> 

I would prefer to see that we check that we have consumed the entire
input (accepting optional \n end), rather than having to prepend a count
to the string...

Regards,
Bjorn
