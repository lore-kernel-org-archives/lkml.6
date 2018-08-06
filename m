Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8CDFC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 18:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7965620685
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 18:18:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7965620685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387663AbeHFU2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 16:28:50 -0400
Received: from mga17.intel.com ([192.55.52.151]:46278 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbeHFU2t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 16:28:49 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Aug 2018 11:18:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,452,1526367600"; 
   d="scan'208";a="78975165"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by fmsmga001.fm.intel.com with ESMTP; 06 Aug 2018 11:07:40 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 12A42301388; Mon,  6 Aug 2018 11:07:40 -0700 (PDT)
Date:   Mon, 6 Aug 2018 11:07:40 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 2/4] trace: avoid calling cc-option -mrecord-mcount for
 every Makefile
Message-ID: <20180806180740.GI4238@tassilo.jf.intel.com>
References: <cover.thread-aa7b8d.your-ad-here.call-01533557518-ext-9465@work.hours>
 <patch-2.thread-aa7b8d.git-de935bace15a.your-ad-here.call-01533557518-ext-9465@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <patch-2.thread-aa7b8d.git-de935bace15a.your-ad-here.call-01533557518-ext-9465@work.hours>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 03:17:44PM +0200, Vasily Gorbik wrote:
> Currently if CONFIG_FTRACE_MCOUNT_RECORD is enabled -mrecord-mcount
> compiler flag support is tested for every Makefile.

Good catch.  Does it make a measurable compile time difference?

> 
> Top 4 cc-option usages:
>     511 -mrecord-mcount
>      11  -fno-stack-protector
>       9 -Wno-override-init
>       2 -fsched-pressure
> 
> To address that move cc-option from scripts/Makefile.build to top Makefile
> and export CC_USING_RECORD_MCOUNT to be used in original place.
> 
> While doing that also add -mrecord-mcount to CC_FLAGS_FTRACE (if gcc
> actually supports it).
> 
> Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>

Acked-by: Andi Kleen <ak@linux.intel.com>

-Andi
