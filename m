Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1469C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF8B7222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bv2GK8ub"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390515AbfBMII5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 03:08:57 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33096 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730406AbfBMII5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 03:08:57 -0500
Received: by mail-pg1-f196.google.com with SMTP id z11so804896pgu.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 00:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8IJYKgmjf2yR7+aqwtgCOFEalvWTzcVJSGELSJ0mLE8=;
        b=Bv2GK8ubktaQH+dCG4j4mCDa0scPCOpYd8tiGdRJuhLebjuY80LubUZ7cp9eN1FvWH
         UrtGbLcpXux0K+nISeaJM9YZ2FI75f8RYwsxrlaw1Xk+CiOERHGPEt6Gi6L7vxp2Jprz
         T+q39kQCu/JgtRKwzGwnaXGXk7DcloPh4p2LU1nT2DS0pkwjq5RP7Eu6Z/NDjZUnr3A6
         r/wgVaSRkDLBY1ZdoBxhrLEjcst4JpR6bAYLtrEMV+2+0nXqJDmw88JXlfL13Uf6mO2o
         yyOPLimsx4GIka0flcwA7OtigmP9duQVVpVF2+K8Wt4GANNxgtJpHZKO95Z93MsJZiQs
         KPsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8IJYKgmjf2yR7+aqwtgCOFEalvWTzcVJSGELSJ0mLE8=;
        b=ETTqz9vdW8M1EBPIuJ4dpd1Ju8+dONyLzHghO7XpuyApyVGYGd9j7upeuhoEgju+L9
         ZoZKWeCrhiHDp4igSMypdp/606FeK4wD4J/jFHPnL4+DcsuECazRnhzZOpGtVvJK3+km
         q2MBoPN+2d28hpy5vICPgODuqlaWu9O/A6Is240iDXJFGel0z5AFmPKXYQ4CjIp2hHA5
         EkqVzlL95C8hubAsR9BOSHuorBTCRgeBxsB8U8tfQYTavMU2TN4fLjVkukCuPxTppU0l
         NskyP7QzJkiPyYzZ8KS3XTHlclSj4qNI/gO3onJXwYj1aLaguRmr8eDo3R+rBgzF1tmf
         B/Vw==
X-Gm-Message-State: AHQUAubNqzAlaAVKYZAdkeMenTRLsfQMsyhgIofjQ/ZeLBUd42Pxy1Nh
        poz0jwpUZJXkhEV18/F/Dw0=
X-Google-Smtp-Source: AHgI3IY9sQ3PXunyCZKLN0xCmoVdwT1DuFvkyPWW1cUZD572IGtNl17BxxOKZP2CFQIOlE0L0NJXsg==
X-Received: by 2002:aa7:8508:: with SMTP id v8mr8387925pfn.14.1550045336481;
        Wed, 13 Feb 2019 00:08:56 -0800 (PST)
Received: from localhost ([39.7.15.189])
        by smtp.gmail.com with ESMTPSA id t5sm26785485pfb.60.2019.02.13.00.08.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 00:08:55 -0800 (PST)
Date:   Wed, 13 Feb 2019 17:08:52 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     xiang xiao <xiaoxiang781216@gmail.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, Xiang Xiao <xiaoxiang@xiaomi.com>
Subject: Re: [PATCH] printk: add KERN_NOTIME to skip the timestamp
Message-ID: <20190213080852.GA1702@jagdpanzerIV>
References: <1549995065-27597-1-git-send-email-xiaoxiang@xiaomi.com>
 <20190212144606.4b7cf0f8@gandalf.local.home>
 <CAH2Cfb-Zd9TKgs52ROVGYg6F_hiN2ieWKwYPkxpVV8St+zwa2A@mail.gmail.com>
 <20190213062912.GA23233@jagdpanzerIV>
 <20190213063815.GA32272@jagdpanzerIV>
 <CAH2Cfb8ENK6f1BKvD4oqGhRjQU6cU5ii_OREcPtjwZqP=1qAeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH2Cfb8ENK6f1BKvD4oqGhRjQU6cU5ii_OREcPtjwZqP=1qAeQ@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (02/13/19 15:14), xiang xiao wrote:
>
> But how can I precisely control timestamp on/off per message
> through sysfs node?
>

Hmm. I don't know how many kernel printk-s you have and how often
do you write to kmsg. I was thinking about something like this:

	echo 0 > /...printk.../time
	dump buffer to /dev/kmsg
	echo 1 > /...printk../time

- If you would have several kernel printk-s in the meantime, then
  those would not have timestamps, but you kinda can roughly guess
  it

	write [1243] foo > /dev/kmsg
	write [1244] foo > /dev/kmsg
		<< printk(bar)               <timestamp ~[1244,1245]>
	write [1245] foo > /dev/kmsg

Maybe this won't suffice.

	-ss
