Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6421C070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 23:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52CAE2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 23:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="1ljj98bA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52CAE2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbeIME7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 00:59:50 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43528 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbeIME7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 00:59:50 -0400
Received: by mail-wr1-f67.google.com with SMTP id k5-v6so3737636wre.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 16:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vHFty3yKLaJdJIT5vu9/gLq1I2ctklGntNsuIxm04Pc=;
        b=1ljj98bAPmx0qmgnQf+9YzTP3vcsAlsRp7sY5gQVDQ8u7Lqy9pugP+JO8dknxvYsL4
         zsSj0KjoNbDzIxEgV69YxnGdNfclKAGOrWH8xusAGN2v+x9Xt2DtdUoals9NaJad/m1x
         MzjGF1b7XTFzDx6xavGTY/SZyDEH93tf/ggnPR5cUAW2+HZUNi2dLl7mnZidDBxT88u/
         dVKRK33GeXO/eet1cRkQLSQTzJMxCtXGIvTr8jnOD2B//YRZ0izjfnWGlpLSgMOP7l0R
         c2mux6gIvojDgVeTVEsn/gPNtj/kFLJPiQVCxmIHMC/1cMS+zubb6Xx84OvfnRUwey3Y
         5fyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vHFty3yKLaJdJIT5vu9/gLq1I2ctklGntNsuIxm04Pc=;
        b=ILukfV7+3Rk2wPy7G8tdTW7sexj0dx9jmz0R1AmbGjIpKKaYyJq4/i6zRrjUXW8x/r
         MawyGAegbszHoeESIgrfAYF7oez6JSySRRGX2b/5xcS7quVvrbMojFwclGIdLrXOj8s6
         L+nw5XYZZ7wEVpdvP26PthDj3MvZHpm1HmKo/bA1h1y67B51GUmcwDcBUdJz4mlvZW58
         TA9rWg5PqwHL8o2ORi4yR2XrzSZM0Ki3lKzKbh4u+pzoMeXIA0X8c90yoixyimZSmbSx
         1kfrTBvX685kNc6/Ikf1Pa2GFpK9JcFFjQCcHH3htMXygKTSWeZ2MlkpjJ7CjT5sO7pl
         nutQ==
X-Gm-Message-State: APzg51DnI/EX8UMcda7nU9NTxga/XNowxfl560mdH9De/1YSKiPbBQYJ
        dz05QupO7Gbjbt1JNsvbDlatCHQsH8rhfp7Di5ngug==
X-Google-Smtp-Source: ANB0Vdb4HRhtG1fWJViOzG97IMTQRfiiXlnYVLA/Zq5Ipj+S5/m6nN27obLQ7c1SP/U1dU/Q1KJz251YSPbeqYBxK90=
X-Received: by 2002:a5d:4c49:: with SMTP id n9-v6mr3360340wrt.71.1536796378783;
 Wed, 12 Sep 2018 16:52:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:7810:0:0:0:0:0 with HTTP; Wed, 12 Sep 2018 16:52:38
 -0700 (PDT)
In-Reply-To: <20180906152859.7810-5-tycho@tycho.ws>
References: <20180906152859.7810-1-tycho@tycho.ws> <20180906152859.7810-5-tycho@tycho.ws>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Wed, 12 Sep 2018 16:52:38 -0700
Message-ID: <CALCETrWZmN4FeCSwemfMeayupBmQ-NqpVWQuqSU34CLvzdx8gw@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] seccomp: add support for passing fds via USER_NOTIF
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 6, 2018 at 8:28 AM, Tycho Andersen <tycho@tycho.ws> wrote:
> The idea here is that the userspace handler should be able to pass an fd
> back to the trapped task, for example so it can be returned from socket().
>
> I've proposed one API here, but I'm open to other options. In particular,
> this only lets you return an fd from a syscall, which may not be enough in
> all cases. For example, if an fd is written to an output parameter instead
> of returned, the current API can't handle this. Another case is that
> netlink takes as input fds sometimes (IFLA_NET_NS_FD, e.g.). If netlink
> ever decides to install an fd and output it, we wouldn't be able to handle
> this either.

An alternative could be to have an API (an ioctl on the listener,
perhaps) that just copies an fd into the tracee.  There would be the
obvious set of options: do we replace an existing fd or allocate a new
one, and is it CLOEXEC.  Then the tracer could add an fd and then
return it just like it's a regular number.

I feel like this would be more flexible and conceptually simpler, but
maybe a little slower for the common cases.  What do you think?
