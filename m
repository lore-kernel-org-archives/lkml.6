Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32DB4C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 17:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91B7320840
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 17:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JwaPjzqx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91B7320840
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933507AbeGIRFv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 13:05:51 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35162 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933287AbeGIRFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 13:05:50 -0400
Received: by mail-pg1-f193.google.com with SMTP id e6-v6so1382195pgv.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 10:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xkFEVMB7PJgolMe1NrMasvvInK7PuMRDWKVdnWU/e3w=;
        b=JwaPjzqxw/L99yNOKvLA+PtKtqr0jruQkUdAXOY1XJsb5dhA6WKFjUwDNeiV+xCT1M
         /a0gRdvILWoPQrbpQM/L7grq4ds+xyJpmq+eDm0AGXPCc+QwnxdifA6v1HQGlE0RBlOj
         7YmWeR2sWlD+friySXVavIK+GNCxJlYZjtmYfZv/F9sM1ZAzZEqsl/EWDxV3EczCTaVL
         U/Raak5VUkKTTLygZzAGcTRA5wYmqDmJoMw+UYEt5fzgId/KUiPJQNEw4WIHvq+5y4Gm
         fMJsxNqwfyIIVzt15vqCqsGFZkHTYCpnU7+GLl0ivQW9h/S/KeflYOQN7C9dSO5hCZH6
         NQsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xkFEVMB7PJgolMe1NrMasvvInK7PuMRDWKVdnWU/e3w=;
        b=nx58yXYJr4a/ZkeZ093Us18zSESjEsx8kWeqifWGcNhC1t3lsE2/WLtmP5vtjr76MZ
         V8FNaeI2cn52eoai9FdVPoqtc1Jun3Xjtq5/wr/mGqitW+qDsoLV2E7bz88uwEVwhYJk
         l9XroT71Fp3akpz1jMBoPUNWnaHI6mdsbv9rN6Rmvo5vQomezrb54AEnGBnh2nYfiaJu
         9RaVa15+qnZw5KqFg115oU8lRZC40hXsj8Bnqdh32YYYXV7Yq/lNtn5xNb1BDbC5MK5o
         u1TsU1LtrbRabOM8rTSBIKSnHtw3qRLIBqv+Y064D5rUF98n4+TAAMXsSWIi0iZb+bGm
         9/dA==
X-Gm-Message-State: APt69E2zlTInbZqep20cEPXia/MCv+GO8CGej8FSV1EDLkyZq95D7vsc
        7qkFelvGKfhqzIR3M+TKtnvMoiZMYw3ZVhEt7EkuJQ==
X-Google-Smtp-Source: AAOMgpdXMbaFLba5o9lP+1Hf9CcXRdYFUlYXByzSEujQ2U4ONeiHevgEx7j48JjAx2frb5YvSo+NoyzAFZd02HjPkmc=
X-Received: by 2002:a62:9652:: with SMTP id c79-v6mr22314612pfe.114.1531155949505;
 Mon, 09 Jul 2018 10:05:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:950a:0:0:0:0 with HTTP; Mon, 9 Jul 2018 10:05:29
 -0700 (PDT)
In-Reply-To: <20180709151019.1336-13-manfred@colorfullife.com>
References: <20180709151019.1336-1-manfred@colorfullife.com> <20180709151019.1336-13-manfred@colorfullife.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 9 Jul 2018 19:05:29 +0200
Message-ID: <CACT4Y+ZVuhHmrdhVou5KWkV2v2s-jEq4+fz+=6WxK3JJaK087A@mail.gmail.com>
Subject: Re: [PATCH 12/12] ipc/util.c: Further ipc_idr_alloc cleanups.
To:     Manfred Spraul <manfred@colorfullife.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        LKML <linux-kernel@vger.kernel.org>, 1vier1@web.de,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 9, 2018 at 5:10 PM, Manfred Spraul <manfred@colorfullife.com> wrote:
> If idr_alloc within ipc_idr_alloc fails, then the return value (-ENOSPC)
> is used to calculate new->id.
> Technically, this is not a bug, because new->id is never accessed.
>
> But: Clean it up anyways: On error, just return, do not set new->id.
> And improve the documentation.
>
> Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> ---
>  ipc/util.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
>
> diff --git a/ipc/util.c b/ipc/util.c
> index d474f2b3b299..302c18fc846b 100644
> --- a/ipc/util.c
> +++ b/ipc/util.c
> @@ -182,11 +182,20 @@ static struct kern_ipc_perm *ipc_findkey(struct ipc_ids *ids, key_t key)
>  }
>
>  /*
> - * Specify desired id for next allocated IPC object.
> + * Insert new IPC object into idr tree, and set sequence number and id
> + * in the correct order.
> + * Especially:
> + * - the sequence number must be set before inserting the object into the idr,
> + *   because the sequence number is accessed without a lock.
> + * - the id can/must be set after inserting the object into the idr.
> + *   All accesses must be done after getting kern_ipc_perm.lock.
> + *
> + * The caller must own kern_ipc_perm.lock.of the new object.
> + * On error, the function returns a (negative) error code.
>   */
>  static inline int ipc_idr_alloc(struct ipc_ids *ids, struct kern_ipc_perm *new)
>  {
> -       int key, next_id = -1;
> +       int id, next_id = -1;

/\/\/\/\
Looks good to me. I was also confused by how key transforms into id,
and then key name is used for something else.

>  #ifdef CONFIG_CHECKPOINT_RESTORE
>         next_id = ids->next_id;
> @@ -197,14 +206,15 @@ static inline int ipc_idr_alloc(struct ipc_ids *ids, struct kern_ipc_perm *new)
>                 new->seq = ids->seq++;
>                 if (ids->seq > IPCID_SEQ_MAX)
>                         ids->seq = 0;
> -               key = idr_alloc(&ids->ipcs_idr, new, 0, 0, GFP_NOWAIT);
> +               id = idr_alloc(&ids->ipcs_idr, new, 0, 0, GFP_NOWAIT);
>         } else {
>                 new->seq = ipcid_to_seqx(next_id);
> -               key = idr_alloc(&ids->ipcs_idr, new, ipcid_to_idx(next_id),
> +               id = idr_alloc(&ids->ipcs_idr, new, ipcid_to_idx(next_id),
>                                 0, GFP_NOWAIT);
>         }
> -       new->id = SEQ_MULTIPLIER * new->seq + key;
> -       return key;
> +       if (id >= 0)
> +               new->id = SEQ_MULTIPLIER * new->seq + id;

We still initialize seq in this case. I guess it's ok because the
object is not published at all. But if we are doing this, then perhaps
store seq into a local var first and then:

      if (id >= 0) {
              new->id = SEQ_MULTIPLIER * seq + id;
              new->seq = seq:
      }

?
But I don't have a strong preference, so if it's the only reason to
resend series then perhaps it's not worth it.

Thanks


> +       return id;
>  }
>
>  /**
> --
> 2.17.1
>
