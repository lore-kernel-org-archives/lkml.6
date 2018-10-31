Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96FE7C6786F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 02:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D03720664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 02:55:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D03720664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbeJaLvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 07:51:49 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42517 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728141AbeJaLvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 07:51:49 -0400
Received: by mail-ed1-f66.google.com with SMTP id b7-v6so12325335edd.9;
        Tue, 30 Oct 2018 19:55:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9emBDZTGRWNK8R4I7XhEKWrB2jltkiRn+tvII5NNH40=;
        b=G0L+TC75vT6C/ZPxNj0OeGwl3VVeOwkD/10C4HOBoguT41U1ebEbWr+xQ6I0JpXSH+
         gPVwqALwJNqJxDVZAh+B0MaWs9L5uMBIf8LK5amLdJ9mmjuvkkyxk0whTWadRwDFgSjm
         10XuZS68+AXgGXtJa/HQwxxLyM6RZoyeOh7v5BVWTr7QtzD2+D4df/RBDrwGQEbfoSGE
         Caz/P3D7rjApk8bSmx8pKp4C41tu0LvW4ei93CIblhUmggFZ30m/BvTACNTLv/qM6TIL
         rH9KrXUMUev41dbBvDg+loI/aYQ7/z8pFye7lwzY/YwrRGDgiRDTONQvTItqdDTTkYv9
         icjw==
X-Gm-Message-State: AGRZ1gJ7FYdEpXHMUqKk8lxWe2e8AjP5sQnU8/M7jjrM6j9e+Kb8vMOl
        6TA+ArjUyKTn3+jzu3Tq3NQ/8QMWF6g=
X-Google-Smtp-Source: AJdET5dhOGqme6frJwFZ5NC+esksAd9kvDw2nDaCKn1Y+RdACXxIpGpx/6O6518vEZZS96IhkkT3Zw==
X-Received: by 2002:a17:906:6a8f:: with SMTP id p15-v6mr463181ejr.235.1540954543130;
        Tue, 30 Oct 2018 19:55:43 -0700 (PDT)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id c24-v6sm7893056ede.73.2018.10.30.19.55.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 19:55:42 -0700 (PDT)
Received: by mail-wm1-f42.google.com with SMTP id y144-v6so13101813wmd.4;
        Tue, 30 Oct 2018 19:55:42 -0700 (PDT)
X-Received: by 2002:a1c:13d2:: with SMTP id 201-v6mr812400wmt.58.1540954541667;
 Tue, 30 Oct 2018 19:55:41 -0700 (PDT)
MIME-Version: 1.0
References: <20181023185330.10472-1-oskari@lemmela.net> <20181023185330.10472-10-oskari@lemmela.net>
In-Reply-To: <20181023185330.10472-10-oskari@lemmela.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 31 Oct 2018 10:55:28 +0800
X-Gmail-Original-Message-ID: <CAGb2v673=_skEmWJxn3Ly_vJsE4hsY+HrKM7fS8pkkUQhR76vg@mail.gmail.com>
Message-ID: <CAGb2v673=_skEmWJxn3Ly_vJsE4hsY+HrKM7fS8pkkUQhR76vg@mail.gmail.com>
Subject: Re: [PATCH v5 09/11] power: supply: add AC power supply driver for AXP813
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
> AXP813 and AXP803 PMICs can control input current and minimum voltage.
>
> Both of these values are configurable.
>
> Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
> Reviewed-by: Quentin Schulz <quentin.schulz@bootlin.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
