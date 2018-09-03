Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10656C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 12:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 834B020862
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 12:58:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 834B020862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbeICRS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 13:18:57 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44304 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbeICRS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 13:18:57 -0400
Received: by mail-ed1-f67.google.com with SMTP id s10-v6so704036edb.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 05:58:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gkMw77JGqjvMY2EmL0avAdwpMnxdvHf8T0MHM4nzKGI=;
        b=iJhjiHjc/2mAmGLd+pZ3dl7MXnw9Uoj4Y4GcAaFZdCrvfwnTA/buu6SkTwJPFlVcmJ
         zPq2EoPYuMzImvGVYb7mwTEZ9mAkmz8pC8dTkBLdDIX2ADH4cyBefTCMFKC9IzKoIfs1
         QsIe7DAF/VtvdnlTxCPGpHmt8vxqvtrXoSQB83AsEQRx4/rkIs7HqIFPNAkCAXPDcO68
         FwGx4+0YoE24Ri2zwxv/74A8uFrE3vlZJpCHp004FTHTvkZtZSfqMkzVfE+9C2xqGosT
         p1YbeL2JCqdznyvVw9i4k9fL4yangos7FsK25oXiLvRuAUnVLLFiNs+dXmFAd/+cX+5k
         utYg==
X-Gm-Message-State: APzg51CLtxaHmdNMra8a/MqUUeqSbLxwvfuzwNrNloTfaZZannrAVAwe
        5CcwdkajiEKon9EObd/2cJI5VQ==
X-Google-Smtp-Source: ANB0Vdbp/gfj+4jGmZH0D8aY/8A2xd9euCbBmJIaIjc1Zt1COWlm4zDw5jkq9rAuW67p/OeJp91EHg==
X-Received: by 2002:a50:eb96:: with SMTP id y22-v6mr32116152edr.38.1535979533405;
        Mon, 03 Sep 2018 05:58:53 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id p28-v6sm13376528eda.85.2018.09.03.05.58.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 05:58:52 -0700 (PDT)
Subject: Re: [PATCH v5 0/9] ata: ahci_platform: support allwinner R40 AHCI
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     axboe@kernel.dk, mark.rutland@arm.com, robh+dt@kernel.org,
        wens@csie.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
References: <20180903100201.23131-1-clabbe.montjoie@gmail.com>
 <20180903124229.rchurusvt4rv5ln7@flea>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <34c6fda4-c266-8aff-e685-e6a6ee2c7890@redhat.com>
Date:   Mon, 3 Sep 2018 14:58:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180903124229.rchurusvt4rv5ln7@flea>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 03-09-18 14:42, Maxime Ripard wrote:
> On Mon, Sep 03, 2018 at 12:01:52PM +0200, Corentin Labbe wrote:
>> This patchset add support for allwinner R40 AHCI controller.
>>
>> The whole patchset is tested on sun8i-r40-bananapi-m2-ultra and
>> on sun7i-a20-cubieboard2 which doesnt have any of the ressources added
>> by this serie, so no regression should come with it.
>>
>> Patchs 1-7 should go via the ata tree
>> Patchs 8,9 should go via the sunxi tree
>>
> 
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

The entire series looks good to me too:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans
