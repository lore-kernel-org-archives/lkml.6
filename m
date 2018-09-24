Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5502FC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 028542086B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LbRQdGR3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 028542086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730585AbeIXVXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:23:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:59086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728880AbeIXVXz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 17:23:55 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C45E720833;
        Mon, 24 Sep 2018 15:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537802474;
        bh=zEbS0U9LJFPlYdMMnSXeWGg5I+7X56BAwfIKpQrj4qo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LbRQdGR3mOMeRecf+ECcwgt2bMnTKT3RhRnoXcQ3K8v6+3+TDvUk+RELcRVX9Lydd
         KFAdS3HFk0IsQeEsx4Q0/0eDcDfrfNPDYznV6FFdjiccCPa08oqpMW1YcuTJdmXk8G
         kX4u7DNrBSupF5SSeu/5T8DAAzfOpv2OJX1grwMM=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id CAB6C1401A1; Mon, 24 Sep 2018 12:21:05 -0300 (-03)
Date:   Mon, 24 Sep 2018 12:21:05 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-trace-devel@vger.kernel.org,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Subject: Re: [PATCH 00/15] tools/lib/traceevent: Namespace updates to make
 traceevent into a library
Message-ID: <20180924152105.GC4640@kernel.org>
References: <20180919185643.358126338@goodmis.org>
 <20180923185626.GC30923@krava>
 <20180924045523.2c15be13@vmware.local.home>
 <20180924141632.GA4640@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180924141632.GA4640@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Sep 24, 2018 at 11:16:32AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Sep 24, 2018 at 04:55:23AM -0400, Steven Rostedt escreveu:
> > On Sun, 23 Sep 2018 20:56:26 +0200
> > Jiri Olsa <jolsa@redhat.com> wrote:

> > > is there still something left to rename, or we can start moving it into public rpm?

> > We're testing it as a external library, and we did find something. Did
> > you get this patch?

> >  https://lore.kernel.org/lkml/20180921152037.1e23c7f4@gandalf.local.home
 
> I'm finishing tests with the patchset before this last patch, will push
> to Ingo soon, then will check if the patch with the private copy of the
> strerror_r() wrapper passes on the systems that made that wrapper came
> to be, i.e. systems using the musl libc (https://www.musl-libc.org/).

Ok, it passes on these systems:

   1 alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.3.0
   2 alpine:3.5                    : Ok   gcc (Alpine 6.2.1) 6.2.1 20160822
   3 alpine:3.6                    : Ok   gcc (Alpine 6.3.0) 6.3.0
   4 alpine:3.7                    : Ok   gcc (Alpine 6.4.0) 6.4.0
   5 alpine:3.8                    : Ok   gcc (Alpine 6.4.0) 6.4.0
   6 alpine:edge                   : Ok   gcc (Alpine 6.4.0) 6.4.0

Which puzzled me, but then I saw that you guys are not using
strerror_r(), but strerror() that is not thread-safe, and then the
pitfalls with strerror_r() XSI/_GNU_SOURCE problems are not hit.

This same problem happened with tools/lib/bpf/, and I fixed it in by
having a separate file to create the wrapper, where we make sure
_GNU_SOURCE is not defined and continue using strerror_r():

   https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/commit/?h=perf/urgent&id=6d41907c630d3196be89c9ed5a7f8258486b3eaf

I think it would be interesting to use something similar so that
libtraceevent becomes thread safe for this specific point.

For now I've applied the patch to my local perf/core branch, so that it
gets tested in more systems.

- Arnaldo
