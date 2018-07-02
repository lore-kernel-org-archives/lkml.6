Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCDBDC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 22:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 720AC24D84
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 22:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RDP2N41A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 720AC24D84
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932423AbeGBWyS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 18:54:18 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:53854 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753603AbeGBWyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 18:54:16 -0400
Received: by mail-it0-f68.google.com with SMTP id a195-v6so528893itd.3;
        Mon, 02 Jul 2018 15:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p8CHpZyszHyJTYC/00e2QCkHGmz5oqWztjAlfY6soOc=;
        b=RDP2N41A85NdN2ePXjYwuoS5XmSGH9uBvynffJ21sbxAbSl8zJxFJIoD4ka3UPUgOd
         2TmdmFaNi2p6atQmhfnixl5K6QCMJXT+xslbGL6zpZSyd44pZvxVo/0WFd3/nHbyBNQ8
         0FsSfQTc+V2AZN4m7n5A8gYx40so96pwgDh6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p8CHpZyszHyJTYC/00e2QCkHGmz5oqWztjAlfY6soOc=;
        b=XW/7hR1ALk+HEsD90W/8XTljR7yDjE+nSV5MNyF2a8H0RjDxd1KJ0k7gOEq3+Zxliu
         QA4SSLLFkA3Lu8/punLiT7pN4/hE/6SdzKZArVEaUPdGfjvtKcxh817mFg12CwedSkCP
         IbmDF9rI1R9S1+cKaRLsA/zYMzSBU/5Yihgrp6I3kR3pyt7+vaWj5Tagmf6clXDN9ELY
         hWb0kzwhI756SzWDZ4bJQGY6kfAre0ICDGBjd3A/8MY0DBWxNy+gL1wsHHTKnpfudVcL
         nCyrXgfEYXDm/GB4gygqm7IsSoQZrEZAPnYT5//83XNJKKVHawXqMe4KXztAl6e8KI9P
         r00w==
X-Gm-Message-State: APt69E3DT5TamYj1zzQXe4f9ZlfzJVJ4zsE6B5egUz1VYGPBuK+TD3/t
        88XP96XeFL93aFU7BfzZn9V+5xtG98UPHUgv7mE=
X-Google-Smtp-Source: AAOMgpcPWOqsmyooO8tSF9xB23VKwGQta28Jrz2zU5Y14cyo+/13wXwC/nDOhKVR2dgrUGlz5+vGP3HNmx/ZZ9x+RtQ=
X-Received: by 2002:a02:89a3:: with SMTP id p32-v6mr22617968jaj.10.1530572055594;
 Mon, 02 Jul 2018 15:54:15 -0700 (PDT)
MIME-Version: 1.0
References: <1530510723-24814-1-git-send-email-longman@redhat.com>
 <CA+55aFyH6dHw-7R3364dn32J4p7kxT=TqmnuozCn9_Bz-MHhxQ@mail.gmail.com>
 <20180702141811.ef027fd7d8087b7fb2ba0cce@linux-foundation.org> <1530570880.3179.9.camel@HansenPartnership.com>
In-Reply-To: <1530570880.3179.9.camel@HansenPartnership.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 2 Jul 2018 15:54:04 -0700
Message-ID: <CA+55aFzyUb07Lt251bzi4T79oB=M8uypFQ2m__FgnRJUauqd0Q@mail.gmail.com>
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

On Mon, Jul 2, 2018 at 3:34 PM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> There are still a lot of applications that keep looking up non-existent
> files, so I think it's still beneficial to keep them.  Apparently
> apache still looks for a .htaccess file in every directory it
> traverses, for instance.

.. or git looking for ".gitignore" files in every directory, or any
number of similar things.

Lookie here, for example:

  [torvalds@i7 linux]$ strace -e trace=%file -c git status
  On branch master
  Your branch is up to date with 'origin/master'.

  nothing to commit, working tree clean
  % time     seconds  usecs/call     calls    errors syscall
  ------ ----------- ----------- --------- --------- ----------------
   73.23    0.009066           2      4056         6 open
   23.33    0.002888           2      1294      1189 openat
    1.60    0.000198          13        15         8 access
    0.80    0.000099           2        36        31 lstat
    0.53    0.000066           1        40         6 stat
    0.27    0.000033           8         4           getcwd
    0.11    0.000014          14         1           execve
    0.11    0.000014          14         1           chdir
    0.02    0.000003           3         1         1 readlink
    0.00    0.000000           0         1           unlink
  ------ ----------- ----------- --------- --------- ----------------
  100.00    0.012381                  5449      1241 total

so almost a quarter (1241 of 5449) of the file accesses resulted in
errors (and I think they are all ENOENT).

Negative lookups are *not* some unusual thing.

                   Linus
