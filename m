Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21699C67837
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 22:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E142B20841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 22:11:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E142B20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbeJLFlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 01:41:06 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34406 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbeJLFlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 01:41:05 -0400
Received: by mail-oi1-f193.google.com with SMTP id v69-v6so8384228oif.1;
        Thu, 11 Oct 2018 15:11:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5IgkOnyfQn8kd4GLJBdpgH9aUY5eeO9hCm+RmfPDebc=;
        b=tyEyvPzbkB+9QvdlREDIgAkIiYl91ZU2gIosQxwfpGKpRILJ8Hm44EUxl7qYZTUTHl
         8y8OCVyiIa4zXJ+Vsm36ZQvJJtkzlWdj27rV9/yRZMFbtrp/29CDBCqMjButX8lx54rv
         fRld3s02Nc5fBrjaqTDbjGLO2baDh8WP/ERyOsgsjW9EPcvfjwJdsDq0gibaQh8XQQ5C
         k/QS2+f6W0MbDRct+Pu6flmcpiup3/BJHGaFqJaVHvoTBB8uD3TUnFgaVypjS5XrhryU
         wwBAf+P8khiUnjwQY4znNqyaDzASMIDbIQz4elkt1SrNUPQMtc7w8A/Lyrq5rgNE7m4Q
         ZJJQ==
X-Gm-Message-State: ABuFfogtTdQowo+xQy8atPFt2bq46mpfJuh8RwLP9nV/LZEFyEEr8XJV
        8MijfrL+9qhjgtu/TSdsuA==
X-Google-Smtp-Source: ACcGV62UQfFLSxzsm9fr8HwPNIiEgew7AugNOfbqMg0E/2hc3kbI8cyaOq3kvqAF18xudSd+oolhRw==
X-Received: by 2002:aca:a89:: with SMTP id k9-v6mr1954016oiy.297.1539295910119;
        Thu, 11 Oct 2018 15:11:50 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k68-v6sm2629059oib.35.2018.10.11.15.11.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Oct 2018 15:11:49 -0700 (PDT)
Date:   Thu, 11 Oct 2018 17:11:48 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Joel Stanley <joel@jms.id.au>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org,
        openbmc@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        James Feist <james.feist@linux.intel.com>,
        Vernon Mauery <vernon.mauery@linux.intel.com>,
        Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Subject: Re: [PATCH i2c-next v7 1/5] dt-bindings: i2c: Add 'bus-timeout-ms'
 and '#retries' properties as common optional
Message-ID: <20181011221148.GA31195@bogus>
References: <20181005214507.26315-1-jae.hyun.yoo@linux.intel.com>
 <20181005214507.26315-2-jae.hyun.yoo@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181005214507.26315-2-jae.hyun.yoo@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  5 Oct 2018 14:45:03 -0700, Jae Hyun Yoo wrote:
> This commit adds 'bus-timeout-ms' and '#retries' properties as
> common optional properties that can be used for setting 'timeout'
> and 'retries' values of 'struct i2c_adapter'. With this patch, the
> bus timeout value and the master transfer retries count can be set
> through these properties at the registration time of an adapter.
> Still the values can be set by I2C_TIMEOUT and I2C_RETRIES ioctls
> on cdev at runtime too.
> 
> These properties may not be supported by all drivers. However, if
> a driver wants to support one of them, it should adapt the
> bindings in this document.
> 
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> ---
>  Documentation/devicetree/bindings/i2c/i2c.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
