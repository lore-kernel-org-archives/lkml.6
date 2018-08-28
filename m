Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6856C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 503B020891
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="jBTfCsKg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 503B020891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbeH1SgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 14:36:05 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:34424 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727406AbeH1SgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 14:36:04 -0400
Received: by mail-io0-f193.google.com with SMTP id c22-v6so1677600iob.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 07:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Nbw1BnyzKqEYfX3lhL65PuPn+ieNkfENnVIvzrXn2gU=;
        b=jBTfCsKg7UlN66OXpj4ertWGb2ZxpNqZ4pRjseEC+9LJoI/PwFQUETMvePik+SS5hi
         Q/NiBpZUCl7LpoGKwxzQH/3plsQVOOoycEdyVPo713VwG5kc997zWtHGf+6fTcrJAL1A
         hgnGQmcBK97wg7Hs7co3I4nuNcnH8TTM3VPfPYadxPiZ6Qx3qzrC7D8Sj0CRjiezQ+cN
         qwIIDoxB71pQTlocfIGWw8di+X9eE9qYJJCmog9g8pbLjR9wA97bIPc0SLYMHvK+ay1J
         L7QuY63cUKwc0VuflourK/x2ELwX4eQ/oRQywYLFUbrJkzHDb0L14m8RXCKLAr2nVFoh
         TnAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Nbw1BnyzKqEYfX3lhL65PuPn+ieNkfENnVIvzrXn2gU=;
        b=rPZbbcrZn17PSzfNJUfC8F+iKE7MSE7DS9FBiMuk6LNCZ81TwPTSHlw3zKt/9RoNKu
         7K2uhiuQdK0IEI0etSUC6pxhMrM/62uPWiCV10h/dz2ZSUILIUHq4fJj/Ri7CYGpvglh
         6jpO1z2YvR4H6XuEQfLUO3QqaBmF30yVNDku7JjQAJk5tcPnytiR4mnZzZ3OILQPoMOF
         bjSKpixwqDnvuy0k/t5bZIkIdm7ygjvGJOcCYCSARKn6SLHO1AIoF/+uvr5YbdJSW3LV
         EV1wEisGm10aNQmB6+o4CA2SmG3YyAI0p76gogtION38WtnmrK7sdZs4Mll3KbLw3AVW
         E6mA==
X-Gm-Message-State: APzg51DsZdnWBZRocX6OBbmO3fDy5EIKu7XEgE8Cai6P1CQtPNBFslBX
        tnEz4lhx16Lhq6ezcA+LVIpXcA==
X-Google-Smtp-Source: ANB0VdZ1aBhz9W7GywLDvRtnvuBHTcVNMuxmOd3CaK4gTBviB5A8EdFfYzMJkhOJEcEHX01QwCe6sQ==
X-Received: by 2002:a6b:410f:: with SMTP id n15-v6mr1589368ioa.3.1535467444863;
        Tue, 28 Aug 2018 07:44:04 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id c141-v6sm786556itc.42.2018.08.28.07.44.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 07:44:03 -0700 (PDT)
Subject: Re: [PATCH] ata: ahci: Convert to using %pOFn instead of
 device_node.name
To:     Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-ide@vger.kernel.org
References: <20180828015252.28511-1-robh@kernel.org>
 <20180828015252.28511-9-robh@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <111e6704-49fc-621a-036e-e659ebe08519@kernel.dk>
Date:   Tue, 28 Aug 2018 08:44:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180828015252.28511-9-robh@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/18 7:52 PM, Rob Herring wrote:
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.

Applied for 4.20, thanks.

-- 
Jens Axboe

