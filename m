Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B717CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 836112190C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Nh0jObm1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732371AbfBOPrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 10:47:22 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:38924 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbfBOPrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 10:47:21 -0500
Received: by mail-vs1-f65.google.com with SMTP id e16so6041078vsq.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 07:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PnFpHSwVq5mXaCRX9TbyXPOst3rjSPY2Hoy3E+B8Ftk=;
        b=Nh0jObm1RI10kPU3y7N6oXejhm4Flv/VcpIoTz8zb8hQ/6ZFCon8jd2OCzxgoy7xaH
         MIM40ZJTR1WPSK5Pdv90jIBqthU4J+bW/zmnl04Giktg78gBOyZulmfmiH6xkN/Z+rkN
         lEByoevmoaFugF4CB8T1dC0xs+zA+yuCirmDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PnFpHSwVq5mXaCRX9TbyXPOst3rjSPY2Hoy3E+B8Ftk=;
        b=JMug4TEyo+MDBu1bDSceOkxCatkUDNSerj7dyp/1XAtTyFmIwmT444ullN8dvKGk3x
         MDtSkSGzzHWHtaQKDW/Hj9eK5kD3CdpW5QNSjKkI4kIZHCg3DZj/eM5oATc+31KHLqsn
         x+0ljIAMYUuALb4xgQs3wah7KpmI0OJXtB7UM9Sy/qHlKIYreJaVwprAdmdvd+ZkCsgC
         G5hDbBY+hOwTReSOQqZwxgBAuVvqkuldlTfsnWO17RiJ7NaK8VAVDd0qPGEOjoLsQAfv
         swqz05xagrk40Ww1eEcUKB498SS1KEhqKRzGyXPGiwoiQj382cc7njOr9qdALCO+pyD7
         71ow==
X-Gm-Message-State: AHQUAuYwXbrsb2XU7TW8AhAzocZWjR5UbXr+m2qc/M0BzEW97XFP1JXJ
        T67KdfVo/ILWNxvaV/F5u9oIfSswby4=
X-Google-Smtp-Source: AHgI3IYG5SFFgVM0Y0wAVI0E+e4CJD/Tupf6ljAzhji8H99HDWcTLvFVgPFvqDAPYeQwvA9z8bU1GQ==
X-Received: by 2002:a67:e889:: with SMTP id x9mr5415528vsn.182.1550245640393;
        Fri, 15 Feb 2019 07:47:20 -0800 (PST)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id j64sm1193190vkj.3.2019.02.15.07.47.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 07:47:19 -0800 (PST)
Received: by mail-vs1-f54.google.com with SMTP id i15so3436815vsd.10
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 07:47:19 -0800 (PST)
X-Received: by 2002:a67:1505:: with SMTP id 5mr5255799vsv.20.1550245639052;
 Fri, 15 Feb 2019 07:47:19 -0800 (PST)
MIME-Version: 1.0
References: <20190214181249.2749-1-dianders@chromium.org> <20190215030205.g6ntaiec3kscsaoi@vireshk-i7>
In-Reply-To: <20190215030205.g6ntaiec3kscsaoi@vireshk-i7>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 15 Feb 2019 07:47:06 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WH9zg62ME5Atk2NDXX8rLn0qMY3-P1U8jqDr4Th_BX_Q@mail.gmail.com>
Message-ID: <CAD=FV=WH9zg62ME5Atk2NDXX8rLn0qMY3-P1U8jqDr4Th_BX_Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] PM / Domains: Mark "name" const in genpd_dev_pm_attach_by_name()
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>, linux-pm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Kevin Hilman <khilman@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Machek <pavel@ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Thu, Feb 14, 2019 at 7:02 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 14-02-19, 10:12, Douglas Anderson wrote:
> > The genpd_dev_pm_attach_by_name() simply takes the name and passes it
> > to of_property_match_string() where the argument is "const char *".
> > Adding a const here allows a later patch to add a const to
> > dev_pm_domain_attach_by_name() which allows drivers to pass in a name
> > that was declared "const" in a driver.
> >
> > Fixes: 5d6be70add65 ("PM / Domains: Introduce option to attach a device by name to genpd")
>
> Not sure if this should be counted as a fix.

I'm OK if the "Fixes" is stripped when applying or if someone tells me
to re-post without the Fixes--just let me know.  In general I do a lot
of cherry-picks from upstream and I appreciate the Fixes tag helping
to link patches together.  In this case if I picked the original patch
I'd definitely want this one too.  Certainly, though, CCing stable
would make no sense in this case.  ;-)

-Doug
