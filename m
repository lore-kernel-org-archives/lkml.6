Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C9AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6E212070C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dionne-riel-com.20150623.gappssmtp.com header.i=@dionne-riel-com.20150623.gappssmtp.com header.b="P+6OmcYb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395322AbfBNDQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 22:16:17 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40514 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390020AbfBNDQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 22:16:16 -0500
Received: by mail-lj1-f195.google.com with SMTP id z25-v6so3897295ljk.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 19:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dionne-riel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oz7mEj1PyPdx47Z542OOOgMZTRRN8i/r2FlwV9qjH0c=;
        b=P+6OmcYbYKJ57aI0Qdfe6Jdd4pzvGMItLtYB0gXWsrsFzA22IBrKDyqmvsmJjLbM3n
         4Rb6n+0ZnUYYfj9moaVWffpFJfjSrKSNvXyspj83AKBn8LC4SPgKs+lxsEUa41e2lHY0
         SoNtAburXbjTibaAXd9qMDHA3HqyFy+uo/gIUHxpwEcERBS4t+RIn5m12RiqfW1nNTtP
         1GIt8zua8Vf/5SfnfTixlHaGANt7iXcH4lH3wVF0J0UJb9zP2kTal4bJhl8eDLjFv2SV
         Fbg3i1ObNMn8SCuFx8biFN0JvL/AGfsIcDKjd490H2XCjC452UyHAid9orQLLRLsCfM4
         tqAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oz7mEj1PyPdx47Z542OOOgMZTRRN8i/r2FlwV9qjH0c=;
        b=SzPgaLIn6VDaWFI5zcmHatQ9CCU7+xp/Rx2VTL1QnKM3yE69QueTIOCnJd6KV39rwJ
         b3QeGYNmTZ+0O6uC9htYry235Zw8wxTec7Y5P4AgGzgajs6umYD+93vQHL1Gv/V6SR2L
         WVb0cBfhYacq+ZCd+31cxUtGbmokZL1lD//QaW5i1zp2vI1rEYsgxhV9srZ/1Fpzx0S4
         IIZawkGofsv68UR/75Xmvg6OkJQGVpUZn0O3dFkhHq05sTNSqnNSWcfv4yh5hGkbe2s8
         PwGx/uWW2581j6MsMFWrLvfKg1rHzRxuWO2Zupcu22+WG4HQAZDRAV5OgZBUN7ADQV3/
         +E5Q==
X-Gm-Message-State: AHQUAuY3h4dXcpBlvpbtvred3SRS4NY2+PnZupwcrEkM1aHOxbI1wdTT
        GSxanZPiEiryIXQaHWjckl2EkdLMwPaoMJ97WWB+OQ==
X-Google-Smtp-Source: AHgI3IYNSS5B1bvIwNNwjZKIRmaYk6tcdXUsFw4nXKMPCmtuKQXHj6rNSZoD0R2ReyawhQH7HzBwhlCZd88dcSY06+g=
X-Received: by 2002:a2e:4601:: with SMTP id t1-v6mr808018lja.111.1550114174813;
 Wed, 13 Feb 2019 19:16:14 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ab3:5612:0:0:0:0:0 with HTTP; Wed, 13 Feb 2019 19:16:13
 -0800 (PST)
In-Reply-To: <CAGXu5jKXUhYB9xBLMWTvJiJEVPyRd=RsZTOCSvbNv7i6pEhtmg@mail.gmail.com>
References: <CAN1fySViLgrLAHHfTHMef-Bkh73kUHKP-ava6TbgALeSE4LfFw@mail.gmail.com>
 <CAFLxGvwpuxKF4UWdsULwQWo7kgVLMNHC=77dN+w-A0a6avrAXA@mail.gmail.com>
 <CAN1fySXjLUYFw2JGQQ5xxqjX+6kygzqgUc6Oj-sbtq=ZjgfLTA@mail.gmail.com>
 <CAGXu5jJoqnX54JnHZDVxO4NRCsT6sLH4+-TPk8GqCSVp0mFNLw@mail.gmail.com>
 <CAN1fySW2mTaHmj7_uon_xZBVgPeEuYCD8e+JGOSKNwokmgZ7yg@mail.gmail.com> <CAGXu5jKXUhYB9xBLMWTvJiJEVPyRd=RsZTOCSvbNv7i6pEhtmg@mail.gmail.com>
From:   Samuel Dionne-Riel <samuel@dionne-riel.com>
Date:   Wed, 13 Feb 2019 22:16:13 -0500
Message-ID: <CAN1fySWW7y=nt72kHKydG-KrcrZhsj0YKZExyRc_OmAb_+QqAg@mail.gmail.com>
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
> The original problem that was trying to be fixed here was to disallow
> execution of a truncated interpreter path. It was assumed argument
> truncate was just as bad, but it's not, since the interpreter can (and
> does!) re-read the script to get the right arguments.
>
> So, I've sent a fix-up patch that should disallow the path truncation,
> but pass through the argument truncation as before. This passes all
> the tests I built:
>
> [...]
>
> Are you able to test the patch and report back?

The patch works as implemented. It also fixes the specific regression
which affected NixOS. This was verified to work once applied to 4.14
in our testing infra. Confidence is high enough that I don't think I
need to test other LTS/stable versions.


Though, I have one minor doubt in mind. Looking at man 2 execve,

ENOEXEC
   An executable is not in a recognized format, is for the wrong
   architecture, or has some other format error that means it cannot
be executed.

I can see "or some other format error" could be misapplied to mean
ENOEXEC on failure to read the shebang, but I'm thinking it's kinda
abusing the meaning behind the failure. The format was recognized, as
a shebang, but it was impossible to use the shebang. If I were to
misuse an error code, I would probably misuse ENAMETOOLONG. I'm still
doubting ENOEXEC is safe to not cause issues since a truncated
interpreter name (not shebang) will end up with a different behaviour
than expected in the exec(3) userspace scenario, where with ENOEXEC
the shell will be used instead of failing.

Though, this is a different face to the same root regression reported
here; our initial issue with the regression can be deemed fully
resolved with the patch.

In all cases, I think the man page will need an update to describe the
new failure mode with truncated shebangs, and describe the non-failure
mode when truncating arguments.


> Thanks again for bringing this to our attention!

Thanks for the quick turnaround!

--=20
=E2=80=94 Samuel Dionne-Riel
