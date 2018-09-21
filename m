Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A575ECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 15:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E41A2154F
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 15:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="izjp/WOp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E41A2154F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390556AbeIUVl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 17:41:56 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44921 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728149AbeIUVl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 17:41:56 -0400
Received: by mail-pf1-f194.google.com with SMTP id k21-v6so6153413pff.11;
        Fri, 21 Sep 2018 08:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iGPjR/YcEHjRPw4RGDa2LaSIO8X/9tB9268mzGdhPnY=;
        b=izjp/WOpI2psg6k4GD/tBfYiIja+tiiamS4cxIFWJipItt6VI8N2TvjyP+H8VET+IU
         AG5GR3qExjQDsDWCObhJB3HdJ9yJUvTeGnuY2ULhjRxFA9TlGH2Pkgrqyy3vpInoAX+W
         KAvukUiWGi+4oV+o0FaLAsKWn17A6OdTcfYuLDaW2eu5w+ag1wmzrbSVe2IfkDyskcVw
         I7RCjEPUcuPukZIbV7+NJg8DVosJ4rMyndD+roabNdd+ajkniVbEv+Zwl6tlB409xu+W
         ZDZT49BWY1RsoobJsqfRbuoP9r26S17WYEtjQDXHyA5l9qmuNkux1nivWFHgspoHBTx6
         pLCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=iGPjR/YcEHjRPw4RGDa2LaSIO8X/9tB9268mzGdhPnY=;
        b=Z7sgvnF7Vfg2iicIWjpFm1+j9Tb8S5ekvyTK6tMaUDej9Rp7Z/IMonBbmv22JoUJax
         HhhST/Azp5QIYO8aqXitbyyPla0gvyySjsPEqE3HtwNv/6k+qE7Z0UigO3uzpeGBWJ9t
         tyg23sFH9vTAiqXdd/AJTK8TMeat79RPvOPvLiWFSPlDwugfZ5UFJNvqXP17SLzBrtV7
         s5/V5Tq2AKLU4kWWJLTEgn+4YBjwUaw4kS/iDhtcWL+7npZZC6aELZ93RRnaH1XoKQZ8
         wkpLWox6X6G2sKIyE3m0V53fumID+ipnxRRBPGWwKOZELcQuVp5qVh1zPGr4z07YvO6G
         KXpw==
X-Gm-Message-State: APzg51AY20MkphMM56pWPC4Yi7hQYHKmyKpq00G8DVkMdJByt7macw//
        dgumFDB9pgRKOjqNf17ENhQ=
X-Google-Smtp-Source: ANB0VdbOdmwg0yeTp1UJuUUVDOL9OTzn2gARul2BpyWV/Uh/mFg9Qixcjp/VvjxNSCpYJcp5lSKyLg==
X-Received: by 2002:aa7:824d:: with SMTP id e13-v6mr47245677pfn.97.1537545146853;
        Fri, 21 Sep 2018 08:52:26 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id v2-v6sm32091411pgf.58.2018.09.21.08.52.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 08:52:25 -0700 (PDT)
Date:   Fri, 21 Sep 2018 08:52:24 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, support.opensource@diasemi.com
Subject: Re: [PATCH] usb: typec: tcpm: Fix APDO PPS order checking to be
 based on voltage
Message-ID: <20180921155224.GA22237@roeck-us.net>
References: <20180921150411.8BEE73FBE5@swsrvapps-01.diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180921150411.8BEE73FBE5@swsrvapps-01.diasemi.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 04:04:11PM +0100, Adam Thomson wrote:
> Current code mistakenly checks against max current to determine
> order but this should be max voltage. This commit fixes the issue
> so order is correctly determined, thus avoiding failure based on
> a higher voltage PPS APDO having a lower maximum current output,
> which is actually valid.
> 
> Fixes: 2eadc33f40d4 ("typec: tcpm: Add core support for sink side PPS")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>

Makes sense.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Code based on usb-testing branch (ae8a2ca8a2215c7e31e6d874f7303801bb15fbb)
> 
>  drivers/usb/typec/tcpm/tcpm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 4f1f421..c11b3be 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -1430,8 +1430,8 @@ static enum pdo_err tcpm_caps_err(struct tcpm_port *port, const u32 *pdo,
>  				if (pdo_apdo_type(pdo[i]) != APDO_TYPE_PPS)
>  					break;
>  
> -				if (pdo_pps_apdo_max_current(pdo[i]) <
> -				    pdo_pps_apdo_max_current(pdo[i - 1]))
> +				if (pdo_pps_apdo_max_voltage(pdo[i]) <
> +				    pdo_pps_apdo_max_voltage(pdo[i - 1]))
>  					return PDO_ERR_PPS_APDO_NOT_SORTED;
>  				else if (pdo_pps_apdo_min_voltage(pdo[i]) ==
>  					  pdo_pps_apdo_min_voltage(pdo[i - 1]) &&
> -- 
> 1.9.1
> 
