Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D583CC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 18:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B03421A16
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 18:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="h8AmUL9R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B03421A16
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732534AbeHFU4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 16:56:05 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:54872 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730724AbeHFU4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 16:56:05 -0400
Received: by mail-it0-f66.google.com with SMTP id s7-v6so18754393itb.4;
        Mon, 06 Aug 2018 11:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EUXscBVARplfxVYwsCfulG5jaedpv6Qfeml0/IJgXp8=;
        b=h8AmUL9RZgtVeRbEe9XUUtMy8M0lkUQzdlzbBbq2A5PcCu+tDPqowjYUkxH7A2mYCl
         NTjsopLfbmpVbBfFCmQufTLa/Fy0Ws3CWP2IT3Ip0EaoXxKLExeFdt0VrPw3YQ84WpLp
         /k5A44VXhWi1EtN7lIt4ytuZPvJrKzoKKIj30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EUXscBVARplfxVYwsCfulG5jaedpv6Qfeml0/IJgXp8=;
        b=aH630+Vs6eoTKzRIn+wc2HjMN1Ez0eEmae5lEr/OHA8B+WZS+0Przyfs0i6rcqOSXN
         xp1DHu37NSHGHojexmxu++fZxJWslfS0VRzseAosnQopVBuOMQ3utNVpOpZaPe97CXDW
         Dp8I+ImKKu6BhdLpAUX/RAsKE3NFTdMgnKzffoAMKwehaiu9a4K8ItSwxCF+DwrpN251
         6wET2CwFuNH7lHws34D5fgHlQyDaassMX4aOsDwmNd6nidrgvvpZzavWg1+qYYKy0H90
         HW/TIXuxfjCBGT5f03B+Tt7gt/P4uAIVkzvaAy7GuxwrR0XIKObd7f9wPy0cgNkiLAPh
         fvGA==
X-Gm-Message-State: AOUpUlE7z/T4XGl2+Ee12CYcKewaTWrAr7kQ9nbD9698Oa99qoH3tb2D
        1SuG5A4RsTI0AjxMleHrvF405WG9cfou2m6T8do=
X-Google-Smtp-Source: AAOMgpcDeBKC57XkeTA28yxQCx4/dtysotarhrJn30XLeUISEyU8vLZixBzSAGNhKDnkMJf7+PIlV29YZjmmNGBB40I=
X-Received: by 2002:a24:b211:: with SMTP id u17-v6mr15811962ite.1.1533581141267;
 Mon, 06 Aug 2018 11:45:41 -0700 (PDT)
MIME-Version: 1.0
References: <20171005183636.20732-1-sergey.m.klyaus@gmail.com>
 <20171005205724.GJ21978@ZenIV.linux.org.uk> <CA+55aFx7d2+GG=0LqMejiK=ZADxX347v_m0S4WzrnQ=1FoyP8A@mail.gmail.com>
 <20171005230633.GK21978@ZenIV.linux.org.uk> <CA+55aFzJYXCNPXT8D91FmjU2AWOfvWMnx2BZE+0CLgBcqX3u1g@mail.gmail.com>
 <20180806170634.GA2490@ZenIV.linux.org.uk>
In-Reply-To: <20180806170634.GA2490@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 Aug 2018 11:45:29 -0700
Message-ID: <CA+55aFy0E1nm=YH_TMH9wUGuBHRit=_d+WQ_H88b_8Cp0fR+Rg@mail.gmail.com>
Subject: Re: [PATCH] vfs: fix statfs64() returning impossible EOVERFLOW for
 64-bit f_files
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Sergey Klyaus <sergey.m.klyaus@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Li Wang <liwang@redhat.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Andi Kleen <andi.kleen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 6, 2018 at 10:06 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> That leaves us with f_bsize and f_frsize (the latter defaulting to the former).
> Hugetlbfs can put greater than 4Gb values in there, for really huge pages.
> And that's the only thing worth checking in there.
>
> So the whole put_compat_statfs64() thing should be

Ack, I'm ok with this simplification.

> I'm somewhat tempted to get rid of those 'long' in struct kstatfs,

I'm ok with this one too.

> with
>
> #define STATFS_COPYOUT(type)                                            \
> static int put##type(struct kstatfs *st, struct type __user *p)         \

No. Don't do this.

I'm ok with the #define to avoid duplication, but don't bother with
the FIT_IN() after you've above successfully argued that it's
pointless for anything but f_bsize/frsize.

So if you do the macro to generate the different copyout versions,
just use your simplified code for that macro instead. With FIT_IN()
just for f_bsize/frsize.

                    Linus
