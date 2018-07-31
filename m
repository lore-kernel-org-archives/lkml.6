Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2ACC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 16:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 496DE20844
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 16:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MVvnpr0w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 496DE20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732506AbeGaSHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 14:07:34 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:42298 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732411AbeGaSHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 14:07:34 -0400
Received: by mail-oi0-f65.google.com with SMTP id n84-v6so29040951oib.9
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 09:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vjhNIKhxgf1s8B1n/bfFrUZ6c0znrh9skJahDADg2EY=;
        b=MVvnpr0woKh8gv1Wc80aYYcMoyyOsn9CR29NyhKeqrsFh/0vztygvSgaFD8rs596PW
         E2w1GzbZ3GcZWmOH9dCTdZFAeKtVBJaV5treOE8mzQoRGJOv2wlRgGYtPMBUmO+tnCUC
         FrdTm2hYgGHao3wmceS/L88ES9dsdwR7Mpwq+4+H8bPdtiqAw7udYKxINf1h/4xhbae3
         GT3qdkMGFEYrCtlBaG+cXOrpON0VqD2lXabGgiDQTCwinSIrRKSCYDKxNzmqGJQZmFMo
         LDSuUm1MdTUT+DK9meogtdddkVQhEalHwDFKhVTVRmS6frFkIj3zv0RILQEPsI4XxuU+
         0QEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vjhNIKhxgf1s8B1n/bfFrUZ6c0znrh9skJahDADg2EY=;
        b=ORRAJ5CQQu2KCXrjG3XMLNiK5nFblclY0JXmRikILjrFzPI1nexjGl5l6W4bnq/+W+
         rTSlC46Sxofr8r1MVlycMd2AJdKS+DbTY0fVk6r+Z3qH+swri79+XkReAjfCTNjvYtUP
         eDHa5aAbwQToNXp+vDPS7zSOq85WEMG4QVOTtm3kFtRe2NfKXGPgBW6hLIKzB6Jah1BT
         6aePYjMPGwF3NM6gtWidQHEl1NF3oPCI+DkbTl8elqfm2CXtB62ah421OfsQWjqaCuXd
         LyLon94wRzVo64olu1ALbxXnzpczrLkEeqJF+9TIhuLWW1sqWvHakQ3dWDJ7WRe8zgVQ
         fXvQ==
X-Gm-Message-State: AOUpUlGH7DFCs1MoPfETS/XaRhGLkvgllLQ6EDeZL6vcZ+r7gbD27SZ7
        1k7bzReD/FI8qLOF35cIyDMzzLpQ63TKA5qoN2QewQ==
X-Google-Smtp-Source: AAOMgpdGLE4/0YQNK9WL3hgvqO+dXo5HdkPq50aUIuFV+Ot3r8znVXNpsxvFun157ypOsuAAm4KPfdkY1EQytM0r33U=
X-Received: by 2002:aca:c42:: with SMTP id i2-v6mr20974542oiy.219.1533054389101;
 Tue, 31 Jul 2018 09:26:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180730075241.24002-1-j@bitron.ch>
In-Reply-To: <20180730075241.24002-1-j@bitron.ch>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 31 Jul 2018 18:26:02 +0200
Message-ID: <CAG48ez1izZ+W_cPdNp3SOUwb_8YzwAYdSA6d=eqvaF=5+GKemA@mail.gmail.com>
Subject: Re: [PATCH] prctl: add PR_[GS]ET_KILLABLE
To:     j@bitron.ch
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux API <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 10:01 AM J=C3=BCrg Billeter <j@bitron.ch> wrote:
>
> PR_SET_KILLABLE clears the SIGNAL_UNKILLABLE flag. This allows
> CLONE_NEWPID tasks to restore normal signal behavior, opting out of the
> special signal protection for init processes.
>
> This is required for job control in a shell that uses CLONE_NEWPID for
> child processes.
>
> This prctl does not allow setting the SIGNAL_UNKILLABLE flag, only
> clearing.
>
> Signed-off-by: J=C3=BCrg Billeter <j@bitron.ch>
> ---
[...]
> diff --git a/kernel/sys.c b/kernel/sys.c
> index 38509dc1f77b..264de630d548 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
[...]
> +       case PR_SET_KILLABLE:
> +               if (arg2 !=3D 1 || arg3 || arg4 || arg5)
> +                       return -EINVAL;
> +               me->signal->flags &=3D ~SIGNAL_UNKILLABLE;
> +               break;

I don't have an opinion on this patchset otherwise, but should this
prctl maybe block PR_SET_KILLABLE if you're actually the real init
process? This seems like it could potentially lead to weird things.

This code in kernel/fork.c seems to rely on the fact that global init
is SIGNAL_UNKILLABLE, and probably also leads to weirdness if
container init is non-SIGNAL_UNKILLABLE:

        /*
         * Siblings of global init remain as zombies on exit since they are
         * not reaped by their parent (swapper). To solve this and to avoid
         * multi-rooted process trees, prevent global and container-inits
         * from creating siblings.
         */
        if ((clone_flags & CLONE_PARENT) &&
                                current->signal->flags & SIGNAL_UNKILLABLE)
                return ERR_PTR(-EINVAL);
