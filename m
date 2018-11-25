Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD74C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 05:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4125520855
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 05:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vYXXJbap"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4125520855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbeKYP6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 10:58:00 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:38235 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727174AbeKYP6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 10:58:00 -0500
Received: by mail-it1-f193.google.com with SMTP id h65so22847450ith.3;
        Sat, 24 Nov 2018 21:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VVUtrEXZA+jRPL+fVbmJthoajvPk69C0Kd+Rm2/KstQ=;
        b=vYXXJbapH/+kHOwdAsgQJjBZFg1A/8PyjY2TL3FaU0OIIg1uLQVItXaMPbyIM45X4T
         /Rb6ISaMhvFopBImLt+RpgZh8wdnhCfYdHxcasoI/C8UVpQk/0963+LZW2Bb3Ls6Y1bk
         HFvDaXxsuYBt+syfaS4qeupM7GHCJAYt7cOl//LhU0nxFuO3tGIbo0Rc9Azzf3hefA2c
         YOQQRQlqRINtLowTROqYUmmCa+mn6ZiOThp5JzZ4+CuFKGJr/TreXsDHdJ8KC1IZ2SEy
         lhPNLox/O1PVHWx3U/B2HlMyG2Bahat5BXb7kJY9LHrs1Vs+97w71EX8vEXAFlvrW2xg
         u+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VVUtrEXZA+jRPL+fVbmJthoajvPk69C0Kd+Rm2/KstQ=;
        b=d7DKCSU7oKTR6PIxLFEINhRCBMWXUwJv37PSgzlRvgDOIhwMiO7tydEiVNmPTi0u0a
         OdyWSV+36ZBvvBq7y8eKwPRhmWn23MHqTpZcPFZ/GiQZ28jZaQEpl/JHVgJAPjsKywap
         OxnRG9xnoyNleEJUL2H7KJuYeZYx6E5VCdX1LQAEi6Fvb2L2ySJogkLsDcd+lHziY8Z5
         zfabUh59+fa80J2uP81D6pgZGO0b7f75lsZgsJ7+N8hF08IvkdEKVznoS+9xU+avZLNj
         UtfWNsAQRxx1Zu46Y/KZ9lbbIP4DOPsKOZV5ONf5fJQkFkgqMdpgVuXZYbVkDkZst5X1
         p/NA==
X-Gm-Message-State: AGRZ1gL7aCMIEpSK4YA2OtleGukNix+svknQ1bZr+U7lEJapQdchWLCC
        lLNqajVLTsfp11phyLOJ1o91Lbve3+5+37C6Ix5WIQ==
X-Google-Smtp-Source: AJdET5cAruM4G6eXFV0rMhyoQQNI681CgpHx5fkqW8a1sDCvbgRkOQ917/fybeS+wBhhzxKm1KpM3LygAI8L5tSnx9A=
X-Received: by 2002:a24:a64f:: with SMTP id r15mr18647950iti.101.1543122466274;
 Sat, 24 Nov 2018 21:07:46 -0800 (PST)
MIME-Version: 1.0
References: <20181124022035.17519-1-deepa.kernel@gmail.com>
 <20181124022035.17519-9-deepa.kernel@gmail.com> <CAF=yD-Jz8c2EsoKxUDbf7dygWRW49kwteUsksq3eUV00Eg94-w@mail.gmail.com>
In-Reply-To: <CAF=yD-Jz8c2EsoKxUDbf7dygWRW49kwteUsksq3eUV00Eg94-w@mail.gmail.com>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Sat, 24 Nov 2018 21:07:35 -0800
Message-ID: <CABeXuvoRPAFa5v86pp+WmBkjzbHZSJqjzibL1+Zx8Uas6bvohg@mail.gmail.com>
Subject: Re: [PATCH 8/8] socket: Add SO_TIMESTAMPING_NEW
To:     willemdebruijn.kernel@gmail.com
Cc:     "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Network Devel Mailing List <netdev@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Chris Zankel <chris@zankel.net>, fenghua.yu@intel.com,
        rth@twiddle.net, Thomas Gleixner <tglx@linutronix.de>,
        ubraun@linux.ibm.com, linux-alpha@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-ia64@vger.kernel.org,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org,
        sparclinux <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +               new_tstamp = sock_flag(sk, SOCK_TSTAMP_NEW);
> > +               if (new_tstamp)
>
> nit: no need for explicit variable

Sure, will drop it.

-Deepa
