Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE94C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 18:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 013B52086E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 18:18:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 013B52086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbeIJXNu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 19:13:50 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33204 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbeIJXNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 19:13:50 -0400
Received: by mail-oi0-f67.google.com with SMTP id 8-v6so42080968oip.0;
        Mon, 10 Sep 2018 11:18:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eYqmEyCq4Rlk5NeZPOtWHXyuw2Rk6RkZ5z1A6JGoflc=;
        b=ISaxK1KEbKPWGzWCm0QUIzMkzX1th8oWzsR9ssMD3pCeZhbeeNlgMyMo0xxkLte5Ek
         ddkU0CM52cBJSDV1/8md2OxKuKIIPT2LnwQBu/kGc506E6SvFLIzR8Q7IuH5ZgFXiKr3
         Fhd+tx1rG/hsiW6vNG8+/i5Wk9MvYgUFc+ux9/jRwHnwGmtE7MxTqCEE/g+AbHq2ZK71
         o1Dyq9bnmry3ZLlUf4Ca4vxxhQzOsUpC6u+iL+sDdWbSSOo5z9mzocQ6MfuJhItk8g9o
         HWH3+jInKTOMlerPPKJqSwKEBQxD4ZtmXYZs/p7BTvXaFIWnP46s3xV1TdCqgmcb5C9i
         BBMg==
X-Gm-Message-State: APzg51Dgm5teWEk1idNnC2MOUNP7pZGJiZh+hGo75fV/T0juUH2CfoA1
        Ava6BbPzhvfQxIRtlZcNqQ==
X-Google-Smtp-Source: ANB0VdbcwY64pqXpDJlmP+K/ALey8cMAd4iaErzq57K8ElwMAQRpdb4WUdlJPfN1hmoMtDyyg4LS2Q==
X-Received: by 2002:aca:36c1:: with SMTP id d184-v6mr24388425oia.36.1536603509216;
        Mon, 10 Sep 2018 11:18:29 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d5-v6sm9377498oia.57.2018.09.10.11.18.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 11:18:28 -0700 (PDT)
Date:   Mon, 10 Sep 2018 13:18:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     axboe@kernel.dk, hdegoede@redhat.com, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, robh+dt@kernel.org, wens@csie.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: Re: [PATCH v5 7/9] dt-bindings: ata: update ahci_sunxi bindings
Message-ID: <20180910181827.GA12679@bogus>
References: <20180903100201.23131-1-clabbe.montjoie@gmail.com>
 <20180903100201.23131-8-clabbe.montjoie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180903100201.23131-8-clabbe.montjoie@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  3 Sep 2018 12:01:59 +0200, Corentin Labbe wrote:
> This patch update binding with the new R40 compatible.
> 
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> ---
>  Documentation/devicetree/bindings/ata/ahci-platform.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
