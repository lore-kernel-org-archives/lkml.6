Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 839C9C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50259206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="he/2rpV0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733048AbeLQOhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 09:37:10 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:46966 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbeLQOhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 09:37:09 -0500
Received: by mail-io1-f66.google.com with SMTP id v10so10085641ios.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 06:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3q6P5RehYoQytdTA+RoUcbFi6HQhV44fDiOGvIzUx7c=;
        b=he/2rpV0eUhH66VHjFgksJpefZ97b4EoPPsXDMFHGlteLbTNNqpcxeF3XVIJ/uOWW4
         yT4D7vF1s37KGMkngO55Np+Pvqt+YdCuwGq2rVVZ7Q3/HOMHQDgrXbnEWxHNyX49bYWC
         h2rjGYdHd4rzQV7IrKXd0nB5cFB5Uu+gPNJeL9VuNy93SJH4E5Nao73/tozIlWfKv18u
         MHwEBM5FShw8iTggbeGO5qQzYy4vd9tP8ltb4+N3WPbEi7TvsGYXiRXUJD/W7ebK25XP
         0W4R346YXlr1nNu2am4YQywYX3Ud25l7tZt5z5ps1PX4VfbwdheLK7h2DZ3SHzO4RFHT
         NDTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3q6P5RehYoQytdTA+RoUcbFi6HQhV44fDiOGvIzUx7c=;
        b=dTq+v/hUmIIquM4CQyHahxNpBsQzx2rZY7Uq+rAP020rdIMizjgWhjPXO/yi1gpzJj
         6DPk3i7yw0FwEPpHBU/j+xViL+XCHADCgfoQANDEEbYW3/26otRMWm3wrRja8KAN9I1b
         Ni5mRlpyLNksk9NJwtxOoTwI7lPY94uWRsISVh3LWF9wdW1akfgJGUNt0jYHvLn5zfiZ
         nRfFSbTwN+GKFY5ryE9R+BtFW3SD/0bgpNd6D6Lm/cWTjNa+zBhB9sz4fK5cEDtQmp5A
         rLixQxjeQD2OA6htQ5L4rl0E2VND+EL4izjw+A93/asuSaTHqahcEyWnoIDmV56Qf2+N
         n18A==
X-Gm-Message-State: AA+aEWawFAXwLDjUkESPmQS7d3isfjMJe+KQZh6C/tUi96kYob+UfkSH
        nb7EN+r7C61j+55CWpNWngqNjiY8hoFIVau4aJs=
X-Google-Smtp-Source: AFSGD/UfEBEwkeda+pE3xmM9vL01OBZBgQmdhZ6+QnXM2pokwhISsPU4Bc8x57HrGszTiBJdVEoShe8ppFhwAyrPpC4=
X-Received: by 2002:a6b:a0d:: with SMTP id z13mr8326411ioi.57.1545057428626;
 Mon, 17 Dec 2018 06:37:08 -0800 (PST)
MIME-Version: 1.0
References: <20181121145429.7582-1-thierry.reding@gmail.com>
 <CABb+yY3G3VQGcEHaSZq3bUYrJUToP4oQOCns92q3S0Nr9W_09A@mail.gmail.com> <20181217143506.GA29853@ulmo>
In-Reply-To: <20181217143506.GA29853@ulmo>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Mon, 17 Dec 2018 08:36:57 -0600
Message-ID: <CABb+yY1reX7dgkz6bfnbU3TFSkG=UYNpCjQcvAbEad=2=rwS-Q@mail.gmail.com>
Subject: Re: [PATCH 00/19] mailbox: Device-managed registration
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 8:35 AM Thierry Reding <thierry.reding@gmail.com> wrote:
>
> On Tue, Dec 11, 2018 at 10:34:59PM +0530, Jassi Brar wrote:
> > On Wed, Nov 21, 2018 at 8:24 PM Thierry Reding <thierry.reding@gmail.com> wrote:
> > >
> > > From: Thierry Reding <treding@nvidia.com>
> > >
> > > Hi,
> > >
> > > This series of patches adds device-managed registration functions for
> > > mailbox controllers. A number of drivers can be simplified by making use
> > > of this new API both in the error cleanup paths in their probe functions
> > > and in the driver remove implementation.
> > >
> > > In addition to adding the new API this series converts all drivers to
> > > use it. There is also an additional cleanup patch for the mtk-cmdq
> > > driver that removes some calls to devm_kfree() that are not needed.
> > >
> > Any  Acked/Reviewed/Tested-by would have been great, but I see no
> > driver author is CC'ed. Do you want to loop in authors too?
>
> I didn't think that was necessary because it's a pretty mechanical
> change. But I can resend with all the authors in Cc.
>
Yes please. The authors should atleast be notified of the change, if
not asked for review.

Thanks.
