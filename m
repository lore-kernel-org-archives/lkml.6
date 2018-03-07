Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933351AbeCGS5J (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 13:57:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:39896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753934AbeCGS5I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 13:57:08 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 542E320685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Wed, 7 Mar 2018 15:56:59 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH 05/19] perf tools: Add refcnt into struct mem_info
Message-ID: <20180307185659.GP3701@kernel.org>
References: <20180307155020.32613-1-jolsa@kernel.org>
 <20180307155020.32613-6-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180307155020.32613-6-jolsa@kernel.org>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 07, 2018 at 04:50:06PM +0100, Jiri Olsa escreveu:
> It's passed along several hists entries in --hierarchy mode,
> so it's better we keep track of it.

I like this, but you called it...
 
> +
> +struct mem_info *mem_info__aloc(void)
> +{
> +	struct mem_info *mi = zalloc(sizeof(*mi));
> +
> +	if (mi)
> +		refcount_set(&mi->refcnt, 1);
> +	return mi;

"aloc" with just one 'l', so I have to fix the typo, while at it I'll
use what is used elsewhere for this operation, i.e.

struct mem_info *mem_info__new(void);

:-)

- Arnaldo
