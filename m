Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5814CC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25ADB21872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbfAXKjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 05:39:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35622 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725986AbfAXKjZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 05:39:25 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 04F0112E3;
        Thu, 24 Jan 2019 10:39:25 +0000 (UTC)
Received: from krava (ovpn-204-178.brq.redhat.com [10.40.204.178])
        by smtp.corp.redhat.com (Postfix) with SMTP id F363B6B8FB;
        Thu, 24 Jan 2019 10:39:22 +0000 (UTC)
Date:   Thu, 24 Jan 2019 11:39:22 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Tony Jones <tonyj@suse.de>
Cc:     linux-kernel@vger.kernel.org,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 0/6] Fix issues with Python3 scripting
Message-ID: <20190124103922.GB13852@krava>
References: <20190124005229.16146-1-tonyj@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124005229.16146-1-tonyj@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 24 Jan 2019 10:39:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 04:52:23PM -0800, Tony Jones wrote:
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

please try latest code from Arnaldo, we just had fix in that area

> test #18 "'import perf' in python" is failing on my system without these 
> changes. I'll look at it further but didn't want to hold up Seeteena's 
> resubmit.
> 
> Tony Jones (6):
>   perf script python: Add trace_context extension module to sys,modules
>   perf script python: Use PyBytes for attr in trace-event-python
>   perf script python: remove explicit shebang from setup.py
>   perf script python: remove explicit shebang from tests/attr.c
>   perf script python: remove explicit shebang from Python scripts
>   perf script python: add Python3 support to tests/attr.py

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka
