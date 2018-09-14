Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0730BECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 12:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A764120881
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 12:45:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1KzJmcj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A764120881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbeINSAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 14:00:10 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36507 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727749AbeINSAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 14:00:10 -0400
Received: by mail-wm1-f68.google.com with SMTP id j192-v6so1821176wmj.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 05:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qu1ge5zglKzT1BPwpuJ8dQt4khDBZk9GWe+oy9i3388=;
        b=U1KzJmcjK6DPrZjNhiVzdBxHwLPlvDVRjfjYyN0mCdAsrEUYLHeu6x97w0ZuMicqRX
         7qDjHHPzPLH/QDc8DjZ+lfwO6R//GQtvzWr5Ea7NbZFfy4Ag62BUhWicqZ6+8DbLa+9w
         sa8ByQUR0bxRnALSBU03FH9R925AL2kXHU8klUugoGq/+c6ziJaBy8S9fmfpVsP2KE/9
         VyyS+WJ/odHJL49ZDNJLNVLH/HGjp6doLE2VvXORIhA4zdFncDYKBxWsMJqbBQ1Xp+gY
         nNTGR7cqZiUxfrkGnXDwc0uFLASLAsRjHM64FpvjRuDjCeBFuy9TcxvrB51Qx+NScdIM
         Kgcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=qu1ge5zglKzT1BPwpuJ8dQt4khDBZk9GWe+oy9i3388=;
        b=UdXBWiivOqVgm4Axe4nn+ggNnYcKypxl90V8WEIpiAJ7AgHqdd65QnIPXhHoqQ75VE
         3vy1EcHaMqEtTZKv3pCFVAwtjW4pjwZIrDgg8O5BOlj9JtDIFJ4hmRhnIpIgprraS3HV
         oJ8kuSCGpW//iJ0Z2GnZ29a9uQ2J+OkVYd7R34y1SPAg30SmRjSKcD5i0nkd1H7ZvFzz
         tCq/j6Ch6g/vHW3rHo7sSpWWhqnSmYQ24YBUQGScqiBbB+fO+Df2/L5An+vnh2gdGpsW
         mfDke0+114Y0L6MTJr0o4u7YW8DqvhR5/U09pXYnz30Rw6qtLoBtH1vwvixMI7uX2Mne
         XUcw==
X-Gm-Message-State: APzg51BOqTNbtRrmnwg5I2StnnXZKsrsUKUOzIgZGd7odsPUsG6YVqtN
        ia6W0a4j7br5/JMQTq2XaEk=
X-Google-Smtp-Source: ANB0VdYsR8NWuKDR/MuqMEakHW18HJakdz+OoScEtL2rdaqNZ3MPkxGqszsG7D2ydMhj6msKvwexpQ==
X-Received: by 2002:a1c:5411:: with SMTP id i17-v6mr2116108wmb.53.1536929149237;
        Fri, 14 Sep 2018 05:45:49 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id 14-v6sm2271698wmp.32.2018.09.14.05.45.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Sep 2018 05:45:48 -0700 (PDT)
Date:   Fri, 14 Sep 2018 14:45:46 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <andi@firstfloor.org>, kernel-team@lge.com
Subject: Re: [RFCv2 00/48] perf tools: Add threads to record command
Message-ID: <20180914124546.GB98534@gmail.com>
References: <20180913125450.21342-1-jolsa@kernel.org>
 <cba27d6a-a97b-cbb7-4be8-d1c14fb7dea5@linux.intel.com>
 <20180914022910.GA15146@sejong>
 <20180914082307.GF24224@krava>
 <20180914094022.GB96351@gmail.com>
 <20180914111528.GH24124@hirez.programming.kicks-ass.net>
 <20180914114725.GB17042@krava>
 <20180914120129.GJ24124@hirez.programming.kicks-ass.net>
 <20180914121307.GA98534@gmail.com>
 <20180914121940.GA9737@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180914121940.GA9737@krava>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Jiri Olsa <jolsa@redhat.com> wrote:

> On Fri, Sep 14, 2018 at 02:13:07PM +0200, Ingo Molnar wrote:
> > 
> > * Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > > On Fri, Sep 14, 2018 at 01:47:25PM +0200, Jiri Olsa wrote:
> > > > On Fri, Sep 14, 2018 at 01:15:28PM +0200, Peter Zijlstra wrote:
> > > > > On Fri, Sep 14, 2018 at 11:40:22AM +0200, Ingo Molnar wrote:
> > > > > > In fact keeping the files separate has scalability advantages for 'perf report' and similar 
> > > > > > parsing tools: they could read all the streams in a per-CPU fashion already, from the very 
> > > > > > beginning.
> > > > > 
> > > > > Also writing to different files from different CPUs is good for record,
> > > > > less contention on the inode state (which include pagecache).
> > > > 
> > > > maybe I should explain a little bit more on this
> > > > 
> > > > we write to different (per-cpu) files during the record,
> > > > and at the end of the session, we take them and store
> > > > them inside perf.data
> > > 
> > > How long does it take to combine that? If we generated a lot of data,
> > > that could take a fair amount of time, no?
> 
> yep.. fair amount ;-) wasn't that bad in my tests,
> but could be evil on some really big server

Also, adding any sort of 'global' processing to the end of a session sucks as a workflow 
principle: perf record should ideally be as lightweight as ftrace. It should trace and that's 
it - the processing should be done at the report phase. Shuffling hundreds of megs or gigs 
around at the end of the session is really bad.

> > Agreed - plus at the report stage it would be advantageous to be able to *read* per-cpu files 
> > as well.
> > 
> > If we do things smartly them report will create similar NUMA affinity as the record session 
> > used.
> 
> ok, separate files it is

Thanks!!

	Ingo
