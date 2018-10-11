Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5300BC677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 20:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02E1C214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 20:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i3BZB1Rt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02E1C214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbeJLEIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 00:08:46 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44395 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbeJLEIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 00:08:46 -0400
Received: by mail-oi1-f195.google.com with SMTP id u74-v6so8159266oia.11
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 13:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+NaERK3t9jZbwruYt+KRN4CMKJa5ImYF22IDwr1nznw=;
        b=i3BZB1RtGZo5hdf7PWvA4dOZk/fhJBBk32vLvTd5+GzbqHSBaSQAIL+mQ4unxVniio
         16PRaK0Jxyo3KiJJle9dBIvIE1GXUvoBhxFFSU58vppUWrpWLrsC1TqXUqFkZNholw9E
         mdUXiN4Yk6zBxCx/bRZzkwyLMNJwAdTtJDhrWCeATYq9srbvZ/OhF32CGu8wtopdl1lY
         jLZBqm/5hMInID+rqzyxyMOK5gLHRnMiAIzoXHlGZZOipLDxvoZng4fStVa4mQNj5j/W
         4x4hIPDKOOX5pkz33N2ftql/o+0Kq3/F8g4R48YXCWNeZ3nnKXR4A2yRLjBwOMeSODEC
         j8bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+NaERK3t9jZbwruYt+KRN4CMKJa5ImYF22IDwr1nznw=;
        b=ow3yyH5i6k8A89rVUG+dqQjAd/9WJmOB+NHgGbvxjd+2Vj3L3tuJhNQpwDD2Xvv2QZ
         EGqne6IXwVtnjcHtmepQ1sykrk+irZczRGMGNzxEnHimdQXEC57jOrDKinbd4zZthef2
         wDOBuLkm0DXQXop9aOfjRpIC4LGVlFqdE0oVnidAmGcYmM0Qv9Kf+Zpgng8rXzFYYHNJ
         RaIYb+7nAioYWU+a+eoBnqYMZcfGXtPmaQqD0WyaI+oKEm1m5Bi29HHnlH86tfFA/+St
         gOZAeyuyVv0K1x9b4pw6jgA+NFMa3rhC8FUik6k9SLy+d5eIxI6yg8laYSnuJdCyNLvO
         7mFQ==
X-Gm-Message-State: ABuFfojrfqTGbP+cVuSXHVY+bGxUaTycKGM+MUR1IEKjWUZZKLPirJT0
        eg+lMik+0kQkoM+v2vEvukmKHUE6YkK8zNwvEiBbFA==
X-Google-Smtp-Source: ACcGV62LIGnlFhONcnkkngc9Z/V6ZuElp3ECouZgxaPIurUR5siO55nOgxPJndqL9ySAwpjVQFrAD6PLs+aiyDtWjzM=
X-Received: by 2002:aca:bf55:: with SMTP id p82-v6mr1857876oif.39.1539290390243;
 Thu, 11 Oct 2018 13:39:50 -0700 (PDT)
MIME-Version: 1.0
References: <20181011151523.27101-1-yu-cheng.yu@intel.com> <20181011151523.27101-8-yu-cheng.yu@intel.com>
In-Reply-To: <20181011151523.27101-8-yu-cheng.yu@intel.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 11 Oct 2018 22:39:24 +0200
Message-ID: <CAG48ez3R7XL8MX_sjff1FFYuARX_58wA_=ACbv2im-XJKR8tvA@mail.gmail.com>
Subject: Re: [PATCH v5 07/27] mm/mmap: Create a guard area between VMAs
To:     yu-cheng.yu@intel.com, Andy Lutomirski <luto@amacapital.net>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>, hjl.tools@gmail.com,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>, rdunlap@infradead.org,
        ravi.v.shankar@intel.com, vedvyas.shanbhogue@intel.com,
        Daniel Micay <danielmicay@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 5:20 PM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
> Create a guard area between VMAs to detect memory corruption.
[...]
> +config VM_AREA_GUARD
> +       bool "VM area guard"
> +       default n
> +       help
> +         Create a guard area between VM areas so that access beyond
> +         limit can be detected.
> +
>  endmenu

Sorry to bring this up so late, but Daniel Micay pointed out to me
that, given that VMA guards will raise the number of VMAs by
inhibiting vma_merge(), people are more likely to run into
/proc/sys/vm/max_map_count (which limits the number of VMAs to ~65k by
default, and can't easily be raised without risking an overflow of
page->_mapcount on systems with over ~800GiB of RAM, see
https://lore.kernel.org/lkml/20180208021112.GB14918@bombadil.infradead.org/
and replies) with this change.

Playing with glibc's memory allocator, it looks like glibc will use
mmap() for 128KB allocations; so at 65530*128KB=8GB of memory usage in
128KB chunks, an application could run out of VMAs.

People already run into that limit sometimes when mapping files, and
recommend raising it:

https://www.elastic.co/guide/en/elasticsearch/reference/current/vm-max-map-count.html
http://docs.actian.com/vector/4.2/User/Increase_max_map_count_Kernel_Parameter_(Linux).htm
https://www.suse.com/de-de/support/kb/doc/?id=7000830 (they actually
ran into ENOMEM on **munmap**, because you can't split VMAs once the
limit is reached): "A custom application was failing on a SLES server
with ENOMEM errors when attempting to release memory using an munmap
call. This resulted in memory failing to be released, and the system
load and swap use increasing until the SLES machine ultimately crashed
or hung."
https://access.redhat.com/solutions/99913
https://forum.manjaro.org/t/resolved-how-to-set-vm-max-map-count-during-boot/43360

Arguably the proper solution to this would be to raise the default
max_map_count to be much higher; but then that requires fixing the
mapcount overflow.
