Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C25BC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54E2C217D6
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549371740;
	bh=bfhShA8hDdp4lBQpi5/a4CfWivHpA46vp1FImn8n8rI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1oyZ4eJWjb2ckQHTw6EYK/URvYTAEPMYT0mrRVkBxWhmx32YCa6dIr+fw41ESLYRN
	 akybv0FhYrTkKlpWqYyrkjNZut0FbH52b9hfxMPzJD+u9BLUGRiObIaZkrtDou6sGX
	 dc7KlBi0TFZTg5wfwmHSTYXFDtTYQoy5QJzzpRkQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbfBENCS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 08:02:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:54158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725947AbfBENCS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 08:02:18 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2686420818;
        Tue,  5 Feb 2019 13:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549371737;
        bh=bfhShA8hDdp4lBQpi5/a4CfWivHpA46vp1FImn8n8rI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aMUPAZqMHYqj1ikz1so+UbxxB/ktXqeDfs1rLx0jcAwxvHRWcsvf8GomkQxl5v5tP
         qWQDSZ4y+l2Ulh7Z6OjD0QMFDRC6NQ815voYVXtoZH4rIFoZ1qWirNkjuW5Va4Jr4p
         ItpP6F2yI4I9bKuE64UmLhl4pGdJ35bsXgAfSW8k=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A313C4034F; Tue,  5 Feb 2019 10:02:14 -0300 (-03)
Date:   Tue, 5 Feb 2019 10:02:14 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Tony Jones <tonyj@suse.de>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: perf: python3 + tests attr.py failing
Message-ID: <20190205130214.GM5593@kernel.org>
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

[acme@quaco ~]$ cat /etc/fedora-release 
Fedora release 29 (Twenty Nine)

[acme@quaco tumbleweed]$ rpm -qa | grep python3 | wc -l
96
[acme@quaco tumbleweed]$ rpm -q python3-devel
python3-devel-3.7.2-4.fc29.x86_64
[acme@quaco tumbleweed]$ 

But it is a SyntaxError, so something simpler, looking up...

- Arnaldo
 
> jirka
> 
> > [root@quaco ~]# find
> > 
> > Reverting back to building with python2-devel makes it work:
> > 
> > make O=/tmp/build/perf -C tools/perf install-bin
> > 
> > [acme@quaco perf]$ ldd ~/bin/perf | grep python
> > 	libpython2.7.so.1.0 => /lib64/libpython2.7.so.1.0 (0x00007fe283792000)
> > [acme@quaco perf]$
> > 
> > [root@quaco ~]# perf test perf_event_attr
> > 16: Setup struct perf_event_attr                          : Ok
> > [root@quaco ~]#
> > 
> > - Arnaldo

-- 

- Arnaldo
