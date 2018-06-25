Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B17CC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 07:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE2EB25500
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 07:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hui9thMT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE2EB25500
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752139AbeFYHG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 03:06:58 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:39901 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750825AbeFYHG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 03:06:56 -0400
Received: by mail-ot0-f194.google.com with SMTP id l15-v6so13923924oth.6;
        Mon, 25 Jun 2018 00:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=78B80lqyCdaQRIOd9eZdeAeKlDrLBqCZ2fqi/kCkAxg=;
        b=Hui9thMTnMsXrFn48UNyY66H6wdf7nlPrhtPXzlYxqgCh7ZRAfFn513BtqKboc67Nm
         EFNTIv2Md2im1Qf98Z6ceWL5PGi8RdVBmjP5uicNnHUYj/mO9zhhZNuDXLlYclm5+m+7
         H6debFCEVjLf4zyarTRAbEqXF7CdQzffvp6kGZmeC9rdBVx2/LxKZhyeqN1RUdr8BWZI
         U39eOahEqG/K8k3kvaauWiLnfaLlnWt7Yq69SOwgGe0LbkFpmCknjoLOKMzrM+MHpYtl
         9O4K/NnRwLa5svjzjiLmG/WeL8wXXAwXkYFqwystQWlxrpadQe3bEOaJ3ztBLbgoDyNk
         5KVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=78B80lqyCdaQRIOd9eZdeAeKlDrLBqCZ2fqi/kCkAxg=;
        b=kFaew9/nG3asGPoQNEVye8KQ9PdaSi9HadZNid3OR1Yxkei3mEyQWRG/Rz4LKqCcwK
         seRE9o+wvElfU1RXgbLeEa8LTcZJvcOEdHtuuVMivvSwfFxjmKKNrD+ZkKBClsZkf0Yh
         KxNE/sxRD2BrWv128hJh1k00tEdXEr1cxF37RBrULGP00YjSegRopnaPglUniqnXibHf
         qtf3s7VYhIA9tgBBstuBeISFn3Kh2IuS/oVNxmtHwW2jjBVkHld88NRVB+PSUKjH8iPu
         mw+B07ulOfZ0N0HtbqHLC5fgpsYLa3j68I+XocuHQJvEsHZGPzpgMIlR+mtnpS9gcTvJ
         BMSQ==
X-Gm-Message-State: APt69E1yZUgv+1H1VJKrZml3rGLtExyjkzsTscOezPG9j+eBoG0Pe5V5
        KxuMwNh8OOjiyehxr5oEfpU0rUDzt6OCpzK86tw=
X-Google-Smtp-Source: AAOMgpdpblxReLFkv6Wcjd7ED80xvs6g2v6xT3n+ezHKJ8p/yIoMjcXT+SE21CYNJ7BkJjc8Hpr6mDJLx5Z7ibh21cc=
X-Received: by 2002:a9d:3e4c:: with SMTP id h12-v6mr2258284otg.150.1529910415720;
 Mon, 25 Jun 2018 00:06:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1429:0:0:0:0:0 with HTTP; Mon, 25 Jun 2018 00:06:55
 -0700 (PDT)
In-Reply-To: <20180621190401.GA14623@amd>
References: <cover.1529486870.git.yu.c.chen@intel.com> <78af30838d0bac69bdd6e138b659bcbb8464fd13.1529486870.git.yu.c.chen@intel.com>
 <20180621090142.GB21807@amd> <CAJZ5v0hDhsxwU4X6_dCqc7P5GaTtpBeMUeJTHo9YJ8QtWinYfg@mail.gmail.com>
 <20180621190401.GA14623@amd>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 25 Jun 2018 09:06:55 +0200
X-Google-Sender-Auth: WME9OwgT7KMAl3G4qd1G6uReTgo
Message-ID: <CAJZ5v0jQQ7neWDc_cy5ZJPVJp155BLF7fQFmeNJ3Nn0Jho7AeA@mail.gmail.com>
Subject: Re: [PATCH 3/3][RFC] tools: create power/crypto utility
To:     Pavel Machek <pavel@ucw.cz>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Chen Yu <yu.c.chen@intel.com>, "Ted Ts'o" <tytso@mit.edu>,
        Len Brown <len.brown@intel.com>,
        "Lee, Chun-Yi" <jlee@suse.com>, Borislav Petkov <bp@alien8.de>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Stephan Mueller <smueller@chronox.de>,
        Eric Biggers <ebiggers3@gmail.com>,
        Denis Kenzior <denkenz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 9:04 PM, Pavel Machek <pavel@ucw.cz> wrote:
> On Thu 2018-06-21 14:10:06, Rafael J. Wysocki wrote:
>> On Thu, Jun 21, 2018 at 11:01 AM, Pavel Machek <pavel@ucw.cz> wrote:
>> >
>> >
>> > On Wed 2018-06-20 17:40:51, Chen Yu wrote:
>> >> crypto_hibernate is a user-space utility to generate
>> >> 512bits AES key and pass it to the kernel via ioctl
>> >> for hibernation encryption.(We can also add the key
>> >> into kernel via keyctl if necessary, but currently
>> >> using ioctl seems to be more straightforward as we
>> >> need both the key and salt transit).
>> >
>> > Ah, here you go:
>> >
>> > https://en.wikipedia.org/wiki/Uswsusp
>>
>> No, not really.
>>
>> > It can already do encryption. If you see problems there, patches will
>> > be gladly accepted to fix them.
>>
>> By whom?
>
> By me.

Well, OK

Where's the repository the patches will go to when you accept them?

>> > If you want to maintain uswsusp in kernel tree, I guess that would be
>> > an option, too.
>>
>> No, it isn't an option due to the dependencies on crypto libraries.
>
> Why not?

You need a specific set of devel libraries for the utilities to build
and that need not be present on all systems I suppose?

Besides, s2disk is currently tangled with s2ram which is obsolete, so
I'd rather not.
