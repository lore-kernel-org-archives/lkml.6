Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18049C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF88A2064A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aRvP6y2d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF88A2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbeJAQ3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 12:29:46 -0400
Received: from mail-yw1-f41.google.com ([209.85.161.41]:39433 "EHLO
        mail-yw1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729045AbeJAQ3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 12:29:46 -0400
Received: by mail-yw1-f41.google.com with SMTP id v1-v6so5207962ywv.6
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 02:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kcqd3Pcfb9xxD6yrIN5Zh0buM8KoteGB3Gfwl/+108g=;
        b=aRvP6y2dgw3/BG+E6XzF2ggDmSPXnM/Z+cAg8PGUuZfD7tsd3z/eHQ6XkAArIGUAAD
         6d26o1XwuU39y324ABp3pRYR6++t6Qi5gSk6PVQfStPiMvNny41RtmomQp1m+BQte/hK
         /f5ollY5RBjwWhcU3MgwouWWzC6LzqxVfxfrqZRx5oySGAaTWtFJaw39iN+d0hIr0sBc
         BmXTUTJrUZDszDLoKAOFwrR+GAqdNASPR0kNJ9wa3Yj/8NgpIQFWqQI6W8AckrExvt5n
         9BsIQ6pxa4eHVdP0sYZa3sSHJ0rnR8MCmSL75aWexjwcFHPv0aRvFJmYp1Vq0bQDoxKi
         0SKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kcqd3Pcfb9xxD6yrIN5Zh0buM8KoteGB3Gfwl/+108g=;
        b=mi3vRdAALPD2lSncFSvxSzngmup3M5edNohcH8onZt75NWmEa1OaE3JiczWMDK1KZL
         upue/CBcu092U4uhsUSVA64lA3xb+eJgUx12q4FkKdzbVVHWyL4LonE4VUMVIa2BjBg8
         aGDMTZBfV2tpYBvkwH57tcDCRJDFXoiAr26SLERXXcpx17Jjti6+KFANPuMJhSKuA0fF
         PeHceSxkA0gB9Gu/St++nvaTGXg5XNE/NlII+aCPxqYZuXW7RGLr0+QTHxsm7xOKUPdp
         7694ZP4g4XLkCjzc7qZ5VvBrKBhTEu17YZILUEc35g0EfbTr9VZTDoSFmdNvQOooiP/q
         AyQg==
X-Gm-Message-State: ABuFfoiPmQ1oUZhQfv5mXVZKLpnHvAu40QBiQhhLAc/TJfFNkIiiDRGD
        32eLtN8fKue0vruY4nI8L0wsY8hGgSkir3gKAzkNYbom
X-Google-Smtp-Source: ACcGV60MmPKQ2gRlcMLwwKsiGkymY991QLpZIyI0RmFe0pjA6dUZSiqDLIyBqW7f9r/eGSid3dVo7kuJoVQBkgGKa+w=
X-Received: by 2002:a81:2989:: with SMTP id p131-v6mr5200875ywp.176.1538387568168;
 Mon, 01 Oct 2018 02:52:48 -0700 (PDT)
MIME-Version: 1.0
References: <20180930065100.GL15893@shao2-debian> <CAOQ4uxiHkufAtt87bMs9n-0sFxJSHsBxDX6jn8v28vkvy=a_qQ@mail.gmail.com>
 <20181001093249.GD3913@quack2.suse.cz>
In-Reply-To: <20181001093249.GD3913@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 1 Oct 2018 12:52:35 +0300
Message-ID: <CAOQ4uxiY=-=F6v4enQkcw4VjhP6gp4E31fdRxM=_ShutbT2QXw@mail.gmail.com>
Subject: Re: [LKP] [fsnotify] 60f7ed8c7c: will-it-scale.per_thread_ops -5.9% regression
To:     Jan Kara <jack@suse.cz>
Cc:     rong.a.chen@intel.com, linux-kernel <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, LKP <lkp@01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 1, 2018 at 12:32 PM Jan Kara <jack@suse.cz> wrote:
>
> On Sun 30-09-18 12:00:46, Amir Goldstein wrote:
[...]
> > > commit:
> > >   1e6cb72399 ("fsnotify: add super block object type")
> > >   60f7ed8c7c ("fsnotify: send path type events to group with super block marks")
> > >
> >
> > I have to admit this looks strange.
> > All this commit does is dereference mnt->mnt.mnt_sb and then
> > sb->s_fsnotify_mask/sb->s_fsnotify_marks to find that they are zero.
> > AFAICT there should be no extra contention added by this commit and it's
> > hard to believe that parallel unlink workload would suffer from this change.
>
> Well, it could be those additional fetches of
> sb->s_fsnotify_mask/sb->s_fsnotify_marks if they happen to be cache cold.
> Or it could be just code layout differences (i.e., compiler is not able to
> optimize resulting code as good or the code layout just happens to align
> with cache lines in a wrong way or something like that). Anyway, without
> being able to reproduce this and do detailed comparison of perf profiles I
> don't think we'll be able to tell.
>

Indeed, I am still trying to figure out how to run lkp in my test env.

Thanks,
Amir.
