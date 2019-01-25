Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF5DDC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84F9E2146E
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548419484;
	bh=req2DWeINf2sHwaiVPbegwHPBqhGB/aCM9FphK49bjA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=a/SZ4OzsLt+G3WtG7GnSK9561cuILw647MTtTgWc20dFzh5UQ7tGFU6VWb1jslQ7w
	 GzTHY3EaIF14xYQ+vrP044swwP6iSgv0HQeqeA4xGKN4sq060arAVNyJi5M7JAG+Jk
	 k1AreHJfMvQgsTzP74ucxeUaXfY3HhWRAPjoo3b8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfAYMbW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 07:31:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:39522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbfAYMbW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 07:31:22 -0500
Received: from quaco.ghostprotocols.net (unknown [147.229.117.36])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE51E2146E;
        Fri, 25 Jan 2019 12:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548419481;
        bh=req2DWeINf2sHwaiVPbegwHPBqhGB/aCM9FphK49bjA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yx2eDzya7ETm/VGvmD5mEje72QRnmUD4+/gHn6voAH+tBlepmXTQ+8sAypDIdFS2B
         0dxtRnYHNEGUtdtzuTUpFTKd6nO9kF8qt5ZJNWMV8NS/at6+gCNEIJ7PJmeW4tT3ja
         OxExAfstWgnzoyv24fq++Cgr+td/Jh/kPyU0bNto=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 23B954034F; Fri, 25 Jan 2019 13:31:19 +0100 (CET)
Date:   Fri, 25 Jan 2019 13:31:19 +0100
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Tony Jones <tonyj@suse.de>
Cc:     linux-kernel@vger.kernel.org,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 0/6] Fix issues with Python3 scripting
Message-ID: <20190125123119.GD12077@kernel.org>
References: <20190124005229.16146-1-tonyj@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124005229.16146-1-tonyj@suse.de>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jan 23, 2019 at 04:52:23PM -0800, Tony Jones escreveu:
> Seeteena posted, earlier this week, some patches to add Python3 support
> to scripts/python/*.py.  Unfortunately there were some issues with these
> patches (such as: https://lkml.org/lkml/2019/1/17/351)
> 
> Since I already had a tested set of patches in openSUSE:Factory and 
> SLE15-SP1 and was about to submit them, Seeteena and I that agreed I 
> should post my patches not involving scripts/python/*.py and Seeteena 
> will later resubmit the patches for scripts/python/*.py incorporating 
> my review feedback under a joint signed-off-by.
> 
> It should be noted that the use of "from __future__ import print_function" 
> (see: https://lkml.org/lkml/2019/1/16/641) and "except as" (see change to:
> tests/attr.py) implies Python2 >= 2.6 as the necessary support has not 
> been backported to prior versions.  I am not sure if it's worth detecting 
> <2.6 at build time or whether it's sufficiently old as to be a non-issue?
> 
> The shebang changes were driven mostly by our build process as it scans
> all files within an rpm and the shebangs would result in a rpm requires
> on the python2 binary when BuildRequires was python3-devel. I think they 
> make sense to apply upstream but understand totally if it's prefered we 
> keep them local.
> 
> These changes have been tested with PYTHON=python2 (v2.7) and 
> PYTHON=python3 (v3.6) on latest openSUSE Tumbleweed.  I did notice that 
> test #18 "'import perf' in python" is failing on my system without these 
> changes. I'll look at it further but didn't want to hold up Seeteena's 
> resubmit.

So it fails on AmazonLinux 1, that has python 2.6, please check if this
is something we can workaround, if its difficult, I'll just use
NO_PYTHON=1 there to disable it.

  CC       /tmp/build/perf/util/parse-branch-options.o
util/scripting-engines/trace-event-python.c: In function 'python_start_script':
util/scripting-engines/trace-event-python.c:1520:2: error: passing argument 1 of 'PyImport_AppendInittab' discards 'const' qualifier from pointer target type [-Werror]
  PyImport_AppendInittab("perf_trace_context", initfunc);
  ^
In file included from /usr/include/python2.6/Python.h:130:0,
                 from util/scripting-engines/trace-event-python.c:22:
/usr/include/python2.6/import.h:54:17: note: expected 'char *' but argument is of type 'const char *'
 PyAPI_FUNC(int) PyImport_AppendInittab(char *name, void (*initfunc)(void));
                 ^
cc1: all warnings being treated as errors
mv: cannot stat '/tmp/build/perf/util/scripting-engines/.trace-event-python.o.tmp': No such file or directory
make[5]: *** [/tmp/build/perf/util/scripting-engines/trace-event-python.o] Error 1

