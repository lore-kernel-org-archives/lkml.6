Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A395C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16F0A20818
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DnGmLbjq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbfBKWew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 17:34:52 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37364 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbfBKWew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 17:34:52 -0500
Received: by mail-lj1-f193.google.com with SMTP id r10-v6so479264ljj.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 14:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VSJeR1wQHl+/Y6Al2Tu3jSZ2Tpf/taeD5pL7B97K/BQ=;
        b=DnGmLbjqFtXjQGckwV7pLTn2TyqePjqJeRG1QT7iitWet3l7RmdOWMZyDWuho7CeGD
         MoxxRoNtu3WF/l0nIaWg+FK48JUmA82Lwy6QD57psIXK31ERY8Va7kLyXZdXUkbEHC3d
         fv6WriFc2HsnjZ9wPLdDjxYYW04cehfVMm1G0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VSJeR1wQHl+/Y6Al2Tu3jSZ2Tpf/taeD5pL7B97K/BQ=;
        b=lcB+MFvISFVlo+TmB875Qya3WHHlFfodL0wK1YZXGYaxxhctCMPzcnw//aL58v1lgd
         gD4XkWpLP0pjjMGWDouR8AY6mrZNKit74u7WUE5quDizP+gb0SlUKi1+PCvUedhailEa
         7kzr307GgeDLnXhTY6S6F9F3C19COBsNxZ5I/hN86GgU6tqI4Yrqk1icq/VGpVcgvaBz
         DRTHAp4lKjH76OgVh142Gr4iPO6ssuCFD+DMEBcg7PyXe9HNxywPX6oRYGzlZQbAO2GW
         M38aFopusPA/V0xZpwe7fYbRYcySWn94szdcZJ5n8Mjnh7KZ+HNdGSrcPOhZRg8y7TPE
         9PKw==
X-Gm-Message-State: AHQUAuZqNNbmcYNYwm+351Dqz8DLaRp2SQ9pORpp9zPAqbpi9wsivbze
        tYAJtjPnGQMx/xllAJyGrd65kIugLcA=
X-Google-Smtp-Source: AHgI3Ia5Jo8CE3fyC5uV3DFEEyVvUvlhL+bGcdMZPwtfN3uZkzmARu+k0LQg7o7d2JPxi8Vu7WTYmQ==
X-Received: by 2002:a2e:9944:: with SMTP id r4-v6mr269936ljj.185.1549924489414;
        Mon, 11 Feb 2019 14:34:49 -0800 (PST)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id m10-v6sm2367755ljj.34.2019.02.11.14.34.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 14:34:48 -0800 (PST)
Received: by mail-lj1-f171.google.com with SMTP id j13-v6so494018ljc.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 14:34:48 -0800 (PST)
X-Received: by 2002:a2e:880a:: with SMTP id x10-v6mr321289ljh.174.1549924487924;
 Mon, 11 Feb 2019 14:34:47 -0800 (PST)
MIME-Version: 1.0
References: <20190211172948.3322-1-will.deacon@arm.com>
In-Reply-To: <20190211172948.3322-1-will.deacon@arm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 11 Feb 2019 14:34:31 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiP42aqBApAUJbLAB43u5ips9ArgLxXn5L1r74bowxdow@mail.gmail.com>
Message-ID: <CAHk-=wiP42aqBApAUJbLAB43u5ips9ArgLxXn5L1r74bowxdow@mail.gmail.com>
Subject: Re: [RFC PATCH] docs/memory-barriers.txt: Rewrite "KERNEL I/O BARRIER
 EFFECTS" section
To:     Will Deacon <will.deacon@arm.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 9:30 AM Will Deacon <will.deacon@arm.com> wrote:
>
> +
> +     1. All readX() and writeX() accesses to the same peripheral are ordered
> +        with respect to each other. For example, this ensures that MMIO register
> +       writes by the CPU to a particular device will arrive in program order.

Hmm. I'd like more people look at strengthening this one wrt across
CPUs and locking.

Right now we document mmiowb(), but that "documentation" is really
just a fairy tale. Very *very* few drivers actually do mmiowb() on
their own.

IOW, we should seriously just consider making the rule be that locking
will order mmio too. Because that's practically the rule anyway.

Powerpc already does it. IO within a locked region will serialize with the lock.

                Linus
