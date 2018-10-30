Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC07C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 23:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1AB420685
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 23:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VLfzrdQP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1AB420685
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728726AbeJaIu5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 04:50:57 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:42213 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbeJaIu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 04:50:57 -0400
Received: by mail-ua1-f66.google.com with SMTP id z18so4070110uam.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 16:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=84pObyZNG859jCZmtUPM/w8UTseVWLuL8sSWe6gkig8=;
        b=VLfzrdQPRxW+N2rBZD1FNVe4ZILbqqIfuiSAAz+tNyADF31tI80iXfN75aZN5i5UhD
         5dPfNMin7PrEkylUcowDwa0XhyAa2eX0HIfNs5AuVwmAMsp5T+slg7RbACdJah5aI8Di
         oNbapFD+8adZ9NQxiQaHULqc0/UnBDBOhIQC3+SAVXL801GdfisWjwxXfxXE20Bvg8RP
         w3Uubx05KWYzZhCGjqkwtEOpxCk8OW1CdD7lbn1WnppO6HYN/V+4m7GwTwR0Gz1Y8IqX
         4UeTonAqE+VLg2t6vgEkvY92OUFhTzxmqXGFqlLS3HOIwUgbSh/Bti2x9dy3ljmyHFS3
         sSJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=84pObyZNG859jCZmtUPM/w8UTseVWLuL8sSWe6gkig8=;
        b=YFUIRVf+RbctAPgElJ8BOqxE1wevVtzweC3HXM+aKE0K1R1rhrJYkWmV+ZnaUmYA9P
         SFTO1RhRj3NE1YOhh3qUaXidNC6KRmSj/Ym/h+4cUKkjjlfosXIA6iq/VKkeJzHZSLwh
         xPyFmNNKERXZ9Jivdc/CjCQsz0+RNjzd6hyZYV2QW1ibuygrFlgL4hd2v5jtuAxTuBud
         pxkbs5ihYwEpvb1htfVXPocCOsDBbT4tWeO8eMaJkoyBO8s0hTFQjn4TuPqmXqu6eOXa
         UIF9KBPiw3AzN1qV0pzMYOP7/XQw2ib3gUvagzwsZWhkFJNj0JDeNXbBxam4VWoSvEhL
         1URw==
X-Gm-Message-State: AGRZ1gIeqYrKsa2LA5ghNPs38PaYWeg5p9Hmk+3n4A3kWS+b1niejFbk
        4+IiZWdFqd694VoMHjFb5Lfv1VnS8bvj25eawrSARWbfEU/eIw==
X-Google-Smtp-Source: AJdET5ce1JlRCV9FDyUHVAfC4TlwipMLTvCrxxXldJBMO4cRreuCSPZWYX/HLqXmJusWPueJbeSpYXGyfiSChjrSYvk=
X-Received: by 2002:ab0:648b:: with SMTP id p11mr408170uam.128.1540943718390;
 Tue, 30 Oct 2018 16:55:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:f48d:0:0:0:0:0 with HTTP; Tue, 30 Oct 2018 16:55:17
 -0700 (PDT)
In-Reply-To: <CAPP7u0VQqDvFr=-52+Tmv_K=vT730wG7w9VQqJggsXTPFvaUBQ@mail.gmail.com>
References: <20181029221037.87724-1-dancol@google.com> <20181030050012.u43lcvydy6nom3ul@yavin>
 <CAKOZuesKVic-5epRj8XcFNR_63SgvaPcbjDQuSLxNrEfS=O=Jg@mail.gmail.com>
 <20181030204501.jnbe7dyqui47hd2x@yavin> <20181030214243.GB32621@google.com>
 <20181030222339.ud4wfp75tidowuo4@yavin> <20181030223343.GB105735@joelaf.mtv.corp.google.com>
 <CAKOZueuBdY_b=CVk29pzn0NAt9sJtzr6yqx9Y00WCppCm1JFWQ@mail.gmail.com> <CAPP7u0VQqDvFr=-52+Tmv_K=vT730wG7w9VQqJggsXTPFvaUBQ@mail.gmail.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Tue, 30 Oct 2018 23:55:17 +0000
Message-ID: <CAKOZuesuj6HyX-Y6J7wJ73PB_EuoKc2OB68nYzWY-08i+M+z-g@mail.gmail.com>
Subject: Re: [RFC PATCH] Implement /proc/pid/kill
To:     Christian Brauner <christian.brauner@canonical.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 11:23 PM, Christian Brauner
<christian.brauner@canonical.com> wrote:
> On Wed, Oct 31, 2018 at 12:10 AM Daniel Colascione <dancol@google.com> wrote:
>> I think Aleksa's larger point is that it's useful to treat processes
>> as other file-descriptor-named, poll-able, wait-able resources.
>> Consistency is important. A process is just another system resource,
>> and like any other system resource, you should be open to hold a file
>> descriptor to it and do things to that process via that file
>> descriptor. The precise form of this process-handle FD is up for
>> debate. The existing /proc/$PID directory FD is a good candidate for a
>> process handle FD, since it does almost all of what's needed. But
>> regardless of what form a process handle FD takes, we need it. I don't
>> see a case for continuing to treat processes in a non-unixy,
>> non-file-descriptor-based manner.
>
> That's what I'm proposing in the API for which I'm gathering feedback.
> I have presented parts of this in various discussions at LSS Europe last week
> and will be at LPC.
> We don't want to rush an API like this though. It was tried before in
> other forms
> and these proposals didn't make it.

And I'm looking forward to that proposal.

AIUI, one of the reasons previous proposals in this area failed is
that they'd have their process handles pin entire task_struct
instances and keep PID-table entries reserved as long as handles were
kept open. If you keep a PID reserved as long as you have an open
handle to a process, then existing PID-taking interfaces become
race-free automatically, so there's little new API. (This
PID-preserving approach is the one Windows uses, FWIW.)

An alternate approach is that have your process "handle" reference a
struct pid instead of a numeric PID or task_struct. You can't prevent
PID reuse this way, but you can at least distinguish between different
processes that have used the same PID, so you still get race freedom.
The downside of this approach is that since you don't prevent PID
reuse, existing PID-accepting interfaces remain racy and so, since you
need to let people name processes by process handle instead of by PID
whenever they want to do something with a process, you need to provide
an FD-accepting version of each current pid_t-accepting system call,
e.g. ptrace.
