Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDB0C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81A782152E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9Jt5KA/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81A782152E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbeIZWoe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 18:44:34 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37846 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727285AbeIZWod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 18:44:33 -0400
Received: by mail-wm1-f66.google.com with SMTP id y26-v6so2448041wma.2;
        Wed, 26 Sep 2018 09:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=mw29pwm0WNjmx9GSwGM9eCTRwypSc3fh4MQ4KknLuXQ=;
        b=X9Jt5KA/fOuULileVefGfTzNJjJiXSU7Kq03Z5ffFu5TGs4kxzeEMw2ish9MpXM6rl
         Pf3q3CeZHNFYiOgRS3sLnOAOD4X+mhmgffBo4L6aEem/91+giyUTCM26lHbiNRYabIv5
         6+u26mZRHX7iJkmJPKuhJBJqRVbPIQ/EwYmD54Nw7rQTMikWirY1ZIlmm8AIx6g0U8IA
         BY2+6c9rP1gZ6V+QF5ic3WwypdEPIVaqBc2EyVPESvwU329Y+VUn1GI/xxWslXBM/Ktt
         5LbQvEAI/Hibtqgfq1QMvJuNd1m90G1qB2lft4paJ95zaThjEvAFlbPrBdXnWWzBnLqi
         u3pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=mw29pwm0WNjmx9GSwGM9eCTRwypSc3fh4MQ4KknLuXQ=;
        b=XxJz1Nc8iLD/6+4iY3/uteKJXEq749VLMYP0hUHjihjGlSYcw1hR1fsEugyiAA+JMo
         R0o/3SXsiTLywSAD9BbbYUEOPiomqzOd9x+k7AnHnPFXP7vYZDeOqLdqvSv1D80MrSsV
         ezYPOvAkBueqaedk8QQfFdjnxbalCQGwND1jK7fBPwIDt0qJebgUf9vfzOAof06cMmxB
         S9XyUTCpdWlp6fBs0I2ovyaUAtdRMDwzEB503TNl4YWNbemsfhX8yNeHUmdqNEB2LXLZ
         kJQMYW4PyT2vu1q/e3jq6PH6rsGwvyh1E7jj3ryi4bOObxo/5z7nYTXDz6l8Ync58VJV
         Cefw==
X-Gm-Message-State: ABuFfog85+UjcZXZB8MwwZLEwTRenEmwoKKkXUuXUai6rsLY6N3NPS7x
        u2v93ok73iewC9wmc7Iw9A==
X-Google-Smtp-Source: ACcGV604GF2gx96anMLKzrFhJNx6qdJI7zb/po6tLJJm2SYmw6pNA8UeZb5mrw3+kTprmCNWEsAoIQ==
X-Received: by 2002:a1c:1943:: with SMTP id 64-v6mr4638072wmz.89.1537979447294;
        Wed, 26 Sep 2018 09:30:47 -0700 (PDT)
Received: from android-dhcp-8-1-0-d4-38-9c-a2-1f-05.home (host86-147-9-252.range86-147.btcentralplus.com. [86.147.9.252])
        by smtp.gmail.com with ESMTPSA id a1-v6sm6292404wrt.9.2018.09.26.09.30.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 09:30:46 -0700 (PDT)
Date:   Wed, 26 Sep 2018 17:30:43 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <CACRpkda4SuPVz8Awg6OhhanmZKEs4URw3WBMv0Fa8iJa2MD-KA@mail.gmail.com>
References: <20180812142413.20856-1-ctatlor97@gmail.com> <20180925173801.3835-1-ctatlor97@gmail.com> <CACRpkda4SuPVz8Awg6OhhanmZKEs4URw3WBMv0Fa8iJa2MD-KA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 1/2] pinctrl: qcom: Add sdm660 pinctrl driver
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     linux-arm-msm@vger.kernel.org, neeraju@codeaurora.org,
        vabbar@codeaurora.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Craig <ctatlor97@gmail.com>
Message-ID: <43F103C6-7ADF-4D4C-A930-376D66F538F0@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,
You seem to have missed the bindings, it might be an idea to drop and reap=
ply with the new ones I just sent off when they get a review=2E

On 26 September 2018 07:57:41 BST, Linus Walleij <linus=2Ewalleij@linaro=
=2Eorg> wrote:
>On Tue, Sep 25, 2018 at 7:38 PM Craig Tatlor <ctatlor97@gmail=2Ecom>
>wrote:
>
>> From: Neeraj Upadhyay <neeraju@codeaurora=2Eorg>
>>
>> Add initial pinctrl driver to support pin configuration with
>> pinctrl framework for sdm660=2E
>> Based off CAF implementation=2E
>>
>> Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora=2Eorg>
>> Co-Developed-by: Venkatesh Yadav Abbarapu <vabbar@codeaurora=2Eorg>
>> Signed-off-by: Venkatesh Yadav Abbarapu <vabbar@codeaurora=2Eorg>
>> [craig: minor updates for upstreaming, updated tile handling]
>> Signed-off-by: Craig Tatlor <ctatlor97@gmail=2Ecom>
>
>Co-Developed-by? That was innovative=2E
>
>Anyways, since there is also a signoff all is fine=2E
>
>Patch applied with Bj=C3=B6rn's ACK=2E
>
>Yours,
>Linus Walleij

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
