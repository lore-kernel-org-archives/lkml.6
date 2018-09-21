Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5FBECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 18:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6BAB21568
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 18:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AAvz3/o/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6BAB21568
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390999AbeIUXwq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 19:52:46 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:47091 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390381AbeIUXwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 19:52:46 -0400
Received: by mail-io1-f65.google.com with SMTP id y12-v6so13040404ioj.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 11:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ZTJX3t/gAHmx9rW/S+9/Zduu1zVx+8HPSzXJV7hX3Zw=;
        b=AAvz3/o/M6eO3zNcniWlFo0+NhwKlIDWDxIgjhTcbPAnXxiUHUJNhQM7qvhQHIH8AY
         7cKpMVshgLpVSAZjNfcD6p2VijJQJ1aW+0mgAeQ1vFyQ5zNCRDMFhme56F9jmIyW2VIa
         lH7hPXBvm1ag7ALb0z7AUm5/ofJZhJs8+0VOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ZTJX3t/gAHmx9rW/S+9/Zduu1zVx+8HPSzXJV7hX3Zw=;
        b=K2eSCf+wplanAB8MrMNIcMc9QeD+ktg8BJlV8DgyIU3k0ZIJWPUssznI9esd6ygAT1
         IowWc5lTzIEqYhJ2W+u539R68vaH1BhPFdE6rUYdluplZrTdvmPGU1t+eM7UXY8uNqKf
         mwmd8OPq/U9lI/y2Iub2VemBrzdKSQew6N9vCKICBatQLvTN2jnEjEhv4qzAQAoWs2rz
         BLK57auHnWNjJ8vJr63nH2P+GBFmUPNpSwnfvC/Hjaqbl+w632Af6037LU5RqK+DlJ/N
         B2X6pvN4XFM87i/kfm29PRjqD17M6UGxDCWW/HFRYNxJ7ddo8mt1rwNcYsrVp2TbhRs8
         xNXg==
X-Gm-Message-State: APzg51CuDUhKXQWcot4nZUJqxPU9cJqo6Xnrh8N/BMl9s3iLlEbzuGuM
        XIKT1JXHF4lqMWwt/Fsh5HYXug==
X-Google-Smtp-Source: ANB0VdYHbKnXH78tkbN/+86BlfnnU8t2df4p60MS756EyZHqA4Rcv+WQN414rCMwO5tUiQfo60eOTg==
X-Received: by 2002:a6b:ec15:: with SMTP id c21-v6mr40262954ioh.33.1537552965339;
        Fri, 21 Sep 2018 11:02:45 -0700 (PDT)
Received: from dell ([209.82.80.116])
        by smtp.gmail.com with ESMTPSA id m4-v6sm1119305itg.0.2018.09.21.11.02.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Sep 2018 11:02:44 -0700 (PDT)
Date:   Fri, 21 Sep 2018 11:02:41 -0700
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
Message-ID: <20180921180241.GA4358@dell>
References: <cover.1536912922.git.matti.vaittinen@fi.rohmeurope.com>
 <3996792a07fea45d94d4d712ed05527199cc4ac0.1536912922.git.matti.vaittinen@fi.rohmeurope.com>
 <20180921172959.GG20825@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180921172959.GG20825@sirena.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Sep 2018, Mark Brown wrote:

> On Fri, Sep 14, 2018 at 11:27:46AM +0300, Matti Vaittinen wrote:
> > BD71847 is reduced version of BD71837. DVS bucks 3 and 4 are
> > removed as is LDO7. Voltage ranges of some regulators are
> > expanded.
> > 
> > Add initial support for BD71847 with BD71837 driver.
> > 
> > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > ---
> >  drivers/mfd/rohm-bd718x7.c            |   70 +--
> >  drivers/regulator/bd71837-regulator.c | 1055 +++++++++++++++++++++++----------
> >  include/linux/mfd/rohm-bd718x7.h      |  271 ++++-----
> >  3 files changed, 879 insertions(+), 517 deletions(-)
> 
> This looks OK to me - Lee, the patch is almost entirely a regulator one,
> are you OK with me applying it?

The diff in rohm-bd718x7.h does not look significant.

You can apply it so long as you provide me with a PR in order to avoid
any potential merge conflicts.  Especially as Linus is out for this
release.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
