Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B4C5C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 05:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDA8C242E1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 05:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Cq68UVhn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDA8C242E1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753856AbeGCFBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 01:01:39 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:35312 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753671AbeGCFBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 01:01:37 -0400
Received: by mail-io0-f195.google.com with SMTP id q4-v6so579909iob.2;
        Mon, 02 Jul 2018 22:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BK2ocT8tBjnBBxhiEEQKtCxMos0t0OtQ9qvfzG/gq3M=;
        b=Cq68UVhnVWVyx+hC3YtfZo/rH9bMJDykpaQiesFrrE2XKEEsr1gIVTOBWqaTfOYsJz
         4cN44OZrBWyDEIGa3uu6wI8qC8mtgXblF1DPHojib0+aJ8DJD7nXXGsi7HfK9que53ht
         l5bkisaeB+ILPCLhVAV7OYeTQddojWvfrnRsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BK2ocT8tBjnBBxhiEEQKtCxMos0t0OtQ9qvfzG/gq3M=;
        b=fh0iHzS4oo2NvhaH0Lq84QkRdEGD3QEUGXNPbrse14Ye+lebF9m80MGYEqm3Hif7xO
         Bo2/vR4IveOreLkTjUe5X7FabXvLEjIUrR6hAbMQamsC1v8PaBKSAse0v6Wox9rC2o5L
         btbO++zxzRgERTM8/8TZImsljeSy1oSWGTzOzd4D/GBt57G3ZKGgGMnIW+3u7S3YSjpY
         t5DNcwUaooIhXwGRG170QHsn2XMsiwTxc8LqFbFpwM87g37RJkqcRMdYh/w99SsTjSEu
         l809zsEPXJ6PhCzYUZWVA+u/AtLKaIacCWEDjf7ynPrmfPvPXWGnw+u7sw1J9xNdgKlH
         Gaow==
X-Gm-Message-State: APt69E0n1ra02IBVvEfVT6T3eKrj6PSZ0tJEVITl65HmS0gJR79rCAJv
        Fot6zy0GwIW43ElDEdc6fvsAU3mgHnUZB0paV85QMOH6
X-Google-Smtp-Source: AAOMgpfxNC+IXCqJgwuuZy5gQTpvjy88N3r98jR3TnK33w3IQajF9T5zWvVX719gu7X5YOpg8AYvftLyzVmuX7v6UQc=
X-Received: by 2002:a6b:274f:: with SMTP id n76-v6mr24286742ion.259.1530594096466;
 Mon, 02 Jul 2018 22:01:36 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20180530073304epcas3p4967df82d2d086fd08fd354781df61861@epcas3p4.samsung.com>
 <20180530073211.GA22422@kroah.com> <20180703032456epcas1p29c4570ae3f6bb3f8d7c2d475e1ba4658~9vfIpgNT51989519895epcas1p2d@epcas1p2.samsung.com>
 <20180703043655.GA9793@kroah.com> <20180703044302epcas1p4ff5961129c010a2df3548cf678b6274c~9wjUy-vFW2959129591epcas1p4p@epcas1p4.samsung.com>
In-Reply-To: <20180703044302epcas1p4ff5961129c010a2df3548cf678b6274c~9wjUy-vFW2959129591epcas1p4p@epcas1p4.samsung.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 2 Jul 2018 22:01:25 -0700
Message-ID: <CA+55aFz-K8s-Sh86PqxRaXTD5pG=YsVUCxf9ue8XOSaGmg-brw@mail.gmail.com>
Subject: Re: Linux 3.18.111
To:     Seung-Woo Kim <sw0312.kim@samsung.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>, lwn@lwn.net,
        Jiri Slaby <jslaby@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 9:43 PM Seung-Woo Kim <sw0312.kim@samsung.com> wrote:
>
> I think the commit itself is required. Simple, but not reliable,
> workaround fix is like below:
>
> diff --git a/fs/dcache.c b/fs/dcache.c
> index a34d401..7c751f2 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -1879,6 +1879,8 @@ void d_instantiate_new(struct dentry *entry,
> struct inode *inode)
>         BUG_ON(!hlist_unhashed(&entry->d_u.d_alias));
>         BUG_ON(!inode);
>         lockdep_annotate_inode_mutex_key(inode);
> +       /* WORKAROUND for calling security_d_instantiate() */
> +       entry->d_inode = inode;
>         security_d_instantiate(entry, inode);
>         spin_lock(&inode->i_lock);
>         __d_instantiate(entry, inode);

Ugh. That looks horrible even if it might avoid the oops.

I think a much better solution is to back-port commit b296821a7c42
("xattr_handler: pass dentry and inode as separate arguments of
->get()") to older kernels. Then the inode is passed down all the way,
and you don't have people try to get it from the (not yet initialized)
dentry.

But there might be other parts missing too, and I didn't look at how
easy/painful that backport would be.

Al - comments? This is all because of commit 1e2e547a93a0 ("do
d_instantiate/unlock_new_inode combinations safely") being marked for
stable, and various cases of security_d_instantiate() calling down to
getxattr. Which used to not get the inode at all, so those older
kernels use d_inode(dentry), which doesn't work in this path since
dentry->d_inode hasn't been instantiated yet..

                Linus
