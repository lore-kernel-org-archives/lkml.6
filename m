Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA3DC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 00:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94A9F208B7
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 00:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cRtsjihw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94A9F208B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbeH1Ekl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 00:40:41 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:45457 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbeH1Ekk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 00:40:40 -0400
Received: by mail-oi0-f65.google.com with SMTP id t68-v6so1491198oie.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 17:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V5V+MaoytbLc+NEJcwsww/0a5U5p1xoji8AQBDvZziY=;
        b=cRtsjihw9yIPb76tGnGEJc0XD4nN7teaVkb/vHK2vWANtCA3jvZgJo6Jpg5K/3Z/pz
         tuC5GS12Piy6w63CQrfw3/+9sGMWpKlBgYNsXzCDpDNe2WAuF4lx0OhbX78+2SNe1np9
         uF/RIvb8z9iFOkiR7Dma543EUtyNVEiHlB1uYPsr8klm7XX3DQ5fWzbgJjhdsoi/N8k/
         mLblnK3NZXFFiZACZWGrPOdMWmoBKDOV5lb2Hb1vkc2gQc0roG32jIOCgeMqT3qN70Er
         S904wgWaIBIOU02V4L5aJYvHATAUL/5K+p0dKogAgZWlvFckWYAkhd21IbG86laI7p2V
         tjFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V5V+MaoytbLc+NEJcwsww/0a5U5p1xoji8AQBDvZziY=;
        b=TLYOb5lWF+4f+KkzgWXaiQ9loWO+c0eQ7KiC8bIHwaJx8I/R3N7/PHHsHwq1DpQ8nm
         QbjLZbcsET2n+ViJqkB/kzlmRb1gk1e6rZPHh6Xo+rOg1GGHgpGxKnH13+XwQVaF/aYC
         euxlKhKZcJYhjIl+dpMiSOR72Wm1ubEm9tkkbLpvEzpe+1Yefrye61Dg/vtYgn9/ibG6
         2KQSVDYB9MaFMh93mBaKPp/VMpxvqU4SmT8EDNW9yIMBqngEcnvIxEl6cZmFEE2HTbU7
         2lP4QJY0viIbvbhdZ2KB4UdFf3u3ncU3KrTl2AO1cF3Y9kJlMKY+llkjKzzbT3e2kZXh
         /a1A==
X-Gm-Message-State: APzg51BAD0/MqiUOTHVO3FzHH0YYaLMZE+ild6DDHVT2MFUrl0ODqKPJ
        ck+MC39NjinheI3+wkJtMqf07NAIPzSq4OhMogLr8g==
X-Google-Smtp-Source: ANB0VdZchJ8CyeRPkWz92wd+eDVAAT+/xKtSNuUy1EtmPxuCQQjiq9Mb0ZdYWBLYL+Yo2oOuO8xjUp1Htps6J6wp3D8=
X-Received: by 2002:aca:4204:: with SMTP id p4-v6mr850423oia.242.1535417497144;
 Mon, 27 Aug 2018 17:51:37 -0700 (PDT)
MIME-Version: 1.0
References: <20180827185631.163506-1-jannh@google.com> <20180827185631.163506-7-jannh@google.com>
In-Reply-To: <20180827185631.163506-7-jannh@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 28 Aug 2018 02:51:10 +0200
Message-ID: <CAG48ez2ScPzTM-0JOmops7ae6zotF=sYbP5hDZHJ=0=EuzQk8w@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] x86: BUG() when uaccess helpers fault on kernel addresses
To:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        tony.luck@intel.com, Borislav Petkov <bp@alien8.de>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>, linux-edac@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 8:58 PM Jann Horn <jannh@google.com> wrote:
>
> There have been multiple kernel vulnerabilities that permitted userspace to
> pass completely unchecked pointers through to userspace accessors:
>
>  - the waitid() bug - commit 96ca579a1ecc ("waitid(): Add missing
>    access_ok() checks")
>  - the sg/bsg read/write APIs
>  - the infiniband read/write APIs
>
> These don't happen all that often, but when they do happen, it is hard to
> test for them properly; and it is probably also hard to discover them with
> fuzzing. Even when an unmapped kernel address is supplied to such buggy
> code, it just returns -EFAULT instead of doing a proper BUG() or at least
> WARN().
>
> This patch attempts to make such misbehaving code a bit more visible by
> refusing to do a fixup in the pagefault handler code when a userspace
> accessor causes #PF on a kernel address and the current context isn't
> whitelisted.

Kees noticed that when you have vmapped stacks on (I was testing with
KASAN, so I couldn't enable vmapped stacks), exact_copy_from_user() in
copy_mount_options() is incompatible with this patch when used on
kernel pointers. do_mount_root() and devtmpfsd() call kys_mount() with
kernel pointers. So I'll have to either add that to the whitelist
and/or refactor the mount options copy logic first (so that it uses
strncpy_from_user() as long as the data argument isn't binary data).

I've wanted to fiddle with that code anyway - silent truncation at
0xfff bytes isn't very robust, especially when suid binaries call
sys_mount() with a partly user-controlled options string...
