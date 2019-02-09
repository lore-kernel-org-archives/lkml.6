Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 719B1C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 13:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41F4721927
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 13:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fdy4wR7g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbfBINCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 08:02:12 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51891 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbfBINCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 08:02:12 -0500
Received: by mail-wm1-f66.google.com with SMTP id b11so8342081wmj.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Feb 2019 05:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U5IA71eVIrL0jQg3EbAzLYKZzmUC6El2gVY2jqfAiQ8=;
        b=Fdy4wR7gSQ3PLZG+WpNcPop4/7+twhLChjK+xDyTrgWjlD2JTuAeCbpSNglqm9G6CR
         6h1icT6Io31eW0EUbolFyvmbJd0fB3ML0iK8QgT53TlBbiz4BxztDQZ8FxCo83dVLGUP
         FKsDtjqvTliw1x9NU+4FsSs1xf/mNPXwJwZ8qe0dz7oI4zRv8D03VRF9RZ9CDbz68dye
         gVueESdsSbdirfyFUr4ogvyhyVLcxFsHZGS5dcQz6AEX9FrqGdjoKP6H6wPornmD8Nws
         InAZtqYpk0og3JCQGxvDlqUJ8ZgVrAfRjSMzoNPBXYF/nYryuuZBzhHFFcigIAsTaaPu
         Is7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U5IA71eVIrL0jQg3EbAzLYKZzmUC6El2gVY2jqfAiQ8=;
        b=dv4PSgsc9ahXOlmncWSjkEHsIsyPkUUExoCDYwQcGV4KbwyhXpxsv0haCbxyMccfJs
         2/hcu2ng7Yhq3YpLmk09JQut2J9lLoluIO5XN8WKjf9HDx8bBGgFAbwlGcoiUJ9VY39a
         f3oowu1bnxt/fEZ9xqB6lYZ5C1cnNgb8+Q8c1c3rdc4U5Q/9otpexT3k8T3ISZR49Rjo
         BPtgRpBfZZqOyfWqHKL6AkHxiPPIWbnO9T3kdGdcUkAsQxMA+HFiVg4anJwhECygssta
         VnuuHC0bRu1VN36u5GeXTIJXL8dYWCVnE6ccerimbe/4m2OO2rRM8HqVByH/6gl+GlG6
         Okdw==
X-Gm-Message-State: AHQUAuYCMBdYIkKwUfaPbPXik2OksT57soEYy4c8zX2URMpLJ3Qfsnvc
        2DTalSNh9kdFE6O6rBcZKUX0nQg=
X-Google-Smtp-Source: AHgI3Ia18svl1ikf2aEhkR/jxfGAOX2qDb7/FqvyTmvSRxTCZFTjYv6uTylkRafBO3PYiziec9+rKQ==
X-Received: by 2002:a1c:e343:: with SMTP id a64mr3019403wmh.46.1549717330364;
        Sat, 09 Feb 2019 05:02:10 -0800 (PST)
Received: from avx2 ([46.53.242.39])
        by smtp.gmail.com with ESMTPSA id l19sm2836196wme.21.2019.02.09.05.02.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Feb 2019 05:02:09 -0800 (PST)
Date:   Sat, 9 Feb 2019 16:02:07 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/string.c: make strncmp() smaller
Message-ID: <20190209130207.GA11988@avx2>
References: <20190208073403.GA19734@avx2>
 <061655a972b4037b5bf245a65aed937967410e61.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <061655a972b4037b5bf245a65aed937967410e61.camel@perches.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 01:31:49AM -0800, Joe Perches wrote:
> On Fri, 2019-02-08 at 10:34 +0300, Alexey Dobriyan wrote:

> > -			return c1 < c2 ? -1 : 1;
> > +			return c1 - c2;
> 
> This does change the return value for most comparisons.

It does.

> Wasn't there a specific reason for -1 and 1?

Maybe. Spec says anything positive or negative works.
