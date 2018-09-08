Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD24C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 00:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0B7D20861
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 00:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sWN4Qj6l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0B7D20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbeIHFaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 01:30:35 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:32850 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725731AbeIHFaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 01:30:35 -0400
Received: by mail-oi0-f68.google.com with SMTP id 8-v6so30500000oip.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 17:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YouB2dXJf1Q+PNgUYnLSk3Ac8HJVjkZuxxNPGCrG8hI=;
        b=sWN4Qj6llDbbCBe2yFY3EAzw4ybI3dGd7rESqU0bPCq1kLz6wNga5iQkjrr6Yl689Q
         2ewTH3PhZcZrEsEjahQ2PVZf5soztu1MGLQ9BzBxrXu/kaaxgLmuK4l3KfswVjCcDhqH
         Bp1QvCg/8DFMOI8LuikxqiFOoMs8JmzrEqg/zT9l2DQTh8226jmxPGZzpNbLzXm1Owzw
         kfgLlcnehsdW3NlOy7T5vc1RDHbXR5AcoiKb7n9fr//BigKjBrYyhG9uGZ+adyPGhqg5
         jVwl6if9GtUIvWvGGzH38a10jpGGVoJOYgChuTZ9XySuZtqrxkBhYptyZubujELzzG0b
         2QdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YouB2dXJf1Q+PNgUYnLSk3Ac8HJVjkZuxxNPGCrG8hI=;
        b=POVB4GD3+zH2A+QOCGyZYiFRpYfo/u+8pjA3CITikEp03ti0/3fvJjQrnHBHpnR6mV
         r/Suy5BQNOEinIRSpLnaMHtRgnjzei/vkQNTQ/IBlwehNfZJfrxyEwAzSCVi5hVBZdNy
         S3Z6dhSqRbtuaTAfYzcM/FryXpTaNmM3y/lDaOendthT6DJm0/ciLo0gOqoH7/1h+Sh1
         F2Xq/e2HJzidJ/Nkl2Fu8bpKBx9v27QiGl3V+3Z+RLC54PZy12EgI7mYue2N9kJhuDIz
         8wDicJzEEuqRrwUNVGT/jWGTjrvFPlhaiUq+T4a6g84XG99u7dzIRvt6hY57rGZkGrN5
         EvIw==
X-Gm-Message-State: APzg51AB+AAE8efNQ5xJg0B4cgU0FODGA7gFYKXxTvJ9aCOfQxKD25o6
        Yr5uZdlZlpFkpl5eyZuDQlPFcrSsfpBaoqGOqlhwag==
X-Google-Smtp-Source: ANB0VdZfZCu/oiwYjqm+Jin9ebVZtjfmzBz+yMH4lA/e7EDnff8UJrJWGTj7DyFwRzEefRPvAhlEFT9XbEN5KRAh0H8=
X-Received: by 2002:aca:4204:: with SMTP id p4-v6mr9997436oia.242.1536367622774;
 Fri, 07 Sep 2018 17:47:02 -0700 (PDT)
MIME-Version: 1.0
References: <20180907194852.3C351B82@viggo.jf.intel.com> <20180907194901.C54A0101@viggo.jf.intel.com>
In-Reply-To: <20180907194901.C54A0101@viggo.jf.intel.com>
From:   Jann Horn <jannh@google.com>
Date:   Sat, 8 Sep 2018 02:46:35 +0200
Message-ID: <CAG48ez0FAizJH-4LivpMPSnZqDUeUq0XHf6K8cA4xCqkiPMNYw@mail.gmail.com>
Subject: Re: [RFC][PATCH 6/8] x86/mm: add vsyscall address helper
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        sean.j.christopherson@intel.com,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 8, 2018 at 2:25 AM Dave Hansen <dave.hansen@linux.intel.com> wrote:
> We will shortly be using this check in two locations.  Put it in
> a helper before we do so.
[...]
> +/*
> + * The (legacy) vsyscall page is the long page in the kernel portion
> + * of the address space that has user-accessible permissions.
> + */
> +static bool is_vsyscall_vaddr(unsigned long vaddr)
> +{
> +       return (vaddr & ~0xfff) == VSYSCALL_ADDR;
> +}

<bikeshed>
Since you're touching this code anyway: Would it make sense to change
that constant to a more explicit "~0xfffUL" (or alternatively
PAGE_MASK)? I tend to end up staring at code like this forever, trying
to figure out whether the upper 32 bits of the constant end up being
set or clear. As a reader, looking at the current code, it's quite
annoying to see what actually happens - first there's a signed 32-bit
literal 0xfff, then a 32-bit negation happens, and then the number is
converted to 64 bits with sign extension.
</bikeshed>
