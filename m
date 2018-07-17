Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F8DECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DFC02086D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9ycpU/G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DFC02086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731228AbeGQQYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 12:24:48 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:38947 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729755AbeGQQYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 12:24:48 -0400
Received: by mail-pl0-f66.google.com with SMTP id p23-v6so647260plo.6;
        Tue, 17 Jul 2018 08:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=G2uP0r/qMylzgGtFaZxCGlBnrHX1oy1f/I42cSXMtZ4=;
        b=f9ycpU/GmGuE0nGXG4Ak1au9r8o4wFvWrDt6DULaya9O+HXNF1hBm1mToc66J1d1lS
         rOKqzrROy0XpLpYdBnBWGyFieQKW3wdYdAvBQzTCMpr82EKXDqlu50jRf30KvIiolvW7
         LrGj1mqrClfKchqMpgAXf0nOskbqedm01845UHtwsTeazKTRlod58EOBaMT2UxijgTDF
         1Lw3OH897uYO8rRdohkUCDyhJbBqTDsP97Tya8uUqgdMIWio0+5E6ccukfGz53F4QcXq
         3EzeGYP1TFrXIIfv17z9VUqtqkHdEvSeQcLA/UpRr1pLkkpzN+ZkXOwrcJ6stEqn61Ri
         DPmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=G2uP0r/qMylzgGtFaZxCGlBnrHX1oy1f/I42cSXMtZ4=;
        b=i1irIKsTTicLjlvBe+69CyYmMhGdEN2Oz6J+CMzrLW4qy7eQV33gNbDvatL7gDG+6E
         BCs+cRlgBhgKC1XWOpkNAg8XS0Fsnm3sR9nFwd6xLE0RkKF10WSmZip2JO2KkMfKka9I
         P79/Qmf2+ynYWTf4OruCrG6DqPNigRcdCZvRPqCj4gfB4yurTep/aOGOOsrnLRzQ18KY
         eCgODLiJe8xOb7QtA92X0RkSPSBM5ckHYrXtCtblGSi3D/5USl0Z/djCqnDpTlMx5JJk
         yhNQRJOyMpxcPAANX13FUfMzEl3RdRPJRqzpo9IakCBiOMNBELT173L58jFIsEN8RyZH
         KjtA==
X-Gm-Message-State: AOUpUlF6GXCh4403tMk4yb8c/aWQRzyXVJ+tdoUCWgKmg1/mQqBDr4oU
        qWg8nuQDpHBMrbZL4xCObnw=
X-Google-Smtp-Source: AAOMgpekLw9gDJtuGACnvqiNXmUB9qhp3N3BPRZ4s78g2wHRoBvKLUBU+p0madtsj/9L3iBfed7BJg==
X-Received: by 2002:a17:902:3c5:: with SMTP id d63-v6mr2174147pld.163.1531842690615;
        Tue, 17 Jul 2018 08:51:30 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id t76-v6sm2418723pfe.109.2018.07.17.08.51.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 08:51:29 -0700 (PDT)
Date:   Tue, 17 Jul 2018 08:51:29 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        support.opensource@diasemi.com
Subject: Re: [PATCH] usb: typec: tcpm: Fix sink PDO starting index for PPS
 APDO selection
Message-ID: <20180717155129.GB29933@roeck-us.net>
References: <20180717143619.80EEB3FBB7@swsrvapps-01.diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717143619.80EEB3FBB7@swsrvapps-01.diasemi.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 03:36:19PM +0100, Adam Thomson wrote:
> There is a bug in the sink PDO search code when trying to select
> a PPS APDO. The current code actually sets the starting index for
> searching to whatever value 'i' is, rather than choosing index 1
> to avoid the first PDO (always 5V fixed). As a result, for sources
> which support PPS but whose PPS APDO index does not match with the
> supporting sink PPS APDO index for the platform, no valid PPS APDO
> will be found so this feature will not be permitted.
> 
> Sadly in testing, both Source and Sink capabilities matched up and
> this was missed. Code is now updated to correctly set the start
> index to 1, and testing with additional PPS capable sources show
> this to work as expected.
> 
> Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/usb/typec/tcpm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
> index 74e0cda..4f1f421 100644
> --- a/drivers/usb/typec/tcpm.c
> +++ b/drivers/usb/typec/tcpm.c
> @@ -2238,7 +2238,7 @@ static unsigned int tcpm_pd_select_pps_apdo(struct tcpm_port *port)
>  			 * PPS APDO. Again skip the first sink PDO as this will
>  			 * always be 5V 3A.
>  			 */
> -			for (j = i; j < port->nr_snk_pdo; j++) {
> +			for (j = 1; j < port->nr_snk_pdo; j++) {
>  				pdo = port->snk_pdo[j];
>  
>  				switch (pdo_type(pdo)) {
> -- 
> 1.9.1
> 
