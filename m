Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE503C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 19:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32A1720675
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 19:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dKeCskrg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbfACTe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 14:34:28 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46666 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbfACTe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 14:34:27 -0500
Received: by mail-pl1-f193.google.com with SMTP id t13so16299444ply.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 11:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/rhSO4GaFBAsaZDukGcMw3ZBgE3dIWcCiR5XFvWF0B0=;
        b=dKeCskrgznL9tYzicg808oKovT2QS7QYIt8C2LjnbK9SNK1Q6V8Lhlsx0t2T0mPpmu
         JX85tDuGlimlhgCtbHmzdGXy9+S1yoY+BMyS7pjhFFesV3Gm0KmDAXcTR9MUGC4VwmSu
         pHXbBekc9zCOkXJefBpLg5WYNIM3ptrH3B80ser4o/4SvGU1WasqWVSPDcqnnP1ZKBSk
         976/wixB/XnP1Ee6OJBzRixtXPIrTd9SIlN7drO7/ZiZ7acNzbOK93lpMsXfmDjH1/Uk
         Pbyt9JNZUeQ+1ZJuIZ/z0qMr4KDmhhIyj0/nPVO/m4qYqpdeglt+q5IYuByMdX95xMDt
         3guA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/rhSO4GaFBAsaZDukGcMw3ZBgE3dIWcCiR5XFvWF0B0=;
        b=suQKT47lX3OtY0pfZPiKytlVnDa+WUaYkKsLPckDRg29/DfaotpA8qE0CphVuTaCaa
         gREeqS+4ZT8AslokBhvzUILe7bRBcStg1ecUFlA1tWWw1jbnZIqwKkQ6rXs9AH1Acx1N
         2oNAv69UTZP1jDq78xrq6eveB3xWnF8RHcKEFC9Y3Sn0JZfo5CFlbVIjAUGDI1q4Pn9D
         2/13rwYIGNzC7JWEHWRgV8AstrSY2PUkOkON4S3Mar8XzIknwVTpA+uGP1S4toUXV/8T
         5LZbVmJP9Rut6rnHhhwJ/xskVPbyYsrbl34tKkp9cSjLRCBzNyyWk+Ha6Aq4nVUVwMte
         l+Jw==
X-Gm-Message-State: AJcUukd/4oD4ipVPJeL3ar+4yDyQmw7lGuWSVNXiWoXhPDDXsl+pKObB
        BVnj68y/cB28WPqIn4QQC7g=
X-Google-Smtp-Source: ALg8bN5gFA2C5VPQyBPXEv5j8wS+lPUMkCISJErOhhZUYe0T3pGA8CBtXN/j7/MVCBaF4mS/9YNTCw==
X-Received: by 2002:a17:902:74cc:: with SMTP id f12mr48566926plt.134.1546544066815;
        Thu, 03 Jan 2019 11:34:26 -0800 (PST)
Received: from Ideapad-330S ([49.206.12.66])
        by smtp.gmail.com with ESMTPSA id g28sm97585788pfd.100.2019.01.03.11.34.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Jan 2019 11:34:26 -0800 (PST)
Date:   Fri, 4 Jan 2019 01:04:21 +0530
From:   b-ak <anur.bhargav@gmail.com>
To:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: tlv320aic32x4: Kernel OOPS while entering DAPM
 standby mode
Message-ID: <20190103193421.GB18413@Ideapad-330S>
References: <20190102170633.GA9724@Ideapad-330S>
 <20190103124554.GS1846@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190103124554.GS1846@sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03, 2019 at 12:45:54PM +0000, Mark Brown wrote:
> On Wed, Jan 02, 2019 at 10:36:33PM +0530, b-ak wrote:
> > During the bootup of the kernel, as soon as the DAPM framework kicks in
> > it pushes the codec into standy mode.
> > 
> > The existing TVL320AIC32x4 codec driver doesn't prepare the clock in
> > the probe function.
> > This leads to an OOPS when the DAPM tries to put it into standy by calling
> > clk_disable_unprepare()
> > 
> > This patch fixes that problem.
> 
> This isn't the best way of fixing this because it makes it look like
> there's a missing disable in the removal process.  What would be better
> would be to do what other drivers do and check to see what state we're
> transitioning from before we disable the clock in set_bias_level().  See
> drivers like wm8903.c for examples.

Hello Mark,

I will test the change and update the patch.

Thanks,
Bhargav

