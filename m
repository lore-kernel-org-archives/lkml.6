Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C545FC5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 17:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F5ED208D7
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 17:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AO95dpIs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F5ED208D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966110AbeFORNu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 13:13:50 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:44629 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966059AbeFORNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 13:13:47 -0400
Received: by mail-ot0-f193.google.com with SMTP id w13-v6so11764623ote.11
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 10:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2aZ6po8XUHvR2JWCUv4pU6GhXc9bWXaUBTGGyAc1o6o=;
        b=AO95dpIsZ/7oxw1JtMYcjnUU18JCuKiafWwOvLGqFM2QJzUrOjY3cGRyfZ6GNySMid
         n1gNJYCWwJaloDBXmfjEkxDMNq9GGgnpcDXjUBpeWP+kVR3i0ln8Tc9EIGd9gBr9Ru2d
         5YhMBrW5ouUxEvIq2BTfLEtAUUq36xeRQlIlO68nb5xRBrdixt6Wuggb+eqAnyN/BpOv
         eqHaKNUQRYwWbhVcNWaESYmBqcggsaHz8MomtBfR2ffrP4ZdlXsjt1JpJj3ogd9G8Xym
         HeYAuF2WzETsOoOXQXGt+luPAsaDZkYNAGjVebXnw9tPG1vUqBLGlrHM6rHBRAsErY/9
         b+hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2aZ6po8XUHvR2JWCUv4pU6GhXc9bWXaUBTGGyAc1o6o=;
        b=T+O7ozoSsORSu0O0pVM1A7FfBVxYLE2iS5lKJGTUN+ihiC9pFVKjhkpKjBTM3qhs3P
         QPjOh1iAu4V4YBZDi08+Q0ymDqw9tQQe9Hkp0MOnjvPpB3y5vG2qg4R63G26xng70VKd
         yDuDPvswQmPoRyKKbkReMY9bC6WDTVW1vJr6zkoPoMeAZGU2/aAwHYpgv/Vcltt+ni05
         xHQw7BDTsRmPDmaU7uLxWpFAlUxG9aJoeYKxBy0/kwKqCKSXZBtewhc3VhWdDoYxFSi7
         71fJho3YOt7XaKGk6Zd/Th+rdLJk5PnQ6slxoiPQj795esG7Ip8mqMNzlEqkuTI/baTn
         AfYA==
X-Gm-Message-State: APt69E1Kf4epUarR6Ugz4zjGu6aJrzQCSgtpl34hYSWO1ZQvfzga0BqH
        Gc7xhhmXuC2VlAn0gEI2gyOX5aUxa/XrmNfHRe+LzQ==
X-Google-Smtp-Source: ADUXVKK4If4VowfkhmuOf2LpVbKLygYiqEBfnNGXjYrA2kyRF1JdGu0fSugp7ktJ0xZa0u4V3tNz/0ktcicgWCWZqRQ=
X-Received: by 2002:a9d:516b:: with SMTP id u40-v6mr1616887oti.297.1529082826251;
 Fri, 15 Jun 2018 10:13:46 -0700 (PDT)
MIME-Version: 1.0
References: <20180615152335.208202-1-jannh@google.com> <20180615164009.GD30522@ZenIV.linux.org.uk>
 <CAG48ez2Fku77S+FM2w5n8J_utOhO0EW_RFbMib=t5Nmwc9pwfQ@mail.gmail.com>
 <20180615165310.GF30522@ZenIV.linux.org.uk> <20180615171033.GG30522@ZenIV.linux.org.uk>
In-Reply-To: <20180615171033.GG30522@ZenIV.linux.org.uk>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 15 Jun 2018 19:13:35 +0200
Message-ID: <CAG48ez0eeBNBjnpNXWHLF4VAXB8xaAi7SGJT3EmEhUUJaz4Pqg@mail.gmail.com>
Subject: Re: [PATCH] sg, bsg: mitigate read/write abuse, block uaccess in release
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     axboe@kernel.dk, fujita.tomonori@lab.ntt.co.jp,
        dgilbert@interlog.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        security@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 7:10 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Fri, Jun 15, 2018 at 05:53:10PM +0100, Al Viro wrote:
> > On Fri, Jun 15, 2018 at 06:44:51PM +0200, Jann Horn wrote:
> > > On Fri, Jun 15, 2018 at 6:40 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > > >
> > > > On Fri, Jun 15, 2018 at 05:23:35PM +0200, Jann Horn wrote:
> > > >
> > > > > I've mostly copypasted ib_safe_file_access() over as
> > > > > scsi_safe_file_access() because I couldn't find a good common header -
> > > > > please tell me if you know a better way.
> > > > > The duplicate pr_err_once() calls are so that each of them fires once;
> > > > > otherwise, this would probably have to be a macro.
> > > > >
> > > > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > > > > Cc: <stable@vger.kernel.org>
> > > > > Signed-off-by: Jann Horn <jannh@google.com>
> > > > > ---
> > > >
> > > > WTF do you mean, in ->release()?  That makes no sense whatsoever -
> > > > what kind of copy_{to,from}_user() would be possible in there?
> > >
> > > bsg_release -> bsg_put_device -> bsg_complete_all_commands ->
> > > blk_complete_sgv4_hdr_rq -> bsg_scsi_complete_rq -> copy_to_user.
> > > I don't think that was intentional.
> > >
> > > Basically, the sense buffer is copied to a userspace address supplied
> > > in the previous ->write() when you ->read() the reply. But when you
> > > ->release() the file without reading the reply, they have to clean it
> > > up, and for that, they reuse the same code they use for ->read() - so
> > > the sense buffer is written to userspace on ->release().
> >
> > Pardon me, that has only one fix - git rm.  This is too broken for words -
> > if your reading is correct, the interface is unsalvagable.  I hope you
> > *are* misreading it, but if not... how did that insanity get through
> > review at merge time?
>
> AFAICS, it went in as part of commit 3d6392cfbd7d "bsg: support for full
> generic block layer SG v3", so your 2.6.12-rc2 is too old...

I picked 2.6.12-rc2 for the Fixes tag because the bad copy_to_user()
in sg_new_read() is at least that old.
Do you think I should split this up into two patches or so - one for
the creds/uaccess_kernel checks, one for the ->release() bug?
