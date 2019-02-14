Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B08C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 01:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2DEE222A1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 01:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dionne-riel-com.20150623.gappssmtp.com header.i=@dionne-riel-com.20150623.gappssmtp.com header.b="RBjqNvJe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730247AbfBNB1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 20:27:47 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46506 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbfBNB1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 20:27:47 -0500
Received: by mail-lj1-f194.google.com with SMTP id v16so3717990ljg.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 17:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dionne-riel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PKnCJsZO+ue1MoqXGh784Vd0v0SSwQVS95AFfPY1odQ=;
        b=RBjqNvJeuSDefI2CBdtS3SCJlV0P1+3F7xT18s37ThBTahD50MUHqwoh3FQaqPxpFh
         SFmudKQPSoF/un6zld39U37cbiPeHqXvq5gqzqDPIEEDaOn3ZJz43i66mDuuQk6gHmTn
         tb06Np38jdEYrbQec41x08HLypIKStzAYVltLVsIG/JIWPO4yTmdW2bcp77GKQdkUVCO
         npQFGIuGRL+EiVPD2oK0Bjj8qkTzmhRcRclev+4a2UjSh1fycNCp/FkkgHQkfwUQJGJo
         R1W4xgwphN5C4weh789hWXiPGVk+RDN+WlVjazWhZZpz0g4uTKGST86MJ4brapwxnGBF
         Pkzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PKnCJsZO+ue1MoqXGh784Vd0v0SSwQVS95AFfPY1odQ=;
        b=b9TWfbY/qoE6lQ00Ad5qog2ij1ii2BQ3pkJP5FKEYLLwfVNkpOcA/MLrZdWNtJxehl
         236dic1nVJ7EcgzINw4K1TPaKj0nHHzgbqpNUALQqlyzFOF9coZeUutteFDiKErtmlnH
         MSuq8Kl4OUk4fpVW2ZDNLVG3VLD78YMCnyR9LXmmtw24EA70xfQ/Iwxc2p3P/Zbf9gl0
         CK3NQVgcPQcQ4z0b9dN66d0BRSHEpxzCcL34kTo2tkcXIq57e+QsuXj98NeZw74a1ww9
         J64e31RGjLBubDJI+BfV6INWWXGyxOeSB9ynKTQYmqC6nJrhgHSO/+jysxPIGFs1Eph6
         T3/g==
X-Gm-Message-State: AHQUAubzQ0U64Nx3iJqdehN3uUz9tw018wQU2URgH5seYzR8BYn7boBD
        646+Gk//HP3O262Pe9ZniBOszT+87piEf+pjAxpLj0rztlo=
X-Google-Smtp-Source: AHgI3IbySG6sPRtffhnOBXDygvhVwnqQM3G8DduW5IxED5MtyeclVTaBo4Do9NTsyH4OoLIGCLFzWPr7XQgcQiZwlV8=
X-Received: by 2002:a2e:9105:: with SMTP id m5mr655838ljg.100.1550107664778;
 Wed, 13 Feb 2019 17:27:44 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ab3:5612:0:0:0:0:0 with HTTP; Wed, 13 Feb 2019 17:27:43
 -0800 (PST)
In-Reply-To: <CAGXu5jJoqnX54JnHZDVxO4NRCsT6sLH4+-TPk8GqCSVp0mFNLw@mail.gmail.com>
References: <CAN1fySViLgrLAHHfTHMef-Bkh73kUHKP-ava6TbgALeSE4LfFw@mail.gmail.com>
 <CAFLxGvwpuxKF4UWdsULwQWo7kgVLMNHC=77dN+w-A0a6avrAXA@mail.gmail.com>
 <CAN1fySXjLUYFw2JGQQ5xxqjX+6kygzqgUc6Oj-sbtq=ZjgfLTA@mail.gmail.com> <CAGXu5jJoqnX54JnHZDVxO4NRCsT6sLH4+-TPk8GqCSVp0mFNLw@mail.gmail.com>
From:   Samuel Dionne-Riel <samuel@dionne-riel.com>
Date:   Wed, 13 Feb 2019 20:27:43 -0500
Message-ID: <CAN1fySW2mTaHmj7_uon_xZBVgPeEuYCD8e+JGOSKNwokmgZ7yg@mail.gmail.com>
Subject: Re: Userspace regression in LTS and stable kernels
To:     Kees Cook <keescook@chromium.org>
Cc:     Richard Weinberger <richard.weinberger@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Graham Christensen <graham@grahamc.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/02/2019, Kees Cook <keescook@chromium.org> wrote:
> On Wed, Feb 13, 2019 at 4:41 PM Samuel Dionne-Riel
> <samuel@dionne-riel.com> wrote:
>> Before, the interpreter was still used (assuming it wasn't cut by the
>> length), and the interpreter was free to re-read the shebang if
>> desired.
>
> So, to address the "wrong binary" problem, how about we ENOEXEC only
> if no newline or spaces are found in the string?
>

If I understand right, you're asking whether it should return NOEXEC
if, of the first 128 bytes of the shebang, there are no spaces, but a
too long shebang? I wouldn't know for sure. The behaviour would
change. Instead failing due to trying to execute a shortened path, it
would fall back to the shell interpreter interpreting the file, which,
due to the inclusion of a specific shebang, might be a wrong
assumption still. Here I believe it's still in the "undefined
behaviour" territory, but one where it fails early for the userspace.

I don't have a strong opinion, but having a special case depending on
whitespace or not (well, possibility of the interpreter being
truncated or not) feels off. As an end-user, I would rather it
truncates, and show the truncated interpreter it tried to use
(behaviour before regression), rather than fail in a way where the
libc will continue executing using another unexpected interpreter.

Thinking in the principle of least astonishment, I would be less
surprised to see a truncated path on exec() than seeing exec() use an
unexpected interpreter.

--=20
=E2=80=94 Samuel Dionne-Riel
