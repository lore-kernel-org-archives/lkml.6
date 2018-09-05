Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C278C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 20:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 079B720645
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 20:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="lkmEPxUH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 079B720645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbeIFBIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 21:08:51 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:45277 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727962AbeIFBIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 21:08:51 -0400
Received: by mail-io0-f195.google.com with SMTP id e12-v6so7064407iok.12
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 13:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gY5o9ua+f1nyI7zjfo+Jmm/sZ/ain01iPpxJ1bvEMMU=;
        b=lkmEPxUHVGyhlJ8XyftPS7q76JZUvTtq8Rsypl3G05eHs7YQEAAEjjqbORqTNwvgH0
         A8L4WKl6lNT3M9NWA+OxUN8cVCFCIfA0uuu3w5k4F6CVwxEsd9MxSpeVutjApijJ12Xu
         UDtgxdk/v8vNytsv4Z4E32P7q+waTBiqDDAwC6C6u4/+/q9YW/npXuudvXVV3KJ0tgBW
         rfvEJyOUmwIK/uG0sJaycUm0Ii7CqyIpsgI30+xUs7/5zoKxoVLmqcLvUUDjjZg0oSv1
         kmAljYw1Ri1YfVJpo5PxgToEWKz9GHUKroIK8K9v/M/pytFpS46uHFP+5I2ZAOWSN0rA
         5NXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gY5o9ua+f1nyI7zjfo+Jmm/sZ/ain01iPpxJ1bvEMMU=;
        b=NoKMepeKUc+6yPSsPHZXlWTv6V5UggGLyXRnhSB9OTKi5/kN12O4TLklQaOzFvORBr
         pcrNeVeHkR+mt3B3JITVt/zqjl+8drLWz9uu3FGSmdGeQISncST60+ZmqQGuYF7pa0IY
         ejHBqa0pHADS31WQ0xslKQMfXBGjHbxVrYBRPGKbhmPnWzvhXzBHDdjeZBBgJ3YDDgcr
         gVf5kYKu5hQp50tx1Czo6DJGNVWLNACYet0Ss2SeAJT6jEw0vp3FGHAmRi5JQqdYxlOR
         qkXzU11zAhocgtS9lof7w3jcDzBmk5llLJHqwIq0/rvazaCCHOFjsQ1OiLnTdf26TXnS
         naww==
X-Gm-Message-State: APzg51BdQEb6HNQoFVWEx2ePQYa6umZkxX2kKxMk6KgOGKyAI9HgFZ3Z
        2yL8Ypw/tp74puLG2VOaLETFXA==
X-Google-Smtp-Source: ANB0Vda1odh/MnEXgunylann8L2l6J+F0MWotCcMfDLoBFEoaaKtnahEQ5nyZV2uVIdaPRod+iGDSg==
X-Received: by 2002:a6b:25d2:: with SMTP id l201-v6mr26958207iol.115.1536179819165;
        Wed, 05 Sep 2018 13:36:59 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id v3-v6sm2145245ita.6.2018.09.05.13.36.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 13:36:57 -0700 (PDT)
Subject: Re: [PATCH v5 07/13] block: Add PCI P2P flag for request queue and
 check support for requests
To:     Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-block@vger.kernel.org,
        Stephen Bates <sbates@raithlin.com>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20180830185352.3369-1-logang@deltatee.com>
 <20180830185352.3369-8-logang@deltatee.com>
 <b5ab8fa3-34ac-3117-fa0d-5206c3939435@kernel.dk>
 <20180901082812.GB670@lst.de>
 <5f79c012-c6e1-56bb-62fd-0689181fb2c9@deltatee.com>
 <59b28977-8f2a-6228-2050-03fae6bdbedd@kernel.dk>
 <1b4283da-44df-4a02-3167-e295243cef78@deltatee.com>
 <09258b9b-3aed-9890-b31a-bd70a133966c@kernel.dk>
 <20180905195647.GA1626@lst.de>
 <bcc1b3cf-2fd9-fa61-9cfb-b0e4d84e5d94@kernel.dk>
 <20180905201152.GA1893@lst.de>
 <eb42fb94-9da6-955b-8524-0a0f5ac4bd19@deltatee.com>
 <2a3394bd-5f13-4818-43f4-dfc61f501e05@kernel.dk>
 <e3ef26e6-6c8d-25b8-fa64-14594a51263c@deltatee.com>
 <3af4d1d4-da07-c0a6-8464-9ddc1378f2f4@kernel.dk>
 <f9e660cd-b597-bb6e-56a2-82fe71cb3649@deltatee.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <34d9b2f7-9e6d-4a0a-77e5-ec0e99610f5c@kernel.dk>
Date:   Wed, 5 Sep 2018 14:36:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <f9e660cd-b597-bb6e-56a2-82fe71cb3649@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/18 2:32 PM, Logan Gunthorpe wrote:
> 
> 
> On 05/09/18 02:19 PM, Jens Axboe wrote:
>> On 9/5/18 2:18 PM, Logan Gunthorpe wrote:
>>>
>>>
>>> On 05/09/18 02:14 PM, Jens Axboe wrote:
>>>> But if the caller must absolutely know where the bio will end up, then
>>>> it seems super redundant. So I'd vote for killing this check, it buys
>>>> us absolutely nothing and isn't even exhaustive in its current form.
>>>
>>>
>>> Ok, I'll remove it for v6.
>>
>> Since the drivers needs to know it's doing it right, it might not
>> hurt to add a sanity check helper for that. Just have the driver
>> call it, and don't add it in the normal IO submission path.
> 
> I'm not sure I really see the value in that. It's the same principle in
> asking the driver to do the WARN: if the developer knew enough to use
> the special helper, they probably knew well enough to do the rest correctly.

I don't agree with that at all. It's a "is my request valid" helper,
it's not some obscure and rarely used functionality. You're making up
this API right now, if you really want it done for every IO, make it
part of the p2p submission process. You could even hide it behind a
debug thing, if you like.

> I guess one other thing to point out is that, on x86, if a driver
> submits P2P pages to a PCI device that doesn't have kernel support,
> everything will likely just work. Even though the driver isn't doing any
> of the work correctly and the requests are not being mapped with
> pci_p2pdma_map() functions. Such code on other arches would likely
> break. So developers may be lulled into thinking they're doing the
> correct thing when in fact they are not and the WARN in the common code
> would prevent that.

If you're adamant about having it in common code, put it in your
common submission code. Most folks aren't going to care about P2P, let the
ones that do have the checks.

-- 
Jens Axboe

