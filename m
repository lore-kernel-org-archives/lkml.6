Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2EDEFC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 09:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 432D420882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 09:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u0IdYcDZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 432D420882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbeINOyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 10:54:07 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46577 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbeINOyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 10:54:07 -0400
Received: by mail-wr1-f68.google.com with SMTP id a108-v6so9775334wrc.13
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 02:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=52a0z7VDHdIt5YIzVsgyaZUjQUdjM56N0Cpykg5QRCM=;
        b=u0IdYcDZ717W7Z+olHzbaAgJOPBzJWynJybqgaVqPuw87jgC7WFES6IvrDgYK1xlno
         3STTjPLoYDg42/GQoUz7mLuio2JI3N12eIglXM1DFAZYxPAT4OuuWZbXtL8PQ9b9P/xK
         D63m+SzBJlPefjf/cydV80WeGJvSjanXw/rG/K++KipejPXDMkY250nKFesNoCqnzKmA
         DSsjBDfiQ6JUz0GRHE90GmbNdHPPgwtEZRI/raBJFpF7PjegCC5jhIT/vjlC4BkJkADv
         FWZqd4QhOQM2t6ybvWghjj/xElc+hudgdbMoZZaduhVYW15RCeQ7L2NJql0OhjFMwmZH
         1PCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=52a0z7VDHdIt5YIzVsgyaZUjQUdjM56N0Cpykg5QRCM=;
        b=kAiIB3se4Qjarp9CFi20gUmKT1Qh6jbU1U1YSqkNZNW86hfe3SyxjzOxbb9PRwz6kU
         B4Tb+MWTK5GWKS/tbNhwi+BTaXJE2k2zpB9WnirpCVBJFjJSlHPwkKJmMHYRGcmFAHM9
         SdIJS8S6rPrsPufuUEtdnaP9dFNZWp5i8dQmm93HKi6vl5T9QetlSpYFa+43Rbwo2r8D
         wPD8voUkSGzeRsVhdiLlDNA7S9dTnjr63TG0EZ5FHDf5pNhDwe99FvO+rWWm8H8P1Gd0
         UZ13xOt/daRSI/gycLETNbulcdaI3KNTetBD+p61DkJgsVbToyNVoIaYf+kPReYMd0PC
         WrYQ==
X-Gm-Message-State: APzg51C5TYrUx3wd83URGVC8Z9pQybLy6K3zefHoe0NmzS7wGP1H/QyE
        fQjMcnXO3Cqp7VBJIuwDl4A=
X-Google-Smtp-Source: ANB0VdYZ1bhzSlzI8fUPV4psEVDFyNiAqqwYi+oQYKQJOU4ToMGSKko1UAlEZXSuOLXhdLgC3rxotg==
X-Received: by 2002:a5d:4e0a:: with SMTP id p10-v6mr8607360wrt.48.1536918025232;
        Fri, 14 Sep 2018 02:40:25 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id v16-v6sm8231097wrw.12.2018.09.14.02.40.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Sep 2018 02:40:24 -0700 (PDT)
Date:   Fri, 14 Sep 2018 11:40:22 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>, kernel-team@lge.com
Subject: Re: [RFCv2 00/48] perf tools: Add threads to record command
Message-ID: <20180914094022.GB96351@gmail.com>
References: <20180913125450.21342-1-jolsa@kernel.org>
 <cba27d6a-a97b-cbb7-4be8-d1c14fb7dea5@linux.intel.com>
 <20180914022910.GA15146@sejong>
 <20180914082307.GF24224@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180914082307.GF24224@krava>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Jiri Olsa <jolsa@redhat.com> wrote:

> On Fri, Sep 14, 2018 at 11:29:10AM +0900, Namhyung Kim wrote:
> > On Thu, Sep 13, 2018 at 07:10:35PM +0300, Alexey Budankov wrote:
> > > Hi,
> > 
> > Hello,
> > 
> > > 
> > > On 13.09.2018 15:54, Jiri Olsa wrote:
> > > > hi,
> > > > sending *RFC* for threads support in perf record command.
> > > > 
> > > > In big picture this patchset adds perf record --threads
> > > > option that allows to create threads in following modes:
> > > > 
> > > > 1) single thread mode (current)
> > > > 
> > > >   $ perf record ...
> > > >   $ perf record --threads=1 ...
> > > > 
> > > >   - all maps are read/stored under process thread
> > > > 
> > > > 2) mode with specific (X) number of threads
> > > > 
> > > >   $ perf record --threads=X ...
> > > > 
> > > >   - maps are spread equaly among threads
> > > > 
> > > > 3) mode that creates thread for every monitored memory map
> > > > 
> > > >   $ perf record --threads ...
> > > > 
> > > >   - which in perf record is equal to number of CPUs, and
> > > >     it pins each thread to its map's cpu:
> > > > 
> > > > 4) TODO - NUMA aware threads/maps separation
> > > >    ...
> > > > 
> > > > The perf.data stays as a single file.
> > 
> > I'm not sure we really need to keep it as a single file.  As it's a
> > kind of big changes, we might consider breaking compatibility and use
> > a directory structure.
> 
> moving the files into the perf.data at the end is actualy
> not a lot code.. and I think it's one of the 'small' things
> that make this feature more user friendly

So the user shouldn't really care about the structure of the file when most uses of perf 
tooling, and 'single file' versus 'single directory' has similar usability IMHO.

When moving across machines it's recommended to use 'perf archive' anyway, which already 
creates a tarball that includes debuginfo and other context.

In fact keeping the files separate has scalability advantages for 'perf report' and similar 
parsing tools: they could read all the streams in a per-CPU fashion already, from the very 
beginning.


BTW., random annoyance bugreport, for me 'perf archive' is spewing a ton of these messages:

  $ perf archive
  unwind: target platform=x86 is not supported
  unwind: target platform=x86 is not supported
  unwind: target platform=x86 is not supported
  ...
  unwind: target platform=x86 is not supported
  unwind: target platform=x86 is not supported

  Now please run:

  $ tar xvf perf.data.tar.bz2 -C ~/.debug

  wherever you need to run 'perf report' on.

  $ perf version
  perf version 4.19.rc2.gcb48b6

That message is repeated 7,200 times (!) and immediately nuked my terminal history. :-/

Even if we want to emit that warning (we really shouldn't unless it's important for the user to 
know), there's no reason to print thousands of messages to stderr.

Thanks,

	Ingo
