Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F20DECE562
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 01:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED977208AE
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 01:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zy6yQ5ci"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED977208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbeIPGtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 02:49:16 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:32889 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbeIPGtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 02:49:16 -0400
Received: by mail-ot1-f67.google.com with SMTP id i10-v6so8029155oth.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Sep 2018 18:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MES4kK9ZkxtTjWSgZujL8lYbFoxxjsUItEv0ENN+FtM=;
        b=Zy6yQ5ciFxgjiFIc6RJvLw3+/M1jeL/Z+jTagmrab3Gyw6bfDeXh51Q6bHTe0pS90T
         ATRtchPlA1Om+En5ziY832wkZ8E1xZm1bGFd0zULXCmAMNrIPzbBkZab2aItmOh2fQXA
         2BoysLjofLSId5UjRSVzcz/3YSNYPGsR2akNSNYDaC39KfQYEyWZg9tCJGSZM3kVJOpj
         s3mZRGmmekKf8P0w5aU0QaOTzK6dDNAbQb1ifAWbzNCIbx1NaF+/ZtQXUpvutH8vz/E5
         OPIoJmf7Si4O5DujrG+Ej1gH4cpwNQeQaSkVpxCes9JrBD1knvrSjSc/BZCNzzZ9UW8f
         mG5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MES4kK9ZkxtTjWSgZujL8lYbFoxxjsUItEv0ENN+FtM=;
        b=hoyLRO+XRzV4pAZleD2Cu08pDMLAuLRmrsLC04aQWQHTqtKfEwCh2qyv8QeYvqx8ag
         KnH1KEwk5FHK2LZ7DPWRqrlKzbLak6cvjejb+Rdu5NzUMQNVfpFgb5KbHnorW+HSAAcH
         u74OROVfVn/GWkPrBt+3OY8B4I4nPgT1998EZIa8ezGhTDL+l1l1h7Mkd87O1hHnL5I2
         1vTXhH+Syf2lChJS1TXlxMA7igpyDs4e1YRIeOyI+IjWvlk1Js06spqKn5j/zpAgqFkG
         1TvAA1mxw4yH/bECQKj1tgvkrp/Nosz5m0ZULqCddeOm6V0bsWy8SyMfWGljP4QsUcbr
         4M0w==
X-Gm-Message-State: APzg51ClcYvuN7ZCQYNKIVrZtjh+uyW5p4luu4yhg9C3PJTAADkKb+cm
        i7DZw24h1wlhyxGZjcA+ekuAf/05UvW58jc3oB4DdA==
X-Google-Smtp-Source: ANB0VdYjL77OiD8ag+qE2YwmdNBshg3gohwmuZ50OiTYuX9CgUhT3ONOMkoMEKIBitmSrn3lycrR6d7NMKByDYQg9T0=
X-Received: by 2002:a9d:4ea:: with SMTP id 97-v6mr8189336otm.99.1537061289663;
 Sat, 15 Sep 2018 18:28:09 -0700 (PDT)
MIME-Version: 1.0
References: <20180916003059.1046-1-keescook@chromium.org> <20180916003059.1046-8-keescook@chromium.org>
In-Reply-To: <20180916003059.1046-8-keescook@chromium.org>
From:   Jann Horn <jannh@google.com>
Date:   Sun, 16 Sep 2018 03:27:42 +0200
Message-ID: <CAG48ez3aU5XtQxUzWE3N3f4JyCz0jFchC=CAnHTZkGZaryWFxQ@mail.gmail.com>
Subject: Re: [PATCH 07/18] LSM: Add minor LSM initialization loop
To:     Kees Cook <keescook@chromium.org>
Cc:     James Morris <jmorris@namei.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        penguin-kernel@i-love.sakura.ne.jp,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Casey Schaufler <casey.schaufler@intel.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 16, 2018 at 3:11 AM Kees Cook <keescook@chromium.org> wrote:
> Split initialization loop into two phases: "exclusive" LSMs and "minor"
> LSMs.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/linux/lsm_hooks.h | 6 ++++++
>  security/security.c       | 8 +++++---
>  2 files changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index f8e618e2bdd2..ec3419b9b16f 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -2039,7 +2039,13 @@ extern char *lsm_names;
>  extern void security_add_hooks(struct security_hook_list *hooks, int count,
>                                 char *lsm);
>
> +enum lsm_type {
> +       LSM_TYPE_EXCLUSIVE = 0,
> +       LSM_TYPE_MINOR,
> +};

Is the intent of this explicit zero assignment that LSM_TYPE_EXCLUSIVE
should be the default? If so, perhaps a comment "/* default */", or
something like that, might be helpful.
