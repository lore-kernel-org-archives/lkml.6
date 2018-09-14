Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F0EEFC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 09:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28D7C20882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 09:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MSFiQbWu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28D7C20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbeINOr2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 10:47:28 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36735 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727670AbeINOr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 10:47:28 -0400
Received: by mail-wr1-f67.google.com with SMTP id e1-v6so9787315wrt.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 02:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vgPY5IANcUj7kHztUz4rANFIsGGk+GBnBK7dQVFnDn8=;
        b=MSFiQbWuQLrZduUb6DPWIPUE7y+RN+2I0QlnkNnGqKCbkRik2otW9xGZeJIkUaXKmI
         2BOSzpYl5yLTq9xZGUNnB7uXPl4BcBcLE6btWU/iSPXKwDuJ8p50N35Wz0dO5TOxo/Z4
         Xwbv5P0nVwkwhsqUzO0s/1gBle0Xxw3GyB07ahiJPhzF2Ccl97UnCwj8qUtPROOc1wZk
         Ai/6jNQ4d5dLYNuHesDolUyMjcPd3ELWdNiTsO1AIp2TBmyarCRAFDr0kP16O5AzB9ak
         7gvMszPvduR6JtrIj63ywb+yoDDMfHndnPOM2mtZ93fJaPm0q91Cxu3GS3sfeOjg2GH6
         Ww0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=vgPY5IANcUj7kHztUz4rANFIsGGk+GBnBK7dQVFnDn8=;
        b=mIGk1LiSFx3AUsWNtIKZjG2VocMMhZPMfjBDZcU5lHgyBioKK0am896EshqnKr88GR
         JQJNcPec35ZkWsWuyStn+5OoClBdUb4iHx2RodLsG01DY6gAVNwo0WTV3Cs2jtUzpY3m
         2rTSc/EUKTY6qmDYDtmK9sbWWFIQks7E6nn+aYJ/NcD+v7VugU7h//lKAfArOuiLgYPX
         CMuicpfKe+38UjoOJj6mqmeSIRDez0C4nITlr//E7fEAqDHjnd1zvW0uEi1IqTZrJQ0T
         q4M3hQotJ7UxQVYq480v2Z6m7HeqyXwiDUt/5oQ+uxT/Hkrj51WGFgVD7i1sdJeKBBl6
         TaRg==
X-Gm-Message-State: APzg51DT31Zdfe0xmGXjiAlbS9PJ8Vm5tgU1SUN3pKTW04Dsg5P5ji0D
        j1/2IcKhDjS/BRw4fgN2K18=
X-Google-Smtp-Source: ANB0VdbbGVQKC6qGQXAKLLzO9nQ2fbFXznX2fJWZVyLIytcd7NFFxNGAKNXHs/ziF32foAVBIqCmGQ==
X-Received: by 2002:a1c:9550:: with SMTP id x77-v6mr1585623wmd.135.1536917627328;
        Fri, 14 Sep 2018 02:33:47 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id v2-v6sm1037398wme.36.2018.09.14.02.33.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Sep 2018 02:33:46 -0700 (PDT)
Date:   Fri, 14 Sep 2018 11:33:44 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Alexey Budankov <alexey.budankov@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>, kernel-team@lge.com
Subject: Re: [RFCv2 00/48] perf tools: Add threads to record command
Message-ID: <20180914093344.GA96351@gmail.com>
References: <20180913125450.21342-1-jolsa@kernel.org>
 <cba27d6a-a97b-cbb7-4be8-d1c14fb7dea5@linux.intel.com>
 <20180914022910.GA15146@sejong>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180914022910.GA15146@sejong>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Namhyung Kim <namhyung@kernel.org> wrote:

> > > The perf.data stays as a single file.
> 
> I'm not sure we really need to keep it as a single file.  As it's a
> kind of big changes, we might consider breaking compatibility and use
> a directory structure.

Agreed - and to make use of the highly scalable Linux VFS implementation we should
attempt to use per CPU file resources as well.

Any cross-CPU contention should stick out like a sore thumb.

> > There is usage of Posix threading API but there is no 
> > its implementation in the patch series, to avoid dependency 
> > on externally coded designs in the core of the tool.
> 
> Do you mean it needs to implement its own threading?  I don't think
> that's what Ingo wanted to.

Yeah, I didn't mean that: every libc hoping to work on Linux implements a pthread API, plus the 
pthread APIs we are using are really just narrow wrappers on top of system calls that were 
written with libc pthread APIs in mind. So it's not a problem to rely on pthreads.h. (And if we 
have trouble with any particular pthread detail we can single out specific functionality and 
not use it or use our own implementation.)

The AIO library is another matter: it's a family of interfaces with complex libc specific 
design choices that cannot be influenced.

I.e. my suggestion was to keep using pthreads APIs like we do today, but not use the libc AIO 
library. Not because there's any problem with glibc AIO: but because basic event flow is a core 
competency of perf that we want to implement ourselves.

Is this clearer?

Thanks,

	Ingo
