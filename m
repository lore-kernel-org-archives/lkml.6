Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C8F3C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 02:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC202241CF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 02:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ofZmo0/v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC202241CF
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755886AbeFZCqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 22:46:23 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:41498 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755848AbeFZCqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 22:46:21 -0400
Received: by mail-oi0-f66.google.com with SMTP id 21-v6so3870655oip.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 19:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OzBmhIJfAsVeBzxgrm8gIPWnnYbiLu0ldeO1S5DsT2E=;
        b=ofZmo0/voErzFZ3IpaK5RMnKcZRmY5BYUFmXeR2F9pDttZGjfViZE4pupYv5oPbi1I
         1TgK8pM4R9U4aaEr14d1GKOuEz1lnC64/WdCr2jCEnZHt64nLhENiF/ekX1bLxOxO4bb
         49SLBofHeVK8vAbzArMxl0vwQXdzG5YGmxA3vmoIJ1Bms3FkMGYvnBv4/btAcdq3sceK
         xA2a2x64p8xuAY7vJi0XCHzQzg2CQyOIFC45tUKHRBgzetBv4nZnaZLLiICK5xuSjHqN
         6H3yF7I21p5x8JpVeetDViSoy2US5W7AccZdwrHxW1aIT2QZJCFQOyxJytCeetvrkA8m
         UjSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OzBmhIJfAsVeBzxgrm8gIPWnnYbiLu0ldeO1S5DsT2E=;
        b=Klaqrbm8PBG42wTYcriGg7KaqvXbzIWrfM3YpxNIDmmZFF+6FK6OXnrb9KvIg29HCe
         ktOQ0yg3l7Z4sh2YlNlfBIsiFbIEirAGQnF/OeCOFkLimWtNbg9boOJZqx8rvIH06cBB
         aEE9KC59SZRpeUfcsGvfTYAyH9Q/0OLoQbU/93orsmD7DmwwtXDc4Ex4a7LHPdKSznZ2
         CShCBHfI9ENp84uCjdlkcr5ml3te7RCdnnggAl6Oy7VwRzZJHYq440F6RwAupVlRCelv
         ZNUnuTLsNk9XvBqe2UDsAG1RbelPTmXffBp+Vnalr4ZDVPclumKJIM/4kZ1msYJPgSSE
         333A==
X-Gm-Message-State: APt69E3Vc3Bjai6tjG0V52nP7DEoz+QXISq3edEz2SVqk2ewPzUsxHBT
        IftqzqBY6aW6m6YrF3vJd12xsabKuatexxmi0mrAZZ0S
X-Google-Smtp-Source: AAOMgpfqIGHEjuEqfBINciovziEyeINMswDeDEVfIHTLHD8vysqSJu+hNFsjb2gEiGmi5cPlDVpD33peLPNQSqbkl2A=
X-Received: by 2002:aca:5bd5:: with SMTP id p204-v6mr8848946oib.91.1529981180502;
 Mon, 25 Jun 2018 19:46:20 -0700 (PDT)
MIME-Version: 1.0
References: <20180607143807.3611-1-yu-cheng.yu@intel.com>
In-Reply-To: <20180607143807.3611-1-yu-cheng.yu@intel.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 26 Jun 2018 04:46:08 +0200
Message-ID: <CAG48ez2puLWrDDPg=ighCY+yxFoP-nN97MqVseqYabBad+eKmg@mail.gmail.com>
Subject: Re: [PATCH 00/10] Control Flow Enforcement - Part (3)
To:     yu-cheng.yu@intel.com
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, hjl.tools@gmail.com,
        vedvyas.shanbhogue@intel.com, ravi.v.shankar@intel.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Mike Kravetz <mike.kravetz@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 4:45 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>
> This series introduces CET - Shadow stack
>
> At the high level, shadow stack is:
>
>         Allocated from a task's address space with vm_flags VM_SHSTK;
>         Its PTEs must be read-only and dirty;
>         Fixed sized, but the default size can be changed by sys admin.
>
> For a forked child, the shadow stack is duplicated when the next
> shadow stack access takes place.
>
> For a pthread child, a new shadow stack is allocated.
>
> The signal handler uses the same shadow stack as the main program.
>
> Yu-cheng Yu (10):
>   x86/cet: User-mode shadow stack support
>   x86/cet: Introduce WRUSS instruction
>   x86/cet: Signal handling for shadow stack
>   x86/cet: Handle thread shadow stack
>   x86/cet: ELF header parsing of Control Flow Enforcement
>   x86/cet: Add arch_prctl functions for shadow stack
>   mm: Prevent mprotect from changing shadow stack
>   mm: Prevent mremap of shadow stack
>   mm: Prevent madvise from changing shadow stack
>   mm: Prevent munmap and remap_file_pages of shadow stack

Shouldn't patches like these be CC'ed to linux-api@vger.kernel.org?
