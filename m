Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E2F4C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 22:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50D0F20855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 22:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dS3RTySV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50D0F20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728429AbeKJIZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 03:25:00 -0500
Received: from mail-ua1-f51.google.com ([209.85.222.51]:36798 "EHLO
        mail-ua1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728148AbeKJIY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 03:24:59 -0500
Received: by mail-ua1-f51.google.com with SMTP id j3so1197628uap.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 14:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vLCeayyhQPEp7DhR4w0Soy9DxKx4sBpZFu+34SRL47I=;
        b=dS3RTySVZTs/k+NRRS/Zg+ZlOEpkMFGCVZu793BXfK267z8bMl7g+SY8RohjpPO7vE
         +yM634keTiuE7Hop82eRD7NNRtodgvEP0QXGKegoC6AHAMRQvFS3FTw2kv3ddRiOgE7v
         hU61XXrLaf1yXoxDAVEYLUxqUCLGJ231U2NFpwT5ehiIw3Z+SfC0WSsRYdo+iz0Os29d
         /2Dk4f2JkPom1L0Qd8xjeqtOFrkCFbT/sR5JqSc9DlVg5rHfsdbXFBSltHD36WcWyZ9D
         a4+vJ1F2veJLbZE6n9YEMR2mi1zUvfqvsWJdd0ik4r581kfqkhfPX6u7QXiwKqVYILGh
         g+dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vLCeayyhQPEp7DhR4w0Soy9DxKx4sBpZFu+34SRL47I=;
        b=ctuv5z7cUIuWJ2UOypohvgMlbWwj5aISrFpB4ZndUrb7OZCCt8gbkb8oZZPorCxhvp
         d/1kN8N9vebRipzK+29ZT35lM8pyoMy7rMMXLjJ1HjxJT7xKsj4orwTy09UfjNunk2Ur
         dPCP5XsIySmnON2PQTZ5OlTjuVHBgtlLYqoSZivY8DslDs1x9K1XRiQxvUbzgQaoc7hL
         n5wkcxbIZTd9aZVH25kvbtNEBlXfH1QfVWRiGtqI4gd8vgYR+3Q8JQB/fB3an8YJlIl0
         /T7s9LIUdYP24KchJLwOlRCBGo1pGaw65AI4PdVH/YqdjKQyy8RX9Qv9KY9xmmduFu+k
         bZzA==
X-Gm-Message-State: AGRZ1gLdQr8V7+KwqZHoX/eW1xdOiPSkjhrv1z+z56kXGzNlcA1KWjqp
        FyC4jZ043Q6lihjdQcTT9oYjaYbk1FO+avCwrtUoDw==
X-Google-Smtp-Source: AJdET5cKvclVT+rpHl+4ShBQ1/2va/r/Yn7pRoHmbZdakgqKAuT0jNldes6AREeC1MgyH0t79oOJPbBJE9KKaZ+8xz0=
X-Received: by 2002:ab0:45e2:: with SMTP id u89mr4859774uau.13.1541803338992;
 Fri, 09 Nov 2018 14:42:18 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a67:f48d:0:0:0:0:0 with HTTP; Fri, 9 Nov 2018 14:42:18 -0800 (PST)
In-Reply-To: <BB64C995-F374-49EB-8469-4820231D8152@amacapital.net>
References: <20181108041537.39694-1-joel@joelfernandes.org>
 <CAG48ez1h=v-JYnDw81HaYJzOfrNhwYksxmc2r=cJvdQVgYM+NA@mail.gmail.com>
 <CAKOZuesw1wG-YynWL7bVb+4BWtYp0Ei62vweWF+mqF1Ln-_2Tg@mail.gmail.com> <BB64C995-F374-49EB-8469-4820231D8152@amacapital.net>
From:   Daniel Colascione <dancol@google.com>
Date:   Fri, 9 Nov 2018 14:42:18 -0800
Message-ID: <CAKOZuetZrL10zWwn4Jzzg0QL2nd3Fm0JxGtzC79SZAfOK525Ag@mail.gmail.com>
Subject: Re: [PATCH v3 resend 1/2] mm: Add an F_SEAL_FUTURE_WRITE seal to memfd
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Jann Horn <jannh@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        John Reck <jreck@google.com>,
        John Stultz <john.stultz@linaro.org>,
        Todd Kjos <tkjos@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bruce Fields <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>,
        Khalid Aziz <khalid.aziz@oracle.com>, Lei.Yang@windriver.com,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>, marcandre.lureau@redhat.com,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Minchan Kim <minchan@kernel.org>,
        Shuah Khan <shuah@kernel.org>, valdis.kletnieks@vt.edu,
        Hugh Dickins <hughd@google.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 9, 2018 at 2:37 PM, Andy Lutomirski <luto@amacapital.net> wrote=
:
>> Another, more general fix might be to prevent /proc/pid/fd/N opens
>> from "upgrading" access modes. But that'd be a bigger ABI break.
>
> I think we should fix that, too.  I consider it a bug fix, not an ABI bre=
ak, personally.

Someone, somewhere is probably relying on it though, and that means
that we probably can't change it unless it's actually causing
problems.

<mumble>spacebar heating</mumble>

>>> That aside: I wonder whether a better API would be something that
>>> allows you to create a new readonly file descriptor, instead of
>>> fiddling with the writability of an existing fd.
>>
>> That doesn't work, unfortunately. The ashmem API we're replacing with
>> memfd requires file descriptor continuity. I also looked into opening
>> a new FD and dup2(2)ing atop the old one, but this approach doesn't
>> work in the case that the old FD has already leaked to some other
>> context (e.g., another dup, SCM_RIGHTS). See
>> https://developer.android.com/ndk/reference/group/memory. We can't
>> break ASharedMemory_setProt.
>
>
> Hmm.  If we fix the general reopen bug, a way to drop write access from a=
n existing struct file would do what Android needs, right?  I don=E2=80=99t=
 know if there are general VFS issues with that.

I also proposed that. :-) Maybe it'd work best as a special case of
the perennial revoke(2) that people keep proposing. You'd be able to
selectively revoke all access or just write access.
