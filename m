Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27EDDC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED6FE217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iQVmLVfe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730040AbeLSSuI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 13:50:08 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40066 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729478AbeLSSuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 13:50:07 -0500
Received: by mail-lf1-f65.google.com with SMTP id v5so15842846lfe.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 10:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PO0k9/o7FTI1jmrZxBjOjNf74wJ/GL8BCXp4XKglEmI=;
        b=iQVmLVfePQuBwksRtmeoKDlom41PV7298F02ulRzbo0gry7p9hGyVy/sy67yu5mNFM
         f+VUWogabWm2Up1+oC9aVduDK4g9c5+yluSQ4H5NFaEhKPES5ByPKdjmngWmOo77Fqdi
         I3BbczXpU7mrqD4x92RGu9CMx3PxRvhKGQYcs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PO0k9/o7FTI1jmrZxBjOjNf74wJ/GL8BCXp4XKglEmI=;
        b=lYj4QEPU8qvZyzXoPm/Bcg5n16zQQpvp2FvSplFp/M0AqN9gT6vtk5+BcQZtriUiGS
         iwvAJx9X14LlIcj3XwdGEWZFJdrsmkBDw1m19oraYFoxj4miXjsj6N7mmmhSu7vKxftM
         iu30w/U7gM57fBOwml/d/efRFCvJA+Tlq6afTOyqTj5+KmRUTL4iVUfpzEF84TJVsRy5
         ftS9gAwnLIZdsMOTY0Ks9blyetLe3148cvBjOJS4Z0Cic9XVXnIsNM4H6icL4Moy/2Xr
         GeLkmhhXtvStynql6F4HUOgA7bvGpxQqOjNpXoK0e69KiUSQzS2luI/yhZHtXBwiAMNY
         1A/Q==
X-Gm-Message-State: AA+aEWahV6oVwlXFQyQyk3fpBPJtpbdmOn6PnsIZC4/g90iujaBAr4pA
        rtwCMsnWV6iRm29+9Vy7KyTnC6/YIG8=
X-Google-Smtp-Source: AFSGD/WDtQ0FXj7iBVoAtWGcFAbfP6wZQQhpNf/upUrKPxQ1Ots9y93KriCIrFKwB0ue/wdBd+aedg==
X-Received: by 2002:ac2:50c4:: with SMTP id h4mr11597859lfm.81.1545245404728;
        Wed, 19 Dec 2018 10:50:04 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id a62sm3978968lfa.37.2018.12.19.10.50.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 10:50:04 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id v1-v6so18358497ljd.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 10:50:04 -0800 (PST)
X-Received: by 2002:a2e:45d:: with SMTP id 90-v6mr13628864lje.110.1545245402786;
 Wed, 19 Dec 2018 10:50:02 -0800 (PST)
MIME-Version: 1.0
References: <20181219181747.118278-1-mka@chromium.org>
In-Reply-To: <20181219181747.118278-1-mka@chromium.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 19 Dec 2018 10:49:26 -0800
X-Gmail-Original-Message-ID: <CAE=gft7BV=M4wpk304yhDV11ddNJSFGDYu8TRW3WOtDPLrRmnQ@mail.gmail.com>
Message-ID: <CAE=gft7BV=M4wpk304yhDV11ddNJSFGDYu8TRW3WOtDPLrRmnQ@mail.gmail.com>
Subject: Re: [PATCH] tty: serial: qcom_geni_serial: Fix wrap around of TX buffer
To:     mka@chromium.org
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        msavaliy@codeaurora.org, ryandcase@chromium.org,
        Doug Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 10:17 AM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> Before commit a1fee899e5bed ("tty: serial: qcom_geni_serial: Fix
> softlock") the size of TX transfers was limited to the TX FIFO size,
> and wrap arounds of the UART circular buffer were split into two
> transfers. With the commit wrap around are allowed within a transfer.
> The TX FIFO of the geni serial port uses a word size of 4 bytes. In
> case of a circular buffer wrap within a transfer the driver currently
> may write an incomplete word to the FIFO, with some bytes containing
> data from the circular buffer and others being zero. Since the
> transfer isn't completed yet the zero bytes are sent as if they were
> actual data.
>
> Handle wrap arounds of the TX buffer properly and ensure that words
> written to the TX FIFO always contain valid data (unless the transfer
> is completed).
>
> Fixes: a1fee899e5bed ("tty: serial: qcom_geni_serial: Fix softlock")
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

Oh nice, so this did end up being your problem with corrupt
characters? Strange though, I still would have expected this bug to
result in inserted serial characters, rather than edited ones.
Either way, this looks good to me.

Reviewed-by: Evan Green <evgreen@chromium.org>
