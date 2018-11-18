Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A66F5C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 20:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4119320817
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 20:33:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DVK0+TfW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4119320817
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbeKSGyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 01:54:15 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:40603 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbeKSGyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 01:54:15 -0500
Received: by mail-vs1-f68.google.com with SMTP id z3so766384vsf.7
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 12:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=en+J5RAKD8cLkaXfMXEkLrR1SyaamgkVqtyoR4X0bDY=;
        b=DVK0+TfW8gWh0sIgUIq390EhQMOilivFqkQZeXG9grpsmLGcFNY/opi/tC/hEoG2/g
         Lx89y0Ktkb0x15KrkPo0CfldijTqJmeE7imkk26OCZpnfotXCRc3LTPW7ToMggioJObN
         x0HLJNULxrxiZ9xlOaB2mE01wRaWus505NB6uasQWXni2LyrmGBrmp9xs6F85Dy+xyzG
         Q0Lf8b4nsnL8SPEQ+Nemhk1PsX5R6ilrTCZjEyGOyEhcFB3MdP9gFjEzx3flR/ykE2PW
         xNQHV5G/Vt7SyswHvO8W3298Lvnz/5IZmX1TL7xtzRYF9bEd/UuNO3fnDfzeiX0e9iUg
         qmyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=en+J5RAKD8cLkaXfMXEkLrR1SyaamgkVqtyoR4X0bDY=;
        b=qPdiqu34CU4i/JdZz39MInhY2NpvypLI1/dXWORMY3k/cN4H7OgMnJq0fdBE0WAFgy
         xPynnWWWBsA9LkIaJzRNVUyY1Gkw3NgkjEKwIuzk1XThC9/93k4Ae4WnAw/zV/JRhRok
         600BZUr9C7DlKIVAmUcu2CZn3yiyi/OcRh7SHhzJCJ+RITyfx4Y/dXVGb14tf8/yiyAd
         xMfaWGQQizUV9T5vafNjyDZVfJUE3JU6To5i8YiiuCpOZE3v7NEvE3IjOT9RlhASCxTu
         GuAw/OSw5LcbdTiR7SRrHuxnLzQl9VBRIf4o58ZjnPdetvIWzcGkV4FpQa4lZD40e3If
         MG/A==
X-Gm-Message-State: AGRZ1gKLJCL1gRqXx1og2I7FttZcQbXLq7IFBIa3piQKen1JjfBCmtw6
        5I1n8PrAh7pU3RKxEj6DsjH5pcoI+BGGVHtrt7+/gQ==
X-Google-Smtp-Source: AJdET5ftQ2Iqok63lVupEYU9sqJDD0tOPrzinhxMHU94Vi1MXniNpezc/DOTcKeK8PKnxv3YV5FA8EYmzVwnsk91icw=
X-Received: by 2002:a67:b44:: with SMTP id 65mr7961791vsl.77.1542573177603;
 Sun, 18 Nov 2018 12:32:57 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a67:f48d:0:0:0:0:0 with HTTP; Sun, 18 Nov 2018 12:32:56
 -0800 (PST)
In-Reply-To: <608F2959-800D-46EE-A7CD-8C972ACD2F02@amacapital.net>
References: <CAKOZuev1JUGFWuwsKqS6rXcFMqpCHT1VAG2kwB4O=FHo6DAFiQ@mail.gmail.com>
 <CALCETrVLP_mudJTW6EQpRr5GZ7kfuGci+QCT1uPrOVDTWcod-A@mail.gmail.com>
 <a7f50692-667c-4efe-a2d0-fa324eebb90b@infradead.org> <CAKOZueutLc8d0Fe+7dNWiZKnALhTSST8+kCnOrL+OmB6coUmtA@mail.gmail.com>
 <CALCETrVg71XBv-gMOtL-m0Dd0HNz8_oXOUDSWin5LeViAL0UYA@mail.gmail.com>
 <CAKOZuesCKo4GH9fdum2EUFLrtTWam3aizcDQUn3-vCYg4T1P8w@mail.gmail.com>
 <CALCETrUeNZPfrSYa9vH5Ukrk1Y+Kb9GkZOh6LkqG6Z9NpK5P0w@mail.gmail.com>
 <CAKOZuevVk_aH_2TuiNcmxgMa+gHXMBXz6Uu5a6TDjoxjhaE36g@mail.gmail.com>
 <CALCETrVscRwQG55-j1SKc2TmSb1-=5861804ojUuviNzdyDOrA@mail.gmail.com>
 <CAKOZuevRq-igh06zS_nsGG400zXrKFCtajpEG9-xgU2+Rtb2Pw@mail.gmail.com>
 <20181118190504.ixglsqbn6mxkcdzu@yavin> <CAKOZuetfqvn1uVqKJ=16iEzG4g449YOjC_tLM60eKBSkv9u+bQ@mail.gmail.com>
 <608F2959-800D-46EE-A7CD-8C972ACD2F02@amacapital.net>
From:   Daniel Colascione <dancol@google.com>
Date:   Sun, 18 Nov 2018 12:32:56 -0800
Message-ID: <CAKOZuet4uzYjvNznfUvid2RH8kAuxteWWc26vLhJHKSfS6MjAA@mail.gmail.com>
Subject: Re: [PATCH] proc: allow killing processes via file descriptors
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Andy Lutomirski <luto@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Christian Brauner <christian@brauner.io>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Kees Cook <keescook@chromium.org>,
        Jan Engelhardt <jengelh@inai.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 18, 2018 at 12:28 PM, Andy Lutomirski <luto@amacapital.net> wro=
te:
>> That is, I'm proposing an API that looks like this:
>>
>> int process_kill(int procfs_dfd, int signo, const union sigval value)
>>
>> If, later, process_kill were to *also* accept process-capability FDs,
>> nothing would break.
>
> Except that this makes it ambiguous to the caller as to whether their cur=
rent creds are considered.  So it would need to be a different syscall or a=
t least a flag.  Otherwise a lot of those nice theoretical properties go aw=
ay.

Sure. A flag might make for better ergonomics.

>> Yes, that's what I have in mind. A siginfo_t is small enough that we
>> could just store it as a blob allocated off the procfs inode or
>> something like that without bothering with a shmfs file. You'd be able
>> to read(2) the exit status as many times as you wanted.
>
> I think that, if the syscall in question is read(2), then it should work =
*once* per struct file.  Otherwise running cat on the file would behave ver=
y oddly.

Why? The file pointer would work normally.

> Read and poll have the same problem as write: we can=E2=80=99t check caps=
 in read or poll either.

Why not? Reading /proc/pid/stat does an access check today and
conditionally replaces the exit status with zero.
