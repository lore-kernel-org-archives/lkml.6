Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76568C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 21:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32B2321B24
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 21:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HeoDAzz2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440194AbfBNVbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 16:31:12 -0500
Received: from mail-ua1-f51.google.com ([209.85.222.51]:41056 "EHLO
        mail-ua1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392871AbfBNVbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 16:31:12 -0500
Received: by mail-ua1-f51.google.com with SMTP id z24so2527616ual.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 13:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l6oJdwKsksPx604/yJJd+mEudQ0YUiZ9cBn0VKX9KVI=;
        b=HeoDAzz20Jg3BhMTwCELmwvtDztUVJysAZ0ZwaJJqJuWLeVPT9Y0l4YfrRuav+cLA3
         qeFPKrPbeE3anBsBAdYEhCY3k5kWsNm208xeAwA9KhMCapnzUvq6krMSSBDcj0dkhzWx
         sHSWVHunQGFH46/osaeyv1Ziz9m104vlqOeYsjTTu6rgrO7bgWEmtZW039DQ2rpOQbNz
         Iw2cjVlB6Y1QUZv5A53N0ZStsA5vnAqugFv4u2seMrIthSRXiFfacRRhEsU+1VdY3ZvS
         jM4JzggKCyyjUVXeTroVmAgxlGlASocQmtut2mbiN12Kn7uheBu+HssaLvn6ohhW3g/E
         JyHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l6oJdwKsksPx604/yJJd+mEudQ0YUiZ9cBn0VKX9KVI=;
        b=AEHIjEptVRzTURLszfM8MRinvaZrf93pEagAEyOyATZNxK3dfjn1c9VH1+aUtYTokY
         hUDBg0AlmjZPL8fPWwDPH+SkmQ0COyc1fedqkYgZ/uXgKQeEgpL8wKoUSEm6IU2tcaOn
         ua5CX/dT1GM9FgYcmQNuIzA28ffk95qo3chrtJC/zFnazuQABw4VpcN6SkL0nmxoCfn2
         UwCMhl0R/zvuDXtB42g9mtfhZFEbliUWiN1capJEDgGnFbMhi46ANBAJV6cbN9ELDaIC
         uSwgGx044pZswSBC6gJZ9t3KcgyeAqCkMfemr2kTA7nGS+fH73yNfjKaFo/bEKM5/5xp
         Yt+g==
X-Gm-Message-State: AHQUAua4fUDBCMoyVjUDwFVLiJEfGKwxP2/P6MpDVbeRDLCpThcUOMzc
        758tYOP3SuKw1HICFYnNlpiAOhoELK6AbAW7NzyKvA==
X-Google-Smtp-Source: AHgI3IarmW+I2egRChm3a8P8cZ7kujnrp4wDgJZoTHzshoCBW9Ye4HCi7zIcGHTh2viraYKM8Yu0DJ14L54FS8JtDZ0=
X-Received: by 2002:ab0:5590:: with SMTP id v16mr3172848uaa.132.1550179870532;
 Thu, 14 Feb 2019 13:31:10 -0800 (PST)
MIME-Version: 1.0
References: <20190205133727.GF4794@krava> <20190211101957.GB14253@krava>
 <CABPqkBSkyHRaXN-oVLuJJ=aPEBfqOAunRUReHsxESnC=KKQuPg@mail.gmail.com>
 <20190211185306.GD5046@krava> <20190211193202.GG3269@kernel.org>
 <20190211201831.GE5046@krava> <CABPqkBRdmfOde793id4GEuwD=eYL8TLKe1p8k07xWAh1MPD3AQ@mail.gmail.com>
 <20190214113450.GC26714@krava> <20190214125759.GS3269@kernel.org>
 <20190214132638.GB13095@krava> <20190214135958.GB7074@kernel.org>
In-Reply-To: <20190214135958.GB7074@kernel.org>
From:   Stephane Eranian <eranian@google.com>
Date:   Thu, 14 Feb 2019 13:30:59 -0800
Message-ID: <CABPqkBS1LQFV7=DS1-LJVWPo-x=cK9X6iFa=eRHuQKAukwv-OQ@mail.gmail.com>
Subject: Re: [RFC/PATCH 00/14] perf record: Add support to store data in directory
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 6:00 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Thu, Feb 14, 2019 at 02:26:38PM +0100, Jiri Olsa escreveu:
> > On Thu, Feb 14, 2019 at 09:57:59AM -0300, Arnaldo Carvalho de Melo wrote:
> > > But with the build id in the MMAPs we wouldn't need to scan anything at
> > > 'perf record' time, just at 'perf archive' time, where we would scan
> > > everything, and as soon as we find a hit, we add that DSO to the list of
> > > things we need to put in the tarball.
>
> > ok.. it might little change the expected behavour in that you will not
> > have .debug cache populated until you run perf archive.. some profile
> > data might stop report after you reinstall the binary..
>
Today perf record does collect the buildids once monitor is completed,
it does one
pass over the perf.data file looking for MMAP records, or at least in
the version I am
more familiar with.

> Well, nothing prevents us from continuing to, in 'perf record', go thru
> the perf.data just collected to populate the .debug cache, its just that
> we would do it just for that, for populating the cache, we wouldn't
> _have_ to do that for collecting the buildids.

Sure, for compatibility reasons.
In pipe mode, this would also avoid the need for perf inject -b -i -,
which is a win.

perf archive is useful if you do not have a way to locate the binary using  only
the buildid on the analysis machine.
>
> > on the other hand '.debug' cache would stop growing uncontrolably..
> > so I think I'd be ok with this
>
I agree!

> That is another problem, and one that has to be solved in a way similar
> to ccache's --max-size option.
>
> The .debug cache is useful for various workflows, but may get in the way
> for some others, which is why we have ways to disable it.
>
Correct.

> For instance, when working on some project it is handy to have copies of
> binaries saved so that older perf.data files can find a file that was
> rewritten by the compiler when doing changes in it, etc.
>
> With the .debug cache and if using -g, we can get the older copy of the
> binary _and_ its sources, annotation for older versions continue to
> work, etc.
>
> - Arnaldo
