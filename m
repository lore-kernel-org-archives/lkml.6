Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B55EC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 02:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FA2C208A3
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 02:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cX0Opj4/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FA2C208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbeHBEZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 00:25:49 -0400
Received: from mail-qt0-f170.google.com ([209.85.216.170]:33461 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbeHBEZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 00:25:48 -0400
Received: by mail-qt0-f170.google.com with SMTP id c15-v6so786491qtp.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 19:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DI+B2P3VQU9YXIjVA0Oma6on3mGS7n30P/JW57SISD0=;
        b=cX0Opj4/Sp6E0JDEXPmdmTtWAFS8RC7pV6u498C3CRqI/cf+izl/6SJ5Fq4ltr/OZc
         vMjr3PiM557gwV+2QQnAgCsrX5rYvTQEBVRDeTYSYP7W++/KEL6OY16u2EZrB0Nu77r8
         O66/1uUYhOCdNDDn5Z+Lkt+JfdYUZPpu49p7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DI+B2P3VQU9YXIjVA0Oma6on3mGS7n30P/JW57SISD0=;
        b=mbDRTzFPeKKrx5ZxUZU+qM3fvxsl9tBD47TH9JEQOIptgb6mMkSH57E8eKm9YZOEdD
         HqBAXk0cxE93aB259pl4DE/CoB97rGkta60YHe+7X9cDc5MyPLq699EDCSK58G37BGOX
         vk25EPhJAQ//HEXndY+w48MvlkfTnLs7UPLCFCudqtOjIFrUQB3tgrPaMIdxEjCwD7A6
         8UdHqKbQe+tVXLS91yx2WQ8Z5td3lmfQODTNlFep6zXo79VDbixykIM/rDJhd/mGpod9
         CAQx72xWEAucobX0DvVzY+fhyKpMd9bSX/efy9adJElgrwVaw+JR7VYWJGBIGxihK6q6
         Xdxw==
X-Gm-Message-State: AOUpUlGtS1b+4kFbI+vWcIymlXOo0CP0EXj6LzqMbKtQjld0COmD0RgH
        uJxE/Pdd3Uwnj7OwyEJStWWW2C41QLw=
X-Google-Smtp-Source: AAOMgpevilrdfwfI8gslEhjd8c1yFeQPb/ho3lYOd6gpt2qAmIevv1JRTm+ksFzdP+aUiE4zr5qp8A==
X-Received: by 2002:ac8:302e:: with SMTP id f43-v6mr841642qte.217.1533177417218;
        Wed, 01 Aug 2018 19:36:57 -0700 (PDT)
Received: from localhost ([168.194.163.63])
        by smtp.gmail.com with ESMTPSA id r67-v6sm429935qkd.10.2018.08.01.19.36.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Aug 2018 19:36:56 -0700 (PDT)
Date:   Wed, 1 Aug 2018 23:36:54 -0300
From:   Rafael David Tinoco <rafael.tinoco@linaro.org>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Commit "new primitive: discard_new_inode()" introduces a problem
Message-ID: <20180802023654.t7xujjcv7ugq5ru4@mobile.celeiro.br>
References: <64a0f022-a32d-d4ee-7464-5c5ce0ebd222@virtuozzo.com>
 <20180801151937.GN30522@ZenIV.linux.org.uk>
 <96e3c195-aaca-9214-0dcd-5c2b970a72ae@virtuozzo.com>
 <20180801161151.GO30522@ZenIV.linux.org.uk>
 <20180801161648.GP30522@ZenIV.linux.org.uk>
 <20180801162739.GQ30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180801162739.GQ30522@ZenIV.linux.org.uk>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2018 at 05:27:39PM +0100, Al Viro wrote:
> On Wed, Aug 01, 2018 at 05:16:48PM +0100, Al Viro wrote:
> > On Wed, Aug 01, 2018 at 05:11:51PM +0100, Al Viro wrote:
> > > On Wed, Aug 01, 2018 at 06:43:56PM +0300, Kirill Tkhai wrote:
> > > > #git status
> > > > HEAD detached at 22dc9a168272
> > > 
> > > Wait a sec - just that commit?  With discard_new_inode() not even
> > > used anywhere?  Then any of those -ENOMEM is disguised ERR_PTR(-ESTALE)
> > > from find_inode()/find_inode_fast(), i.e. an inode found by
> > > iget5_locked() (your /etc is on ext4) with I_CREATING still set.
> > 
> > iget_locked(), that is.
> > 
> > > And that is set only by insert_inode_locked()/insert_inode_locked4(),
> > > and only until unlock_new_inode().
> > > 
> > > Could you slap WARN_ON(1) before these return ERR_PTR(-ESTALE) in
> > > find_inode{,_fast}() and see if that's what's getting triggered?
> 
> ... and I still can't reproduce it here - exact same tree, same .config,
> same reproducer.  The only difference is that it's a gcc-5 build, but
> I can do gcc-6 as well; doubt that it'll change anything.

I bisected an issue with our functional tests to this commit also.

LTP started failing for -next for tests depending on remounts to RO.

Link: https://bugs.linaro.org/show_bug.cgi?id=3957

Reproducer:

    # testfile = ext4 filesystem

    mount ./testfile /mnt
    rm -f /mnt/read-only
    touch /mnt/read-only
    mount -o remount,ro /mnt
    ls /mnt
    $ ls /mnt
    ls: cannot access '/mnt/read-only': Cannot allocate memory

Could not reproduce with xfs.

More information on investigation:

https://bugs.linaro.org/show_bug.cgi?id=3957#c3
https://bugs.linaro.org/show_bug.cgi?id=3957#c4

Trace of a failing acct (thought originally related):

https://bugs.linaro.org/show_bug.cgi?id=3957#c5
do_filp_open() -> path_openat() -> do_last() -> lookup_open()
(check ext4_lookup() and beyond)

I'm testing your patch right now. Will inform soon.

-Rafael
