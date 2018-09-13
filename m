Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 533AAC07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 11:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05DA520861
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 11:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GEBr3hfT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05DA520861
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbeIMRFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 13:05:05 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:41973 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726919AbeIMRFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 13:05:04 -0400
Received: by mail-oi0-f68.google.com with SMTP id k12-v6so9112579oiw.8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 04:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B6h1//2vm/HylacJxfhbEtuT8QaYZ0/+orUQ80a469M=;
        b=GEBr3hfTWjo9lKxg+UgrwmL2UIm7Vgb0ctS2yw0Kr88J4PIASur5oGUa/KgOoa0Fyf
         7t60WaqY/Q3LbTkHbmwUh0/7YQj+YyBJ364K/mD12cOK1AQbpE/JK2efePq/cV6KXKBS
         VdszsMb1Odrwi+nrmzBL1YGD6S1Db9Au2NZy2kClwgSXyUWK405I1N990hd9jgjYz5mK
         VxjywaMABUi2t4Qc42/IcRo/MmGGzzNGdKKAWPVY0ysMEgoJGwuR8SmlimVBKlwJ4PSt
         r0XqvRtTkesfRuL2cIJzGcaXezcyq7jdBVZ8l0E7CqwaatTZH6AI0KeVADtHwJAQ1PA/
         jWng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B6h1//2vm/HylacJxfhbEtuT8QaYZ0/+orUQ80a469M=;
        b=Uin32OfwJskwApEtPDRuIwiI+ZphtLhBNYUKfQfZxDHmWo9LrZSSrvdjpV/zzQoC1A
         BgHekKCgxhjkz15Dc1eq16LQR/5X2DWM7zxmxxQPpUKpCuXBpRt1/IE/a3vqZZWYnDx9
         JxoimKfB0OG28MtrKDquSO3QHZMK/Ye14mSH2S+aiJWbD3673NTEt8R5PSeaw1WdlXAK
         7YoDBOg8EfYslYVimI+b96VRVm5XnHV0TQm1Yi1baL41lmGoCjTv9iSo+5DtslNCgkO7
         PJR/I96cCpv3OM9JHwEQUNdrMEeWwKuDAzby4qumeePMCGZPh/zqFTs1Djb89lrtClO+
         9Wrg==
X-Gm-Message-State: APzg51BZUrU8iylCXrjQ/53Yoosq5lK+JWcVTmSe2y9ro54fhOEhSRPV
        +3Nwd7PlTP1R/qarQ8RPdtiE2u/MMwGg2YrIW/RA8A==
X-Google-Smtp-Source: ANB0VdbRP5cpalSlz2dpiHINGrrCz85MgTJUmNhMRobsptAQe3y6tOccIbBrLwfU8ZFu48Lv5D2bp2t+xynX/W0p+kY=
X-Received: by 2002:aca:4204:: with SMTP id p4-v6mr5826384oia.242.1536839754855;
 Thu, 13 Sep 2018 04:55:54 -0700 (PDT)
MIME-Version: 1.0
References: <20180911183909.233413-1-jannh@google.com> <CAG48ez03ivLr6w+V911V7pqb1o=kcJw4CLEktcSVVE+=hXXP=w@mail.gmail.com>
 <CAGXu5jKBPh+TSCuaitpPdk89hW=ch+QeRsUfE68pLpzLS=z4Jg@mail.gmail.com>
In-Reply-To: <CAGXu5jKBPh+TSCuaitpPdk89hW=ch+QeRsUfE68pLpzLS=z4Jg@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 13 Sep 2018 13:55:28 +0200
Message-ID: <CAG48ez22djpKdtYDTMn0MS=2m_QAq983O0-oXyVGiu3ju2HwXg@mail.gmail.com>
Subject: Re: [PATCH] proc: restrict kernel stack dumps to root
To:     Kees Cook <keescook@chromium.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Ken Chen <kenchen@google.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>, security@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 12:28 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Sep 12, 2018 at 8:29 AM, Jann Horn <jannh@google.com> wrote:
> > +linux-api, I guess
> >
> > On Tue, Sep 11, 2018 at 8:39 PM Jann Horn <jannh@google.com> wrote:
> >>
> >> Restrict the ability to inspect kernel stacks of arbitrary tasks to root
> >> in order to prevent a local attacker from exploiting racy stack unwinding
> >> to leak kernel task stack contents.
> >> See the added comment for a longer rationale.
> >>
> >> There don't seem to be any users of this userspace API that can't
> >> gracefully bail out if reading from the file fails. Therefore, I believe
> >> that this change is unlikely to break things.
> >> In the case that this patch does end up needing a revert, the next-best
> >> solution might be to fake a single-entry stack based on wchan.
> >>
> >> Fixes: 2ec220e27f50 ("proc: add /proc/*/stack")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Jann Horn <jannh@google.com>
> >> ---
> >>  fs/proc/base.c | 14 ++++++++++++++
> >>  1 file changed, 14 insertions(+)
> >>
> >> diff --git a/fs/proc/base.c b/fs/proc/base.c
> >> index ccf86f16d9f0..7e9f07bf260d 100644
> >> --- a/fs/proc/base.c
> >> +++ b/fs/proc/base.c
> >> @@ -407,6 +407,20 @@ static int proc_pid_stack(struct seq_file *m, struct pid_namespace *ns,
> >>         unsigned long *entries;
> >>         int err;
> >>
> >> +       /*
> >> +        * The ability to racily run the kernel stack unwinder on a running task
> >> +        * and then observe the unwinder output is scary; while it is useful for
> >> +        * debugging kernel issues, it can also allow an attacker to leak kernel
> >> +        * stack contents.
> >> +        * Doing this in a manner that is at least safe from races would require
> >> +        * some work to ensure that the remote task can not be scheduled; and
> >> +        * even then, this would still expose the unwinder as local attack
> >> +        * surface.
> >> +        * Therefore, this interface is restricted to root.
> >> +        */
> >> +       if (!file_ns_capable(m->file, &init_user_ns, CAP_SYS_ADMIN))
> >> +               return -EACCES;
>
> In the past, we've avoided hard errors like this in favor of just
> censoring the output. Do we want to be more cautious here? (i.e.
> return 0 or a fuller seq_printf(m, "[<0>] privileged\n"); return 0;)

In my mind, this is different because it's a place where we don't have
to selectively censor output while preserving parts of it, and it's a
place where, as Laura said, it's useful to make lack of privileges
clearly visible because that informs users that they may have to retry
with more privileges.

Of course, if you have an example of software that actually breaks due
to this, I'll change it. But I looked at the three things in Debian
codesearch that seem to use it, and from what I can tell, they all
bail out cleanly when the read fails.
