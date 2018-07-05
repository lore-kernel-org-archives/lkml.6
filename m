Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5916BC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 20:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0227F2086E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 20:43:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0227F2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754328AbeGEUnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 16:43:35 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:34918 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754032AbeGEUnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 16:43:33 -0400
Received: by mail-oi0-f65.google.com with SMTP id i12-v6so19419434oik.2;
        Thu, 05 Jul 2018 13:43:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pLFS+R0zSvo9gC9QGZAfaWvPZOnXVSSf2fa72qbMKGU=;
        b=atnZL7exsXm9qDyelqFvmvYJAmddvO4dY1mYypUHhXCFCvY9FKpEoLfo3nfd9tLswS
         cddLE7zU9mFj0J7lZUf2OewfNqlPr9J+5XufbR/dd9RRG7rhyhcXO+z01Pi5wUa5w0KI
         v4QpIzppgV8XxNTDlskWYK+kd+vd1HmyG+DNk4ek5O/br2MpxriTrd+82U4/da5yMmQ7
         RJ/jq9dTRjTuLCd4tcB1uyC+GH6OQsFhY19ywjaQboEux9LdLWc6VEHuP4j0OwVuEBmy
         xvOJdX2w3zTyamedJwEn0jKRVEH8xG7T/D9lG3R0xH50JUVan3WTOB1INZuJ3RppUM9v
         UEEw==
X-Gm-Message-State: APt69E3hoeje4aBY3Mvcw8XNBEfGz97Pwa/gaUGCuwzRKGnMQpQ/F3He
        0eZ6jG4jsKquIj7N/ZLNcw==
X-Google-Smtp-Source: AAOMgpfOnVauGtuQ5v09vxAN9e/99ptafWG9WD/nrDEDsrrgTqDotoRf4sb/nBX0rIEPizya9jWRlA==
X-Received: by 2002:aca:e3c8:: with SMTP id a191-v6mr9069650oih.4.1530823413174;
        Thu, 05 Jul 2018 13:43:33 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id r187-v6sm1731425oib.2.2018.07.05.13.43.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Jul 2018 13:43:32 -0700 (PDT)
Date:   Thu, 5 Jul 2018 14:43:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     mark.rutland@arm.com, jdelvare@suse.com, linux@roeck-us.net,
        avifishman70@gmail.com, yuenn@google.com,
        brendanhiggins@google.com, venture@google.com, joel@jms.id.au,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: Re: [PATCH v8 1/2] dt-binding: hwmon: Add NPCM7xx PWM and Fan
 controller documentation
Message-ID: <20180705204331.GA1778@rob-hp-laptop>
References: <20180703232326.355718-1-tmaimon77@gmail.com>
 <20180703232326.355718-2-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703232326.355718-2-tmaimon77@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 04, 2018 at 02:23:25AM +0300, Tomer Maimon wrote:
> Added device tree binding documentation for Nuvoton BMC
> NPCM7xx Pulse Width Modulation (PWM)  and Fan tach controller.
> The Nuvoton BMC NPCM7XX supports 8 PWM controller outputs
> and 16 Fan tachometer controller inputs.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
>  .../devicetree/bindings/hwmon/npcm750-pwm-fan.txt  | 84 ++++++++++++++++++++++
>  1 file changed, 84 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/npcm750-pwm-fan.txt

Reviewed-by: Rob Herring <robh@kernel.org>
