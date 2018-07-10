Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE6FC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 20:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A28F20878
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 20:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Il58tFBc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A28F20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732774AbeGJUgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 16:36:10 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:40235 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732290AbeGJUgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 16:36:09 -0400
Received: by mail-oi0-f66.google.com with SMTP id w126-v6so45186323oie.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 13:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JhNwQwbY5E2WgQywK3pdK45I/bDTI0gSh5WcKqcJ5kk=;
        b=Il58tFBcTYhsmWPMJAuFA/NSsmKyl5ZpJ7+Y84duiwYl47+bvpJ/qb2iBpPhLIinYo
         wiapk0mM3rWFczjPqeb81KuynlKu6UiVsVIcuLMh/XvynlxFiE9a3sZ7+6dm28Hvexz1
         Ix35WsoY/p2F72BK5PtTkfQnRTH/xUXz/AePK705vfwwInsLA9una0xxEMdP+mUX60qo
         Xh+Mpx3/vUibdG6RU8p2qmWsw2SfMLdYRJpvz2yywESiI/u+n+voDpas2r8AmBc+qUHn
         zcCOwMdorLmLGUnidc84IU4kqzLgUMMazzbFvChXWd6NR0O8XMXzP20fAol2dCgy3m0C
         zqRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JhNwQwbY5E2WgQywK3pdK45I/bDTI0gSh5WcKqcJ5kk=;
        b=OoQ6OMPINAlQaUjuWtVzWsRclWbv7vOstcMaP+wSB2D651b6CC8aKYtEklGwPUN0+x
         ZQG+vIAXhqiSPo+3ncumUprD+0LyJf+WFecF/JAC3hPm69oW44q0WO3TymwS/3oJKb9G
         lTIRBw6Mxw6EUodE0DlDRnfZG31XoDbeFeS9rfc7yp6okfxr81176cjZGIrT8qDOfK1W
         eydPNzkLRbcqT0BX5zXOtP+H5uVCtrPEKuGvxkSJ2ecl+xnBjEXFhHbb3U3UEWCzmDy+
         IX6+wBn+XV9vB/uZmDsYDnQ1VZvQ1z54ToEuwtfNrKRvUnkhUeocjiycUYdto3tTRMkB
         1Mtw==
X-Gm-Message-State: APt69E1XNecrMTGj1Ypv55MoiB40Y6Z4EUv5P8OygppHpC15oTp7/mIJ
        F96LY9mtcLCAt0r4DLqaZmdqG72QJsLXvRkBzfx5gw==
X-Google-Smtp-Source: AAOMgpd2te7Eal3U05hX5a5y/9p9682aHfDkT/cugkjHcSQTfn/k3HJL+mMYhHtQxOZAC6G9dASBOgp0ozlrkMUB08I=
X-Received: by 2002:aca:5004:: with SMTP id e4-v6mr31476113oib.111.1531254926260;
 Tue, 10 Jul 2018 13:35:26 -0700 (PDT)
MIME-Version: 1.0
References: <20180707015344.146672-1-jannh@google.com> <20180707082926.66zbedgq5zqjfbjx@var.youpi.perso.aquilenet.fr>
 <20180707140343.GA7052@kroah.com>
In-Reply-To: <20180707140343.GA7052@kroah.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 10 Jul 2018 13:34:59 -0700
Message-ID: <CAG48ez3m1VBMHUBTP3yt4NFjFGv7qZCGJy3fUHvZWpM5mKQAog@mail.gmail.com>
Subject: Re: [PATCH] staging: speakup: fix wraparound in uaccess length check
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        William Hubbs <w.d.hubbs@gmail.com>,
        Christopher Brannon <chris@the-brannons.com>, kirk@reisers.ca,
        kernel list <linux-kernel@vger.kernel.org>,
        speakup@linux-speakup.org, devel@driverdev.osuosl.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 7, 2018 at 7:03 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sat, Jul 07, 2018 at 10:29:26AM +0200, Samuel Thibault wrote:
> > Re,
> >
> > Could you review, test, and resubmit the patch below instead?
> >
> > Samuel
> >
> >
> > If softsynthx_read() is called with `count < 3`, `count - 3` wraps, causing
> > the loop to copy as much data as available to the provided buffer. If
> > softsynthx_read() is invoked through sys_splice(), this causes an
> > unbounded kernel write; but even when userspace just reads from it
> > normally, a small size could cause userspace crashes.
> >
> > Fixes: 425e586cf95b ("speakup: add unicode variant of /dev/softsynth")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
>
> You forgot a "reported-by:" line :(
>
> also, I already applied Jann's patch, so could you either just send the
> fixup, or a revert/add of this patch once you all agree on the proper
> solution here?

I think my patch was garbage (as both Samuel and Dan Carpenter's
smatch warning pointed out) and should be reverted. Should I be
sending the revert?
