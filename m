Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35554C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA134214FD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GUDBD0Ba"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA134214FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753070AbeGDQL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 12:11:57 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38730 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752933AbeGDQLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 12:11:55 -0400
Received: by mail-wm0-f66.google.com with SMTP id 69-v6so6588583wmf.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 09:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=jC0lT+NTx6xqwHbmLw52X4YFw493OK7aKztJUypT1jU=;
        b=GUDBD0BajHllupfYrFWo6zyeYdPUJ1FNDo/TD1DMSso2E4uO3DaaiIKidZ0srvGt5I
         FyGem5bXh1Jxd7d+mj6FhPEEtG8wZqjNJljAWvxIiSlZqAPlFZUVgBXTqZtugMV7a4SG
         KMNEnK9M5sIJvMwA9nbAYXI1KwxzFak+QZVF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jC0lT+NTx6xqwHbmLw52X4YFw493OK7aKztJUypT1jU=;
        b=JBiyzN3ws61iFdUDAENrMiac7v9ioOXvgu143D4GTxxdO1uvIi/LMYQzT8KGKHBDWU
         pBWT1piUNzpZb4GpjMaiwObOWLEOT+bEKo4QjhsilfdL88cemvN9gomN7bpU1wMiYQ03
         fNi5L1dq11SeV/VpVlHXZ7HwzrQQCEWkDoItBJTzmMYePBcFp55bi8Remuxch42jxuY/
         4lgq62IdFJvgUXM38UpGuzYZZZzazbXYu96hHJazDmUFYO2gPS4OkVQuXH/Y74sS8Y39
         kpiVcmG+jcB7zf9QyHASdx31LWWR32drYBesrvSl3Gm3SDMwPcCkdxhwgAkNvn5J7OYq
         B1YQ==
X-Gm-Message-State: APt69E1V/PBPFxOwvwyeKro0fhp7AUsC2EN3MDqpgXvhBWydi+KbyswB
        VtB7PX6ryTTgXY81zu0Az8ajew==
X-Google-Smtp-Source: AAOMgpez/V89ySRfb8NUj++87gApxs9XcFYljtwW9H2y4a97By+MsMv6eN1GN4w/AyX8UEvWTCl1SA==
X-Received: by 2002:adf:b0d0:: with SMTP id j16-v6mr1948253wra.3.1530720714516;
        Wed, 04 Jul 2018 09:11:54 -0700 (PDT)
Received: from dell ([2.27.167.87])
        by smtp.gmail.com with ESMTPSA id g4-v6sm3013499wrq.32.2018.07.04.09.11.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jul 2018 09:11:53 -0700 (PDT)
Date:   Wed, 4 Jul 2018 17:11:52 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>,
        Benson Leung <bleung@chromium.org>
Subject: Re: [PATCH 1/2] Revert "mfd: cros_ec: Remove unused __remove
 function"
Message-ID: <20180704161152.GG496@dell>
References: <20180620213033.100455-1-dmitry.torokhov@gmail.com>
 <20180704064811.GD20176@dell>
 <20180704151622.sncbvlrlv3tuilrp@penguin>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180704151622.sncbvlrlv3tuilrp@penguin>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Jul 2018, Dmitry Torokhov wrote:
> On Wed, Jul 04, 2018 at 07:48:11AM +0100, Lee Jones wrote:
> > On Wed, 20 Jun 2018, Dmitry Torokhov wrote:
> > 
> > > This reverts commit 556c242045f0c1613aac2e64dc5b2ff0e4bc89e1.
> > > 
> > > The patch that this change is purported to fix is broken and should be
> > > reverted; thus we reverting this one as well.
> > 
> > You need to provide more information.
> > 
> > How does the original patch break the build/code execution?
> > What is this patch doing to rectify the issue?
> > Any other information you think is relevant.
> 
> We are reverting this patch because it is not needed: it tries to fix
> another patch that is completely broken and needs to be reverted. The
> justification for reverting the original broken patch is in the revert
> of that patch, but just for reference:
> 
> We should not use devm_kzalloc() to allocate refcounted objects.

The other patch looked good.  Please ensure the story is told in each
of the patches individually though.  That way they can be are viewed
by an outsider the history can be read and understood independently.

Thanks in advance.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
