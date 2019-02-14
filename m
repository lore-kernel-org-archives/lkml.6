Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0F9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61DB921A80
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="X4PmYtR3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbfBNXHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 18:07:33 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33832 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfBNXHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 18:07:33 -0500
Received: by mail-lf1-f68.google.com with SMTP id u21so5827983lfu.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 15:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7hlg+eKh/auF+5WjWvtMwFbY0os3KJiNPz+CKE17eCw=;
        b=X4PmYtR3b/vLVV8Rq+SsVlH05Njyet7+8JGlkL3Jhl5QjSCrvwxuOjJ7egjO0cAFUa
         MuWWobHTOiWwulA73H6UsLZHzP0psulbboA/BU3mHHAeWgbGvcK0Ef5wB2oOwKBYmZNx
         r2ZqugF4hMyZe80qdKWIoYTEgTUOKltWectYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7hlg+eKh/auF+5WjWvtMwFbY0os3KJiNPz+CKE17eCw=;
        b=Jb8nTl/BIF1jKNFf3+ToC7+Lh1SqlNZ7y5XiN21VmZ+DUvYPFR9kyzgKU48TWMgKCp
         K39RD/9AD558Ijuo5fMCd2r2W0FQOQcTkeQyRPhirykSix8XlxXM6E94n67nreOAIpqu
         WuCKZgUbAomjrFrz4TmoV+9fVsrvnbDTRFniqWB07u2r3oFtSk+lRMG6zxkG/QiWv3d1
         PYZblQU4SF9MNwmfre/tAJxtMDMqc3S4FN9YcwwN46+Zgph40I4PjmdehfdZh2c86aj3
         bPEf0qARQ/M0ZfMHg7ec+HzEMRpZxsQHw1ZK1AmvlS37EW/PR0mqM8UVLjDmxe/1Xums
         OIXQ==
X-Gm-Message-State: AHQUAuZ8V4/7fN/pHLmk1XiOC99u8nyPj+2HqwMwMzgwjjiGKavvkIiP
        0OuclE4wy9e4DWdZc2m3j+e/Nsbl2Ao=
X-Google-Smtp-Source: AHgI3IYzDUEL9z6v+YIDGDMGi/WAvfnlyJ6hC4HZOPA+o/zDYNholperIMuWhRVL1PUbsqXWC3wC7Q==
X-Received: by 2002:ac2:43c6:: with SMTP id u6mr3884073lfl.102.1550185650861;
        Thu, 14 Feb 2019 15:07:30 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id r80sm729339lff.33.2019.02.14.15.07.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 15:07:29 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id f5so5780685lfc.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 15:07:29 -0800 (PST)
X-Received: by 2002:a19:ae0a:: with SMTP id f10mr3621252lfc.1.1550185648629;
 Thu, 14 Feb 2019 15:07:28 -0800 (PST)
MIME-Version: 1.0
References: <20190214164331.GA33450@beast> <CAHk-=wg+Bc1Qmp0VBqPQq=_4=SgbN6jRvPtrme8-ieobpM16iw@mail.gmail.com>
 <CAGXu5jLYJyz+afGrMp_KbvL2xiwg3h6Cz_q6fQjXL9gpbej7QA@mail.gmail.com>
In-Reply-To: <CAGXu5jLYJyz+afGrMp_KbvL2xiwg3h6Cz_q6fQjXL9gpbej7QA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 14 Feb 2019 15:07:12 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgNt+Pm89Cqp5onH2dQN2ddAV-GU5ZftgrBpupx3h+juA@mail.gmail.com>
Message-ID: <CAHk-=wgNt+Pm89Cqp5onH2dQN2ddAV-GU5ZftgrBpupx3h+juA@mail.gmail.com>
Subject: Re: [PATCH v2] exec: load_script: Allow interpreter argument truncation
To:     Kees Cook <keescook@chromium.org>
Cc:     Samuel Dionne-Riel <samuel@dionne-riel.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        Graham Christensen <graham@grahamc.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 10:10 AM Kees Cook <keescook@chromium.org> wrote:>
> We certainly can, but we'll still need to fix the "don't exec a
> truncated interpreter path" problem (which this fixes).
>
> I'm happy to do it as two steps instead: revert, then a separate fix
> to land in the merge window?

I think that's better. It should also be fairly easy: just look for
whitespace in the truncated output (in the place where we already
check for the "oh, we truncated")

It's even possible that somebody depends on a truncated interpreter
executable name. Unlikely, but possiible. So I'd rather just revert,
and re-try the smaller approach for 5.1.

               Linus
