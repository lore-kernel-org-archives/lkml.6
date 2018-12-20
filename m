Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 019D0C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 23:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE706218FE
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 23:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jq9FmGN4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390292AbeLTXUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 18:20:25 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:37641 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731895AbeLTXUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 18:20:25 -0500
Received: by mail-it1-f196.google.com with SMTP id b5so4225983iti.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 15:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aJCstcpioKX1kDPN9Do4ajl4wQrLRjEEgz6HAK8MoUY=;
        b=jq9FmGN4dEMDtMTdoSlw+U4KYxRXJEWTp0D/E5gKQxakIGOQlDSyOpAf28F3X6D93Q
         zBWTouplLsJzDsBHyzbPw5I5cneJ2jm5gNKicFCRLDOnZkK23qJn4Olt6gCsRkaBV4ys
         ff+XaSkC4mwtm7wQHD6ms6kOp4MHJ4ZTcCjH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aJCstcpioKX1kDPN9Do4ajl4wQrLRjEEgz6HAK8MoUY=;
        b=YfILTqyxS7rVBzO41Wi2CguUAqP+f/ihOV23aa/Ls1kbu//HUlbbkxeedZAA8McEe4
         g5L0VV/VxJ7qLNxnspcuHmsx78ZYPIt40OyHDtgBR69+6ia1bbQh3Fte2ZbgdiA0dIUQ
         10zSZc26t00Ll24Mf+nJYYmWZsVj4o9xZ52fzUyc9q7WxR5QyhjommJZAjqfruhsWNSv
         6OFA6qPj9dR9PgttVrPZLb4e03gInlCx+SWQlH5t7M8YAoaWAlJnlPqy8aHNKv9PGPU+
         Xt1vkbQ6A5QhzPwvcVGX72vGqyuxFZhzYRNXy66vF8b/6FEE+Q07LKmRQHZz+dH2SUu2
         jyqg==
X-Gm-Message-State: AJcUukdqYIoNomQSdoemEfeiTK289eFpkIHijzZe1ci2jJ2BjzRq+QEm
        aV7p1/33M24TnSggEI++DSuHu0KkDqhjJOdYphc+Fg==
X-Google-Smtp-Source: AFSGD/WPKU3M+3Jvw6zAtXzZltMyw24jz/yuzayxY6/Dl1M0Ds3Tovkz1K5Cs+O0YvNmtCqawmFHb/ey5XpGON0VQjM=
X-Received: by 2002:a24:bd0e:: with SMTP id x14mr502314ite.123.1545348024331;
 Thu, 20 Dec 2018 15:20:24 -0800 (PST)
MIME-Version: 1.0
References: <20181024013132.115907-1-dbasehore@chromium.org> <154534054131.79149.12015186156265337224@swboyd.mtv.corp.google.com>
In-Reply-To: <154534054131.79149.12015186156265337224@swboyd.mtv.corp.google.com>
From:   "dbasehore ." <dbasehore@chromium.org>
Date:   Thu, 20 Dec 2018 15:20:13 -0800
Message-ID: <CAGAzgsq=p-2N6ybFXNTnz5SDkcdktA+Gk6e3gxrjpJB+L8389A@mail.gmail.com>
Subject: Re: [PATCH 0/6] Coordinated Clks
To:     sboyd@kernel.org
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-doc@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        aisheng.dong@nxp.com, mchehab+samsung@kernel.org,
        Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 1:15 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Derek Basehore (2018-10-23 18:31:26)
> > Here's the first set of patches that I'm working on for the Common
> > Clk Framework. Part of this patch series adds a new clk op,
> > pre_rate_req. This is designed to replace the clk notifier approach
> > that many clk drivers use right now to setup alt parents or temporary
> > dividers. This should allow for the removal of the
> > CLK_RECALC_NEW_RATES flag and the implementation of a better locking
> > scheme for the prepare lock.
>
> Are you going to resend this series? I can do a review but I wonder how
> much it will change anyway.
>

I'm going to resend next year. I got distracted trying to get other
code to work. This code has bugs in it, so a new patch set is
required.
