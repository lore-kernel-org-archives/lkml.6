Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 594B1C46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 20:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0350C20664
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 20:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qaOl7U+8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0350C20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbeJ1FPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 01:15:16 -0400
Received: from mail-pg1-f180.google.com ([209.85.215.180]:36316 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbeJ1FPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 01:15:15 -0400
Received: by mail-pg1-f180.google.com with SMTP id z17-v6so2064966pgv.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Oct 2018 13:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KHu97m/1zU+Xqp7bDt8OgvuUFtxTz/ixNgArjSqHGpg=;
        b=qaOl7U+8Le97L5V0n7NoqMVAsKnmmJXrg0MtDRdh5VK5uLKdQIBOngRiwmmtaGefrk
         T1NTiJmkV86F3toKsx/WtyLEnaSkWzL9aj9v+q6JbS4854qC1+GtP/NyDHTu70wMF2aS
         i1mL1SR0CSK6RqjnunKANDg22MDeQ4rbu18bszfRqMPXfdpZx7eXBqqn6X5SbJvYAFMk
         Qf8lEJGAkTIsKyQq6CWO+8+0NmXKvrwflnX/wW8i4RSrh22L2DvgCJASlpA4GnhWm3XS
         UFUNaeRcEjVaKvKOx2gn215mwcsXivrLHvT5IUgFkF3gJzI5VZSREPj65YCzoGYnOQB/
         +L8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KHu97m/1zU+Xqp7bDt8OgvuUFtxTz/ixNgArjSqHGpg=;
        b=F1wWZ/fRpeda4YR46S+peyC7LTGEtFU6ihMyA9Li4dn1l3zMPlPoKTOJCe+zlmmXld
         Szyd7XZsszNESrLfpK8Rj54ikY8VomVlmMPqQygtkmOXYorAQ8iYux1OaadgyVBr8pCP
         TBItcpaFS0bVAx44Bd+/zoYJb998SXB/VYNqtjnm3B8CqgZM8uzUaGMb6z802+bAG8bg
         o/91xMwdLLj682yKqQAys+OH7Z7KC73QSnsQ0rpE+APMc20zpg/8GgyVIyJ3fmWr13Yl
         tLyhR21/KACzqO0Wqk6ND59P1AgvizKhgCNaWXdR8otWv07JBtG0aGFQiaGi7a4W7YbH
         2Sbw==
X-Gm-Message-State: AGRZ1gLHs8FwyTCfVHT0HJlUIl/Ww16KbvREv4TmSfmKym66M5sa7j0W
        /4YbWErK+YtyTKx07ZRHvFE34GYXEtk72LMnrQ88BA==
X-Google-Smtp-Source: AJdET5ckzW9wuAPdKwnuUUeQ1KHuTsDJ3tAInfGln5hZ6OvU5kC8YYamftO3JqWhYVGY2xVxiENz2Yqto+SREiVRkYA=
X-Received: by 2002:a63:a064:: with SMTP id u36mr8212720pgn.145.1540672384154;
 Sat, 27 Oct 2018 13:33:04 -0700 (PDT)
MIME-Version: 1.0
References: <20181027082019.20838-1-hch@lst.de>
In-Reply-To: <20181027082019.20838-1-hch@lst.de>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Sat, 27 Oct 2018 13:32:51 -0700
Message-ID: <CAKwvOdnK5BfpkSos6HsaQ1V7Jmo-voA0=a6NqEAUNKS3WyLwUQ@mail.gmail.com>
Subject: Re: remove exofs and the T10 OSD code V2
To:     Christoph Hellwig <hch@lst.de>
Cc:     ooo@electrozaur.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        osd-dev@open-osd.org, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 27, 2018 at 1:20 AM Christoph Hellwig <hch@lst.de> wrote:
>
> The only real user of the T10 OSD protocol, the pNFS object layout
> driver never went to the point of having shipping products, and we
> removed it 1.5 years ago.  Exofs is just a simple example without
> real life users.
>
> The code has been mostly unmaintained for years and is getting in the
> way of block / SCSI changes, so I think it's finally time to drop it.
>
> Quote from Boaz:
>
> "As I said then. It is used in Universities for studies and experiments.
> Every once in a while. I get an email with questions and reports.
>
> But yes feel free to remove the all thing!!
>
> I guess I can put it up on github. In a public tree.
>
> Just that I will need to forward port it myself, til now you guys
> been doing this for me ;-)"

Hi Christoph,
Thanks for the series.  I suggest you pick up Nathan's patch:
https://github.com/ClangBuiltLinux/linux/commit/a37fa82bde58960c5c966a5c1bef8ace6c9d4f34
that removed the configs that were removed in this series from the
various defconfigs.

I think the other thread still has some questions about when it's ok
to remove filesystems. But it's ultimately the maintainers decision.
Let's continue the discussion in the other thread.
-- 
Thanks,
~Nick Desaulniers
