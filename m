Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E796C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46041218FF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:12:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731462AbfBOSM0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 13:12:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38808 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725835AbfBOSMZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 13:12:25 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B59E130EF62;
        Fri, 15 Feb 2019 18:12:25 +0000 (UTC)
Received: from krava (unknown [10.43.17.23])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3861F5C21E;
        Fri, 15 Feb 2019 18:12:24 +0000 (UTC)
Date:   Fri, 15 Feb 2019 19:12:23 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH 09/10] perf tools: Add perf_topo_cpu object
Message-ID: <20190215181223.GA8393@krava>
References: <20190213123246.4015-1-jolsa@kernel.org>
 <20190213123246.4015-10-jolsa@kernel.org>
 <20190213211935.GH1904@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213211935.GH1904@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Fri, 15 Feb 2019 18:12:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 06:19:35PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, Feb 13, 2019 at 01:32:45PM +0100, Jiri Olsa escreveu:
> > Making struct cpu_topo global and renaming it to
> > struct perf_topo_cpu, so it can be used from record
> > command in following patches.
> > 
> > Adding following interface functions to load/free
> > cpu topology details:
> >   struct perf_topo_cpu *perf_topo_cpu__new(void);
> >   void perf_topo_cpu__free(struct perf_topo_cpu *tp);
> > 
> > Moving it into separate object file cputopo.c together
> > with numa related object in following patches.
> > 
> > No functional change, the new interface will be used
> > in upcoming changes.
> 
> Please rename it to 'struct cpu_topology' and make its related functions
> be cpu_topology__new, the __free() should be __delete() since it doesn't
> just free its members, but deletes itself as well.
> 
> I think this is not perf specific at all, so no need for the 'perf'
> prefix.

ok, will do

jirka
