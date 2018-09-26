Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFEB0C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 828F121530
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uT/wewPa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 828F121530
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbeIZWoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 18:44:00 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46690 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728431AbeIZWoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 18:44:00 -0400
Received: by mail-pg1-f194.google.com with SMTP id b129-v6so14170166pga.13;
        Wed, 26 Sep 2018 09:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=G6TMKg1JK3DdFOKzgAVTUm7zuXFLj4VpkHdNlzhq5d4=;
        b=uT/wewPayA1pk6hiwaxlEB5HvrhKPUElSPBR6KTzXUdPoVVp5sE9fHSobcXlWgKjG6
         CKjexVWDRKa2twdGUBVZ2FcSkEQduSWMIOTqV+jXX3c0gnmX+nsWHvsZYN9Q2Wc1CZEb
         gWDI90NELOiSEeGrXFz5BZmxPS24zjVKRdswKLTf2U45AfM7C4oTgX8T3ZLjd0yQaCNQ
         lZFbl3+RIL1SFpBg/zPcG8AGwkiRECt3tQWvdLtFL2mGUdvQlKWgHZVOXDWShhDZALh3
         M45CEyojdSYOZRlUuf5sklToYrWoAcmBUm6F+sbu4V1RAhIDvFTNyc/V6o1R6gDyQA14
         tCuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=G6TMKg1JK3DdFOKzgAVTUm7zuXFLj4VpkHdNlzhq5d4=;
        b=FaCfiw7z4gZPr5C5shST9VByckBJe40qZzzuI59YQZtHovJpmWT+yB2ayxWpaBCb5M
         fmq7CYxybomsWm9dhnYyE26EVwi7U7LcEvNuvJFPUP8JY2V1X++2M3xVXpwRyG9588hF
         Z4txq72at2To0FiZN6XMzsvtOxOau5MxdFteHZLwPEFbCyAfk7SPrXwUaB3F2QWR2R17
         JtRs2q8bb5KrVNtEbwgglzjYjx8uSzeurfcLn0rF0q9AkfopqkLnpcC+phNy5DMg/JPz
         4jT7K+Ptm5vdl3bYMhvvrhsOX10gNlSYIJShmlqX1fgXBIlBcqYmL8otEFJ8P1s01Tit
         ITFw==
X-Gm-Message-State: ABuFfoiNlQYpXiJlqtLgQQfFBmfSkw/KM9suIXKYaLK9LXWHCUkhYnde
        /p1W2KDE/T//dW11d4rsLyA=
X-Google-Smtp-Source: ACcGV63fVVIdQm4nnkgVU6uKt3zXwDhalvb/7gT5zKfbRBcU9338NdweXw2Yhd1RmxXym/zswYdKRg==
X-Received: by 2002:a63:eb53:: with SMTP id b19-v6mr6351368pgk.371.1537979415456;
        Wed, 26 Sep 2018 09:30:15 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id c23-v6sm9108243pfh.26.2018.09.26.09.30.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 09:30:14 -0700 (PDT)
Date:   Wed, 26 Sep 2018 09:30:13 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        support.opensource@diasemi.com
Subject: Re: [PATCH 2/2] usb: typec: fusb302: Resolve fixed power role
 contract setup
Message-ID: <20180926163013.GB17716@roeck-us.net>
References: <cover.1537975081.git.Adam.Thomson.Opensource@diasemi.com>
 <383410593681e2fed025a4b538ea0840ff370a9a.1537975081.git.Adam.Thomson.Opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <383410593681e2fed025a4b538ea0840ff370a9a.1537975081.git.Adam.Thomson.Opensource@diasemi.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 04:23:52PM +0100, Adam Thomson wrote:
> When the controller is configured for a fixed power role (Source
> only or Sink only), attach does not proceed within the TCPM state
> machine as there is no CC event generated by this driver to update
> the CC line status.
> 
> To rectify this, when CC is configured as Source or Sink we now
> make use of the hardware's automatic fixed Source or Sink
> toggling mechanism, which detects attaches in the same way as for
> DRP toggling. In this way the result of toggling is handled in the
> same way by the 'fusb302_handle_togdone()' function, and CC events
> are generated as expected for TCPM allowing a contract to be
> established.
> 
> Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/usb/typec/tcpm/fusb302.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb302.c
> index fd851d8..43b64d9 100644
> --- a/drivers/usb/typec/tcpm/fusb302.c
> +++ b/drivers/usb/typec/tcpm/fusb302.c
> @@ -679,6 +679,7 @@ static int tcpm_set_cc(struct tcpc_dev *dev, enum typec_cc_status cc)
>  	int ret = 0;
>  	bool pull_up, pull_down;
>  	u8 rd_mda;
> +	enum toggling_mode mode;
>  
>  	mutex_lock(&chip->lock);
>  	switch (cc) {
> @@ -764,6 +765,29 @@ static int tcpm_set_cc(struct tcpc_dev *dev, enum typec_cc_status cc)
>  		chip->intr_comp_chng = false;
>  	}
>  	fusb302_log(chip, "cc := %s", typec_cc_status_name[cc]);
> +
> +	/* Enable detection for fixed SNK or SRC only roles */
> +	switch (cc) {
> +	case TYPEC_CC_RD:
> +		mode = TOGGLING_MODE_SNK;
> +		break;
> +	case TYPEC_CC_RP_DEF:
> +	case TYPEC_CC_RP_1_5:
> +	case TYPEC_CC_RP_3_0:
> +		mode = TOGGLING_MODE_SRC;
> +		break;
> +	default:
> +		mode = TOGGLING_MODE_OFF;
> +		break;
> +	}
> +
> +	if (mode != TOGGLING_MODE_OFF) {
> +		ret = fusb302_set_toggling(chip, mode);
> +		if (ret < 0)
> +			fusb302_log(chip,
> +				    "cannot set fixed role toggling mode, ret=%d",
> +				    ret);
> +	}
>  done:
>  	mutex_unlock(&chip->lock);
>  
> -- 
> 1.9.1
> 
