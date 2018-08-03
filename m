Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D800CC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 20:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E395217A2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 20:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LjldOHI2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E395217A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729834AbeHCWKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 18:10:25 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:51683 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727953AbeHCWKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 18:10:25 -0400
Received: by mail-wm0-f48.google.com with SMTP id y2-v6so7468275wma.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 13:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LOFDd9Jty6XmFo23AH95peAJNjgrJMToWrTC0VvRw9Q=;
        b=LjldOHI21E2KQFx6bY1iIq+08dDQ67JaZQnxFltn12ergzwi2u75e1ZQyybu/oN+1n
         +wUmlBFo5dZp9rHJUiwAe5/Yspn5sX5g6vCxvSCvGiSQyiNNlsKod1gWhIUQm2CXvXBg
         iv6s9YlSl3XuuJ4wjiR70PS8hGtg79ewZ9g+1ZmPPAy3k7h779ZkKqBwdHvi2vdL1sIl
         0GHWCgdN+nhUtlHnAbtNmU9Z9lcdVh7N5FD7Ng58RdHuMG2LiWj23tgmWDdvDhdwgH9a
         Co4JgjQ70VCQj+AnHFyAgdVhZS0PsrBjFropE//0SucNfZj8ndE0StnDzaBQ1Z4CTQZG
         vB0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LOFDd9Jty6XmFo23AH95peAJNjgrJMToWrTC0VvRw9Q=;
        b=T6KDyMdyC/IfCYjixrX321mcRjcr1NBeViMMOyV+fsSjDZqkhFP2czER+JT9f0bS7x
         nO8L8MVrWFf1ueygnDDESvruR1LB+09B+40VoW63AUelupyphZduIWyMos3xij77+bM0
         xEQjMd7twwhQRM86zWTM7tuAiWrlQ8jF0BC41JiPXn/oxGMis5XIz6tMDBggZH/hv596
         /AFSzSyIjGiGzWRaOf1mMo2lFArGJ2VHrmde8rtw+avAdNk9yAwkteFPoadgD+bJcbSs
         D050BMwrrT1QblfNld8EYtc7BRRZsvnMVuU2VFF5cDYltx5ptLSYPV8LY8z0DNejThyB
         3aBA==
X-Gm-Message-State: AOUpUlGFsFE6PmjwE26y0COrUQL8eB++mtUpRDAqdYXvQMOeO3PHuTfU
        l3O+y8qVlkFc7BdZjd887/EAkJHlDz+is51u38JVBw==
X-Google-Smtp-Source: AAOMgpdtCymOMIfBES0CrFlgGB6KnCztAm0+DAEsoI5kj6NPdbhYIOO1mVBp2oD/wpfy785ibwceoZhPwXBfGiOa8cg=
X-Received: by 2002:a1c:af0c:: with SMTP id y12-v6mr5549608wme.87.1533327156090;
 Fri, 03 Aug 2018 13:12:36 -0700 (PDT)
MIME-Version: 1.0
References: <CABPqkBT0P=GKNb6ypjaPxe4dEwShHk37mdrX0RtodMm44gaE+Q@mail.gmail.com>
 <20180719082539.GB18667@krava> <20180731092128.GA17617@krava>
 <CABPqkBQOWGUsTOXP1CjVxSDtquSGrxaiSqK1ZgJcW0jfzwENsg@mail.gmail.com>
 <20180803112955.GA2402@krava> <20180803155140.GH7996@kernel.org>
In-Reply-To: <20180803155140.GH7996@kernel.org>
From:   Stephane Eranian <eranian@google.com>
Date:   Fri, 3 Aug 2018 13:12:24 -0700
Message-ID: <CABPqkBRjNPxmf809g-g0DwaVrPNccbLDg2TggNVJySj6Oak5Kg@mail.gmail.com>
Subject: Re: [RFC] perf annotate: option to report global percentage
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 3, 2018 at 8:51 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> Em Fri, Aug 03, 2018 at 01:29:55PM +0200, Jiri Olsa escreveu:
> > On Fri, Aug 03, 2018 at 12:28:16AM -0700, Stephane Eranian wrote:
> > > On Tue, Jul 31, 2018 at 2:21 AM Jiri Olsa <jolsa@redhat.com> wrote:
> > > > there's the 'p' key to switch between local and global period
> > > > I haven't added any command line option for stdio yet
>
> > > > I'll have more testing and post later but any feedback
> > > > now would be great
>
> > > Tested your code on a few examples and it seems to work well. Looks nice!
> > > Thanks.
>
> > cool, I'll have it sorted and send out soon
>
> > > PS: I'll have more small requests coming based on user feedback and my
> > > personal experience.
>
> > keep them comming, we need more user feedback ;-)
>
> Exactly! Features driven by user requests are super important to keep
> these tools improving.
>
Ok, then. I will start a new thread with the other requests I got.
Thanks.
