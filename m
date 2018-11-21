Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF49C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 17:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96A11214D9
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 17:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kqM8oOGx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96A11214D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732543AbeKVEVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 23:21:22 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34079 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729279AbeKVEVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 23:21:22 -0500
Received: by mail-qk1-f193.google.com with SMTP id a132so5411032qkg.1;
        Wed, 21 Nov 2018 09:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+y0+HMCgkTMUY378kVyZT/5XfnJg2CUDxwv1cJf63Do=;
        b=kqM8oOGxk9x+SO5aXUg96yaqCYXOEcus3T6WejXDLvnakJocq3mnqg8uWtcDcX14Sc
         nI/J29m0c2/XrDz2AijIvc6t+6HGTYUaXTbO/1VMiBVrcy+il/uuoK5s+cb/4UaA4uf4
         g7+syzOp3RcOv+9znxVqly1wSrc5ddzFVgXz/IYe9pofOVULJ02W6xeWtMoKlMLZ3TyW
         bX+IUIuIGzbotywbfGZZUEx5zl4yHwnO2GeRVu5LpsF+j3OfJY/EKUn5KTOOYX2gCF4K
         RZUsMvxvVd12mApqsKn3TTIUDYUzGxzSL2yYtrfV7udyiM8yeRrqWBm/5PMLIIaLohyc
         Plvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+y0+HMCgkTMUY378kVyZT/5XfnJg2CUDxwv1cJf63Do=;
        b=I8Uh8WcHSkXp4wZX92o3I67gt753NASiAPOrnKo9xc7vWBH2yLwCtTCmf4NRZsvVQC
         eCW512ZXEkYRv2BBOO0Ttr9WR90yDCvlQgu9hy6ic2EC4nDCOrCm3qBnl7e1DcDglKa8
         6hIqcm6bKSPJtTCxpg1Sb5ebWit0D7ThiFrPhqoqaEfePNIF7e4gZZYE0kEVc1QU74+/
         O++1vpC0l+FGIENhQThki1wZyGZSh/+Am1XkefyPXbyU1l369zXEwhdQ/vij1zQf/jRO
         lBAuOQ8jsHtXkmJkeRQunHVIEMQ2S7SIfDNbea71KOAGmBPkpG+oEHlx2OuTl5QN5F6O
         8DGg==
X-Gm-Message-State: AA+aEWbgr7GnVEpWKYpfTNnn/MV6c/WZjPLkUJyi5Of2MLKvSt20eUno
        OBnRg+Md2h5nrMtEA6Aq/VZzqFUDUwuFJvxDyXU=
X-Google-Smtp-Source: AFSGD/UVxAIxhenCFO0t8cnEKS+YMZYEq3EeS2F5rbwlj4ZvP83L+hrEvA3CK3Z49Ne7FnH12xLVvRdgRtabpdj1LIk=
X-Received: by 2002:a37:41d2:: with SMTP id o201mr6410640qka.24.1542822361006;
 Wed, 21 Nov 2018 09:46:01 -0800 (PST)
MIME-Version: 1.0
References: <1542786192-19164-1-git-send-email-wen.yang99@zte.com.cn>
 <CAH3MdRVEoJXh1FRJKPiUvvphRLV9=-a8UV4pFUa=kq4qaWYjww@mail.gmail.com> <20181121093044.3c34b66b@cakuba.netronome.com>
In-Reply-To: <20181121093044.3c34b66b@cakuba.netronome.com>
From:   Y Song <ys114321@gmail.com>
Date:   Wed, 21 Nov 2018 09:45:24 -0800
Message-ID: <CAH3MdRV-8dva2dW7pFbvKmEbAcB3rG3gVNLiLfU6wO+Uuh+=Yg@mail.gmail.com>
Subject: Re: [PATCH 3/4] tools: bpftool: fix potential NULL pointer
 dereference in do_load
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     wen.yang99@zte.com.cn, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Jiong Wang <jiong.wang@netronome.com>, guro@fb.com,
        Sandipan Das <sandipan@linux.vnet.ibm.com>,
        John Fastabend <john.fastabend@gmail.com>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, zhong.weidong@zte.com.cn,
        wang.yi59@zte.com.cn, julia.lawall@lip6.fr
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 9:30 AM Jakub Kicinski
<jakub.kicinski@netronome.com> wrote:
>
> On Wed, 21 Nov 2018 09:18:06 -0800, Y Song wrote:
> > On Tue, Nov 20, 2018 at 11:42 PM Wen Yang <wen.yang99@zte.com.cn> wrote:
> > >
> > > This patch fixes a possible null pointer dereference in
> > > do_load, detected by the semantic patch
> > > deref_null.cocci, with the following warning:
> > >
> > > ./tools/bpf/bpftool/prog.c:1021:23-25: ERROR: map_replace is NULL but dereferenced.
> > >
> > > The following code has potential null pointer references:
> > >  881             map_replace = reallocarray(map_replace, old_map_fds + 1,
> > >  882                                        sizeof(*map_replace));
> > >  883             if (!map_replace) {
> > >  884                     p_err("mem alloc failed");
> > >  885                     goto err_free_reuse_maps;
> > >  886             }
> > >
> > > ...
> > > 1019 err_free_reuse_maps:
> > > 1020         for (i = 0; i < old_map_fds; i++)
> > > 1021                 close(map_replace[i].fd);
> > > 1022         free(map_replace);
> >
> > I did not see any issues here.
> > We have code looks like:
> >  867         struct map_replace *map_replace = NULL;
> >  868         struct bpf_program *prog = NULL, *pos;
> >  869         unsigned int old_map_fds = 0;
> > ...
> >  948                         map_replace = reallocarray(map_replace,
> > old_map_fds + 1,
> >  949                                                    sizeof(*map_replace));
> >  950                         if (!map_replace) {
> >  951                                 p_err("mem alloc failed");
> >  952                                 goto err_free_reuse_maps;
> >  953                         }
> >  954                         map_replace[old_map_fds].idx = idx;
> >  955                         map_replace[old_map_fds].name = name;
> >  956                         map_replace[old_map_fds].fd = fd;
> >  957                         old_map_fds++;
> > ...
> >
> > old_map_fds becomes non zero if and only if map_replace is not NULL.
>
> Note that this is a realloc in a loop, and map_replace will become NULL
> again if realloc fails.  We should check the return value of realloc()
> without loosing the pointer to the old value.  No?

Or right. Agreed. The right fix seems to restore the old map_replace
in the error path
and jump to err_free_reuse_maps if reallocarray fails.

>
> > > Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> > > Reviewed-by: Tan Hu <tan.hu@zte.com.cn>
> > > CC: Julia Lawall <julia.lawall@lip6.fr>
> > > ---
> > >  tools/bpf/bpftool/prog.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> > > index 5302ee2..de42187 100644
> > > --- a/tools/bpf/bpftool/prog.c
> > > +++ b/tools/bpf/bpftool/prog.c
> > > @@ -1017,8 +1017,9 @@ static int do_load(int argc, char **argv)
> > >  err_close_obj:
> > >         bpf_object__close(obj);
> > >  err_free_reuse_maps:
> > > -       for (i = 0; i < old_map_fds; i++)
> > > -               close(map_replace[i].fd);
> > > +       if (map_replace)
> > > +               for (i = 0; i < old_map_fds; i++)
> > > +                       close(map_replace[i].fd);
> > >         free(map_replace);
> > >         return -1;
> > >  }
> > > --
> > > 2.9.5
> > >
>
