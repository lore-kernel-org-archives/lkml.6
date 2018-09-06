Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F7CEC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 15:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27AA72075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 15:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="rnBUWG8K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27AA72075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730343AbeIFU0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 16:26:20 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:39940 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730122AbeIFU0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 16:26:19 -0400
Received: by mail-qt0-f196.google.com with SMTP id h4-v6so12811461qtj.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 08:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+jnPKTZ0c+/B1RaujfdArsJQjneQQQrPfgDLshUdTD0=;
        b=rnBUWG8K9HnJN3y24LwW1HwEzwt3AFJcvjF9tXLyU+NrIGKTPuxyXyvQno49+JB6NF
         9UjKfMk7oAxA+AltU6qyARGrjtKV0h/i88pwnj6yLSm8zpkU9/lV4ROYJYmRhAZGWGzD
         1gyS2tjNJiZwd8KGcJPBJj2qUbuerqQJj7K2sFbnEbXwyv0EpTPW13s0kK08aPpWNcXk
         OpLisL+cT9dyGmhmqsaMvIFutzLf84Ik9A8nOHgJ26w8mr9hGNIXCDVCyXH+pFndonIq
         A97yaFF87nvPeVcz+5/+bD7oc+xQcg0/LcfA1MvSG7su5Z2RxxjGL4dBEXBiwkWoFJlp
         vZ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+jnPKTZ0c+/B1RaujfdArsJQjneQQQrPfgDLshUdTD0=;
        b=kDXNZyCO7LJJrsK+iZc8FJv6tVFSLI/IlTxIrZr/JSUS3yIVL/jRGzZVk0bZqQsRsk
         L3kEZ7JvPVkWH0d/P6+9EGEmoxmiJ6uxV0ilQ9HlcTb/TQU1OxXkyQUPaF31cd188MoU
         5W4uH0MGyJt3XvY9HiaT6etCIjbhQpPwZFIL5pXsc2pgl02kW5nQOoe4NldlA8wc7rV7
         fwDC9ag0uSJ7FNKKhMQklxfG4y+0N8AUH3N9AZpA/12JKlG4JybvmF3PLOLx24edbZ+V
         BBc3JQLP2iz/7pek5yE0bSVwyavrv0SLtpxt0DzNGwVIVYbaxWqgy9Hk4qIA9yu28pju
         h8Gg==
X-Gm-Message-State: APzg51DvKG+4tVsrparFClB8WrvcAZuz80wlWApIp5xxSTtKDCNaVHrl
        Bqc4kF6KH5gR9xqYQXmNpkYm3Q==
X-Google-Smtp-Source: ANB0VdZK2+SHF0KAp/Lc/U0dZTcHgUFvyCFgjUGB0OgAqq597+rQyh0TBIm9mCOBE+4sOb3aW7QIyw==
X-Received: by 2002:a0c:fb08:: with SMTP id c8-v6mr2527574qvp.149.1536249012005;
        Thu, 06 Sep 2018 08:50:12 -0700 (PDT)
Received: from cisco.cisco.com ([173.38.117.76])
        by smtp.gmail.com with ESMTPSA id c50-v6sm1490625qtb.8.2018.09.06.08.50.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Sep 2018 08:50:11 -0700 (PDT)
Date:   Thu, 6 Sep 2018 09:50:08 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Jann Horn <jannh@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        containers@lists.linux-foundation.org,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>, suda.akihiro@lab.ntt.co.jp
Subject: Re: [PATCH v6 3/5] seccomp: add a way to get a listener fd from
 ptrace
Message-ID: <20180906155008.GA3326@cisco.cisco.com>
References: <20180906152859.7810-1-tycho@tycho.ws>
 <20180906152859.7810-4-tycho@tycho.ws>
 <CAG48ez3gRpGZT4Vk7ZZXk5dkYeVfnGsaqeFZeOio0GpqFd=Vow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez3gRpGZT4Vk7ZZXk5dkYeVfnGsaqeFZeOio0GpqFd=Vow@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 05:45:25PM +0200, Jann Horn wrote:
> On Thu, Sep 6, 2018 at 5:29 PM Tycho Andersen <tycho@tycho.ws> wrote:
> >
> > As an alternative to SECCOMP_FILTER_FLAG_GET_LISTENER, perhaps a ptrace()
> > version which can acquire filters is useful. There are at least two reasons
> > this is preferable, even though it uses ptrace:
> >
> > 1. You can control tasks that aren't cooperating with you
> > 2. You can control tasks whose filters block sendmsg() and socket(); if the
> >    task installs a filter which blocks these calls, there's no way with
> >    SECCOMP_FILTER_FLAG_GET_LISTENER to get the fd out to the privileged task.
> [...]
> > +long seccomp_new_listener(struct task_struct *task,
> > +                         unsigned long filter_off)
> > +{
> > +       struct seccomp_filter *filter;
> > +       struct file *listener;
> > +       int fd;
> > +
> > +       if (!capable(CAP_SYS_ADMIN))
> > +               return -EACCES;
> > +
> > +       filter = get_nth_filter(task, filter_off);
> > +       if (IS_ERR(filter))
> > +               return PTR_ERR(filter);
> > +
> > +       fd = get_unused_fd_flags(0);
> > +       if (fd < 0) {
> > +               __put_seccomp_filter(filter);
> > +               return fd;
> > +       }
> > +
> > +       listener = init_listener(task, task->seccomp.filter);
> 
> Did you mean to write something like `init_listener(task, filter)` here?

Yes, yes I did. Thanks, Jann.

Tycho
