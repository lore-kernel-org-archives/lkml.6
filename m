Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D096C7113B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC69F2084C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:30:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nj5uH1Sh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbfAUMaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 07:30:05 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:38827 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728299AbfAUMaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 07:30:04 -0500
Received: by mail-yw1-f66.google.com with SMTP id d190so7956829ywb.5;
        Mon, 21 Jan 2019 04:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7m+KvIsLSKcpmR1P89YwAZS9iEqag+YvOiB6GUSKYq8=;
        b=Nj5uH1Shx4LzFYzel1sUqEe9P7AkXujq9nvcr24mHaGriEbS5iE5G6qDZ2nRM2or2O
         DgkcnGtPKta++gx4tlJiptEduKwFT5+kht/Qkq6TUkveGMoSGH2w0Dvdw6ybeRJv9yW2
         Y3GqeAsmrHBx3zl3JFJA6m89dMcT9+JDbmqA9rMDr1XFvqYoEhosIQVgH2iKdePP1WRs
         12+gBZCL51EL4mkM+GDACOnj15Vx/GYH+CmEDMMFACsUwQQ7Ldytu4HfxnvGcYfXKoSP
         BJClM4ajlKXlfhHCsj2IVoG+wULvzMXIOdGicgcV+seGfYlJc7NFzC+zDp0UySa48l1U
         XPJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7m+KvIsLSKcpmR1P89YwAZS9iEqag+YvOiB6GUSKYq8=;
        b=fW3G4QoUm9FpllbdAGUFpzLSmgbF+Hz9pJ6loXioKBmdsRA6vqx9NLsCBdRsBhGs2L
         U/FuM2EKQUSOIASygwwNmWHLwMTcuFv/uFYlN4dvenaNlGIbfHhx7mZXj75+znLcRcRy
         EA3bQ7tqEXYPwhJKLVvqsHjZ9xtTfJ6UJkDEmaJXgk499ZwygixRDHBepRduos2bkFf4
         eq0Jw26/o3RdVbmtdof+QO881gbQhptv4IfE50mWk4ANTieESeq6C40dFgiZt0z7+Uyo
         pC5Cuy3u4GrWvGFtDyjtkLmMglmmBsBv+Qum2qf0ePivijKlHBDa/sJPQQLZjs9hXg1Z
         Lrpw==
X-Gm-Message-State: AJcUukdhnZNm3nRskAT7icS2kcPuRK0q7jlLcblh5y8eDxkRJoTVZful
        xz4Cr/bmxmOcuqZld05LP+hjEVAz4EqmJPO4wsk=
X-Google-Smtp-Source: ALg8bN78SwSqc2WMAF0CxkOu2UiYdFjFC+akKqhLKpcB6cY0iVUBLCEdgHVZ2fRq/Mdh1aBQIGRa4cLmirl+a1BeAKE=
X-Received: by 2002:a81:54:: with SMTP id 81mr28519046ywa.404.1548073802792;
 Mon, 21 Jan 2019 04:30:02 -0800 (PST)
MIME-Version: 1.0
References: <1545158873.4206.86.camel@linux.ibm.com> <20190117213421.ggasuc263dpqh46c@merlin>
 <1548072003.3782.24.camel@linux.ibm.com>
In-Reply-To: <1548072003.3782.24.camel@linux.ibm.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 21 Jan 2019 14:29:51 +0200
Message-ID: <CAOQ4uxjNhNFfFidjzi-8ywQPi54LdzT=LxwdSaX+H-ERS6Qwog@mail.gmail.com>
Subject: Re: [PATCH v2] ima: define ima_post_create_tmpfile() hook and add
 missing call
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Ignaz Forster <iforster@suse.de>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Fabian Vogt <fvogt@suse.de>, Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 2:00 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> On Thu, 2019-01-17 at 15:34 -0600, Goldwyn Rodrigues wrote:
> > On 13:47 18/12, Mimi Zohar wrote:
> > > If tmpfiles can be made persistent, then newly created tmpfiles need to
> > > be treated like any other new files in policy.
> > >
> > > This patch indicates which newly created tmpfiles are in policy, causing
> > > the file hash to be calculated on __fput().
> >
> > Discussed in overlayfs, this would be better if we use this on inode
> > and called from vfs_tmpfile() instead of do_tmpfile(). This will cover
> > the overlayfs case which uses tmpfiles while performing copy_up().
> > The patch is attached.
> >
> > Here is the updated patch which works for my cases.
> > However, it is the the failure case after setting the IMA flags
> > I am concerned about, though I don't think that should be as harmful.
>
> Right.  The new IMA hook allocates memory for storing the flags, which
> needs to be cleaned up on failure.  For this reason, the IMA call is
> deferred until after the transition from locally freeing memory on
> failure to relying on __fput().  In "do_last", the call to IMA is
> after "opened"; and in the original version of this patch the call to
> IMA is after finish_open().
>

Not sure I understand the concern.
The integrity context is associated with the inode and will be freed
on destroy_inode() no matter which error path is taken.
Am I missing something?

Thanks,
Amir.
