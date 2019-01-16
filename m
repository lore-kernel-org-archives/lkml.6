Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD213C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACF0420657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:43:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="SytJIsY0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393708AbfAPOnk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 09:43:40 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39979 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729639AbfAPOnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 09:43:39 -0500
Received: by mail-wm1-f66.google.com with SMTP id f188so2235718wmf.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 06:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RN8JpFilnUd7X+1+7CcRjucomiFk14b4T2rqhUt5Trw=;
        b=SytJIsY0yC03iWnRHLd8fYtpEdxVqq8B3zOkP05BR590EE3ei9zJqtwotDi6x9P/CH
         tVheE7tuGap5O4Rb7TCRP+RIMJ9mlIj8J4HS3hEwEBK3xQkuJmH2igC2jiKm08McFQ0M
         woNSPBbmS93iARD7dkFYNDNvCZgvsswdEiVsp62yJgZpKoB5Oke6KDeP7LFhaG7pJRCb
         Ckbf/q2jtK0vhsbej8t10yuLSaXRr7Rb7zJni79oivZxPIjRllSCt+jmkfzKxKgbId8w
         bDDOV93x59DYICidy9+UAS5Z3aLfg3J/5aYKkIbqbV4qutNRgMc0Y/Y6Mn96usT8139t
         c0TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RN8JpFilnUd7X+1+7CcRjucomiFk14b4T2rqhUt5Trw=;
        b=mJkQQ5jCEQvRMwxCwSgLugoCf/FYmWjG6KELgBQgMnKuuVN9hI/zjB5gdZK18zj5+P
         ZKV2SVt8t+aH5aDRzzb9eMZLX6w9RxRL1bK3kOHy+97R50cfA/M1eUYaEqyXHhA2aMNW
         A669yewEXyDXUCXUtlvAHyIED3sanInoeRnNdLty01sit6gvzr0StcDFlzQcL/+A8ft1
         GFs53mxlcZvGJ8+bUWprM/IugxypW5RwJZ/JtMJRQJuo1fJFGqp8r3VAwEcBoLoSsR/D
         tHwqaRF9wJQUpNHlzzgmS0BNRfarfNLFX1NDQ9VNzlWb4AJk2YknHhn7vCzqRBirMJ5h
         8HNg==
X-Gm-Message-State: AJcUukc1L6Y+JRmoFb7JrYmJlpUkzCWKEB5FeK7RaU6HjdeKB9gZ1VWM
        qIFxXGcj3ivwpkf/4IJPgBathw==
X-Google-Smtp-Source: ALg8bN4Nk4fQM8FHA2w/2L4dEIpyFVDNSB9lXzOnuRoOIi7DfMATWmEJCBq+IEmACdqiyLdfXUDHRA==
X-Received: by 2002:a1c:c483:: with SMTP id u125mr7765176wmf.14.1547649817939;
        Wed, 16 Jan 2019 06:43:37 -0800 (PST)
Received: from localhost (ip-89-177-6-176.net.upcbroadband.cz. [89.177.6.176])
        by smtp.gmail.com with ESMTPSA id g129sm34008268wmf.39.2019.01.16.06.43.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 06:43:37 -0800 (PST)
Date:   Wed, 16 Jan 2019 15:35:07 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Jian-Hong Pan <starnight@g.ncu.edu.tw>
Cc:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        netdev@vger.kernel.org, linux-lpwan@lists.infradead.org,
        Ben Whitten <ben.whitten@lairdtech.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 4/5] net: lorawan: Fulfill the help text of Kconfig
Message-ID: <20190116143507.GH5265@nanopsycho>
References: <20190116142048.19446-1-starnight@g.ncu.edu.tw>
 <20190116142458.19542-4-starnight@g.ncu.edu.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116142458.19542-4-starnight@g.ncu.edu.tw>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, Jan 16, 2019 at 03:25:00PM CET, starnight@g.ncu.edu.tw wrote:
>Mention the LoRaWAN network feature to distinguish it from other
>Low-Power Wide-Area Network like Sigfox and NB-IoT.
>
>Signed-off-by: Jian-Hong Pan <starnight@g.ncu.edu.tw>
>---
> net/lorawan/Kconfig | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/net/lorawan/Kconfig b/net/lorawan/Kconfig
>index bf6c9b77573b..ce3ed6e6d11c 100644
>--- a/net/lorawan/Kconfig
>+++ b/net/lorawan/Kconfig
>@@ -4,7 +4,8 @@ config LORAWAN
> 	  LoRaWAN defines low data rate, low power and long range wireless
> 	  wide area networks. It was designed to organize networks of automation
> 	  devices, such as sensors, switches and actuators. It can operate
>-	  multiple kilometers wide.
>+	  multiple kilometers wide.  The network is client/server technology

Please avoid double spaces.


>+	  centered around gateways.
> 
> 	  Say Y here to compile LoRaWAN support into the kernel or say M to
> 	  compile it as a module.
>-- 
>2.20.1
>
>
>_______________________________________________
>linux-lpwan mailing list
>linux-lpwan@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/linux-lpwan
