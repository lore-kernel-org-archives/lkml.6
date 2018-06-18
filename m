Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08605C5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 19:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A62482075A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 19:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Tw92OFaS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a638L2ic"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A62482075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936852AbeFRTyL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 15:54:11 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:39150 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935923AbeFRTyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 15:54:09 -0400
Received: by mail-ua0-f193.google.com with SMTP id n4-v6so11497932uad.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 12:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=fc7LexULpLHjtP2f2ChwGyh0HQOEZEoqBECfn68kBo0=;
        b=Tw92OFaSP0H0z/GY1lW9JAFAjyOhnE1dGm17JaLyZpFybal5lwTVDIFo49jsgYPfku
         GhYYig4qVWYq/rxQ8tLzaTEG6vpDOtTfX33UBDQ9JbfloY82Eu3BA52YiSV+NCFNFNXI
         0ntRu5MaYTMgYJKAZq9BI7xD8yD7YdSh0P9+YbOBxY/3N/CczXT4Uab41aNsAF5KI97l
         yipjOGJO/hCQPOAdPLaE4Shazqf6WCWcaJBzudrC1Vweya4UyaIAGigeuIldk9Z00W2p
         JrEB8aKwXwihYnkMwRNeCa5pgfv17U/ps2ayX2UrZ58HopwiLBMVj7VGz6xjGSVuhxkW
         LsYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=fc7LexULpLHjtP2f2ChwGyh0HQOEZEoqBECfn68kBo0=;
        b=a638L2ic4xvCyp58tkJ8Rd7XXjGTPvUsrsKjPklAq6lVFiXpdexSrLnovMB0pRq4oY
         PfRu0IxrIQif8DWV0KRiLVu3hqxdjiuR2/ZEm4RVc4FSE9pPNx5E9nBCMcAlGL4BTykh
         HmUS5e2iPkD4+GaubhWbWyJifCzO3oMQGna78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=fc7LexULpLHjtP2f2ChwGyh0HQOEZEoqBECfn68kBo0=;
        b=WL/rmk8lVl/CDJpFrPaZCxGKpHe8Jim9UuFdXBrjPOnlsJOLOM5dUmsPQHBMEGwhe/
         yL7OazXGF8oe28xD7GLH6ALvXlk05OLc98YfjM3T/NXVeO38pdayMOkMa9HK5vdmIVrx
         vMCLQfUNg+RkHUoJEx3QuGP9MoBV09+qxuToKius46pWFcUGAAPwwad8tkxHG63tS3Xr
         dtHQuQnhCwzS6XAxja0GicAEDs7eugNGUgFq7ru99hX8OGM5uXdrt/vpn0DG5kj1HgkM
         Q62SYp9yRDJcDmCH4iN/xyLOYbRTmpAcLs7QVT0TrsZh+Iq7xl94Y3xqT8CpBYXfFstq
         0Chw==
X-Gm-Message-State: APt69E0yrar69KzKiLDnrHBe8/Gzw3fCeGT8R/CS80HBjhSdGydGwCxB
        HRKY+MVC2tdEnvbU8H6CuNYYxTqa5++RnPheSQUxug==
X-Google-Smtp-Source: ADUXVKLO7UP73GaY95yDvkq+y4YiqBXhNSjH65IZu+N0z2UZh8l9KUdaxMK+Ko3p6sAL50MmJplznQeFAgTEsMnL4FI=
X-Received: by 2002:ab0:2015:: with SMTP id v21-v6mr8738548uak.46.1529351648113;
 Mon, 18 Jun 2018 12:54:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:9495:0:0:0:0:0 with HTTP; Mon, 18 Jun 2018 12:54:07
 -0700 (PDT)
In-Reply-To: <20180618190637.GG21724@codeaurora.org>
References: <1529329040-2606-1-git-send-email-rplsssn@codeaurora.org>
 <1529329040-2606-5-git-send-email-rplsssn@codeaurora.org> <20180618163945.GE21724@codeaurora.org>
 <CAD=FV=W_tKb2n2x9AY4T_17Q_KJcu9wsfFv4vio08W76t0d00A@mail.gmail.com> <20180618190637.GG21724@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 18 Jun 2018 12:54:07 -0700
X-Google-Sender-Auth: R7Jlcvs4PEXO0b9Ez3wB6iO4Aec
Message-ID: <CAD=FV=VVLGR-ynvURvQB2yU5HNb0-Z5e-1_McJ1Wu5PFpJ72Yg@mail.gmail.com>
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

Hi,

On Mon, Jun 18, 2018 at 12:06 PM, Lina Iyer <ilina@codeaurora.org> wrote:
> On Mon, Jun 18 2018 at 12:33 -0600, Doug Anderson wrote:
>>
>> Lina,
>>
>> On Mon, Jun 18, 2018 at 9:39 AM, Lina Iyer <ilina@codeaurora.org> wrote:
>>>>
>>>> +/**
>>>>  * struct rsc_drv: the Direct Resource Voter (DRV) of the
>>>>  * Resource State Coordinator controller (RSC)
>>>>  *
>>>> @@ -52,6 +78,7 @@ struct tcs_group {
>>>>  * @tcs:        TCS groups
>>>>  * @tcs_in_use: s/w state of the TCS
>>>>  * @lock:       synchronize state of the controller
>>>> + * @ctrl:       controller to handle cases like batch requests
>>>
>>>
>>> This is not only for batch requests.
>>> This is handle to the DRV's client. @client might be a better name than
>>> @ctrlr.
>>
>>
>> The name "ctrlr" also matches the name of the structure.  Are you
>> suggesting also renaming "struct rpmh_ctrlr" to "struct rpmh_client",
>> or you think they should be different names?
>>
> Just the name of the variable. I was just a nice to have. I wouldn't
> block for this though.
>
> I also got a couple Bot reported issues on this and the previous
> revision that I have sent to Raju. He is planning to the post the v12
> tomorrow his time after fixing them. If you can wait until then, I would
> recommend picking up the v12 instead of this.

OK, if Raju can post the v12 tomorrow his time then that sounds like a
great plan to me.  While you're at it, I noticed that checkpatch
yelled about a few lines that were > 80 characters long for no good
reason.  Those would be nice to fix too.

-Doug
