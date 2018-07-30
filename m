Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF672C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 23:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9233E20892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 23:14:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9233E20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732191AbeGaAv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 20:51:59 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:46753 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732027AbeGaAv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 20:51:58 -0400
Received: by mail-io0-f196.google.com with SMTP id i18-v6so11349087ioj.13;
        Mon, 30 Jul 2018 16:14:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CwpW9TV2Jde8QYIo1VHe9MK6XRSBMcGxAnVq7pbI4hE=;
        b=UGWFIbp/DhaWu+eWzOwNVne3WUNtpbcLWtVrFAysrtPyhmJOHXen8GfrgTilccUZtK
         ZB98nGqQxAgpwUdS90HImcg0tVMSxGXiMRqV9yiRA2/Lk1SXdRViCUAGPrPC+spVw8Km
         AdCeNZZFP3hzwiLpZxwP/kHzEEr/aj9S2Gv8zrn6C0gLcTa0TTsy+M+WHWMOOpRE5V3i
         oolE7nD4SnPtSIo0DIjeWH8A0jRRZo9MY2Boh5zLCyGCX9NEB6n2Bn0yx1wx/AEaJQ0i
         rpy3dzln+YHFPQT09m7DTle9RlxUVcvTgXXHRKAY28nHukb+gQ3lNk5HOD7YyZXJ12wb
         JU7A==
X-Gm-Message-State: AOUpUlGGfRif8tahKs60/qmWdWOZgzmeKeA3taaiXthBGFloVH3iW8Ar
        G8sM0AB9zODD4a96zMWf1w==
X-Google-Smtp-Source: AAOMgpe3JNkAU672O5EidXOTx5SAfEaPMAf7Ilo8wPkVEE1doD5KL+QMy313sEPsSB4Ltts9IKGsMA==
X-Received: by 2002:a6b:84d6:: with SMTP id o83-v6mr15772888ioi.93.1532992481692;
        Mon, 30 Jul 2018 16:14:41 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id 203-v6sm451396itw.31.2018.07.30.16.14.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 16:14:41 -0700 (PDT)
Date:   Mon, 30 Jul 2018 17:14:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        robert.walker@arm.com, coresight@lists.linaro.org,
        frowand.list@gmail.com, devicetree@vger.kernel.org,
        matt.sealey@arm.com, charles.garcia-tobin@arm.com,
        john.horley@arm.com, al.grant@arm.com,
        Sudeep Holla <sudeep.holla@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>
Subject: Re: [PATCH v3 9/9] dts: juno: Update coresight bindings
Message-ID: <20180730231440.GA7782@rob-hp-laptop>
References: <1532686537-12380-1-git-send-email-suzuki.poulose@arm.com>
 <1532686537-12380-10-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532686537-12380-10-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 11:15:37AM +0100, Suzuki K Poulose wrote:
> Switch to updated coresight bindings for Juno platforms.
> 
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> Changes since V2:
>   - Update to new format.
> ---
>  arch/arm64/boot/dts/arm/juno-base.dtsi    | 161 +++++++++++++++---------------
>  arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi |  52 ++++------
>  arch/arm64/boot/dts/arm/juno.dts          |  13 +--
>  3 files changed, 105 insertions(+), 121 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
