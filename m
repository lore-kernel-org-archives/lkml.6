Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57EBAECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D70B20673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="R4qh4GxC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D70B20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731911AbeGSPgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 11:36:38 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:33392 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731110AbeGSPgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 11:36:37 -0400
Received: by mail-it0-f67.google.com with SMTP id y124-v6so2507349itc.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 07:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:organization:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=ITu2WOnlCFrr/u5dwJQohcStZxJypdiEUIhd4p8u90w=;
        b=R4qh4GxC9t5uQJp5XvVDJcPSExIjwj0cMqM8s4QrSS/c8/g79ZTtGTlNdzJXCnEjDg
         R3e+8v23uNNd64fjRr/W71IA9dYTpuEgxcxuDpHrgEqpOijL8puDxg00s0JTiAptQfYL
         pX5P+nWHWLSKNnUpAEAWkq6HNpE/SU2I9ULRAxrGS8qZrNqPPMmqV2e1rlahMX+BVY77
         loYai3AFpyP8i0Gmy7CI5fpNfw5s1YdF0A+YmXKdkmHmsU+mc5qEWDEIyfogIsQ6sYDP
         1vntO/s95/javR3Fnj+qg3DLiUc/eWwKYBMJbILuHXz8MYnnC0U4hcWbD7miVriGrDCy
         8JRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:organization:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ITu2WOnlCFrr/u5dwJQohcStZxJypdiEUIhd4p8u90w=;
        b=h0xUOorJXi00EKkWKQd52fY793WsTnW2HO4E0mGn/vjGE/PoEdeolEQj3rY+hJk9aD
         j6wst3JgioZYUFYL1diaRWnG7C/uJquDfF52VyKQCJPb9nruWXQ9oeZ4sCS+8zJnMAjq
         aGRHZU9/N508Xh831R1mmbO5GPUuvcU5iGL5ArAqGFXXN9ZPMeX/LUtRBhMt4ObJm4rh
         IU4suqEh2UZW+fLhrXUgpiXEA691ehIS1ivusbx9QhzQUpG5qa8EVzK/h8/Bz+UHM106
         JE9prNqM+j1Ypal9FhSFDm+EDkWCh8fkFPagV8sCoB+RxWra7Kd+4us42u0ngkmWhu5a
         D4JA==
X-Gm-Message-State: AOUpUlEgqyBm4A8nxnhdLNnJUJ2h4eNoRWQa70bQWDY33HTWvUPAV84V
        YvAV93XSj2y/Ktv92bk993mrEg==
X-Google-Smtp-Source: AAOMgpfJTAfkFo97gCREwOCTmIZ9n++akTRsqp4HNMcqimD3IFiZNRmpFc7f4Xn/M4VvzBGs9vHPog==
X-Received: by 2002:a02:2b12:: with SMTP id h18-v6mr9879790jaa.10.1532011984985;
        Thu, 19 Jul 2018 07:53:04 -0700 (PDT)
Received: from localhost ([2604:2d80:4413:8125:59cb:8e52:e49b:158f])
        by smtp.googlemail.com with ESMTPSA id i74-v6sm3151531itb.21.2018.07.19.07.53.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Jul 2018 07:53:04 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Yixun Lan <yixun.lan@amlogic.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, <qianggui.song@amlogic.com>,
        Rob Herring <robh@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <mturquette@baylibre.com>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <bo.yang@amlogic.com>,
        <sboyd@kernel.org>, <jian.hu@amlogic.com>,
        <xingyu.chen@amlogic.com>, <qiufang.dai@amlogic.com>,
        <linux-amlogic@lists.infradead.org>, <sunny.luo@amlogic.com>,
        <carlo@caione.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 3/3] clk: meson-g12a: Add EE Clock controller driver
Organization: BayLibre
References: <1531134767-29927-1-git-send-email-jian.hu@amlogic.com>
        <1531134767-29927-4-git-send-email-jian.hu@amlogic.com>
        <CAFBinCBB9N_p6S_-dfiV=zDCf-RYnA3C-ir6oNLC7JAfdOqqiw@mail.gmail.com>
        <ec49c089-bccf-9aac-5d0f-43bc27770ad9@amlogic.com>
        <1531216472.2708.71.camel@baylibre.com> <7hfu0jmhbe.fsf@baylibre.com>
        <7e1cce0b-fc86-b900-2019-a85c5e5ba2ae@amlogic.com>
        <7h601be2vk.fsf@baylibre.com>
        <e1f0b672-65de-6afa-cec4-e2d910c58b7c@amlogic.com>
Date:   Thu, 19 Jul 2018 09:53:03 -0500
In-Reply-To: <e1f0b672-65de-6afa-cec4-e2d910c58b7c@amlogic.com> (Yixun Lan's
        message of "Thu, 19 Jul 2018 22:27:55 +0800")
Message-ID: <7hk1prmg4w.fsf@baylibre.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yixun Lan <yixun.lan@amlogic.com> writes:

> On 07/19/2018 10:06 PM, Kevin Hilman wrote:
>> Yixun Lan <yixun.lan@amlogic.com> writes:
>> 
>> [...]
>> 
>>>>
>>>> As Jerome said, I think consistency is an important goal, so leaving off
>>>> the "meson-" for drivers/clk is fine with me.
>>>>
>>> ok
>>>
>>>> Also for consistency, for the rest of the drivers, keeping "meson-" is
>>>> probably the right thing to do.
>>>>
>>> ok, for the above, you are talking about the already exist compatible
>>> names? or the patches we will push in the future?
>> 
>> I'm talking about future patches.
>> 
> ok
>
>>>> However, patches would be welcome to add compatibles without the "meson"
>>>> for the rest of the drivers & documentation as well, but please do not
>>>> remove any compatibles.
>>>>
>>> I assume you are talking about the patches in the future we will push?
>>> to drop the "meson".
>>>
>>> I'm confused here, as the above two paragraphs conflict with each other
>> 
>> Yeah, what I wrote is confusing, sorry about that.
>> 
>> What I mean is that new patches should stay consistent with compatibles
>> in their existing drivers/subsystems.  That means keeping the "meson-"
>> prefix for everything except drivers/clk.
>> 
> sounds good to me.
>
>> In addition to that, patches would be welcome for *adding* compatibles
>> without "meson" to all the current drivers.
>> 
> not sure if I parse above correctly, so let me rephrase..
>
> for "all the current drivers", do you mean all the drivers which already
> accepted at mainline kernel, which are mmc, uart, spi, i2c ..

Yes.

> all of them follow "amlogic,meson-${SOC}-${FUNCTION}", so do you propose
> to add compatbiles like "amlogic,${SOC}-${FUNCTION}" ?

Yes, but that's an optional future cleanup.

> take i2c for example, there is "amlogic,meson-axg-i2c" already, do you
> want to add another "amlogic,axg-i2c" ? I feel this will adding more
> confusion..

Possibly, but it will provide a path to remove the "meson-" prefix in
the future if we would like.

> How about only following the "amlogic,${SOC}-${FUNCTION}" syntax in the
> new added drivers in the future, for example NAND, PCIE driver which we
> want to push (those drivers doesn't exist in current mainline kernel).

For new drivers, it's fine to not use the "meson-" prefix at all.

Kevin
