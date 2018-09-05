Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 942CCC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 11:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30C7220659
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 11:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="lsHfCx7F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30C7220659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbeIEQMK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 12:12:10 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34462 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727397AbeIEQMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 12:12:10 -0400
Received: by mail-lj1-f195.google.com with SMTP id f8-v6so5975803ljk.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 04:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uICETPQSbfhNJtjwfuh9flj/2Me5hbTHSjQ2WxyhSrE=;
        b=lsHfCx7FQDmZaWxwgJhS4iao6++sIN2dPgqS8fiznVmU3CyWf/Jm3y3QmPPHkVuaih
         YP8TSH3k5NXON59TT+qGQwd94bIqasjIac4zD6G+WCfZxr/P/rqJxiLyQrH7bAOPL1S3
         K88A3SVk7HiWSqG4qyWymcow3Qbc7NRtbFaP0l5oFcALllQuCAwmrbEd2fmArydVVZAf
         qL9Bwzqt/4ai8jvljUeNIhVKsfwoniHvv0K7GvCKE1ibSEWg+83svDUPcvEVlEnwO86Q
         yGoS0SVcmQ9MbeIajhcs9jYvqU6VTVnA5Qq7gnR0I2DJl8nrbB+Heo2/VXUJLIr6cT92
         XF6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uICETPQSbfhNJtjwfuh9flj/2Me5hbTHSjQ2WxyhSrE=;
        b=d7gDX4kk5mKMhNi4iKryubTE0Q3I8rZs1lVdVbM6ERZWsaI66ellJChvN2YV8LFnsQ
         7e/LRNvNW7L1GenhDrtJ3bvlFLhbO9HSan4yJ1zWRDy0X8CUCXlcaVkQtkkcPFFwAY3f
         J3+N/XYKy3/VPwkgkYka2j8nc/q8twJd41vFG+nSK7kJD1AEytDnJU28+Ari8h4JFDdz
         rGPXMdFGDxJhePgmlKqZswfmXrZ9MEYQdRVQ79rOprHLS9ZTbi3dkobzubT+WT/UOWrA
         z/aYXVEetr4HA2KXRwCgWOv7wgOBQlT6zbb2+ccEM5xTAxZYWh7ulMSGtpJKO35CLOOc
         lX3A==
X-Gm-Message-State: APzg51DGdT5j467VDuTs9HrOMF4aRR8ssb/MkHDqVZBQtyYpGA1ALJYf
        ZEu/A8rJYMSTt/T8cyEyo6yHLWo/sxyRoIae7UmX
X-Google-Smtp-Source: ANB0VdavlWKBNXeJJyBdfH82008cZr9tDmHM/lKPXcFgrwy9Utl1qet2pSQA4qjjJvlExUP1oMKeu6jtw7GIB8IQ/U4=
X-Received: by 2002:a2e:97c8:: with SMTP id m8-v6mr24653282ljj.52.1536147736058;
 Wed, 05 Sep 2018 04:42:16 -0700 (PDT)
MIME-Version: 1.0
References: <1536012923-16275-1-git-send-email-henrik@austad.us>
In-Reply-To: <1536012923-16275-1-git-send-email-henrik@austad.us>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 5 Sep 2018 07:42:04 -0400
Message-ID: <CAHC9VhR7Zana3xTEj2jUGXb+hBzyh69g0rBg_p_4tkbjtCUdpw@mail.gmail.com>
Subject: Re: [PATCH] [RFC v2] Drop all 00-INDEX files from Documentation/
To:     henrik@austad.us
Cc:     linux-doc@vger.kernel.org, corbet@lwn.net, bhelgaas@google.com,
        paulmck@linux.vnet.ibm.com, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, axboe@kernel.dk, robh+dt@kernel.org,
        mark.rutland@arm.com, b.zolnierkie@samsung.com,
        linus.walleij@linaro.org, davem@davemloft.net, isdn@linux-pingi.de,
        yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com,
        ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org,
        jejb@parisc-linux.org, deller@gmx.de, rjw@rjwysocki.net,
        len.brown@intel.com, pavel@ucw.cz, benh@kernel.crashing.org,
        paulus@samba.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, gregkh@linuxfoundation.org,
        jslaby@suse.com, broonie@kernel.org, tglx@linutronix.de,
        pbonzini@redhat.com, rkrcmar@redhat.com, zbr@ioremap.net,
        hpa@zytor.com, x86@kernel.org, akpm@linux-foundation.org,
        raven@themaw.net, jacek.anaszewski@gmail.com,
        rppt@linux.vnet.ibm.com, jjj@gmx.de, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-ide@vger.kernel.org,
        netdev@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-mips@linux-mips.org, linux-security-module@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-pm@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-spi@vger.kernel.org, kvm@vger.kernel.org, haustad@cisco.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 3, 2018 at 6:15 PM Henrik Austad <henrik@austad.us> wrote:
> This is a respin with a wider audience (all that get_maintainer returned)
> and I know this spams a *lot* of people. Not sure what would be the correct
> way, so my apologies for ruining your inbox.
>
> The 00-INDEX files are supposed to give a summary of all files present
> in a directory, but these files are horribly out of date and their
> usefulness is brought into question. Often a simple "ls" would reveal
> the same information as the filenames are generally quite descriptive as
> a short introduction to what the file covers (it should not surprise
> anyone what Documentation/sched/sched-design-CFS.txt covers)
>
> A few years back it was mentioned that these files were no longer really
> needed, and they have since then grown further out of date, so perhaps
> it is time to just throw them out.
>
> A short status yields the following _outdated_ 00-INDEX files, first
> counter is files listed in 00-INDEX but missing in the directory, last
> is files present but not listed in 00-INDEX.
>
> List of outdated 00-INDEX:
> Documentation: (4/10)
> Documentation/sysctl: (0/1)
> Documentation/timers: (1/0)
> Documentation/blockdev: (3/1)
> Documentation/w1/slaves: (0/1)
> Documentation/locking: (0/1)
> Documentation/devicetree: (0/5)
> Documentation/power: (1/1)
> Documentation/powerpc: (0/5)
> Documentation/arm: (1/0)
> Documentation/x86: (0/9)
> Documentation/x86/x86_64: (1/1)
> Documentation/scsi: (4/4)
> Documentation/filesystems: (2/9)
> Documentation/filesystems/nfs: (0/2)
> Documentation/cgroup-v1: (0/2)
> Documentation/kbuild: (0/4)
> Documentation/spi: (1/0)
> Documentation/virtual/kvm: (1/0)
> Documentation/scheduler: (0/2)
> Documentation/fb: (0/1)
> Documentation/block: (0/1)
> Documentation/networking: (6/37)
> Documentation/vm: (1/3)
>
> Then there are 364 subdirectories in Documentation/ with several files that
> are missing 00-INDEX alltogether (and another 120 with a single file and no
> 00-INDEX).
>
> I don't really have an opinion to whether or not we /should/ have 00-INDEX,
> but the above 00-INDEX should either be removed or be kept up to date. If
> we should keep the files, I can try to keep them updated, but I rather not
> if we just want to delete them anyway.
>
> As a starting point, remove all index-files and references to 00-INDEX and
> see where the discussion is going.
>
> Again, sorry for the insanely wide distribution.
>
> Signed-off-by: Henrik Austad <henrik@austad.us>
...
> Signed-off-by: Henrik Austad <haustad@cisco.com>
> ---
>  Documentation/00-INDEX                  | 428 --------------------------------
...

Looks reasonable to me, you can add my ACK for the NetLabel bits.

Acked-by: Paul Moore <paul@paul-moore.com>

-- 
paul moore
www.paul-moore.com
