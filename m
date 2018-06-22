Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47486C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1A4623F88
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:46:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1A4623F88
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753272AbeFVJqT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 05:46:19 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:39865 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751307AbeFVJqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 05:46:18 -0400
Received: by mail-oi0-f68.google.com with SMTP id t22-v6so5607619oih.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 02:46:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zDKgpljZ7ktPL8hDCsNqYu5pQLL/K7yCLPwroIxoCTc=;
        b=jKQoblOPbhzQEAigJ/n0maROXMA5wONRQpbQ8Qpnm5/Q8OVY0nXfq3i63m4NoUHAN7
         CzkJwwgTNkUq1LRUNaGAT9KtgvCaSGFACoX3VUrm4zfnCANPiBGsyG7QlgQutjcSkohq
         xtyH+oPbVUFSD8P0KqrFfWmLAwgzF+ENvIRWkbkrNxfVSTNKO8Rooz3YZaVHv9hViGUj
         XdG38LmJX0deISnNVdSYspMjafD4AAKNWDTQ87YpA7IDg4MlPlGQEdyGS5qgjPldyq//
         p3AWsKc37EA4mWUzsQ30nsncSEbu3qGJO/QXNSDNknQL42iMa2zw14v36rTts5TXskD7
         LOJQ==
X-Gm-Message-State: APt69E1azbjV/3K7ulAvEGODgRhyIpZLjxJ6tCCsdB817/+DcahJ93FS
        LBFLc/lvJc72OPmoQEohqKEPfvvMW2nuPgaKaM0=
X-Google-Smtp-Source: ADUXVKLSBZQR8/hcza6jlYt3W4bklYRMLxJ6Z/hwsRLXTb17+tiN+kdk4p/r42NsK0TS5Dp4d7l4vg2y2rj9T09K6Fc=
X-Received: by 2002:aca:ad91:: with SMTP id w139-v6mr453355oie.107.1529660777612;
 Fri, 22 Jun 2018 02:46:17 -0700 (PDT)
MIME-Version: 1.0
References: <20180322202007.23088-3-malat@debian.org> <20180328193028.823-1-malat@debian.org>
 <20180329180922.Horde.Mtq3N9paq5gkMn9QcIUlGQ1@messagerie.si.c-s.fr>
In-Reply-To: <20180329180922.Horde.Mtq3N9paq5gkMn9QcIUlGQ1@messagerie.si.c-s.fr>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Fri, 22 Jun 2018 11:46:06 +0200
Message-ID: <CA+7wUsyGxY-bJbUyggpuHe9UBy+6yDiTiOM-qM0hz33TpqL6DQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/19] powerpc/powermac: Mark variable x as unused
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Christophe LEROY <christophe.leroy@c-s.fr>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 29, 2018 at 6:09 PM LEROY Christophe
<christophe.leroy@c-s.fr> wrote:
>
> Mathieu Malaterre <malat@debian.org> a écrit :
>
> > Since the value of x is never intended to be read, remove it. Fix warning
> > treated as error with W=1:
> >
> >   arch/powerpc/platforms/powermac/udbg_scc.c:76:9: error: variable
> > ‘x’ set but not used [-Werror=unused-but-set-variable]
> >
> > Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
> > Signed-off-by: Mathieu Malaterre <malat@debian.org>
>
> Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>

Michael, can you take this one ?

> > ---
> > v2: remove x completely
> >
> >  arch/powerpc/platforms/powermac/udbg_scc.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/powerpc/platforms/powermac/udbg_scc.c
> > b/arch/powerpc/platforms/powermac/udbg_scc.c
> > index d83135a9830e..8901973ed683 100644
> > --- a/arch/powerpc/platforms/powermac/udbg_scc.c
> > +++ b/arch/powerpc/platforms/powermac/udbg_scc.c
> > @@ -73,7 +73,7 @@ void udbg_scc_init(int force_scc)
> >       struct device_node *stdout = NULL, *escc = NULL, *macio = NULL;
> >       struct device_node *ch, *ch_def = NULL, *ch_a = NULL;
> >       const char *path;
> > -     int i, x;
> > +     int i;
> >
> >       escc = of_find_node_by_name(NULL, "escc");
> >       if (escc == NULL)
> > @@ -120,7 +120,7 @@ void udbg_scc_init(int force_scc)
> >       mb();
> >
> >       for (i = 20000; i != 0; --i)
> > -             x = in_8(sccc);
> > +             in_8(sccc);
> >       out_8(sccc, 0x09);              /* reset A or B side */
> >       out_8(sccc, 0xc0);
> >
> > --
> > 2.11.0
>
>
