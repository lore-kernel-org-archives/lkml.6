Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E7EC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D83B21546
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S5HP7J/C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D83B21546
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbeI0Dp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 23:45:56 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39640 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbeI0Dp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 23:45:56 -0400
Received: by mail-oi1-f194.google.com with SMTP id y81-v6so404871oia.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 14:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fDmMp5ROO1w3cDSGWlW7MThzTA4BjePAwlxq+IdgWX0=;
        b=S5HP7J/CjmE/azDjx+XAL4fxL9yK4Qp0oimKSWs0bpviQdbAEz+7DhVYBadXde43nZ
         KlkKDi4Q92dyMQOqUhsfNPaTuU4mUi78mC+zGFTzLhuWL5OPS7JKo+KF8iyaHfS1X6/N
         wipVQQ5RBZg3MRqFRCo8Hnk11fM0QkXi+xgbSIroW95vT8QuIYPSFSMx5dtaLOX3kh70
         j8zCBGnwRpoO2uwTvxBPyB0dSJpeTUiPv/7jhhk4fgvbu55NOxDXw/z6l++NwuOwlSdg
         7EvNxULz2h7XMQwbWfzIsX0ivk/hnPc5i2pqC3eTLmYMRXlFb3T7PJJ8A9UBRtjRe4sj
         3O7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fDmMp5ROO1w3cDSGWlW7MThzTA4BjePAwlxq+IdgWX0=;
        b=UadYTXzXmY5MUTV0DSKTXHT+3Lw5fTIIIphBsvRMPqHlDr/vnUTFGV2nFb/c+R0DoL
         H5Drb18lKqfEI60no/F3u24oq+6n3yaG+we5VW1i8ArME+RMT+UYV+/DIvJXRxFvYvMl
         I2v3bOwELp7Oad5+VKULoo3aQERWcq7xjT4iSeFBWWjvc0APMJozAeJYdc/F1AL1XSio
         tQD/dm6zY0BSzzyfjmmFbs+XrVRfhHudHZrbCyEigwBqHumN5vW6jKFJNNBtUW5xjgY2
         jNZdoZXVtrntEmZg+tUMUEWfFiv5SV+Sv8WavOTXG3OxlGkxdUeWIBA1YFN8wrliGzQf
         Tqzg==
X-Gm-Message-State: ABuFfoj4EyyZrtJuuxSyVX3vUBfiopUehV8m4gUC+iR7HjCubXZNwrGR
        LuVynlC3bYJVgmG0FshO6cxM6yJwJT4BJku/EL+qgg==
X-Google-Smtp-Source: ACcGV61lcffN3FelUzNZvcjBPA2NyvhTZMwyUdMRhg52Vid3qM/9vWnDt+iLPINPpJRG6nWbx9eEDCTvt3WFwL2x+GQ=
X-Received: by 2002:aca:4d13:: with SMTP id a19-v6mr1665450oib.205.1537997461339;
 Wed, 26 Sep 2018 14:31:01 -0700 (PDT)
MIME-Version: 1.0
References: <20180926203446.2004-1-casey.schaufler@intel.com> <20180926203446.2004-3-casey.schaufler@intel.com>
In-Reply-To: <20180926203446.2004-3-casey.schaufler@intel.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 26 Sep 2018 23:30:35 +0200
Message-ID: <CAG48ez3_XJYCURiCurDeCousGguGUdPego30j5+UF8FebWxUtA@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] Smack: Prepare for PTRACE_MODE_SCHED
To:     Casey Schaufler <casey.schaufler@intel.com>
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        selinux@tycho.nsa.gov, Dave Hansen <dave.hansen@intel.com>,
        deneen.t.dock@intel.com, kristen@linux.intel.com,
        Arjan van de Ven <arjan@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 10:35 PM Casey Schaufler
<casey.schaufler@intel.com> wrote:
> A ptrace access check with mode PTRACE_MODE_SCHED gets called
> from process switching code. This precludes the use of audit,
> as the locking is incompatible. Don't do audit in the PTRACE_MODE_SCHED
> case.
>
> Signed-off-by: Casey Schaufler <casey.schaufler@intel.com>
> ---
>  security/smack/smack_lsm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 340fc30ad85d..ffa95bcab599 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -422,7 +422,8 @@ static int smk_ptrace_rule_check(struct task_struct *tracer,
>         struct task_smack *tsp;
>         struct smack_known *tracer_known;
>
> -       if ((mode & PTRACE_MODE_NOAUDIT) == 0) {
> +       if ((mode & PTRACE_MODE_NOAUDIT) == 0 &&
> +           (mode & PTRACE_MODE_SCHED) == 0) {

If you ORed PTRACE_MODE_NOAUDIT into the flags when calling the
security hook, you could drop this patch, right?
