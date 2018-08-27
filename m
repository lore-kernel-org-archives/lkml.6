Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5005FC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 09:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2AB2208B1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 09:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bbODHc+U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2AB2208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbeH0Nk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 09:40:59 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:36168 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbeH0Nk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 09:40:59 -0400
Received: by mail-it0-f66.google.com with SMTP id u13-v6so1574700iti.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 02:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=c6gRYBIn7tL9m1cgzkeN0nTvLlObFqGKe51QQPBekW8=;
        b=bbODHc+U9eZz38Nl6fXs/Ap2e2P+LR2jziduDN7/Svt6cUeGGW6U8VE8fBuDl+9iwq
         3nlpVASS6iuMpkiWl5mS1E1u1bBxMIFD1qOlUxye4AauYpdak7wRm08tOPj+K/nX7aNG
         ryU0quKjSCGYajKrA3Nv5ElDErZDrKnRKHbKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=c6gRYBIn7tL9m1cgzkeN0nTvLlObFqGKe51QQPBekW8=;
        b=ZrZB/AJ3xyLV6W/TeFL0kZkA47HfUrk0dsEYyQRDB9K+sn+hYJb089T9CxfuxmhPd1
         vcMuUOFAL8VvlGtcS7drIaYtfCMIQdgmvjOL39xQa0MfRpX5kDdH5yHy5Vo6oj3dBkh9
         jUaXnjDKK3ki1tVXW6nVCONESnLCwESr3O6PfAyxh6uCFEjcXpqyyXEDCSw0vwdczyLz
         bV9l9yxx0aoz9isvI+wbKjyial2v4PyCGRQqZNHiqGNJ3qX03ZZwhvOquLEMxa2z14mM
         SCU0w5fjfDDbdtXT6qOVKEB3dNovUfpEl46duBrk9VFvk5RVGlqlv6HDHxPPXquWbNvw
         FXvQ==
X-Gm-Message-State: APzg51DD2ElKryaA1zFdtZVJS72Sa5AAz+VINvVFIG+9a8mY3nHrVAiP
        hi0NEwRhLa2p0hsM7MzJZ+vBXLb5SFOdE9JBXQBXUYaUJlI=
X-Google-Smtp-Source: ANB0VdYp5zm5SEeNOyO/6O1aLUMFym/nNFy+mp0ANYAZTddtYKLFrmqs++wKU2xr3Z53mUwNHFCApVcFtUESEEOc8qI=
X-Received: by 2002:a24:a388:: with SMTP id p130-v6mr5942823ite.146.1535363701686;
 Mon, 27 Aug 2018 02:55:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:2b03:0:0:0:0:0 with HTTP; Mon, 27 Aug 2018 02:55:01
 -0700 (PDT)
In-Reply-To: <20180823085014.GB28696@ulmo>
References: <1534757013-4524-1-git-send-email-avienamo@nvidia.com> <20180823085014.GB28696@ulmo>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 27 Aug 2018 11:55:01 +0200
Message-ID: <CAPDyKFqJJhhJe-fNLs-_zCcZiYKb+JAgJHwEyZbbUbs69hvQaw@mail.gmail.com>
Subject: Re: [PATCH 0/2] Tegra SDHCI rerun pad calibration periodically
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Aapo Vienamo <avienamo@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 August 2018 at 10:50, Thierry Reding <thierry.reding@gmail.com> wrote:
> On Mon, Aug 20, 2018 at 12:23:31PM +0300, Aapo Vienamo wrote:
>> Hi all,
>>
>> This series implements pad drive strength recalibration. The calibration
>> is rerun to compensate possible changes in temperature. The calibration
>> procedure is rerun as part of mmc_host_ops.request before
>> sdhci_request() is run. The calibration is executed only if the 100 ms
>> recalibration interval has passed.
>>
>> This series depends on the "Tegra SDHCI add support for HS200 and UHS
>> signaling" series.
>>
>> Aapo Vienamo (2):
>>   mmc: sdhci: Export sdhci_request()
>>   mmc: tegra: Implement periodic pad calibration
>>
>>  drivers/mmc/host/sdhci-tegra.c | 22 ++++++++++++++++++++++
>>  drivers/mmc/host/sdhci.c       |  3 ++-
>>  drivers/mmc/host/sdhci.h       |  1 +
>>  3 files changed, 25 insertions(+), 1 deletion(-)
>
> Adrian, Ulf,
>
> Since this depends on the earlier, fairly large series, I could throw
> these on top of the branch I already have. That way you don't have to
> worry about the dependency yourself. Of course it's also fine if you
> want to apply this yourselves, in which case the series is:
>
> Acked-by: Thierry Reding <treding@nvidia.com>
>
> Thanks,
> Thierry

Feel free to put in top in your branch and send a PR. BTW, Adrian has
already acked these changes.

Kind regards
Uffe
