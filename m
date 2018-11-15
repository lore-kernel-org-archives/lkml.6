Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C698C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 15:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF8C2223CB
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 15:33:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF8C2223CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388560AbeKPBlp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 20:41:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48438 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726432AbeKPBlp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 20:41:45 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E2FB930820CE;
        Thu, 15 Nov 2018 15:33:26 +0000 (UTC)
Received: from krava (unknown [10.40.205.128])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 16B305C26E;
        Thu, 15 Nov 2018 15:33:24 +0000 (UTC)
Date:   Thu, 15 Nov 2018 16:33:24 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, namhyung@kernel.org,
        ak@linux.intel.com
Subject: Re: [PATCH 1/2] perf vendor events: Add stepping in CPUID string for
 x86
Message-ID: <20181115153324.GM9600@krava>
References: <20181114212416.15665-1-kan.liang@linux.intel.com>
 <20181115135347.GI9600@krava>
 <7a63fdf4-828f-0685-e146-6d3d86d8655b@linux.intel.com>
 <58a3caa6-0ba9-773b-9f99-1e4be5ff77fb@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <58a3caa6-0ba9-773b-9f99-1e4be5ff77fb@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Thu, 15 Nov 2018 15:33:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 10:18:27AM -0500, Liang, Kan wrote:

SNIP

> > > > +int strcmp_cpuid_str(const char *mapcpuid, const char *cpuid)
> > > > +{
> > > > +    regex_t re;
> > > > +    regmatch_t pmatch[1];
> > > > +    int match;
> > > > +    bool full_mapcpuid = is_full_cpuid(mapcpuid);
> > > > +    bool full_cpuid = is_full_cpuid(cpuid);
> > > 
> > > cpuid will be always full from now right? why do we need to check it?
> > > 
> > 
> > User may set cpuid by environment string "PERF_CPUID", which may not be
> > full format.
> > 
> > > also please move this to arch/x86/util/pmu.c
> > > so it matches the weak function object
> > 
> > Sure.
> > 
> 
> It looks like both pmu.c and header.c have cpuid related functions.
> For example,
> get_cpuid_str() has weak function in pmu.c. It's declaration in header.h.
> It's x86 specific function in x86/util/header.c
> get_cpuid() has weak function in header.c. It's declaration in header.h.
> It's x86 specific function in x86/util/header.c
> 
> It looks like most of the cpuid related functions are in header.c/h.
> I think it may be better to move all the cpuid related functions to
> header.c/h.
> 
> If it's OK for you, I will send a clean up patch later to move the weak
> functions strcmp_cpuid_str() and get_cpuid_str() to header.c
> 
> What do you think?

sounds good, thanks

jirka
