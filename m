Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 047F8C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 06:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFD0321872
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 06:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IOC0xujn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732057AbfBOG1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 01:27:21 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:42161 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbfBOG1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 01:27:21 -0500
Received: by mail-vk1-f196.google.com with SMTP id y14so1989619vky.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 22:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nX4Wr1D9M1+c3CsrTt4yymxZtZjZuAzpI3GgtGnxxGw=;
        b=IOC0xujnEWxQSopc/iM5RAiWYKc6eHXNbVq5/Rv1tO+Wbf0m6RZU0q/pPF2JsSjbzT
         Ez8uZ0vYTSL1OV5ZH+kZ1wtKeJyq8TiU4jeYG56ZO9ilJvJNgUK6RaVx3tIjftXFMwXK
         1p4KvYLD5DWhYqqC4tzinnjmey0yadsoAGeqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nX4Wr1D9M1+c3CsrTt4yymxZtZjZuAzpI3GgtGnxxGw=;
        b=Y8wHHXgh+bVzORJWpIGB4UXsQ/mrKatNyfaP3xsgrd1eNK5x14Gj1lhrSj73YSNNZF
         BA3+9py45Cx8KmRS8NwJBgbyxiEW4QxFtY3F2KhaXvMdIl5YKP2PrV5oHfW34VxLrxem
         nSrRMnT0FSv4S57zBQ5QgLc9bvvvWdKt1d+1kW1KMMRPSAl+k+esv6OopITNlVoqyjtz
         NnJmdKytSH3q9V9EivPpk78KaOC2u5nWGglU46qtTUwBx0NC0f3v5QILKRHTR7Nv83XY
         +ZfcG+EZymOnrF6IYlFE+j1TBn10NMxLYjhzbusg58XMwk9LLq587/kMIMIDwkDs/x5w
         jAIA==
X-Gm-Message-State: AHQUAub1koNxz43TPFUoQi78zHhr7SJXmeql3iFStiRYpI9DDdzwDlnH
        aE4fSo9gyDq3569mo03b4BEcM/vtZoc=
X-Google-Smtp-Source: AHgI3IZWRKkvKaQKqcO8sWwSLvTNeR2Xfs3Z4bNH5rFM4a2G7UorSjV4L1ui/zvmaZKDf0ROXY1kRA==
X-Received: by 2002:a1f:5145:: with SMTP id f66mr3035087vkb.69.1550212040135;
        Thu, 14 Feb 2019 22:27:20 -0800 (PST)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com. [209.85.221.175])
        by smtp.gmail.com with ESMTPSA id s20sm458964vke.43.2019.02.14.22.27.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 22:27:19 -0800 (PST)
Received: by mail-vk1-f175.google.com with SMTP id f206so1997261vke.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 22:27:19 -0800 (PST)
X-Received: by 2002:a1f:998d:: with SMTP id b135mr4334072vke.44.1550212038592;
 Thu, 14 Feb 2019 22:27:18 -0800 (PST)
MIME-Version: 1.0
References: <20190215031758.GA18776@beast> <CAHk-=wg7DRUqWvbCS2dm=mpdSNJry92Fo0OHDVi67bi8BMqt4A@mail.gmail.com>
 <CAGXu5jLi+zcOoi+Ti=OyR3MfF8s_S35EEmT_DoCzYPepOcn+Ow@mail.gmail.com>
In-Reply-To: <CAGXu5jLi+zcOoi+Ti=OyR3MfF8s_S35EEmT_DoCzYPepOcn+Ow@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 14 Feb 2019 22:27:07 -0800
X-Gmail-Original-Message-ID: <CAGXu5jJXFP-1rEeYtMfqrSUz2oz8TWcjr89zL6-MPsNS7rwywg@mail.gmail.com>
Message-ID: <CAGXu5jJXFP-1rEeYtMfqrSUz2oz8TWcjr89zL6-MPsNS7rwywg@mail.gmail.com>
Subject: Re: [PATCH v3] exec: load_script: Do not exec truncated interpreter path
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Samuel Dionne-Riel <samuel@dionne-riel.com>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        Graham Christensen <graham@grahamc.com>,
        Michal Hocko <mhocko@suse.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 10:14 PM Kees Cook <keescook@chromium.org> wrote:
> But, as it turns out, the above is actually wrong too (yay for my test
> cases): the NUL termination before the loop (line 45) may blow away
> the newline at byte 127. So we need to actually manually scan for the
> newline while doing the out-of-bounds checking. (This was part of
> Oleg's original "don't blindly truncate" rationale in the reverted
> patch.)

Actually, though, this passes my regression tests:

diff --git a/fs/binfmt_script.c b/fs/binfmt_script.c
index 7cde3f46ad26..6d7787e35d76 100644
--- a/fs/binfmt_script.c
+++ b/fs/binfmt_script.c
@@ -42,9 +42,18 @@ static int load_script(struct linux_binprm *bprm)
        fput(bprm->file);
        bprm->file = NULL;

-       bprm->buf[BINPRM_BUF_SIZE - 1] = '\0';
-       if ((cp = strchr(bprm->buf, '\n')) == NULL)
-               cp = bprm->buf+BINPRM_BUF_SIZE-1;
+       if ((cp = strnchr(bprm->buf, BINPRM_BUF_SIZE, '\n')) == NULL) {
+               bool truncated = true;
+
+               for (cp = bprm->buf+2; cp < bprm->buf+BINPRM_BUF_SIZE-1 &&
+                                      ((*cp == ' ') || (*cp == '\t')); cp++);
+               for (; cp < bprm->buf+BINPRM_BUF_SIZE-1; cp++) {
+                       if ((*cp == ' ') || (*cp == '\t'))
+                               truncated = false;
+               }
+               if (truncated)
+                       return -ENOEXEC; /* Interpreter truncated */
+       }
        *cp = '\0';
        while (cp > bprm->buf) {
                cp--;

I still want to add all the comments, though. :)

(The above still seems uglier to me than just collecting the
information as we need it, but I'll do whatever.)

What do you think?

-- 
Kees Cook
