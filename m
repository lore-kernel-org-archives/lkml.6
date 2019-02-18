Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3328AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 03:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 028AA218D3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 03:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bh3D4ALV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728505AbfBRD7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 22:59:36 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:43826 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728459AbfBRD7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 22:59:35 -0500
Received: by mail-ua1-f66.google.com with SMTP id z11so5371516uaa.10
        for <linux-kernel@vger.kernel.org>; Sun, 17 Feb 2019 19:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C5mPZbc1CaMt6frrgcbK8kk9usGEYeIzQLFIP+/1HEI=;
        b=bh3D4ALVp/1uxirXriqpy+0d0htmuuK2ut3iHHmO5ryWLjCfx+oUyZKz7bPT45KlQU
         STjjesa67Zy3fHPPYghBlEMAynx+DSzHp/CC+M7qtarJ/Gpz3u/zK3vv/Sw74y91M0Cn
         Ly4gKmxLh4XrnWR9Y7CvW5uYUvoVDlOfm20+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C5mPZbc1CaMt6frrgcbK8kk9usGEYeIzQLFIP+/1HEI=;
        b=f3ZY/rQmrpb7CgHLyDznRUN9nmtLC/1zjl83dzfFukZC2d7Ks8E6Qet1o/iLczt/X6
         5Sb607Aoli7e/En9gnmXudg2cqN2c+q1pBnstTorj/t0r+Dy1WMMGZcvQ8qW69iDR+pv
         1wbHt4xIxdnlTy0F3RCGTpWS6QktiSqVMbq2w57/RrVDEgZHERlKib4NgcJ5c8ETsuZF
         gFCJ9LwnC447jK7v+6q8CoshHhJUcxglLE2ZhHhiTfjdh48qPOlQgAEO+mY/qtYt13WS
         GnXq8Icm6ZaPjbFcIiKVhnyVJkF27K7/tSvCvAWEP5jr+E5UOU0sxDh0+hiRGShokPs8
         lCPQ==
X-Gm-Message-State: AHQUAuZ+0mVEy9LCqyU2d5EUCVYiHY7P4gtx1UvwvUwqAscmYiOqJyXI
        tVfOTAzC/W4z/Aecv9cOhknYmkTTVlw=
X-Google-Smtp-Source: AHgI3Ib207XAzvGUUYMBMdgFkARV8Q/PjlhcX0ze8Ik/+/KWSeg86oAMWV+oRJwLvo6FIJjiIKH+/Q==
X-Received: by 2002:a9f:2f0b:: with SMTP id x11mr3833554uaj.78.1550462373812;
        Sun, 17 Feb 2019 19:59:33 -0800 (PST)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id q67sm2654340vkq.42.2019.02.17.19.59.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 19:59:32 -0800 (PST)
Received: by mail-ua1-f50.google.com with SMTP id d21so5374220uap.9
        for <linux-kernel@vger.kernel.org>; Sun, 17 Feb 2019 19:59:32 -0800 (PST)
X-Received: by 2002:ab0:470d:: with SMTP id h13mr10634505uac.122.1550462372286;
 Sun, 17 Feb 2019 19:59:32 -0800 (PST)
MIME-Version: 1.0
References: <20190217220836.GA41179@beast> <CAHC9VhSdW+eLx3RNwMZ-Wn7BUv9ayPubZLxSZzSj_ab-k84ZGQ@mail.gmail.com>
In-Reply-To: <CAHC9VhSdW+eLx3RNwMZ-Wn7BUv9ayPubZLxSZzSj_ab-k84ZGQ@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Sun, 17 Feb 2019 19:59:20 -0800
X-Gmail-Original-Message-ID: <CAGXu5j+Cy_Ku=1zyLpXLnJXNKieu3L_SZq3Rn_D0jm=N5szt9Q@mail.gmail.com>
Message-ID: <CAGXu5j+Cy_Ku=1zyLpXLnJXNKieu3L_SZq3Rn_D0jm=N5szt9Q@mail.gmail.com>
Subject: Re: [PATCH] doc: sctp: Merge and clean up rst files
To:     Paul Moore <paul@paul-moore.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Richard Haines <richard_c_haines@btinternet.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        SELinux <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 17, 2019 at 6:56 PM Paul Moore <paul@paul-moore.com> wrote:
> On Sun, Feb 17, 2019 at 5:08 PM Kees Cook <keescook@chromium.org> wrote:
> > The SCTP sections were ending up at the top-level table of contents
> > under the security section when they should have be sections with the
> > SCTP chapters. In addition to correcting the section and subsection
> > headings, this merges the SCTP documents into a single file to organize
> > the chapters more clearly, internally linkifies them, and adds the
> > missing SPDX header.
> >
> > Signed-off-by: Kees Cook <keescook@chromium.org>
>
> [NOTE: adding the SELinux list to the CC line]
>
> Looks good to me, thanks for the fixes/cleanup.
>
> Are you planning this to go via the doc tree, or would you like me to
> grab it for the SELinux tree?  Either way is fine with me.
>
> Acked-by: Paul Moore <paul@paul-moore.com>

Thanks! I figured it'd go via the docs tree since it's mainly moving
files around in there. I figure it's up to Jon. :)

-- 
Kees Cook
