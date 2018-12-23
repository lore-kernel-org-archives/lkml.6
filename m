Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C557C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 03:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 135622173C
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 03:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545536489;
	bh=12ChcSjIlezH4LAEpIAqw8PuK+4PavIMXxqjzRL5Rmg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uFhZEyfuBYshq4m5rDjPuW4oO0pRqI66baTuXXGahEJSiDCkaKeiAjwCgb/s8VFWg
	 h7FG+3w3XpP+82VegRSBOmPnwKYesA8rMIF3JOd6KvV+tgBu6nc7+E/0IpO3mzZD6w
	 NU3La+MrIwDt1A9NmC8qyUG7dlk4lC89qqCiA5Qw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405153AbeLWDl1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 22:41:27 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:32832 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389248AbeLWDl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 22:41:27 -0500
Received: by mail-pl1-f193.google.com with SMTP id z23so4287600plo.0;
        Sat, 22 Dec 2018 19:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fqBJ0110aawK8sOOB72XMa51Pbkb7DNuWdAqlrJ5JRY=;
        b=bgHXGDloTap2aX3p12DeO1YajXRoNrCPjuslnyeGKE2W84c4z5JlZ0Ua+WpGgAR0kR
         CdsjUO/vb0Zw5RNQ1Gh3l3iHbnhgya4IkYU7pCSQVJFE2a7YCZcI2lGySqKTH7dhzu45
         1akLxSloIdKk23glOYgeIVByqmEKRYP8XeJrSVs3aNRCUdel/ALsha4TW7ABxaa3ZtOq
         7fzM9MdS+lSr0ADmYYJtIg0+V+tPnEVenSSzvtSC6IWTPPPxtfzJzNJjCrcB5+WH8BnG
         0eC0zB3WL+Za0VGTC2eF73e2C6ra1Cjm5CKXCpBk0XSO52bcaCzVXmQ5C45Lht6MMh+c
         HN3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=fqBJ0110aawK8sOOB72XMa51Pbkb7DNuWdAqlrJ5JRY=;
        b=HlHPYfKHtuecW58mbphxZQrcl9syHDCwifr8JSDsFfb59W+i9z9tLfu4RfHtjhtLKW
         afF6/eRTacb4eFKn3d/vSjkg2FglUzO/b0joBF34CCfxY5G9g9O1oSY9VWkoum03SHH6
         xWbG6VJDr9oNzRBZ6Fy0lmVTOw+Y1MCnjn4jECt0zmyXAwjQohvxMfCwygsHYG9pDIOo
         efgAKYeXpidmgrAsHW+1VXU5mmVDAqeqCIxj8mQnCVIaY/cRwqHFoVCBchIsDWFPi99u
         N14rHvuGPBAhEIIkT8AM8SnCDBhlijE9Q0UBdTZ6+CILRFIuI5ZC3FetoNTXQSxVa++h
         d5Kg==
X-Gm-Message-State: AJcUukcdTMmAItJGjrN4oWQEE/2n8kvt79ebjvAwKcPzOqAkbh7MihGz
        6FN2K8/2X7Mu1gSs4UVsfCY=
X-Google-Smtp-Source: ALg8bN7lTPDocuf6huJwJ3FfVB49zC3cRYj4Yier14XkGdlmmIovDVF7xVdDfdFPel3hTCgCp8zPeQ==
X-Received: by 2002:a17:902:f81:: with SMTP id 1mr8264663plz.174.1545536486570;
        Sat, 22 Dec 2018 19:41:26 -0800 (PST)
Received: from danjae.aot.lge.com ([182.210.106.196])
        by smtp.gmail.com with ESMTPSA id m3sm15547106pfi.102.2018.12.22.19.41.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Dec 2018 19:41:25 -0800 (PST)
Date:   Sun, 23 Dec 2018 12:41:20 +0900
From:   Namhyung Kim <namhyung@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        kernel-team@lge.com
Subject: Re: [for-next][PATCH 0/5] tracing: Add string_has_prefix() and usages
Message-ID: <20181223034120.GF11421@danjae.aot.lge.com>
References: <20181222162007.697862256@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181222162007.697862256@goodmis.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 22, 2018 at 11:20:07AM -0500, Steven Rostedt wrote:
> I hope everyone is OK with these changes. I pushed to linux-next but I'm
> willing to change them if there are still issues.
> 
> They ran through all my tests, althought zero-day-bot had a weird build
> regression in sh, that looks totally unrelated:
> 
>  Regressions in current branch:
> 
>  arch/sh/kernel/dwarf.c:107:26: error: 'dwarf_frame_reg' defined but not used [-Werror=unused-function]
>  arch/sh/kernel/dwarf.c:1209:0: error: unterminated argument list invoking macro "WARN_ON"
>  arch/sh/kernel/dwarf.c:226:12: error: 'dwarf_read_encoded_value' defined but not used [-Werror=unused-function]
>  arch/sh/kernel/dwarf.c:306:26: error: 'dwarf_lookup_cie' defined but not used [-Werror=unused-function]
>  arch/sh/kernel/dwarf.c:38:27: error: 'dwarf_frame_cachep' defined but not used [-Werror=unused-variable]
>  arch/sh/kernel/dwarf.c:399:12: error: 'dwarf_cfa_execute_insns' defined but not used [-Werror=unused-function]
>  arch/sh/kernel/dwarf.c:41:27: error: 'dwarf_reg_cachep' defined but not used [-Werror=unused-variable]
>  arch/sh/kernel/dwarf.c:580:22: error: unused variable 'frame' [-Werror=unused-variable]
>  arch/sh/kernel/dwarf.c:581:20: error: unused variable 'cie' [-Werror=unused-variable]
>  arch/sh/kernel/dwarf.c:582:20: error: unused variable 'fde' [-Werror=unused-variable]
>  arch/sh/kernel/dwarf.c:583:20: error: unused variable 'reg' [-Werror=unused-variable]
>  arch/sh/kernel/dwarf.c:584:16: error: unused variable 'addr' [-Werror=unused-variable]
>  arch/sh/kernel/dwarf.c:622:3: error: expected ';' at end of input
>  arch/sh/kernel/dwarf.c:622:3: error: expected declaration or statement at end of input
>  arch/sh/kernel/dwarf.c:622:3: error: 'WARN_ON' undeclared (first use in this function); did you mean 'WMARK_LOW'?
> 
> Pushing to my for-next branch should kick off another run. Let's see
> if it reports that again. Unless someone knows why that happened?
> 
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
> for-next
> 
> Head SHA1: 92b9de3e574bd874188a4e27a8830bb901a08ef8
> 
> 
> Steven Rostedt (VMware) (5):
>       string.h: Add str_has_prefix() helper function
>       tracing: Use str_has_prefix() helper for histogram code
>       tracing: Use str_has_prefix() instead of using fixed sizes
>       tracing: Have the historgram use the result of str_has_prefix() for len of prefix
>       tracing: Use the return of str_has_prefix() to remove open coded numbers

For the series:

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> 
> ----
>  include/linux/string.h           | 20 ++++++++++++++++++++
>  kernel/trace/trace.c             |  8 +++++---
>  kernel/trace/trace_events.c      |  2 +-
>  kernel/trace/trace_events_hist.c | 35 ++++++++++++++++++-----------------
>  kernel/trace/trace_probe.c       | 17 +++++++++--------
>  kernel/trace/trace_stack.c       |  6 ++++--
>  6 files changed, 57 insertions(+), 31 deletions(-)
