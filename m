Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5CF6C6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 11:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7565B21939
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 11:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nr1iwa6c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7565B21939
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754180AbeGGL3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 07:29:20 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:33614 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753605AbeGGL3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 07:29:19 -0400
Received: by mail-oi0-f65.google.com with SMTP id c6-v6so28162808oiy.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jul 2018 04:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DLGNzRhql2zKUgJwW4UadonGhfa7XgG+px0HZl+OeLg=;
        b=Nr1iwa6cVZ1I1vSNrQSyseXdGIVE7Ws7+Z7aWyCyHSXNfoKeuAR5xbWo33nJnXwAb8
         X3bpuZjCGVRoWsiH3yuQVxXTNjlDMOjYZfa4CsMLlnemaSmuo6FBtYODGhuBwBxt0IF7
         jUp6nCEUsUSihiVsFONUzWN8zLFJB3O9bHNuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DLGNzRhql2zKUgJwW4UadonGhfa7XgG+px0HZl+OeLg=;
        b=De5DOjP10e0owyU+b1s8FV+ZGEPWYXPAVvlC4zL8UiVZ3MmsCbTGdYfwRZhsa+yem5
         wClVIc7Tpvp+bSVi7S5U5zS7OIccjvvqEoyF12g6PWKVRoItJezG/3YMX0iWjyhWvgG/
         2BIHWivPgTIDSGcBQaH+bYS1X1h1xrxfwMWDlZyLpMOpBh/0gHjkSFs+0HvrkrR7jzRH
         PjtHMU6EWXxokJilKy/pd3xS98W2cF2JvCQO9IMudSs/SrTVWhK5WONA+GAtRrLMUXRT
         84BOaodq627mGHbS0XDWspP3AVJ9NfDY6QAqKswjlhW2vH+pB7H52g4257k01BJNNka5
         tiVA==
X-Gm-Message-State: APt69E3u9UZfiBMaSARmuqxSoiV8rlC8643e0bIJKOxZuWN0Ceja0oBr
        FcPg6sQClIdMo20mzxZhBFKM5UotM2WqqFq1m25q5A==
X-Google-Smtp-Source: AAOMgpduXmDn3PEYDa+e9dRCB3mIW7B/N+NlE5eV1anq1Ja0ToG2GVggCS+yeh20816a27KWRckQbTvGL4TcrVPpCYs=
X-Received: by 2002:aca:f401:: with SMTP id s1-v6mr16369479oih.269.1530962958899;
 Sat, 07 Jul 2018 04:29:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:192d:0:0:0:0:0 with HTTP; Sat, 7 Jul 2018 04:29:18 -0700 (PDT)
In-Reply-To: <s5hpo00quk4.wl-tiwai@suse.de>
References: <20180706130703.22352-1-benjamin.gaignard@st.com> <s5hpo00quk4.wl-tiwai@suse.de>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Sat, 7 Jul 2018 13:29:18 +0200
Message-ID: <CA+M3ks7QL6t+HLHAiW3T8hDFDNyR494y4dM20jc8YXJ7-Xbd_g@mail.gmail.com>
Subject: Re: [PATCH] sound: stm32: replace "%p" with "%pK"
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        alsa-devel@alsa-project.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-06 16:59 GMT+02:00 Takashi Iwai <tiwai@suse.de>:
> On Fri, 06 Jul 2018 15:07:03 +0200,
> Benjamin Gaignard wrote:
>>
>> The format specifier "%p" can leak kernel addresses.
>> Use "%pK" instead.
>>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
>
> The code change itself is OK (apart from the subject prefix to be
> "ASoC").  But do we really want to patch manually every single place
> like this?  There are thousands of files using '%p'.

I have limited myself to the few remaining %p in STM32 architecture.

>
>
> thanks,
>
> Takashi
