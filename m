Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FAEBC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 07:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9A7A217BD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 07:05:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9A7A217BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388528AbeHGJRz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 05:17:55 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35327 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727224AbeHGJRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 05:17:55 -0400
Received: by mail-ed1-f66.google.com with SMTP id e6-v6so6392300edr.2;
        Tue, 07 Aug 2018 00:04:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XmptHZRUj1HhbqLfOOMN9DS48U2tNv1riI7VZGWRZp8=;
        b=nOkjMwLMrlWDnfwtjh2HSEFAgBxz3h0smCuudr4AYic4mKXTKfyfZKwQbnj3WahGab
         KEPZwkfY8cdydSpkCSM1Lm9FhiZ3B6M47pyDLLRh2Jk/unIt136Xg1is0xBLBJBy877O
         Y4QcAP8Ke7Bsle6sZsSFbBfsl++Y7W0OXp6ScdXpWHHNjvweubvD9ZBNF3RvNrQtHrBg
         lOOqN/37+7Rd+cCvFUIT07MokVM2PzPK5EsyIO9IAfn5eSzEw2rAjKP7PfFZuHzDzax3
         68icNTToZVfbvmjFmNKXLgsdi85raPb2em7+a68gDJdlBS/YvkB+ojFp8XXxglDGmVOs
         1keg==
X-Gm-Message-State: AOUpUlGNaVTGHf68WlmIK8Tlo4RiJyp6XcVElkGKLi7Yvg9Wx0L3Lbvw
        ci8JRa6gXv0EW6SFEVc9lM+ElUcGmCtDyg==
X-Google-Smtp-Source: AAOMgpcTryhUSOARJO8faFP8C5QjerLuhKmZZZWu+HZHK7CAnpkJeIXz/V/254Umn+YQ03p7YgdxYA==
X-Received: by 2002:aa7:d588:: with SMTP id r8-v6mr21847196edq.130.1533625497926;
        Tue, 07 Aug 2018 00:04:57 -0700 (PDT)
Received: from mail-wm0-f50.google.com (mail-wm0-f50.google.com. [74.125.82.50])
        by smtp.gmail.com with ESMTPSA id g9-v6sm362426edq.34.2018.08.07.00.04.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 00:04:56 -0700 (PDT)
Received: by mail-wm0-f50.google.com with SMTP id c14-v6so16194963wmb.4;
        Tue, 07 Aug 2018 00:04:56 -0700 (PDT)
X-Received: by 2002:a1c:3b54:: with SMTP id i81-v6mr795912wma.143.1533625495971;
 Tue, 07 Aug 2018 00:04:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a101:0:0:0:0:0 with HTTP; Tue, 7 Aug 2018 00:04:35 -0700 (PDT)
In-Reply-To: <266e5f874b36aa83f3327879d85921fab52d5461.1529079120.git.mchehab+samsung@kernel.org>
References: <cover.1529079119.git.mchehab+samsung@kernel.org> <266e5f874b36aa83f3327879d85921fab52d5461.1529079120.git.mchehab+samsung@kernel.org>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 7 Aug 2018 15:04:35 +0800
X-Gmail-Original-Message-ID: <CAGb2v65+6zV1E--KvD3Si=XNmDE3oaZ2hBxvm86KjTwUv9BnSw@mail.gmail.com>
Message-ID: <CAGb2v65+6zV1E--KvD3Si=XNmDE3oaZ2hBxvm86KjTwUv9BnSw@mail.gmail.com>
Subject: Re: [PATCH v4 23/26] devicetree: fix a series of wrong file references
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-input@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-pci@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 16, 2018 at 12:30 AM, Mauro Carvalho Chehab
<mchehab+samsung@kernel.org> wrote:
> As files got renamed, their references broke.
>
> Manually fix a series of broken refs at the DT bindings.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  .../devicetree/bindings/input/rmi4/rmi_2d_sensor.txt |  2 +-
>  Documentation/devicetree/bindings/mfd/sun6i-prcm.txt |  2 +-

If still applicable,

Acked-by: Chen-Yu Tsai <wens@csie.org>
