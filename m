Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F45AC5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 18:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A9DA2083D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 18:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="XSSRWD+p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A9DA2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935828AbeFRSL0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 14:11:26 -0400
Received: from smtprelay6.synopsys.com ([198.182.37.59]:42849 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935533AbeFRSLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 14:11:24 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id D8BE41E04FD
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 20:11:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1529345483; bh=KklUq1GJk9Bw5hmSaZKjX9Pu+3ekeecZANQ/EjIDMuI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=XSSRWD+pQq+EFQNleU7sxdp+cKmC54hPkDh+47mm8LBjARnjME3KUBMWduSje6pno
         qDmB2Q0UAFfnwwKcbX2aokI+vOdxVfp/+Vixjr8VOzO4qv9EeDI8LJs/NVLm4UEJ6s
         m2cnMkbWUqA9LKqS1jfWx7k+YQaDP+DXvOiZr3pXOPWn2ta2zGUJww/3RsioJXCb+m
         8TaXSoyjEeELmvvlCwE/MYybym9GA8Db3sWPlSOuZca+TfHHnvAK+jhFmlaS1yAunU
         dv8nHG6cPXsdGzlAC3hDi5+zbQWkGeskU8z9VXBsIMG3POeNr70c69buWYnEbkcx1t
         IT+hpso2WiNng==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1.internal.synopsys.com [10.12.239.235])
        by mailhost.synopsys.com (Postfix) with ESMTP id 3EA7C3FFE;
        Mon, 18 Jun 2018 11:11:22 -0700 (PDT)
Received: from IN01WEHTCB.internal.synopsys.com (10.144.199.106) by
 us01wehtc1.internal.synopsys.com (10.12.239.231) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Mon, 18 Jun 2018 11:11:01 -0700
Received: from IN01WEHTCA.internal.synopsys.com (10.144.199.103) by
 IN01WEHTCB.internal.synopsys.com (10.144.199.105) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Mon, 18 Jun 2018 23:40:59 +0530
Received: from [10.10.161.98] (10.10.161.98) by
 IN01WEHTCA.internal.synopsys.com (10.144.199.243) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Mon, 18 Jun 2018 23:40:58 +0530
Subject: Re: [PATCH] ARC: Add PCIe support for ARC HSDK platform
To:     Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>
CC:     "robh@kernel.org" <robh@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Eugeniy.Paltsev@synopsys.com" <Eugeniy.Paltsev@synopsys.com>,
        "sboyd@codeaurora.org" <sboyd@codeaurora.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
References: <3e9a2f384fd831fb2639ad99ec43ce0f019ac17c.1529333762.git.gustavo.pimentel@synopsys.com>
 <ba4b10e967fb39d18eba7a5c70abb167308481f5.camel@synopsys.com>
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
Openpgp: preference=signencrypt
Autocrypt: addr=vgupta@synopsys.com; keydata=
 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
 i91ThhqBJlyU6MVUa6vZNv8E
Message-ID: <562939df-4c97-c19b-72e3-14196a651c40@synopsys.com>
Date:   Mon, 18 Jun 2018 11:10:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <ba4b10e967fb39d18eba7a5c70abb167308481f5.camel@synopsys.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.10.161.98]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/18/2018 08:20 AM, Alexey Brodkin wrote:
>> +static void __init hsdk_enable_gpio_intc_wire(void)
>> +{
>> +	u32 val = GPIO_HAPS_INT;
>> +
>> +	iowrite32(0xffffffff, (void __iomem *) GPIO_INTMASK);
>> +	iowrite32(~val, (void __iomem *) GPIO_INTMASK);
>> +	iowrite32(0x00000000, (void __iomem *) GPIO_INTTYPE_LEVEL);
>> +	iowrite32(0xffffffff, (void __iomem *) GPIO_INT_POLARITY);
>> +	iowrite32(val, (void __iomem *) GPIO_INTEN);
>> +}
> I would suggest to have a map of really used lines and enable all of them
> instead of adding one-by-one occasionally.

More importantly, adding any code in this file is an absolute abomination and only
desired if this is a platform specific hack which can't be added in the generic
driver and/or specified via the Device Tree. Here it seems like we are enabling
some gpio lines which likely could be done via the gpio driver paths ?

-Vineet
