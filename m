Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD03C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 13:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BEE12081C
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 13:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="msP7tJNs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BEE12081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436897AbeKWAJv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 19:09:51 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:45190 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729285AbeKWAJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 19:09:50 -0500
Received: by mail-io1-f68.google.com with SMTP id w7so6605461iom.12;
        Thu, 22 Nov 2018 05:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qSqVZ4wC8BLB3KS1Rh2X9uFvpKZ1m3iw2AqC6OIl35Q=;
        b=msP7tJNs3o7XbBIPba0uK11VNSIwfE4JmLYh3+T4TUM+jbqs9qMUy3bwH6ijJVvoWu
         jVXXRwViOxQeLmp4+hsThgFncQAEohoweiOoJwoSkWlgYxo0cqWBd6396AwK9LSThgmk
         a1Fr8e0NjhzDGZexkxtUNUQ3zHbDs9nbF+9rLnJpX5jpPBPoMnIkzXjSJnpo2CLvpRqe
         eKTYZltlbw4llzxHJkvOLv/BaoEOITSzM+0dbNMmutK/Hcba5qb8iH4Q6xShSPfhZxft
         XkrpwVLU4/0rsnvKSUxQn1A1SQhkN7vkBO121QnbOlRfym3tpGP4sO+mO+TElTy11UPs
         RcrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qSqVZ4wC8BLB3KS1Rh2X9uFvpKZ1m3iw2AqC6OIl35Q=;
        b=sfidQad56fQFKYhnzvMK6bGqqjsj+IRD5aV5MSKo6jsHy0Oyp65dVQ1PZFmMl8IsrA
         C6MNjQIQdo4EGCgsFFHpdOCMNnOqXNkiQa0oFlu3Rz3S1DQuIeoz5IQDco3IC7rXQgu2
         fHCiEmUED41LCfslgTW5l8WA4OrUMToorRMYyJvj6uqEKUKBzP6lD3b7JjePDQrE8cKN
         +IDLgMtINRpMXAE3LEcopXgNHYfr0yY6CVlsj8Uo7t4Q+dAKbQp7WX/KduG0oPQIj+3a
         UE8gbGi0xNyFwDayMKS71mvD1bLFvmY3fNZw89lpkQ00rSrbisKEXAa3DH7LywxLLIKR
         v9EA==
X-Gm-Message-State: AA+aEWZ+7YPZdYRskFaZuBs8t5uSeOiPl++S9yN+UuH5LXkJhCJMadlJ
        uvd2wv843SGRhE8MlFSmVASdp0FgMfP9Hk8sflQ=
X-Google-Smtp-Source: AFSGD/U/lp18CffjYWNwZFoLGdUooBXiKtGtGQFomBW7AJidAbnrNt+6JohozGPQ0U7lugvu++w/6PfwVIE3ewvysmo=
X-Received: by 2002:a5d:8497:: with SMTP id t23mr1030918iom.11.1542893428528;
 Thu, 22 Nov 2018 05:30:28 -0800 (PST)
MIME-Version: 1.0
References: <1542626272-29129-1-git-send-email-laoar.shao@gmail.com>
 <20181121192844.1cd1c2fa4801a324d059176c@linux-foundation.org> <CACVxJT9ns2XGeE3FUwNT2J2Fn2s0YuHPQT-z6yg2RE8qzK-ssQ@mail.gmail.com>
In-Reply-To: <CACVxJT9ns2XGeE3FUwNT2J2Fn2s0YuHPQT-z6yg2RE8qzK-ssQ@mail.gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 22 Nov 2018 21:29:52 +0800
Message-ID: <CALOAHbBaR2GB1Xtzzi9bNprfCWSP_PV5FCfAG_xK=jqg8uuong@mail.gmail.com>
Subject: Re: [PATCH] procfs: fix the output format in /proc/PID/wchan
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, viro@zeniv.linux.org.uk,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 7:40 PM Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> On Wed, Nov 21, 2018 at 07:28:44PM -0800, Andrew Morton wrote:
> > On Mon, 19 Nov 2018 19:17:52 +0800 Yafang Shao <laoar.shao@gmail.com> wrote:
> >
> > > Just add the missing newline.
> > >
> > > ...
> > >
> > > --- a/fs/proc/base.c
> > > +++ b/fs/proc/base.c
> > > @@ -370,11 +370,12 @@ static int proc_pid_wchan(struct seq_file *m, struct pid_namespace *ns,
> > >     wchan = get_wchan(task);
> > >     if (wchan && !lookup_symbol_name(wchan, symname)) {
> > >             seq_puts(m, symname);
> > > +           seq_putc(m, '\n');
> > >             return 0;
> > >     }
> > >
> > >  print0:
> > > -   seq_putc(m, '0');
> > > +   seq_puts(m, "0\n");
> > >     return 0;
> > >  }
> > >  #endif /* CONFIG_KALLSYMS */
> >
> > What is presently wrong with the wchan output?  The changelog
> > should explain such things, please.
>
> It is just newline to make "cat /proc/*/wchan" output look cool.
> But newline can break something.

Could you pls. show some examples for what the newline may break ?

Thanks
Yafang
