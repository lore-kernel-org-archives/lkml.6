Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB03C64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 20:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A223214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 20:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="gSTDQx8d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A223214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=poorly.run
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbeJJDk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 23:40:57 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:35851 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727486AbeJJDk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 23:40:57 -0400
Received: by mail-vs1-f65.google.com with SMTP id c205so2874956vsd.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 13:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pNJrqXOQHulQArPCtxubYH255vZ66s47qNtL7nLdsLs=;
        b=gSTDQx8dwXX4jBdJkejGXdULTQGiQMNQCzp0J2GOqyrBiRKtwurBP1YSQJ8G4NF9nd
         7scuamKwYfSwrbitoBjQ/xnNNNg1EnI/AYY6rHGHxHAaFJTk9MCeOeFcZMVcWGNl9kKh
         XKYdE74NESvU2ubgber7qBUfcEMbv/VsgRpalX9ck/fKXf6Eb911crHVLUJ+oXXq/HpO
         Xvp2fcS+G5jxLmxP9zKUBG41C5CO6XKTWMb40iXkdI9jakiMdMao4Jmx3RpMyFliP2vQ
         VznMuOxfkw1VrxtuMwk2SiG9KL3rX39EU+gi0F5Xq2kk8cv9khgv8oG54FBv+v5BWs/N
         r0zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pNJrqXOQHulQArPCtxubYH255vZ66s47qNtL7nLdsLs=;
        b=YRyEA1EebfgClK4ZMLUbADGo+nhDlOWpW8X3FNUfivk65YHi6cYy+pUuz6fNOy0KJ7
         IrZeDe9KLKgNh8T5mE/tQvxh3BoKdgihJ+gxkJC6uueW3E7kPnI37sOAsafMh9HCRr2u
         tkOQRop4/ThANJ9jLEw9kQzmvBID58kYf0MLTajLnDdnZDOv5gmWv+0wsc2lf/afMNkL
         Zp733rZd4gSdvY5KeCJTixj0gQKAr1QqiKSiaPlg/ePqtUV+wBtgJHHIarSRKGJuQvZ7
         o0AhNPRn2Q7E7C7QxZ0WkL+uJ6sy0Ah6pAHLXghTmqTvrlEX+xD+AjHY+m0sRiriHipG
         gNfw==
X-Gm-Message-State: ABuFfohHT2T8vcG//lITOlZuhxln4rQM6mNrYTyoH1GLb+iKjWpKrKYO
        UWXd6oArqsjHfq1EPdqUQjVweUiAhiScCMOtZjAqYw==
X-Google-Smtp-Source: ACcGV60208bKta/vec/x9Ux3Ctx/nqIi/1qKCS7XzvarRDnzc60Ku3venhhORI8B5Mn5x+ld0Gi7yA7zmu5OZgm4C2c=
X-Received: by 2002:a67:78c5:: with SMTP id t188mr9410859vsc.168.1539116537015;
 Tue, 09 Oct 2018 13:22:17 -0700 (PDT)
MIME-Version: 1.0
References: <20181005160256.200162-1-sean@poorly.run> <20181009095640.ye2kh5gciktq3kf6@flea>
In-Reply-To: <20181009095640.ye2kh5gciktq3kf6@flea>
From:   Sean Paul <sean@poorly.run>
Date:   Tue, 9 Oct 2018 16:21:40 -0400
Message-ID: <CAMavQKKfB6ypUh7ThmY9NkvsVLaU4Y39YWYYq15-4+UVy+m1Qw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add Maxime Ripard as drm-misc maintainer
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Airlie <airlied@linux.ie>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 9, 2018 at 5:56 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Fri, Oct 05, 2018 at 12:02:22PM -0400, Sean Paul wrote:
> > Unfortunately Gustavo has decided to step down as drm-misc maintainer to
> > focus on other projects. Thanks Gustavo for your dedication and hard work!
> >
> > Fortunately for us, we have a wealth of people qualified to assume a
> > -misc maintainer role. Maxime has done an outstanding job with sun4i and
> > in the community in general. I'm really excited that he agreed to take
> > on this responsibility and I look forward to working with him!
> >
> > Cc: Dave Airlie <arlied@linux.ie>
> > Cc: Gustavo Padovan <gustavo@padovan.org>
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Cc: Maxime Ripard  <maxime.ripard@bootlin.com>
> > Signed-off-by: Sean Paul <sean@poorly.run>
>
> Obviously-Acked-by: Maxime Ripard <maxime.ripard@bootlin.com> :)

Applied with Dave's IRC ack (I also fixed his email address)

Big thanks again to Gustavo!

Sean

>
> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
