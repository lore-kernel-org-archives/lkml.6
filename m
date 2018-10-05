Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F05C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55DDC213A2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="r2X0SMKX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55DDC213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728569AbeJEXJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:09:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:48726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727572AbeJEXJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:09:22 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CC2A20834;
        Fri,  5 Oct 2018 16:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538755800;
        bh=f4xMEZI7jN3lyylBo2PQMWS8kXK/g/je44IPfcBvFP8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r2X0SMKXUZioQ6bDOy63lx7KvSy2y1UhuxDu+7mgBBRIPjoYjN07O4WklUbBk6j2k
         mLo+DemGReUvbjTvKRFCWkZgflvhcKdJi9p4+sXzAfe1vK10hJCC1KuMjvSPf8MsV8
         5UAKZD4nO4kiXkxK7RsBvdRyaY8L+7LcqsVbNJW4=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id F2225141DDC; Fri,  5 Oct 2018 13:09:57 -0300 (-03)
Date:   Fri, 5 Oct 2018 13:09:57 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Linux Trace Devel <linux-trace-devel@vger.kernel.org>,
        Colin Patrick McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: [PATCH v3] tools/lib/traceevent: Replace str_error_r() with an
 open coded implementation
Message-ID: <20181005160957.GE20250@kernel.org>
References: <20181002175539.2ac894c7@gandalf.local.home>
 <20181005113056.55b23c31@gandalf.local.home>
 <20181005153731.GC20250@kernel.org>
 <20181005114516.68f47767@gandalf.local.home>
 <20181005154740.GD20250@kernel.org>
 <20181005115843.46155df8@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181005115843.46155df8@gandalf.local.home>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Oct 05, 2018 at 11:58:43AM -0400, Steven Rostedt escreveu:
> On Fri, 5 Oct 2018 12:47:40 -0300 Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > Yep, I've been looking at these. I'll need to add yet another version,
> > > so that we can have it for the external libtraceevent. I'll be sending
> > > out a patch shortly.  
> > 
> > Unfortunately, yes, due to licensing and because we don't have a
> > liblinux with the things in tools/lib/*.c, we need to relicense that as
> > at least LGPL 2.1 :-\
> > 
> > Lets start here, whoever reads this message, would you have a problem
> > with relicensing what is in tools/lib/*.c and tools/lib/api/ as LGPL
> > 2.1?
> > 
> 
> All of the libtraceeevent code was already licensed as LGPL 2.1 to
> begin with. It was taken from trace-cmd which had that as LGPL as well.

yes, sure, you did it right :-)

- Arnaldo
