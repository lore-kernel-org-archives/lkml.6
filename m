Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB25C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64F5C20855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jbe0TWCh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64F5C20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbeIJSmA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 14:42:00 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45968 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728110AbeIJSmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 14:42:00 -0400
Received: by mail-wr1-f66.google.com with SMTP id 20-v6so21997371wrb.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 06:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=VVxGLwEjd8/zWRxsrTJr/zmY45c8rUqAaGcX9v1xEU0=;
        b=jbe0TWCh7j+5ADA2dA0Y1JTr7dEpOp0/u+fPRP3OqFZugE9xOuq6Qpm6OtvQEe+vYv
         Sk4j7ob65d/HeIQiS/INy50+s9iW0qUWxw40ShRaaZPKInHG/sI1CL6O9pplax9N2j0q
         DiFbdmzDzNJZ5+lahaq47hIirf01hQyntEkJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=VVxGLwEjd8/zWRxsrTJr/zmY45c8rUqAaGcX9v1xEU0=;
        b=AcyYrDqR/XRer17irvXDqTCe5TIXbiJ/wfqBUJYCXBp1+3hBQ/iJWFT+6jNIYwNfBC
         pQg8qApzz5ulqvbKh9dImPIuy4PsxQjn3TZZA+TNgazHLPQWv4PSYCppyQ93E8BePZrZ
         1TAd7ekw28cJPzWimNkqIzPjYB3swElU9Hzbj8JL/mVkrIXWctDKt5d4QXCP0DKims6K
         UbnmsdBFVvKD5gwN9mewTM80yC8Rtr0yJtPODwXEgbEkmLwhoOB8AHodcT/ObQttcM5N
         AgSYQH52c6rR/jkfrKi1vrReCKLxyY5kcd2vIdoqAMakOGAZmnmZXtyOp7ZHwZPAe6Jc
         Po/w==
X-Gm-Message-State: APzg51AKskTnWI4IW/Hoa8qHqcjtjfou8p6mdfD1Gp+Ff5DG80GW2sBx
        LXgIXBJCTH+qq8+PBlAl+IX2PrM0pH3+NA==
X-Google-Smtp-Source: ANB0VdasdwkSCheQRsXIM/i4zPmwVeBgZHzG+smP1ForLcxicult7A09jbMkYdTKX9CweWAjGaIiWg==
X-Received: by 2002:adf:9081:: with SMTP id i1-v6mr15856739wri.271.1536587268102;
        Mon, 10 Sep 2018 06:47:48 -0700 (PDT)
Received: from dell ([2.27.167.7])
        by smtp.gmail.com with ESMTPSA id t69-v6sm13117107wmt.40.2018.09.10.06.47.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 06:47:47 -0700 (PDT)
Date:   Mon, 10 Sep 2018 14:47:45 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Benson Leung <bleung@google.com>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>, kernel@collabora.com
Subject: Re: [PATCH 2/2] mfd: cros_ec: Fix and improve kerneldoc comments.
Message-ID: <20180910134745.GO28860@dell>
References: <20180718160956.19864-1-enric.balletbo@collabora.com>
 <20180718160956.19864-3-enric.balletbo@collabora.com>
 <20180907075438.GB95655@rodete-laptop-imager.corp.google.com>
 <20180910091208.GH28860@dell>
 <CANLzEkvuNYS4q_bATF1kz205dzfrjzEkRZ0MaT71-Cd46-D0fA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANLzEkvuNYS4q_bATF1kz205dzfrjzEkRZ0MaT71-Cd46-D0fA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Sep 2018, Benson Leung wrote:

> On Mon, Sep 10, 2018 at 5:12 PM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > On Fri, 07 Sep 2018, Benson Leung wrote:
> >
> > > Hi Enric,
> > >
> > > On Wed, Jul 18, 2018 at 06:09:56PM +0200, Enric Balletbo i Serra wrote:
> > > > cros-ec includes inside the MFD subsystem, specially the file
> > > > cros_ec_commands.h, has been modified several times and it has grown a
> > > > lot, unfortunately, we didn't have care too much about the documentation.
> > > > This patch tries to improve the documentation and also fixes all the
> > > > issues reported by kerneldoc script.
> > > >
> > > > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > >
> > > Applied, thanks.
> >
> > If applying patches from other subsystems, you need to wait for an
> > appropriate Ack before applying.  Please send me a succinct
> > pull-request for this patch, so that we might avoid potential conflict
> > at merge time.
> 
> Ok Lee, sorry about that.  Actually this hasn't landed in my for-next
> branch yet so no conflict has happened yet. I  will send you a PR
> shortly.

No worries, it happens.

The PR is to avoid merge conflicts at "merge time" i.e. when Linus
merges everything into Mainline during the merge window.

Appreciate your help.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
