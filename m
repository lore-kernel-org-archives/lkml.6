Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C5C6C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 08:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BBD62243E
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 08:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="bTHj4A7E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BBD62243E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732276AbeKNS3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 13:29:42 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:43203 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbeKNS3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 13:29:41 -0500
Received: by mail-io1-f66.google.com with SMTP id t81-v6so11076017iod.10
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 00:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4kTUarp7O4qH3NADE6rZgqZ8qFc8RzcrWPiJyKyU94o=;
        b=bTHj4A7EPLPwxKsrJRvZasj9gI7baVh+IOlx55cLddkPP9j98dvd8lPoVUhZQTBAqj
         Io1+K2+HFlleruaxuFSIUVN4MFNeQwvDhHwjBuYiRKfpU92PUrs7FN4l0BDv10JsaCa0
         6mSUzNWRMMgvftxwzjDrd/jkD4jt+ESP8QR1drW3oGu6zSXlr+L7FTrkouGPpVwDdDYq
         riU9Oh4HdQ7N/y0OOZRrkxksfIMOB+KtE65O6XCqd0XaGJpmC+3CCfRJW80E8nGHgLAl
         Lmp5X8U+xxjrsDf6jm6OHyPDB3QWg8LcN3o8YkMKJqRK0A2K8p2l377LpaG7BfPjweI1
         6vWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4kTUarp7O4qH3NADE6rZgqZ8qFc8RzcrWPiJyKyU94o=;
        b=csjWV1ard4sSNVvzXe7puuyy9d35WXAPIKiReZDDovTGY86SgxZ0zI5owCFJT9zhv6
         dl59pIDra1QtRNwMCjYshHi9qAFOkwBKD85zHxtlcZsSk5LLjAzq74udB6TQgiWL4VCh
         1gKv0BXKJFmbfcl1D9dqmLyd6KslFA9gfvi8MEWFuu2ozHyAvBB1Pg1ErllSKyY3lY9A
         5+jd0uhldZ1/bbpbiseun5TdDdnFlbF6/vStGMl70k2EhS4e5yRW14WTsQP9cXAPy3+V
         38ILUGUjIzmFuMrCjiq3X21LPGBdx/kezHamylj6zbLs1e1T1ADcoGB4KcnBwERNO7jf
         M9aA==
X-Gm-Message-State: AA+aEWYqYQTHTKIHJq+PZ4RpCeHluaNuHnB8xaJxW8rq7775VYZI0ul8
        mTYxKE+BcJqdiIgRTKl1dayNPkqMaF4MWqEeFmowtw==
X-Google-Smtp-Source: AFSGD/U33Od6SXBoqYj93WLTIFJwtYK1a1aPM/QWhu9NskjPgp7t/Jus8OHJNP1Cqv4slWmI7PUEStRTrzDav7kbRMU=
X-Received: by 2002:a5e:9e0a:: with SMTP id i10-v6mr755431ioq.111.1542184049013;
 Wed, 14 Nov 2018 00:27:29 -0800 (PST)
MIME-Version: 1.0
References: <20181108164610.28361-1-brgl@bgdev.pl> <20181113211144.GC2724@ulmo>
In-Reply-To: <20181113211144.GC2724@ulmo>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 14 Nov 2018 09:27:17 +0100
Message-ID: <CAMRc=Mcdw5rfnXhrj7BSGTocU1HfACtTXraE1EgWe5dxw2SUTA@mail.gmail.com>
Subject: Re: [PATCH] mailbox: tegra-hsp: use devm_kstrdup_const()
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 13 lis 2018 o 22:11 Thierry Reding <thierry.reding@gmail.com> napisa=
=C5=82(a):
>
> On Thu, Nov 08, 2018 at 05:46:10PM +0100, Bartosz Golaszewski wrote:
> > Use devm_kstrdup_const() in the tegra-hsp driver. This mostly serves as
> > an example of how to use this new routine to shrink driver code.
> >
> > Also use devm_kzalloc() instead of regular kzalloc() to shrink the
> > driver even more.
> >
> > Doorbell objects are only removed in the driver's remove callback so
> > it's safe to convert all memory allocations to devres.
> >
> > Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
> > ---
> >  drivers/mailbox/tegra-hsp.c | 41 ++++++++-----------------------------
> >  1 file changed, 9 insertions(+), 32 deletions(-)
>
> This looks really nice. I'm currently working on a series of patches to
> add shared mailboxes to the HSP driver. Part of that series adds struct
> device *dev to struct tegra_hsp, which in turn would simplify this
> patch a little.
>
> Looking at some of the changes here it also seems like they would
> conflict with my patches in some places. Would you mind if I pick this
> patch up into my series and resolve the conflicts there?
>

Not at all, please do. I just want to add at least one example user of
the routine (devm_kstrdup_const) I introduced in the last merge
window.

Best regards,
Bartosz Golaszewski
