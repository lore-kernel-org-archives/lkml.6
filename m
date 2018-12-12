Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 813BFC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4193C20672
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qF9xcejg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4193C20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbeLLQl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 11:41:26 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:53820 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbeLLQlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 11:41:25 -0500
Received: by mail-it1-f196.google.com with SMTP id g85so9980126ita.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 08:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gR98btrArpXgzNlFBMpM5+u+hymqUmJwdF9GWqwhALE=;
        b=qF9xcejgGz+zDTbCzD8jlk1x1cy6fCMFt8RLIRM+l3JtR0mQOlFxvDVZtnjjOxpaza
         7oxqezBH7Bzoa5mINDEi/bcWs4g6ljZD0d6K5hQWEh5cuqskg8uRAuWfEsEsJi28zww5
         YEJBHEvaGlVksDG7a3PgelIP/Etk0qwZY31++UnxiieQz8tP+mK0xcMn4sn01UgFJFd6
         R2t+VvNJnHtdCBKoq70HAglSw2h6Y2ecA0JIgcLFbThAS5WDAg79fgRA/8eShuJk92be
         MLZKi70Ps9byAXky4JpIuz6nY4A4LX9OF2KJWuDhJUcIzy4xvY0U24ExC9Y5SS6Qe8Vi
         g1UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gR98btrArpXgzNlFBMpM5+u+hymqUmJwdF9GWqwhALE=;
        b=iAA9T8S1uNxz0DXAlhwn45qIkcbq5+cGyREDrB+69jlM2iCsfhxtL3DNnUWuwlMEsP
         Q6cEDwWJc0LdO0yopjIXYSFxe0a6SM5w0xjoa7PgNbRku6V9cy+/EfulD22A79LUrYfG
         Ry4xVvOEJMi4GBo6nD74shtHTkmfLPlh2MKKUhqfxJUC6A+fWi8YaLVdgr3sH219Q53K
         flvLy7sPdF7Du3qEKcto+Hj4op2aK4giMRPwW+3iBavA7AMelK5GooA8CgLH6lJPTnKg
         nfHMTw0KSomnRUp1IyTa9BWgN+o+XGIWi18q/SwMLHaWjI3M9SMd3GE0j6vzKEHO+aVZ
         WJfw==
X-Gm-Message-State: AA+aEWbnv5/oaA9B/zHjLRbZOSbt6FujnLXR5Yy1gUWS/2ZF0s4PqC+a
        QX+/7tStbm6+Bl6mH45577nXhtnrzhxar/hMZBnsnY7M
X-Google-Smtp-Source: AFSGD/UnYbnYuqN4UVLMQ5x9Ehncb0M6h1s/LRdOrPqqfZ6J4u8mFvZgFliBb/MtMweNzEFTyOjoQ00Z5ftHFtGh7Wo=
X-Received: by 2002:a05:660c:250:: with SMTP id t16mr3532082itk.78.1544632884446;
 Wed, 12 Dec 2018 08:41:24 -0800 (PST)
MIME-Version: 1.0
References: <20181210160327.20811-1-tiny.windzz@gmail.com> <20181210102157.6fa8fd8b@cakuba.netronome.com>
In-Reply-To: <20181210102157.6fa8fd8b@cakuba.netronome.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Thu, 13 Dec 2018 00:41:13 +0800
Message-ID: <CAEExFWtOmSAZfqq5kr5dorzZugs0CJv9NE76Z1W9vuqPfzZjrg@mail.gmail.com>
Subject: Re: [PATCH] bpf: convert to DEFINE_SHOW_ATTRIBUTE
To:     jakub.kicinski@netronome.com
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 2:22 AM Jakub Kicinski
<jakub.kicinski@netronome.com> wrote:
>
> On Mon, 10 Dec 2018 11:03:27 -0500, Yangtao Li wrote:
> > Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
>
> Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>
>
> Please post v2 with the subject prefix set to "netdevsim:" rather than
> "bpf:".
The newer has been sent.

Thanks,
Yangtao
>
> >  drivers/net/netdevsim/bpf.c | 16 ++--------------
> >  1 file changed, 2 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/net/netdevsim/bpf.c b/drivers/net/netdevsim/bpf.c
> > index cb3518474f0e..14b4d9774708 100644
> > --- a/drivers/net/netdevsim/bpf.c
> > +++ b/drivers/net/netdevsim/bpf.c
> > @@ -48,7 +48,7 @@ struct nsim_bpf_bound_map {
> >       struct list_head l;
> >  };
> >
> > -static int nsim_debugfs_bpf_string_read(struct seq_file *file, void *data)
> > +static int nsim_bpf_string_show(struct seq_file *file, void *data)
> >  {
> >       const char **str = file->private;
> >
> > @@ -57,19 +57,7 @@ static int nsim_debugfs_bpf_string_read(struct seq_file *file, void *data)
> >
> >       return 0;
> >  }
> > -
> > -static int nsim_debugfs_bpf_string_open(struct inode *inode, struct file *f)
> > -{
> > -     return single_open(f, nsim_debugfs_bpf_string_read, inode->i_private);
> > -}
> > -
> > -static const struct file_operations nsim_bpf_string_fops = {
> > -     .owner = THIS_MODULE,
> > -     .open = nsim_debugfs_bpf_string_open,
> > -     .release = single_release,
> > -     .read = seq_read,
> > -     .llseek = seq_lseek
> > -};
> > +DEFINE_SHOW_ATTRIBUTE(nsim_bpf_string);
> >
> >  static int
> >  nsim_bpf_verify_insn(struct bpf_verifier_env *env, int insn_idx, int prev_insn)
>
