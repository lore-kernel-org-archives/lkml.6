Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D4CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF458217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g5aLtBwX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbfBZOUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 09:20:25 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37249 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbfBZOUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 09:20:24 -0500
Received: by mail-qk1-f195.google.com with SMTP id m9so7640535qkl.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 06:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O2h1MY/nFFbkrutD6v76WKjrrVDrEVfs31jKmeZT7tw=;
        b=g5aLtBwXLqGbGf7eXrnKj5aWnCFTvV2L53xKP3dpsTwL5hJrNiXy9YKyWO1wFxB9Tf
         E/Vz70UAvOwKELL5ZxXl5yHcq9GJGm4OrZ7+DqPYvgB14tMrE7vz6oNdXDlI/HdXUSoy
         /P7Xb2Vicvkcd6xHGHHL0oEadt+nBmUMErhRYuk/n7QTgI5T+aaRK2c/DgNDdX2NQ8uh
         QB8iT9r60nFQjiKVhynl/k6jC3eapW7cvjuPaNlws5RAGkllhoAIJfIn7Ws9wPpCMIbC
         6eFkaV8oNxmaZ6uRWdPU0er8012pcGZUqBdS9NnfwGCYil/DzE6aaupEgucwP1MTYvqG
         bbwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O2h1MY/nFFbkrutD6v76WKjrrVDrEVfs31jKmeZT7tw=;
        b=PM2vxlt7AcN78NBedQ/n09UTuKParO5VeZUVNvTFQZ2COJnooqCtCFk3ga8IzLgKsc
         yDV+X9pad4dfORisShz/4o1MOEPzn4W+tZ/zpC+lSwbzTH/qSSxWPgl4pNRxlF6MK+Ji
         fwBLrtdhIzhsryFRDjkOtlat9KYTX2rTwwdNuyyA7JfSR14vJkXEzD+8RnbqEPFfCfMl
         AtnxOS+qrTUQT8+lvPYLrFIcOx6vxdqeiqpHMzBqPMcmZVd3i+jbbqjC9uiq+osTc+Us
         OPQfeHQX+0F+XZarr6V+FENioA3ZrQwUzZn3LvWWYVMjSvSspL7OknFN6ezJINCnJulu
         9lYw==
X-Gm-Message-State: AHQUAub8Bpyk/0GpvyGlyUm/ZrSBe4ZENCtfMXaA6o9S71OHoOApkTmb
        h7VCPAwAoF4NDxii4f/5Lt0=
X-Google-Smtp-Source: AHgI3IZE3xjOGV2w0Ce245ds/z0r47CjDVr+MoYZsmKjZGgFjABk3x14QQuud0p7p6Q8XIOmwHGT4w==
X-Received: by 2002:a37:4fd5:: with SMTP id d204mr17266546qkb.90.1551190823406;
        Tue, 26 Feb 2019 06:20:23 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id v18sm7003224qkj.13.2019.02.26.06.20.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Feb 2019 06:20:22 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3353F41104; Tue, 26 Feb 2019 11:20:09 -0300 (-03)
Date:   Tue, 26 Feb 2019 11:20:09 -0300
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        luto@kernel.org, Jiufei Xue <jiufei.xue@linux.alibaba.com>,
        Xu Yu <xuyu@linux.alibaba.com>, peterz@infradead.org,
        mingo@redhat.com
Subject: Re: [bug report][stable] perf probe: failed to add events
Message-ID: <20190226142009.GC26786@kernel.org>
References: <1a4240a8-288b-45d0-073d-d5cb8f0c63eb@linux.alibaba.com>
 <20190226090505.GA24409@kroah.com>
 <c7ccd9cb-3a66-98a9-faa1-7ee5ed20ff88@linux.alibaba.com>
 <20190226130802.GA10343@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190226130802.GA10343@kroah.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Feb 26, 2019 at 02:08:02PM +0100, Greg KH escreveu:
> On Tue, Feb 26, 2019 at 08:32:34PM +0800, Joseph Qi wrote:
> > 
> > 
> > On 19/2/26 17:05, Greg KH wrote:
> > > On Tue, Feb 26, 2019 at 03:31:14PM +0800, Joseph Qi wrote:
> > >> Hi,
> > >>
> > >> I'm using kernel v4.19.24 and have found that there is an issue when
> > >> using perf probe to define a new dynamic tracepoint.
> > >>
> > >> $ perf probe -a handle_mm_fault
> > >> Failed to write event: Numerical result out of range
> > >>   Error: Failed to add events.
> > >>
> > >> I've also tried kernel v4.20, and it can pass.
> > > 
> > > Ick, has this ever worked on the 4.19 stable tree?  If so, any chance
> > > you can run 'git bisect' to find the offending commit?
> > > 
> > >From my test, v4.19.0 also has this issue.
> > Bisect locates that it is introduced by commit bf904d2762ee
> > "x86/pti/64: Remove the SYSCALL64 entry trampoline".
> 
> But that commit was in 4.20, not 4.19.  So if this never worked, it's
> not a regression?
> 
> confused,

Adrian, Ideas?

- Arnaldo
