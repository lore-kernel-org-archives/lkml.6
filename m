Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD3B7C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 13:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6931920C0A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 13:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RoUz13x4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6931920C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729369AbeJAUVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 16:21:42 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:45308 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729289AbeJAUVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 16:21:41 -0400
Received: by mail-io1-f66.google.com with SMTP id e12-v6so9380644iok.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 06:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pGlkwmjfzHbZyX21EsofoTjiqbi4kJWg5ee3EVtewwI=;
        b=RoUz13x4hSrTTxLjRD9GucRRrjgcD72AT0uaOx4qmdTdVG8ARdR4i1TGu+rGgAOV1M
         s5xil6WhCrPR134w6RP5ZEMj7rIXZPaS67jKNRmaPjLzx/69egdzCYMpea5zX1rUqSVX
         +UPPBMgtJIiYhNnHQMhMgQmV8oL/B9VSHWdgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pGlkwmjfzHbZyX21EsofoTjiqbi4kJWg5ee3EVtewwI=;
        b=RhvCvAyfG+TMiP5oidpwYNCBITcVTEfBtH6/KhAJVToAGhDlXE5I6JbiQ9kmq6Rfcb
         L3QTa+JxOw+n0QK3UDoNDCZjAXFED0Rgnry2u57LWLUZc//R+oZFn0NGCVxmqq0BvNoV
         e5Z3+/05Plj7bRfJncXH2nXt2yE3G2NhzF0txgVfph9Z8wMMPtjiN6OjNOvnWu7s6K8h
         OQFNrTQtiv+YInJeM1qnqNBA2lb8cKUtYtWM8gcButyhjaucd+yitgznYciKLTiSC51c
         zby387snW/KzEU3cfjFLMK0WpOAae3h3drVP3kYeWLCTInaXE596i4onhqqRpId8jwZI
         S8ig==
X-Gm-Message-State: ABuFfoisyFEH2c9WqdLXN/bUB6f472BoixpCQ8vUkcOwSZ76GxigrrnN
        rC4p2HOUMzKJlFrXVeFqyIIUZWKKMSINHjZaZFI1FQ==
X-Google-Smtp-Source: ACcGV60PU7h7eNBzGW5gNjcwdoHHApcf2jDj6YOK1OKglfiVBj+KOCIA5WlQ/5n0df2+g3J6MA4AL3o+qZHzItF1c8E=
X-Received: by 2002:a6b:9cc8:: with SMTP id f191-v6mr7388234ioe.266.1538401428380;
 Mon, 01 Oct 2018 06:43:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:3941:0:0:0:0:0 with HTTP; Mon, 1 Oct 2018 06:43:07 -0700 (PDT)
In-Reply-To: <a956549b-a84e-2582-1fce-3b15495f208c@st.com>
References: <1537523181-14578-1-git-send-email-ludovic.Barre@st.com>
 <1537523181-14578-24-git-send-email-ludovic.Barre@st.com> <CAPDyKFqxBuQcafS2KFqPDwb4=V1Jwoovb4+VsJZjAA5CeKs2kw@mail.gmail.com>
 <a956549b-a84e-2582-1fce-3b15495f208c@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 1 Oct 2018 15:43:07 +0200
Message-ID: <CAPDyKFpeifgeZcB45WE+nbRtOrGk+h0BqbNZgM2ivJiELkXJhQ@mail.gmail.com>
Subject: Re: [PATCH V2 23/27] mmc: mmci: add variant property to request a reset
To:     Ludovic BARRE <ludovic.barre@st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Gerald Baeza <gerald.baeza@st.com>,
        Loic Pallardy <loic.pallardy@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

>>> @@ -1854,6 +1855,14 @@ static int mmci_probe(struct amba_device *dev,
>>>
>>>          dev_dbg(mmc_dev(mmc), "clocking block at %u Hz\n", mmc->f_max);
>>>
>>> +       if (variant->reset) {
>>> +               host->rst = devm_reset_control_get_exclusive(&dev->dev,
>>> NULL);
>>
>>
>> As suggested, let's make this optional and not depending on the variant.
>
>
> I done like that because is required for my variant (if no reset, no power
> cycle for sdmmc).

The point is, I think don't think it's correct to ties this to the
variant, but rather I think it depends on the behavior of the SoC.

>
> If you prefer, I could move to optional with
> "devm_reset_control_get_optional_exclusive"
> And I add a comment in mmci dt binding to specify that not optional
> for sdmmc. (see above)

Alright, fair enough. Let' do that.

[...]

Kind regards
Uffe
