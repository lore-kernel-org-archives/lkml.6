Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3AC6C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 20:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73A0421741
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 20:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jUB14QvS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbeLZUah (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 15:30:37 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42878 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727632AbeLZUag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 15:30:36 -0500
Received: by mail-pf1-f193.google.com with SMTP id 64so8218473pfr.9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 12:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VQJT6MeJYrSPdPAfIPKE/lvVa8lxNLDID4YH/mNOmAQ=;
        b=jUB14QvSc4hNzVjUV08nKq+qYf0VNoPxgVd+s0BRfgC0/o5ZNqcvc6lmaAquE+yyzo
         1nolxv3eQdTwQjG/Q1wYCTbqcY7Y5e66DDV3kx0Ew9MHWx7x3d1E79TUOBJotX6djpTb
         QH+LyOve9pQ8OdoUL+W3PQJFFmAf883O62oP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VQJT6MeJYrSPdPAfIPKE/lvVa8lxNLDID4YH/mNOmAQ=;
        b=YnbfIVInzQ6Px4kT25fZnkOG7Uw0o6UoD9kIqPRNxo5s1t9NyO0fEgoY8BdXhqT4GP
         8il8mvuDSTa+Ziw/fLrKVShDgFZovdTXAKXZyg+1AaBTWnl1l7k3XRxYh69Hc28MFxm9
         Xit3LIjGhqQUd3GrP2+iOh7X7WY2n3Qakvb6h4EYcAuczrKl7gtfA3ciC/5Z5qzSeOcB
         UlkzSlt2cvi/bAl3Z222hTkilsSw7WJE5G+bvM+30Ryu3gjMdOWM+R6ffNg4bCeZDfNp
         jf+IqBJ3mKYHvdKWvX14xRD3FMk59881mqQgz9+p2tlr8EQi0imxB+JkUd8f63/8J82q
         hFfg==
X-Gm-Message-State: AJcUukfO4ZenOWm9aNntb3HviNVnMwaAzYYG+J5zSNWcFZR31rGnbu4c
        /ybdgfp6whA4bkjeWZ9n+BuxeA==
X-Google-Smtp-Source: ALg8bN7SDC8G5ilaX+taPuDUqBxVtc9/5ymp5Qwx8QkZyWQegqDv8mAbFiLV8wZlYTZaCWRBlbGAjQ==
X-Received: by 2002:a63:235f:: with SMTP id u31mr20128965pgm.122.1545856235897;
        Wed, 26 Dec 2018 12:30:35 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id m9sm41821157pgd.32.2018.12.26.12.30.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Dec 2018 12:30:34 -0800 (PST)
Date:   Wed, 26 Dec 2018 12:30:33 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] soc: qcom: Add AOSS QMP genpd provider
Message-ID: <20181226203032.GF9704@minitux>
References: <20181112080557.22698-1-bjorn.andersson@linaro.org>
 <20181112080557.22698-4-bjorn.andersson@linaro.org>
 <dfd0096c-d1f1-da0e-7c4c-3da916d521dc@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfd0096c-d1f1-da0e-7c4c-3da916d521dc@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 26 Nov 19:31 PST 2018, Sai Prakash Ranjan wrote:

> Hi Bjorn,
> 

Thanks for your review Sai!

> On 11/12/2018 1:35 PM, Bjorn Andersson wrote:
[..]
> > +static int qmp_pd_clock_toggle(struct qmp_pd *res, bool enable)
> > +{
> > +	char buf[96];
> > +	size_t n;
> > +
> > +	n = snprintf(buf, sizeof(buf), "{class: clock, res: %s, val: %d}",
> > +		     res->name, !!enable);
> > +	return qmp_send(res->qmp, buf, n);
> > +}
> > +
> 
> I was trying to get QDSS working with these patches and found one issue
> in qmp_send of qmp_pd_clock_toggle.
> 
> The third return value should be sizeof(buf) instead of n because n just
> returns len as 33 and the below check in qmp send will always fail and
> trigger WARN_ON's.
> 
>          if (WARN_ON(len % sizeof(u32))) {
>                  dev_err(qmp->dev, "message not 32-bit aligned\n");
>                  return -EINVAL;
>          }
> 
> Also I observed that multiple "ucore will not ack channel" messages with
> len being returned n instead of buf size.
> 

I must have been "lucky" when I did my final pass of cleanups and
retests, thanks for spotting this!

> One more thing is do we really require *WARN_ON and dev_err* both because it
> just spams the kernel logs, I think dev_err message is clear
> enough to be able to understand the error condition.
> 

No, that's just unnecessary.

Regards,
Bjorn
