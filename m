Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C5AC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 23:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 319712515D
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 23:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="U8C71P0t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 319712515D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753468AbeGBXEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 19:04:15 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:35112 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752927AbeGBXEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 19:04:12 -0400
Received: by mail-it0-f67.google.com with SMTP id l16-v6so582605ita.0;
        Mon, 02 Jul 2018 16:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AFeU3XjU27qvR/UkfnljhwfQZmt9JtmIFn1qomgOwR0=;
        b=U8C71P0tue/rUyfT8NvFioq5o/psAboHhq4EdQHmH7+a0ekx+dOfbod12VYAvnYSRz
         olz9L6NT+2WqWkdbp6Zb8Gb5lDHr3OFm38h5RtcjN+Eb4ji87b+zzQocsAxKRyAlItfu
         GErby9g9Ua1tZw85t5yG0KfUeIxh3gIwvl99g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AFeU3XjU27qvR/UkfnljhwfQZmt9JtmIFn1qomgOwR0=;
        b=qiLgNGNaRLLHeB7YWpVpVS7A9aJojUfwnyam0bT/Zwm/STq79YqOC7Jli8ubVifxe1
         k25nIymbD4xyu86jTUCvY0LmoH/Lq+JB0alQFhyxg7I5dCcYJmS0z4DpTApS789Gl7qy
         tPZifzo8ztIx260DLRUGiA0ldDUqEWwiSwAeyB8adnuGiOVemgq/YfPibSfsqBAkOS8r
         c4i10Oj8Gm8XfK9PGdAcfDGFuWrBN1MGkekUcgiwjZoPBGdgkEeiVsh0sit0DSS4cASF
         b+UYesjm/wCKTRJdevxOZPIRr9khL1ogXN8xy5cd7ZAopGq37q3xZJucJEQ0m9RqHeSF
         G9pg==
X-Gm-Message-State: APt69E1XdOnYvxArW60XxbuZ8dNGW0+2osJroXwOGP7UwyjCO3iKqjlI
        OwmiFhaJBPFA0l7sd/tH8iJ+EE9PWEgZJjAM+jE=
X-Google-Smtp-Source: AAOMgpcLR4Udb8DwgYCF0TstzkLT2xnGHO9Z/CVoi7zlvifNpvHo1dRR40x6Nx9YKdJq9JGg5V6Z78fI5AQhJpeveBs=
X-Received: by 2002:a24:d0d7:: with SMTP id m206-v6mr6516066itg.1.1530572650488;
 Mon, 02 Jul 2018 16:04:10 -0700 (PDT)
MIME-Version: 1.0
References: <1530510723-24814-1-git-send-email-longman@redhat.com>
 <CA+55aFyH6dHw-7R3364dn32J4p7kxT=TqmnuozCn9_Bz-MHhxQ@mail.gmail.com>
 <20180702141811.ef027fd7d8087b7fb2ba0cce@linux-foundation.org>
 <1530570880.3179.9.camel@HansenPartnership.com> <CA+55aFzyUb07Lt251bzi4T79oB=M8uypFQ2m__FgnRJUauqd0Q@mail.gmail.com>
In-Reply-To: <CA+55aFzyUb07Lt251bzi4T79oB=M8uypFQ2m__FgnRJUauqd0Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 2 Jul 2018 16:03:59 -0700
Message-ID: <CA+55aFxZM9JeOeMkksZR93LojhvPZC38QnyvDEdazYg2SG2qHQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] fs/dcache: Track & limit # of negative dentries
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Waiman Long <longman@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Larry Woodman <lwoodman@redhat.com>,
        "Wangkai (Kevin,C)" <wangkai86@huawei.com>,
        linux-mm <linux-mm@kvack.org>, Michal Hocko <mhocko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 3:54 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Lookie here, for example:
>
>   [torvalds@i7 linux]$ strace -e trace=%file -c git status

So in the name of honestly, that's slightly misleading.

"git" will happily thread the actual index file up-to-date testing.

And that's hidden in the above numbers (because I didn't use "-f" to
follow threads), and they are all successful (because git will go an
'lstat()' on every single entry in the index file, and the index file
obviously is all valid filenames).

So the numbers quoted are closer to the

        git ls-files -o --exclude-standard

command (which doesn't check the index state, it only checks "what
non-tracked files do I have that aren't the ones I explicitly
exclude").

            Linus
