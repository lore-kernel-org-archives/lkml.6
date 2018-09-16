Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D56ECE562
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 01:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE0DD21470
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 01:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZaR/SYvZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE0DD21470
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbeIPGxg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 02:53:36 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44274 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbeIPGxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 02:53:36 -0400
Received: by mail-ot1-f66.google.com with SMTP id 36-v6so8032813oth.11
        for <linux-kernel@vger.kernel.org>; Sat, 15 Sep 2018 18:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=onO3wba/2X3vJdtAd/PjEugEkZLBESLYCJ4iwqTwRaU=;
        b=ZaR/SYvZFeYjirludgPE/FsvV9tWuqcQ5aZiAhLQbpPDfCL44+zElfw+mJTxMCIsm9
         s8PpAtZO1JOmWJB5nGytQN43xg5TpdLzjeG6HNlpa9MJeGkX/t5ypRAk9AovwY0CKfej
         Tu8gE746EWK91Fpbe+yTWkWMHORCxpD1iWLAxTMkz+wvRvnYZsfYGkdd//a+yO6UZZYc
         L0Takbs9AeZE/mnmVF0MzsmMeKuOZ2WS8MztgaUjpnbKI5U+7vmV+U5leSzxTowqglUe
         Q2Ad6CytQQzA3m6TgUDhbsx/liDnH1Yman1MrLKd6q+pI6aSKiBsm42qkFAngKj9vkIN
         nIBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=onO3wba/2X3vJdtAd/PjEugEkZLBESLYCJ4iwqTwRaU=;
        b=s/y1eEr9+vBRBcagoMu/+XutMcBBmQMd3aGQKItsFBcJrngtIxqYPgrtloDyIEBCpz
         UkXvdmWhNMOtqfEy+2HsQsXBR/h41aNpdYbTF03L8R1hu5v6ucCJxxwk8K6Zx4EAK4Du
         d3G5mMswu+fAW2hTxS/oxUbVdHx6RnMnswmmgltxfLZGkoPw97N4ueVJtqgZXoW2udm0
         hxOr7MoUCp4S07QXReXmmgi+jcgXy9w2ZJDDn48oET8zxQZFjL3H3YV29y68mbajYY4n
         ks+8REuWkiN2akGe4iQRiyIIR4zb+yecLX+9fF6Dkj/lA5ZRt58pt5Buq58+LTYdh+Yg
         gmzA==
X-Gm-Message-State: APzg51A9DKfFySJDAfXTsMiFBzVw025lzCmujOOQwYl9V4/+1hm9QXgy
        ERiXG9D962O45k6pe0wzrw7liaTp3La012r3omjbmw==
X-Google-Smtp-Source: ANB0VdYkhDnWR+LWF7SDMKefso71nmCyUDiU8F7mnIJQ40zvyO3n9Hl0Gd7vRQeE8KqhInU8H5LJCvL3lcwqJyjbXio=
X-Received: by 2002:a9d:3224:: with SMTP id t36-v6mr8271500otc.284.1537061548279;
 Sat, 15 Sep 2018 18:32:28 -0700 (PDT)
MIME-Version: 1.0
References: <20180916003059.1046-1-keescook@chromium.org> <20180916003059.1046-12-keescook@chromium.org>
In-Reply-To: <20180916003059.1046-12-keescook@chromium.org>
From:   Jann Horn <jannh@google.com>
Date:   Sun, 16 Sep 2018 03:32:01 +0200
Message-ID: <CAG48ez1TPsz30WebxQPkZbjfPTyT2ui7L+4ZQ94FStCkWcJ0VA@mail.gmail.com>
Subject: Re: [PATCH 11/18] LSM: Lift LSM selection out of individual LSMs
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

On Sun, Sep 16, 2018 at 3:14 AM Kees Cook <keescook@chromium.org> wrote:
> In order to adjust LSM selection logic in the future, this moves the
> selection logic up out of the individual LSMs, making their init functions
> only run when actually enabled.
[...]
> +/* Is an LSM allowed to be enabled? */
> +static bool __init lsm_enabled(struct lsm_info *lsm)
> +{
> +       /* Report explicit disabling. */
> +       if (lsm->enabled && !*lsm->enabled) {
> +               pr_info("%s disabled with boot parameter\n", lsm->name);
> +               return false;
> +       }
> +
> +       /* If LSM isn't exclusive, ignore exclusive LSM selection rules. */
> +       if (lsm->type != LSM_TYPE_EXCLUSIVE)
> +               return true;
> +
> +       /* Disabled if another exclusive LSM already selected. */
> +       if (exclusive)
> +               return false;

What is this check for, given that you have the strcmp() just below
here? From a quick look, it (together with everything else that
touches the "exclusive" variable) seems superfluous to me, unless
there are two LSMs with the same name (which really shouldn't happen,
right?).

> +       /* Disabled if this LSM isn't the chosen one. */
> +       if (strcmp(lsm->name, chosen_lsm) != 0)
> +               return false;
> +
> +       return true;
> +}
