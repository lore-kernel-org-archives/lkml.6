Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D3AC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 20:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC6FA21533
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 20:30:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC6FA21533
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbeI0Cpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 22:45:32 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36604 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbeI0Cpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 22:45:31 -0400
Received: by mail-oi1-f194.google.com with SMTP id p125-v6so280382oic.3;
        Wed, 26 Sep 2018 13:30:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pEL3LICLzjo6LI7AFA2tg/hCFTTTJbsEQ/W1XolzrcI=;
        b=Mgkk6RiTvn6E8Ax/v6eJtm6yXrFtK9v0OlslB0dHu8PTERizkMQByHGOZGMEkgPV0P
         EouP/r7D8najcb2U+RZTaZtvozjuRMR3omOAM7rOFVx2hhh1OVfv5Tp8l8o0zMEM6U1Y
         kUCYthhUwFnHnseOAtmeedrvuyMLMn/dDKT+8K03V2XOao16e+EsSlgav4YA9p4vDpRA
         vkVGGQjKfVNXGYhtuqZu/oRLlU4qFtOLtmM0+z8pgOxHe05dE7SIf/JJOjw3FVSulnO8
         3fLhYUd72KGRK0gTRWK6RcS/eYzJz9+Cq6MjRZC/gj/TojXLqkFr1zYBgWJBbVAp4ov6
         vdpQ==
X-Gm-Message-State: ABuFfog8NTT0YHZMZgPCt8x+0B1eAyJrSidbhq3M2gDmWDJNjYd/R+cS
        Pb8uebJ62mCQND+yPZxTBZ0Ckgi/vw==
X-Google-Smtp-Source: ACcGV62yGbQre/EvotJCIGIpbIB8/NhvKkwB6oe43GVEw4AoIxkwjRe7v8ltsFmK5NEmlcuqxd09/Q==
X-Received: by 2002:aca:40d6:: with SMTP id n205-v6mr1636503oia.35.1537993849806;
        Wed, 26 Sep 2018 13:30:49 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l195-v6sm2438oib.17.2018.09.26.13.30.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 13:30:49 -0700 (PDT)
Date:   Wed, 26 Sep 2018 15:30:48 -0500
From:   Rob Herring <robh@kernel.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, mathieu.poirier@linaro.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh@kernel.org, frowand.list@gmail.com,
        coresight@lists.linaro.org, leo.yan@linaro.org,
        suzuki.poulose@arm.com
Subject: Re: [PATCH v2 01/11] coresight: dts: binding: Fix example for TPIU
 component
Message-ID: <20180926203048.GA24629@bogus>
References: <20180912135352.19722-1-suzuki.poulose@arm.com>
 <20180912135352.19722-2-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912135352.19722-2-suzuki.poulose@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Sep 2018 14:53:42 +0100, Suzuki K Poulose wrote:
> TPIU component has an input port. The example uses out-ports
> which is wrong. Let us fix it.
> 
> Reported-by: Leo Yan <leo.yan@linaro.org>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  Documentation/devicetree/bindings/arm/coresight.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
