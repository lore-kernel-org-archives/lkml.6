Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F0ADC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 05:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3E04214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 05:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F3HrcGq2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3E04214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbeJQNLB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 09:11:01 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40198 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbeJQNLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 09:11:01 -0400
Received: by mail-pl1-f196.google.com with SMTP id 1-v6so12086330plv.7;
        Tue, 16 Oct 2018 22:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=e098GeBfTphcH0PH7t4yQNR+i4RKSMtfZ+HDTdincjo=;
        b=F3HrcGq2LpAciRrLAvsSzQEU6AwZQXJTvEO269ib2AxFfy8eRk153ctTayNwUkV6q8
         9Grs+TnqMhJIh1Otw7wtlkzMqMyFk8mg+rV3QJ2MKYWuJcI5s+cj+attupZd8iQbHzYu
         /LyEJq9OhjcXj1wC1rQnNlueTTKGfbOzzI7E4ItNvCImrjftlzkKkRKd7Ta4SSawcLPr
         Wte2NHKt3BexxtmXYhoYbJdt39l1ECJ5LBZhu4ACcF7K+mIr36t52KcXjN7sncWa5xMr
         q6vq0Ts8dfQdpJq7L4S3oIRT4DJ7v/tXlkGp7nC8KYAk0P0s3zFDc+KtWDAp7/j+7s8t
         +7KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=e098GeBfTphcH0PH7t4yQNR+i4RKSMtfZ+HDTdincjo=;
        b=aNVnhoWTvk6cnkrOAgyWLuBNTyMTAX+VVDrdEtD0VqzAWYCA7qUUo+XxbUX0N5GNYN
         Cp0teE/mSE7rH6QIMoNEBZB5cljlgMru83vIVT4mVBraGDnSjYJDmYZNoJOYJVfcu6T1
         Jsi2Umn0Tlozu8GGANWrPMMbzwos8YHPZOV5DHUFabbBbERmVsL2Jr8kEVJS2gLr9ya+
         cZQ9MqRLne6ud9uEi7EmucItOzIT6TbBE9eRquIBqhd3E6JS9PescaO5BW+CWSTOnsjS
         0uxxygTvI6S1nwDLwXNGqUfvjIVZ8+cd2CtAfxB3q1jQwltIZd8TphkJV87Ly9vBelr8
         EYcg==
X-Gm-Message-State: ABuFfog0mmQ1a4CpeZp4GEABYfwqh4hdrfh8c/FHf2wYSc5Bt4haiQQg
        4x8J6dL9tpCGryTMj3AJiVkIfXZHdzWKrywr+qLXIWFa
X-Google-Smtp-Source: ACcGV637YU3LV0DHGLqHHa7yHhdQj1/3rM7QE1SKhCJ8/X72ict3XdqbGGAC1JWy6wx/2t6yAmhwprpj4/yK68RfjK4=
X-Received: by 2002:a17:902:bf44:: with SMTP id u4-v6mr13651263pls.48.1539753429200;
 Tue, 16 Oct 2018 22:17:09 -0700 (PDT)
MIME-Version: 1.0
References: <e0611057-1b5b-9990-b9fa-060a9b5eba40@linux.ee>
 <CAM_iQpU0+LVwgMea32KQWf8z6Bp1VTmWOGnWNwNSmV0PZzf_ew@mail.gmail.com>
 <20181017034047.nrhstc3b4wzevnri@codemonkey.org.uk> <20181017035038.czaqown24rnjn2pw@codemonkey.org.uk>
In-Reply-To: <20181017035038.czaqown24rnjn2pw@codemonkey.org.uk>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Tue, 16 Oct 2018 22:16:57 -0700
Message-ID: <CAM_iQpWJfMWRY1TZRDz+GgjGJj_ySjmb42hjPyAtcakzWqnLeg@mail.gmail.com>
Subject: Re: netconsole warning in 4.19.0-rc7
To:     Dave Jones <davej@codemonkey.org.uk>, Meelis Roos <mroos@linux.ee>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 8:50 PM Dave Jones <davej@codemonkey.org.uk> wrote:
>
> On Tue, Oct 16, 2018 at 11:40:47PM -0400, Dave Jones wrote:
>
>  >  > This is exactly what I mentioned in my review here:
>  >  > https://marc.info/?l=linux-netdev&m=153816136624679&w=2
>  >  >
>  >  > "But irq is disabled here, so not sure if rcu_read_lock_bh()
>  >  > could cause trouble... "
>  >
>  > Not sure why this didn't show up for me when I was developing that
>  > patch, but I can now reproduce this.  The patch below fixes it for
>  > me, but I'm not sure if there are still any side-effects.
>  > There's also a missed unlock in the error path.
>
> I took another look at that error path. Turns out this is all we need I
> think..

Double check if rcu_dereference_bh() is happy with it.

Don't trust me, enable the relevant Kconfig and trust your test. ;)
