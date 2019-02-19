Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD348C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A4762083B
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="GpBfEbrW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729267AbfBSRZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 12:25:55 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36520 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbfBSRZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 12:25:54 -0500
Received: by mail-qt1-f194.google.com with SMTP id p25so23767942qtb.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 09:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XAvQ2mTt6SpNCXODI4kI5sc5LbLNS3TwLZzKEYq6M+0=;
        b=GpBfEbrW4JgOdxkoE26D/K56Dsy4L8KcnQeAU7p6Hq1O13kKOLMbBVnZoaGTx9CLm7
         QtMvRYGIUNbp1leY/Febq1rVRy3iTVBSTMOo8D4J9Y4JrCSZyUeVTV5Vs1Rm9SPvbou7
         NQMiKH87DlE2ZqDJfyok2TUcrzpQBmUk47mY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XAvQ2mTt6SpNCXODI4kI5sc5LbLNS3TwLZzKEYq6M+0=;
        b=nAswFp0QDqgzDmsxkm9f9JLAqE8HcCDPjHTqOGiz21LZ+TA86ezrsWgOpjEbtNRWKF
         1psi7ZsJ8ynBcrgdm9XY0f3YKYys9cobY6WKdY8MNbedb7qvqnEFOpC4Fn6KNzH3O5H3
         +/nPQKooTtsALeCcQCn811+2bKIl/LvZebt0WLZUaL0MA1TjofnMPFMfh18mnca4dm+u
         LqxZoCadXThiSn3V6z2qORDwd9LrgBpvRRzAThv2LA+i0hdZ6/C2qyY0uExG60G3GfmQ
         IhrpQtSnZmdtJYDxaAYB8FJWUidlQqvW2pHKI0JS+QUqMMv7IKulKk+zrsWXeEp8gYL+
         aMGQ==
X-Gm-Message-State: AHQUAub0JN3NlFPf4j2HoiTLpLoryBYt/TyzEzt57wVJdIpKmA5foP7H
        g0MPQXVzjC/OpbAKRdL9dzghnw==
X-Google-Smtp-Source: AHgI3IYNbv/Uq0CszQQXu+oLi/+Z3Ow3xBuCbN6Qzt07nn5E3wvgVSFW0Du38FesjmGme+KvLpaIEQ==
X-Received: by 2002:ac8:166b:: with SMTP id x40mr23105654qtk.363.1550597152863;
        Tue, 19 Feb 2019 09:25:52 -0800 (PST)
Received: from localhost ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id j139sm9197250qke.26.2019.02.19.09.25.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 09:25:51 -0800 (PST)
Date:   Tue, 19 Feb 2019 12:25:50 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-kernel@vger.kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v2 1/2] Provide in-kernel headers for making it easy to
 extend the kernel
Message-ID: <20190219172550.GB239374@google.com>
References: <20190219060531.GA3263@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190219060531.GA3263@avx2>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 09:05:31AM +0300, Alexey Dobriyan wrote:
> > /proc/kheaders.txz
> 
> This is gross.

It is a bit gross, but it solves a long standing problem we have nicely. And
there's also /proc/config.gz.

> > The feature is also buildable as a module just in case the user desires
> > it not being part of the kernel image. This makes it possible to load
> > and unload the headers on demand. A tracing program, or a kernel module
> > builder can load the module, do its operations, and then unload the
> > module to save kernel memory.
> 
> Please explain how keeping headers on the filesystem is not OK due
> to "licensing and other issues" but keeping a module on the filesystem
> is OK.

In the Android ecosystem, the Android teams only provide a "userspace system
image" which goes on the system partition of the flash. This image is not GPL
and doesn't contain anything GPL. It is thus not possible to put kernel
headers on the system image and I already had many discussions on the subject
with the teams, it is something that is just not done. Now for kernel
modules, there's another image called the "vendor image" which is flashed
onto the vendor parition, this is where kernel modules go. This vendor image
is not provided by Google for non-Pixel devices. So we have no control over
what goes there. We do know that kernel modules that are enabled will go
there, and we do have control over enforcing that certain kernel modules
should be built and available as they are mandatory for Android to function
properly (and we can enforce this as a case of Android device compliance).

So this solves the problem rather nicely. It is also useful for non-Android
usecases where a linux-headers package needs to be installed for tracing
programs. With this feature, such a package install step is not needed.

> > > I can route it via bpf-next tree if there are no objections.
> 
> Please don't.

Why not? You do know that eBPF based compilation needs to process kernel
headers to build the eBPF program? This was primarily inspired by problems
with getting eBPF to work, but it also applies to other trace tools like
systemtap that build for a module backend. In fact for Android, I am planning
to have facilities to compile code for a module backend as well.

> IKHD_ST IKHD_ED are bogus artifacts as others mentioned.
> proc_create(S_IFREG) is redundant.
> seq_file.h is not needed as is THIS_MODULE.
> I'd say such data should live in their own section for easy extraction
> with "objdump -j", something /proc/config.gz never did.

Thanks for the suggestions, I will look into these and refresh my series. My
first priority right now is to make incremental builds work. Other than
these, other changes are mostly cosmetic so I can address them after. Of
course I will address everything before posting again.

 - Joel

