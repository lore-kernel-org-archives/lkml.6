Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99DC6C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5414D2172C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IPll9i4C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5414D2172C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbeHTTa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 15:30:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:34246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbeHTTa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 15:30:27 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4D882170E;
        Mon, 20 Aug 2018 16:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534781652;
        bh=Mkl0y1Vpf8XzCB9OnivY/ks/MUhwwf+R17HlViP5P70=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IPll9i4Cu+Wsjp19AjwgG7r+dpU7xkcQiksLIoI78u8j0TX+7XloXJFIM3vgFWpTl
         y5DrMoJhAa9uL4A5euZPzJEZTqyAIEA4bECufcnsij5ipUKVLhDgsc4/59f8OHN8zm
         86YtklnA4wl54yhCrMDWEcTSYJERoHDMJ/+1dBvY=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 3FD73141C3F; Mon, 20 Aug 2018 13:14:10 -0300 (-03)
Date:   Mon, 20 Aug 2018 13:14:10 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Thiago Macieira <thiago.macieira@intel.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Yordan Karadzhov <y.karadz@gmail.com>,
        Linux Trace Devel <linux-trace-devel@vger.kernel.org>
Subject: Re: libtracevent build warnings on Clear Linux (gcc 8.2.0)
Message-ID: <20180820161410.GD21100@kernel.org>
References: <20180820133943.GB21100@kernel.org>
 <1800559.mKxvYeAo7o@tjmaciei-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1800559.mKxvYeAo7o@tjmaciei-mobl1>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Aug 20, 2018 at 08:53:05AM -0700, Thiago Macieira escreveu:
> On Monday, 20 August 2018 06:39:43 PDT Arnaldo Carvalho de Melo wrote:
> > Hi guys,
> 
> Hello
> 
> > Makefile.config:318: No libelf found. Disables 'probe' tool, jvmti and BPF
> > support in 'perf record'. Please install libelf-dev, libelf-devel or
> > elfutils-libelf-devel
> 
> You may want to install the user-basic-dev bundle.

Thanks, I'll add that one
 
> > Makefile.config:518: Disabling post unwind, no support found.
> 
> Also present in user-basic-dev.
> 
> > Makefile.config:598: slang not found, disables TUI support. Please install
> > slang-devel, libslang-dev or libslang2-dev
> 
> Ditto.
> 
> > Makefile.config:612: GTK2 not found, disables GTK2 support. Please install
> > gtk2-devel or libgtk2.0-dev
> 
> This one is in desktop-dev. We don't have that enabled in our own build of 
> perf, though.
> 
> > Makefile.config:666: No python interpreter was found: disables Python
> > support - please install python-devel/python-dev
> 
> user-basic-dev too. We're almost rid of Python 2, do you need it?

Nope, patches to make perf build with python3 (while still building with
python2, if that is what is available) were already merged, IIRC.
 
> > Makefile.config:750: No liblzma found, disables xz kernel module
> > decompression, please install xz-devel/liblzma-dev
> 
> Assuming xz is sufficient for this, user-basic-dev.

ok
 
> > Makefile.config:814: No libbabeltrace found, disables 'perf data' CTF format
> > support, please install libbabeltrace-dev[el]/libbabeltrace-ctf-dev
> 
> user-basic-dev too.

Cool, now the avx2 thingy.

- Arnaldo
