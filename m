Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E33ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 03:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA6DE20664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 03:05:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA6DE20664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728936AbeJaMBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 08:01:33 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40605 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728157AbeJaMBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 08:01:32 -0400
Received: by mail-ed1-f67.google.com with SMTP id z12-v6so6575690edp.7;
        Tue, 30 Oct 2018 20:05:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wOq5ODwl0vI6gbQZ4fu1SBDl8ND8yWp3RtRwx7QAc/0=;
        b=dloceeOd3oigWvGXk2PmcNuTcWw19lr2ggeigCLtuWhWAc7uLFk/zwH0Hxj+aab/EC
         k8TWj8gBvl0wft7DIFDqS/k/uZ9aoWzu0fzqg2cO/ALX8Fv4dnHhnPO6I6FVhsEUTMgM
         AenrOAdfO0PBWX7J2TAglXMftNN8/mR5agGXD7bpQIyMQC6sM15EqzenuckpYIItH63H
         ofv3UCP4tqn56JtiwB65qSozlnvw/d7M5BbHjYbwYeENGD3QkNsJGmWGPDo7Kasw7uuS
         UywyK5C+Cbgod0W1J/faKNsX5Fn5gPu0vlQjYkwqWwV7dRE6FXNCh+6B1IN2L0O7c/Fq
         O5RQ==
X-Gm-Message-State: AGRZ1gJszjnQz9KwzDrp86x1LLfdFTH9OBx6zDTe42tXSkMCdt9YIA1F
        KBN6gHM7FOk04B2XQMBPL/Q/ufgtw9A=
X-Google-Smtp-Source: AJdET5fKf+zsTV57P2neTTk/03nhh7ma2lTIBhHVikIaWst8oSI7mmdlF5p6TDiY0LamTSe9rg/SaA==
X-Received: by 2002:a50:892d:: with SMTP id e42-v6mr599463ede.201.1540955124918;
        Tue, 30 Oct 2018 20:05:24 -0700 (PDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id t1-v6sm5994181eds.44.2018.10.30.20.05.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 20:05:24 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id j26-v6so624798wre.1;
        Tue, 30 Oct 2018 20:05:24 -0700 (PDT)
X-Received: by 2002:a5d:4844:: with SMTP id n4-v6mr1089109wrs.28.1540955124171;
 Tue, 30 Oct 2018 20:05:24 -0700 (PDT)
MIME-Version: 1.0
References: <20181023185330.10472-1-oskari@lemmela.net> <20181023185330.10472-8-oskari@lemmela.net>
In-Reply-To: <20181023185330.10472-8-oskari@lemmela.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 31 Oct 2018 11:05:11 +0800
X-Gmail-Original-Message-ID: <CAGb2v66dY87HN6HQz3=ER=yr6arV3LcxCxpVVwojKpqwj7m7dQ@mail.gmail.com>
Message-ID: <CAGb2v66dY87HN6HQz3=ER=yr6arV3LcxCxpVVwojKpqwj7m7dQ@mail.gmail.com>
Subject: Re: [PATCH v5 07/11] arm64: dts: allwinner: a64: sopine-baseboard:
 enable power supplies
To:     oskari@lemmela.net
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 2:54 AM Oskari Lemmela <oskari@lemmela.net> wrote:
>
> AXP803 ACIN pins are routed from SOM to the DC jack on the baseboard.
> AXP803 charger pins BATSENSE, LOADSENSE, N_BATDRV, LX_CHG, VIN_CHG
> and IPSOUT are connected via PMOS driver to SOM VBAT pins. VBAT and
> AXP803 TS pins are routed to the baseboard 3-pin battery connector.
>
> Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
> Reviewed-by: Quentin Schulz <quentin.schulz@bootlin.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
