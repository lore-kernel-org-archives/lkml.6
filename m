Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F6EECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2162420880
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGEVIeTz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2162420880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388472AbeGXQ74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 12:59:56 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:33193 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388363AbeGXQ74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 12:59:56 -0400
Received: by mail-qk0-f196.google.com with SMTP id 27-v6so2921864qkv.0;
        Tue, 24 Jul 2018 08:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ASp4aA6oxvaP+WDYJMoT+0ESVIKlTEIWwLrAPD5OkGA=;
        b=eGEVIeTz3sqWw3pRycHnCEAb5OrXET814hVQXL8eQlY6ja9s9i0gQn8S+2agdxYkbj
         sV9eGqQ2Jwcn4HOxJ7KcZKZenac8inzdh6eCDeWGO8DcdbRxa4N+B5wX8CwKMjKMvF4Q
         WI3BZSjKm0WuASdRTJWmdL9ogRSWpxVtS92p0k8kXAmjtmqJqBCcyjM1eGTANF1xsddh
         h6J9ekD6RyEwZD6Xo84t8GjMlCZvkBfSvluDrAvlVpWkgdBhPiNzXTsCa0F7f97N7ops
         Mc97PMq/jyxGBMJcO5zNI3z3CwbrD24mw22aOqUt7wowyyliSYgq3KE2u5pdBbuTR1cn
         dFCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ASp4aA6oxvaP+WDYJMoT+0ESVIKlTEIWwLrAPD5OkGA=;
        b=kcBTJgtNATV1oK5S0ipEKVEjVWVzBXn9pLdYmK1N1LM6hBCgqG3/n+ioM6LEp20xuj
         u77yXHbM5E3Xwi18cUNR9haA4RUevrR03Cby9WPuYqODVCcsdYiDzNnO1yueucCR63yz
         skA9jnT1CkOMikwWf0JFXPBQLd3TxEWiMn+UWZ/KzyMBafQHpzvimgfyWO8BaAoN+R1U
         MPZB++4DiBS+4UbebsTObuK9+RfjNGRsZFzzCU5nHc4pvWqT/TGkniU2CWicoG8IQFUx
         xKYq+ZkVU/BrTzcPA5qNx1BegjLhA3V1772VWe00O6nNwuiROIW+5YASTyuIsKqel/M4
         Repg==
X-Gm-Message-State: AOUpUlEIv0uvBiCHRP+XtlBWwc1OurKxPGVZhGgl5RIPfPxetm6Gxt/8
        RDgWpPrK7KILgDIWvuboeUlFUW7RL1o=
X-Google-Smtp-Source: AAOMgpcY17+nA/Hc9RCLNPCAQqTYymgMc6JW0UwOQF62hDKcCOdy78n1TUH73D8DNN4P6uEOq+2plQ==
X-Received: by 2002:a37:b286:: with SMTP id b128-v6mr15802569qkf.158.1532447569390;
        Tue, 24 Jul 2018 08:52:49 -0700 (PDT)
Received: from [192.168.44.96] (180.sub-174-226-6.myvzw.com. [174.226.6.180])
        by smtp.gmail.com with ESMTPSA id o25-v6sm6749354qtp.87.2018.07.24.08.52.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 08:52:49 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] Add sw2_sw4 voltage table to cpcap regulator.
To:     Mark Brown <broonie@kernel.org>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <20180724132541.17039-1-pgwipeout@gmail.com>
 <20180724132541.17039-2-pgwipeout@gmail.com>
 <20180724143634.GD13268@sirena.org.uk>
From:   Peter Geis <pgwipeout@gmail.com>
Message-ID: <2ae14535-c14f-c50f-c76a-4406f67fc682@gmail.com>
Date:   Tue, 24 Jul 2018 11:52:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180724143634.GD13268@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/24/2018 10:36 AM, Mark Brown wrote:
> On Tue, Jul 24, 2018 at 09:25:40AM -0400, Peter Geis wrote:
>> SW2 and SW4 use a shared table to provide voltage to the cpu core and
>> devices on Tegra hardware.
>> Added this table to the cpcap regulator driver as the first step to
>> supporting this device on Tegra.
> 
> Please submit patches using subject lines reflecting the style for the
> subsystem.  This makes it easier for people to identify relevant
> patches.  Look at what existing commits in the area you're changing are
> doing and make sure your subject lines visually resemble what they're
> doing.
> 

Copy, should I resubmit?
