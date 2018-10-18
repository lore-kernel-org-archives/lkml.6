Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 856F9C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 10:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2684F2087A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 10:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="er3KY5cR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2684F2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbeJRSkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 14:40:49 -0400
Received: from mail-yw1-f53.google.com ([209.85.161.53]:44717 "EHLO
        mail-yw1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbeJRSkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 14:40:49 -0400
Received: by mail-yw1-f53.google.com with SMTP id s73-v6so11585925ywg.11;
        Thu, 18 Oct 2018 03:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NXu/nYYgcDQv8yZ4XAj8qVRukxFFEM18pKUyS+dvjyE=;
        b=er3KY5cRYcxLF5QanysKTg9ymNMYs8lpTBBR/bTG6PwINnEYTO1ljEohAs6xNAJPPU
         f/S2xNsU6IqiJL8uxpbEXEdquIchzCqXCu+2x/NxUUrUDAXoz59Xtv0ArcPuzkYbH9c/
         dlpf7vjSKcFBECjPyrbXl+rbYRRU04BPJ0iz6xECUy6Jwmvi0+OfMLq+dCNyz0uYxLk+
         DpLhKmg9wT2kive8JvGfqN8LY8SNPXbuJO766ycQkCbLC2+vNj+d9w1rv9vfFB9A2X8b
         UfhS/o/N5CFKthArKZbEkiM1FZwA9I2jGZlQr6L61Rz6tBYwzbddgXdoQAgn/GZGiFKN
         9Mfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NXu/nYYgcDQv8yZ4XAj8qVRukxFFEM18pKUyS+dvjyE=;
        b=SRrN8+p17K4sx8FxIJEBgU0M/RJIfkFqHi/k0yS/5CUcyUdvqzO5+sv2mSQIWzt0bN
         zr8Tft23l0NSFUeUuIQRbpNJJ3DzxMAgfelXO+z33UUmnHnF3/UN5M8yBexydGtqgTmX
         +KK/1ZcU/eqVLi1x8Ws0FWrLGALHg+k+DTbMMzAtRMKbKmDhYcvhBC2hanRraECIl6+4
         rJXPXcDs87OrpEd0wM26TpJm1/CixZbc2Nkkf95fDonbMAiWVi4qXlpOPGBnkNugKNZq
         l2IG1ph/zLxvJWX91J5cjUXDl9W+o//NwAIg1+ZYF3Ym5U4WS5R+YONxVvXjU5os11hU
         l7IA==
X-Gm-Message-State: ABuFfohFTYSORixMH07rbG+ddRam8OvROw0N54Ktx+9K2Y/qNC3Rexgu
        oHLxR3l2Vgtfeu6LSpuIvdwxod5zX4Fg3vIv8O8=
X-Google-Smtp-Source: ACcGV628Gg6DbU+dbSTgcLKtiLMXvhYm0zAtyRZdfLuI0/3gp43jMPE/4UAt6iRq6haleR0gcVSMS8G+OmnaH3edz+M=
X-Received: by 2002:a81:ae4e:: with SMTP id g14-v6mr17762553ywk.248.1539859225759;
 Thu, 18 Oct 2018 03:40:25 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000058404b0578797a9d@google.com> <CAOQ4uxjY1LpVKv1id6W-1nHaKC=RbG8HUkTvgGTdGo8MKwzSTw@mail.gmail.com>
 <CAJfpegsDfJMsT8OJVYuUFpNz94ex0fm5Z-e2Gp=cUgXsb_L-Jg@mail.gmail.com>
In-Reply-To: <CAJfpegsDfJMsT8OJVYuUFpNz94ex0fm5Z-e2Gp=cUgXsb_L-Jg@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 18 Oct 2018 13:40:14 +0300
Message-ID: <CAOQ4uxhw5ewvH6_x3oSU67Z+zLB28BUWijq7kM_h1+Jt66T1LA@mail.gmail.com>
Subject: Re: possible deadlock in ovl_copy_up_start
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     syzbot+3ef5c0d1a5cb0b21e6be@syzkaller.appspotmail.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 11:41 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Thu, Oct 18, 2018 at 8:26 AM, Amir Goldstein <amir73il@gmail.com> wrote:
>
> > Can someone tell me what the expected behavior of a nested
> > mutex_lock_interruptible(&lock); ?
> >
> > Why does the reproducer only warn and not really deadlock.
> > It is because that is considered the lesser evil?
> > and obviously, then inner unlock releases the outer lock?
>
> No, it's not the same lock, just the same lock class (first one is
> OVL_I(d_inode(old))->lock, the other is
> OVL_I(d_inode(new->d_parent)))->lock).

Doh! of course.

>
> So we could possibly get away with annotating with
> mutex_lock_nested().  Is this the only place that ovl_i_lock is
> nested?
>

As far as I can see it is.
But how would we annotate it for consistent and clear locking order?
NLINK/COPYUP?
if we want this annotation to maintain locking order we need to patch
I posted (does copyup of new->parent prior to nlink_start), so then
we don't need nested annotations anymore.

Nah, I don't think we need to add nested annotations.

FYI, I am working on a small cleanup series for ovl_nlink_start/end
and ovl_inode_lock/unlock, but it is independent of the fix patch I posted
for this bug.

Thanks,
Amir.
