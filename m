Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA18ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 17:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B373214DD
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 17:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QeCZTATU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B373214DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbeIQXGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 19:06:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:42490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727089AbeIQXGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 19:06:44 -0400
Received: from localhost (unknown [104.132.0.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01D4D214DA;
        Mon, 17 Sep 2018 17:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537205901;
        bh=9Bu/NJJ6SANwN8OurcMsJYpZVATMVVJfD3hSyPK2qSY=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=QeCZTATUKt/sz7PsiuDnsCFelj6zutta04D74/TUGoFBudfIrnSX2q0CJU9ze80DV
         MBLhrn7wJ5RDrLmjgOczE/aA0T2nP6909Ideplqwj8CIWjuGFJT52tVnObU/SPAVPb
         U4HhiAf200n88gPcuLWq01bU20F3pRCc/N2ERY3Y=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Anton Vorontsov <anton@enomsg.org>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Colin Cross <ccross@android.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Jim Cromie <jim.cromie@gmail.com>,
        Joe Perches <joe@perches.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tony Luck <tony.luck@intel.com>,
        Will Deacon <will.deacon@arm.com>, devicetree@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <444d7b13-2653-ba0e-e9e6-a448fded2a77@codeaurora.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        tsoni@codeaurora.org, Bryan Huntsman <bryanh@codeaurora.org>,
        Tingwei Zhang <tingwei@codeaurora.org>
References: <cover.1536430404.git.saiprakash.ranjan@codeaurora.org>
 <b9b60ff2864a17fb05481aa33f90114ab051d6ce.1536430404.git.saiprakash.ranjan@codeaurora.org>
 <444d7b13-2653-ba0e-e9e6-a448fded2a77@codeaurora.org>
Message-ID: <153720590027.119890.15984895820368075914@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 2/6] pstore: Add event tracing support
Date:   Mon, 17 Sep 2018 10:38:20 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sai Prakash Ranjan (2018-09-11 03:46:01)
> On 9/9/2018 1:57 AM, Sai Prakash Ranjan wrote:
> > +void notrace pstore_event_call(struct trace_event_buffer *fbuffer)
> > +{
> > +     struct trace_iterator *iter;
> > +     struct trace_seq *s;
> > +     struct trace_event_call *event_call;
> > +     struct pstore_record record;
> > +     struct trace_event *event;
> > +     struct seq_buf *seq;
> > +     unsigned long flags;
> > +
> > +     if (!psinfo)
> > +             return;
> > +
> > +     if (unlikely(oops_in_progress))
> > +             return;
> > +
> > +     pstore_record_init(&record, psinfo);
> > +     record.type =3D PSTORE_TYPE_EVENT;
> > +
> > +     iter =3D kmalloc(sizeof(*iter), GFP_KERNEL);
> > +     if (!iter)
> > +             return;
> > +
> > +     event_call =3D fbuffer->trace_file->event_call;
> > +     if (!event_call || !event_call->event.funcs ||
> > +         !event_call->event.funcs->trace)
> > +             goto fail_event;
> > +
> > +     event =3D &fbuffer->trace_file->event_call->event;
> > +
> > +     spin_lock_irqsave(&psinfo->buf_lock, flags);
> > +
> > +     trace_seq_init(&iter->seq);
> > +     iter->ent =3D fbuffer->entry;
> > +     event_call->event.funcs->trace(iter, 0, event);
> > +     trace_seq_putc(&iter->seq, 0);
> > +
> > +     if (seq->size > psinfo->bufsize)
> > +             seq->size =3D psinfo->bufsize;
> > +
> > +     s =3D &iter->seq;
> > +     seq =3D &s->seq;
> > +
> > +     record.buf =3D (char *)(seq->buffer);
> > +     record.size =3D seq->len;
> > +     psinfo->write(&record);
> > +
> > +     spin_unlock_irqrestore(&psinfo->buf_lock, flags);
> > +
> > +fail_event:
> > +     kfree(iter);
> > +}
> > +
> > =

> =

> When tracing sched events on sdm845 mtp, I hit below bug repeatedly.
> Seems like pstore_event_call can be called in atomic context.
> I will respin the below fix in next version of the patch.
> Reviews on other parts would be appreciated, thanks.
> =

> diff --git a/fs/pstore/ftrace.c b/fs/pstore/ftrace.c
> index d47dc93ac098..a497cf782ee8 100644
> --- a/fs/pstore/ftrace.c
> +++ b/fs/pstore/ftrace.c
> @@ -73,6 +73,7 @@ void notrace pstore_event_call(struct =

> trace_event_buffer *fbuffer)
>          struct trace_event *event;
>          struct seq_buf *seq;
>          unsigned long flags;
> +       gfp_t gfpflags;
> =

>          if (!psinfo)
>                  return;
> @@ -83,7 +84,9 @@ void notrace pstore_event_call(struct =

> trace_event_buffer *fbuffer)
>          pstore_record_init(&record, psinfo);
>          record.type =3D PSTORE_TYPE_EVENT;
> =

> -       iter =3D kmalloc(sizeof(*iter), GFP_KERNEL);
> +       gfpflags =3D (in_atomic() || irqs_disabled()) ? GFP_ATOMIC : =

> GFP_KERNEL;
> +

Do you need to allocate at all? Can you throw the iter on the stack?

Using in_atomic() and irqs_disabled() to figure out if an atomic or a
non-atomic allocation should be used is not a good solution.

