Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C3A1C282CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD15F217D6
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549372129;
	bh=d1L1iyBTcuF5EbS4gOmeW0JsYu299+Fo0IRyVvR4CVc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=i+IMGZ8kLCBVzK8iUyhSCZSsFNWGbwM4k+ZUJ9wY+89j61WWUWZjoRCTCAw9eKyqR
	 x4K9Fpm0PQ6fQ8NAq/ir2DsgPgPPOGtbfB7p/+iuaejZBjnrLHiTjyglmlMosucM3y
	 g42t65aGXSnDBsggaUWy7svD+1QE9rB9in4+RtQU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbfBENIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 08:08:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:56646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728595AbfBENIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 08:08:47 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9B8B20844;
        Tue,  5 Feb 2019 13:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549372127;
        bh=d1L1iyBTcuF5EbS4gOmeW0JsYu299+Fo0IRyVvR4CVc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZVeLXt6iYJBCfpzBCvgd1cLGK9YthFDrRsOiDlz0gEJcJy9L130FxXJDaXZnMS2y4
         9nkGLdjVi/iMa/61PNBwjM8ThNJszAYnUqIStBpZ8Xaj7axXecG/VV9yCezSwU99TF
         OXFInsjNkHRcxZTLezBODxsw6yPP0ELa3t3WVcYg=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C983E4034F; Tue,  5 Feb 2019 10:08:43 -0300 (-03)
Date:   Tue, 5 Feb 2019 10:08:43 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Tony Jones <tonyj@suse.de>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: perf: python3 + tests attr.py failing
Message-ID: <20190205130843.GN5593@kernel.org>
References: <20190204151042.GH5593@kernel.org>
 <20190204203738.GE4794@krava>
 <20190205130214.GM5593@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190205130214.GM5593@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Feb 05, 2019 at 10:02:14AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Feb 04, 2019 at 09:37:38PM +0100, Jiri Olsa escreveu:
> > On Mon, Feb 04, 2019 at 12:10:42PM -0300, Arnaldo Carvalho de Melo wrote:
> > > Noticed this now when building with PYTHON=python3, can you take a look?
> > > For now I'm reinstalling python2-devel and building with it, i.e.
> > > removing that PYTHON=python3 make command line variable.
> > which Fedora are you on 29? I'm on 28
 
> [acme@quaco ~]$ cat /etc/fedora-release 
> Fedora release 29 (Twenty Nine)
 
> [acme@quaco tumbleweed]$ rpm -qa | grep python3 | wc -l
> 96
> [acme@quaco tumbleweed]$ rpm -q python3-devel
> python3-devel-3.7.2-4.fc29.x86_64
> [acme@quaco tumbleweed]$ 
> 
> But it is a SyntaxError, so something simpler, looking up...

So python 3 needs to have that as:

	except Unsup as obj:

How to make this work with both is what I'm trying to figure out now...

 
> - Arnaldo
>  
> > jirka
> > 
> > > [root@quaco ~]# find
> > > 
> > > Reverting back to building with python2-devel makes it work:
> > > 
> > > make O=/tmp/build/perf -C tools/perf install-bin
> > > 
> > > [acme@quaco perf]$ ldd ~/bin/perf | grep python
> > > 	libpython2.7.so.1.0 => /lib64/libpython2.7.so.1.0 (0x00007fe283792000)
> > > [acme@quaco perf]$
> > > 
> > > [root@quaco ~]# perf test perf_event_attr
> > > 16: Setup struct perf_event_attr                          : Ok
> > > [root@quaco ~]#
> > > 
> > > - Arnaldo
> 
> -- 
> 
> - Arnaldo

-- 

- Arnaldo
