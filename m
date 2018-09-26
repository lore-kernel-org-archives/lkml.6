Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7385FC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FE95214FE
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tjader-xyz.20150623.gappssmtp.com header.i=@tjader-xyz.20150623.gappssmtp.com header.b="Mi3+FCpW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FE95214FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tjader.xyz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbeIZV1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 17:27:52 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45677 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbeIZV1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 17:27:52 -0400
Received: by mail-ot1-f65.google.com with SMTP id c13-v6so10757019otf.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 08:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tjader-xyz.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sBG7WSp/wvy3MqEZRmK/eNRW4XRr67Ksi/kS/WEUhjg=;
        b=Mi3+FCpWKgvrlLvJIriIODNyBaqJhbg/vvVCeuNHc8JfiOZZexRx8grpGfnIRqt7Fc
         yPYZMBkjJ59plrd7nFAbaU7lvnLDf3XUExlkEEN79W+m3DLQN8ruupoA1/dI67WaG531
         hl9SyQdGo8asELqZYLKMC/GmzukzuD9xewY+5uX03/dXw1PqC0U+OYRATYC5DEnPpmD+
         S1ZC/Z4zweUAvBT8HIpSctnLURE8rdtEd4/nUahuL94stPUKuuiaqsi+U6AJpCUkIw4Q
         2DmhYdUIKEDwoJjql2cbp+rolOHyHza3FaReLsdChC3zZV1HI/8bGGxkfzf7dOcGbjwT
         e+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sBG7WSp/wvy3MqEZRmK/eNRW4XRr67Ksi/kS/WEUhjg=;
        b=Vz+AH55nmtPuGsWAN29v9XI2WvBRAoCZRwYPTXlReC7ifuw2KlxBMJZi58xQYa2uFG
         2W/wmzYyn7fNkGLBxVLN+AZxyh8l+u3UlaFkNF3xRyG4tG+JhN6j37NU/v7IJ/gQzTJR
         OMk/7UdaF9YJCFa5Om0x0IXjw3sHiB5TO+NpX+KvZ4kP73nJTObVYiXAFnqMCCZia6Ju
         7L/i6fNESm1WFEGaxx3n+w4oVN4wm6VSwxxSSi/fcClrxPS8lVJmOo+xpS+csvbrp1LS
         P+wMHfJswnknJytf/Jpydf5GIguSMad1BrQZJbIt1SvQKBducJZirY+n6rP9MHtmX/Fn
         vZRA==
X-Gm-Message-State: ABuFfogSPB/0gMs2gPzVaSih/ngIX7FPbwlCg7i46RdwHuL8Sm83QIBj
        6RhbKIVzmwvvzzs8wbbnbdbfLOzriQuBVYBjUa//2w==
X-Google-Smtp-Source: ACcGV62BWFiohaYq9gz+1jr3oLZbSXM3eq0+kEftjMAV3P+pXDZWTDbGtADy7xKX3RgBzQkgPl9EqO31Q8UFSaPMjzE=
X-Received: by 2002:a9d:3984:: with SMTP id y4-v6mr4300035otb.215.1537974867494;
 Wed, 26 Sep 2018 08:14:27 -0700 (PDT)
MIME-Version: 1.0
References: <20180919141938.18791-1-rodrigo@tjader.xyz> <20180921142941.5ymp7ksphgboxrwz@flea>
 <CAG7TQgFOuHHmkm-6CDDYJ6KuDqfjNvFjnt8_9BPYfdP=oV57VQ@mail.gmail.com> <20180926094525.e4fepvonmy7ykdbb@flea>
In-Reply-To: <20180926094525.e4fepvonmy7ykdbb@flea>
From:   =?UTF-8?Q?Rodrigo_Exterck=C3=B6tter_Tj=C3=A4der?= 
        <rodrigo@tjader.xyz>
Date:   Wed, 26 Sep 2018 12:14:15 -0300
Message-ID: <CAG7TQgFEqH6k0GAPA3yqKDQbtA=n9Qiw0-rq-aNNVZ5L6+Unhw@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: allwinner: Olimex A64-OLinuXino: fix ethernet
To:     maxime.ripard@bootlin.com
Cc:     wens@csie.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 6:46 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> There's no need to be so specific though :)
>
> Something like that would work:
>
> arm64: dts: allwinner: a64-olinuxino: set the PHY TX delay
>
> The PHY found on the A64-Olinuxino requires a TX delay in order to
> operate properly. Olimex uses a 600ps second delay in their BSP, and
> that has been found to work, so let's use that value in the current
> DT.

Should I go ahead and send a v2 with that commit message then?
