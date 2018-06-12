Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 52694C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 22:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EC7E208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 22:11:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EC7E208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934824AbeFLWLb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 18:11:31 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:33082 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934377AbeFLWL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 18:11:28 -0400
Received: by mail-yw0-f193.google.com with SMTP id u124-v6so201383ywg.0;
        Tue, 12 Jun 2018 15:11:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TPzjnzHTOfrNM7f7LsGZT0CJyhOHArapkWDEb8sGPo8=;
        b=PfZDwGHixJvSSIV6BLnrmbXpN/vWC7B03i0hmJHpGiqj5vdAJnu3dKSTRUypaj2njH
         /ShPjCYh3x65j9o7jO0t2l+OwHWwJujcDRJMJdsRzLQrXl42pbLSvoWefRvgGK/BqNJ3
         cAJlkwPBi50PEnbAU7LlkeW+frWyUaFpV6ezYHtzcXyJz3Foqx8blrnBsFSbhFTbIhyG
         /OQMA/1uIKLqWqF+4eVS4rABV0HNZlioK5knR0S5AaIzQwDZvsplUrvjpReWc6mB6546
         bNahnDUb/YTMqjJuP9Ik/UkNgB/dvI5cDBSCu2AbHD1v5RLfibaJCKYgXEctCfFTtzKr
         eeNA==
X-Gm-Message-State: APt69E16XC/ef1+J8p46FGQspEjzCJEn6Yq3DLkuG1ne4aZieonLhWRM
        JM5o+7gM1GUzeKbSsbvWPIc4ygQ=
X-Google-Smtp-Source: ADUXVKKoWAxujBa1fzu+gdGIQ6LM8+7sNkTIegoGKLKLw3kZiRYnuFfsb8kXLlV0fPUiguix1nZ3Ow==
X-Received: by 2002:a81:8686:: with SMTP id w128-v6mr1152482ywf.497.1528841487379;
        Tue, 12 Jun 2018 15:11:27 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id v127-v6sm505141ywf.101.2018.06.12.15.11.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 15:11:26 -0700 (PDT)
Date:   Tue, 12 Jun 2018 16:11:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc:     mchehab@kernel.org, devicetree@vger.kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: media: i2c: Document MT9V111 bindings
Message-ID: <20180612221125.GA22846@rob-hp-laptop>
References: <1528730253-25135-1-git-send-email-jacopo+renesas@jmondi.org>
 <1528730253-25135-2-git-send-email-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528730253-25135-2-git-send-email-jacopo+renesas@jmondi.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 05:17:32PM +0200, Jacopo Mondi wrote:
> Add documentation for Aptina MT9V111 image sensor.
> 
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> ---
>  .../bindings/media/i2c/aptina,mt9v111.txt          | 46 ++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/aptina,mt9v111.txt

Reviewed-by: Rob Herring <robh@kernel.org>

