Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC4E8ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 20:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8989620658
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 20:35:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8989620658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbeJSEiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 00:38:22 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42075 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725751AbeJSEiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 00:38:22 -0400
Received: by mail-ot1-f65.google.com with SMTP id c23so29328814otl.9;
        Thu, 18 Oct 2018 13:35:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PrM7XZQAKRWgV4vYT9n8NCSMrNhconiFMYbYrdAhufs=;
        b=ugAsapCOOTkqGW9pOs++yvtfbwYs5IJWKyQmQFFcH+9WDf/BVxcN5jthZs8R3H+Hgm
         EiV/S66RRvwkLcWTx3tJxvPazsY+/+zzIrAHrPrM5E16YwypdDhU+HxI81RFt9vJodVN
         LyhgWTM8XRA4hH4wey3gf760JyxsvRbyJ7xdbeUC0843GrWlktLiB3XlSUOukEExryLf
         /rFxNZ/yKUCBhHJpLaAbTCzF5r8mKjCJtuLbO2NlzfP70U0ZUUm5nx4XqXb9UrUSaRut
         DYkpJ9rUYbgfsc5W/K558sy6avRNHjtLBA9y8cpKyW9+P3NWeJmp6TjFl6tnaUpS5jAe
         fFRA==
X-Gm-Message-State: ABuFfogYlzFuXpboqrF2xiYoIHcl9IcaVvcpDgUAXq1C+rmn1rBxKHD/
        pJF4hg4EEJhcUwfv1yvaTA==
X-Google-Smtp-Source: ACcGV63z6vcTZghm3/EkbCgJJGPgd7I8PsBOiqh1LcCrq1gCBl/8ryXOW+TZBwRFNHwZcXZDTLoSGw==
X-Received: by 2002:a9d:7a91:: with SMTP id l17mr20996001otn.62.1539894938028;
        Thu, 18 Oct 2018 13:35:38 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p185-v6sm7164386oic.36.2018.10.18.13.35.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 13:35:37 -0700 (PDT)
Date:   Thu, 18 Oct 2018 15:35:36 -0500
From:   Rob Herring <robh@kernel.org>
To:     Richard Leitner <richard.leitner@skidata.com>
Cc:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Richard Leitner <richard.leitner@skidata.com>
Subject: Re: [PATCH v2 5/8] dt-bindings: input: touchscreen: sx8654: add
 sx8650 to comatibles
Message-ID: <20181018203536.GA21783@bogus>
References: <20181017125116.20077-1-richard.leitner@skidata.com>
 <20181017125116.20077-6-richard.leitner@skidata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017125116.20077-6-richard.leitner@skidata.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Oct 2018 14:51:13 +0200, Richard Leitner wrote:
> As the sx8650 is quite similar to the sx8654 support for it will be
> added in the driver. Therefore add it to the compatibles.
> 
> Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
> ---
>  Documentation/devicetree/bindings/input/touchscreen/sx8654.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
