Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F6DC282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF47520869
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tp9GPLwU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729466AbfA2U4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 15:56:30 -0500
Received: from mail-it1-f181.google.com ([209.85.166.181]:52065 "EHLO
        mail-it1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727388AbfA2U43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 15:56:29 -0500
Received: by mail-it1-f181.google.com with SMTP id w18so6836013ite.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 12:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PbF++x/c+Rk9/y8urPwBJZolYS/qjCy27gMQV+Aeh28=;
        b=tp9GPLwUgbRRb80MNnnerGpeJkzkpH4oWqtWjxuhGUmLrqTiW1/S6nw17TQ7WDuma+
         48rCf7lL8fstJpVdPeQx5UPDKjFdme0FWWw/0hvoxkpjdMhheQSN3vwqndVgpMIHLVlG
         GZ46lsik7z4xMCi/ABEB/1DaPs1+knJfzMMARGDjTvGgOocn53l6VUA/pRMwLq/lGzFC
         mQ1Lk6hnJr+136o0rBxLMBFzhrUtJt1r+9qhWKF3Y97j42neaegPVHOFNvQpdi4qfNlx
         rugFyKyYLhzE0jr8mxjJKAwniPaGEOjJ5hKIOt7y5LoEUPXCauihX4/dzecAmr5bjbSB
         EmTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PbF++x/c+Rk9/y8urPwBJZolYS/qjCy27gMQV+Aeh28=;
        b=ZgT/ra2r0o9mtYIdnJEfOJ8Yk9/npcdanHDzAfk9Hxg0CXxLQX2IfYiFYMc4KFX90z
         p4mwXWXh5Yu5fXYAD9OYYVP2ROJAqaOXeHEiXS40FPV/e6P1w1EGCqlxcCb2FMnbDR91
         YmjzLJ0cAB9OY41PdiqIroSbb0pcPGP3pxt14XUiaQw1Zk1XxVDo06lHsjWwCw0Rpomt
         ctivRadNc71QJzRE9fxNwnP4zjks6QtKWWA2IcrGOgsTacwu8CHDNdT6qWX4TzpvukKH
         xVxZlRZUXB3P5f3EHnQXqbZ24fe7SrmQVLb3tYadtTC+U3LJBlwebXV/SjWncNW3LB9c
         OO9w==
X-Gm-Message-State: AJcUukdK5L5hjw/ebtJYPxesth1YpU7qFnSZEHT2IPiTdnQYRKf1tWx0
        NgxlHlfVKD0eJ/Lr/hzCdiGVXwLJGaM0zDMmbEM=
X-Google-Smtp-Source: ALg8bN4zHSFabZZo/4FI9LtIg2/+xT6LXak3S1kpLCNEodVKp0yKbyT7uT3noZnxWni0iogkCby5h10I2gspmQWw8BA=
X-Received: by 2002:a24:2e94:: with SMTP id i142mr4857501ita.157.1548795388816;
 Tue, 29 Jan 2019 12:56:28 -0800 (PST)
MIME-Version: 1.0
References: <20190128144506.15603-1-mhocko@kernel.org> <20190129141447.34aa9d0c@thinkpad>
 <20190129134920.GM18811@dhcp22.suse.cz> <CABXGCsPM-JrdxN9t-HjkWxJJzdGHiJZOYD5p-CsjGEFSQ=+DwQ@mail.gmail.com>
 <20190129202440.GP18811@dhcp22.suse.cz>
In-Reply-To: <20190129202440.GP18811@dhcp22.suse.cz>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Wed, 30 Jan 2019 01:56:17 +0500
Message-ID: <CABXGCsMk_kj5HxsHncAFFp4Z3trDfL3j8fpcLv3Q_Hj4tGgH2w@mail.gmail.com>
Subject: Re: [PATCH 0/2] mm, memory_hotplug: fix uninitialized pages fallouts.
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Mikhail Zaslonko <zaslonko@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2019 at 01:24, Michal Hocko <mhocko@kernel.org> wrote:
> I do not think so. I plan to repost tomorrow with the updated changelog
> and gathered review and tested-by tags. Can I assume yours as well?

Sure

--
Best Regards,
Mike Gavrilov.
