Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 128D9C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 06:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9AB021A0D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 06:29:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QA9clUwe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9AB021A0D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388489AbeHGImA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 04:42:00 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:44854 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727725AbeHGImA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 04:42:00 -0400
Received: by mail-pl0-f66.google.com with SMTP id ba4-v6so6668208plb.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 23:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0051tf2uH/KemC1FXT/3lJa6zc4uOJeaKvnRGPgh5vw=;
        b=QA9clUwexXYzrqJ+4vsMbYgjFbOnT3B7K6DPobc25uSauxMB+o+9QMKWb/QJ4FpXRA
         PQMF+GAs0Z4OEYHB++qpdMzmhHjEo0rnvVN+iR5fclhSXqGIjb4qcuTIabR+Vy+BL8VK
         nINZxD+Q41+ZW0kQRLYksmkSpJd6BKHe54jZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0051tf2uH/KemC1FXT/3lJa6zc4uOJeaKvnRGPgh5vw=;
        b=GqycTyx4b2us5reR87TunTXpcV0p+Q7L8QjHG1iIEcADByK3MI4JNTDqGsca18t99O
         bJ9eO/fm7h0PHAMaWw29Qkyck5MbCneSXR33x+4uo7K8MU2XFaak64uX/tvYI+UoKD0z
         FzF2kEse0YsdyL9PF0NLKyPnLbg+4UOAGpm8PT6sJqivm/+jRGdwOvWWK0R+/Zy14gL8
         znAkeZXuv6v91UYhn52NydUm6QS+PoQaJ+9pP4Wy5mMqA6HhFeT3/4qV56ue8/x9SdBC
         CzRHHpzq80s0bHWWhqz1Y8vCE2Lsi1VavmfiAWLbOGJ+dRLqFLLMuSgRFVwB3+oemmvz
         WbUA==
X-Gm-Message-State: AOUpUlHyCTxBwh6swfIN4AI7t9a9X25tvgYgn7QbiqxAa0eogopgp4Ay
        3+hHCnetl9YdycEnA1wOXHXpVg==
X-Google-Smtp-Source: AAOMgpfsPXth6nrJQVXyP+oSthB8TATMu/mM/eAldtSr2PgonKrSYv9UgBSgsIhnCsuZ/LvlroWADQ==
X-Received: by 2002:a17:902:760d:: with SMTP id k13-v6mr16490893pll.56.1533623352272;
        Mon, 06 Aug 2018 23:29:12 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id s73-v6sm888288pfi.154.2018.08.06.23.29.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Aug 2018 23:29:11 -0700 (PDT)
Date:   Mon, 6 Aug 2018 23:32:29 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Kiran Gunda <kgunda@codeaurora.org>
Cc:     jingoohan1@gmail.com, lee.jones@linaro.org,
        b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        daniel.thompson@linaro.org, jacek.anaszewski@gmail.com,
        pavel@ucw.cz, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH V4 8/8] backlight: qcom-wled: Add auto string detection
 logic
Message-ID: <20180807063229.GE23866@tuxbook-pro>
References: <1531131741-19971-1-git-send-email-kgunda@codeaurora.org>
 <1531131741-19971-9-git-send-email-kgunda@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531131741-19971-9-git-send-email-kgunda@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 09 Jul 03:22 PDT 2018, Kiran Gunda wrote:
> diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
[..]
> @@ -189,6 +206,15 @@ static int wled4_set_brightness(struct wled *wled, u16 brightness)
>  	return 0;
>  }
>  
> +static void wled_ovp_work(struct work_struct *work)
> +{
> +	struct wled *wled = container_of(work,
> +					 struct wled, ovp_work.work);
> +
> +	if (wled->ovp_irq > 0)
> +		enable_irq(wled->ovp_irq);
> +}
> +
>  static int wled_module_enable(struct wled *wled, int val)
>  {
>  	int rc;
> @@ -200,7 +226,18 @@ static int wled_module_enable(struct wled *wled, int val)
>  				WLED_CTRL_REG_MOD_EN,
>  				WLED_CTRL_REG_MOD_EN_MASK,
>  				val << WLED_CTRL_REG_MOD_EN_SHIFT);
> -	return rc;
> +	if (rc < 0)
> +		return rc;
> +
> +	if (val) {
> +		schedule_delayed_work(&wled->ovp_work, WLED_SOFT_START_DLY_US);

schedule_delayed_work() takes a delay in jiffies, not micro seconds.

> +	} else {
> +		cancel_delayed_work_sync(&wled->ovp_work);

If we get here within WLED_SOFT_START_DLY_US of a module enable we have
yet to execute the enable_irq() in the delayed worker, which should mean
that the irq is unbalanced from then on.

I believe you can check the return value of cancel_delayed_work_sync()
being true to know if wled_ovp_work() was yet to execute.

> +		if (wled->ovp_irq > 0)
> +			disable_irq(wled->ovp_irq);
> +	}
> +
> +	return 0;
>  }
>  

Regards,
Bjorn
