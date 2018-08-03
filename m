Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD83C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 18:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2D232178F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 18:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fSy5OCHG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2D232178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730730AbeHCUJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 16:09:04 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:37721 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727819AbeHCUJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 16:09:04 -0400
Received: by mail-pl0-f66.google.com with SMTP id d5-v6so2901416pll.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 11:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6m5Qbo5W22J5DKCFCd71EHj506kxxwkxa3cOmV7lW6g=;
        b=fSy5OCHGQaSBIm9Oa4MnYzBEmVLzvP5qSKh4eA7038xW7zgNnu168pu4MT22JpSyXJ
         6xmxErITKED6c4Zt+aMSxOkmIPa0RN7ARuSIMRR7slS8hkWzSzG7+28nPs0Z/4lnYPsV
         4yhlQirBWKk/po1f/Y37oJ1XqpQwIqjGKLxwh3sBcJ8tJIuz9DLpc7YyzKJlsS31dUEF
         YEjP2YMByFdZc9w05nPyE/9Onb7WMN0N99+ME87BDGA0YGV8n4B7960sVz27Hc6VvtIc
         x4UxbePXu2wHYGq5zCGlLOsJK88k2gS41svPp40zo4VnFmBBq+AgpefS/Oj51qzLdSPH
         ytJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6m5Qbo5W22J5DKCFCd71EHj506kxxwkxa3cOmV7lW6g=;
        b=YYWNkGgIbfYe5wa82kHaPoerz6iPFl76tz6PdTDBWph4ujgANUVA8BJdYLJoHY/voh
         Pg4mumkbn/kNc4qxDdn0oK6DLKHzB62QMcbXvg1DKR1De2eJ82K3JVWjXeb2GZDcJIBl
         2XkgTfXJ1V4dPYDSDizPe3T4rrjUMKsl0wr72ZgwNJt5x0jga1J3axUyVDhurnDGaOt2
         GYJIKhkeppW4t2CFNGqGFaILKzJe79vsa7JjtekSKCibPhWM4HYT8WW/cqb/IL40TbOe
         rCgbE4hQm+fzz3/wnPFMA7Hmxupt/PXndc+dTpuXSTuBAcPbX5RwikR6AOCsvODs7fqr
         RA9A==
X-Gm-Message-State: AOUpUlGJQK+eYtgA/AgizqEbAL7PlXfQ+peEBuryrlXrK8N9RBjZ49FN
        JdH8Vf5/jU8bTXXuXfEC9l+TteUOtpX909gStxt3Vw==
X-Google-Smtp-Source: AAOMgpfC8ubZGAeYBi0crI80aPEhn54Abapqva2ivgRGSooqxDRmUMjJuRxkhNVHOOmkJiBQY6xc2H23/mCiDmNPdtU=
X-Received: by 2002:a17:902:9a01:: with SMTP id v1-v6mr4639012plp.20.1533319899972;
 Fri, 03 Aug 2018 11:11:39 -0700 (PDT)
MIME-Version: 1.0
References: <20180801182258.17834-1-ndesaulniers@google.com>
 <78c667f9-5c8b-3835-83eb-4b59e27e4f7e@bell.net> <CAKwvOdmdrA+UvAWyqe8sNJt5nxHXHsSwf5Yxih9HYgVL+kovxQ@mail.gmail.com>
 <fe7b57d8-b586-a390-31d2-2274f69db3c0@bell.net> <CAKwvOd=CLBFZRQ4HQb_+VCydDEvsbC2w2gD4hTwvp_jm1zqN9Q@mail.gmail.com>
 <54b2139b-53d2-01c5-f240-93a692cdbc59@bell.net> <CAKwvOdktvrZL8T_5K2VtQtgt_mscS7kzVXYVy0O7CSuGX53Y5A@mail.gmail.com>
 <536ef1b1-cfa2-f66d-4261-fb8405964632@bell.net> <CAKwvOdmwj76aESZNKhzfPmhfzGKvrfDut7oD5KAwA+VR-JukSg@mail.gmail.com>
 <80743c1c-2a8c-7bce-2068-24c63790eba7@bell.net>
In-Reply-To: <80743c1c-2a8c-7bce-2068-24c63790eba7@bell.net>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 3 Aug 2018 11:11:28 -0700
Message-ID: <CAKwvOdmDwO1U1sk=3-6zXFrVw6by1e_9VBx1WWMCx_rMqYSw-A@mail.gmail.com>
Subject: Re: [PATCH] parisc: prefer _THIS_IP_ and _RET_IP_ statement expressions
To:     dave.anglin@bell.net
Cc:     deller@gmx.de, jejb@parisc-linux.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Pravin Shedge <pravin.shedge4linux@gmail.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-parisc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 3, 2018 at 10:57 AM John David Anglin <dave.anglin@bell.net> wrote:
>
> On 2018-08-02 4:31 PM, Nick Desaulniers wrote:
> > If I understand your point correctly, is it that you're saying that
> > _THIS_IP_  should be implemented in terms of inline assembly (as in
> > what current_text_addr() is currently)?  If that's what you mean and
> > I'm understanding correctly, my point is that we should be preferring
> > the generic C implementation as that's what's being used in most
> > places currently, so if it was broken you'd likely already know about
> > it.  Unless unwinding is truly broken by the additional label, I don't
> > think we need an inline assembly implementation of current_text_addr()
> > for parisc (or any arch for that matter).  If we do, then it can be
> > localized to the parisc unwinding code, that way it can be
> > consolidated everywhere else for every other arch.
> The label breaks the unwind data, not the unwind code.  So, localizing
> the use of
> current_text_addr() to the parisc unwind code doesn't help.

But the kernel uses the generic _THIS_IP_ *everywhere*, not parisc's
custom current_text_addr().  So if this did actually break unwinding,
you should have noticed by now.  There's only one call site that uses
the custom current_text_addr(), which is what my patch is addressing.

Localizing the custom implementation would literally produce the same
binary as is produced today, but allow us to start removing all the
other custom implementations of current_text_addr() from
arch/*/include/asm/processor.h, which is why I proposed that as an
alternative to this patch.

> Personally, I prefer the implementation of current_text_addr() because:
>
> 1) The generated code is smaller, and

One instruction vs two, for a single call site that I bet is cold and
not inlined in multiple places.

> 2) it doesn't introduce any unnecessary labels into the text.
>
> As noted, these labels can cause issues with unwinding.

Can you confirm that applying this patch actually breaks unwinding?

-- 
Thanks,
~Nick Desaulniers
