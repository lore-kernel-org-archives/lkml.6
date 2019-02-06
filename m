Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CFC7C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23F812186A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L17qMF+E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbfBFNrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 08:47:48 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36263 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727179AbfBFNrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 08:47:48 -0500
Received: by mail-ot1-f68.google.com with SMTP id k98so11925075otk.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 05:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XVRXZtNFlTpX8lkhPWC52RRu+H2rn9W6ZGWpmXI3jdQ=;
        b=L17qMF+ETV736pVmpyVYLUOUJuLnOH7YcTeQveJuOi61dFUfP7VRxBvXchApWexkfM
         4Q6GDp/y6pxaeUV043j31vWm1vwZ2GgXZ11yF+8LQrbQPaGNCdN7s5v/X6puTTzmu4md
         xYpmcyw+i/Jd0MT9GAbJM9+749qdqawR0eDB85ivPSYIvryl4Tv7g3G/S2i+6MU+wAgc
         r0n5CpiGt/0iWO+66GpXT3E84zie3qkuZFKoCtnuugFpLHozxEZ7kU07f1Kqc3LfZgx3
         6BleLzWSedhqgG1+cFLvam01fAEIAZW8HWmI8y5Cv6gFEaKOAb9d8WAyKcjRZDYRY53N
         5hPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XVRXZtNFlTpX8lkhPWC52RRu+H2rn9W6ZGWpmXI3jdQ=;
        b=K48BUNaUNsjkL4EGPFMOTTtiWl8AAjooVqVdZHO5ZQ7D4GV+iJ4/2Sh+fqyUYRzW25
         c8Eoy9PSDAKHyfoDX7XRPdyOux21dJJrTCydDdDhI1c36++W0K+CLKkpphLDZQF1n/US
         3jNoSdvOplge+ByHcviM72/vubNfMdVa0JIi3pT+zF/pZ/4IP6lM/uHfahldTWk3tnD/
         3+gCDGyK+rLC4fgBDgpOz1fN2z81qoWckIt9ohTZqe0sI0nTqyNdjKOm9n2SjuLgRgTb
         Fh6J3VF+Deg2SS51vmSjVYy3AchwZKAb0z69g74oSKQUT2TzI+FbZEL1ooS23NGz4hJ7
         PIaA==
X-Gm-Message-State: AHQUAuZVOeDO8k6mNZc22SWf8n+4W0IZpnHjn+EgKa9etz+FZBY84E42
        m9wEkBA7qK7kq97TKaNxL4lTYz8Geen7FXsRmXo=
X-Google-Smtp-Source: AHgI3IYXau3/xoWypLIqL2oVYJREyqHCnM7Tv7JpcsTRlABGqlIb2eAPLMGWcIM5BEhZxdAB44NqtNZs5g5A67VsLI8=
X-Received: by 2002:aca:cc:: with SMTP id 195mr5523382oia.297.1549460867465;
 Wed, 06 Feb 2019 05:47:47 -0800 (PST)
MIME-Version: 1.0
References: <20190124201251.15159-1-TheSven73@googlemail.com>
In-Reply-To: <20190124201251.15159-1-TheSven73@googlemail.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Wed, 6 Feb 2019 08:47:36 -0500
Message-ID: <CAGngYiWFU-VnG=ODLWaUf0yp69qaU2GSd9exdHvyi6Ko1ib9qw@mail.gmail.com>
Subject: Re: [PATCH v8 0/6] Add Fieldbus subsystem + support HMS Profinet card
To:     Sven Van Asbroeck <svendev@arcx.com>, robh+dt@kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Lee Jones <lee.jones@linaro.org>, mark.rutland@arm.com,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        treding@nvidia.com, David Lechner <david@lechnology.com>,
        noralf@tronnes.org, johan@kernel.org,
        Michal Simek <monstr@monstr.eu>, michal.vokac@ysoft.com,
        Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        Stuart Yoder <stuyoder@gmail.com>, maxime.ripard@bootlin.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 3:12 PM Sven Van Asbroeck <thesven73@gmail.com> wrote:
>
> This patch:
>   1. adds a Fieldbus subsystem
>   2. adds support for the HMS Industrial Networks AB Profinet card.
>

Is there any feedback I may address? Any improvements I could make?
Any clarifications?

If not, what would be the next step for this patchset?

Many thanks,
Sven
