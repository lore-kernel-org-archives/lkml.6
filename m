Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25AD6C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 00:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6131219D2
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 00:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bbIr7xTK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6131219D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbeHRDtw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 23:49:52 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:42622 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbeHRDtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 23:49:52 -0400
Received: by mail-qk0-f193.google.com with SMTP id p71-v6so2213071qka.9;
        Fri, 17 Aug 2018 17:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GYTKYD3RRQzcDbKf46MJyfYMMOpvMxlZOySLpvS4/FU=;
        b=bbIr7xTK1iXJKilEgKV3ENBe8wdlx1z16caWKBBotpQ0M/cnrkHJyj6NNOyxSpN5JI
         07IjubmZr4zRk1VEl2tAB8zF/FrLvhcEsFGE6R/N0ucCtbE+8b8ZvpIkyyyxxNvdBHFJ
         Zh6TzvdX6PfvN4qBBWMPW3folrveA2QaowKIohdkQYSO1e0MD1vRTlT00NbDTtxghH5j
         ZAT6NH3LXIftopjCGbjZo6l6HQSRnVVSi/uMfBAg7kGOnTbOnIilRgCKaWJV3WK7ofT6
         LRlL7CLjYECDjDhoh6Q4taEBGEv6OZJPEF5+1ho1KQv8gKBuZN6bkOYxXYFsWLgn/VLc
         eP1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GYTKYD3RRQzcDbKf46MJyfYMMOpvMxlZOySLpvS4/FU=;
        b=R5WbJfSlSBCgeqov5bhEvaTBhQouu38a794xBVMen7cqcPbS0++gpc27hVoKZmlwzA
         NILMK/HK18k5KDm/XGdKjoYa7J47Kf3UEHLOgOrV/F2L3qxReGxjKC7sNX5+N/sAuocN
         0dWcMYxvmXmB5HpD4wW0yJ2+D69tU7Y8GCF6SuqqkYGOTrszpDynE97bpT9LDkF7UnVV
         rleKhTLohCeJCAcMnwVfKQt5uCO9Kh+EEWS4e7rGKh2dFWWaaU9B7VTmLyrvAWDB2qMv
         61lHNqubrhqJQJuCGrPYcIddyktE+dRbOYuOtmeZXVzUCH+N3WDDhqYu8zfzMhyuailf
         w+Jg==
X-Gm-Message-State: AOUpUlFRj8abtxxYDxUCcpuNPNUuBOnC09EZqJdV7KpTPAY3+gZ6/3LZ
        7Kp+zZKbF7E/AU7wHV2sBX1xa/jLJ380Xd6Ad+o=
X-Google-Smtp-Source: AA+uWPx/zPg4lZ6MefF5I3/IXhKmY+DdBOeUwgCZWVgEJwBCTQGBCjMeukeWIZIv3TPMwA9R7t990HcyBycQPdQBqS0=
X-Received: by 2002:a37:3752:: with SMTP id e79-v6mr35313380qka.131.1534553055505;
 Fri, 17 Aug 2018 17:44:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:949c:0:0:0:0:0 with HTTP; Fri, 17 Aug 2018 17:44:14
 -0700 (PDT)
In-Reply-To: <20180817234049.9624-1-mdf@kernel.org>
References: <20180817234049.9624-1-mdf@kernel.org>
From:   Moritz Fischer <moritz.fischer.private@gmail.com>
Date:   Fri, 17 Aug 2018 17:44:14 -0700
Message-ID: <CAJYdmeOBWt3rdbBGfCR5OFxO8pQHn62msXb0q2ukxBFGHQQqog@mail.gmail.com>
Subject: Re: [PATCH] fpga: dfl: region: Restory symmetry in probe()/remove()
To:     Wu Hao <hao.wu@intel.com>
Cc:     Alan Tull <atull@kernel.org>, linux-fpga@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Moritz Fischer <mdf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2018 at 4:40 PM, Moritz Fischer <mdf@kernel.org> wrote:
> Replace dev_get_drvdata() with platform_get_drvdata() to
> match the platform_set_drvdata() in the probe function of
> the platform driver.
>
> Fixes commit bb61b9be3e6b ("fpga: dfl: add fpga region platform driver for
> FME")
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> ---
>  drivers/fpga/dfl-fme-region.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/fpga/dfl-fme-region.c b/drivers/fpga/dfl-fme-region.c
> index 0b7e19c27c6d..ce7ebe4b3212 100644
> --- a/drivers/fpga/dfl-fme-region.c
> +++ b/drivers/fpga/dfl-fme-region.c
> @@ -65,7 +65,7 @@ static int fme_region_probe(struct platform_device *pdev)
>
>  static int fme_region_remove(struct platform_device *pdev)
>  {
> -       struct fpga_region *region = dev_get_drvdata(&pdev->dev);
> +       struct fpga_region *region = platform_get_drvdata(&pdev->dev);
Blergh ... that doesn't even compile. I'll resubmit next week. Sorry
for the noise.
Should of course be platform_get_drvdata(pdev);

- Moritz
