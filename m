Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29416C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 22:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C328B206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 22:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qb5HzIJE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C328B206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731909AbeGZXbh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 19:31:37 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:36626 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731445AbeGZXbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 19:31:37 -0400
Received: by mail-qt0-f195.google.com with SMTP id t5-v6so3220763qtn.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 15:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q5mjetjocd2mRNMMoBuAx8J0ZuA4Q85m22PajafWhZg=;
        b=Qb5HzIJEivH2BvepYAnKGADBTY7xAN8d3sZ4e5l1HoyqVzgym7ggvspJNnyGDyENXX
         pDzqVFfZjrO2FsVf01sWmwZBsglWwPks/MJc2mvT9wKHmDNiWKGH4K9Z33EPoHoYM+TZ
         1Codw9UrdDl2ps0MCARbPi6iF4teerMi516GY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q5mjetjocd2mRNMMoBuAx8J0ZuA4Q85m22PajafWhZg=;
        b=KrfE2KTf9QtsBLBSPXb8oJQgTHbXiACb42Bft1Vd+4J4UcZw9OoVvxt2lm8vTjMnrM
         WAhFgBlGdzr30BIL33lnoVjBMXHxVGOYquaOTFhqsEf/bD8gz5JPTYBAaoms62xfHVoO
         Coc3LSWSk3c4MWXbDvCTKfeNRNSP3tt87Iy1hynaG0Hb+VyHzuPDiK6RX8Rz0lwA46Ri
         HHxFcUbW3ho0MHUUMt3qrYV1GiJlvDPAOH+KEOGgC07ZkrFm5AvosqyX65bonMCufh4L
         5mxz93oY/mp1fwibuPeVl/cOcImwKK6iPAKzxHdLvfI72Go4yTWVMSaE5wsbciwq/xqD
         YuGA==
X-Gm-Message-State: AOUpUlGuW+uXCkBQvZBiMMmtTBmEjtTFLbVjq2Zvu89FR0cDL/Kp3fNx
        8jR+qe5OgUtU1ZBLZzlXnJGgprb3xZm+DY+62a7Wig==
X-Google-Smtp-Source: AAOMgpfNjL1aq/ilxpDEHwqCJJgV/KpUqLV8p053PFlDEvMCJ7+7nHr3kASSGT86mjsUhWJm4Vdagd2CWGmTKhpl7og=
X-Received: by 2002:ac8:3134:: with SMTP id g49-v6mr3863989qtb.55.1532643169102;
 Thu, 26 Jul 2018 15:12:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1532600791.git.amit.kucheria@linaro.org> <20180726210303.GC7708@u40b0340c692b58f6553c.ant.amazon.com>
In-Reply-To: <20180726210303.GC7708@u40b0340c692b58f6553c.ant.amazon.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Fri, 27 Jul 2018 03:42:37 +0530
Message-ID: <CAP245DV9q7Sbm7HirPsMPrtDD4Vd634VGoV_Z11p1tGGz8Lk8Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] thermal: tsens: bugfixes, cleanups
To:     eduval@amazon.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        smohanad@codeaurora.org, Andy Gross <andy.gross@linaro.org>,
        Doug Anderson <dianders@chromium.org>, mka@chromium.org,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 2:38 AM Eduardo Valentin <eduval@amazon.com> wrote:
>
> Hey Amit,
>
>
> On Thu, Jul 26, 2018 at 04:03:07PM +0530, Amit Kucheria wrote:
> > Here is another series of tsens-related bugfixes and cleanups to prepare
> > for IRQ support, among other things. It applies on top of another series[1]
> > that did some code consolidation to add support for sdm845.
> >
> > [1] https://lore.kernel.org/lkml/cover.1531895128.git.amit.kucheria@linaro.org/T/#t
>
>
> Given it is already rc7 time, even if this is fixes series, I will only consider this for the merge window.

Sure, I wasn't expecting to land this series in 4.19. I'm hoping that
[1] can be landed though.

Regards,
Amit
