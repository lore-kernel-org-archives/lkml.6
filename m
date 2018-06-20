Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FAF1C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 15:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55DA620874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 15:48:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55DA620874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754271AbeFTPsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 11:48:04 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:38918 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754065AbeFTPsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 11:48:02 -0400
Received: by mail-yw0-f194.google.com with SMTP id 81-v6so8143ywb.6;
        Wed, 20 Jun 2018 08:48:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OTtGtJop6+f/LeZecttIGTeofkjNIGaoX5DWtfJ7uHk=;
        b=iG98oe92rdZrMMx7+uKT/rauhvPOQmkKvk1tV8BJxO5CJjcXSMUZ0sPOmQebPtIzCd
         39wCnWoSnzjkCPNICl60VmjuHiXXIltV2NrvGHequWCFYnV4zi26csGVKFvrerqMnVYl
         X1bwP851zra9pdYpMiRtFEgI+FnHBLU9yeWAfW0vvi62HPmtxFd8Cv1JCw+hR3atM+eO
         CKTSP3y5e/uO+JfqB11l6V8l3PemTtbiDMSycmc2ARiLyZZ8UttLCthI/uGZngyRkjN/
         qVIzO5eHXyz4lMIGqY82f1QSaEqQ8A8bHUOFGJ/3UaSsaqL463r3bNoDt3Jz2FzBSnGL
         pW8w==
X-Gm-Message-State: APt69E18h8v23ggD6y+jqIOjIoo7DenhPo+VcmvFStXV1ZRe7IYwBKeN
        APGGnRQS44cOAf4PfFkdqQ==
X-Google-Smtp-Source: ADUXVKIVkPQT07Bbp7GAEqVEs8XcbAaj5Pd79NibEnyM4S722pm3gkoxcjPTQcZA2FRR71zvGqEG4w==
X-Received: by 2002:a0d:f683:: with SMTP id g125-v6mr10727411ywf.378.1529509681339;
        Wed, 20 Jun 2018 08:48:01 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id l6-v6sm996038ywd.58.2018.06.20.08.47.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 08:48:00 -0700 (PDT)
Date:   Wed, 20 Jun 2018 09:47:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        alsa-devel@alsa-project.org, nicolas.ferre@microchip.com,
        boris.brezillon@bootlin.com, alexandre.belloni@bootlin.com,
        broonie@kernel.org, sboyd@kernel.org, Cristian.Birsan@microchip.com
Subject: Re: [PATCH v5 1/5] dt-bindings: clk: at91: add an I2S mux clock
Message-ID: <20180620154759.GA4755@rob-hp-laptop>
References: <20180618141239.10892-1-codrin.ciubotariu@microchip.com>
 <20180618141239.10892-2-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180618141239.10892-2-codrin.ciubotariu@microchip.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 05:12:35PM +0300, Codrin Ciubotariu wrote:
> The I2S mux clock can be used to select the I2S input clock. The
> available parents are the peripheral and the generated clocks.
> 
> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> ---
> 
> Changes in v5:
> 	- specified clock's parent;
> 	- added a newline before adding the clock's compatible string;
> 
>  .../devicetree/bindings/clock/at91-clock.txt  | 35 +++++++++++++++++++
>  1 file changed, 35 insertions(+)

Well, since Alexandre promises all this is going to get re-worked soon:

Acked-by: Rob Herring <robh@kernel.org>
