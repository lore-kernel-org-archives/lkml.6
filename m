Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF27C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3268520821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mc1KjDtN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3268520821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729817AbeLJVaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 16:30:00 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:46691 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728088AbeLJV37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 16:29:59 -0500
Received: by mail-yb1-f196.google.com with SMTP id f9so2298401ybm.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 13:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OR+kNOdJJZefBxuym1baYASOQoEnD7Kg+lrvxzn9dGw=;
        b=Mc1KjDtNlEBVGka92nkdz5d7r6I8QU63hCYI0c/EfE1F/yBP0Z34NqUOFUYC+sFw6F
         52UG2JdxUu+C0puoWHOyulqNEpPNKbj6UBIgpEQjyMUKcI/dOtYm/MqnKHh0nh+5QGT7
         jVorMlyDWdPutSspZiAv+jwgd+cbQK2PHL34ry1F7wAY3bv+S4HjCDxEaRwfjtvVzq4j
         cD3VgWpLqnN4X0DpR3WvpileMUxnnuqoGENvC94mh5DVylW7XmWmgI4hv0raHUgexQjs
         zqKqKdAIiDSpZfTL0M8FX8IttpG3I2mVDByL8uqkqqs5PZu9m4O69wSxq6ZQbejvMDtV
         kxdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OR+kNOdJJZefBxuym1baYASOQoEnD7Kg+lrvxzn9dGw=;
        b=GcCsPKEdny0Nd07eSq5KctysrgMzORL4twLFcU28NjYkxd5TAiLAQU5dagg/yJmRFe
         28cooqrVXVO7BpuuKVXVQoYz9vgxDUgIGfe8/yYRq5Zh/tePwmlCmmNjh7ozEHgxrHHx
         7TuVqkJTcyeqiB1IPZ0rtgTSYjXA0ei2d2tqF3ynCixefUI0pDUfRwXej09qco3z2sFC
         z3lBfbY0PE82zH2IPozH3qw8SJo24NnLovaJUagKprEhCCPLAThAzqRzrdypSrD+GI3S
         YclPXoea1jr8FMMTKDJ5hIFaUdPCIxNWWSCMDK8B4aKa9OuMKBfGhYNsFdSB10y0RTAV
         QzKQ==
X-Gm-Message-State: AA+aEWY/HguHpKNlHX1dw2xXeYtm6bW+8s15Fz2hahvih+WTJHWjJNeN
        Xm2y7+ZROMCX+HP3Uz+ISLOwQe6rcZd1IRZnNIwuWg==
X-Google-Smtp-Source: AFSGD/WCm+L4uAhERoWcvLI6V6XFWB1Od04CFSXDF1qpjG+cg2rxFA2oWEOheNQQveAjI3Clwz9FDvfmlOz3TKaNr7w=
X-Received: by 2002:a25:19c2:: with SMTP id 185-v6mr13979746ybz.445.1544477398702;
 Mon, 10 Dec 2018 13:29:58 -0800 (PST)
MIME-Version: 1.0
References: <20181210042352.GA6092@altlinux.org> <20181210043041.GS6131@altlinux.org>
 <CAMo8Bf+s6xObgYoOOR0NTQZR-ReBbXmNv_5Jf=jX7J+bnDsTYQ@mail.gmail.com>
 <20181210125315.GB11942@altlinux.org> <CAMo8BfLbk8wfUNVZ_Qa9XVTtg4f5k5Wj6LFauroheheoTCJPxw@mail.gmail.com>
 <20181210202402.GA18101@altlinux.org> <20181210203036.GA18150@altlinux.org>
In-Reply-To: <20181210203036.GA18150@altlinux.org>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Mon, 10 Dec 2018 13:29:46 -0800
Message-ID: <CAMo8BfL1ENxo__XouYg6pNja-fe21yF_hXrPhMi82nf8J9TZOA@mail.gmail.com>
Subject: Re: [PATCH v5 19/25] xtensa: define syscall_get_* functions
To:     ldv@altlinux.org
Cc:     oleg@redhat.com, Andrew Lutomirski <luto@kernel.org>,
        lineprinter@altlinux.org, esyr@redhat.com,
        Chris Zankel <chris@zankel.net>,
        Paul Moore <paul@paul-moore.com>, eparis@redhat.com,
        linux-xtensa@linux-xtensa.org, linux-audit@redhat.com,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 12:30 PM Dmitry V. Levin <ldv@altlinux.org> wrote:
> On Mon, Dec 10, 2018 at 11:24:02PM +0300, Dmitry V. Levin wrote:
> > On Mon, Dec 10, 2018 at 12:14:37PM -0800, Max Filippov wrote:
> > > On Mon, Dec 10, 2018 at 4:53 AM Dmitry V. Levin <ldv@altlinux.org> wrote:
> > > > On Sun, Dec 09, 2018 at 09:02:50PM -0800, Max Filippov wrote:
> > > > > How should we synchronize our changes?
> > > >
> > > > No problem, I can revert to the previous edition of this patch
> > > > that just adds syscall_get_arch.
> > > > Alternatively, you can just take that couple of patches (v5 18/25
> > > > and v2 15/15) into your tree.
> > >
> > > Sure I can do the second. Will it work for v2 16/15 that changes
> > > syscall_get_arch adding an argument to it?
> >
> > No, I'm afraid it won't work for v2 16/15 (aka v5 22/25), which means
> > I'd have to keep them in the series.
>
> You can surely take them into your tree, but I'll have to keep them
> in the series because of that change of syscall_get_arch signature.
> Sorry for confusion.

Ok, no problem, I'll take them. I'm planning to merge this branch into the
for-next in a couple of days, let's see how it goes after that.

-- 
Thanks.
-- Max
