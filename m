Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31BF2C65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 18:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D835220837
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 18:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="EVvCM9Ok"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D835220837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbeLIS1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 13:27:09 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42029 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbeLIS1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 13:27:06 -0500
Received: by mail-ot1-f68.google.com with SMTP id v23so8362061otk.9
        for <linux-kernel@vger.kernel.org>; Sun, 09 Dec 2018 10:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jSxT4gfHl5WXRc8jU0ThvEUw3na9p8omVU3j1EuQcoI=;
        b=EVvCM9OkJ6k1PgVutSX4iGp3Vpc3tsjfj3z2VxNIHKYFdeIor/4SliQoSrLfqNT+rJ
         gMSLZ7ZICplcva/c78Fj/4AMI08aalUJQqwcFaTQrhHWc8TiE+49QI+usIdH4kre0V+C
         QgXuvQoWhWnnqbos0hpEzYx8OZs2pLBnfbXhnZ/2KuYUpYSjxyeTCt/A6/Y9CnMJt68S
         eLuEWfLWBS1AYp8qyfPpG2H59aKvGael9eEcdWinA6/O5YyVUP4fvZUZtQpDnbB635UJ
         blhvbjj5G7yWE4p9eAad9uJkq2gz8z+qcD81GnZw6lYNo+oS6dhYtNHisNw6BIFdcMCc
         M1mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jSxT4gfHl5WXRc8jU0ThvEUw3na9p8omVU3j1EuQcoI=;
        b=jZji5wy/xeMxHnWxIs96gpBZqZX3hx9OoQsLjdR3bM02xYKZlPjY/9YOK0WiAzL8jh
         ECeQhvTflLt8+ejjKHc6ud4oM+GivwTY6vvJnV+/eXcmVg55n//AbKWreYZJSaqASxp/
         OfBzVmzAfePzy/wjJPtLvrX0FKGZk8Oz26s19HC8Tkj0D1nGQcAge1yLG4QISezr5KKK
         XOH1+tbjLQzJ17TWwK8p10rC1CNO2XkVIVEA5MH0kXxdpDDQYTyR6imJDyiavKdfqqMe
         jgGgsOK5+bV4yrpw3lnO1CML8KoOTq7le8nfQh0iqhkf8zV48H1Yz9iMlqHrKhZjdgDQ
         gp0w==
X-Gm-Message-State: AA+aEWbbCX6wfbmfvCxaN1XbRTmnrm6cfeuv5ckUi2w170hJUUXJ7VGs
        VT/NHpNfJlwLIZqPkrB4UdXr6PohGMP/SUU9x7dbwXsl
X-Google-Smtp-Source: AFSGD/X8+1KvDQlELUSop3UJ7OezWWcsah9fWKNMJDo1as5kStMbA0FIVgq4++be7QHuovNSSTg9tIUahWOUq2C9YvA=
X-Received: by 2002:a9d:6ac2:: with SMTP id m2mr6501766otq.353.1544380025118;
 Sun, 09 Dec 2018 10:27:05 -0800 (PST)
MIME-Version: 1.0
References: <6be0835bf256755375f3b5822bf70d74538d1d6e.camel@intel.com> <CAHk-=wgAONwr6pMn+D2OsMZjAB5zNaMWSW5KdTM+L72gGnhV2Q@mail.gmail.com>
In-Reply-To: <CAHk-=wgAONwr6pMn+D2OsMZjAB5zNaMWSW5KdTM+L72gGnhV2Q@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sun, 9 Dec 2018 10:26:54 -0800
Message-ID: <CAPcyv4jznHRB=BCsm8Y3d-uqDy_OWHSgTsPZoPK-L80FiQftFg@mail.gmail.com>
Subject: Re: [GIT PULL] dax fixes for 4.20-rc6
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ add Willy and Jan ]

On Sun, Dec 9, 2018 at 10:02 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sat, Dec 8, 2018 at 10:26 PM Williams, Dan J
> <dan.j.williams@intel.com> wrote:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/dax-fixes-4.20-rc6
>
> What's going on with the odd non-exclusive exclusive wait?
>
>         prepare_to_wait_exclusive(wq, &ewait.wait, TASK_UNINTERRUPTIBLE);
>         ...
>         /*
>          * Entry lock waits are exclusive. Wake up the next waiter since
>          * we aren't sure we will acquire the entry lock and thus wake
>          * the next waiter up on unlock.
>          */
>         if (waitqueue_active(wq))
>                 __wake_up(wq, TASK_NORMAL, 1, &ewait.key);
>
> that seems to make little or no sense.
>
> Why isn't that prepare_to_wait_exclusive() just a regular
> prepare_to_wait(), and then the whole "let's wake up anybody else" can
> be removed?
>
> I've pulled it, but am awaiting explanation of what looks like some
> pretty crazy code. I *suspect* it's a copy-and-paste situation where
> you took the exclusive wait from somewhere else.

Yes, I believe that's true. In the other instances of waiting for an
entry to be in unlocked there is a guarantee that the waiter will
attain the lock and perform an unlock + wakeup. In the dax_lock_page()
path there is the possibility that the inode dies before the lock is
attained and a subsequent unlock sequence is not guaranteed. So, I
believe the intent, Willy correct me if I am wrong, was to keep all
waits "exclusive" for some sense of symmetry, but this one can and
should be a non-exclusive wait.

I can send a cleanup, do you want one immediately, or is post -rc6 ok?
