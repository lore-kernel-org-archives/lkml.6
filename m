Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E4DEC67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 19:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E84D3205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 19:48:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E84D3205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbeJSDud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 23:50:33 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41072 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbeJSDud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 23:50:33 -0400
Received: by mail-ot1-f66.google.com with SMTP id c32so30983328otb.8;
        Thu, 18 Oct 2018 12:48:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TW0ld+49mrI3fSEdHT5ADhTTD7haW5UOlwuNbsIgO1Y=;
        b=AAYKcPOqvH8g8+ly3hthYX1AFgqkTeM6d4ceC2IG5Oue79t5jmPeBbMi8iYjhZLYu6
         QdtCEFGM2ux26s/GWV/PQQ8teOQGJ+SAn2l1y97kXpJdpLp9Xdk2TcXRwn6yArmXfz7N
         /fN9ugCc/w9Ofb5Gd3kI0w7CEhMCv1Gud3Ge3m6Zwei+OL+5Ndegb6QUL8FSYqdvPoPs
         vgirEoAR3DgR0/hHxDObCFph8hVj91rQA8gBvqH4ppOE8BznjgOmL9b2+s0N9WvVmcEV
         60CU2/hBzvjS14YGlecRQ5nzKlIIRc//Jnhdng3nPix5vwWcZAHt6uBm3u+KWxFj2jI4
         8UWw==
X-Gm-Message-State: ABuFfogo5+AIf7deVEPdbyg9iZtNPL+bnEe4zB/V1guKnu6qhB5a+mSH
        Ndkk7bVijCYlQgXr2YotGVf90ws=
X-Google-Smtp-Source: ACcGV61pTBVOZCJfwQpxzzSAEJbBUlOOWtYbR2d8PgtYXGZeLRF6ZuXgsc00Q8Dtt6qwFAFcwp7b7w==
X-Received: by 2002:a9d:19ec:: with SMTP id k99mr21003179otk.340.1539892080017;
        Thu, 18 Oct 2018 12:48:00 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 111sm7483377otf.51.2018.10.18.12.47.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 12:47:59 -0700 (PDT)
Date:   Thu, 18 Oct 2018 14:47:58 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kun Yi <kunyi@google.com>
Cc:     openbmc@lists.ozlabs.org, kunyi@google.com,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] dt-bindings: hwmon: Add adm127x documentation
Message-ID: <20181018194758.GA21705@bogus>
References: <20181017222710.254994-1-kunyi@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017222710.254994-1-kunyi@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Oct 2018 15:27:09 -0700, Kun Yi wrote:
> adm127x are hot-swap controllers that allow a circuit board to be removed from
> or inserted into a live backplane. This patch adds the device tree
> bindings documentation.
> 
> Signed-off-by: Kun Yi <kunyi@google.com>
> ---
>  .../devicetree/bindings/hwmon/adm1275.txt     | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/adm1275.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
