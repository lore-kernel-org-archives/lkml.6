Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280C9C64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2B8220700
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544112832;
	bh=56VthS44E+w8dXDIpEacBy2R4ABnG7yEynO6/qYFvNI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0aF5EohdzmHDCpBcyoeSeD7NKr35Drdh4kED4jymDiQ5ZTLd0UBdpIUKMTXnmDxYg
	 TBou9l/Ts3NhhjGjGVlCaQxCUHR6m64eKeW+CW/qbawaUk4p5U1TnVb4DuAbsIhp4y
	 knl03eXJlg6MjJ4toaFs2BbUGkUSVpSaraD5uiz4=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2B8220700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbeLFQNu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 11:13:50 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46427 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbeLFQNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 11:13:49 -0500
Received: by mail-wr1-f66.google.com with SMTP id l9so1000820wrt.13
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 08:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZWnBqBiyhodpG/hISKEA8wuP68nlQZNbMSAgz1uV9vI=;
        b=De9HWiY7gFIknvMnpqSQtwuIshngJI30zovaxXXeX4qqeq6kWsqkgrxRx5S5jJh0M/
         QYw/suXktTuvJEcyNLTd8dI6/+OLkumoUKU1N1Co8uQFXebzmzTKVWVX+a6KKtUw2c2B
         Spprl8Fz5CrIVTe04EWa6AQhh1iTWIEqL52xFlMGJnQVQt2qsGhBLVBgJVz2o4d20v1X
         aGmOUv0im9YcGHXiytEaGUnmCdGg233bRVOtRIaLQgFbccVB0PUcJJr0wo+ZSIigJVNB
         3mLnqx5ccsJiEucEXuniX/pVKZDZu5XoPPasuGXPqaOKKK6nX+g3t5Vvx6sBDRYAqRDi
         SXhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZWnBqBiyhodpG/hISKEA8wuP68nlQZNbMSAgz1uV9vI=;
        b=g1tipeJDwKy8wJM8CCqfxQec1pSkuAEBPNCoT4U/iXnpkvRQqH8mrsYRpbRBv7bXKN
         TFl3WjpgczwXWEaeceFNYlAFmrCdbXg6f/AkMYnF1Ors3O6rCse/asR1gDNI513GRA3K
         7o0bDiUaOBE3SWeTFSXDTNY+NXHkUoklTsC6aIgH6C+LdANnb9PsTkuhwbGrO/SSCcTW
         x0BMz9e06R5jcyRL83wg5eog3N9GK79j09VZ6tgqdKDCiW9nKwttvdwGJxdExGRo9/94
         jyGkNpK+4FK0m1owRmMQKfv6mweq2apTsFUPYfgnOFeSmJUO7drX3+OnNHbg3e+ic+p0
         LI8Q==
X-Gm-Message-State: AA+aEWbMfdVDRR6d7/4Bu1zjRKh07Sh2RkyXFknem7uCgsnPcUM3/tHP
        95CNl+bK8r3DOvr3pDHIHRoeiLNp
X-Google-Smtp-Source: AFSGD/Wrhxz4zmHkH1OBvfEJ4IJ7xUOqCmCCjCt7FI53t9JEU8eu3B/0U/89fo28cTRYxBHMYBW/Lw==
X-Received: by 2002:a5d:494a:: with SMTP id r10mr26811652wrs.272.1544112827865;
        Thu, 06 Dec 2018 08:13:47 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id l202sm2106319wma.33.2018.12.06.08.13.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 08:13:47 -0800 (PST)
Date:   Thu, 6 Dec 2018 17:13:44 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCHv2] locking/atomics: build atomic headers as required
Message-ID: <20181206161344.GA110430@gmail.com>
References: <20181128085455.1164-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128085455.1164-1-mark.rutland@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Mark Rutland <mark.rutland@arm.com> wrote:

> Andrew and Ingo report that the check-atomics.sh script is simply too
> slow to run for every kernel build, and it's impractical to make it
> faster without rewriting it in something other than shell.
> 
> Rather than committing the generated headers, let's regenerate these
> as-required, if we change the data or scripts used to generate the
> atomic headers, or when building from a pristine tree.
> 
> That ensures they're always up-to-date, allows them to be built in
> parallel, and avoid redundant rebuilds, which is a 2-8s saving per
> incremental build. Since the results are not committed, it's very
> obvious that they should not be modified directly. If we need to
> generate more headers in future, it's easy to extend Makefile.genheader
> to permit this.
> 
> I've verified that this works in the cases we previously had issues with
> (out-of-tree builds and where scripts have no execute permissions), and
> have tested these cases for both x86_64 and arm64.
> 
> The diffstat looks nice, at least...
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: linux-kernel@vger.kernel.org
> ---
>  Kbuild                                    |   18 +-
>  Makefile                                  |    8 +-
>  arch/arm64/include/asm/atomic.h           |    2 +-
>  arch/x86/include/asm/atomic.h             |    2 +-
>  include/asm-generic/atomic-instrumented.h | 1787 ----------------------
>  include/asm-generic/atomic-long.h         | 1012 -------------
>  include/linux/atomic-fallback.h           | 2294 -----------------------------
>  include/linux/atomic.h                    |    4 +-
>  scripts/Makefile.genheader                |   26 +
>  scripts/atomic/check-atomics.sh           |   19 -
>  10 files changed, 38 insertions(+), 5134 deletions(-)
>  delete mode 100644 include/asm-generic/atomic-instrumented.h
>  delete mode 100644 include/asm-generic/atomic-long.h
>  delete mode 100644 include/linux/atomic-fallback.h
>  create mode 100644 scripts/Makefile.genheader
>  delete mode 100755 scripts/atomic/check-atomics.sh

So these 'automatically generated' headers are actual and important code, 
and I think it's bad practice to remove these from the git grep search 
space and history as well.

Really, this whole notion of auto-generating the headers should be 
implemented correctly, instead of working around deficiencies in a 
short-term fashion that introduces other deficiencies.

I never got any replies to my previous comments about this:

  <20181128083057.GA7879@gmail.com>

Did I miss some mails of yours perhaps?

Thanks,

	Ingo
