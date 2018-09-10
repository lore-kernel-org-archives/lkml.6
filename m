Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA34C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13FD42086E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7SHtIhh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13FD42086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbeIJO4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 10:56:23 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37470 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727781AbeIJO4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 10:56:23 -0400
Received: by mail-wm0-f67.google.com with SMTP id n11-v6so20693274wmc.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 03:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nrp/LzQCHtlfiL6Q32QcL2jgzBICyLoJno5frRBkNL4=;
        b=R7SHtIhhajJHa1BureKYcRNUm33TAUgz0Wp1j/je1kCt8NVHVaFwihvC9QP7WG9uOR
         Ao2Ol1RTmi4y0yAQZdmEo50eYS37JksxLr4dAQk3dgs8iqGmYZ2gypyxO3gHAGNSOFMQ
         6vJiJyw/CtKiNWfRCFhaM6Htk4gXDmaiG6kB13mJ8flFqw/2idcF3lX9G+BlDuLr3hMy
         Mjl9SFpy7xNV5SLxN0r6yECS7MFj0c+6SBjCieE4eIOw181nNdw555mBWvulgkdN8KOh
         OEPd8s+qJ2n1hgKKDjC7B9aSxJigi+ITpsViPQ0UX5I7iENcO9M2CiZ93+ofjGyxjhv6
         DTxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=nrp/LzQCHtlfiL6Q32QcL2jgzBICyLoJno5frRBkNL4=;
        b=epbiogCQ8vKpCuybY/zIU3ZLhGD0ed6/+bMplTiMNo1QJGj6wpzcPYWBnOx8KFs4Ex
         Dnf25MI9eL7/HU9xO+vluRbzhjk/v7e+HH8HB0Uzk1jyPdWB/JLop6mnx6KbKHmVvo6s
         w/pJ7kYUK2mb+Qk7uoxGmDkYIJK32ftcRpXGJOxRWIi15f+NJVpHOKF4JHN1BHIdjKvo
         VitmCMOMe43iWUpsI1GLnojIdXjGVUfYxgFB0IDv1hjTP92k4ElrfCL4DpEgfbf9mtP/
         glDyDdLFojUPPIgcvagXQyE/mJ2oXfsgK97ClJ7piv/pJhHW6PJRm2VkQoyN/kq2mwZD
         gI6Q==
X-Gm-Message-State: APzg51CodoEG52qeVEG7HgI85OdEbk7PwUVnFnLIw08o7nsELsM9gDjl
        ta1ZWUTJZZOf39TddRpVomc=
X-Google-Smtp-Source: ANB0VdZyt+TKyFIgKlmsH4CAbL7pLll8pSR9oEo7qxSd87YhAmU8RjrZSVqgYEXmPjPVQygRnHCrMA==
X-Received: by 2002:a1c:7305:: with SMTP id d5-v6mr158078wmb.53.1536573786043;
        Mon, 10 Sep 2018 03:03:06 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id h73-v6sm46906042wma.11.2018.09.10.03.03.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 03:03:05 -0700 (PDT)
Date:   Mon, 10 Sep 2018 12:03:03 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Alexey Budankov <alexey.budankov@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 0/3]: perf: reduce data loss when profiling highly
 parallel CPU bound workloads
Message-ID: <20180910100303.GA101776@gmail.com>
References: <e1144f9d-b231-e42c-d698-4db0e62b71ff@linux.intel.com>
 <20180910091841.GA4664@gmail.com>
 <20180910095909.GA15548@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180910095909.GA15548@krava>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Jiri Olsa <jolsa@redhat.com> wrote:

> > Per-CPU threading the record session would have so many other advantages as well (scalability, 
> > etc.).
> > 
> > Jiri did per-CPU recording patches a couple of months ago, not sure how usable they are at the 
> > moment?
> 
> it's still usable, I can rebase it and post a branch pointer,
> the problem is I haven't been able to find a case with a real
> performance benefit yet.. ;-)
> 
> perhaps because I haven't tried on server with really big cpu
> numbers

Maybe Alexey could pick up from there? Your concept looked fairly mature to me
and I tried it on a big-CPU box back then and there were real improvements.

Thanks,

	Ingo
