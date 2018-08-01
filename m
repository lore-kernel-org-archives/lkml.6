Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA2DC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 22:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82B3A20840
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 22:20:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+/lxZqX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82B3A20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732211AbeHBAIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 20:08:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:56020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726228AbeHBAIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 20:08:31 -0400
Received: from mail-qk0-f181.google.com (mail-qk0-f181.google.com [209.85.220.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC6F2208AC;
        Wed,  1 Aug 2018 22:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533162033;
        bh=wyp/U0/nRYU1zksbG7jWM5q94opgUr6p40iS6+Q9wZQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=m+/lxZqXpniY684zSgQHB8dLo+QeLlPyZ/N5OH1wxcHRm+nSYBP5f85CAOtbH1PoZ
         eASIMQE7ZMg3tWhLrvb3XdgNaDU9NQV3ev/KUTdXWN84gS1pNQzS5/0Vs5nUzREBNa
         FFCXVpHw7Kdo17mvi0FtClKaGfo/8QTYYSRQbivk=
Received: by mail-qk0-f181.google.com with SMTP id 191-v6so149273qki.13;
        Wed, 01 Aug 2018 15:20:32 -0700 (PDT)
X-Gm-Message-State: AOUpUlFW/PjupwTeQ5CmmHMVBqGdb8WGu2U2/5Yob3qymqGsHuC35gYh
        cliixFJzRm2f7+yy+/AFHnbN3iEtWBGcnwOiAQ==
X-Google-Smtp-Source: AAOMgpeci5f9Yb2XVsqbYTdmSOlO+KA1CNqdzE5kN+4LAtCdUXtsbQTvlCyu9gtARKR+rFrkU0LMMZzL2Jhn3Quo8nc=
X-Received: by 2002:a37:1a69:: with SMTP id a102-v6mr202470qka.43.1533162032040;
 Wed, 01 Aug 2018 15:20:32 -0700 (PDT)
MIME-Version: 1.0
References: <20180727121806.18209-1-srinivas.kandagatla@linaro.org>
 <20180727121806.18209-2-srinivas.kandagatla@linaro.org> <20180731204315.GA5265@rob-hp-laptop>
 <53a4e82c-7270-fdbd-a2ea-efbfc2d747a2@linaro.org>
In-Reply-To: <53a4e82c-7270-fdbd-a2ea-efbfc2d747a2@linaro.org>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 1 Aug 2018 16:20:20 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKcxB2NZR94BP9-Qc8AAFsySPoADm2UA_ZV8V7JdP8-wQ@mail.gmail.com>
Message-ID: <CAL_JsqKcxB2NZR94BP9-Qc8AAFsySPoADm2UA_ZV8V7JdP8-wQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] ASoC: dt-bindings: add dt bindings for wcd9335
 audio codec
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vinod <vkoul@kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 1, 2018 at 2:57 AM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
> Thanks for the review.
>
> On 31/07/18 21:43, Rob Herring wrote:
> >> +
> >> +- reset-gpio:
> > reset-gpios
> >
> Yep, reset-gpios makes more inline with others!
> >> +    Usage: required
> >> +    Value type: <String Array>
> >> +    Definition: Reset gpio line
> >> +
> >> +- qcom,ifd:
> >> +    Usage: required
> >> +    Value type: <phandle>
> >> +    Definition: SLIM interface device
> > Wouldn't this be the parent?
> >
> No, Interface device is just like other slim device and is part of
> SLIMbus Component and has a unique address. Every SLIMbus component has
> one interface device.

I still don't understand what this means. If this is SLIMbus specific,
then maybe it should be named that way? Or it is QCom specific?

Rob
