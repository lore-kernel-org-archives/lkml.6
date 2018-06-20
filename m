Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE71C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 18:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D71A9204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 18:27:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D71A9204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754777AbeFTS1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 14:27:41 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:36813 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752838AbeFTS1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 14:27:37 -0400
Received: by mail-yw0-f195.google.com with SMTP id t198-v6so194955ywc.3;
        Wed, 20 Jun 2018 11:27:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iVG09SE/MDOR9aIFQ6m9mdR14m1U5cWb79rvo5fmhjg=;
        b=Fi/+/QtkLIv9oTTN4IhyoJJhYGM5ViREWeV0qRlGT2hAugUzkWm0u4ECvHkT8YBCyW
         ex4iseW0Ec8ZHtXpxhRKGH6XAqyQkjz8FxIZ1jbk6HWHpPirJgAghD3oqxuhFm5TORwr
         +w67sMW2+O0nmBk6+jUwFc6KJgDKpWkB7kz+tKnZxJ0tHljYoSHahAVWv+jcbTci2bnD
         R3gf19t+/qvZ4adtxqxZaAZ1F2r6y3d3STkJ/nGYoMPM59Jsnd4EjwfXrAnMc1rUdhP1
         UgGixZtAl6YXuUp9JQm266MS74hwxxWMtp1rFm6NqeD4XNrfH8s1OfSk+Gn1/ps/OVEy
         R1fQ==
X-Gm-Message-State: APt69E0eer7Y+p7NSQ67d8+YGtaoVNRC/mm726HCh6Fi4mHnyQuHpJeA
        MIF2lTFeVZbqEWEagAWdiA==
X-Google-Smtp-Source: ADUXVKIVJVu/Dn5CeehRZ42PRG3Sg110fPlUsPHpk2NX6j5TPC46oM56dAsf78zZRara8v2YhXo0ZQ==
X-Received: by 2002:a81:47d7:: with SMTP id u206-v6mr10532812ywa.316.1529519257116;
        Wed, 20 Jun 2018 11:27:37 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id 13-v6sm142882ywt.43.2018.06.20.11.27.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 11:27:36 -0700 (PDT)
Date:   Wed, 20 Jun 2018 12:27:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kiran Gunda <kgunda@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, jingoohan1@gmail.com,
        lee.jones@linaro.org, b.zolnierkie@samsung.com,
        dri-devel@lists.freedesktop.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH V3 1/7] backlight: qcom-wled: Rename pm8941-wled.c to
 qcom-wled.c
Message-ID: <20180620182735.GA17179@rob-hp-laptop>
References: <1529406822-15379-1-git-send-email-kgunda@codeaurora.org>
 <1529406822-15379-2-git-send-email-kgunda@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529406822-15379-2-git-send-email-kgunda@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 04:43:36PM +0530, Kiran Gunda wrote:
> pm8941-wled.c driver is supporting the WLED peripheral
> on pm8941. Rename it to qcom-wled.c so that it can support
> WLED on multiple PMICs.
> 
> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
> ---
>  .../bindings/leds/backlight/{pm8941-wled.txt => qcom-wled.txt}    | 2 +-

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/video/backlight/Kconfig                                   | 8 ++++----
>  drivers/video/backlight/Makefile                                  | 2 +-
>  drivers/video/backlight/{pm8941-wled.c => qcom-wled.c}            | 0
>  4 files changed, 6 insertions(+), 6 deletions(-)
>  rename Documentation/devicetree/bindings/leds/backlight/{pm8941-wled.txt => qcom-wled.txt} (95%)
>  rename drivers/video/backlight/{pm8941-wled.c => qcom-wled.c} (100%)
