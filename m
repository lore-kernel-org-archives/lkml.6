Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DBDFECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 20:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30A9A20867
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 20:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TlknAMMZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30A9A20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730343AbeISBqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 21:46:42 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:39534 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729859AbeISBqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 21:46:42 -0400
Received: by mail-io1-f68.google.com with SMTP id l7-v6so2640335iok.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 13:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iHCoAHEmQ6Gp0tLNwfJQ2Vi5Zuiw8x6oFo5bdagm7zM=;
        b=TlknAMMZjoK/hetTHLiPwY2QR9lLzz9EhuRBF8i7h3pOGAPctzOOvsvZlfcpGApHMN
         atZeEWU9Erq1jmPtQwRaNmH90skgdqlAdGtqIOQo2iHwNGpLal4xpwLXB7DC7RkmHGXP
         LF7US3T0S3z5OPNjzOns9Keffj0TLSNMfOK/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iHCoAHEmQ6Gp0tLNwfJQ2Vi5Zuiw8x6oFo5bdagm7zM=;
        b=eu3y4KFzw3xkSFOh5yFchGnAw3epT2lKijJF1SbvXzKWVH1Y0/9pQdLrHKx4iauFpD
         qmXMqjBlfFEqdpjq/PjJg4kAhU6oV4VBvzD11gwuUZdv5uWINghN2m9uszy5hNr28bo0
         BjUnhdz1M6ysu7oGpHZ1peaQhvcmYFoOgnJ8jyz+cB7SMWDUoU3GHohtA8XQ/JbYUJBF
         iUl5lGYhQCITdO/W0Av2P5ZWTCqDiY7I9HfG5Y+1dUX5l8jWjb6v/4hPmcqwAaYqMG3r
         O/ESY5I/DzBiJxpjYJPvlZ3n17mXLRu8dChqU0cO9Gen+qZLyVoMOk9CK11IsGr/2oJv
         Qt3w==
X-Gm-Message-State: APzg51BKGeA160jZQZNLjkiAgBIvbCgDZ1oPL/iM4DbusCQbS0m9jQOI
        c6ZQdJDOQXT7Omgc33Ip/rNV2Fg9dTg=
X-Google-Smtp-Source: ANB0VdaQlGnqHwfdu5Fid9bYgqhkjS8++Xe59b5btxUHiXoYHVP0ZOz4BUR6pNlujQoDkdXJpCl9+w==
X-Received: by 2002:a6b:7a49:: with SMTP id k9-v6mr27598655iop.238.1537301549925;
        Tue, 18 Sep 2018 13:12:29 -0700 (PDT)
Received: from mail-it0-f54.google.com (mail-it0-f54.google.com. [209.85.214.54])
        by smtp.gmail.com with ESMTPSA id i26-v6sm6345046ioj.33.2018.09.18.13.12.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 13:12:29 -0700 (PDT)
Received: by mail-it0-f54.google.com with SMTP id h1-v6so4738311itj.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 13:12:28 -0700 (PDT)
X-Received: by 2002:a24:cf06:: with SMTP id y6-v6mr18323938itf.5.1537301548546;
 Tue, 18 Sep 2018 13:12:28 -0700 (PDT)
MIME-Version: 1.0
References: <1537294047-12093-1-git-send-email-dkota@codeaurora.org> <1537294047-12093-5-git-send-email-dkota@codeaurora.org>
In-Reply-To: <1537294047-12093-5-git-send-email-dkota@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 18 Sep 2018 13:12:17 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VP5xKY8GSwcsb3WBinb+wn75AL8Z2Z=fWau_KAx7iztQ@mail.gmail.com>
Message-ID: <CAD=FV=VP5xKY8GSwcsb3WBinb+wn75AL8Z2Z=fWau_KAx7iztQ@mail.gmail.com>
Subject: Re: [PATCH V4 4/4] spi: spi-geni-qcom: Plugin API to assert and
 de-assert Chipselect
To:     Dilip Kota <dkota@codeaurora.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Sep 18, 2018 at 11:09 AM Dilip Kota <dkota@codeaurora.org> wrote:
>
> Plugin set cs API to the SPI framework so that
> framework can do chipselect assert de-assert
> during  SPI transfers.
>
> Signed-off-by: Dilip Kota <dkota@codeaurora.org>
> ---
>  drivers/spi/spi-geni-qcom.c | 65 ++++++++++++++++++++++++++++++++-------------
>  1 file changed, 46 insertions(+), 19 deletions(-)

As I mentioned in out-of-band I don't see a huge reason why this can't
be squashed into patch #3.  Logically patch #3 has a bug where it
can't handle setting the chip select without a non-zero transfer and
that bug isn't fixed until patch #4.  ...but if folks really feel like
it should be a separate patch then I won't object too loudly since the
end result is the same.

...so feel free to add:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Douglas Anderson <dianders@chromium.org>


-Doug
