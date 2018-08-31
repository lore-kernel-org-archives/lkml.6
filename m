Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EFB2C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46D74205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="R5pwB1oS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46D74205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728700AbeHaSnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 14:43:13 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:45242 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728670AbeHaSnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 14:43:12 -0400
Received: by mail-io0-f196.google.com with SMTP id e12-v6so10566724iok.12
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 07:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=T3TcGDh7WYqpBs4ofoZmit+HToqWQJzIHgvXNGnWwV4=;
        b=R5pwB1oSSQwlO8FeHs2AlmA+I15VJUdI6482voH6r/JAFfZiGyPqpjcjXLewXnT0TA
         QoSF0qAihyY76vIOiOaQbZ0OOniKS+HlEyLVNSb/ppp1Qewt08gSV6ZCV+hcFzFKCJcA
         Av1m5YEQgS3OFeqoDFkaKGmu2ST22mbM4y7jCNKGkqfs29DLQAAKp3GLBxrTjgSwzFEz
         Picg2bDhfXMTWq2jRZM5mHqT0u4r7j7zy0o6HhVbTPBSt18vozM9DJxywACmizcpSp+g
         c/QD8KKmpPKi6nU+yTw+5aD7sylYeBM8nv6qp25RM7tpg7CksZTNgNidm1HC6XjKN/5f
         lOyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T3TcGDh7WYqpBs4ofoZmit+HToqWQJzIHgvXNGnWwV4=;
        b=KcTQVrJLoWrcjIBcK0j55+oZ40XOJjIzLmX1qEOQwU9Y6WplxX7CrPFUJjuaAbJj90
         m2ht7K+w2zmWKQKmCHpkRd1/UAWCeUyRxHPQcdeNNsOAD7CgEYhW0AsILZjn4kz8cHR9
         A8V/8geQpr8Br+euIEfLnS5Y2+M+QAYvQhIODVOtpDWodIsYpb0tt0jKuQFwOIUg0uyL
         1b/snAO/PDDNfaR0zV5TL7TEib7XEk2WKIHg5LwDzsfv6yBmr1NItur4TYx1hy20k9l5
         2/5SMdtyF9u0+Uh6XLQv/xzQEm5aVjkrkDWKEQvbxkduZDFjMbBhCLVIIS+5XOopVHV/
         tY7g==
X-Gm-Message-State: APzg51BXe5LxEb9d6CywSmeXGQGglqwXw/M2+ajsoMdB2a6TvHI2JpOO
        RZQTtc1eArXZ6pBYTLFvcdcyAw==
X-Google-Smtp-Source: ANB0VdZRgVTZdWx9/ujZpwDMj9p4UVFXQexEF5Vfs/JG4odvLcigyrkAwke0n3lfS/UoPVc0UD/02A==
X-Received: by 2002:a5e:d612:: with SMTP id w18-v6mr12523752iom.54.1535726126088;
        Fri, 31 Aug 2018 07:35:26 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id u204-v6sm2273722itb.34.2018.08.31.07.35.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 07:35:24 -0700 (PDT)
Subject: Re: [PATCH v4 00/13] ata: ahci_platform: support allwinner R40 AHCI
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        LABBE Corentin <clabbe.montjoie@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-ide@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
References: <20180830190120.722-1-clabbe.montjoie@gmail.com>
 <f5838eae-fa6c-8699-14a4-95d0daa8a960@kernel.dk>
 <CAGb2v67miUjqeKeDh_E_XPee_0Hq1C6YrfXxsOp_=NtQY+LLmQ@mail.gmail.com>
 <8fa866c5-6800-505f-53bc-5c1b27582ca6@kernel.dk>
 <20180831074024.w7yicj5y4imy57e2@flea>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <39f89b9d-f5bf-7c4a-8e68-252bfc0b91a4@kernel.dk>
Date:   Fri, 31 Aug 2018 08:35:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180831074024.w7yicj5y4imy57e2@flea>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/18 1:40 AM, Maxime Ripard wrote:
> Hi Jens,
> 
> On Thu, Aug 30, 2018 at 08:52:52PM -0600, Jens Axboe wrote:
>> On 8/30/18 8:32 PM, Chen-Yu Tsai wrote:
>>> Hi,
>>>
>>> On Fri, Aug 31, 2018 at 4:31 AM Jens Axboe <axboe@kernel.dk> wrote:
>>>>
>>>> On 8/30/18 1:01 PM, Corentin Labbe wrote:
>>>>> Hello
>>>>>
>>>>> This patchset add support for allwinner R40 AHCI controller.
>>>>>
>>>>> The whole patchset is tested on sun8i-r40-bananapi-m2-ultra and
>>>>> on sun7i-a20-cubieboard2 which doesnt have any of the ressources added
>>>>> by this serie, so no regression should come with it.
>>>>>
>>>>> The last patch(ata: ahci_sunxi: remove PHY code) should not be merged,
>>>>> but will be resent for inclustion when all patchs will have hit linus
>>>>> tree.
>>>>
>>>> Applied 1-12 with Hans's blessing, thanks Corentin.
>>>
>>> Please don't merge device tree ("dts") patches, i.e. patches 9-12. We will
>>> merge them through the sunxi / armsoc tree. Having them in separate trees
>>> introduces conflicts when we have other stuff going through our tree.
>>
>> OK, fair enough, I can drop those.
> 
> And the DT bits actually have some issues that would need to change
> the code significantly.
> 
> Can you drop all of them please?

OK, can do. Corentin, please resend when everybody is happy with it.

-- 
Jens Axboe

