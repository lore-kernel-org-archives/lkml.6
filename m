Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC5DEC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 11:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D67620883
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 11:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TRXgZoj+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D67620883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbeKIV3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 16:29:12 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37976 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727702AbeKIV3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 16:29:12 -0500
Received: by mail-lj1-f196.google.com with SMTP id q186-v6so1335475ljb.5;
        Fri, 09 Nov 2018 03:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q7LMD7wuQ+tZZhK0MKgl/vW4M4nPLsiexJn280o9gpY=;
        b=TRXgZoj+L7FUi/yZfx6uAqOl6eE4IPXIuqCBDxBFNTSSPJLr54wy/hQ4kg4iFnntTm
         aJLBY9k288B7zTrHcx1zYSoQzyxMvdus29uSxOKeXVXCr0OGNmdnTGRWpAKb5fSN0r+g
         6FA+ea8mryz3YQCKegsBzwdal8iJ8YAY05izUuW614apWpkKI0yyILCcMmGmo3ol3DoR
         PAXCCPwWbHhW1GzTRJRMoGtJfQNgmMr5oHneAqAabJYnk3e0nVoQFanepi03d6n/agRm
         dhfJcv8o0IFMo/97C/inNVrv813y3qDMUre11+fHUz1ofmeQQN2xyvKsLufyNGKDE0h4
         /x/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q7LMD7wuQ+tZZhK0MKgl/vW4M4nPLsiexJn280o9gpY=;
        b=uNF/psj6tmY86YxRdvjAKkYLQAdX9A4cd2UdT9zlyiTVqHWzlG/7uwfsQ9XJK1sbeO
         I3s/k9KsdUNe6b7VgvydvNqfzzI/vKcYx1CM7ApucKY+RGjfLh1gOdtFEN9xyUtdvKpF
         iRKNR9YoRX1WAgKAdvfaLM/yNHPbm8iMTEJaom7iuj5pocR8dRQVVV6EWfZsv6nrbF1q
         kmDjrEYnDpGBo4h0BKEZSP8bigYe+jWgmrKKB/O+TKLeeWDf/LK8OpXS+4M7p3T9QY7Z
         FcunIsJF3GQxwSGS3U1eJ4CbrKyo1LA3TyO2Mr/LnSQWfeB03pzu1e2BKZ3EGEFqvCqJ
         0M9w==
X-Gm-Message-State: AGRZ1gKoZTZ4P0Vl3bpQ7pcL5qpPaXFBvjYxtYfswpOSvT70Vr9SrnqM
        HcNL2dtfSyn5C4tg92IqPkU=
X-Google-Smtp-Source: AJdET5cb718mQ9GBgN0fd4JoyA+QCr9jiAOyn8T/K9goncQ5eEwWYGX2psoNUzJsliOHj9D9VxCEDA==
X-Received: by 2002:a2e:6c04:: with SMTP id h4-v6mr2458087ljc.92.1541764133842;
        Fri, 09 Nov 2018 03:48:53 -0800 (PST)
Received: from uranus.localdomain ([5.18.102.224])
        by smtp.gmail.com with ESMTPSA id q5-v6sm1194338lfj.85.2018.11.09.03.48.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Nov 2018 03:48:53 -0800 (PST)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id B0EFC460899; Fri,  9 Nov 2018 14:48:50 +0300 (MSK)
Date:   Fri, 9 Nov 2018 14:48:50 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Rafael David Tinoco <rafael.tinoco@linaro.org>
Cc:     adobriyan@gmail.com, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH] proc: fix and merge proc-self-map-file tests
Message-ID: <20181109114850.GL13195@uranus.lan>
References: <20181108111105.GC13195@uranus.lan>
 <20181109113036.21512-1-rafael.tinoco@linaro.org>
 <20181109114123.GK13195@uranus.lan>
 <1541763936.3280758.1571224480.76F1EF1C@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541763936.3280758.1571224480.76F1EF1C@webmail.messagingengine.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 09:45:36AM -0200, Rafael David Tinoco wrote:
...
> > today evening or tomorrow. I think this way everybody will be
> > happy: procfs get passed on arm32 and x86 will still have first
> > page testing.
> 
> Ohh, my understanding was that this was going to be addressed in some other test,
> like what you said.. I did not understand you wanted me to create a test for
> it altogether, my bad. I can do it if you want, let me know, pls.

:-) I'll be able to create patch and test in about 10 hours, so
feel free to beat me if you have time meanwhile.
