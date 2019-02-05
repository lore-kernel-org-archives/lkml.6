Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2CEC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 496F0207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549374581;
	bh=V7kwdb4gQrDIDihaB4vBZmN6lY0pPce40PaWsxRpLOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Fcc2+ok0M3RY0x28quuXoWuqR4SiDdiUaqHV7WMBpuEgMpyyIOf/5SkyH25EYNV+W
	 /JqXaPMVP7peN+lSN3KKJHxs6q963wI9gIbOUkCXE0732GvqnoDCrcO5Q5pMus1J+R
	 wLchfbYAyM+6mZwNReKq47aN/+brdm8bUcu2LKxo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729353AbfBENtj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 08:49:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:40274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbfBENtj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 08:49:39 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FCFB207E0;
        Tue,  5 Feb 2019 13:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549374578;
        bh=V7kwdb4gQrDIDihaB4vBZmN6lY0pPce40PaWsxRpLOg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MmiCUQoCt86kjKPyIbU9BPFp7V9eeo/rmvUdQgFy1ZIJ6Ek5J0qzaQdPXh523NmSx
         TcRElvBUsiA+3OZek2vXTq99Fz0rcrXDpQA437UnXl5oJz3uXBqC6zLqFILdBPUY/t
         XlH2S9Rxocksdv95HX82yEEM9aDCioOLohBePTYM=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2E71F4034F; Tue,  5 Feb 2019 10:49:35 -0300 (-03)
Date:   Tue, 5 Feb 2019 10:49:35 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Tony Jones <tonyj@suse.de>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: perf: python3 + tests attr.py failing
Message-ID: <20190205134935.GB10613@kernel.org>
References: <20190204151042.GH5593@kernel.org>
 <20190204203738.GE4794@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204203738.GE4794@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Feb 04, 2019 at 09:37:38PM +0100, Jiri Olsa escreveu:
> On Mon, Feb 04, 2019 at 12:10:42PM -0300, Arnaldo Carvalho de Melo wrote:
> > Noticed this now when building with PYTHON=python3, can you take a look?
> > For now I'm reinstalling python2-devel and building with it, i.e.
> > removing that PYTHON=python3 make command line variable.
> > 
> > [root@quaco ~]# perf test -v perf_event_attr
> > 16: Setup struct perf_event_attr                          :
> > --- start ---
> > test child forked, pid 23937
> >   File "/home/acme/libexec/perf-core/tests/attr.py", line 325
> >     except Unsup, obj:
> >                 ^
> > SyntaxError: invalid syntax
> > test child finished with -1
> > ---- end ----
> > Setup struct perf_event_attr: FAILED!
> 
> hum, I built the same way like you 'make PYTHON=python3'
> [root@krava perf]# ldd ./perf | grep python
>         libpython3.6m.so.1.0 => /lib64/libpython3.6m.so.1.0 (0x00007f4ca7cc4000)
> 
> and get 'Ok result'
> 
> [root@krava perf]# ./perf test attr
> 16: Setup struct perf_event_attr                          : Ok
> 48: Synthesize attr update                                : Ok
> 
> 
> [root@krava perf]# python3 --version
> Python 3.6.8
> [root@krava perf]# rpm -qa | grep python3-devel
> python3-devel-3.6.8-1.fc28.x86_64
> 
> which Fedora are you on 29? I'm on 28

I think you tested perf/core, that has Tony's fix to make 'perf test perf_event_attr'
work with both python2 and python3, right?

While I was having that failure with perf/urgent.

I just cherry-picked:

commit 35ea7e4bbb89ecd32057f5f6a2a8feb0d7224e51
Author: Tony Jones <tonyj@suse.de>
Date:   Wed Jan 23 16:52:29 2019 -0800

    perf script python: Add Python3 support to tests/attr.py


----------------------

And now my perf/urgent branch passes that 'perf test' entry with both
python2 and 3.

- Arnaldo
