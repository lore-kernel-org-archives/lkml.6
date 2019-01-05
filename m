Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C2EC43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 19:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EBF6222FB
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 19:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VmxmtenY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfAETut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 14:50:49 -0500
Received: from mail-lj1-f171.google.com ([209.85.208.171]:32833 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfAETut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 14:50:49 -0500
Received: by mail-lj1-f171.google.com with SMTP id v1-v6so35118183ljd.0
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jan 2019 11:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3gtEwaNEjdCPGtTV4trcD0HAWT7H2A0cIc7LlFZEwkA=;
        b=VmxmtenY0hqZ43PiYoxT6Af0o//0e6oNsWTVsnZU9p5aoauCFoF/yN8ifsNeHxQFDf
         3JRiLxvtKiG1Q7ByKKjj5xV4EV4St/RySjEaDLuE4qmmD/u8r1fP7gDRwWKCQC3AbkeK
         4neRr9b86Gpjk5I1bvrQ8wrtQRQEVRp3AmlXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3gtEwaNEjdCPGtTV4trcD0HAWT7H2A0cIc7LlFZEwkA=;
        b=gtdXuE8t2g/p2i/f/0yOFkbBBm1dwERy1p78oejK1M2EOQ0qpbq3nqBcNceZh+HAMw
         A/FCTIFsMWV/uKxk3Hw4SZhSAHaFTJ1Lb3GkOGJMb8SD0KhqbVYME2zvaMIfz18KOLgr
         5tK587FwMIaJQeVO1JAr6kgWaVI+Qsah7IZGNWKqCaQHkj9SqvK50kGdgcCc34LXFaU1
         u+IM3H6P+Pm/xsY1+QyKd9HMBmS5oXzjEkfTvuo2rlWi6eIEtNufYIe9veShEkPYQ72t
         SIElp3ygTU6efp5w6zQoXY88qzOl5EPPEXDx/DfODNkHGJhgCxDm1gJhqWWIuMPeLA0n
         U7Rg==
X-Gm-Message-State: AJcUukcsACJRZlLr/7n/AKMufJeykoseiMdZy8MjK/+rCy9qOo/JEp8M
        aKREBPPNiZkgcROdAIQ3cU9I5js8mok=
X-Google-Smtp-Source: AFSGD/U7EInIZ53NKi8Jc4EQcqmd+kc4sxNXK9mSXW7PLQFclngjCEIB4BO3/2JyY2zGW/39l+s1OA==
X-Received: by 2002:a2e:2c02:: with SMTP id s2-v6mr31179713ljs.118.1546717846751;
        Sat, 05 Jan 2019 11:50:46 -0800 (PST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id b21sm11750297lfi.7.2019.01.05.11.50.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Jan 2019 11:50:45 -0800 (PST)
Received: by mail-lj1-f173.google.com with SMTP id t18-v6so35068233ljd.4
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jan 2019 11:50:45 -0800 (PST)
X-Received: by 2002:a2e:2c02:: with SMTP id s2-v6mr31179695ljs.118.1546717845563;
 Sat, 05 Jan 2019 11:50:45 -0800 (PST)
MIME-Version: 1.0
References: <87ftu8y3vw.fsf@concordia.ellerman.id.au> <877efjxquj.fsf@concordia.ellerman.id.au>
In-Reply-To: <877efjxquj.fsf@concordia.ellerman.id.au>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 5 Jan 2019 11:50:29 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiE-_Dc7FDirP=_QGYt6pU7TEYdbGhCTeDnasj5s1uOOQ@mail.gmail.com>
Message-ID: <CAHk-=wiE-_Dc7FDirP=_QGYt6pU7TEYdbGhCTeDnasj5s1uOOQ@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-4.21-2 tag
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     chunkeey@gmail.com, diana.craciun@nxp.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, Mathieu Malaterre <malat@debian.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 5, 2019 at 3:53 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
> >   powerpc: Drop use of 'type' from access_ok() (2019-01-04 23:07:59 +1100)
>
> I see you've fixed this in your tree already.

No problem. It was my mess-up to begin with, and I just did the
obvious resolution (only difference between our fixes was whitespace,
and that I obviously also fixed up sparc32 as well).

                 Linus
