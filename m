Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43202C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 08:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED9A52154C
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 08:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RHAk8b60"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED9A52154C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbeHHLLm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 07:11:42 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42757 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbeHHLLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 07:11:41 -0400
Received: by mail-ed1-f67.google.com with SMTP id r4-v6so860090edp.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 01:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3UhH7fdKj9bOBGJA9WDC9b/IGHIbzEqBIAhWtSEIr/c=;
        b=RHAk8b60DBI7hXpRpAIdkBo3NKwmoy3iibZdAHc0/4tM3tPjIApJIaMwDXwzMV6FfE
         i7zMBvWPq/llU0XVunHFa/QQsYWF+zmKbXJTMH85nAAO0KCywWYDmJ08AXbghEQn0ueu
         kdVYSx8+ApjHsVWS+psAGX4BApH+ZQOrOA6/XzbqFFCvvS3OFuyp4Xsbl8SuOOuDEVjh
         a6Cqp+vzpvz4xw3IRLVd6LkvCJH/0vC1E0iQOAO71VcRfO9aPN1GmnhfUt0aH4UjxiZQ
         svr8mUCIYee3gL5igC5uGAwO1foHsQTlAEs19yuxRoGziZ6TGfKb5Is6ddt4J/MZdMFn
         0BjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3UhH7fdKj9bOBGJA9WDC9b/IGHIbzEqBIAhWtSEIr/c=;
        b=OKfAVq4OvjIFEnPgv+pDfcTLlfSRxT4y8QQuiy8oBjvMRcaWjg26Wqn/JkLWmBA8q7
         11J2fLo4vF4y1WSVEa5qm/dtn3o0mHdYIZTLL/9OGfJ1xJ8ldeAfzPv5RhJWAULqhrfm
         khmmgrLrfKd+0uK6rB6yJatR2xzSeHUJCTuyt4XMUghgDjVfkQeQFpvFZW0KFX5/5hsT
         f4ff3JE6SRx1H9cTDSYkXHcDyruu913QUAcoFGMWUbohtDyDI74qkcCOWw/AP2147pRx
         nVYlstgvAHyg1iG0Cb62ygjXfcC6znxGjwxRfrMSCYh4n+pRjBAf8RhxH9GaMKFlBPZA
         8gmg==
X-Gm-Message-State: AOUpUlFYoQ5Bx0/7f4K07/9Qw/Tp8K+xEgGOizopDpJitrkRJkvfwAT3
        sCACTEcalfCpCX24YPlDoeND16jM9V0=
X-Google-Smtp-Source: AA+uWPxQFPY+kfHLDgRw1sNzuFbZpQd/Kv/YCmOjQ/C6rm1QXZeJXB1h9BPBbY8ouCZLnlTNFH+MMg==
X-Received: by 2002:a50:b266:: with SMTP id o93-v6mr2212338edd.173.1533718377116;
        Wed, 08 Aug 2018 01:52:57 -0700 (PDT)
Received: from xux707-tw ([109.76.213.36])
        by smtp.gmail.com with ESMTPSA id r11-v6sm1347076edp.60.2018.08.08.01.52.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Aug 2018 01:52:56 -0700 (PDT)
Date:   Wed, 8 Aug 2018 09:52:59 +0100
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH 04/17] staging:rtl8192u: Rename eqMacAddr macro - Style
Message-ID: <20180808085258.GA31258@xux707-tw>
References: <20180807211255.29343-1-johnfwhitmore@gmail.com>
 <20180807211255.29343-5-johnfwhitmore@gmail.com>
 <f06112b569731e2c5de3958d1b9de5a039b7ed0d.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f06112b569731e2c5de3958d1b9de5a039b7ed0d.camel@perches.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2018 at 01:12:53AM -0700, Joe Perches wrote:
> On Tue, 2018-08-07 at 22:12 +0100, John Whitmore wrote:
> > The eqMacAddr(a, b) macro causes a checkpatch issue, due to CamelCase
> > naming, so has been renamed to eq_mac_addr(a, b).
> > 
> > This is a coding style change which should not impact on runtime code
> > execution.
> []
> > diff --git a/drivers/staging/rtl8192u/ieee80211/dot11d.h b/drivers/staging/rtl8192u/ieee80211/dot11d.h
> []
> > @@ -30,7 +30,7 @@ struct rt_dot11d_info {
> >  	enum dot11d_state state;
> >  };
> >  
> > -#define eqMacAddr(a, b)		(((a)[0] == (b)[0] &&		    \
> > +#define eq_mac_addr(a, b)		(((a)[0] == (b)[0] &&		    \
> >  	(a)[1] == (b)[1] && (a)[2] == (b)[2] && (a)[3] == (b)[3] && \
> >  	(a)[4] == (b)[4] && (a)[5] == (b)[5]) ? 1 : 0)
> 
> I'd check to see if the etherdevice.h ether_addr_equal
> would be used instead of this macro.
> 

Deadly thanks a million for that input! That Macro gives a checkpatch
warning about the obvious side effects, which I have yet to tackle. I'm
cherry picking the easy stuff ;) getting to know my way around.

I'll check that other macro later today and hopefully reissue a better
v2 of the series. (same for your second email on the other macro)

thanks again.
