Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 814ECC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 01:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51B282146F
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 01:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sk7aKVYM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729667AbfAIBmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 20:42:23 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46955 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729617AbfAIBmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 20:42:22 -0500
Received: by mail-wr1-f65.google.com with SMTP id l9so5982663wrt.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 17:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=b/HJvCgn5Z6ktlShmUJqvAiBoympcmpPOmkEoT0hzHc=;
        b=Sk7aKVYMj7EOy8H9fRgOY7SyUoYBkUiHa9t7rsxy4dLzC1VfBlNl6SY/Kr2TfgaIqV
         fBrt6z/zam8TRrYygQEfOJYYR3TLOcmMu6tETI+0P5B4kUOTV80SPRY1lH7vjlbADCzH
         udIqu6ZIU5P/yf+QBVG3z6mzbsn7m722l/50w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=b/HJvCgn5Z6ktlShmUJqvAiBoympcmpPOmkEoT0hzHc=;
        b=IFd3B0ukmsmppJQVoc342NSmgfWjzplAMat/OVBwvq3H8QEtjDez19ZGnxrfwoTqx6
         atvgirK/u5sfu8MuQxLFSkT/7bpNwDXqO12U5Ok5jHY5jTlShwK7HQd3VnfmGUK46uQb
         DT+0mPNoeMhPA1XEutPolrwUBuHcG4LQjjoE/zJwqLiWtVrHeJwnV089QBGmQ+7POMkP
         YIE7Kb0TXVgjcKaaWGMPa1/SQmq6ps0RXzYDAnVwJGxAsmzCOj2Y6YYsP1g1goqCT76Y
         vLDsscyOVZ7o3xGSvuEZ8IBkjTTQrndspghY78EmWnihIED2exJd+BbSe14E8hDt2gzM
         Uo0w==
X-Gm-Message-State: AJcUukdxChCGC5bIOBWsrNrBBGUPJDwlBL38r6zGgg2jsatZg9+xNCxJ
        e+jIlCDX4O1juBuMIcpUbc4JuA==
X-Google-Smtp-Source: ALg8bN68p7cOe+vxysUeacG+9RLxll6UW+RojJnTZhd+9ifwoJfa9dseDZUZD5Zyand7EbWegT8sAw==
X-Received: by 2002:adf:81c4:: with SMTP id 62mr2941156wra.266.1546998140673;
        Tue, 08 Jan 2019 17:42:20 -0800 (PST)
Received: from linaro.org ([2a01:e0a:f:6020:99e2:bc56:9ad9:69c5])
        by smtp.gmail.com with ESMTPSA id c14sm10756601wme.13.2019.01.08.17.42.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 17:42:19 -0800 (PST)
Date:   Wed, 9 Jan 2019 02:42:18 +0100
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org
Subject: Re: Regression in v5.0-rc1 with autosuspend hrtimers
Message-ID: <20190109014218.GA8363@linaro.org>
References: <20190107233833.GI5544@atomide.com>
 <CAKfTPtDBEmcsLotp-6K1KU1wM9Ba1EpMp3niXScRxYgzjs0nog@mail.gmail.com>
 <20190108155354.GL5544@atomide.com>
 <CAKfTPtCoOK-cYLXJ--sOfpVa9RVmzOAEN1+zB2qHMCzkJN0qaQ@mail.gmail.com>
 <20190108213743.GN5544@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190108213743.GN5544@atomide.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Tuesday 08 Jan 2019 à 13:37:43 (-0800), Tony Lindgren a écrit :
> * Vincent Guittot <vincent.guittot@linaro.org> [190108 16:42]:
> > On Tue, 8 Jan 2019 at 16:53, Tony Lindgren <tony@atomide.com> wrote:
> > > Hmm so could it be that we now rely on timers that that may
> > > not be capable of waking up the system from idle states with
> > > hrtimer?
> > 
> > With nohz and hrtimer enabled,  timer relies on hrtimer to generate
> > the tick so you should use the same interrupt.
> 
> OK yeah looks like that part is working just fine.
> 
> Adding some printks and debugging over ssh, looks like
> omap8250_runtime_resume() gets called just fine based on a wakeirq,
> but then omap8250_runtime_suspend() runs immediately instead of
> waiting for the three second timeout.
> 
> Lowering the autosuspend_delay_ms to 2100 ms makes things work again.
> Anything higher than 2200 ms seems to somehow time out immediately
> now :)

This is quite close to the max ns of an int on arm 32bits

Could you try the patch below ?

---
 drivers/base/power/runtime.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 7062469..44c5c76 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -141,7 +141,7 @@ u64 pm_runtime_autosuspend_expiration(struct device *dev)
 
 	last_busy = READ_ONCE(dev->power.last_busy);
 
-	expires = last_busy + autosuspend_delay * NSEC_PER_MSEC;
+	expires = last_busy + (u64)(autosuspend_delay) * NSEC_PER_MSEC;
 	if (expires <= now)
 		expires = 0;	/* Already expired. */
 
-- 
2.7.4


> 
> Regards,
> 
> Tony
