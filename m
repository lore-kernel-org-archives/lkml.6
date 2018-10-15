Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7193DC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 21:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30ED52089E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 21:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="INJGOQyA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30ED52089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbeJPFCJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 01:02:09 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42059 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbeJPFCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 01:02:08 -0400
Received: by mail-lf1-f67.google.com with SMTP id s10-v6so15179397lfc.9;
        Mon, 15 Oct 2018 14:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H6Z6RVy0ITbco0ghS71evfgCoO/mUd6T7wdJjxH9kt4=;
        b=INJGOQyAwbz7OONzqlt6AAVo0m0JD7IqF8019ZA3HugZTJn/lADba5yDzBjeOOsmW9
         Ovso4nzx+cty4QqDjvJ7Mv71zncw3sMxbXlsTFPhJBMHs8GX/A63FgK0i0JNdgbbXaC+
         37ee/SYK/WPyjWij6Z1XIHq3UJllCVQzNTw5UoUYZxFSlb4WJ0tz7HwTm9yC9GyNDjxc
         j4OTtzdoIcopVrIjDXBAOhAFz/VpsaNuKsAanWtcGzhCaoguM6Q39cD3M99kSL3a1OO4
         XtvYewwINUUpvYEIf9oenDL+Aw2bel+N8aEmJCxC6bDgqKF6PtV6ipeTHrRor6836JwF
         UoVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H6Z6RVy0ITbco0ghS71evfgCoO/mUd6T7wdJjxH9kt4=;
        b=tCa02x3qWK0XhaaLl8pHS7wZOgd25uY/I1hRTuH8Uw+UQYqFgbel6RhPeBFVEMMmzJ
         hrcXAnWkmxXdvPxwtumM/GNVeBs/xbYJXYletr3jof5roFIZcLyhpnQ+hZYJjoK+0Z+k
         tU0b3J+sP6/67yQlis3x/MgHgofMbnNrWzsND623uhUVD3XhUe5dp3DI1kO5c00VzWkT
         3j+0OGkF+GhigVbhnCpZ91g85wx+CzQE/mI1pD+yzyPptIIznRTB2FKFLKwdEm15LiWC
         qWPIAUrg++DCdqDwRkC+IOtAN4fIttZsocnzBzo30lhNDzGjJmjhUWLFHpXUzjWl19H/
         7T6A==
X-Gm-Message-State: ABuFfoh595JJ7gaN0VWo2ruJnFK7IyDw+6xUZLmX2yz7y/udjOiDdDQo
        k8hGLkb1Sh64Ts7uDcJT+h5mf9vBFHV+5YZT4KA=
X-Google-Smtp-Source: ACcGV63rDrT8AmrfYY4S8rqnRJyXpV8Wj0SKV/COCpLU53gJ78+VxE/0l3Q4cfgRO806t+GzwzR+E4ClPt+Lo2z2wYc=
X-Received: by 2002:a19:1090:: with SMTP id 16-v6mr3722219lfq.131.1539638108432;
 Mon, 15 Oct 2018 14:15:08 -0700 (PDT)
MIME-Version: 1.0
References: <20181015172221.35709-1-ndesaulniers@google.com>
 <CANiq72kLs-Z=ZDdWU_1JV-NG+D5yPEfgREny+nXQgPioyOB=mg@mail.gmail.com> <CAKwvOdnwfXSdBw_Y2zpAEdcn3aWRqUq9Fh8uk8EnkxPMC+c2Sw@mail.gmail.com>
In-Reply-To: <CAKwvOdnwfXSdBw_Y2zpAEdcn3aWRqUq9Fh8uk8EnkxPMC+c2Sw@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 15 Oct 2018 23:14:57 +0200
Message-ID: <CANiq72=PMEqu__HjQ-Y7DmzbWMRQPY6gQ5MF0cd9gF6vbCj=8Q@mail.gmail.com>
Subject: Re: [PATCH] compiler.h: update definition of unreachable()
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     luto@amacapital.net, Josh Poimboeuf <jpoimboe@redhat.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Christopher Li <sparse@chrisli.org>,
        linux-sparse@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 10:13 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Looking at commit cb984d101b30 ("compiler-gcc: integrate the various
> compiler-gcc[345].h files") it seems that the comment is referring to
> gcc 4.4 not supporting __builtin_unreachable().  Looks like it was
> added in 4.5 timeframe: https://godbolt.org/z/ugv5QO, so the comment
> can be deleted.  Would you prefer a v2 (single patch), or an
> additional patch on top?

Split would be better, I think, since the changes can be applied
independetly even if related. If you are busy, I can do it myself, so
don't worry too much. :)

Cheers,
Miguel
