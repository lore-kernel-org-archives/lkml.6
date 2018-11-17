Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A04D5C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 16:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67B07206BA
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 16:30:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67B07206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbeKRCr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 21:47:27 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39340 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbeKRCr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 21:47:27 -0500
Received: by mail-ot1-f68.google.com with SMTP id g27so24117871oth.6;
        Sat, 17 Nov 2018 08:30:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dTCvlXOn5C4fDbESzFoOZNYgdCdjITZk2Cl1/hiCPj0=;
        b=M9R6GMEW7iZ1cut4Qb5dT92aMXEf+9MpxkNMwRjazKyAkNlePWAGFL6hgsAQM6qhzC
         xFhvKiM+FDLH1DOJ1eCC/XTgGsjjrVH1PPefea+dDjJH2jlST7yAG5olW4z8Wanu6uGD
         b6mSEXMZ2Nt0AD9n0vFbpZ8+EIKuDRUNr1vUp5NMlcZNeCEVJTTVCs+3Qas3ReY8SesL
         giaM/tSuBNKqXRcFaw7TlZSO66AnDvxheEbyOoBe80BYSYgP9+jnKJrwdxI/b2TkxmwC
         a6A2PC7jGeRGgUaTo9YFzTsPxmNH7yat1IF/Y51ZVyNedwz3fBcT90G2K5lkYNtwNira
         F8dg==
X-Gm-Message-State: AGRZ1gIGswHWnUvtSy+cTwjhYTwth4tQhnqOb8p3Z/dWoHskVajfNZKU
        tA3rjdtkJj5oyITiRHI4Ww==
X-Google-Smtp-Source: AJdET5efQQsZaveLpiH4Nypp1OYeUy1tCNUESb7+SKA+gDXN0EpM4qmk9asj1ORVAfiiITSPlXewCg==
X-Received: by 2002:a9d:bee:: with SMTP id 101mr9599373oth.120.1542472215849;
        Sat, 17 Nov 2018 08:30:15 -0800 (PST)
Received: from localhost ([166.137.105.180])
        by smtp.gmail.com with ESMTPSA id o189-v6sm11721903oih.15.2018.11.17.08.30.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 17 Nov 2018 08:30:15 -0800 (PST)
Date:   Sat, 17 Nov 2018 10:30:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: Re: [PATCH 1/4] dt-bindings: reset: uniphier: Replace the expression
 of USB3 with generic peripherals
Message-ID: <20181117163013.GA4481@bogus>
References: <1541727727-10821-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1541727727-10821-2-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541727727-10821-2-git-send-email-hayashi.kunihiko@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  9 Nov 2018 10:42:04 +0900, Kunihiko Hayashi wrote:
> Replace the expression of "USB3 glue layer" with the glue layer of the
> generic peripherals to allow other devices to use it. The reset control
> belongs to this glue layer.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../devicetree/bindings/reset/uniphier-reset.txt   | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
