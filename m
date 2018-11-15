Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77218C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 10:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37A8B20854
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 10:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="e8h9k6X+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37A8B20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387724AbeKOUW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 15:22:57 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45341 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728699AbeKOUW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 15:22:57 -0500
Received: by mail-lj1-f193.google.com with SMTP id s5-v6so16764313ljd.12
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 02:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hbKXfHU7twiZ4fvzU2sgu0UvCEZC+VrhtPjd3SJH4BM=;
        b=e8h9k6X+AV1a81FCj8m5Q5fBa28trhund/CK/pACQmv9QdMfMzURIUWOshurUyvAe4
         4Mgos1c3U1y+yJitZMbRp+CLorHZoPo3nh3e6Cm3hLMPxWXzs+PlXAMtr9chaRkDi96I
         /tCx2VIqCzP9/pkR47gi0WG6gl+2IcmSnfoEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hbKXfHU7twiZ4fvzU2sgu0UvCEZC+VrhtPjd3SJH4BM=;
        b=IZhtNAuylwLWsgC2cn7y2NB8Ydsvjy6kNXhK9rP9dGQx38UrDFq+hocx+HGm7u7wYh
         /JvCoa/VSbFDcxpsT4iYjp3ejkeELLPDcPlMPYFBXqQdYA1lFtUsD9g7ODFOD5mFR3oJ
         5xaOR9AKsqFLF4AnWVledBpgd6nbRoqfdgAncfR6nsC/nSuUgmYTjBQA1ArJGzFPJ/zN
         7Q6CyTFO3EeUdocuXSeCaFljA6PeCdz7AM9W78SCzDeXyPzSc3YFbNRQ+eThTCbllqOd
         NPTxaHxyPV9KCCuG/XNPV5Sx1bzZZ9UinGATdOEYfJkWWaDdMLS/4NLMxbNBa0nnjFSG
         BWUg==
X-Gm-Message-State: AGRZ1gICVO5N/UKrXNU1evhs1BDtWEH9UXScd/BppHrw0ig57o2ZgTTS
        ZsBLDC9pfmnx5owwnr3CnnwpkYDhSyEV4L8HJ8gUaA==
X-Google-Smtp-Source: AJdET5d2WK8dglHrqPo9Decf7dCtdQw5KLrUCLKXl280n3Y4FhNhrrmkV5oDNzFXmcqSiBTWFXj1+juf/bl71GE47zw=
X-Received: by 2002:a2e:710a:: with SMTP id m10-v6mr662734ljc.66.1542276943449;
 Thu, 15 Nov 2018 02:15:43 -0800 (PST)
MIME-Version: 1.0
References: <20181107134434.354795-1-tmaimon77@gmail.com> <20181107134434.354795-2-tmaimon77@gmail.com>
In-Reply-To: <20181107134434.354795-2-tmaimon77@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 15 Nov 2018 11:15:31 +0100
Message-ID: <CACRpkdYo_4Be=N-ewRBMCP=KAs4DeXW4r-qQerx2UAvsyS=-fQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] pinctrl: nuvoton: modify NPCM7xx pin configuration function
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     Nancy Yuen <yuenn@google.com>,
        Patrick Venture <venture@google.com>, benjaminfair@google.com,
        Brendan Higgins <brendanhiggins@google.com>,
        avifishman70@gmail.com, Joel Stanley <joel@jms.id.au>,
        Kun Yi <kunyi@google.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 7, 2018 at 2:44 PM Tomer Maimon <tmaimon77@gmail.com> wrote:

> Modify GPIO direction setting in pin configuration function by using
> generic GPIO functions to set the GPIO direction instead of direct
> access to the GPIO direction register.
>
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>

Patch applied with Kun Yi's tested-by tag!

Yours,
Linus Walleij
