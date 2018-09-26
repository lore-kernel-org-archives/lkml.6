Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25E9C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B6F32152C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/Mwpno4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B6F32152C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbeIZWkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 18:40:51 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46418 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727692AbeIZWku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 18:40:50 -0400
Received: by mail-pg1-f196.google.com with SMTP id b129-v6so14166080pga.13;
        Wed, 26 Sep 2018 09:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Yp8Cm4sbdHce8SdBYK0K1jSxXq2Hc1wxPUgs2H92s2s=;
        b=J/Mwpno4imXY9P+YOOh5BUwLSZuBfu7IlfgCM9YxIIKfCESogPKC4eU1Ck2ziBqGJc
         BiyDxG3f5s0K1SgXCUcP+8D+17A8aye3U88t3WPyEMlnU0Mewh/fzYMcf/x4IpCH3w0Z
         siJQub0DUbuhq+YipDwK6sRwkuhTm0GHaEKbV8ZUDClxiVRxYs1dso+W2GDfH66oY8W7
         lTOb5ys+kBDsD0m5B9+CAPI3FlrR4R7tZCbp1wrEieqxln1fMD7uYtgoBpHX9J55aQKl
         s4OVzcCyxXHngOXu7KCj0ypRDEzEUxBfYYdrShIrjk+8VPcWIg1C1ht9ONIyRryuriQE
         zO6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Yp8Cm4sbdHce8SdBYK0K1jSxXq2Hc1wxPUgs2H92s2s=;
        b=pB5Ow3quIeE4c+hDpYHxr+aTYvqfucYBMsloAcC7JJO6Ur9zU/v0gGE5he1+xVlyXo
         KjoT0q4b/YjE4xQtOd4rI4iEDszFh01HYiNR3Lc+wpS2QM5RMB0uS7qM8l0U6i90vMsd
         7/nd9qP3iuSCzGeANzGilHp7Lmz9daOVG8L8Tivn8OrDFqU9TqqBW3LGhFm682JVQXL1
         HaU6zsk6WoagPmxGIn/AJc/2hVUjl5JoiSlxWI/N2rSp5cITJXwEdDZlKltdJaW7DmZr
         b4PFT1wFoVf6WbsUquEIsYET2JwFwIaCmnOCIvCxscmX6g+2fH88uYZ5zoe1Zh20fh5z
         WIzg==
X-Gm-Message-State: ABuFfogpB+7dSS8k90FvCpBQeMPyahIelrLOeqSLUyRsUUsQSsCP2stu
        jCugtNTOU9zZE2G2Q0Y9Uf8=
X-Google-Smtp-Source: ACcGV62rq6umCcn4b7d2BsjVFL/EAI4el1NsrsPBbNCxoeJyRvqbN3Dx1Kv0C8ufcp16U7KbXtzaBg==
X-Received: by 2002:a65:5cc3:: with SMTP id b3-v6mr6494177pgt.277.1537979226685;
        Wed, 26 Sep 2018 09:27:06 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id 89-v6sm13774142pfk.134.2018.09.26.09.27.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 09:27:05 -0700 (PDT)
Date:   Wed, 26 Sep 2018 09:27:04 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        support.opensource@diasemi.com
Subject: Re: [PATCH 1/2] usb: typec: fusb302: Correct spelling mistake for
 toggling state
Message-ID: <20180926162704.GA17716@roeck-us.net>
References: <cover.1537975081.git.Adam.Thomson.Opensource@diasemi.com>
 <8ef602efbb7ee84ec86225ae4b9e1d138154e51b.1537975081.git.Adam.Thomson.Opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ef602efbb7ee84ec86225ae4b9e1d138154e51b.1537975081.git.Adam.Thomson.Opensource@diasemi.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 04:23:51PM +0100, Adam Thomson wrote:
> There's a typo in the enum name of the 'OFF' state for toggling
> (TOGGLINE instead of TOGGLING). This commit resolves that trivial
> spelling inconsistency.
> 
> Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/usb/typec/tcpm/fusb302.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb302.c
> index 6e9370a..fd851d8 100644
> --- a/drivers/usb/typec/tcpm/fusb302.c
> +++ b/drivers/usb/typec/tcpm/fusb302.c
> @@ -42,7 +42,7 @@
>  #define T_BC_LVL_DEBOUNCE_DELAY_MS 30
>  
>  enum toggling_mode {
> -	TOGGLINE_MODE_OFF,
> +	TOGGLING_MODE_OFF,
>  	TOGGLING_MODE_DRP,
>  	TOGGLING_MODE_SNK,
>  	TOGGLING_MODE_SRC,
> @@ -594,7 +594,7 @@ static int fusb302_set_toggling(struct fusb302_chip *chip,
>  	chip->intr_comp_chng = false;
>  	/* configure toggling mode: none/snk/src/drp */
>  	switch (mode) {
> -	case TOGGLINE_MODE_OFF:
> +	case TOGGLING_MODE_OFF:
>  		ret = fusb302_i2c_mask_write(chip, FUSB_REG_CONTROL2,
>  					     FUSB_REG_CONTROL2_MODE_MASK,
>  					     FUSB_REG_CONTROL2_MODE_NONE);
> @@ -626,7 +626,7 @@ static int fusb302_set_toggling(struct fusb302_chip *chip,
>  		break;
>  	}
>  
> -	if (mode == TOGGLINE_MODE_OFF) {
> +	if (mode == TOGGLING_MODE_OFF) {
>  		/* mask TOGDONE interrupt */
>  		ret = fusb302_i2c_set_bits(chip, FUSB_REG_MASKA,
>  					   FUSB_REG_MASKA_TOGDONE);
> @@ -702,7 +702,7 @@ static int tcpm_set_cc(struct tcpc_dev *dev, enum typec_cc_status cc)
>  		ret = -EINVAL;
>  		goto done;
>  	}
> -	ret = fusb302_set_toggling(chip, TOGGLINE_MODE_OFF);
> +	ret = fusb302_set_toggling(chip, TOGGLING_MODE_OFF);
>  	if (ret < 0) {
>  		fusb302_log(chip, "cannot stop toggling, ret=%d", ret);
>  		goto done;
> @@ -1292,7 +1292,7 @@ static int fusb302_handle_togdone_snk(struct fusb302_chip *chip,
>  		tcpm_cc_change(chip->tcpm_port);
>  	}
>  	/* turn off toggling */
> -	ret = fusb302_set_toggling(chip, TOGGLINE_MODE_OFF);
> +	ret = fusb302_set_toggling(chip, TOGGLING_MODE_OFF);
>  	if (ret < 0) {
>  		fusb302_log(chip,
>  			    "cannot set toggling mode off, ret=%d", ret);
> @@ -1388,7 +1388,7 @@ static int fusb302_handle_togdone_src(struct fusb302_chip *chip,
>  		tcpm_cc_change(chip->tcpm_port);
>  	}
>  	/* turn off toggling */
> -	ret = fusb302_set_toggling(chip, TOGGLINE_MODE_OFF);
> +	ret = fusb302_set_toggling(chip, TOGGLING_MODE_OFF);
>  	if (ret < 0) {
>  		fusb302_log(chip,
>  			    "cannot set toggling mode off, ret=%d", ret);
> -- 
> 1.9.1
> 
