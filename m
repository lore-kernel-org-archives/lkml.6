Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B38C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C18E2133F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jP3PWjnI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbeLRIwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 03:52:39 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46172 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbeLRIwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 03:52:38 -0500
Received: by mail-wr1-f66.google.com with SMTP id l9so14951664wrt.13
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 00:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=v+RjPbOptUi4IyaEeTvFfltlERYG6SNSE8UWhypKBPM=;
        b=jP3PWjnISnj5yvc8nCOqgPPJsEdlfPvOGucqq6MEzE0z1mxGE4pGk09S6M32xq6qyp
         5teQBKHBhN85MTRSqzMZ1OhWQO1qciOE9ZVvm5GfXNWgXrShJcOAiEg0jmKxbBWS6avo
         N3PSksQcckslEyJjYdurdOmTWJSnbl07xUlSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=v+RjPbOptUi4IyaEeTvFfltlERYG6SNSE8UWhypKBPM=;
        b=JjoZGLbdHi0Gk3n9rlmeUD09dEhUmxptOlpJ56NYePzNtCixUloX8/kVwxAx5uWKtK
         8QzDZUhbrkKiY5I9kwa32K4x0F2xAold9aYZT3Hn80TlEzCLQrjVsaBOL197SNHVpXmx
         BMq0bNN0E51YnCaR89r2d8V2Z1gjFsxSSnKfZb+BWZ164bi1Cx/0Y8maXVdnx5c9GMEr
         dlGudRVzS0IhU4wYtw4iglh5i1WLf3HDHdpoc68XNWLEPncDPTQe2a0sJwwBUV7eipGz
         Ut+WXrsE0PIs77zsFhg4oK9IyxhVwD1csj9R/QZ6b+Af5CrhM+iGU56j9VQAC1wIEXr3
         ruiw==
X-Gm-Message-State: AA+aEWaEMnpZ7v2KstbYA6x1GAb2WDHUo13KSCzeZ9zNH4kk8nHCahS0
        L0Oz9ME1t3lgfc5UP4CHJk8wRA==
X-Google-Smtp-Source: AFSGD/U1KbkOfqCD7zteercuiWSxeRn5SjADpRwt7uICkB2aKjUxGRLxpKjlztucWDjNCJ7x6WDkzg==
X-Received: by 2002:adf:b592:: with SMTP id c18mr13579112wre.89.1545123157067;
        Tue, 18 Dec 2018 00:52:37 -0800 (PST)
Received: from dell ([95.149.164.119])
        by smtp.gmail.com with ESMTPSA id 62sm2382573wra.30.2018.12.18.00.52.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 00:52:36 -0800 (PST)
Date:   Tue, 18 Dec 2018 08:52:34 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Cheng-yi Chiang <cychiang@chromium.org>
Cc:     bleung@chromium.org, groeck@chromium.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org, Dylan Reid <dgreid@chromium.org>,
        tzungbi@chromium.org, Rohit kumar <rohitkr@codeaurora.org>,
        scollyer@chromium.org
Subject: Re: [PATCH v2] mfd: cros_ec: Add commands to control codec
Message-ID: <20181218084307.GH4497@dell>
References: <20181206040540.84632-1-cychiang@chromium.org>
 <20181214122156.GT4497@dell>
 <20181214122245.GU4497@dell>
 <CAFv8Nw+RbzKrjE1tsgxdRntXKWp9XVq8hbP7MZ3mZ=a2rMyG2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFv8Nw+RbzKrjE1tsgxdRntXKWp9XVq8hbP7MZ3mZ=a2rMyG2Q@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Dec 2018, Cheng-yi Chiang wrote:

> +Benson, Guenter, Scott
> 
> On Fri, Dec 14, 2018 at 8:22 PM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > On Fri, 14 Dec 2018, Lee Jones wrote:
> >
> > > On Thu, 06 Dec 2018, Cheng-Yi Chiang wrote:
> > >
> > > > Add EC host commands to control codec on EC.
> > > >
> > > > Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> > > > ---
> > > >  V2 fixed the wrong ancestor issue so the patch can be applied cleanly on mfd tree.
> > > >  Codec driver that uses these commands will be sent separately.
> > > >  Thanks!
> > > >
> > > >  include/linux/mfd/cros_ec_commands.h | 94 ++++++++++++++++++++++++++++
> > > >  1 file changed, 94 insertions(+)
> > >
> > > Would be good to have this reviewed by some more Chrome people.
> >
> > See this for reference:
> >
> >   https://lore.kernel.org/patchwork/patch/1024985/
> 
> Hi Benson and Guenter,
> Could you please review this patch ?

You haven't sent them the patch.

Please resubmit as a [RESEND] and add them as recipients.

> The corresponding implementation at EC side by Scott is at
> https://chromium-review.googlesource.com/c/chromiumos/platform/ec/+/1356185
> 
> Thanks a lot!
> 
> >

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
