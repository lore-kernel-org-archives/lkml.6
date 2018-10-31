Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 781F0C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 15:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20BFC2064C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 15:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bAuc5q7L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20BFC2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbeKAAPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 20:15:04 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:41877 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbeKAAPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 20:15:03 -0400
Received: by mail-ua1-f67.google.com with SMTP id o17so6031955uad.8
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 08:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mDD75d+IwQHXDKS8c/RtO1Ixi7VqLTvr9TtRrx0/vEs=;
        b=bAuc5q7LG2yshy2LFFxqW8rIhzew11u1fE06vcaENCcqBKoc5FUyrbdY23RvXv/mBR
         AUVPYBGuR/RN1LtnD3PZflpR61G8gdYRYt1ib/cShAPqu58tqt2MwI+DiJAmyrigOgRa
         TdwgFDld287pCJ/N8d2jX0ZhZFmfGyN53fjlttw++Nn7Sna0n0NtjnIsorNVriG2K8/j
         YoswUtFfsSbcDcR4nqxO7uzT1BDP+MAorpig3gWqF4zW62RtpNldYuxTj50mQ1DclGnr
         r8vdMn72IeEMQ+Py5jLmJNl9wuVdELwfMhdHhNMFckCxYYkafV4j25qK3vQrwIUhESz8
         aSJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mDD75d+IwQHXDKS8c/RtO1Ixi7VqLTvr9TtRrx0/vEs=;
        b=m19KwCZ5CDFUGhgsqDjKtnbXMfDP7yeUgGHiPHVNtVNJDySniATVsi4Zl6eM4+GoFx
         DosrVTzNtq/yGVB2B8hXyznHjEqFoWrBVpnfiXclu3paAMItkjT8cOfBlsVatfbICubD
         6Ncbtd9NZ8Xro7Pj8ygQbd1f7gSY6BaFtIrzlK/3DxXAs7UoVtIH3D4H8kEHNZhplppW
         31rtMls0WRzjRj0DCi87jebtwXsB6C1KuBkvhBmMlZct/AXY/P9NZp9BAUDNNNU39h0/
         te3c+rjSi8bmx9ayo/gCuSNq7PQft1cGx5p/mt7xiZJu2LBTO1aEuKeZ9cR8mnN8LTLv
         wBUQ==
X-Gm-Message-State: AGRZ1gICBkzSLIdnJod3eZ+nAnDQ4htwGi0bpIyHAMtG7TK1ZFv10EFY
        e+b84qIr5To679xFm2tlN1cHpQScXpzoXVPKU9+RaA==
X-Google-Smtp-Source: AJdET5fzhfmLanTAmPFIVMMYu7A95A2K/VNy8o9kO7hIEzaevo7Rj7UIdurNzEEOVgbCdfJ7yYjPwNRUeIOXk6NmZK0=
X-Received: by 2002:ab0:648b:: with SMTP id p11mr1604254uam.128.1540998995900;
 Wed, 31 Oct 2018 08:16:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:f48d:0:0:0:0:0 with HTTP; Wed, 31 Oct 2018 08:16:32
 -0700 (PDT)
In-Reply-To: <20181031151007.GA21207@redhat.com>
References: <20181029221037.87724-1-dancol@google.com> <87bm7a3et9.fsf@xmission.com>
 <20181031124435.GA9007@redhat.com> <CAKOZuevTF2cjJ0-nK7nv7jbgFexyW-deScaYVzE3iEPC48SAJg@mail.gmail.com>
 <20181031151007.GA21207@redhat.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Wed, 31 Oct 2018 15:16:32 +0000
Message-ID: <CAKOZues0_jMfW8xAa0mC=QS7UnHMzkWb5nCz3S_GDf3RzPg90Q@mail.gmail.com>
Subject: Re: [RFC PATCH] Implement /proc/pid/kill
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
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

On Wed, Oct 31, 2018 at 3:10 PM, Oleg Nesterov <oleg@redhat.com> wrote:
> On 10/31, Daniel Colascione wrote:
>>
>> > perhaps it would be simpler to do
>> >
>> >         my_cred = override_creds(file->f_cred);
>> >         kill_pid(...);
>> >         revert_creds(my_cred);
>>
>> Thanks for the suggestion. That looks neat, but it's not quite enough.
>> The problem is that check_kill_permission looks for
>> same_thread_group(current, t) _before_ checking kill_of_by_cred,
>
> Yes, you are right.
>
> Looks like kill_pid_info_as_cred() can find another user, but probably
> it needs some changes with or without /proc/pid/kill ...
>
>> There's another problem though: say we open /proc/pid/5/kill *, with
>> proc 5 being an ordinary unprivileged process, e.g., the shell. At
>> open(2) time, the access check passes. Now suppose PID 5 execve(2)s
>> into a setuid process. The kill FD is still open, so the kill FD's
>> holder can send a signal
>
> Confused... why? kill_ok_by_cred() should fail?

Not if we don't run it. :-) I thought you were proposing that we do
*all* access checks in open() and let write() succeed unconditionally,
since that's the model that a lot of FD-mediated resources (like
regular files) use. (MAC notwithstanding.)

Anyway, I sent a v2 patch that I think closes the hole another way. In
v2, we just require that the real user ID that opens a /proc/pid/kill
file is the same one that writes to it. It successfully blocks the
setuid attack above while preserving all the write-time permission
checks and keeping the close correspondence between
write()-on-proc-pid-kill-fd and kill(2). Can you think of any
situation where this scheme breaks? I *think* comparing struct user
addresses instead of numeric UIDs will protect the check against user
namespace shenanigans.
