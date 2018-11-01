Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256A6C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA1AB2064C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c8/xKqj0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA1AB2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729065AbeKBAxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 20:53:54 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:44652 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727950AbeKBAxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 20:53:54 -0400
Received: by mail-vs1-f68.google.com with SMTP id w194so12432440vsc.11
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 08:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=InpizKkZGP6vpOoWAuZYCvEQx7tLohXSb/i5fUYeT8A=;
        b=c8/xKqj0IH+gqrGb5hwwbG04KG7FMeara3baRwSNywrFrOY82ho5PXUIYUuQLHWlGm
         FSBVTmIZvnsjPi0RHlpboSXgDlnpP4gJqbaxm9KLTFG9RiwjN+oA2/i+1eqMcZVWalRq
         Gdaapl6zeBfXf4aoNZKPsXsqFq3zadTyxW6e/hyiRG/GCbOXWwN5nV+tDl7TAbFbpmQe
         07W7HgEOzE0x5ezXpkiQ8sgqYfH7S4fJrVn+C1h6CWDI3wQEzY2LiCUHgcC+HfihDJkz
         EnwxHf3SkUf9rOiEPaPT/dwKyUrkFBQAyrqK2csMboNas0/msXfdQBfzytPzwTGGFPHm
         TAXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=InpizKkZGP6vpOoWAuZYCvEQx7tLohXSb/i5fUYeT8A=;
        b=ieQymcY05QGILnNAtqNUtuceSEi11a9q4Uoxpf5/dqLFbkadESml6UHyCidvc3iC1a
         E1U88k54T/QsckpmWTfavgpwWaPdFNgFjAfTP5PCGLSod0rBbHHSclk+sDgbhkvWnmdu
         BhXoEkaS2f9nOWtaglCu4a2GimPWYvpzeCH4SJlbIOkl+k8acUcs/crvbfxb8C6uJWrM
         QhBiE2IHE2V3kez1nzJpFcS0o/uUwV2MT+v29n7oU0AFx81eKnf5TZf8KrwZrb5l2kN0
         ouD9uBhcx7r8TEWKdOyx1IwYH+9M2s8TXIecC2yt33KfIHCFo0eX4Rcb/VmMn47YjIFQ
         fQYg==
X-Gm-Message-State: AGRZ1gK+JxtEtWXNvfB23schzklC/+wvOH7v1rBu633AVjO6PkjZmq3J
        4DTkryim6FTpgnadDnpQKHZFppllddp0Kcgqln7K2g==
X-Google-Smtp-Source: AJdET5fjPWAXHJPtHuVaATZfK24BoI7f+/CEbpEw/qb1IzeLqtv8gpCKd2sEcksNH10xmvMHJXCf9zogFuxwJv9wNlw=
X-Received: by 2002:a67:105:: with SMTP id 5mr3359275vsb.183.1541087421797;
 Thu, 01 Nov 2018 08:50:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:f48d:0:0:0:0:0 with HTTP; Thu, 1 Nov 2018 08:50:20 -0700 (PDT)
In-Reply-To: <061df748f65d41b5bbd4749074dbce29@AcuMS.aculab.com>
References: <20181029221037.87724-1-dancol@google.com> <87bm7a3et9.fsf@xmission.com>
 <20181031124435.GA9007@redhat.com> <CAKOZuevTF2cjJ0-nK7nv7jbgFexyW-deScaYVzE3iEPC48SAJg@mail.gmail.com>
 <061df748f65d41b5bbd4749074dbce29@AcuMS.aculab.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Thu, 1 Nov 2018 15:50:20 +0000
Message-ID: <CAKOZueuRbYh5dKoT4R6_t87yKZR_bzX+7s4KevvSmfcBk+YeYw@mail.gmail.com>
Subject: Re: [RFC PATCH] Implement /proc/pid/kill
To:     David Laight <David.Laight@aculab.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian.brauner@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 1, 2018 at 11:53 AM, David Laight <David.Laight@aculab.com> wrote:
> From: Sent: 31 October 2018 13:28
> ...
>> * I actually have a local variant of the patch that would have you
>> open "/proc/$PID/kill/$SIGNO" instead, since different signal numbers
>> have different permission checks.
>
> I think you'd need the open() to specify some specific unusual
> open modes.
> Otherwise it'll be far too easy for scripts (and people) to
> accidentally send every signal to every process.

I think the /proc/$PID/kill/$SIGNO idea is dead anyway, and even
dead-er since Linus banned write() for commands. (Looks like we'll
need a system call after all.)

That said, for the record, I was talking about the *write* sending the
signal, not the open, so grep of /proc wouldn't send random signals to
every process.

> Also think of the memory footprint.

Proc inodes are created on-demand, so AIUI, the memory overhead of
heaving a per-FD directory of stuff isn't very high.
