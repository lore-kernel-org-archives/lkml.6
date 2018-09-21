Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FF8ECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 18:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7319821567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 18:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RRAOabQf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7319821567
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391311AbeIVAnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 20:43:13 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:38266 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391089AbeIVAnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 20:43:13 -0400
Received: by mail-it1-f196.google.com with SMTP id p129-v6so3087391ite.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 11:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ImqkEEgiOKqxK2ibm/xeSlKoj5RWZHlodOvqR+yHhjo=;
        b=RRAOabQfFLk0Rq8EsTUDEgUwRociv1HiFJ4L4d9vormW+gQeLLXyFrVdrxHrfRLoO9
         KYxqPY5qWx9WjX4iuu9A50VqczsxeareUyG5IrWoIpJvbLYeb8FWCmZsVAnGlIsWrTSU
         oBJm0pxhacFBPMO7zBZFajXGQrFqoOhFWcU78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ImqkEEgiOKqxK2ibm/xeSlKoj5RWZHlodOvqR+yHhjo=;
        b=hVsPfYR/bg1cSn1QOaKyeQZWwLX3DxCRyxHi5Swha/5l6nRewfjLNozgNXo3KEqwgI
         SPoWj/tCKd1pREQ9D8mHuyqsVGD+w2S6QbRb8/Yo/wae1ujc2zRkUr/vkwPHbEhaMuNq
         OVTQ35E2UwXA9j+0WL5qffVIjC3IHItZ5aE+y7Hb+xXHWGa6QXV6J4r+yWUoG2kOu22n
         3mhXynMHCxJjF9Ww++mcmmv196FhqScxTZSc3QNYr0588jAEFGLP4v1cwW4RKIuYd+Ws
         hsyw2JDVk9kHCxygcIhMP5Hp154Rx4JogusK6xpR0yxvcor0Gk/sLMSgwn+APW1dCG5v
         FJAQ==
X-Gm-Message-State: APzg51BNV/WRO6Yqv82LO3zLnwyS0IMQSl9an7t7ZvkbOWss9Q4+Kcxh
        AhZmBWwwinAeEBcnOjKyMtybRA==
X-Google-Smtp-Source: ANB0VdbR4NzByzGJlq0UVfsndJW0o617Tg6+/y4UV6P3kF7Uev0nlm6IqJ63+MAbzGvhH4HQfN22Kg==
X-Received: by 2002:a02:95c4:: with SMTP id b62-v6mr26127606jai.43.1537555982697;
        Fri, 21 Sep 2018 11:53:02 -0700 (PDT)
Received: from dell ([209.82.80.116])
        by smtp.gmail.com with ESMTPSA id d11-v6sm8767290iok.77.2018.09.21.11.53.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Sep 2018 11:53:01 -0700 (PDT)
Date:   Fri, 21 Sep 2018 11:52:58 -0700
From:   Lee Jones <lee.jones@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        robh+dt@kernel.org, mark.rutland@arm.com, lgirdwood@gmail.com,
        sboyd@kernel.org, mazziesaccount@gmail.com,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v3 1/7] regulator/mfd: Support ROHM BD71847 power
 management IC
Message-ID: <20180921185258.GC4358@dell>
References: <cover.1536912922.git.matti.vaittinen@fi.rohmeurope.com>
 <3996792a07fea45d94d4d712ed05527199cc4ac0.1536912922.git.matti.vaittinen@fi.rohmeurope.com>
 <20180921172959.GG20825@sirena.org.uk>
 <20180921180241.GA4358@dell>
 <20180921181217.GI20825@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180921181217.GI20825@sirena.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Sep 2018, Mark Brown wrote:

> On Fri, Sep 21, 2018 at 11:02:41AM -0700, Lee Jones wrote:
> > On Fri, 21 Sep 2018, Mark Brown wrote:
> 
> > > This looks OK to me - Lee, the patch is almost entirely a regulator one,
> > > are you OK with me applying it?
> 
> > The diff in rohm-bd718x7.h does not look significant.
> 
> > You can apply it so long as you provide me with a PR in order to avoid
> > any potential merge conflicts.  Especially as Linus is out for this
> > release.
> 
> Great, thanks.  There's also the MFD DT bindings and another patch later
> on with Acked-for-MFD tags on them, should I convert the tags to acks,
> apply those as well and include them in the pull request?

Please.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
