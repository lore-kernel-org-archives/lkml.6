Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF569C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 07:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C43F205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 07:58:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C43F205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbeKARAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 13:00:24 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46325 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727704AbeKARAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 13:00:23 -0400
Received: by mail-ed1-f68.google.com with SMTP id f8-v6so3471972edt.13;
        Thu, 01 Nov 2018 00:58:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MUV3OWQzBRs+Rfb55yoiC4Pom0da7pcMUAJW0kZkg0g=;
        b=CfkSokPi8/J5ofMr+zJsulhlu1MP0eZKYaEQpxeIvpRUVOA67rlSR2nas7O1kFaJDe
         +v2101MWxQXM1+nYoEGy36U+LDR6seXsYcIooLlhfOSo/tx1yR3L2eIBAFK80wowyGSP
         CwzUus+WA+2VHrX8feNUKwMi4KJUeewGpOQWeqmCVJt0lrLwY4kmx+t63lbijCEoyF58
         kFcNE1tnRIrmVnB4sepDxNyUEiY1AJSZChjBTXGH1y9e48P1cpiDNYdhXYC9AZxAq3Xy
         OsjyPXLM4OqiZ1m7/oA1HG9ptr4YdVZ2qikwWIwCD17Ce77m6+O/M5NAAphvRZ+eF5JN
         zJcA==
X-Gm-Message-State: AGRZ1gKKBFz4dNrEfou+EA6FOKatyQWVnUeAQ+UfhDijpXKzvKz/tXVr
        1Qlm6Orhpau7LS6XmXOsDkLoGllik+c=
X-Google-Smtp-Source: AJdET5dkFVfTO4nUg7y4LMRNxAU+N1mAeuV4TvpVHyCm76n1/cvsIbB3LhzNte8jpiB33+LQ5cJ1Vg==
X-Received: by 2002:a50:e00e:: with SMTP id e14-v6mr4593164edl.152.1541059107798;
        Thu, 01 Nov 2018 00:58:27 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id n12-v6sm4453222ejl.29.2018.11.01.00.58.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 00:58:27 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id 74-v6so10932643wrb.13;
        Thu, 01 Nov 2018 00:58:27 -0700 (PDT)
X-Received: by 2002:adf:f9d2:: with SMTP id w18-v6mr5699930wrr.134.1541059106632;
 Thu, 01 Nov 2018 00:58:26 -0700 (PDT)
MIME-Version: 1.0
References: <20181031183634.29640-1-jagan@amarulasolutions.com>
 <20181031183634.29640-7-jagan@amarulasolutions.com> <CAMty3ZCeZzXYy4XRwTeQjYfpB6KKjEVRWyhjoca9Os4foLYL4g@mail.gmail.com>
In-Reply-To: <CAMty3ZCeZzXYy4XRwTeQjYfpB6KKjEVRWyhjoca9Os4foLYL4g@mail.gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 1 Nov 2018 15:58:13 +0800
X-Gmail-Original-Message-ID: <CAGb2v67xCnH20Hga2P2Ekk3vhhOWUSgtOmRVAte+HDuodjsjkw@mail.gmail.com>
Message-ID: <CAGb2v67xCnH20Hga2P2Ekk3vhhOWUSgtOmRVAte+HDuodjsjkw@mail.gmail.com>
Subject: Re: [RFC PATCH 7/7] arm64: allwinner: h6: orangepi-liet2: Enable
 AP6356S WiFi support
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi@googlegroups.com, Jagan Teki <jagan@openedev.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 1, 2018 at 3:35 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> On Thu, Nov 1, 2018 at 12:07 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
> >
> > From: Jagan Teki <jagan@openedev.com>
> >
> > Enable AP6356S WiFi/BT combo chip on Orangepi Lite2 board:
> > - WiFi SDIO interface is connected to MMC1
> > - WiFi WL-PMU-EN pin connected to gpio PM3: attach to mmc-pwrseq
> > - WiFi WL-WAKE-AP pin connected to gpio PM0
> > - 32kHz external oscillator gate clock from RTC

You never specified a clock rate for it, so it might actually be wrong.
The default clock rate would be something "around" 32 kHz, but not very
accurate. Meanwhile the WiFi module would have very specific requirements
on frequency and accuracy of this clock. The WiFi part doesn't seem to
care that much, but the Bluetooth part cares very much. It doesn't work
or it would seem to work but you don't get anything off the radio if the
frequency is off (as in off-frequency).

> >
> > Signed-off-by: Jagan Teki <jagan@openedev.com>
> > ---
> > Note:
> > - chip detected, but failed to connect
> > [  129.084504] brcmfmac: brcmf_sdio_hostmail: mailbox indicates firmware halted
> > [  135.906409] brcmfmac: brcmf_sdio_bus_rxctl: resumed on timeout
>
> This got fixed. Will send next version.

Could you wait until I get my RTC changes out? I also have some Bluetooth
patches for AP621x, which is what started all this RTC work, which you might
find interesting.

ChenYu
