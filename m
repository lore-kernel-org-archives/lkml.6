Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73877C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 07:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97425208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 07:28:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97425208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732846AbeKTRz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 12:55:57 -0500
Received: from mga07.intel.com ([134.134.136.100]:50623 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726840AbeKTRz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 12:55:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Nov 2018 23:28:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,256,1539673200"; 
   d="scan'208";a="109595786"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.72.61])
  by fmsmga001.fm.intel.com with ESMTP; 19 Nov 2018 23:28:14 -0800
From:   Jani Nikula <jani.nikula@intel.com>
To:     Joe Perches <joe@perches.com>, Julia Lawall <julia.lawall@lip6.fr>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     ksummit-discuss@lists.linuxfoundation.org,
        "linux-nvdimm\@lists.01.org" <linux-nvdimm@lists.01.org>,
        vishal.l.verma@intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stfrench@microsoft.com, Greg KH <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Tobin C. Harding" <me@tobin.cc>
Subject: Re: [Ksummit-discuss] [RFC PATCH 2/3] MAINTAINERS, Handbook: Subsystem Profile
In-Reply-To: <f08820b05467cc95cc195a2639595c0274c95d69.camel@perches.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <154225759358.2499188.15268218778137905050.stgit@dwillia2-desk3.amr.corp.intel.com> <154225760492.2499188.14152986544451112930.stgit@dwillia2-desk3.amr.corp.intel.com> <alpine.DEB.2.21.1811142146230.9620@hadrien> <CAMuHMdVmvCOX6gF0BskQ1NBUpdMZHSBQXpxkx085B9ZKGm0wiA@mail.gmail.com> <alpine.DEB.2.21.1811150544090.2354@hadrien> <878t1tgpk8.fsf@intel.com> <f08820b05467cc95cc195a2639595c0274c95d69.camel@perches.com>
Date:   Tue, 20 Nov 2018 09:28:46 +0200
Message-ID: <875zwsgqc1.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Nov 2018, Joe Perches <joe@perches.com> wrote:
> On Fri, 2018-11-16 at 14:44 +0200, Jani Nikula wrote:
>> I quickly cooked up this script to produce the top-5 commit prefixes for
>> the given files over the arbitrary last 200 commits. It'll give you a
>> pretty good idea if you're even close.
>> 
>> ---
>> #!/bin/sh
>> # usage: subject-prefix FILE [...]
>> # show top 5 subject prefixes for FILEs
>> 
>> git log --format=%s -n 200 -- "$@" |\
>> 	grep -v "^Merge " |\
>> 	sed 's/\(.*\):.*/\1/' |\
>> 	sort | uniq -c | sort -nr | sed 's/ *[0-9]\+ //' |\
>> 	head -n 5
>> ---
>> 
>> Someone who knows perl could turn that into a checkpatch check: See if
>> the patch subject prefix is one of the top-5 for all files changed by
>> the patch, and ask the user to double check if it isn't. Or some
>> heuristics thereof.
>
> This won't work when a patch contains multiple files
> from different paths, or even multiple files from a
> single driver.

*shrug*

You can give it multiple files as argument, and it'll give you an
approximation of what the prefix could be, whether you're way off or
not. Close enough at least for the single driver case. Obviously not
perfect, but hey, it took me all of five minutes to write that. ;)

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
