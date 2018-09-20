Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529A1ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 14:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B1A721531
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 14:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wx8upoya"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B1A721531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733020AbeITT5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 15:57:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:48054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731223AbeITT5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 15:57:13 -0400
Received: from jouet.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A865F21531;
        Thu, 20 Sep 2018 14:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537452812;
        bh=3kSm5AUDyyr88RKRXsfpSjEYVYpwn/j97i9qwh1EKAU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wx8upoyabdIBjy4PufN69sNeAU7N2MfM0XJQ7uUrlX7jNMiAiqbd5aXkzGlqc/ieF
         rme68FsjmelKo2PJ19lmVzljCKIh8n2tQtjRBd/rRbqYReeGgoIqcjSP43ltCNU6Ht
         8U8eGSMSQrBYMv5GZ2jsfZAt6pdbCoCczyORmFo4=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 7E71C140260; Thu, 20 Sep 2018 11:13:30 -0300 (-03)
Date:   Thu, 20 Sep 2018 11:13:30 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 0/6] perf intel-pt: Improve the data displayed when
 using address filters
Message-ID: <20180920141330.GE19861@kernel.org>
References: <20180920130048.31432-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180920130048.31432-1-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Sep 20, 2018 at 04:00:42PM +0300, Adrian Hunter escreveu:
> Hi
> 
> Here is V2 of some Intel PT patches to improve the data displayed when using
> address filters.
> 
> Previously, the decoder would indicate begin / end by a branch from / to
> zero. That hides useful information, in particular when a trace ends with a
> call. That happens when using address filters, for example:
> 
> $ perf record -e intel_pt/cyc,mtc_period=0,noretcomp/u --filter='filter main @ /bin/uname ' uname
> Linux
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.031 MB perf.data ]

Thanks, applied.

- Arnaldo
