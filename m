Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579B8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 21:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 189E42147C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 21:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pg/70112"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406182AbfBNVjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 16:39:43 -0500
Received: from mail-vs1-f47.google.com ([209.85.217.47]:42410 "EHLO
        mail-vs1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440396AbfBNVjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 16:39:42 -0500
Received: by mail-vs1-f47.google.com with SMTP id b20so4583765vsl.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 13:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2AgvUemPbGDs5wcdYTHUoim6pmloKfWLdvKfw90+HFM=;
        b=pg/70112KaVZ7aW2f05nvCy+IFkGsXmwwl2+e8z2VxuFtro23Z2s5z8HQuZo0GuVNQ
         jXHIQ2gBqpQXzxTfm7rY6T/XlyQqvG25pL2gxgyRBoObtswwKy7Tay7fsHIDvSyF56oe
         etmvLoIiLnv9c/S9TpXUhfR8a7wr+czDjov3qYn/JRf+AQDU+xOLIpT1WQ06DKmYiEr6
         rBg9mxy0gOfyQNEJL1eC/CCG5CDTfuS8jxd6ePxppsICPQ+66HTScUVeb0WXxe2k9OL+
         cufV9WOj5rh1xpY5swbJyV7aHEm2jwsbwgAYNVvNUwu1uLVK+QWVWa6VlO8Lt6c/U4uf
         bXcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2AgvUemPbGDs5wcdYTHUoim6pmloKfWLdvKfw90+HFM=;
        b=Fabx4qrWJR8A6Do3N0ngpXRYu5mAgi1YqpFNlUhA+DoB9VTj4C1mix01fbXfsi0cXH
         CejlFXWIv9nug674kx4JCpiQsc491RnpA+EVOtMie9J1VC9kqh7A5mLGap/RBouo2zQe
         SJdVhj3IwFsBb95eAhtbpBfREjOjRHfdVALG+TPB4nFPSyt1vhDgLLgyGvAjhP00S8tb
         mR/TdTY0Beoy+bNRwGZy4AxhCeVBIn9LqT99yBn0IMBJsCiAituwr/cxwJPvV1c7+KOO
         xVzwNyul/I/QCSp1rKF/NJe65y9lIW/A5/hnFbd1w88jnm70GjmJxU/oKwG9PWy/9NRu
         SrZQ==
X-Gm-Message-State: AHQUAuZHDUX8cvZOg4/vNZC2/1lUIGrSueuLybcwNbD3AwUZOs5M1YHx
        16IbZBbUzMslal3ocqzdYS9O7HGzQv29W9tsgUxRqQ==
X-Google-Smtp-Source: AHgI3IZ+/WUVeABmRXq1PTCpexyWJWXKAO3MgfylEcA0i9f+xprWtHTUhHFuG8nTPUOulnkt5BKCoUACGSrNES9/WO0=
X-Received: by 2002:a67:744:: with SMTP id 65mr3226580vsh.101.1550180380561;
 Thu, 14 Feb 2019 13:39:40 -0800 (PST)
MIME-Version: 1.0
References: <20190205133727.GF4794@krava> <20190211101957.GB14253@krava>
 <CABPqkBSkyHRaXN-oVLuJJ=aPEBfqOAunRUReHsxESnC=KKQuPg@mail.gmail.com>
 <20190211185306.GD5046@krava> <20190211193202.GG3269@kernel.org>
 <20190211201831.GE5046@krava> <CABPqkBRdmfOde793id4GEuwD=eYL8TLKe1p8k07xWAh1MPD3AQ@mail.gmail.com>
 <20190214113450.GC26714@krava> <20190214125759.GS3269@kernel.org>
 <20190214132638.GB13095@krava> <20190214135958.GB7074@kernel.org>
 <CABPqkBS1LQFV7=DS1-LJVWPo-x=cK9X6iFa=eRHuQKAukwv-OQ@mail.gmail.com> <CA+JHD90ssKi3CJ7yfCFTkrS8xwUsZhvd0t7cSCy1MF7TJ2XLYw@mail.gmail.com>
In-Reply-To: <CA+JHD90ssKi3CJ7yfCFTkrS8xwUsZhvd0t7cSCy1MF7TJ2XLYw@mail.gmail.com>
From:   Stephane Eranian <eranian@google.com>
Date:   Thu, 14 Feb 2019 13:39:29 -0800
Message-ID: <CABPqkBTik6dLrbXSjJm7LpL5T=kv8aHG54j9P0iKzUj6taA7hg@mail.gmail.com>
Subject: Re: [RFC/PATCH 00/14] perf record: Add support to store data in directory
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
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

On Thu, Feb 14, 2019 at 1:35 PM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> On Thu, Feb 14, 2019, 6:31 PM Stephane Eranian <eranian@google.com wrote:
>>
>> On Thu, Feb 14, 2019 at 6:00 AM Arnaldo Carvalho de Melo
>> <acme@kernel.org> wrote:
>> >
>> > Em Thu, Feb 14, 2019 at 02:26:38PM +0100, Jiri Olsa escreveu:
>> > > On Thu, Feb 14, 2019 at 09:57:59AM -0300, Arnaldo Carvalho de Melo wrote:
>> > > > But with the build id in the MMAPs we wouldn't need to scan anything at
>> > > > 'perf record' time, just at 'perf archive' time, where we would scan
>> > > > everything, and as soon as we find a hit, we add that DSO to the list of
>> > > > things we need to put in the tarball.
>> >
>> > > ok.. it might little change the expected behavour in that you will not
>> > > have .debug cache populated until you run perf archive.. some profile
>> > > data might stop report after you reinstall the binary..
>> >
>> Today perf record does collect the buildids once monitor is completed,
>> it does one
>> pass over the perf.data file looking for MMAP records, or at least in
>> the version I am
>> more familiar with.
>
>
> It does look for the MMAP records, how else would it find the DSO pathnames?
>
I was not talking about the synthesize_mmap() code. I was talking
about process_buildids().

>
> - Arnaldo
>
> Sent from smartphone
>>
>>
>> > Well, nothing prevents us from continuing to, in 'perf record', go thru
>> > the perf.data just collected to populate the .debug cache, its just that
>> > we would do it just for that, for populating the cache, we wouldn't
>> > _have_ to do that for collecting the buildids.
>>
>> Sure, for compatibility reasons.
>> In pipe mode, this would also avoid the need for perf inject -b -i -,
>> which is a win.
>>
>> perf archive is useful if you do not have a way to locate the binary using  only
>> the buildid on the analysis machine.
>> >
>> > > on the other hand '.debug' cache would stop growing uncontrolably..
>> > > so I think I'd be ok with this
>> >
>> I agree!
>>
>> > That is another problem, and one that has to be solved in a way similar
>> > to ccache's --max-size option.
>> >
>> > The .debug cache is useful for various workflows, but may get in the way
>> > for some others, which is why we have ways to disable it.
>> >
>> Correct.
>>
>> > For instance, when working on some project it is handy to have copies of
>> > binaries saved so that older perf.data files can find a file that was
>> > rewritten by the compiler when doing changes in it, etc.
>> >
>> > With the .debug cache and if using -g, we can get the older copy of the
>> > binary _and_ its sources, annotation for older versions continue to
>> > work, etc.
>> >
>> > - Arnaldo
