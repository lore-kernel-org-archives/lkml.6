Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 436A4C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 18:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0DC32083D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 18:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="BtHWYrpw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gu7dtIRh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0DC32083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935966AbeFRSdf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 14:33:35 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:33553 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935836AbeFRSdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 14:33:33 -0400
Received: by mail-vk0-f68.google.com with SMTP id 200-v6so10160113vkc.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 11:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=I/jcJeZSPL5FTa3ECB1UzVCgyWpDiwY3LYFj3F7x9B0=;
        b=BtHWYrpwhZyHtO786mdKJKoEtwE7dF7fIfzivdA25TcGoHO17yhexk5LhygMwpuc6D
         mqLNE/Q1tGoK0Yb6KCySAframiptYukZaV0zwxE11tzxjMt2nkGcACGXM7CT5tSgWKtc
         eK0ZnjKOf3PX9xJUf1nyBAwWZibZJeL+EZzCcZwH3SD3ru9vf0baz5IA2AaEb0QEfV7R
         R94mB+g/VHpg53lhVklptHUxEnYh03lWnYV3gJcRHy9pq8iy60Ga2wzah8EIXatbU0I+
         zQfXvNYcE1HaKjSNy6HDSw3ahb517lt2iFPSxzCwlEOp1Z92zkT21kEx6B2y0+lzAYjI
         l3Aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=I/jcJeZSPL5FTa3ECB1UzVCgyWpDiwY3LYFj3F7x9B0=;
        b=gu7dtIRhv1gx4hD/VQaSLzdnsT/ckVAQ3KZZnYvDR5dEt7ohSbsLyC6pfdRTsBNBqv
         52UywivX9k4njnmNELfbjsUlTKrCEAzlDXS08C/nC0o0VtNJmc40eDzWJgg4Ac096mvR
         +2HAyL6oAgFci5tgcTKtI5mBtr0Eap6OxqqKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=I/jcJeZSPL5FTa3ECB1UzVCgyWpDiwY3LYFj3F7x9B0=;
        b=dUYrtE2XeOMZk6oMXbuV0an68aeFh+BvoKtNqRjmqB8ssjsOgTIRtR90YPihVznRAi
         U1ypEyGV1gLjXXKF7yAxCojH2V8ObEty7E9eZs6r3XHWhiX47jejFFMIQrcU/YuDcK4m
         /sJ8HQoCPUK6uYQaTpR+sTByIOL4NYxImosayvGp1Wvw+x5Alb6tyNWKtA+11MxbhoJn
         TcHNhHgPOmKJwPjf1irFAt5oa9BmG7PaOVqHe1Thr9WX/o33e3HnmXU0N/SfWhYTDrpi
         MXJyf8uYmMERB6+bMj5QqG1xPeZDFixXft5+POJ6SQwDONqW7ShS9CyrVXwUXEOFnJZk
         l5ew==
X-Gm-Message-State: APt69E3OQDRx4tilHWR12d4ht9LcYhMpqCf0GkaT0YSRDJj4SIo30ODs
        +f3hINPYvQepRvwBlqbi2Xosr6Gy6XY5VH4ryAbdQA==
X-Google-Smtp-Source: ADUXVKI5bTGP8GFwKDvT6yVY2L4FExP1WY/GFO8i9VW1p2tMOLfRzNTKNR4yQHPZqM3X+3GEmXCHI3kGqSyvlepAiI4=
X-Received: by 2002:a1f:fc02:: with SMTP id a2-v6mr7760708vki.141.1529346811946;
 Mon, 18 Jun 2018 11:33:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:9495:0:0:0:0:0 with HTTP; Mon, 18 Jun 2018 11:33:31
 -0700 (PDT)
In-Reply-To: <20180618163945.GE21724@codeaurora.org>
References: <1529329040-2606-1-git-send-email-rplsssn@codeaurora.org>
 <1529329040-2606-5-git-send-email-rplsssn@codeaurora.org> <20180618163945.GE21724@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 18 Jun 2018 11:33:31 -0700
X-Google-Sender-Auth: a9-u-2zH88zXVFXbqk_MXnDIqwg
Message-ID: <CAD=FV=W_tKb2n2x9AY4T_17Q_KJcu9wsfFv4vio08W76t0d00A@mail.gmail.com>
Subject: Re: [PATCH v11 04/10] drivers: qcom: rpmh: add RPMH helper functions
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     Raju P L S S S N <rplsssn@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lina,

On Mon, Jun 18, 2018 at 9:39 AM, Lina Iyer <ilina@codeaurora.org> wrote:
>> +/**
>>  * struct rsc_drv: the Direct Resource Voter (DRV) of the
>>  * Resource State Coordinator controller (RSC)
>>  *
>> @@ -52,6 +78,7 @@ struct tcs_group {
>>  * @tcs:        TCS groups
>>  * @tcs_in_use: s/w state of the TCS
>>  * @lock:       synchronize state of the controller
>> + * @ctrl:       controller to handle cases like batch requests
>
> This is not only for batch requests.
> This is handle to the DRV's client. @client might be a better name than
> @ctrlr.

The name "ctrlr" also matches the name of the structure.  Are you
suggesting also renaming "struct rpmh_ctrlr" to "struct rpmh_client",
or you think they should be different names?

I'm advocating that we should land this patch series to unblock
everything.  Hopefully you agree that's OK and if we want to change
the name of this we can do it in a future patch.  Let me know if you
disagree.  ...if others agree that the series should land and you
really want the name change, I'm happy to post up a version of the
series with the fix to help move things along...


-Doug
