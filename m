Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E709CC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 21:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B57E420870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 21:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="b9RUv9+X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbfAVVRV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 16:17:21 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37686 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbfAVVRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 16:17:20 -0500
Received: by mail-oi1-f196.google.com with SMTP id y23so18691037oia.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 13:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w7mtXbsWp8Z+SG/+jvBYOCM7iks1Q7na3wi37/monz8=;
        b=b9RUv9+XW/D2QxJEr8BcaEii+bD5yXPYG85nvwB8C3lDcsnTDbLHcNItGM+dSDdMXi
         B69/XpSCQ3JRoZiit5HRbwHmMipzYhlCI+q18/mYV0FrqnVXLVt75LMGx8DNyFaT9MCL
         yxMCOaLCatDK5LqhzQBxiBnQ4+YRWkcN4PsuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w7mtXbsWp8Z+SG/+jvBYOCM7iks1Q7na3wi37/monz8=;
        b=WFqonaCIPUCwi63kCmFvzgw10PCUHdv18BUQO8d+ZSNDjDzV0BWkBpzmDfV21r5b1i
         GmmNclDhMsSEU4OJUZ4EkDFpi2ToSkbnZjWdS7nbll3xgp5RIoqPybevDYkALl9wOsh6
         5zW80QTP0Ross35Z0IOMpbXI8buRqEf/E657N4p4Q4dDA3wPHvp8+O2ro78ZduBhe6ud
         gLh6/dYzxVsvkIwA104Jb/Iqra2U5ahwcQ97crmevGZ0D1EMNLtHxAGiuqxOQjzM+8GN
         0NAQlE8EoWjOnTmh0iTL5qDjAGoQ/Vfo5z2nXxhgbEP+OmNWUcL3o4FsxsMcO7c5+Hcb
         wT6Q==
X-Gm-Message-State: AJcUukcbewNHyKIv0tOR1QeWdx6qjjMX0MDpzAoeIghy9PewJSleMF1/
        ttFey36GH1r6TLF9g2sw5B8sqriHEYw=
X-Google-Smtp-Source: ALg8bN42srJacRaaJABBUXM1A573YZF1C2i2x+HqCmdGVRtA+FVRlJIqPie6W2aVqt0iz0w3hcpQyg==
X-Received: by 2002:aca:eccb:: with SMTP id k194mr8904426oih.104.1548191840015;
        Tue, 22 Jan 2019 13:17:20 -0800 (PST)
Received: from localhost (107-207-74-175.lightspeed.austtx.sbcglobal.net. [107.207.74.175])
        by smtp.gmail.com with ESMTPSA id v3sm11595446oib.57.2019.01.22.13.17.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 13:17:19 -0800 (PST)
Date:   Tue, 22 Jan 2019 15:17:15 -0600
From:   Andy Gross <andy.gross@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        marc.w.gonzalez@free.fr,
        Bjorn Andersson <bjorn.andersson@linaro.org>, kvalo@adurom.com,
        joe@perches.com
Subject: Re: [PATCH v3 1/1] MAINTAINERS: update list of qcom drivers
Message-ID: <20190122211715.GC30582@hector.attlocal.net>
References: <cover.1547494994.git.amit.kucheria@linaro.org>
 <3f8a0c7a8701446abe02f1e35d412d72d9c1f0f3.1547494994.git.amit.kucheria@linaro.org>
 <CAHLCerMLYec-jf151xPbNB0RxT+wvJ87nGY3_4jwS7rQwt+hCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHLCerMLYec-jf151xPbNB0RxT+wvJ87nGY3_4jwS7rQwt+hCg@mail.gmail.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 01:58:41PM +0530, Amit Kucheria wrote:
> On Tue, Jan 15, 2019 at 1:16 AM Amit Kucheria <amit.kucheria@linaro.org> wrote:
> >
> > Several drivers didn't have a specific maintainer (other than the
> > subsystem maintainer). Add some generic regex patterns to capture most
> > qcom drivers in the list of supported drivers. For the rest, add
> > explicit filenames.
> >
> > Sort the entries, while we're at it.
> >
> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> 
> Hi Andy,
> 
> Do you need another revision of this or is this good enough?

This looks ok for now.

Andy
