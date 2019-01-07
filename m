Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65746C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 23:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B7902173C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 23:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f98gwhS7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfAGXQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 18:16:57 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:46035 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfAGXQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 18:16:56 -0500
Received: by mail-vk1-f196.google.com with SMTP id n126so473463vke.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 15:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DMknoEMoeSXjj4UHAQvdqUkRXX2v0sWeTabM8utGsZw=;
        b=f98gwhS7qxj0T+C11+KTziTjRGIyGDdRXoL4jvBLS8c0H0t0uNYncDIutsSn9NCjno
         yMWRbWDbShbpYwdGRwGgnNH3yP7Ykg9Sdqe70dfgjgDRqRKrcpmi1VGy8iA7FwrcKtco
         J0LtZz+GHSDQ/5CmFDTVvqSUZL969xJEXxHgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DMknoEMoeSXjj4UHAQvdqUkRXX2v0sWeTabM8utGsZw=;
        b=add+ndPbWxvuBSXJZHKtxo8k3ak6yF3ddlsPmdeWvtXSbiZ4ci8wqBt54D1RPHbe0X
         +kZpRSJD1cr6VCWws7TY6DI++bYrp4e8ATdtv97M6YrZEliv6R966PzSn/3WblHxMhMR
         F1y4gKrWK49WxiyNP1/f6BnSRNXyub3z7LhH7VdxGSQLBB2EWPsF5SfvvjlyWNTc8RuX
         BwJTa52mtYNQtbw3T3GTnOZ480fqGxugiT6dQ0LSocylOp9Ey2Kzm2fDhX67EG7iDe3j
         3eKd1Zwz1TTFrsgn1oRXv31TfxeuiMZCkRKVhG0ddVh+gVBjeb9K6Xmea3OJaCaAIU/p
         VKwA==
X-Gm-Message-State: AJcUukeyecwRGLNk5HX+o1/PmJoO2XQrGtEBSC4HLZFuq5r9kS/R+jzx
        bd2NbLVV6gJJxaoxItmyazUor6M/qXk=
X-Google-Smtp-Source: ALg8bN7eNhXRflEfcwQ5AR4OQhG+fpkoN9dRFIV6ryQOEKU0NWJgnykC6qNuvK8UsH7KAW9bqx6v0Q==
X-Received: by 2002:a1f:1e09:: with SMTP id e9mr23866029vke.18.1546903015371;
        Mon, 07 Jan 2019 15:16:55 -0800 (PST)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com. [209.85.221.181])
        by smtp.gmail.com with ESMTPSA id 67sm19597830vkt.35.2019.01.07.15.16.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 15:16:54 -0800 (PST)
Received: by mail-vk1-f181.google.com with SMTP id b18so487154vke.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 15:16:54 -0800 (PST)
X-Received: by 2002:a1f:3d10:: with SMTP id k16mr23265287vka.13.1546903013896;
 Mon, 07 Jan 2019 15:16:53 -0800 (PST)
MIME-Version: 1.0
References: <20190107222700.15954-1-christian@brauner.io>
In-Reply-To: <20190107222700.15954-1-christian@brauner.io>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 7 Jan 2019 15:16:42 -0800
X-Gmail-Original-Message-ID: <CAGXu5jJQgZDec1+WnsU6ttVaMb6j5oqtJ7Zw_YYn4RgWgvc0SA@mail.gmail.com>
Message-ID: <CAGXu5jJQgZDec1+WnsU6ttVaMb6j5oqtJ7Zw_YYn4RgWgvc0SA@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 0/2] sysctl: handle overflow for file-max
To:     Christian Brauner <christian@brauner.io>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 7, 2019 at 2:27 PM Christian Brauner <christian@brauner.io> wrote:
>
> Hey,
>
> Here is v3 of this patchset. Changelogs are in the individual commits.

Andrew, can you take these? I've already Acked them.

-Kees

>
> Currently, when writing
>
> echo 18446744073709551616 > /proc/sys/fs/file-max
>
> /proc/sys/fs/file-max will overflow and be set to 0. That quickly
> crashes the system.
>
> The first version of this patch intended to detect the overflow and cap
> at ULONG_MAX. However, we should not do this and rather return EINVAL on
> overflow. The reasons are:
> - this aligns with other sysctl handlers that simply reject overflows
>   (cf. [1], [2], and a bunch of others)
> - we already do a partial fail on overflow right now
>   Namely, when the TMPBUFLEN is exceeded. So we already reject values
>   such as 184467440737095516160 (21 chars) but accept values such as
>   18446744073709551616 (20 chars) but both are overflows. So we should
>   just always reject 64bit overflows and not special-case this based on
>   the number of chars.
>
> (This patchset is in reference to https://lkml.org/lkml/2018/10/11/585.)
>
> Thanks!
> Christian
>
> [1]: fb910c42cceb ("sysctl: check for UINT_MAX before unsigned int min/max")
> [2]: 196851bed522 ("s390/topology: correct topology mode proc handler")
>
> Christian Brauner (2):
>   sysctl: handle overflow in proc_get_long
>   sysctl: handle overflow for file-max
>
>  kernel/sysctl.c | 47 ++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 46 insertions(+), 1 deletion(-)
>
> --
> 2.19.1
>


-- 
Kees Cook
