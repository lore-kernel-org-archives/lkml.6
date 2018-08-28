Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63848C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 22:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D5B32087B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 22:27:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D5B32087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbeH2CUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 22:20:54 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:39805 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbeH2CUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 22:20:54 -0400
Received: by mail-oi0-f66.google.com with SMTP id c190-v6so5753336oig.6;
        Tue, 28 Aug 2018 15:27:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4qvIFIYCiv0tkGwrmRXtPZsdJKevk1XWh8m9CE65U/o=;
        b=Eb4LMuvss6uhys5pmV3s7Ij+7xn8zGs6twB9cCJGk75dmyxzTJrDEOHlZRje88f+Ss
         t3pLRD68sDkVm9+2UFejQYdDRvGF/6lqNe8DxWl7TWyJ0ac4cGxY3Czrk+OLxtsEE7qU
         4+DuDj9vKdh5TP/FbKTDGxrYoEs8CItQ9kRc5O11ZdMrYaUl38GTMvIh/IfvY2Gk27kX
         UJWR7u2iiCRnLGc7IjGa+wwbjrGTkQ3Y8odNh8aa4ZNUzddbabFXQ+ds7bk2rBbaHXAN
         T0ZWhapgkCRS3OaElHqGAxiwhGa03w8dDD5iuo7+9b7Pf5lbNd8WlHQ8sX0CEW0v2NFd
         XFQg==
X-Gm-Message-State: APzg51AQBaEwy/RD/cqilJMdtrde1EdGEHqV9OOegXSTPa6DmyYEvxRO
        7JTlKk1PEOmTu+BGNcanJw==
X-Google-Smtp-Source: ANB0VdZbvEWAorLtgIs1q5p/Ud2oUbTSd2eKyRvft0G3bNiZ8ni70V1/tyF+8+HQ/OJtYJdOVHGfGw==
X-Received: by 2002:a54:4784:: with SMTP id o4-v6mr82959oic.101.1535495229803;
        Tue, 28 Aug 2018 15:27:09 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f144-v6sm2260656oib.39.2018.08.28.15.27.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 15:27:09 -0700 (PDT)
Date:   Tue, 28 Aug 2018 17:27:08 -0500
From:   Rob Herring <robh@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     thierry.reding@gmail.com, shc_work@mail.ru, mark.rutland@arm.com,
        corbet@lwn.net, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [RESEND PATCH v5 5/9] pwm: add PWM modes
Message-ID: <20180828222708.GA22527@bogus>
References: <1535461286-12308-1-git-send-email-claudiu.beznea@microchip.com>
 <1535461286-12308-6-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535461286-12308-6-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 04:01:22PM +0300, Claudiu Beznea wrote:
> Add PWM normal and complementary modes.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/pwm/pwm.txt |  9 +++++++--

Acked-by: Rob Herring <robh@kernel.org>

>  Documentation/pwm.txt                         | 26 +++++++++++++++++++++++---
>  include/dt-bindings/pwm/pwm.h                 |  1 +
>  3 files changed, 31 insertions(+), 5 deletions(-)
