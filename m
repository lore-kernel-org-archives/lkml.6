Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C57C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 17:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEE1220C0D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 17:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qU46W3Da"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEE1220C0D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389110AbeGKRzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 13:55:49 -0400
Received: from mail-oi0-f42.google.com ([209.85.218.42]:41659 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732456AbeGKRzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 13:55:49 -0400
Received: by mail-oi0-f42.google.com with SMTP id k12-v6so50798519oiw.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 10:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zYmOuBgrQ/vm5fUHaH+kEgVL+D0gLbXjrHyTqEbP1jk=;
        b=qU46W3DamO5CUd4Dh7nFfJdl8IwMhDzY9LDQp/irBm4v8GNdyVzOU4MSvizyFM0eEM
         VCimbDeoYl/zsMIE0ynOekmwlZRoCA3yWY1JvkolqnGefK1BZNaJoOaPJUuiu/YqFXkx
         gkaXtnJhEe6mAeuEn4A0rufU6rwq6Gyp7gqIW7JkDmAOOnlVvQYJvzJNgU/4xD46LaJb
         eh/cdhWN4nOIAO4j8rMDH73JCPKa8GGJeiAUPoVFtOooks+C6rdn5iyhFAxIvLdMnQWT
         6uTtvFvXS5oP9QEVWiOuryHKu73g8ypHIhfOMC3FR5KV6AjbhzN5Cz9AhDWLRkMLbU5f
         jrnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zYmOuBgrQ/vm5fUHaH+kEgVL+D0gLbXjrHyTqEbP1jk=;
        b=nC9OlC8j4EwtvXZjTTABW1byR6ylvXyvLliU6M6NbGf8yyjLlgDTkuIrr8nYwn6n36
         Y9Q8/A5wBxBN2bDVMCZJsvx9wWi3yREQjVA6tqS7gjl5un6y4y6W+bSAE3OkWaLRNHHX
         fYDqrFqV2d3SgJcrjHsDEhMHZNfSrzKs0yqcVJBmsCIZljpk5/N4MKnK7mDy3uZPWDjH
         2yopkz2EDpTRL1mEt7mWK8vOIkXETxmDAtSefu1l56l/KUfVnwJG5AjboK/h+zajUGck
         8HqWDylhmD/Lt3otHIlIF+JWFO2BvQg7XPhyMCVHq5K4fGrZXGd8z20sL+hDpObDLJNC
         nJgA==
X-Gm-Message-State: AOUpUlEC36rIOouTr7MZEvJtIgPuKqTNUgwMnVkd/qeMPz40LiF483Ns
        VLKx27Lv1HZ7knUtwUoLe72Qe4IimRrdsqoimxU=
X-Google-Smtp-Source: AAOMgpcMkyAHvTyCl4XhKhQ/kKKqLUmgBHg7SEFgH5hSIG87bl9H2i3oJNq4N0vd8BYhSkNk/uPvuezfCrmzXWopHgc=
X-Received: by 2002:aca:b857:: with SMTP id i84-v6mr274659oif.279.1531331423782;
 Wed, 11 Jul 2018 10:50:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:c984:0:0:0:0:0 with HTTP; Wed, 11 Jul 2018 10:50:23
 -0700 (PDT)
In-Reply-To: <35f0b060-b3c0-528e-ee96-811f55b62635@intel.com>
References: <CAMe9rOqXsQ4Onv8_-kYE_yVYVfN0Hsg81XM0sq9k2cVYE_LvaQ@mail.gmail.com>
 <50d6bb50-5fa4-33d1-1f88-3844d0237f16@intel.com> <CAMe9rOoA=OoyaUfOvWuHGTp_ii9-A_ecR5tj8CefBKx_Hmi50g@mail.gmail.com>
 <7db385ef-0940-8f28-87b0-828921dd2f1d@intel.com> <CAMe9rOoZ=8ROyR6U3-JY+4hib2Bb5LGhBYzY5S_Xp38coj16aQ@mail.gmail.com>
 <9548e10a-7403-425e-bf1f-b1eb9d055d99@intel.com> <CAMe9rOrHowBX06nihdRRmEqhV8v7cs+PwVY7JYQFpUFOnHC71A@mail.gmail.com>
 <f22ee1e2-9a35-697f-50ab-543ac1631c89@intel.com> <CAMe9rOpPwtPd-R+D9=iDYgbFtnP+=akWic-QBKwq9wKa7uadEQ@mail.gmail.com>
 <2022d212-62f2-a163-2493-abecfbafa07b@intel.com> <CAMe9rOqc0oVw+ZLXCM-nrtPb1OiPFBeHt+Lsx+6K6y=t3HSVhA@mail.gmail.com>
 <cbb38230-9c57-905b-3a11-e2717c5aa615@intel.com> <CAMe9rOqh9saaULM_+jNtzfYarbZScm+6KCEyibxxqn7GLvKwzA@mail.gmail.com>
 <CAMe9rOpV89jWhvAZtqOJnc0eXzRYiLF5pLWRcdb7-kKLigj4rQ@mail.gmail.com> <35f0b060-b3c0-528e-ee96-811f55b62635@intel.com>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Wed, 11 Jul 2018 10:50:23 -0700
Message-ID: <CAMe9rOopjyiP4LSBqpDzBi4aQe+LKuFJdMAMBR=v9gbJy1QJmA@mail.gmail.com>
Subject: Re: Kernel 4.17.4 lockup
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 10:43 AM, Dave Hansen <dave.hansen@intel.com> wrote:
> On 07/11/2018 10:29 AM, H.J. Lu wrote:
>>> I have seen it on machines with various amounts of cores and RAMs.
>>> It triggers the fastest on 8 cores with 6GB RAM reliably.
>> Here is the first kernel message.
>
> Does it trigger better with more RAM or less?

It triggers much more with 6GB RAM than with 32GB and 64GB.

-- 
H.J.
