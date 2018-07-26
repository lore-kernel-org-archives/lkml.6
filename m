Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB84C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9543020673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:15:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XzmD0Ecg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9543020673
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731605AbeGZUdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 16:33:19 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:46712 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729801AbeGZUdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 16:33:18 -0400
Received: by mail-qt0-f193.google.com with SMTP id d4-v6so2690356qtn.13
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 12:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wEGRVeH5Q8R2kGDMLp5XLOOvYGg2avneZ4EvROwRhXI=;
        b=XzmD0Ecg8cYNKpi1HMQal9X9FRzKN0+bxM9dZPPg/WLtDiIavfkKw6MVfV1SRRYWCp
         0ZdNQDZDoyw3ggOzFO73UU1UF4wDBS1fM3HR/F7hDirnpsS747VbiP4f+/1EcaAwD2sW
         WALdEszI9qLHbaO/z7XATGcOw0Wd0C7xYdC4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wEGRVeH5Q8R2kGDMLp5XLOOvYGg2avneZ4EvROwRhXI=;
        b=Hs91NnCWMtmv9XskqNtXC7GIN3vDSWyofGh4c3biTzeSbG64uOIhLSXG6JvQ5iTnB8
         cBo0i15EDAcLMlQlko6REbPKl8Lo0URgmhRx/i2k6zhduyhm1x4EU8KQiIY+vjwdGcEL
         9gpEJmUJYRf/Lik9rzZUj07QDfubwyPdZ8W5nl8xAucNr75c6+i45ymgUQiSTMl07gll
         XB6yMisfVxw8sX340F10FPIfF0EYIMhHji+CGCLIgt88JDCw56zhp8tNXEaQXm7KChR5
         ftuIxmibZjSGXwisSE/RSsXbXSsloID/56HyosOA1ECF/eyQS9pBj0KMqXtxB/Jlt6Pj
         xrvA==
X-Gm-Message-State: AOUpUlEtDn3YuUak63Dz0XMNd/mp1vqWcCvEM9hVOe4nUz2Q4xoSGH70
        dATOjK+DxuTwJro9J1ZwL7YwinfGuKpZyw==
X-Google-Smtp-Source: AAOMgpcS3xTNb3I6OqbkvCzyqsm7WB9sEvQWc5czMZblOe3HM9IJchg4xmyPwCp8rC6dpcpjwax31w==
X-Received: by 2002:aed:3f7c:: with SMTP id q57-v6mr3225953qtf.256.1532632505678;
        Thu, 26 Jul 2018 12:15:05 -0700 (PDT)
Received: from [10.136.4.147] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id r27-v6sm2056201qkr.17.2018.07.26.12.15.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 12:15:05 -0700 (PDT)
Subject: Re: [PATCH 1/7] dt-bindings: net: Fix Broadcom iProc mdio mux driver
 base address
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
References: <1532630184-29450-1-git-send-email-arun.parameswaran@broadcom.com>
 <1532630184-29450-2-git-send-email-arun.parameswaran@broadcom.com>
 <20180726190103.GF10686@lunn.ch>
From:   Arun Parameswaran <arun.parameswaran@broadcom.com>
Message-ID: <35baf11b-0663-e221-5183-51c664a38e57@broadcom.com>
Date:   Thu, 26 Jul 2018 12:15:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180726190103.GF10686@lunn.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew

On 18-07-26 12:01 PM, Andrew Lunn wrote:
> On Thu, Jul 26, 2018 at 11:36:18AM -0700, Arun Parameswaran wrote:
>> Modify the base address passed to the Broadcom iProc MDIO mux driver
>> to point to the start of the block's register address space.
>>
>> Fixes: ce8d5dbfd64f ("Add DT binding doc for Broadcom MDIO bus multiplexer")
> 
> Hi Arun
> 
> Fixes generally means something explodes, throws an Opps, userspace
> does the wrong thing. Documentation/process/stable-kernel-rules.rst
> says:
> 
>  - It must fix a real bug that bothers people (not a, "This could be a
>    problem..." type thing).
> 
> Please explain how this is a real problem and what people it bothers.
> 
It is only relevant when we need to modify the registers which are not
currently accessible.

I will remove the 'fixes' and use the 'net-next' repo for the change
set.

> I also don't see any attempt to keep backwards compatibility with
> older device tree blobs. Is it intentional you will break such old
> blobs?
> 
I will modify the patch to keep backward compatibility like you
suggested in the other patch.

Thanks
Arun

> Thanks
> 	Andrew
> 
> 
>> Signed-off-by: Arun Parameswaran <arun.parameswaran@broadcom.com>
>> ---
>>  Documentation/devicetree/bindings/net/brcm,mdio-mux-iproc.txt | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/net/brcm,mdio-mux-iproc.txt b/Documentation/devicetree/bindings/net/brcm,mdio-mux-iproc.txt
>> index dfe287a..dc8aa68 100644
>> --- a/Documentation/devicetree/bindings/net/brcm,mdio-mux-iproc.txt
>> +++ b/Documentation/devicetree/bindings/net/brcm,mdio-mux-iproc.txt
>> @@ -18,9 +18,9 @@ at- Documentation/devicetree/bindings/net/mdio-mux.txt
>>  
>>  
>>  for example:
>> -		mdio_mux_iproc: mdio-mux@6602023c {
>> +		mdio_mux_iproc: mdio-mux@66020000 {
>>  			compatible = "brcm,mdio-mux-iproc";
>> -			reg = <0x6602023c 0x14>;
>> +			reg = <0x66020000 0x250>;
>>  			#address-cells = <1>;
>>  			#size-cells = <0>;
>>  
>> -- 
>> 1.9.1
>>
