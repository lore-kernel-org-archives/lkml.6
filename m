Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CCBEC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 17:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 390CB2173A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 17:57:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 390CB2173A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbeHTVO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 17:14:28 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:40176 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbeHTVO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 17:14:28 -0400
Received: by mail-oi0-f67.google.com with SMTP id w126-v6so27353208oie.7;
        Mon, 20 Aug 2018 10:57:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SFJZhK168hE13YJs1HQFY/VtkKd8Cdt6xLFvq7BF8ok=;
        b=UFafOAnwO/7ct16FN7Clu3bRiTTBQzOt1oL7TjY3w9MeY+oz4OniFFVa6Zp2DqDTiA
         Ga4VerDSkQynlqALP3vXmNqObM5US8Bw+/N2136VDZ28o2xAvKsZ0TuIVk0H2/72VJZJ
         NTH3ShIw5GCxSBqzLwZRM1mTEyRq0pnsxlU7UdimznV2+cUyQPd+aDFCcmzH2o344T62
         IV734ISVuhU7VCgEP08d7eofBgIo+EFjvkUsyrvRtoMbw4Al+fo2i+6YtS+LbY2RLN5H
         DNFdv5FH5tMnVSjDC0/rv4WMnmiTfDtD+baetykrlkALci/n/0zcJTfhM6k0YWRKjQNu
         Rx6g==
X-Gm-Message-State: AOUpUlHhh7GLbmyPjIDapTx1Vp21Snbkh1eUPjcF1NCgjaw+453Iwntl
        zUdhDs0SQ6BN9cphuK7mmA==
X-Google-Smtp-Source: AA+uWPzHRagqI3e3X6yXeDOQk8s12tRtef6fqR6npLa9/WMfVMsZB5KmWs1nK4p6N4Gu5s3HEdRU+Q==
X-Received: by 2002:aca:3110:: with SMTP id x16-v6mr15965019oix.126.1534787870758;
        Mon, 20 Aug 2018 10:57:50 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t131-v6sm9974772oie.34.2018.08.20.10.57.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Aug 2018 10:57:49 -0700 (PDT)
Date:   Mon, 20 Aug 2018 12:57:49 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     robh+dt@kernel.org, jacek.anaszewski@gmail.com, pavel@ucw.cz,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: leds: Add bindings for lm3697 driver
Message-ID: <20180820175749.GA13428@bogus>
References: <20180817151528.21623-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180817151528.21623-1-dmurphy@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Aug 2018 10:15:27 -0500, Dan Murphy wrote:
> Add the device tree bindings for the lm3697
> LED driver for backlighting and display.
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
> 
> v5 - Fix the comment for the example - https://lore.kernel.org/patchwork/patch/975060/
> 
> v4 - Removed HVLED definition in favor of HVLED place definition - https://lore.kernel.org/patchwork/patch/974812/
> v3 - Updated subject with prefered title - https://lore.kernel.org/patchwork/patch/972337/
> v2 - Fixed subject and patch commit message - https://lore.kernel.org/patchwork/patch/971326/
> 
>  .../devicetree/bindings/leds/leds-lm3697.txt  | 86 +++++++++++++++++++
>  1 file changed, 86 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/leds-lm3697.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
