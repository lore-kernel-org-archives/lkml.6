Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48F2C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 16:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C431208EB
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 16:15:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C431208EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934495AbeGJQPF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 12:15:05 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35246 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934265AbeGJQPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 12:15:03 -0400
Received: by mail-ed1-f67.google.com with SMTP id b10-v6so16981657edi.2;
        Tue, 10 Jul 2018 09:15:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4iBlZwNpkerA0UfPrt00oBTqbO1XLFJNpEkBWMVhfDg=;
        b=JrS5K+6vDOCsL3Qplm6t+/RsaLp7LJEnrk3CXMtmd2oqcmRCDLbfFgozuBcqLk/Qjt
         IEprTSqRXIRRGPLK6ur2n6fJlFhyZLdittlYhMSKKtOekdz2kao/llvwWUqBCRyu4cNA
         4xylOlAb64LluXkiCSFRtzfIB7Dt5fPIZBnvZgjM/PpIaXor9ymMl67CQHNS92InO6in
         CmLIk9RjBViFhALL9RHujvgHo42u7kGk82vilpWdVQIDSuyAakU2q0w1y9No5J/ym4WJ
         RQ/oHj6577tQL3HWOEzRDm4uJI+9BtKyNQHL5MddlM15rq8/3liw3jGwD2/iMHJLbFf6
         bjjA==
X-Gm-Message-State: AOUpUlEyqpT/x/fv7AuLqvX6N5ttc4jQCvN8+XP7B3ngIYqnR0WuRm6L
        JDkBf+F4WstzuBSWUwZ2fxc3U7FZ
X-Google-Smtp-Source: AAOMgpdnqFTTfeFbJI7DKIb4KLYM2BfTSRyXoxCQX6EG/G8HBDZqEjrcpra+QtWf+25lofyTuGLJ/g==
X-Received: by 2002:a50:fc0f:: with SMTP id i15-v6mr4244332edr.81.1531239302047;
        Tue, 10 Jul 2018 09:15:02 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id h4-v6sm4390815edq.89.2018.07.10.09.15.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 09:15:01 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id g6-v6so6320528wrp.0;
        Tue, 10 Jul 2018 09:15:01 -0700 (PDT)
X-Received: by 2002:adf:f9c9:: with SMTP id w9-v6mr17792357wrr.105.1531239300945;
 Tue, 10 Jul 2018 09:15:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a15a:0:0:0:0:0 with HTTP; Tue, 10 Jul 2018 09:14:40
 -0700 (PDT)
In-Reply-To: <20180706175113.26698-13-jernej.skrabec@siol.net>
References: <20180706175113.26698-1-jernej.skrabec@siol.net> <20180706175113.26698-13-jernej.skrabec@siol.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 11 Jul 2018 00:14:40 +0800
X-Gmail-Original-Message-ID: <CAGb2v67neknTdGyKLu=bMyXw7_M9Ji2GnVmqK1d20VWUsq2ROQ@mail.gmail.com>
Message-ID: <CAGb2v67neknTdGyKLu=bMyXw7_M9Ji2GnVmqK1d20VWUsq2ROQ@mail.gmail.com>
Subject: Re: [PATCH 12/17] drm/sun4i: tcon: Add support for R40 TCON
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 7, 2018 at 1:51 AM, Jernej Skrabec <jernej.skrabec@siol.net> wrote:
> R40 TV TCON is basically the same as on A83T. However, it needs special
> handling, because it has to set up TCON TOP muxes at runtime.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

The runtime muxing of mixer <-> TCON is quite clever.
