Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4477DC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 09:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0285B20840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 09:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQ4FzepY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0285B20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbeKITH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 14:07:57 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40853 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727942AbeKITH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 14:07:57 -0500
Received: by mail-lj1-f195.google.com with SMTP id t22-v6so994938lji.7
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 01:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5b8nJovLJk9gu6KlVz8k5MUqM8YfcLM9odog2FYHi4c=;
        b=lQ4FzepYFSX8plHgHKgoKElIqpLUAIxpn444wSLXFrqzVd8Iq3C8+UhaSZgM+3/R+4
         jjnA8cDAJkUgPouOhzTF2GyQLA9X4E/Y+scScef6WvnKooHbrrIzsFDJwyPkfXfkzjvE
         xQc8d9yOS2croAO4GlhV0G+LP0K/+b6onX/1ejZv4v1iIxQIITdhZyVZ2ZEODqUkwoDq
         0Ze/VSsC9bm+gy5k5ORl8qy/G+3eIHsyfBAcATc0Y7WBOIcvlDPnDYhsjilEsIOfIRa4
         J+mXpDDdnO/WBmjGC+g9x91FifPFQtvFdeBZ6ugvXXfaG+83gttYDtff2gD56CeB27kx
         CMiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5b8nJovLJk9gu6KlVz8k5MUqM8YfcLM9odog2FYHi4c=;
        b=mprefJzDuzkLheasBNMHh+A1Wu34D7jAFFbEpUg/4IB54dU/AuzekSbdlTR18G8JgA
         H3SUuChgRsKrTX88OcXTxrhjH9glBBYhJJNpwIv+9T0hoX2Gyxdko+utfkQ5/LOZBpmp
         OvN3MCSbbtuDSB4/2kED5pr5LRtzhWhFQ7RVKeLHgDe9GrAPbXRzB/zhMQq235V6BtRu
         jAD4ETV8PFO1F0t50HFNrM3kTFadZB0oj/HbXDlOr/GxIMzcz5GlpKJSHAoVTg4AFJTN
         leujeD71vugzOtPnlRigHFtj98rmEA1N5suxZo0kxBMUXiw1W/177n0d3MruvOMPwXWm
         wcyQ==
X-Gm-Message-State: AGRZ1gJgCZRBxU3xyQod9ulKSuInWIrVI2C5yLe3fuidlWOXgbh0kfCX
        q8hO3veUjZTMwvH5XYygwJs=
X-Google-Smtp-Source: AJdET5deP/im00O26vQrkI33m8Dad8uVHiMv3c/6SNNaEUZg4XCPJnmvI95KMX3NtWOLxs+YkiEE6A==
X-Received: by 2002:a2e:9819:: with SMTP id a25-v6mr5545068ljj.6.1541755692636;
        Fri, 09 Nov 2018 01:28:12 -0800 (PST)
Received: from uranus.localdomain ([5.18.102.224])
        by smtp.gmail.com with ESMTPSA id g15sm1124884lfb.1.2018.11.09.01.28.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Nov 2018 01:28:11 -0800 (PST)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id 0F3274607EF; Fri,  9 Nov 2018 12:28:11 +0300 (MSK)
Date:   Fri, 9 Nov 2018 12:28:11 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrey Vagin <avagin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] posix-timers: Use array safe helper when fetching
 notification symbolic name
Message-ID: <20181109092810.GF13195@uranus.lan>
References: <20181101182722.GA2869@uranus.lan>
 <alpine.DEB.2.21.1811091010440.1640@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1811091010440.1640@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 10:18:25AM +0100, Thomas Gleixner wrote:
> > +	nidx = array_index_nospec(notify & ~SIGEV_THREAD_ID, ARRAY_SIZE(nstr));
> 
> I completely understand your intention, but this is misleading. The above
> is really not a speculation gadget.
> 
> I'd rather do an open coded check here and fail the thing instead of
> printing wrong information:
> 
>     	   nidx = timer->it_sigev_notify & ~SIGEV_THREAD_ID;
> 	   if (nidx >= ARRAY_SIZE(nstr))
> 	   	return -EINVAL;

Yes, I thought about such approach and did the similar code
in first place, then I dropped it because didn't want additional
"if"s here (your fix in the former commit already does all verification
needed). But thinking more I agree: this code is not time critical
and spending a few cycles won't hurt much. Will update, thanks Thomas!
