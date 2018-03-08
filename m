Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934157AbeCHNAf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 08:00:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:45350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755034AbeCHNAe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 08:00:34 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE38B205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Thu, 8 Mar 2018 10:00:31 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH 08/19] perf tools: Add mem2node object
Message-ID: <20180308130031.GB3701@kernel.org>
References: <20180307155020.32613-1-jolsa@kernel.org>
 <20180307155020.32613-9-jolsa@kernel.org>
 <20180307192736.GS3701@kernel.org>
 <20180308110306.GB13693@krava>
 <20180308125849.GA3701@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180308125849.GA3701@kernel.org>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Mar 08, 2018 at 09:58:49AM -0300, Arnaldo Carvalho de Melo escreveu:
> We end up leaking entries when what I'm suggesting you to do is to
> not clobber entries with the return of realloc() (doing it this way most
> of the time leads to bugs), but instead store it to a temp var
> (nentries), and if it succeeds, then you know that you can
> set nentries to entries and go ahead with your nicely shrunk block of
> memory.
 
> If it fails, then you continue with the original block of memory, that
> continues to have what you just set up, etc.
 
> Lemme look a third time to your original patch, I must be missing
> something...

I don't think I'm missing anything ;-)

- Arnaldo
