Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C446C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 02:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A89720841
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 02:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Q42htKxc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A89720841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbeICHFs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 03:05:48 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:35059 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbeICHFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 03:05:48 -0400
Received: by mail-it0-f68.google.com with SMTP id 139-v6so13786817itf.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Sep 2018 19:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=topLoQGFaNwxG7QTTuJ+RQHYuVuE+peuBW8yLzEFZvI=;
        b=Q42htKxc9QacMEdNrGBn7gUaEWLfK7RTRyY1HB7CyD97Fli7Dk/7jeZVb9iLmTtdec
         aKwgo19+Zgk5usPwcqh68A0yoyKYq4CuTMWJRWDslBxjnr/a6737gC0EDEGvUo1koRAY
         OUyOH2J1jYKSqiSBbiTj73if2SCbRrZjNj8zk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=topLoQGFaNwxG7QTTuJ+RQHYuVuE+peuBW8yLzEFZvI=;
        b=UA+Gi9TWltiqgWQjq1Vx80rEN8FFdjS5idpndMCAC/EFWklUXgrR6G2Llcetyj8Xho
         6bt+6tG5TD8OKTM/n8jiqUywD5JLACCG4lwHlc8O54TY2ZETFMFvGXUjR++2mC/rJ81s
         9MRJGCpr59lRALqu/uUHriPlSt9tBFUT3MHVSej3kFPZ75kh6lUh7CnRG5+EutQWVNNs
         II+3gybPiAPYbCm+q2gd1547AYaLqbJxcn+bIY0N43Aa9JhWm1yQECQcS2WZwqFyWlYN
         hmEC4JErDomhEONOpvqMd/UOFmI91a4tyyWCAXdiqxrThTgEzVFsR7Rw/3/w4mxg9Oro
         ecKA==
X-Gm-Message-State: APzg51DV94TQQoSw/fM/3RNYxRaE2ie1V6c8dRY5PsGBJoQz38q9TOPi
        +9k0tG+71/UXqKNv57iVOplca8yilW6CAns9jtw=
X-Google-Smtp-Source: ANB0VdY5lclGh1bzk30nrRNGNB9BYKgTwRFN6RIfsz8qfbnlU6hrjz7n/k/XX/X4FdW94+E3y6mlTVVMIiCyu7PkKKM=
X-Received: by 2002:a02:702:: with SMTP id f2-v6mr18969582jaf.70.1535942864363;
 Sun, 02 Sep 2018 19:47:44 -0700 (PDT)
MIME-Version: 1.0
References: <3009b28a-971c-920a-9184-900f1f3b2203@suse.com>
 <alpine.LRH.2.00.1808312312480.14475@gjva.wvxbf.pm> <CA+55aFyqpg_e8dXZWhdyVLa0xSYcK6iuRTKDXxnFLaFEcqZHkQ@mail.gmail.com>
 <CA+55aFyOSLEbiNvPoHkHe8WXae_aJiS+jsnubG8Xk0CYw8U4uw@mail.gmail.com>
 <a1980256cf3d2ea8e91707fcda7cf141b27a212d.camel@kernel.crashing.org>
 <fd389fc96692e38c318f14f0da840cdecda8fbe5.camel@kernel.crashing.org>
 <CA+55aFz_Kbu2PDjqvmgqCFcFSsoRPD=a8vAtPY=--t61X454Jg@mail.gmail.com>
 <CA+55aFwSfXu1LXjLZe4gddY2VybEGLbPpx-PWinF19LjbevEgQ@mail.gmail.com>
 <a2b20fc447e0b2cd208dc82081cb24e38bf71f68.camel@kernel.crashing.org>
 <CA+55aFyhq23ce94Vq_XdCJSOKvo8oYnb2UOdjf-KVaaOFngr+g@mail.gmail.com> <ca2ffedd94f7ca2a53c4417c801efbdd7c40eaef.camel@kernel.crashing.org>
In-Reply-To: <ca2ffedd94f7ca2a53c4417c801efbdd7c40eaef.camel@kernel.crashing.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 2 Sep 2018 19:47:33 -0700
Message-ID: <CA+55aFx0b8ATmeO8KRaHrgsZnhT_0TqotsPUkxN4gbCsvrZuyA@mail.gmail.com>
Subject: Re: Access to non-RAM pages
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Will Deacon <will.deacon@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 2, 2018 at 7:25 PM Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> Ah, my bad reading, I was looking at read_word_at_a_time() instead of
> load_unaligned_zeropad(). I'm not familiar enough with the dentry qstr
> stuff, I assume this is safe ?

The dentry qstr should always be 8-byte aligned because it's a kernel
name allocation.

So it's the path component in the actual pathname string that can be
unaligned (ct/tcount in dentry_string_cmp).

The comment actually does talk about it, although the comment also
claims that the cs read would use load_unaligned_zeropad(), which it
no longer does (now it only does the read_word_at_a_time).

And read_word_at_a_time() is purely a KASAN thing. The thing can't
fault, but it *can* read uninitialized data past the end of the
string, making KASAN unhappy.

So that's actually a different issue, where KASAN does byte-level
validity testing, and doing word-at-a-time accesses obviously violates
that for strings.

               Linus
