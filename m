Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CCBC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7EBF2147A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="epva8soZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7EBF2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404234AbeHPT1A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 15:27:00 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:46118 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727526AbeHPT07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 15:26:59 -0400
Received: by mail-yw1-f68.google.com with SMTP id e23-v6so3315693ywe.13;
        Thu, 16 Aug 2018 09:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=alIChM2asgfj7vyQrMYs0a4ocDl1OghK/2AfWTYX/y8=;
        b=epva8soZFN3ufnqrABxj35tGdph6/TDY82a1FhlQSmAKcCD357iZRERESqUaB5TyPZ
         Jh9dYbWs1LMW4Uq9BU6t/W1kzjeC6R/InJDsLGT0rn3RE+iWSlMwKiP77gi9epxqrW83
         Cgge5ecShH8S7qK6uKyzybY71KvbHqqCi8dPfZnJRR1P6eYZkL0jSovYS4Al4iK2zzvB
         +pD/gMemE0bUSbpmSc1v7A132Hl2DE6HiybiTCuoeX+lt/XFqvVoXJdRaf9kHIS3zrAi
         SAOPWdoYYCXUsoPFqDF5umX7FjKKG5Isv+VICXuxkyzVAEgbbpn4MULcMl85WDgkfrCI
         2joQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=alIChM2asgfj7vyQrMYs0a4ocDl1OghK/2AfWTYX/y8=;
        b=tMgmZsZD5+96H65BeKy72DEvInxSMm9QUkWRBgW7ubaqXlloEqA2QHxbjYcgnQzPxE
         9dxBEbaK5t80L+7q/blBHlf0bJVVPytXXsleE9onQIeIVa3B5bNywf1VZRo7cCulsG6S
         GSJTH4sHXRin8BtPbLRW8XLYGZi4EdDYl2rqJ/fbA73K+nBM+f3808KvZmCVIUqiI3El
         ZMevctI0CC3sohTAr9Pj4++c0rw3s6WbsZlQRdguQZ2Epwa9k7MC3znoDekulYX5Gk3n
         Q9+JaFM9ssmkmkDPYb2PEjH2E5kfoJYYBrUzvKAdYoQeuzu1lgvCuf7F6CIkELzGm6kc
         31WQ==
X-Gm-Message-State: AOUpUlHN5tyXEA/RKksjqPnaD++8wdpqTUvFuN51+f663AuHHxDtpq3h
        s0csl3gbSR8mPIQPHwGNRnPIG0Qm3sn+2Y7VeMI=
X-Google-Smtp-Source: AA+uWPx0sL3Wr9TbEBMvTmFf6gCmt7LhBEXPiK1bNNy7P6nuETbrn0xkn6wevmlbskTfa7LM4b38ubP44eEq7O2417w=
X-Received: by 2002:a0d:e501:: with SMTP id o1-v6mr16627964ywe.409.1534436848546;
 Thu, 16 Aug 2018 09:27:28 -0700 (PDT)
MIME-Version: 1.0
References: <20180729220317.GB30522@ZenIV.linux.org.uk> <20180729220453.13431-1-viro@ZenIV.linux.org.uk>
 <20180729220453.13431-3-viro@ZenIV.linux.org.uk> <CAOQ4uxgOLEpaZ=UwA_CG6CzYbsJBPV4unEV9D5mXrooLXO0+0w@mail.gmail.com>
 <CAOssrKfmR0beT4dXjg1dn6DBsPbmGBpS5xHpG9QtAAEgMWo_Xg@mail.gmail.com>
In-Reply-To: <CAOssrKfmR0beT4dXjg1dn6DBsPbmGBpS5xHpG9QtAAEgMWo_Xg@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 16 Aug 2018 19:29:13 +0300
Message-ID: <CAOQ4uxjHdtjc-aXHb-kxghAxU1oRbhEHmBVX5+=w8CgcnGBSGg@mail.gmail.com>
Subject: Re: [PATCH 03/16] vfs: don't evict uninitialized inode
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 10:41 AM Miklos Szeredi <mszeredi@redhat.com> wrote:
>
> On Mon, Jul 30, 2018 at 7:09 AM, Amir Goldstein <amir73il@gmail.com> wrote:
> > On Mon, Jul 30, 2018 at 1:04 AM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >> From: Miklos Szeredi <mszeredi@redhat.com>
> >>
> >> iput() ends up calling ->evict() on new inode, which is not yet initialized
> >> by owning fs.  So use destroy_inode() instead.
> >>
> >> Add to sb->s_inodes list only if inode is not in I_CREATING state (meaning
> >> that it wasn't allocated with new_inode(), which already does the
> >> insertion).
> >>
> >> Reported-by: Al Viro <viro@zeniv.linux.org.uk>
> >> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> >> Fixes: 80ea09a002bf ("vfs: factor out inode_insert5()")
> >
> > Backport hint: this patch depends on the patch ("new primitive:
> > discard_new_inode()") currently commit 22dc9a168272 in Al's for-next.
> >
> > Still trying to figure out the best format to channel this information to
> > stable maintainers...
>
> Why are we talking about stable?  This regression was introduced in
> 4.18-rc1, spotted by Al *and* reported by testers.  It needs to be
> fixed in one way or other in 4.18.
>

Miklos,

Seeing that it wasn't fixed in 4.18..

> I've nothing against applying "new primitive: discard_new_inode() now
> + this patch, but if it is deemed too risky at this point, we could
> just revert the buggy commit 80ea09a002bf ("vfs: factor out
> inode_insert5()") and its dependencies.
>

Should we propose for stable the upstream commits:
e950564b97fd vfs: don't evict uninitialized inode
c2b6d621c4ff new primitive: discard_new_inode()

Or should we go with the independent v1 patch:
https://patchwork.kernel.org/patch/10511969/

Thanks,
Amir.
