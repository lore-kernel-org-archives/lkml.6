Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22230C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 17:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFC4520864
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 17:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXp/+eIC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFC4520864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729173AbeK2Ejh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 23:39:37 -0500
Received: from mail-lj1-f180.google.com ([209.85.208.180]:33472 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729123AbeK2Ejg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 23:39:36 -0500
Received: by mail-lj1-f180.google.com with SMTP id v1-v6so24237865ljd.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 09:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+ywVYyFoNcvWiW+cv1Gjn9CYiAv798kNHIW9+9JiY7k=;
        b=nXp/+eICan2FBY8ln63CrNg+FKIv5owxFJ612sYcSrOaTdwGH8CqnKh+g6S1ngreRE
         941WyyKiQ2x3cuZGIbOPdgHYXDrwakbcxhbqwaeR0a80T9kEXggrHfs1OAu6KNK4dZ2G
         PJteZiz+PCVRl4+AbcRprWZRYM9ISApUEdNGeEbJeCw/CiG9bncLwHQ8Rd3sT9WTKjdO
         7vzyLmzxeeZq7bUsUIo6y0oZ4NOB46r4NvyxC9vdlgmo4H/vgmTk79mILvvXx+7BvJPd
         KxXlttTbkhkAHMn5JmgcDXuOmTonuyCwzunrQnJc2I1BGbgddwpxnGnnT6etJffajBCU
         zhWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+ywVYyFoNcvWiW+cv1Gjn9CYiAv798kNHIW9+9JiY7k=;
        b=s24lFMW6FcPgBU/3YmRDKy57Xi9DizmncWyoPcsc+6u6sYLG6Xnh2MuQJ6/+aFwY57
         1WSOGhrDamXtBUFpkCU5DVqV+A0VoBhDOn4Ol9nXNaPQTyJ1xwzqlRIzIUMInyhPUG6h
         58WoW6n1KQ6ighog+KIwh/uFq1G1MpH0Bq+xn01Yrany7u4FZTOtlmxXE1/DNe101011
         /DZZF73d2Jy0FJecb4gU5zr0ql4P/VGZ96mgLXbIvuKBjuIjTERnWOeVVjMnjNwxMInH
         Yea0OpXha37tB2x2g4ljce91MxFN+rMuX2e8R8Q1j2kjqot9vld/018JVcpemCJZiRXc
         6qiA==
X-Gm-Message-State: AA+aEWYv4gqKJmc1dIQoQme6gDV0jgiMjbL4s9MNqPNotP0iJsB7Xhc7
        HQi4rkWOWMiQ797dfUUwWL5j7s2r4OXupkNs74Y=
X-Google-Smtp-Source: AFSGD/V1UiWm731e4DIiTwMFG9U9/fNXzqlrAHXd155EpdQW0s5FYAFZMEDsaOkn/bAjE2sAZIEp4ONzvmYXdXSeijY=
X-Received: by 2002:a2e:908b:: with SMTP id l11-v6mr21931630ljg.150.1543426630784;
 Wed, 28 Nov 2018 09:37:10 -0800 (PST)
MIME-Version: 1.0
References: <20181128140852.178260-1-liuxiaozhou@bytedance.com> <CANiq72kzHqQ-M2Gyrf7iy1BQMabM6txChYwa8hrDkMmc3w8ORw@mail.gmail.com>
In-Reply-To: <CANiq72kzHqQ-M2Gyrf7iy1BQMabM6txChYwa8hrDkMmc3w8ORw@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 28 Nov 2018 18:36:59 +0100
Message-ID: <CANiq72k0hR2SXHaO20wzxjsLaMXcCJimaQ8jwPrJhP2Wj_BS_Q@mail.gmail.com>
Subject: Re: [PATCH] Compiler Attributes: move kernel-only attributes into __KERNEL__
To:     liuxiaozhou@bytedance.com
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Paul Burton <paul.burton@mips.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 6:35 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> If your problem is fixed by putting __gnu_inline into __KERNEL__

s/__gnu_inline/inline/

Cheers,
Miguel
