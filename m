Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03EA2ECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 18:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A07ED20868
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 18:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ORZKyNPn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A07ED20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbeJ0DdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 23:33:07 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45308 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727762AbeJ0DdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 23:33:07 -0400
Received: by mail-lf1-f66.google.com with SMTP id c24-v6so1657741lfi.12;
        Fri, 26 Oct 2018 11:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=H3/rtYUf+SrLjFlYeukVasmyKDPkiWYtZfhjXv3OPmY=;
        b=ORZKyNPnrPVezXgJkrrMYib2bo794VdzE+HII45gV+qO2mjSGn9YnuP5cqCL19jn/u
         Xyi0xxsFBR1uDM2MykgB8x/ZScq6i2uMOH8HOr3ET7lC5veriVMDBfxe/gc5pKKVnCtX
         fywm6LYRp6L6p3zwb1vQlsAg2z0g281Js8JbOoK1Yqgqbu3X2vUnhrKnKm9wvmHC0YiY
         nYlAlrlOaA9t5S8EUMGmr9cKPHPKxcah26/UTR8SY8oZRachI4PbdiYbQ0zaDlsrfWiz
         qeK2IQ1c8ps0o0tCdAskHs795nATXMx+FfIswZNRPhB5oSjMcn7E/tuoNjcnPGRLv43W
         nUNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=H3/rtYUf+SrLjFlYeukVasmyKDPkiWYtZfhjXv3OPmY=;
        b=o/KC1tLZJH9yMtSzfR1BNNtD8LvhNHjai5ocHewOCI7WdH+sriJ1c3olhlwb9eFw2o
         H8yIwSQRtvcgC7Ln9cRSOmwAswFW1gNqaJMeCTkRBet4bSqahAlgLkJ5IUm+62JMCuAB
         y2URwMlCVuXcJjAwgridHOMCEKVrqPJF7CdDEDktS/rnUhNzK2FyIsGCLjBv4oWsDp1J
         0dnMqTQNZKrxg1qKC+d0RQLXpcJdGR3DbzYfmVhUexB/GZ9A02o76Uz2vxFCfthmM3Qu
         A3O55RfQWZDCWzioZExG4vU1yWkO6zyP0EXnf6G+3T8ORpRHrz7wC9d8yfAynn2g/hrC
         HKLg==
X-Gm-Message-State: AGRZ1gLpnb78An1kbsGMgmU1IAHnBICDwNb3OwdGwF56NbPR1Q/NAgtN
        yT9iwjnLVTcZHL3PuNReEzjeNipVloeougDrSHMTF8UH
X-Google-Smtp-Source: AJdET5eqPpX8HxT50dGk9bbcjc74e0WMlZcU+88c+0VCXcRLVWOTwkDKaj9VNAImwKujSCZAVQT2mqvr7w/YH3sxR0o=
X-Received: by 2002:a19:4bc9:: with SMTP id y192mr2911291lfa.49.1540580094890;
 Fri, 26 Oct 2018 11:54:54 -0700 (PDT)
MIME-Version: 1.0
References: <20181026172549.3628-1-colin.king@canonical.com>
 <CANiq72nFZS=3KGaQpGjRbprh8HTBiTcSpxScE2uacDmg-xqDGA@mail.gmail.com>
 <20181026184009.GV25444@bombadil.infradead.org> <CANiq72m-2FU7ioqj9sqsfWk4nSp2FO9S_8kYcbnGReXNAXYM2w@mail.gmail.com>
In-Reply-To: <CANiq72m-2FU7ioqj9sqsfWk4nSp2FO9S_8kYcbnGReXNAXYM2w@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 26 Oct 2018 20:54:43 +0200
Message-ID: <CANiq72=4KUL60=_T_VEUZmjoRFkuRmT5WCfbXO9mJ5bZoVgZ+Q@mail.gmail.com>
Subject: Re: [PATCH] Documentation: fix spelling mistake, EACCESS -> EACCES
To:     Matthew Wilcox <willy@infradead.org>
Cc:     colin.king@canonical.com, jk@ozlabs.org,
        Jonathan Corbet <corbet@lwn.net>,
        Dave Airlie <airlied@linux.ie>,
        maarten.lankhorst@linux.intel.com, maxime.ripard@bootlin.com,
        sean@poorly.run, linuxppc-dev@lists.ozlabs.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 8:53 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Fri, Oct 26, 2018 at 8:40 PM Matthew Wilcox <willy@infradead.org> wrot=
e:
> >
> > On Fri, Oct 26, 2018 at 08:20:12PM +0200, Miguel Ojeda wrote:
> > > On Fri, Oct 26, 2018 at 7:27 PM Colin King <colin.king@canonical.com>=
 wrote:
> > > >
> > > > From: Colin Ian King <colin.king@canonical.com>
> > > >
> > > > Trivial fix to a spelling mistake of the error access name EACCESS,
> > > > rename to EACCES
> > >
> > > ? It is not a typo, it is the name of the error (POSIX). Same thing
> > > for the rest of the patches.
> >
> > Are you sure?  From open(2):
> >
> >        EACCES The  requested access to the file is not allowed, or sear=
ch per=E2=80=90
> >               mission is denied for one of the directories in the path =
 prefix
> >               of  pathname,  or the file did not exist yet and write ac=
cess to
> >               the parent directory is not  allowed.   (See  also  path_=
resolu=E2=80=90
> >               tion(7).)
> >
> > include/uapi/asm-generic/errno-base.h:#define   EACCES          13     =
 /* Permission denied */
>
> I thought you were doing the reverse change. Never mind! :-)
>
> (Btw, the POSIX reference is
> http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/errno.h.html#tag=
_13_09,
> in case you want to include it or are curious)

Sorry Matthew, thought I was answering to Colin. I should go to rest.

Cheers,
Miguel
