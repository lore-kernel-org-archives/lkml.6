Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE57C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F57B2054F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549373332;
	bh=jHx05EamNppb8gjVD9pULoluEoQUurGVw04xMYzzlvw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AhlX9WaqMcW32XJK5/V2rD1lyJeNksj3eLW/UpTw+QFQpkOx6TsPB7dL0hdcJ/ZXj
	 FiU0pROfH0rCzPU63L4l0gV5EkXXFb47U3WBuQtfWS6BjxvCjiHo6Evq/+OtBkcEai
	 54KQxCvvS9vgJ4DOebf8xWSGuXe++R/o5h8uwYJE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbfBEN2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 08:28:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:35570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726484AbfBEN2u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 08:28:50 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93B5D20844;
        Tue,  5 Feb 2019 13:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549373329;
        bh=jHx05EamNppb8gjVD9pULoluEoQUurGVw04xMYzzlvw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TcdHA87xBFK428fqM5/d+ZtDpmyXwkCcKOAs6P8mnSgUDmhx6IsfEQbUQRkWsFzrs
         8Agxqyj/z1sGUJJ8/Yqnozl43bmZX3emeo5h0jHnepSeu3LJjCDYCigc9Lqp9Evrrq
         9iEvQN9378Y2F3bt9andFop2N4sXXSgHPkfXLGIA=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6444D4034F; Tue,  5 Feb 2019 10:28:46 -0300 (-03)
Date:   Tue, 5 Feb 2019 10:28:46 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Tony Jones <tonyj@suse.de>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: perf: python3 + tests attr.py failing
Message-ID: <20190205132846.GO5593@kernel.org>
References: <20190204151042.GH5593@kernel.org>
 <20190204203738.GE4794@krava>
 <20190205130214.GM5593@kernel.org>
 <20190205130843.GN5593@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190205130843.GN5593@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Feb 05, 2019 at 10:08:43AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Feb 05, 2019 at 10:02:14AM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Mon, Feb 04, 2019 at 09:37:38PM +0100, Jiri Olsa escreveu:
> > > On Mon, Feb 04, 2019 at 12:10:42PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > Noticed this now when building with PYTHON=python3, can you take a look?
> > > > For now I'm reinstalling python2-devel and building with it, i.e.
> > > > removing that PYTHON=python3 make command line variable.
> > > which Fedora are you on 29? I'm on 28
>  
> > [acme@quaco ~]$ cat /etc/fedora-release 
> > Fedora release 29 (Twenty Nine)
>  
> > [acme@quaco tumbleweed]$ rpm -qa | grep python3 | wc -l
> > 96
> > [acme@quaco tumbleweed]$ rpm -q python3-devel
> > python3-devel-3.7.2-4.fc29.x86_64
> > [acme@quaco tumbleweed]$ 
> > 
> > But it is a SyntaxError, so something simpler, looking up...
> 
> So python 3 needs to have that as:
> 
> 	except Unsup as obj:
> 
> How to make this work with both is what I'm trying to figure out now...

So, all this is fixed in perf/core already by:

commit 35ea7e4bbb89ecd32057f5f6a2a8feb0d7224e51
Author: Tony Jones <tonyj@suse.de>
Date:   Wed Jan 23 16:52:29 2019 -0800

    perf script python: Add Python3 support to tests/attr.py
    
    Support both Python 2 and Python 3 in tests/attr.py
    
    The use of "except as" syntax implies the minimum supported Python2 version is
    now v2.6

 ------------------

 So nevermind, sorry for the noise :-)

- Arnaldo
