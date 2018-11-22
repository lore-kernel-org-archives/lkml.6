Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E55C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74EAD20672
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S5pfdmFW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74EAD20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391127AbeKVWTo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 17:19:44 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:51041 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436567AbeKVWTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 17:19:43 -0500
Received: by mail-it1-f194.google.com with SMTP id a185so13706167itc.0;
        Thu, 22 Nov 2018 03:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=X5p4AIJlGmJu4w5il6I10r9OdsR8xwXaR1Bn3VawYJ4=;
        b=S5pfdmFWxMwn6synMnhQ3ksA1TuftWs/unSspAsnbib6ikkYJyJTNvUMFumwnFRgtE
         Mui6VQl0J9h6orN25kBAqU9o8NMn8wd29cksx1jqiLxzz0uicQTsnceE7quabyHNXAuC
         CXvXK7QVwQ8yQ2mQMytodtmUbQDEFzshn2f+d64y09ryh3Uaf/JjluON/qHmjdZ4IJXZ
         GoR0YOeatTKTjdaiuNGLlZB+ks+4XULg4ddk21XeeA4u0aRn6FfkCCdbyOkABKyo+bmS
         ddz8EiZ8TYLxuEmJp7QkyWlOeyiA4ubNOyUeUhbMVqv1Gh+9JcIcflyHdfbr31Tc0nyc
         lzPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=X5p4AIJlGmJu4w5il6I10r9OdsR8xwXaR1Bn3VawYJ4=;
        b=qt2001V48Zp1UaIm4ULen+XX47k1tR0wCaFIrHbqNSEBCNObhGzsB5Z75+Vad1g0bz
         M5RaQ1kSFPyCN4uN/jNkzmmIwb8CsBiUV8B6fXNttJsoiA/Kdn1Pa9N474wBh2bWf6aJ
         AzpeGs2BbAokYccen0QFFEzWNAy9xBAbPXha+BEVe1tgpnrXxLYTQR72anSb1QFdSt9b
         2ALFaqkMHk43Fxkz9TJWva4sJIRoBI4HbjkN+A8Ccre61PbUOzYvm7BHaqU3YD4bQJ0N
         vY6/c19+0UJ5owBGRe5357W7BzEc5GAUvQTOyGe9vNhrQR9GMI7YGOO/Tn62imb6NhEu
         mjVw==
X-Gm-Message-State: AGRZ1gJ1nYbBOpsiWzhW1JnyvD7upJTMjQypUjyrstrXQ+pcG836m1Xg
        APXDbEbn/42TkBqPwoeIpzAoxbR/9zYhAS0czA==
X-Google-Smtp-Source: AJdET5cZUEk9CMYAoNBXK7zWWNT5PEbkWfkGicL2IwgJ6tidW67/jZapH/djpYREardn6TssnsIclfC5jf4rcNT3trA=
X-Received: by 2002:a02:1b1d:: with SMTP id l29mr9203162jad.98.1542886842536;
 Thu, 22 Nov 2018 03:40:42 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ac0:b188:0:0:0:0:0 with HTTP; Thu, 22 Nov 2018 03:40:41
 -0800 (PST)
In-Reply-To: <20181121192844.1cd1c2fa4801a324d059176c@linux-foundation.org>
References: <1542626272-29129-1-git-send-email-laoar.shao@gmail.com> <20181121192844.1cd1c2fa4801a324d059176c@linux-foundation.org>
From:   Alexey Dobriyan <adobriyan@gmail.com>
Date:   Thu, 22 Nov 2018 13:40:41 +0200
Message-ID: <CACVxJT9ns2XGeE3FUwNT2J2Fn2s0YuHPQT-z6yg2RE8qzK-ssQ@mail.gmail.com>
Subject: Re: [PATCH] procfs: fix the output format in /proc/PID/wchan
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Yafang Shao <laoar.shao@gmail.com>, viro@zeniv.linux.org.uk,
        keescook@chromium.org, orcunov@openvz.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 07:28:44PM -0800, Andrew Morton wrote:
> On Mon, 19 Nov 2018 19:17:52 +0800 Yafang Shao <laoar.shao@gmail.com> wrote:
>
> > Just add the missing newline.
> >
> > ...
> >
> > --- a/fs/proc/base.c
> > +++ b/fs/proc/base.c
> > @@ -370,11 +370,12 @@ static int proc_pid_wchan(struct seq_file *m, struct pid_namespace *ns,
> >  	wchan = get_wchan(task);
> >  	if (wchan && !lookup_symbol_name(wchan, symname)) {
> >  		seq_puts(m, symname);
> > +		seq_putc(m, '\n');
> >  		return 0;
> >  	}
> >
> >  print0:
> > -	seq_putc(m, '0');
> > +	seq_puts(m, "0\n");
> >  	return 0;
> >  }
> >  #endif /* CONFIG_KALLSYMS */
>
> What is presently wrong with the wchan output?  The changelog
> should explain such things, please.

It is just newline to make "cat /proc/*/wchan" output look cool.
But newline can break something.
