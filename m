Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA98BC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F1172083B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vp/Gj0b6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730382AbfBESf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 13:35:57 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44624 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbfBESfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 13:35:55 -0500
Received: by mail-pf1-f196.google.com with SMTP id u6so1852831pfh.11
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 10:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UD1D1/zeln9BcYQboyvZPGUwHcSN4Fr2utgEgbr6nDE=;
        b=vp/Gj0b6yMgibxTuMU6o5q0IoGSWWYhDC3U2gJkXVovIxe0t7P7o7tJEsBZbAFNHGx
         DWiHSsWZayFZJpNZHM4FYrKpsDT7u5hLJfuAY6Q6jPWqY4QcXK+Tvao55MVPiq+BYo78
         HzBFcxvgaq/S463ojytyJmpYVNAKgbFK9Ecr0y7kLwacEdKNAuu2CiuidrSVCP/T/KfS
         s0f9f7oEq/wPTLNOgAA13tkXwSBAui4xJgzqrRUNCBOvZUgeSxC6gAiDqQo3BI89sn3u
         eCFuCkq/FntBPNnKS0p9HZ57oqteXJ5xZlSl4D6T/oQlrBUNvyjI+fgrpGVI07g/a3eG
         Nj6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UD1D1/zeln9BcYQboyvZPGUwHcSN4Fr2utgEgbr6nDE=;
        b=Bg5JlOh1WjBIPBHvmsBerLyh4b+u6FbrdiNC7+v7QfFCzj9eXB3pcfe/2t/IXBSpZ3
         Mc4EqzmbmyDbp4eCTGLl5GynnT1XpICPoW+Pfk8XTrXvnOL54PIT3E0ZP3ZlujlA9evx
         avws6ZQDnuE9fp80/BcBE0YuxmJAD73Tt652PgoUFpFYgOhQhZXL9zjqE2aXCfLL3vIj
         oNUVhqunaAKSqkUQJg96wRP9Lx3WCt/zG+lvAfJq5nGdBZlW6Un5st4aXpDk25s3BMrH
         ullQGvCCA1JXOTWVNxmIyj9Tkele04N6+uZ8y9l+F9qwUwgOYZZqr1haxd6qJx0rq+ry
         zyog==
X-Gm-Message-State: AHQUAuaEExnWyP71/6q0sRopuwczeKHPpY8cRJf4vaqV/o0JpQ64zNyj
        +M7dfefPzYsoLXVc1Z/j74V+5Q==
X-Google-Smtp-Source: AHgI3IY8k28F8PdfxDQA+sjqf98AK8ZfiZOfLB7gag1eRCRnCN59uT/A3J+kzwV0hrV/Y93WOSR7/A==
X-Received: by 2002:a62:fc8a:: with SMTP id e132mr6299225pfh.176.1549391754269;
        Tue, 05 Feb 2019 10:35:54 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id y84sm16125779pfb.81.2019.02.05.10.35.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Feb 2019 10:35:53 -0800 (PST)
Date:   Tue, 5 Feb 2019 10:35:49 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, bgoswami@codeaurora.org,
        rohitkr@codeaurora.org
Subject: Re: [PATCH] qcom: apr: Make apr callbacks in non-atomic context
Message-ID: <20190205183548.GC23363@builder>
References: <20181115184904.27223-1-srinivas.kandagatla@linaro.org>
 <20190131011649.GA27190@builder>
 <7555094b-350b-b4c6-47c6-507f7ce99dc5@linaro.org>
 <20190131160551.GD2387@tuxbook-pro>
 <49a8b982-356b-73ad-0f9a-46e0f496ce02@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49a8b982-356b-73ad-0f9a-46e0f496ce02@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 31 Jan 09:33 PST 2019, Srinivas Kandagatla wrote:

> On 31/01/2019 16:05, Bjorn Andersson wrote:
> > Sure, but we want the design to allow for that still, either in future
> > upstream or by additional downstream code.
> > 
> Yes, I agree, I don't have solution for this ATM.
> It will be interesting to see how Intel handles this kind of usecase on
> there DSP.
> 
> The whole issue is the APR messaging is not really atomic in nature, it is
> basically request->response but the fact in existing code is that smd/glink
> callbacks run in interrupt context.
> 
> Trying to pretend that APR is atomic in nature is problem with audio.
> 
> As audio (dai-links) can be marked as atomic or non-atomic depending on
> which bus it links with, for example when it has to work with other buses
> like slimbus, soundwire, i2c whose transactions can sleep we mark the audio
> dai-link as non-atomic which means that the functions can sleep.
> In the above case, invoking any audio functions as part of the rpmsg
> callback is an issue.
> 
> The only solution I found to address this is handle the callbacks in
> workqueue.
> 

Okay, I think we should merge this and once we have the means of doing
low latency playback we can measure and worst case revisit this
decision.

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> > > Also it depends on definition of "latency", is the latency referring to
> > > "filling the data" or "latency between DSP command and response".
> > > 
> > I'm referring to the latency between the message from the DSP until we
> > give it a new buffer.
> > 
> > > For former case as long as we have more samples in our ring buffer there
> > > should be no latency in filling the data.
> > > For later case it should not really matter as long as former case is taken
> > > care off.
> > > 
> > > Low latency audio involves smaller sample sizes and no or minimal
> > > preprocessing in DSP so am guessing that we should be okay with responses in
> > > workqueue as long as we have good size ring buffer.
> > > 
> > Relying on more buffered data will increase the latency of the audio,
> > preventing you from doing really low-latency things.
> My bad!.. Yes, in low latency case we would have very less buffers!
> 
> srini
> 
