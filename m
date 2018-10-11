Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30623C28CF8
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 22:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB8B720841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 22:12:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB8B720841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbeJLFlh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 01:41:37 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37691 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbeJLFlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 01:41:37 -0400
Received: by mail-oi1-f193.google.com with SMTP id e17-v6so8377603oib.4;
        Thu, 11 Oct 2018 15:12:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=srtI6elytVVzEeFwvIBe7kTajm0oksYdiEyNz9c15Co=;
        b=ZwD8YJgM4Q6TXKV1GgUCHufiFGDUe4STkuTbURN7DSz480MA5cTNQ1CAntNSCm9iDP
         LJlQepPJFv8J1A7cCnXuQA+MPHVudB2UnbfiqSbvgsUI8S9ZjrmhGEJvy8amwPLiCZ0/
         SdsY/0l09nFp7xY17FlFTzm0u2eEBUkAW3umpmZVNeO2BGjtEPihcVAEw8gvRyagfkwl
         WXUICYKOeTCytywlbNbhi3LV7a1u9cunkYfO30ezGCaM6LfGO43I44IMaqPs//WAPKSG
         vDF/mfAQIyXVM88zS5zoOxShdC8nAAZkacaHDw5H0eGwJedypXhqB8J71/SCdgug51d1
         Qo5Q==
X-Gm-Message-State: ABuFfojw3kcbcQ+S29Mn99407UHHCq6bvXDZOBErKCUr+AoJo8eQje5Y
        92+wKIU4iHiczoLn0Yaucw==
X-Google-Smtp-Source: ACcGV63Zz1tbzDAL0A3pjo0qJGDaPUjhTEb0G/DmNReDc1DgxxuBUBzOD4+0iQx6ltjgOj6KysPWTg==
X-Received: by 2002:aca:490b:: with SMTP id w11-v6mr1870035oia.126.1539295941003;
        Thu, 11 Oct 2018 15:12:21 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z44sm9714872oti.38.2018.10.11.15.12.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Oct 2018 15:12:20 -0700 (PDT)
Date:   Thu, 11 Oct 2018 17:12:19 -0500
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
Subject: Re: [PATCH i2c-next v7 3/5] dt-bindings: i2c: aspeed: Add
 'bus-timeout-ms' property as an optional property
Message-ID: <20181011221219.GA31991@bogus>
References: <20181005214507.26315-1-jae.hyun.yoo@linux.intel.com>
 <20181005214507.26315-4-jae.hyun.yoo@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181005214507.26315-4-jae.hyun.yoo@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  5 Oct 2018 14:45:05 -0700, Jae Hyun Yoo wrote:
> This commit adds 'bus-timeout-ms' property as an optional property
> which can be used for setting the bus timeout value of an adapter.
> With this patch, the bus timeout value can be set through this
> property at the probing time of this module. Still the bus timeout
> value can be set by an I2C_TIMEOUT ioctl on cdev at runtime too.
> 
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-aspeed.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
