Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7BCC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 21:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62D4B2080C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 21:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QkQe36jb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62D4B2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731138AbeKTHv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 02:51:57 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:43770 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731112AbeKTHv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 02:51:57 -0500
Received: by mail-ua1-f65.google.com with SMTP id z11so11219153uaa.10
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 13:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nh96bPDfpXkw0uHoBWBhs9Qg+Ot//y/rzYSMJIiajqc=;
        b=QkQe36jbOGRTNr+ZMpFgFS4l98JAe/I1QvpnXl/yl1lITjGOOsZK2TG+rENMIIynvw
         HpWL8e66E2Bc3T2Efp2v77bYp+0RNblx3Qp7jqj/m3wSTsG0ToADG5Q7ceLas3L1u5XN
         Q2qVevclHiKtcEytqZlER0YqvSSIbIXK0UVT5stEqJguUPHPYE1ZccqwaRQRTSfvFCLa
         x6CdZIkvTToIpM1dN4zY/uzSxC+HeYkCU9AXms8EDzjUTC5ad8uS1JftIfH+fgxJLWDu
         HMhNwZZqKqNeOXOim3CZ3bviOewLIH/7p6O1QcpZbcA17EE9BHH5fKjZAL33G/H3G2+2
         uDcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nh96bPDfpXkw0uHoBWBhs9Qg+Ot//y/rzYSMJIiajqc=;
        b=qTActr0ouC249+0ynFPufibagAflU3jvVSkdMnbg6xLCKDov91O+QcoYklyj0OyZUf
         8IQNYT6QmI7TcEd2sSLKc0+Q4y4e/p1yHxZFYtDksyl06ZNtnUvHt/lPUkTdzwTb/fy0
         7gjeC6Ahm+/d09Exont9kwAaJ6sUvefjnQZx632RzNWnUH9SO0J8W3A2/zwDuBMq6kac
         /6LCi71/0EAnLPKzNjJ+MPMBickyh3tZTdWC68J7cGQlcK/gyGCPTiywkGRfbapm5a+W
         cUA7ZhbmrFpybmGKugPQvnxsJVXdogqXVOFQkrL+gT1iAFlHOfDX7MFeQ+bm9qW0+MhK
         /HyQ==
X-Gm-Message-State: AGRZ1gIpEpGsHbvt2xo/lhrxpJApLBeaUMth/wORDNazJ1osVbB/eVPW
        +YC/sBcPr34/ydHvwp+sSSY59Y32z3Hn+5tvarWj5g==
X-Google-Smtp-Source: AJdET5cH09rxV1JMV4mYy6ko6UvaHsBh5ZJPoHO6FhK+GOdWxrwjaZQz4QvTsuNgWEbt+Dhi8c6PHYR1VftmaFgaf/w=
X-Received: by 2002:ab0:72a:: with SMTP id h39mr10825396uah.11.1542662783827;
 Mon, 19 Nov 2018 13:26:23 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a67:f48d:0:0:0:0:0 with HTTP; Mon, 19 Nov 2018 13:26:22
 -0800 (PST)
In-Reply-To: <20181119212126.u2nkijmula6wcfqi@brauner.io>
References: <20181119103241.5229-1-christian@brauner.io> <20181119103241.5229-3-christian@brauner.io>
 <20181119202857.k5zw742xjfrw677j@yavin> <20181119205518.btew3vxwgva4w3zh@brauner.io>
 <20181119211810.73ptfhnwdmkngfi4@yavin> <20181119212126.u2nkijmula6wcfqi@brauner.io>
From:   Daniel Colascione <dancol@google.com>
Date:   Mon, 19 Nov 2018 13:26:22 -0800
Message-ID: <CAKOZuevEx6CbcxrR8eVZrUXDcN5y1GPsXdSoHfQteSQKypx0qw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] signal: add procfd_signal() syscall
To:     Christian Brauner <christian@brauner.io>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        linux-man <linux-man@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 1:21 PM, Christian Brauner <christian@brauner.io> wrote:
> That can be done without a loop by comparing the level counter for the
> two pid namespaces.
>
>>
>> And you can rewrite pidns_get_parent to use it. So you would instead be
>> doing:
>>
>>     if (pidns_is_descendant(proc_pid_ns, task_active_pid_ns(current)))
>>         return -EPERM;
>>
>> (Or you can just copy the 5-line loop into procfd_signal -- though I
>> imagine we'll need this for all of the procfd_* APIs.)

Why is any of this even necessary? Why does the child namespace we're
considering even have a file descriptor to its ancestor's procfs? If
it has one of these FDs, it can already *read* all sorts of
information it really shouldn't be able to acquire, so the additional
ability to send a signal (subject to the usual permission checks)
feels like sticking a finger in a dike that's already well-perforated.
IMHO, we shouldn't bother with this check. The patch would be simpler
without it.
