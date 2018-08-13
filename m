Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A6F4C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 17:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 534A92175C
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 17:34:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 534A92175C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730161AbeHMUSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 16:18:04 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:34690 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729309AbeHMUSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 16:18:04 -0400
Received: by mail-io0-f194.google.com with SMTP id l7-v6so15606982ioj.1;
        Mon, 13 Aug 2018 10:34:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kH1ppJ/JOpB6j+Lia622NeiTo5cqfvMlWRDsLfPl0UQ=;
        b=CWSEdmOzInmF0sdTIz12/lnziZzjazhrcIplc5ERQhgKaNpsvOncYUU2PWUYFBjm62
         S7AEBzzepbTFkonVb54/CsHUrxa9Gw8U7DPboqDQcXhzESXagavJZJUc02xDOo8iHjlz
         8WOAUgnEDvVp8oHS2DKBlWLahBb1+kzX94VOpYw5Ni2UwKH3yTH0v3urHclRUbZ0LpGQ
         hrQDPHFd2sqBUKcPb4yrC0JK3PAejGmXMwnyV7XWuG8IrmrK4IkjPxAyFIcCo446ZG6Z
         E3jFaq1Wf2aE/3Tz8Ir+DZUmzl8MgPRvtRX3veOgFYHTE1EJ9H/vO8eODlMl5LTggpD1
         PvGA==
X-Gm-Message-State: AOUpUlFduwXZL4EBdYasHVY4zfjJOM1ltJoPe0msPpRGb79D4u1c8zsq
        jkHNzJrzd77byO1jvVwhpQ==
X-Google-Smtp-Source: AA+uWPzZCIGUvWth0oSC3hdawyggUIOBdn191miUY+JyXFF34Adn5WGbz3g2VfIBMfiQ6EkPuXH3rQ==
X-Received: by 2002:a6b:3108:: with SMTP id j8-v6mr11272462ioa.219.1534181693388;
        Mon, 13 Aug 2018 10:34:53 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id v3-v6sm2809614iob.70.2018.08.13.10.34.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Aug 2018 10:34:52 -0700 (PDT)
Date:   Mon, 13 Aug 2018 11:34:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Srinath Mannam <srinath.mannam@broadcom.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Pramod Kumar <pramod.kumar@broadcom.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: thermal: Add binding document for SR
 thermal
Message-ID: <20180813173452.GA9598@rob-hp-laptop>
References: <1533819299-3401-1-git-send-email-srinath.mannam@broadcom.com>
 <1533819299-3401-2-git-send-email-srinath.mannam@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533819299-3401-2-git-send-email-srinath.mannam@broadcom.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2018 at 06:24:57PM +0530, Srinath Mannam wrote:
> From: Pramod Kumar <pramod.kumar@broadcom.com>
> 
> Add binding document for supported thermal implementation
> in Stingray.
> 
> Signed-off-by: Pramod Kumar <pramod.kumar@broadcom.com>
> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> ---
>  .../bindings/thermal/brcm,sr-thermal.txt           | 23 ++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt

Reviewed-by: Rob Herring <robh@kernel.org>
