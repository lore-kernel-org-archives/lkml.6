Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EEA4C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 13:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFB37218CD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 13:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548424656;
	bh=nOZ44cpuU6o5g8UPqeCA7flOdxL1BFBwyhbj2ZkAO4I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=b2AjORLjxSWQ2mr/3qKzgSulM2uDyzsI90gsIrGNN03DPrxzh6cOQ/js4dPQg8haF
	 GAkSN9WJvdjHOtLRPUBgOrjftdfHoz/Imlc2Lf2j8gk2KyKtIWRI1pLRdVdEU061bF
	 NqVvfdygkJ3BZlmbAUnx9iaJwt24CpamLNzf5dFI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728751AbfAYN5e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 08:57:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:45802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726095AbfAYN5e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 08:57:34 -0500
Received: from quaco.ghostprotocols.net (unknown [147.229.117.36])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E2B6218CD;
        Fri, 25 Jan 2019 13:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548424652;
        bh=nOZ44cpuU6o5g8UPqeCA7flOdxL1BFBwyhbj2ZkAO4I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XVRnbQmb/IBwDYR4Bad85ZeD7VJE0NV33JK1tjB8iIN/81Z27LVKFfiBiwqura9Kj
         LjQBeoT3Ww0GiZ/xDaUclIGBOlDB3w4Jle7bZLWfWS6kCwV3wVkCs1ponaA/+n2E2l
         652QH05/DP0KNSaY9Sqv9zEkjO2MvcJPOXxaS8tA=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 26E014034F; Fri, 25 Jan 2019 14:57:30 +0100 (CET)
Date:   Fri, 25 Jan 2019 14:57:30 +0100
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Tony Jones <tonyj@suse.de>
Cc:     linux-kernel@vger.kernel.org,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 0/6] Fix issues with Python3 scripting
Message-ID: <20190125135730.GE12077@kernel.org>
References: <20190124005229.16146-1-tonyj@suse.de>
 <20190125123119.GD12077@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190125123119.GD12077@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jan 25, 2019 at 01:31:19PM +0100, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Jan 23, 2019 at 04:52:23PM -0800, Tony Jones escreveu:
> > Seeteena posted, earlier this week, some patches to add Python3 support
> > to scripts/python/*.py.  Unfortunately there were some issues with these
> > patches (such as: https://lkml.org/lkml/2019/1/17/351)
> > 
> > Since I already had a tested set of patches in openSUSE:Factory and 
> > SLE15-SP1 and was about to submit them, Seeteena and I that agreed I 
> > should post my patches not involving scripts/python/*.py and Seeteena 
> > will later resubmit the patches for scripts/python/*.py incorporating 
> > my review feedback under a joint signed-off-by.
> > 
> > It should be noted that the use of "from __future__ import print_function" 
> > (see: https://lkml.org/lkml/2019/1/16/641) and "except as" (see change to:
> > tests/attr.py) implies Python2 >= 2.6 as the necessary support has not 
> > been backported to prior versions.  I am not sure if it's worth detecting 
> > <2.6 at build time or whether it's sufficiently old as to be a non-issue?
> > 
> > The shebang changes were driven mostly by our build process as it scans
> > all files within an rpm and the shebangs would result in a rpm requires
> > on the python2 binary when BuildRequires was python3-devel. I think they 
> > make sense to apply upstream but understand totally if it's prefered we 
> > keep them local.
> > 
> > These changes have been tested with PYTHON=python2 (v2.7) and 
> > PYTHON=python3 (v3.6) on latest openSUSE Tumbleweed.  I did notice that 
> > test #18 "'import perf' in python" is failing on my system without these 
> > changes. I'll look at it further but didn't want to hold up Seeteena's 
> > resubmit.
> 
> So it fails on AmazonLinux 1, that has python 2.6, please check if this
> is something we can workaround, if its difficult, I'll just use
> NO_PYTHON=1 there to disable it.
> 
>   CC       /tmp/build/perf/util/parse-branch-options.o
> util/scripting-engines/trace-event-python.c: In function 'python_start_script':
> util/scripting-engines/trace-event-python.c:1520:2: error: passing argument 1 of 'PyImport_AppendInittab' discards 'const' qualifier from pointer target type [-Werror]
>   PyImport_AppendInittab("perf_trace_context", initfunc);
>   ^
> In file included from /usr/include/python2.6/Python.h:130:0,
>                  from util/scripting-engines/trace-event-python.c:22:
> /usr/include/python2.6/import.h:54:17: note: expected 'char *' but argument is of type 'const char *'
>  PyAPI_FUNC(int) PyImport_AppendInittab(char *name, void (*initfunc)(void));
>                  ^
> cc1: all warnings being treated as errors
> mv: cannot stat '/tmp/build/perf/util/scripting-engines/.trace-event-python.o.tmp': No such file or directory
> make[5]: *** [/tmp/build/perf/util/scripting-engines/trace-event-python.o] Error 1

I did a quick hack to init an auto variable with that const string and
then pass it, is passing everything so far:

$ dm
   1 alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.3.0
   2 alpine:3.5                    : Ok   gcc (Alpine 6.2.1) 6.2.1 20160822
   3 alpine:3.6                    : Ok   gcc (Alpine 6.3.0) 6.3.0
   4 alpine:3.7                    : Ok   gcc (Alpine 6.4.0) 6.4.0
   5 alpine:3.8                    : Ok   gcc (Alpine 6.4.0) 6.4.0
   6 alpine:edge                   : Ok   gcc (Alpine 8.2.0) 8.2.0
   7 amazonlinux:1                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-28)
   8 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180303 (Red Hat 7.3.1-5)
   9 android-ndk:r12b-arm          : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1)
  10 android-ndk:r15c-arm          : Ok   gcc (GCC) 8.2.1 20181215 (Red Hat 8.2.1-6)
  11 centos:5                      : Ok   gcc (GCC) 4.1.2 20080704 (Red Hat 4.1.2-55)
  12 centos:6                      : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23)
  13 centos:7                      : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-36)
  14 clearlinux:latest             : Ok   gcc (Clear Linux OS for Intel Architecture) 8.2.1 20180502
  15 debian:7                      : Ok   gcc (Debian 4.7.2-5) 4.7.2
  16 debian:8                      : Ok   gcc (Debian 4.9.2-10+deb8u2) 4.9.2
  17 debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516
  18 debian:experimental           : Ok   gcc (Debian 8.2.0-13) 8.2.0
  19 debian:experimental-x-arm64   : Ok   gcc (Debian 8.2.0-13) 8.2.0
  20 debian:experimental-x-mips    : Ok   gcc (Debian 8.2.0-13) 8.2.0
  21 debian:experimental-x-mips64  : Ok   gcc (Debian 8.2.0-13) 8.2.0
  22 debian:experimental-x-mipsel  : Ok   gcc (Debian 8.2.0-13) 8.2.0
  23 fedora:20                     : Ok   gcc (GCC) 4.8.3 20140911 (Red Hat 4.8.3-7)
  24 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
  25 fedora:23                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
  26: fedora:24
