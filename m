Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30AC1C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 14:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC2522188F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 14:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="09wR3i9S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC2522188F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbeHQRzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 13:55:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:48968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727037AbeHQRzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 13:55:45 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FBD121536;
        Fri, 17 Aug 2018 14:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534517525;
        bh=GRVbY5EqwJ/2M0NaMhxB8s88/l/loaNmsIUlfPCmtdE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=09wR3i9S4ivu56w2sQCIHfiU5vqTysPRUeszp1YykVnrY7XCq//6rE62issux5h1a
         8Gh7aL0Ht6Nwuv3dCWWcMkV49kRwHaNgMeks0uevfxE00Sv43VE/k9RoY2T7K+8fnm
         xZHzBtiSJOZkpQvY7D7ynDeYuagmo40dzi/2moyA=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 7D3DF141C3A; Fri, 17 Aug 2018 11:52:02 -0300 (-03)
Date:   Fri, 17 Aug 2018 11:52:02 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH 00/13] perf tools: Use plain debug files for compressed
 objects
Message-ID: <20180817145202.GB22443@kernel.org>
References: <20180817094813.15086-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180817094813.15086-1-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Aug 17, 2018 at 11:48:00AM +0200, Jiri Olsa escreveu:
> hi,
> currently we don't allow to open plain debug files for
> compressed kernel module objects, ending up with following
> warning:
> 
>   $ perf report --stdio
>   lzma: failed The input is not in the .xz format
>   lzma: failed The input is not in the .xz format
>   lzma: failed The input is not in the .xz format
>   lzma: failed The input is not in the .xz format
>   # To display the perf.data header info, please use --header/--header-only options.
> 
> The reason is behind the logic we open the DSO object files,
> when we try all possible 'debug' objects until we find the
> data. So even if the DSO is represented by 'krava.xz' module,
> we can end up opening ~/.debug/....23432432/debug' file which
> is not compressed and we fail with above error.
> 
> This patchset adds the code to detect un/compressed files and
> return plain debug file when available even for compressed
> kernel modules.
> 
> Also available in here:
>   git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
>   perf/fixes

Thanks, applied.

- Arnaldo
