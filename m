Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2169BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 19:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDFBF2085B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 19:43:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ol0F1+bl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDFBF2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbeJKDHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 23:07:31 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35619 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbeJKDHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 23:07:31 -0400
Received: by mail-lf1-f66.google.com with SMTP id r191-v6so4907648lff.2;
        Wed, 10 Oct 2018 12:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=oqRJiHpCqRWOx1xolni62sTvKxZhxB3/HSfZ0G2UOas=;
        b=ol0F1+blI6hpWURa1+R8LA7yLF7l/u1UuGkQhlydbStOksEOxN1hC3KY6S+nyyEWU6
         GoN1lA71ciVtVsQoab3XBONweEkIlgFwfJ2oXIuYq1/H7gUdDuVCGdJE8PJqqzyQc0Ya
         1e8HM/wZFAbWFcxM9ljNsjJgcAqwYymYdz1JLwNSXgdVqha08kRnh/D/x5hK7k++UGeo
         WCUufJ3DG0BV/wTftv8MCt/PD/vTqJt7NYfjwI4hIX1SMv1FvOi5pV0+aADuv2oMYr5v
         EfzTLG+G0B0A2Bvyfbg43Wy5MwtvbWp5QWDnFW4q4RwQ3NU/18Y/CMJMkOHfwSY+q0qU
         e+fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=oqRJiHpCqRWOx1xolni62sTvKxZhxB3/HSfZ0G2UOas=;
        b=uC8LoJlrGEXRk+rJXD686ARWH2sBFPYu15oMfWICSHXHDiCiM1L8XEbOkSX8rMeDxW
         IpwiO9m64Pqirj4IZC/SQ9lWu1qjg16yalBHUjebEmjw+CZfpk05LmrPtzwh8ZkMRL1G
         tAc0tZ1rdghYt9fhJWtyy5EZAOQwz3xQFGUgMLRSr+pOidVG5VsAJBF7pOaf7CYGsQyk
         gp7obZVpu5RBYwgSI3XNh3iHg3K52L/M1wuDOP6dngYx+sYz7lcQGyM5enePGl+DOf7m
         JgAcfgEX1XlxS7WznB8KOXVPJIRayfwiNbu/nXpxKv/wospiyP1NUFnK65TKNGrOg0su
         CG1A==
X-Gm-Message-State: ABuFfogpVG4ED8bdgoOHXSEN+5S9pEfDkgeWG17+ESD/LWo7cf1strEP
        JtbmCWDQejKJS+v7HtFBRALF46lvaC+NgAn8CuagHYP1
X-Google-Smtp-Source: ACcGV61935MvaO7h/x0n7hLMAYwoJfyVuNMq9DYhXXOLDsQW5qfgoiyT0ai7udK44Y5eBSxQGpGeDhkFMRmVWUpxLbM=
X-Received: by 2002:a19:169d:: with SMTP id 29-v6mr18655691lfw.151.1539200630302;
 Wed, 10 Oct 2018 12:43:50 -0700 (PDT)
MIME-Version: 1.0
References: <20181010142813.1918180-1-arnd@arndb.de> <20181010192658.GA27646@thunk.org>
In-Reply-To: <20181010192658.GA27646@thunk.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 10 Oct 2018 21:43:39 +0200
Message-ID: <CANiq72nGxH=PTwiEQARiN-iminwECAMYe6-GJzCUh+V0mJ-=YQ@mail.gmail.com>
Subject: Re: [PATCH] ext4: avoid unused variable warning
To:     "Ted Ts'o" <tytso@mit.edu>, Arnd Bergmann <arnd@arndb.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>, jack@suse.cz,
        Eric Biggers <ebiggers@google.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ted,

On Wed, Oct 10, 2018 at 9:27 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> On Wed, Oct 10, 2018 at 04:27:58PM +0200, Arnd Bergmann wrote:
> > The two new variables are only used in an #ifdef, so they cause a
> > warning without CONFIG_QUOTA:
> >
> > fs/ext4/super.c: In function 'parse_options':
> > fs/ext4/super.c:1977:26: error: unused variable 'grp_qf_name' [-Werror=unused-variable]
> >   char *p, *usr_qf_name, *grp_qf_name;
> >                           ^~~~~~~~~~~
> > fs/ext4/super.c:1977:12: error: unused variable 'usr_qf_name' [-Werror=unused-variable]
> >   char *p, *usr_qf_name, *grp_qf_name;
> >
> > Fixes: 20cefcdc2040 ("ext4: fix use-after-free race in ext4_remount()'s error path")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Hmm, I wonder if we should do something like:
>
> #define EXT4_UNUSED_VAR __attribute__ ((unused))

We have __maybe_unused already, so you can go ahead! :-)

(Also __always_unused, same definition as well, but here it does not may sense).

>
> and then we could do:
>
>         char *p, *usr_qf_name EXT4_UNUSED_VAR, *grp_qf_name EXT4_UNUSED_VAR;
>
> More generally, I wonder if this is something we should have defined
> for the whole kernel, as opposed to a one-off hack that ACPI and ext4
> subsystems use.  It's a little ugly, but I think it's much nicer than
> having extra #ifdefs such as:
>
>         char *p;
> #ifdef CONFIG_QUOTA
>         char *usr_qf_name, *grp_qf_name;
> #endif
>
> After all, the compiler is perfectly capable of ignoring variables
> which are unused.  And if it's only because of an #ifdef later in the
> function, it would be nice to not have an extra #ifdef in the variable
> declarations.

Indeed, it looks clean --- I like it.

Although I am not sure how people will feel about that :-) Someone may
argue that, for consistency, we shouldn't, because inside structs we
have to use #ifdefs still.

Cheers,
Miguel
