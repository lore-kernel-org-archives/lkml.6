Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE2E3C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 02:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 795E321871
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 02:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SDpgEUWy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbeLSCIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 21:08:42 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34108 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbeLSCIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 21:08:42 -0500
Received: by mail-lj1-f196.google.com with SMTP id u89-v6so5312496lje.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 18:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n7wcBScktVy+08k1yEhgUaLxoZO5YVNjKs7tOuytHto=;
        b=SDpgEUWyNlVmjyH9Kvz3/0RUnPUmTSRDyPvs3VC8rf2JRu0yDaeTH1yFNOOsBr4Yga
         R5QtYtAYzJutNtCY0Boroo+I4RORWKzuhxn8Y2RfbZLzAQJOIGkZCl7p19u4c0tMINXn
         C3+NToQVu+aNN0lRIepUpauZpzqx90EN6QX/F7KdsYn1cnht5DAc5u7RzSy5g42NuKl0
         qDYmIC4sxvEV8YoJUXmXFAL/9pHqHjj4vUrfxwsnN5zcO7Q71uWdpPzQR1y7JvfTbRMN
         qnONzcZLdql+/5X8oeKUHL3R6Zx7WR06yCg4Ww1ynuo29/JRv5aqwfHIXiaqz5PDnhnT
         lRIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n7wcBScktVy+08k1yEhgUaLxoZO5YVNjKs7tOuytHto=;
        b=jP0OwQeloJwEvRyvm09YOKXEFbZvZmAeDIIXym/SdwbCc5hLhc39XxXQu/otzSB3V0
         dDzNgHI2KH1JouhR2uJz2eYQA3lcPsCM9N+em781p1L9zNzg1+d6/TiXQjvw51PsnayG
         bmMRfGoFY7VUtGh8HwzsyHBn71DDSDNoeWvpJdBEdECi6+KAbtJSGMaKH7xDmk77C8sC
         JjIQqWu8th3NyzP1YtBXdGS+2RPMssjmc7t82pYFxqXpRHKllvzXxJplCWf9PJv3asV7
         0XhzJuLDjugaiylQJLGalzgcNbuOBzWN/Vz6NPZzXRNgr6Y91z477kquo4tOrfbH8d/H
         udNg==
X-Gm-Message-State: AA+aEWYBUt5TiwPrvC2X8+xeWDfL8P3TqNKPeKe1Hy1OJDzIfwCjPT3F
        L04FRiMEwyztNm/N1wAJ9FJ5louGAMlOsGPUUwFU/w==
X-Google-Smtp-Source: AFSGD/UT8WZLfuUpRB1ikgR0cBLj5hpdmcbSNZF8gspdodamzQLPsazXujzhhQNUUI3jfmEQSlXKUUa3O1+vb1Yt5O0=
X-Received: by 2002:a2e:302:: with SMTP id 2-v6mr10852480ljd.137.1545185319408;
 Tue, 18 Dec 2018 18:08:39 -0800 (PST)
MIME-Version: 1.0
References: <4dfc634cfcfb236883971b5107cf3c28ec8a31be.1542328222.git.sdf@google.com>
 <20181116133420.GA29750@krava>
In-Reply-To: <20181116133420.GA29750@krava>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Tue, 18 Dec 2018 18:08:26 -0800
Message-ID: <CAKH8qBs3UJt1d_b39q6i1Arak0SsRunpEsukicprsGVZb00C7g@mail.gmail.com>
Subject: Re: [PATCH] perf build: fix -lbfd feature check
To:     jolsa@redhat.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, mathieu.poirier@linaro.org, mingo@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 5:34 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Thu, Nov 15, 2018 at 04:32:01PM -0800, Stanislav Fomichev wrote:
> > Current libbfd feature test unconditionally links against -liberty and -lz.
> > While it's required on some systems (e.g. opensuse), it's completely
> > unnecessary on the others, where only -lbdf is sufficient (debian).
> > This patch streamlines (and renames) the following feature checks:
> >
> > feature-libbfd           - only link against -lbfd (debian),
> >                            see commit 2cf9040714f3 ("perf tools: Fix bfd
> >                          dependency libraries detection")
> > feature-libbfd-liberty   - link against -lbfd and -liberty
> > feature-libbfd-liberty-z - link against -lbfd, -liberty and -lz (opensuse),
> >                            see commit 280e7c48c3b8 ("perf tools: fix BFD
> >                          detection on opensuse")
> >
> > (feature-liberty{,-z} were renamed to feature-libbfd-liberty{,z}
> > for clarity)
> >
> > The main motivation is to fix this feature test for bpftool which is
> > currently broken on debian (libbfd feature shows OFF, but we still
> > unconditionally link against -lbfd and it works).
> >
> > Tested on debian with only -lbfd installed (without -liberty); I'd
> > appreciate if somebody on the other systems can test this new detection
> > method.
> >
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
>
> looks good, Fedora goes with standalone libbfd
>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
>
> thanks,
> jirka

Will this be included in the next merge window? Or this patch was
somehow missed out? (I didn't get any notification about it being
pulled).
We need this to get -lbfd working with bpftool as well...
