Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E53C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 21:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E37B208A1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 21:13:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E37B208A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754515AbeGEVNH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 17:13:07 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33621 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754205AbeGEVNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 17:13:05 -0400
Received: by mail-oi0-f66.google.com with SMTP id c6-v6so19598364oiy.0;
        Thu, 05 Jul 2018 14:13:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uiZD/cJoLv2UkuXrIa7dCQwSqSt7jGBrR9fZ4+5w+88=;
        b=ksYM4AWu9D0amhiDMU9xuVGeWf3khFNl8XBQzqE87HJLjLteeu8T//jFCXfGlqWWoo
         fRKW7U4n5CjWZLRjUxVPQsZK/I2kg25BEw2rnY4dXwwn5hUXgsWyuQkin1nO6CN2R22E
         5skw6G6pkR+WJaxzzGM5EpbzYSSiSsHjH9ZLijoEeEqkvFTlbdVWrja9utifk6tweJVD
         slESMCzSiUjw7/W+efJU3ozyRoV0lngf4+wwvg0toL6870dgdQuUCOwktOItHafguaGK
         W5Dj6fwmaIeBVOtS1y0uthJZNfqh2BwLu4UdOogvfpBhQXj00eUxe4xKDgGwtuoQBRf+
         ukJA==
X-Gm-Message-State: APt69E1umB2QHP3st/mYEJzYaMewBafVgQkzISFWEhFIh5HmHuEtCCqt
        GbNO5AtQI06U1UmBMwX9sA==
X-Google-Smtp-Source: AAOMgpdCRuAj6tJYaDlis2Hcl7+2D9mheICNw6K0nwWhC1m+kV+jyPaz52FDS0J93xrqjd8Q6VBVqA==
X-Received: by 2002:aca:6885:: with SMTP id o5-v6mr9284799oik.208.1530825184387;
        Thu, 05 Jul 2018 14:13:04 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id b63-v6sm5186747oia.4.2018.07.05.14.13.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Jul 2018 14:13:03 -0700 (PDT)
Date:   Thu, 5 Jul 2018 15:13:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     gregkh@linuxfoundation.org, jic23@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        fabrice.gasnier@st.com, benjamin.gaignard@st.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, mark.rutland@arm.com
Subject: Re: [PATCH v7 07/10] dt-bindings: counter: Document stm32 quadrature
 encoder
Message-ID: <20180705211300.GA18202@rob-hp-laptop>
References: <cover.1529607879.git.vilhelm.gray@gmail.com>
 <c1cc3d567d0a5799c3afe6e24ca9ec3b1547224e.1529607879.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1cc3d567d0a5799c3afe6e24ca9ec3b1547224e.1529607879.git.vilhelm.gray@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 05:08:34PM -0400, William Breathitt Gray wrote:
> From: Benjamin Gaignard <benjamin.gaignard@st.com>
> 
> Add bindings for STM32 Timer quadrature encoder.
> It is a sub-node of STM32 Timer which implement the
> quadratic encoder part of the hardware.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---
>  .../bindings/counter/stm32-timer-cnt.txt      | 31 +++++++++++++++++++
>  .../devicetree/bindings/mfd/stm32-timers.txt  |  7 +++++
>  2 files changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/counter/stm32-timer-cnt.txt

Acked-by: Rob Herring <robh@kernel.org> 

