Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22775C64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 22:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDC3F214FE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 22:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djUYsiS5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDC3F214FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbeJJFjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 01:39:05 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34910 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbeJJFjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 01:39:05 -0400
Received: by mail-io1-f68.google.com with SMTP id w11-v6so2453298iob.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 15:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6jHLNncDElAO3EE6xgrhlIGFZKywuCT9NkoAWswTBK8=;
        b=djUYsiS5+6ppgOBw1otiJaHiiI0HQRpvlIfIa+Nxqlsfe76D2ZmUJco7iRMrTmjl/A
         hPTrVp+LFV5x/zJNtXBPsQH6Q4yhuISqkkoCuThKT0h/gCNiQ7OL2gyMbDTXPMlFHT8j
         k/ZBW5jutwyAjTKM+YoO9dqlbIELYHr7Mi+9ypu8CqV2AQHHEVCGbjZ2ZumWzIcmfD1d
         NR23qFuQ4/BYPHXD10McMYJK8xdPmhXw8ivHm5Fx3Pm8awHjLYibI5Ljpm4yNzWh5YoM
         fveQFJg98QBFlRH6sLm0DV9jzdylIqMDs2N/Cz6z9K363nVNUhRNj3HzOV623xpkfP+C
         PQQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6jHLNncDElAO3EE6xgrhlIGFZKywuCT9NkoAWswTBK8=;
        b=INWpcRzeFrihI7QOG4djEYbunY8DhyTFbSWn5l/bxWi6ilWTeLe2JWSHUOgdosayzj
         UVW0XZzpDCDYucx5B7nWP47Tj7CKdhQOsWLf0mPCIfhB0EAzgJT6xvMm1o3pevqcn50G
         ANy36kyZF7GDoEjlWbCRZS8bCPR08PJYUK81QMSZFiWJ6H1jJqCEaklORib4ris2NTs3
         n9bmyTS6ZAbR++sBe2DC+2YUBE56i99DF7AQSMq9DULkHbkTKWHSoi9xqPuSlb1dk9rb
         SGs/7agz6VmFtDUmRyXk1AZBrEZOR91E3J+KCRgmugvX4wOvT5uCtLEPsMwpNstfVIg4
         oDdw==
X-Gm-Message-State: ABuFfohsxQnmGa8zxVLWUMDmk1LJr7ioVt9T7gHnhTToYdV7SmROU/r9
        wQFOgfvZR5OqGRkKGn1Wb6+pn0gbE7DijCpPWwc=
X-Google-Smtp-Source: ACcGV62YfKQTTrgiAWMEvq/zZEhz7dBfDXu2QZXxiinu4WN6J2eRuhOjRbe+exVjDT4fVTOAs1e7cu/JFnNcONUj7zU=
X-Received: by 2002:a6b:da0e:: with SMTP id x14-v6mr20035225iob.101.1539123599657;
 Tue, 09 Oct 2018 15:19:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAO49afLqUGuBi_R7BKyojqnkHrMGqXquy-FdVFscOu6Ez0cVFw@mail.gmail.com>
 <20181009164743.GA22886@krava> <CAO49af+zxxVh9HGfjKxS=vQcD5po7-oLU87Zp0F21M-C64nWUA@mail.gmail.com>
 <CAO49afJVHsywYdosSqceQiMzFdaYivm4kiNnC_+WKq15jsA7Dg@mail.gmail.com>
 <20181009214158.GB31206@krava> <CAO49af+5TaWrdYeM3XyHoti0obH--0txq9_a6_9ZPMuB-J=hjg@mail.gmail.com>
In-Reply-To: <CAO49af+5TaWrdYeM3XyHoti0obH--0txq9_a6_9ZPMuB-J=hjg@mail.gmail.com>
From:   Anthony LaTorre <tlatorre9@gmail.com>
Date:   Tue, 9 Oct 2018 17:19:45 -0500
Message-ID: <CAO49afLTe3CF36GxjhPOT3CeoXf14_6qpav9Cv4kMbYdnFrOsg@mail.gmail.com>
Subject: Re: perf report segfault
To:     jolsa@redhat.com
Cc:     peterz@infradead.org, mingo@redhat.com, jolsa@kernel.org,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I tried it with the version compiled from the latest sources and I
don't get the segfault, so it must be an issue with the version
distributed with Fedora 27.

Tony
On Tue, Oct 9, 2018 at 4:47 PM Anthony LaTorre <tlatorre9@gmail.com> wrote:
>
> I can try building perf from the latest sources. I've attached the
> perf.data and perf.data.tar.bz2 from the test program I sent earlier.
> On Tue, Oct 9, 2018 at 4:42 PM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Tue, Oct 09, 2018 at 03:18:12PM -0500, Anthony LaTorre wrote:
> > > Ok, I can reliably reproduce it by profiling the following program:
> > >
> > > #include <math.h>
> > >
> > > int main(int argc, char **argv)
> > > {
> > >     int i;
> > >     double sum;
> > >
> > >     while (1) {
> > >         sum += exp(++i);
> > >     }
> > >
> > >     return 0;
> > > }
> > >
> > > compiled with:
> > >
> > > $ cc -o test test.c -lm
> > >
> > > with the following command:
> > >
> > > $ perf record -F 99 -p 20016 --call-graph dwarf sleep 10
> >
> > still nothing.. any chance you could try on latest perf sources?
> >
> >         $ git clone git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git
> >         $ cd linux
> >         $ git checkout -b perf/core origin/perf/core
> >         $ cd tools/perf
> >         $ make
> >         $ ./perf ...
> >
> > you might need some packages mentioned in (search for 'yum install'):
> >   https://perf.wiki.kernel.org/index.php/Jolsa_Howto_Install_Sources
> >
> > it's little outdated, but the packages lists will do
> >
> > thanks,
> > jirka
