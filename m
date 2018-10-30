Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E2EAC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 22:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A6D02081B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 22:14:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A6D02081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbeJaHJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 03:09:45 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42530 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727369AbeJaHJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 03:09:45 -0400
Received: by mail-oi1-f195.google.com with SMTP id h23-v6so11907828oih.9;
        Tue, 30 Oct 2018 15:14:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/ffhZjt0Wm8VhZLlXaITurAxlh83+EeL4ugcRGXeI9g=;
        b=cLG6QnzdbJvmeoUg9jUHvKn2WeqXASnS13PBeXDhETV8tSFbtAUk+phuRmuLf+HL5E
         Ur2CSSvu49u9GzVmsPwqTJMs5Vl0bQGtmxWN5JUWSkaKE+GlRJlnItbV0v81Ry9FrS37
         Ysq/YvkpGKnb5B+c92aw461/lMZtzdRy6zxMwXfhNMO3brLMPoQ3qWmlMsv3+UFeGelm
         LIry0sZ9MLOJZbpR+KIxKQNh/fzkrdyxfhS48CnY51I1d0ZRqUzcCkp7lytEOyhEdAs2
         l1J6XnvmcUDkOyfkx96Km4HSLiUPTW4R9LvtqZx/aUi2V/zdlvg9qWR2w1OCZVsbmHNy
         0Ltw==
X-Gm-Message-State: AGRZ1gLJXebmL8Z37/DKLuYFy1qp+M1vTJ9ozD62SGwIKVaBNvUecyE4
        6hmz4KjA+QoV9Edos0XzFA==
X-Google-Smtp-Source: AJdET5dmRXk2ph+whQoZACABfNcePUAOC0RUpcorfuM+kNWBWBmd5OSnbvnNK0s4Z+CANrn5rAOXDg==
X-Received: by 2002:aca:e8ca:: with SMTP id f193-v6mr358779oih.12.1540937668788;
        Tue, 30 Oct 2018 15:14:28 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j21-v6sm5409741oih.34.2018.10.30.15.14.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 15:14:28 -0700 (PDT)
Date:   Tue, 30 Oct 2018 17:14:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     catalin.marinas@arm.com, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] dt-bindings: arm: Explain capacities-dmips-mhz
 calculations in example
Message-ID: <20181030221427.GA27075@bogus>
References: <1cd2594fff3fb54948dcd2af65ae1867dd1c541a.1540806119.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cd2594fff3fb54948dcd2af65ae1867dd1c541a.1540806119.git.viresh.kumar@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 03:13:05PM +0530, Viresh Kumar wrote:
> The example contains two values for the capacity currently, 446 in text
> and 578 in code. The numbers are all correct but can confuse some of the
> readers. This patch tries to explain how the numbers are calculated to
> avoid same confusion going forward.
> 
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> V1->V2:
> - The numbers weren't incorrect in the example, just that it needs a
>   bit more explanation for some people.
> 
>  Documentation/devicetree/bindings/arm/cpu-capacity.txt | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Applied.
