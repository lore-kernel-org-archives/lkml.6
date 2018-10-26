Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B470AECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 19:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55F992082D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 19:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMMwQUOK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55F992082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbeJ0EfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 00:35:17 -0400
Received: from mail-lf1-f50.google.com ([209.85.167.50]:39573 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbeJ0EfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 00:35:17 -0400
Received: by mail-lf1-f50.google.com with SMTP id p11-v6so1805967lfc.6;
        Fri, 26 Oct 2018 12:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SwSC0hfte0HszjM1kIaGkNToumPieMmROUmTJPjVgx8=;
        b=kMMwQUOKdpO4D+G+otR5jpysAGCgyn+AaSHEUwgTmC8DXS8BMdz5IqR2oyqZLeLT9r
         QqYTQNCPhpnZd0ZfIuNnj0Lu/tyEmpi3/yHPUzCIEJobMXuXNL+1w4eAK6d9HbCaU+fO
         mzwMU94k61R5gBfpy9ipSl5LbiYPpoZ9fobM9fAshAJ14E8dr6HuaBo53+LQhPTsEHgf
         qcOrPdXMfAeg0F9HQr4hmoQxUX3q6CeD+7w4bBiZrwLGZNcXDUTr+S94T+aOY+CnVbVf
         9jOMTU27YG/FXCbjDcRma/6ymGY6OTlAmUyeWAUSqO3NG+j2lB7oZSKKeKGnc/dEkgOr
         2Mrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SwSC0hfte0HszjM1kIaGkNToumPieMmROUmTJPjVgx8=;
        b=S7/T5jlGWIIDXD6fHBccS9yhUusL4s2HDJs0aezq7EtxzfnVVxhx/lNEOXq6rEI1q2
         YACtu3Y7iFjhjPH+xA3TsDDNu+m8CXQJGArbm0gf0pTTr43b29//EUPiTvaF7BkASrw3
         y1NlUwbgmCyakQbxRKTdQFPNIP3y8lmkzSqYVqw1i0+fftB8Riuo9PTzXubYzMS8M/gR
         9NFcfNKFgtLVs893mY6M+Z9hg7CIvCAD8XBgjro1TBEbL6+d4JEbyVRaEWoP7goG7a5g
         44DUA7jPrWAl1cX9jfJABMknTjN3/IEqd8j/AqSIDNt2FKQykaC2SvamrhZz1Em2ze8b
         euJA==
X-Gm-Message-State: AGRZ1gL9m9uLtVeDtY5pvt/RFRCmamixcVhznjxKtP8Dpfd+mUsinSIK
        18jmb13Sv+dV1NpxZuCGUUIw7AhT2Z0=
X-Google-Smtp-Source: AJdET5f3lgZ4hwW+UkKVGOeOetVcnF4uHW9JKdoeNCS/to7oNmeBvm0q916ePTHdFs/kqRqg7vSIeA==
X-Received: by 2002:a19:48d0:: with SMTP id v199mr2876327lfa.104.1540583814963;
        Fri, 26 Oct 2018 12:56:54 -0700 (PDT)
Received: from [192.168.1.18] (bfy71.neoplus.adsl.tpnet.pl. [83.28.62.71])
        by smtp.gmail.com with ESMTPSA id o5-v6sm557481ljh.34.2018.10.26.12.56.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 12:56:54 -0700 (PDT)
Subject: Re: More checks for patterns? was: Fix pattern handling
 optimalization
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Baolin Wang <baolin.wang@linaro.org>, rteysseyre@gmail.com,
        bjorn.andersson@linaro.org, broonie@kernel.org,
        linus.walleij@linaro.org, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <9794969ab8a5a6f62d8ac54cdebcaa3caedfc6d6.1539230481.git.baolin.wang@linaro.org>
 <d90397dd-429f-4f3f-307c-b69dccc360e0@gmail.com> <20181024083143.GA24165@amd>
 <bdadda71-f919-b6a6-4e1c-f87ed298b6b5@gmail.com> <20181024204439.GA32300@amd>
 <79c29d20-ae6a-4a12-28fa-93d7305a0623@gmail.com> <20181025212429.GB18016@amd>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <216b2cb8-dd3e-6849-8643-ab5aef92c7a8@gmail.com>
Date:   Fri, 26 Oct 2018 21:56:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181025212429.GB18016@amd>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/2018 11:24 PM, Pavel Machek wrote:
> 
> We don't want brightness < 0, but this may not be best way to do
> this. We also don't want brightness > max_brightness, but I'm not sure
> this check is effective.
> 
> We probably also don't want pattern where all the delta_t s are zero.
> 
> I came up with this so far....
>    	    	       	    	    	      	  	    Pavel
> 
> 
> 
> diff --git a/drivers/leds/trigger/ledtrig-pattern.c b/drivers/leds/trigger/ledtrig-pattern.c
> index ce7acd1..bc5f495 100644
> --- a/drivers/leds/trigger/ledtrig-pattern.c
> +++ b/drivers/leds/trigger/ledtrig-pattern.c
> @@ -250,9 +251,16 @@ static ssize_t pattern_trig_store_patterns(struct led_classdev *led_cdev,
>  
>  	while (offset < count - 1 && data->npatterns < MAX_PATTERNS) {
>  		cr = 0;
> -		ccount = sscanf(buf + offset, "%d %u %n",
> +		ccount = sscanf(buf + offset, "%u %u %n",
>  				&data->patterns[data->npatterns].brightness,
>  				&data->patterns[data->npatterns].delta_t, &cr);
> +
> +		if (data->patterns[data->npatterns].brightness > data->led_cdev->max_brightness) {
> +			data->npatterns = 0;
> +			err = -EINVAL;

We don't fail on attempt of setting brightness > max_brightness, but
only truncate it. In this case we could do the same for consistency.

> +			goto out;
> +		}
> +			 
>  		if (ccount != 2) {
>  			data->npatterns = 0;
>  			err = -EINVAL;
> 
> 
> 
> 

-- 
Best regards,
Jacek Anaszewski
