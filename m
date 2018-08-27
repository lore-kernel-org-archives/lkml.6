Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31014C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 14:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E01CB2087A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 14:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OF4ztLOh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E01CB2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbeH0Shi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 14:37:38 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44193 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727174AbeH0Shi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 14:37:38 -0400
Received: by mail-pg1-f195.google.com with SMTP id r1-v6so7540009pgp.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 07:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TZJ2PbymgiEijg3ptMu/B05O6z0FWcu9+9sZVlpoRMc=;
        b=OF4ztLOhUFL02oJL/wOdaiFSeVJ42hlvzp99DnMlj4mv9uq46DeNBHs1gkl8a0quV+
         5duygG/lHm1om6Rs86ktjPAbbsPL5gtVf7tmKX96r6JuKJrXhG8rwAjCVjslpOSRB00P
         WZvJFj7V8lk7dKuVYNXEiz/vH88UF+g9zS144=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TZJ2PbymgiEijg3ptMu/B05O6z0FWcu9+9sZVlpoRMc=;
        b=exJjQzFklLcSWjz7aNAGjmb5mwNwYhvSDGokBxWjYUfeVPB6OfNcWQMlc7ckpWXD39
         wH1RKtzgiUVRpejIbU7TLBaAJD/Ak69S6AyOzkGzD7dii3ZI15xr56TK+Avl8iTYbqup
         fr6am085VPG8yJ+wLFw/w0lFo+EMLamEb5gDkFwmmGKNnousZPDBpCwM7K0Bhzas2rG8
         5tFlkLXeghSjE1XbVBzWcIgpuJ3bf9x6WRvWwilCD5hzdtSR8S//BOFHb4iGYG0ijyhu
         kKLRl69iOswuzbDsi5kTOosFcW+JjtgtjyFrTn3KvcPCWMsU2Hfg/UC9wkrwBTfiKOLn
         GknA==
X-Gm-Message-State: APzg51D5x2wG79nYsA1uAwklNjNXFyaFUAy1+/f/Nwb9q7UEScf9pNKw
        kbkC3CTssMczWpk7rZEXmuZTDA==
X-Google-Smtp-Source: ANB0VdZ0TGYxavFjXK7IMRlr6C+ciNmRZYTjmPPZoCLbSkPrEnduL7cmWqeTY5fkIZkopAjBO6G9FQ==
X-Received: by 2002:a63:dd49:: with SMTP id g9-v6mr12366373pgj.356.1535381441214;
        Mon, 27 Aug 2018 07:50:41 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id j195-v6sm27028467pgc.25.2018.08.27.07.50.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Aug 2018 07:50:40 -0700 (PDT)
Date:   Mon, 27 Aug 2018 07:54:20 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Kiran Gunda <kgunda@codeaurora.org>
Cc:     jingoohan1@gmail.com, lee.jones@linaro.org,
        b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        daniel.thompson@linaro.org, jacek.anaszewski@gmail.com,
        pavel@ucw.cz, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH V5 8/8] backlight: qcom-wled: Add auto string detection
 logic
Message-ID: <20180827145420.GL3048@tuxbook-pro>
References: <1535106467-17843-1-git-send-email-kgunda@codeaurora.org>
 <1535106467-17843-9-git-send-email-kgunda@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535106467-17843-9-git-send-email-kgunda@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 24 Aug 03:27 PDT 2018, Kiran Gunda wrote:
> diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
[..]
>  struct wled {
> @@ -135,16 +146,22 @@ struct wled {
>  	struct regmap *regmap;
>  	struct mutex lock;	/* Lock to avoid race from thread irq handler */
>  	ktime_t last_short_event;
> +	ktime_t start_ovp_fault_time;
>  	u16 ctrl_addr;
>  	u16 sink_addr;
>  	u16 max_string_count;
> +	u16 auto_detection_ovp_count;
>  	u32 brightness;
>  	u32 max_brightness;
>  	u32 short_count;
> +	u32 auto_detect_count;
>  	bool disabled_by_short;
>  	bool has_short_detect;
> +	int ovp_irq;
> +	bool ovp_irq_disabled;

ovp_irq_disabled is now only assigned, never read. So you should be able
to drop it.

[..]
> @@ -200,7 +226,18 @@ static int wled_module_enable(struct wled *wled, int val)
>  				WLED_CTRL_REG_MOD_EN,
>  				WLED_CTRL_REG_MOD_EN_MASK,
>  				val << WLED_CTRL_REG_MOD_EN_SHIFT);
> -	return rc;
> +	if (rc < 0)
> +		return rc;
> +
> +	if (val) {
> +		schedule_delayed_work(&wled->ovp_work, HZ / 100);

wled_ovp_work() is a nop when ovp_irq == 0, so wrap the entire if/else
in a check for ovp_irq > 0 (rather than include it in the else) and drop
it from the worker.

> +	} else {
> +		if (!cancel_delayed_work_sync(&wled->ovp_work) &&
> +		    wled->ovp_irq > 0)
> +			disable_irq(wled->ovp_irq);
> +	}
> +
> +	return 0;

Also, if a user calls rmmod within 10ms of enabling module we will
schedule work of code that's no longer available in the kernel. So you
need to also cancel_delayed_work_sync() in the remove function of the
driver.


Apart from this I think this patch looks good now!

Regards,
Bjorn
