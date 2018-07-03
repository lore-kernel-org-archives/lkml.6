Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE04EC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 09:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C04C24D6A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 09:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HT1vxc7w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C04C24D6A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754683AbeGCJlh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 05:41:37 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35439 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754382AbeGCJlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 05:41:36 -0400
Received: by mail-wm0-f68.google.com with SMTP id z137-v6so1556136wmc.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 02:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=GcMpo2XbAllvd6fNp/VgbLzTNcY4e4txN0R8HG9R9io=;
        b=HT1vxc7w6yCr4UlZpLnEb9KH8IDjRGssHzhYeUVLxHnFH58JOM9rUVbIOGyDWBQVvS
         o1k8TBxIDRrO9XUMhOWdieD13ehOBjrlt+UpmNWBcrJMlnjVpKhUKo5fJ6DqDvSrRwGc
         wNyQwsyBufUnOCBCvEmSaE9wM8cwINjKDT5Zg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=GcMpo2XbAllvd6fNp/VgbLzTNcY4e4txN0R8HG9R9io=;
        b=qmM40Q21Gm8Rkln4ySbfyhUfs3KII8j4gLZ4GLsyRd5KZSRp6v091I525F93dFtt4G
         +inQ7m4aNLtXD9aDFfFCj5rLXATm4LN+aGKfNl5VwE3ensH9dNW7ZGa7elDazCsw/TK6
         2Lz5s6eZHGGjCtDYeiz3i8eaMD4XWcG/G2fHGApah/kxcjZ+kkoz80tqxcYFkvSzYttp
         O6eiX3ri/1iWFklX5Axsw59iO4ZcnYuCK8jWKGycYYe4VCwqDAu1dvS1VW79vAerhehl
         uC3Z9+NbjT53BxjDp4VUjwKcDSilBKBraZCVhSpjudjpL9WE87MzWBgefjQimael1uKs
         UF4g==
X-Gm-Message-State: APt69E1PIvXAzcoMcjYh2y6arPYPAY4QNK8mMkilgB3ebd9mgxEl/gs+
        uKLE4WSyTmWTUL+P/NDfDTWuqg==
X-Google-Smtp-Source: AAOMgpdIDzi0Ssnt64reayzJl8oNieD4RUTekh/GLBdMKHEYEPA0SC/qDZf4s1+hpSsKorgvdDh8Bw==
X-Received: by 2002:a1c:d812:: with SMTP id p18-v6mr10949373wmg.92.1530610894872;
        Tue, 03 Jul 2018 02:41:34 -0700 (PDT)
Received: from dell ([2.27.167.87])
        by smtp.gmail.com with ESMTPSA id w2-v6sm1869571wme.45.2018.07.03.02.41.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 02:41:34 -0700 (PDT)
Date:   Tue, 3 Jul 2018 10:41:32 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     andy.shevchenko@gmail.com, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mfd: arizona: Don't use regmap_read_poll_timeout
Message-ID: <20180703094132.GQ20176@dell>
References: <20180604115750.6126-1-ckeepax@opensource.cirrus.com>
 <20180618062754.GF31141@dell>
 <20180618085245.GE18740@imbe.wolfsonmicro.main>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180618085245.GE18740@imbe.wolfsonmicro.main>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jun 2018, Charles Keepax wrote:

> On Mon, Jun 18, 2018 at 07:27:54AM +0100, Lee Jones wrote:
> > On Mon, 04 Jun 2018, Charles Keepax wrote:
> > > @@ -240,18 +241,28 @@ static int arizona_poll_reg(struct arizona *arizona,
> > >  			    int timeout_ms, unsigned int reg,
> > >  			    unsigned int mask, unsigned int target)
> > >  {
> > > +	ktime_t timeout = ktime_add_us(ktime_get(), timeout_ms * USEC_PER_MSEC);
> > >  	unsigned int val = 0;
> > > -	int ret;
> > > +	int ret = regmap_read(arizona->regmap, reg, &val);
> > 
> > I'm not a fan of this type of initialisation.
> > 
> > Also, what's the point of assigning 'ret' if you never check it?
> > 
> 
> It could get checked if the timeout value is very small causing
> the while loop to be skipped and almost certainly will cause
> un-initialised warnings without it.
> 
> I can move it to its own line if you prefer? Would you want a
> comment as well?

Yes please.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
