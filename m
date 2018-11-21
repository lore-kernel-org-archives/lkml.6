Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 318D8C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 17:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7A902151B
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 17:30:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="nr4OriOe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7A902151B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732277AbeKVEGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 23:06:09 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44094 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729597AbeKVEGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 23:06:08 -0500
Received: by mail-pl1-f196.google.com with SMTP id s5-v6so6447015plq.11
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 09:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=nwnDx+PEMxV/2jmeERq+DYTiPZfWkL050Jj2d58Vfxk=;
        b=nr4OriOe9o11hY5rPhOmeYo8gCxcMOVmFVnnHBd61V9duefRkFg6W1Sbe0HYVwnTDr
         Gs9tZqxnVRP4Pcpa5jtKGOuYO3x/R/6usTTZqbBiDNiHUhq8C5TxxbWq4Wx3gVFF7y4s
         sskiqcnTrt1kkGUA3ozhOQXdPi/vg7QZdqhaGSD1X1j0K3hHO2IMuBo7va8Dl7UO953g
         aK8rnqNDqPZ9ypXVAmvuCaW1uDRAcZdqPjQc6gYMEMUWSS3LZHLJzZjUZ0VmuYsWGCAR
         FBCXzUt2jjQtEJrxTVlwC0TvMf3yOLGXT6d120NKDLm/Js/n5aLc8JpHDNQGnQEVirIo
         EABg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=nwnDx+PEMxV/2jmeERq+DYTiPZfWkL050Jj2d58Vfxk=;
        b=HdxiIEW6EnHfQ0Wj2VPKeBnK767IEPfGN8b8WbbQcwt9E0Oiw4eQpI9F3iwH7frZES
         k/JcAmOcwrRtupMlKWeS+goRI9VYz3cAihBau4IL8l14+vYeHo3Ze47oORJqpFh7tXMZ
         g2egsbCrXHxwiGaXoAI5k1m/8HeEWwMZx68frQCW0ljVxFgiGhFWc5ifPmmRX5b0abCj
         Ac9CB1uva//glERBcfG+x3kTbAMDOD3L6egb0f9CSPgcN+tcxLX5lbndYixnd/M/teqv
         oJtV/SZW9abhjJ3XFi0TCa2Ta8nvZv+7dihENRiFvBFgkqVLwV/SmOFN8ezDdEqpnyE9
         v34A==
X-Gm-Message-State: AA+aEWbsyKq6xWWnodN6GK4FxWbB3r7x2aS8A+u8q+Yx668pVL0AbDAq
        afBLt0ECZBAXWLhcYfyJMIsD6w==
X-Google-Smtp-Source: AFSGD/Uw65zj+HMqQCDowVwpmF+5iL0kg2FjMa3XVTtvkuEJp5yAvbaRjTcgI9UnCx6K2mLAu5jdVg==
X-Received: by 2002:a17:902:e207:: with SMTP id ce7-v6mr7423644plb.47.1542821450244;
        Wed, 21 Nov 2018 09:30:50 -0800 (PST)
Received: from cakuba.netronome.com ([2601:646:8e00:727e::5])
        by smtp.gmail.com with ESMTPSA id c13sm21343275pfe.93.2018.11.21.09.30.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 09:30:49 -0800 (PST)
Date:   Wed, 21 Nov 2018 09:30:44 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Y Song <ys114321@gmail.com>
Cc:     wen.yang99@zte.com.cn, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Jiong Wang <jiong.wang@netronome.com>, guro@fb.com,
        Sandipan Das <sandipan@linux.vnet.ibm.com>,
        John Fastabend <john.fastabend@gmail.com>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, zhong.weidong@zte.com.cn,
        wang.yi59@zte.com.cn, julia.lawall@lip6.fr
Subject: Re: [PATCH 3/4] tools: bpftool: fix potential NULL pointer
 dereference in do_load
Message-ID: <20181121093044.3c34b66b@cakuba.netronome.com>
In-Reply-To: <CAH3MdRVEoJXh1FRJKPiUvvphRLV9=-a8UV4pFUa=kq4qaWYjww@mail.gmail.com>
References: <1542786192-19164-1-git-send-email-wen.yang99@zte.com.cn>
        <CAH3MdRVEoJXh1FRJKPiUvvphRLV9=-a8UV4pFUa=kq4qaWYjww@mail.gmail.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Nov 2018 09:18:06 -0800, Y Song wrote:
> On Tue, Nov 20, 2018 at 11:42 PM Wen Yang <wen.yang99@zte.com.cn> wrote:
> >
> > This patch fixes a possible null pointer dereference in
> > do_load, detected by the semantic patch
> > deref_null.cocci, with the following warning:
> >
> > ./tools/bpf/bpftool/prog.c:1021:23-25: ERROR: map_replace is NULL but dereferenced.
> >
> > The following code has potential null pointer references:
> >  881             map_replace = reallocarray(map_replace, old_map_fds + 1,
> >  882                                        sizeof(*map_replace));
> >  883             if (!map_replace) {
> >  884                     p_err("mem alloc failed");
> >  885                     goto err_free_reuse_maps;
> >  886             }
> >
> > ...
> > 1019 err_free_reuse_maps:
> > 1020         for (i = 0; i < old_map_fds; i++)
> > 1021                 close(map_replace[i].fd);
> > 1022         free(map_replace);  
> 
> I did not see any issues here.
> We have code looks like:
>  867         struct map_replace *map_replace = NULL;
>  868         struct bpf_program *prog = NULL, *pos;
>  869         unsigned int old_map_fds = 0;
> ...
>  948                         map_replace = reallocarray(map_replace,
> old_map_fds + 1,
>  949                                                    sizeof(*map_replace));
>  950                         if (!map_replace) {
>  951                                 p_err("mem alloc failed");
>  952                                 goto err_free_reuse_maps;
>  953                         }
>  954                         map_replace[old_map_fds].idx = idx;
>  955                         map_replace[old_map_fds].name = name;
>  956                         map_replace[old_map_fds].fd = fd;
>  957                         old_map_fds++;
> ...
> 
> old_map_fds becomes non zero if and only if map_replace is not NULL.

Note that this is a realloc in a loop, and map_replace will become NULL
again if realloc fails.  We should check the return value of realloc()
without loosing the pointer to the old value.  No?

> > Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> > Reviewed-by: Tan Hu <tan.hu@zte.com.cn>
> > CC: Julia Lawall <julia.lawall@lip6.fr>
> > ---
> >  tools/bpf/bpftool/prog.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> > index 5302ee2..de42187 100644
> > --- a/tools/bpf/bpftool/prog.c
> > +++ b/tools/bpf/bpftool/prog.c
> > @@ -1017,8 +1017,9 @@ static int do_load(int argc, char **argv)
> >  err_close_obj:
> >         bpf_object__close(obj);
> >  err_free_reuse_maps:
> > -       for (i = 0; i < old_map_fds; i++)
> > -               close(map_replace[i].fd);
> > +       if (map_replace)
> > +               for (i = 0; i < old_map_fds; i++)
> > +                       close(map_replace[i].fd);
> >         free(map_replace);
> >         return -1;
> >  }
> > --
> > 2.9.5
> >  

