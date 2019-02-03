Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93067C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 22:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 467A120815
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 22:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="fIoH2VhX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbfBCWxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 17:53:42 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39728 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727321AbfBCWxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 17:53:42 -0500
Received: by mail-lj1-f195.google.com with SMTP id t9-v6so10118222ljh.6
        for <linux-kernel@vger.kernel.org>; Sun, 03 Feb 2019 14:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H5YAEWpSDTl73pTopxapLK3m/IiGvv5Em1bDFhwwCNw=;
        b=fIoH2VhX9RU7IxH4nhy2FQ+Hb3vYoA2lT8L/GOANOwmoaAD/H1IIEudPb7o47YxNVT
         b93YLiLPHuN3CiNTRMja2RP/BSf3yEGgAu3Fu8YLlZDc8dSgR5UDy+KR8+5eYaMBM0O/
         hl4PjVNqB/DZ7dEh/Sdi+7W5uL4QI537hzbUxy3/RHpVcl/gKdBxigINyM+HJyDCAnwF
         yb6cVz8J11dM1joPxgKtj3uYdp4DSYghFSBxwvrgbA/GfzattP9q2JTE2UoCKt65mhgN
         uyvabuoZX0tIW5yB7UQ0pLjVovsqfk2lyKY7tCyepidgMDP6i77ojU/VQoJ++yrGTUdd
         mJ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H5YAEWpSDTl73pTopxapLK3m/IiGvv5Em1bDFhwwCNw=;
        b=U1m9NtqQkNsrHCPfsEHhlmwzS62xr/9WWn7wO95/Wgq1kYaCWJSRsYM0freha4IPgJ
         eQMGJoubGcSc0S6ol6CXO18QnWtdJMMz3L8KYRhuj0kOssPq3WxzyhCWbenUEgmGMP9m
         HEOsQhPwx3+myGs12r3zefxY/dTglDBoCbU4v8grjooOiHTvbOtYq7rJe5n6r4pNl96D
         D5KNYEznBftwh/iTykHdUjsk+BPkkU/YiDAnAJKDzir1AIboMxKgR0FqrmnBoDConWSx
         l7CRJptzjUyFMEVn6i/9t5J1xrf1hBCxXBUZJNy86+wObApgpV9Ec5PboDniWOhzqCIx
         sEEQ==
X-Gm-Message-State: AHQUAuYSpgXzGxZZY+S7o/tGcobGnee8BKwMP/rOGFRFsNuHxIzeihFD
        BmOKqcnsg1uWm2WuccJPHqo2rP+eH6H87eqPxq2s
X-Google-Smtp-Source: AHgI3IYQnwDNaYyU1dMaz+yhW5yhF+BtYWHzNILR32vYaak3oUQyHRnw+nttHKHMSF6lpIkgNc5neaO9jv3Y9TDMJ94=
X-Received: by 2002:a2e:474a:: with SMTP id u71-v6mr6447268lja.161.1549234420069;
 Sun, 03 Feb 2019 14:53:40 -0800 (PST)
MIME-Version: 1.0
References: <0c4ada9c89959ce0aa82e35ffa477ce245f2bb8b.1549074196.git.rgb@redhat.com>
In-Reply-To: <0c4ada9c89959ce0aa82e35ffa477ce245f2bb8b.1549074196.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 3 Feb 2019 17:53:28 -0500
Message-ID: <CAHC9VhTmwh-HRiY1+iinhMrqL8xX+3gvu+2ZywEvijDxAf+P-w@mail.gmail.com>
Subject: Re: [PATCH ghak105 V3] audit: remove audit_context when CONFIG_ AUDIT
 and not AUDITSYSCALL
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        Eric Paris <eparis@redhat.com>, Steve Grubb <sgrubb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 1, 2019 at 10:45 PM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> Remove audit_context from struct task_struct and struct audit_buffer
> when CONFIG_AUDIT is enabled but CONFIG_AUDITSYSCALL is not.
>
> Also, audit_log_name() (and supporting inode and fcaps functions) should
> have been put back in auditsc.c when soft and hard link logging was
> normalized since it is only used by syscall auditing.
>
> See github issue https://github.com/linux-audit/audit-kernel/issues/105
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
> Tested with CONFIG_AUDITSYSCALL automatically set "y" and manually set
> "n".  Passes all audit-testsuite with the former and the expected subset
> that don't depend on syscall auditing for the latter.
>
> changelog v2:
> - guard audit_context by CONFIG_AUDITSYSCALL in task_struct
> - rebase/resolve merge conflicts on upstreamed ghak103 v1.1/1
>
> changelog v3:
> - re-instate audit_context in audit_buffer (though not needed)
> - rebase/resolve merge conflicts on upstreamed ghak100 v2.2/2
>
>  include/linux/sched.h |   4 +-
>  kernel/audit.c        | 157 -------------------------------------------------
>  kernel/audit.h        |   9 ---
>  kernel/auditsc.c      | 158 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 161 insertions(+), 167 deletions(-)

Merged into audit/next, thanks.

-- 
paul moore
www.paul-moore.com
