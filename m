Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 140BDC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 04:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B07BC208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 04:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kOQAFL+/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B07BC208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729214AbeGaGaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 02:30:16 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:45406 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbeGaGaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 02:30:16 -0400
Received: by mail-pl0-f68.google.com with SMTP id j8-v6so6579738pll.12
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 21:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8nBy3mTPXtDjs42w0453M97jKBQukcQbdBa8pKjLGWY=;
        b=kOQAFL+/tRyiyL/g1JnL0pqZi42rdjtur/TqOwbxn50PFusvCosWqN4+vjx+iVa8Pb
         jVYiDdQwLm3BUK1H/AGqs0+PbtgdpwL/QoCzjijVTBfIzR8MO/LgEEw8N6RCQzqiZvdF
         8QTtYTtKHDVkwuUiHAZk8nKbi5uRYBVbK7K90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8nBy3mTPXtDjs42w0453M97jKBQukcQbdBa8pKjLGWY=;
        b=iWKALm9cNPgFpDFr3SzIGy8EErAlmPu3UU8JSmDCtRRR5N5tIfWlzl9QN1UBwaOnzI
         ZEGut1Hd7NemesSJaMK4jetQEIt3Bnnf74IWb4vPyNZ3Sbq7lG6vBaX1secP24zFZc1X
         7Gw1A4boDojYq2VrSTSagPLoviQrbSWSvSYz+44tm80R3UCiAjIurTDDD2YSL88CIWqQ
         SodOX4rrZdBsAwDPS/FqsT3HL83LzohYm0E92lXp9qUzy2B8UoONcQ8zWqcID9XxqdP4
         qz2r8sjabD81HCwl93nRNOBCZ+y1OGYNTDm1ezIm56Mj9m12BZayIHdRTsgKZlIeINQH
         99rw==
X-Gm-Message-State: AOUpUlG6qILxmWmQZZkYHCoKfUm2SIXn4NNOnb8a3N369aZ3orehyOq3
        jCmKEDcb7/uwwi0HiZyLaCC/FQ==
X-Google-Smtp-Source: AAOMgpcz3fpFejHSC/0Pe+zVQSdzRy98nU8IJ7lMWijs/5+MDm8J+7eTmNXLXmpH+oRjiI5fplCy3g==
X-Received: by 2002:a17:902:b205:: with SMTP id t5-v6mr18708745plr.220.1533012714965;
        Mon, 30 Jul 2018 21:51:54 -0700 (PDT)
Received: from localhost ([122.172.86.103])
        by smtp.gmail.com with ESMTPSA id p19-v6sm25484628pgh.60.2018.07.30.21.51.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 21:51:53 -0700 (PDT)
Date:   Tue, 31 Jul 2018 10:21:51 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>, robh@kernel.org,
        Wei Xu <xuwei5@hisilicon.com>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        devicetree@vger.kernel.org, olof@lixom.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] dt: thermal: Fix broken cooling-maps
Message-ID: <20180731045151.gqsgsm6l3gwr5m4z@vireshk-i7>
References: <cover.1530766981.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1530766981.git.viresh.kumar@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-07-18, 10:39, Viresh Kumar wrote:
> Hi,
> 
> This is an attempt to fix the broken or partially defined DT bindings
> for cooling-maps. We should list every device that participates in
> cooling down at a certain trip point, instead of just the first in the
> list as that depends on certain ordering of events to work properly.
> 
> The first patch extends the binding to allow a list of phandles in
> "cooling-device" property and the second patch fixes one of the
> platform's DT.
> 
> This will be followed up by fixing all platform DT bindings that have
> these issues after this set is accepted.
> 
> The kernel also requires some changes to handle the phandle list, but
> wouldn't break with these changes as it reads the first phandle in the
> list for now. We can update that separately.

@Zhang: Are you going to apply this for 4.19-rc1 ? There are lot of patches that
I am holding up until this gets merged.

-- 
viresh
