Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 785DDC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 05:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 391252054F
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 05:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QKGBxu3n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfARFQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 00:16:57 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42175 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbfARFQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 00:16:57 -0500
Received: by mail-lj1-f194.google.com with SMTP id l15-v6so10545793lja.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 21:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4qOOIdur6T5/rfoMG/Swpii5RwwqntWqsy7IdjLQoZc=;
        b=QKGBxu3n0jOCDPuNpLr5p0NKhYJ8N5QJxwh2ddc0H5Ui+S6IjO0C8Dn956YURsTw+M
         bimDBDQahyk1fNHEtSQKi7WMkH7A/Rc17PqJu1IS1nv4CalcDRr6z7tO6au2J4Ui4m7M
         RiATvy8aVzuoZImU4XE8qe0exP+3Q00x679gs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4qOOIdur6T5/rfoMG/Swpii5RwwqntWqsy7IdjLQoZc=;
        b=M6U4BmjO0aP5oJ34PW6iAorRXBjBYTI8Dk3SyTTrcZDfjutBWM2zSSIkVUaMSP6Th5
         who4CW2hExPlGs144O2ViCYvU4dht2w8KeaCHTIxAt0H/Ird4bg8kIyIkoKEevgHFc9V
         27uW7bCCfw6QOuF7+ShnIGYz4DBPk2os3CeAyOyyZ1SQqqyNOUbo7pA/273t/DWyGClQ
         rJLCq8eIumDMXdUoOoRQj1+fFc54+KeigNW+KK53H3oyYc3gLrLIfxQtPvY6LtfXSxW8
         woZj/FBll0uMN80bMaSr9bYCc/rfBJ2sYx7nJyYGM9POtyUMVaY0GGMwFLCo9jjKFxcR
         hz5A==
X-Gm-Message-State: AJcUukdkrhVGTRRF6RWrFHR5H0LuG4cjVKEaUBaZpQKQTP61zpL+VYW9
        trbvXMLG0asMZD1Ye6ATX7oZLR5lFgI=
X-Google-Smtp-Source: ALg8bN6dAdQSn3XeJ5RgULvCEXrqPrshWrqGO9WT3EpNHpVb4zYDoAY5MakGR/mgMhv8RoPhFCLCEA==
X-Received: by 2002:a2e:89d7:: with SMTP id c23-v6mr12185070ljk.0.1547788614998;
        Thu, 17 Jan 2019 21:16:54 -0800 (PST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id e94sm628243lfi.23.2019.01.17.21.16.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 21:16:53 -0800 (PST)
Received: by mail-lj1-f173.google.com with SMTP id t18-v6so10582031ljd.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 21:16:53 -0800 (PST)
X-Received: by 2002:a2e:2416:: with SMTP id k22-v6mr12025586ljk.80.1547788612981;
 Thu, 17 Jan 2019 21:16:52 -0800 (PST)
MIME-Version: 1.0
References: <CAPM=9twXwFGmN8fK-iNyFR6T_k64qB5OdNFP3fzKSSWKou1BcA@mail.gmail.com>
In-Reply-To: <CAPM=9twXwFGmN8fK-iNyFR6T_k64qB5OdNFP3fzKSSWKou1BcA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 18 Jan 2019 17:16:36 +1200
X-Gmail-Original-Message-ID: <CAHk-=wjS+RmnLFYJHxdvc07Z_GeXm+y92zm=16=a5WXYif49xQ@mail.gmail.com>
Message-ID: <CAHk-=wjS+RmnLFYJHxdvc07Z_GeXm+y92zm=16=a5WXYif49xQ@mail.gmail.com>
Subject: Re: [git pull] drm fixes for 5.0-rc3
To:     Dave Airlie <airlied@gmail.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 12:43 PM Dave Airlie <airlied@gmail.com> wrote:
>
> Going to be at LCA next week in Christchurch, but should be fine for
> normal pulls.

.. hey, me too.

>   git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-01-18

Pulled,

              Linus
