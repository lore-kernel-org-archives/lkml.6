Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 201F9C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0CCB20896
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PHXWaSef"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0CCB20896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933014AbeGILcP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 07:32:15 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:37627 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932820AbeGILcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 07:32:02 -0400
Received: by mail-it0-f67.google.com with SMTP id p17-v6so25883531itc.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 04:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fzjSvj7Z97K3C6VuLZ04thnaQ0gs7HQ4aS9ek3xbHxk=;
        b=PHXWaSefYLDD1tGiRIeVS9li6EYlUSB9mDq12U+xoALd5jikmVRQCGN/VZDp0T6Pge
         6+g8Iq3KoHyMWOKiJ452GPHSYwXevjrWIRgM3JZYu2HoDnuNulrf4XjqCsUPazjJPVn+
         BGuxE+NfT+6W1tIYd4ES4ja31lUW0H1mVRewE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fzjSvj7Z97K3C6VuLZ04thnaQ0gs7HQ4aS9ek3xbHxk=;
        b=H2hmrNgZGIt6kKo8HRiKkDYlGfSvbS5i2AKtKKGomqOJdk/5WJnBFL+m6iub2JbHaF
         I6VYc8JYsPeqTEer18A+RqqxMXPKdlJMLz7AG83WWRJVqZdzGNAOPQ56eM7sDaTDObVA
         n/ZTeU2r6Icz/3VLh4H0iR0cybNeD3WV65XUjOk7T++vK1H3J2mLDKiu3swZGtIxmgo2
         8AeG2j6YG7/DRZvxpT0cVmRXXbGvJzPfL2J/95rCEQnih6pqJqSlH/4cOy7Hi2NNmcsj
         ta55/ZVTreHqByPSDWI2Kbwt70fkZUNO0Qa1qDsIB/V///QAG4cO/OY+wjdPTPYh6VpW
         MrRQ==
X-Gm-Message-State: APt69E3ceRL0pAwQjFYMUMu7tRbxtrDB0FOnh1jrPOcvEPB9U1NUlEhd
        yimsM0dfypt90ecWHoLi+XJ3A5BoiEKjUYA3qH1mhw==
X-Google-Smtp-Source: AAOMgpeExXEdthH+/6VV5qrnTWYZmYFixVoHa47j6nevmGG5UVdUF0ioIw3D6lQ5Uh5Sow3zg+knAq2YKM0BXpPfMhM=
X-Received: by 2002:a24:69cb:: with SMTP id e194-v6mr16910099itc.102.1531135921996;
 Mon, 09 Jul 2018 04:32:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:818f:0:0:0:0:0 with HTTP; Mon, 9 Jul 2018 04:32:01 -0700 (PDT)
In-Reply-To: <20180706151930.78b3024b@xhacker.debian>
References: <20180706151930.78b3024b@xhacker.debian>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 9 Jul 2018 13:32:01 +0200
Message-ID: <CAPDyKFp09ch9X0dxC33RBNf4yLzJ439ZCV7sqCiGM300KO48xA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] mmc: add SDHCI OF Synopsys DWC MSHC dirver
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Prabu Thangamuthu <Prabu.T@synopsys.com>,
        Manjunath M B <Manjunath.MB@synopsys.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 July 2018 at 09:19, Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:
> Add support for Synopsys SDHCI compatible DesignWare Cores Mobile
> Storage Host Controller which can support eMMC/SD/SDIO.
>
> Since v1:
>   - move the dt bindings into a separate patch
>
> Jisheng Zhang (2):
>   dt: bindings: Add bindings for SDHCI Synopsys DWC MSHC
>   mmc: sdhci-of-dwcmshc: add SDHCI OF Synopsys DWC MSHC dirver
>
>  .../bindings/mmc/sdhci-of-dwcmshc.txt         |  20 +++
>  drivers/mmc/host/Kconfig                      |  11 ++
>  drivers/mmc/host/Makefile                     |   1 +
>  drivers/mmc/host/sdhci-of-dwcmshc.c           | 116 ++++++++++++++++++
>  4 files changed, 148 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-of-dwcmshc.txt
>  create mode 100644 drivers/mmc/host/sdhci-of-dwcmshc.c
>
> --
> 2.18.0
>

Thanks, applied for next!

Kind regards
Uffe
