Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C7DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 07:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2247620874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 07:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547190777;
	bh=BrJTFM5gKuueM4BJa2U+IwzVXjmAE6JCmOq6OPv+E2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=A7bmLzSIl+MUY1luae8UhOMRuGEiqj3xEas1mekBm0Wzt85TE1o0bo4R7JziJMnjW
	 i7Xvl+NX7dJdJGBMlI79TDOZtGRgDt/gBbcUxOZOpwTmJsB7URI2Fzt8OyKKp/2UuB
	 8qtS4zr2hRVd1Ty8OMZbXd1Yk53/TAEF6DjCxy8g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730832AbfAKHM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 02:12:56 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39473 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfAKHMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 02:12:55 -0500
Received: by mail-wm1-f67.google.com with SMTP id y8so1276575wmi.4;
        Thu, 10 Jan 2019 23:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fS56oVKn1jU+MSvIq1xtj3+RfL7HSRicgSJJZwVEqjc=;
        b=s2+178jMJsvGKB6CJuPoOf6AsXFv5IR5VLUSHPN/Gf6pg69m1nHk8N4Mh0lkyY9qFW
         mLGDz6KNyWrHFdFVOMtjnNgGQNf5YfZl2VsF/hfjhg7v64fqbWddjdfWZHX2dQv1eUUW
         IU/F+85fnMxXZUl6MXkoHKYkGB4NLujIL75JT2mkYxVDF6Umui6k98mYd98a4pzsYnHA
         XNkGuRU8bSh2BLMiECSOZMnI7YGeFHnZL9MD+P7V0uuBKysYCC2iwuJc1CTTqKUoeS9x
         rduOn1Pf0pSv1+k6uYkWQcIZonSWvwp63NfYJnt4pUGQVtRObJnAXQGQ8zP6pgb36Che
         FX0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=fS56oVKn1jU+MSvIq1xtj3+RfL7HSRicgSJJZwVEqjc=;
        b=QYXOClaL4S5KF3UZU8ZT8/7sqKGVjKhv05JqfA//VS2c4+NnUkvIXPwvAyWlwET5zM
         imcSKncZJHqWZo6fsfkKj2UphFo4JZ5uQmu1Ke1U5/Ts7gWsBPjvkh5IugnLBSu7m0Xw
         zir9S/Z8Y2AmR6Klm0K/QA+ZTdGJIwJhb3dJpUqcGUsn/CGMI19at3ovDfBQLETuC3wp
         OHkExKVWSNMT4+q69jDS36Omg6NMyT+OI6anQsSzQ9ztSsV7URnlcX/BmSopWMTNQ3U5
         TRsyh3W/P7YHFo0W/I71fubDWAwbZrtl9XKyejiC7qcoIm4Os4rLtB311GeU0SL/s8PJ
         3wpA==
X-Gm-Message-State: AJcUuke+VNl9V/1X7IKTxSZ86/idlTK+qqSC785qqGT46NIvuogRmNzR
        cDucTj9CR26Km6gCQJGOR+A=
X-Google-Smtp-Source: ALg8bN7utcIiy4MOHwL1jdjqi6Ewzp2O8GhHkcWOdDrlKzDJYhw/ZNYjdnI32XJG2IfcGvHS4w5aDA==
X-Received: by 2002:a1c:6657:: with SMTP id a84mr1022968wmc.23.1547190773176;
        Thu, 10 Jan 2019 23:12:53 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id i13sm59215909wrw.32.2019.01.10.23.12.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 23:12:52 -0800 (PST)
Date:   Fri, 11 Jan 2019 08:12:50 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL 0/4] perf/core fixes and improvements
Message-ID: <20190111071250.GB92116@gmail.com>
References: <20190110165636.19338-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110165636.19338-1-acme@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Please consider pulling, now there are no more ABI header
> warnings,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit 576b50ea235699d83758c0c514c65b8d486a159d:
> 
>   Merge tag 'perf-core-for-mingo-5.0-20190108' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent (2019-01-09 07:59:40 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.0-20190110
> 
> for you to fetch changes up to 15c03092a9fbcdd041f58e5f832bf76c21c42e6a:
> 
>   tools headers powerpc: Remove unistd.h (2019-01-10 10:42:08 -0300)
> 
> ----------------------------------------------------------------
> perf/core fixes and improvements:
> 
> perf trace:
> 
>   Ravi Bangoria:
> 
>   - Rework PowerPC syscall table generation, now using a .tbl file just like
>     x86_64 and S/390, also silencing a tools build warning about headers out of
>     sync with the kernel sources.
> 
> tools include uapi:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Sync linux/if_link.h copy with the kernel sources, silencing a build warning.
> 
> perf top:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Add 'arch_cpu_idle' to the list of kernel idle symbols, noticed on a Orange
>     Pi Zero ARM board, just like with other symbols in other arches.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (2):
>       tools include uapi: Sync linux/if_link.h copy with the kernel sources
>       perf symbols: Add 'arch_cpu_idle' to the list of kernel idle symbols
> 
> Ravi Bangoria (2):
>       perf powerpc: Rework syscall table generation
>       tools headers powerpc: Remove unistd.h
> 
>  tools/arch/powerpc/include/uapi/asm/unistd.h       | 404 -------------------
>  tools/include/uapi/linux/if_link.h                 |  19 +
>  tools/perf/arch/powerpc/Makefile                   |  15 +-
>  .../perf/arch/powerpc/entry/syscalls/mksyscalltbl  |  22 +-
>  tools/perf/arch/powerpc/entry/syscalls/syscall.tbl | 427 +++++++++++++++++++++
>  tools/perf/check-headers.sh                        |   1 -
>  tools/perf/util/symbol.c                           |   1 +
>  7 files changed, 470 insertions(+), 419 deletions(-)
>  delete mode 100644 tools/arch/powerpc/include/uapi/asm/unistd.h
>  create mode 100644 tools/perf/arch/powerpc/entry/syscalls/syscall.tbl

Pulled, thanks a lot Arnaldo!

	Ingo
