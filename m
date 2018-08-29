Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABDE4C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 16:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 643052064A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 16:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PhjZpU9E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 643052064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbeH2UyX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 16:54:23 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:34676 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727245AbeH2UyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 16:54:23 -0400
Received: by mail-qk0-f196.google.com with SMTP id d15-v6so3831832qkc.1;
        Wed, 29 Aug 2018 09:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vmIbtjAa00TEXUIYaWJLR/nL1Ol4/ueJIOEvAYtM4W0=;
        b=PhjZpU9EiVaM5+cfe2f3R52rWOuJgQQJn+lySHIQooYr/LGNHnN9aDHciWSzvrMM0o
         USlIeJ56r31NwwiUx2pf5yM9UnYOtgd8/6nuB25dpFe7u0i/6nr6noALMkwgDuCy/mis
         N8glUuNGD5uEIzu9l+hg8yWoWnY5PGA2pxFcsQskVwIv9/yRjLQrPEJJCuvBKeukHBeh
         2IwZ/ZymWEq6g0WwVmfpi2ZoZsjNiaLX3TDIyLJaVTEH8i0gPp9/C/SkYHAX+Az3NLxi
         UugeFYDCiOj95jQe1PM16yPMypJwRZHmA9ZT/VRnUEoEC95qsdoVqLyrjG/F1sWLuyx3
         v2pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vmIbtjAa00TEXUIYaWJLR/nL1Ol4/ueJIOEvAYtM4W0=;
        b=g0k002e5dXlyWs4LuW9ntEqiPVrlCVbzU4OA6vU0LnC5jmsgu/yRcrZm3c8UIirYS1
         1stn4c9oEGTBQMqzIVDOHRJKoUbstMr6PXi6VDk8jSvQFBDKPc5KuU0Cc92BqoecPNPg
         HNf2rNrPVYk+NMDM8NmUhK3jxqp0u1ab/8xALzI47yId7fc/VMDM+Rm8m7wt/mTftVVd
         Jz/fFkeUp+BBWVxm+QQ3kQcvvpsrF8T3HYpMGk94vA0DAuwWbsXM9rkzAPkSjAvWIdml
         SjMdycJGe5wWtH8QI+32Lrh36FhEoqWoJHHsAsEr6+XFxTcUlsGE5oeUjVGz1PQ5RkX6
         JJSg==
X-Gm-Message-State: APzg51DUnMkjB3bsymbltBa+yZ2JGScI4TdVh+ZqWqdgGNouEX5jleYG
        wXYxgbkiAPuHjb20QWQIzHT+aMjT8JFvCaANyU0dmhxTNkk=
X-Google-Smtp-Source: ANB0VdZme+k3zob8JfTF49D7Wmc27y6535oKoV+eQafx4XfAgID7SviCi7GUqMmRg+5OmX4U4lElVALnUitJ4mRwSxE=
X-Received: by 2002:ae9:e50d:: with SMTP id w13-v6mr7296391qkf.137.1535561793904;
 Wed, 29 Aug 2018 09:56:33 -0700 (PDT)
MIME-Version: 1.0
References: <1535557096-1324-1-git-send-email-george.kennedy@oracle.com>
In-Reply-To: <1535557096-1324-1-git-send-email-george.kennedy@oracle.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 29 Aug 2018 19:56:22 +0300
Message-ID: <CAHp75Vc=Fg165nL+SFDXXDzBvtba+C7CLK24gyz3EaAb8QdjNQ@mail.gmail.com>
Subject: Re: [PATCH] sym53c8xx: fix NULL pointer dereference panic in
 sym_int_sir() in sym_hipd.c
To:     george.kennedy@oracle.com
Cc:     matthew@wil.cx,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 6:42 PM George Kennedy
<george.kennedy@oracle.com> wrote:
>
> sym_int_sir() in sym_hipd.c does not check the command pointer for NULL
> before using it in debug message prints.
>
> Suggested-by: Matthew Wilcox <matthew.wilcox@oracle.com>
> Signed-off-by: George Kennedy <george.kennedy@oracle.com>
> Reviewed-by: Mark Kanda <mark.kanda@oracle.com>

> +#define sym_printk(lvl, tp, cp, fmt, v...) do { \

Since all users are KERN_WARNING level, perhaps

sym_pr_warn(tp, ...) ... \
... \
..._printk(KERN_WARNING ...

?

> +       if (cp)                                                 \
> +               scmd_printk(lvl, cp->cmd, fmt, ##v);            \
> +       else                                                    \
> +               starget_printk(lvl, tp->starget, fmt, ##v);     \
> +} while (0)
> +
>  /*
>   *  chip exception handler for programmed interrupts.
>   */
> @@ -4415,7 +4422,7 @@ static void sym_int_sir(struct sym_hcb *np)
>          *  been selected with ATN.  We do not want to handle that.
>          */
>         case SIR_SEL_ATN_NO_MSG_OUT:
> -               scmd_printk(KERN_WARNING, cp->cmd,
> +               sym_printk(KERN_WARNING, tp, cp,
>                                 "No MSG OUT phase after selection with ATN\n");
>                 goto out_stuck;
>         /*
> @@ -4423,7 +4430,7 @@ static void sym_int_sir(struct sym_hcb *np)
>          *  having reselected the initiator.
>          */
>         case SIR_RESEL_NO_MSG_IN:
> -               scmd_printk(KERN_WARNING, cp->cmd,
> +               sym_printk(KERN_WARNING, tp, cp,
>                                 "No MSG IN phase after reselection\n");
>                 goto out_stuck;
>         /*
> @@ -4431,7 +4438,7 @@ static void sym_int_sir(struct sym_hcb *np)
>          *  an IDENTIFY.
>          */
>         case SIR_RESEL_NO_IDENTIFY:
> -               scmd_printk(KERN_WARNING, cp->cmd,
> +               sym_printk(KERN_WARNING, tp, cp,
>                                 "No IDENTIFY after reselection\n");
>                 goto out_stuck;
>         /*
> @@ -4460,7 +4467,7 @@ static void sym_int_sir(struct sym_hcb *np)
>         case SIR_RESEL_ABORTED:
>                 np->lastmsg = np->msgout[0];
>                 np->msgout[0] = M_NOOP;
> -               scmd_printk(KERN_WARNING, cp->cmd,
> +               sym_printk(KERN_WARNING, tp, cp,
>                         "message %x sent on bad reselection\n", np->lastmsg);
>                 goto out;
>         /*
> --
> 1.8.3.1
>


-- 
With Best Regards,
Andy Shevchenko
