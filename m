Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085B6C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 19:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E0E120657
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 19:37:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E0E120657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbeJaEcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 00:32:10 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44101 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbeJaEcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 00:32:10 -0400
Received: by mail-ot1-f65.google.com with SMTP id p23so12280445otf.11;
        Tue, 30 Oct 2018 12:37:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uteYfbCyf4h+kGEFm86tWBHrteZTzgx/meknTpxAts4=;
        b=h0g6A8oHA0ggQV7G+k+EpA93dRP1rN9/93vEoAa5O+x7kfnabujzImVv1BEkG3tmsa
         2dyBMZWPsN/vj6QGcZpWFgDfyXwUK+Q+STTpQvB8sHEQAqHXTmQ3eAr0Rxxo+d5Mw/+S
         el5s/oXGQmqFypA727NyzQzWhDNpFiGfdBo74EqQ+jgzeAdclGVUxJHbEBd8hV1z6xHi
         bLFVfG6G7zIe0vE/GNxvbmu3BnGvby8rj6KxzOymIbn067QK4pqueApk0qRTJdXzw+x3
         pNjFbk4ePdctvCNDNIdV3HjQFn+ElXEFp73NG+e06sNQV91HPlBerTJBuvbVaQp7dVXJ
         4KsA==
X-Gm-Message-State: AGRZ1gKzi2XldeqMW+xC2rqmJRjiUp7IkxnzwLBR6bdPWSEHAaX9YfFK
        fIH4XWDqXhIbWcrJo8AuZpsmFEs=
X-Google-Smtp-Source: AJdET5cnL6t3XTjKr8N3nLtjNyfT8B4HSlHDsXrub8nV5Cgq3vQUqySdUvIRSCqClOBNHxXG66IaUQ==
X-Received: by 2002:a9d:2e0a:: with SMTP id q10mr52605otb.176.1540928240859;
        Tue, 30 Oct 2018 12:37:20 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d88sm905539otb.3.2018.10.30.12.37.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 12:37:20 -0700 (PDT)
Date:   Tue, 30 Oct 2018 14:37:18 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dan O'Donovan <dan@emutex.com>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Carlos Iglesias <carlos.iglesias@emutex.com>,
        Javier Arteaga <javier@emutex.com>,
        Dan O'Donovan <dan@emutex.com>
Subject: Re: [PATCH v3 1/3] iio: adc128s052: Add pin-compatible IDs
Message-ID: <20181030193718.GA5566@bogus>
References: <20180423213805.12591-1-javier@emutex.com>
 <1540481742-23596-1-git-send-email-dan@emutex.com>
 <1540481742-23596-2-git-send-email-dan@emutex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540481742-23596-2-git-send-email-dan@emutex.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Oct 2018 16:35:40 +0100, Dan O'Donovan wrote:
> From: Javier Arteaga <javier@emutex.com>
> 
> The datasheets for ADC122S021 and ADC124S021 list two more
> pin-compatible alternatives for each device.
> 
> Add their IDs as compatible strings.
> 
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Javier Arteaga <javier@emutex.com>
> Signed-off-by: Dan O'Donovan <dan@emutex.com>
> ---
>  .../devicetree/bindings/iio/adc/ti-adc128s052.txt        |  9 ++++++++-
>  drivers/iio/adc/ti-adc128s052.c                          | 16 ++++++++++++----
>  2 files changed, 20 insertions(+), 5 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
