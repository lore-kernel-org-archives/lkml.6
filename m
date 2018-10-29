Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBBCC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 12:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65DD12082B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 12:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RG3GkqUo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65DD12082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729346AbeJ2VXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 17:23:37 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39924 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729242AbeJ2VXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 17:23:37 -0400
Received: by mail-wm1-f65.google.com with SMTP id y144-v6so7755572wmd.4;
        Mon, 29 Oct 2018 05:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=h4jQvS3smwEHiSjQLJ3kY9xovFkxw3+QZ/jJOJIUjm0=;
        b=RG3GkqUowS0h/5a+EHZKVF9iQoOQu/hZc/Gtp5NLyBb5HtJhSEqQfW1kEae/NVVk/6
         B5Ns5eS5BatVnlAVxjlLX723X0WMi8OX8GPsmbz6qNX8Ic6lm5Q9VgSbVopJqx0ybt1V
         YTsC+NK0fpe//rIhemYvAi/cFVTbX0QzhsIZ1YaJnwZkkUjGdAHlWbKdSypcqlcDKm98
         9ZoUU5KUttpOI1C6U+JlzpcxUuteVbcP3MEpoOhlCu7QobZU5qKxbWYUWRfRqyOjU2ve
         HewPpS5WRR8IewIQBHYyVzDzRQMMDrFcHVkou7swyXLETrj9swTthUkZYAFBigqDvRdh
         H/mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=h4jQvS3smwEHiSjQLJ3kY9xovFkxw3+QZ/jJOJIUjm0=;
        b=hlqdXWpe1/Z1kafUhjNfd8s32Ny0oa3FNYN31CzlWqxxipaNPnEecWtK6WDeA27uMV
         WWI5sxD9xr4HeoXPkZJbTlBtxZ8jDoeVbfU+Tz7xybu+YODJvjhR8SWd36RDUA99dFHP
         9o1DqEwHC3iL8B2p/vsAcU/ljkvSXSVQ/Ym8W+gx59oHu4loVeSgOfl7pIcm8IK1PjqU
         uqKOs5qLuX8jgkd8q5WNY8uMSiFEk4opsRWYI7bVAnUxWxZOkpfa4icc33gejpWZVseb
         me9YIyzMsuDOVSYXmqVQ8tQq7ldu6zwFffmU4yvJyIByjoEe12OEOQr3x5HSv42eMv7t
         Yhig==
X-Gm-Message-State: AGRZ1gJ1YTH2AA4rZxbAnFtEDoTkWZroNKxMaAg/bu1zyFU27hDTO8rT
        vy05WjvmFnqEC4baEwC6yQ0=
X-Google-Smtp-Source: AJdET5dLyR1E3h/zEaBjohTht9EMap9NRkmVuKj3M6/2FP16rNwljoApWrJ3Snf4HnjZ/TkB7NiNxw==
X-Received: by 2002:a1c:2ecc:: with SMTP id u195-v6mr14167988wmu.137.1540816505448;
        Mon, 29 Oct 2018 05:35:05 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id g8-v6sm24728758wri.58.2018.10.29.05.35.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Oct 2018 05:35:04 -0700 (PDT)
Date:   Mon, 29 Oct 2018 13:35:02 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Colin King <colin.king@canonical.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/perf: fix spelling mistake, EACCESS -> EACCES
Message-ID: <20181029123502.GA57235@gmail.com>
References: <20181026175839.4565-1-colin.king@canonical.com>
 <20181029122854.GB20813@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181029122854.GB20813@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Em Fri, Oct 26, 2018 at 06:58:39PM +0100, Colin King escreveu:
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > Trivial fix to a spelling mistake of the error access name EACCESS,
> > rename to EACCES
> 
> Thanks, applied.
> 
> And I also took the chance to fix another spelling mistake, on this same
> line:
> 
> -        *  -EACCESS    -- @event is for this PMU, @event is valid, but no privilidges
> +        *  -EACCES     -- @event is for this PMU, @event is valid, but no privilidges
>                                                                                  ^
>                                                                                  ^
>                                                                                  ^
>                                                                                  ^
> 
> :-)

LOL.

I zapped my commit from perf/urgent, because I failed to notice the 
second typo :-)

Thanks,

	Ingo
