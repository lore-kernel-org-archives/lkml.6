Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D4A9C43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2709F20020
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:31:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2709F20020
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754729AbeFTTb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 15:31:28 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:44003 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754577AbeFTTb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 15:31:26 -0400
Received: by mail-pg0-f65.google.com with SMTP id a14-v6so262342pgw.10;
        Wed, 20 Jun 2018 12:31:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UkiQrO/SxGeCFgCw6wID4W8VvXHhVK48Y+iVAzqvnBY=;
        b=t0II02YCKg8sS5fnoQ1HGLYow9isi6WIseyjYxQBeVlI8calPTxkOpY87hNmclTnjG
         ODBrZyt7MTqMDPIOdr1iwLIS83OWNC6M+1DVfBRggRsZ/L1N+v3g6j2EV+dyiSncz6l8
         PMITXIyg13qJRs3kk+1a1MtW4yu01XiJt9RwLDny57MTVf5IGzjzxbW4cONwc+NU8+U7
         tvgu3gZX0be8I9WLl6iGurXOHbXNx7NUh5/rnAjCQOwc6KFyjkjxxe+ESmBWHhiJzcnL
         pEMcV5LccXqt4fPaQ7yDmyRqJrPU6gwWegrOWWlma98OD5Z8TXz//bpIrPDkQ5wJ6/Dq
         JMcg==
X-Gm-Message-State: APt69E1HLDqIbjLBFS1xRRPtCuup8jzz/0NnJMf233N3BmSB+O7gBph4
        LKo+I8PObIPU7QuGpdQ/Pw==
X-Google-Smtp-Source: ADUXVKIGBO26MQ4H8HlyG95kxcNVs7+RMQRfmVZmwtvacB1B+hb1cQtMykLCJ4QhlgAUePh4HBUolw==
X-Received: by 2002:a63:2d45:: with SMTP id t66-v6mr2425220pgt.381.1529523086018;
        Wed, 20 Jun 2018 12:31:26 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id k69-v6sm5671478pgc.39.2018.06.20.12.31.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 12:31:25 -0700 (PDT)
Date:   Wed, 20 Jun 2018 13:31:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     jic23@kernel.org, mark.rutland@arm.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, freeman.liu@spreadtrum.com,
        broonie@kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: Add Spreadtrum SC27XX PMICs ADC
 controller documentation
Message-ID: <20180620193124.GA8185@rob-hp-laptop>
References: <9b6743bb6782041b7fec9ed0e166faf2b6456de4.1529040864.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b6743bb6782041b7fec9ed0e166faf2b6456de4.1529040864.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 03:03:35PM +0800, Baolin Wang wrote:
> This patch adds the binding documentation for Spreadtrum SC27XX series
> PMICs ADC controller device.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
> Changes since v1:
>  - No updates.
> ---
>  .../bindings/iio/adc/sprd,sc27xx-adc.txt           |   36 ++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/sprd,sc27xx-adc.txt

Reviewed-by: Rob Herring <robh@kernel.org>
