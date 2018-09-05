Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF51FC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44A1E20659
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Sm171yVX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44A1E20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbeIFBuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 21:50:52 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:34725 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727572AbeIFBuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 21:50:52 -0400
Received: by mail-it0-f66.google.com with SMTP id x79-v6so17935035ita.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 14:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GwJUhWIlZtUps0pRNip9h+XIuNpEKn2US8IDJRkXeOA=;
        b=Sm171yVX29ibBhdwfvrMEUziKQRXaoDq6xUtF+ndCedzskbCeKjqaKU0rpkSaSyxN/
         IvRDb05WEkm6i8BVJNhJAtbksR++YVmpIxAOTf9kutMPVMatW/52G3e/5HztldPLDSVT
         vPLdlnubPS0ZVeJ57sxU9Vlsf99Li/5lmWKzpzF2I8iXb3soZAK6vhvDFq441au1IUt5
         cTuG/Csk2USHUdtOmsfj4KZ9ehvthTqXPVTfxQjWfl4Kkbz3Ya091tlp2OeXOc2rwSrI
         bfZSNGCuHipzYpXK1Y6O2XvKMo7RAVLjYYk3nUpS5k8QFk8F/rk5/HYH0kUad2RlO1wE
         S66g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GwJUhWIlZtUps0pRNip9h+XIuNpEKn2US8IDJRkXeOA=;
        b=lMd00/4jSSoK9HQ89cf3mu+6aI0mkMOFZ57d91TEhVMSBzn7pdIdG6Bw2ygpLzXNM2
         D0NlMEnEofIrwAwvp1StNOZDxLhRFOPC5tccJ3HwXfnySoSA6QmnvkiCCeR667orJ0KB
         dCTna9IjAUPSvP1PxOPVER3hsvK4pN3HGZcAb/OAiS4fwyMXQNEf51zdBJUrVP5MM8Et
         Nk0TYINA4+jOSaR9afTLb7gyFG1c3y+Om95vZMwZqzmgC7QYydyXF6GapimJdjDzSWxb
         LlQY2rKZ4P7emdWkAhH4HQhCMwKoCw8Q8anvtSuT7vKXlgWro6AchRkDvBltUtV2RSP4
         dHww==
X-Gm-Message-State: APzg51C0xq859AhiAq8UHBqcZ7OAFDxZTomFTKeknmriG8yT+m1VsJhr
        F5OSRsD0oMIa53zJVGMCpx9U1A==
X-Google-Smtp-Source: ANB0VdZ3rfD2uAhlKTGqzdCVuUnXC+Grr7YUAia9PhW7MKCXehLjWJ6HQN1FGZCyFn3sELLOSasOQQ==
X-Received: by 2002:a24:be8f:: with SMTP id i137-v6mr197941itf.61.1536182331670;
        Wed, 05 Sep 2018 14:18:51 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id w64-v6sm1504239ita.7.2018.09.05.14.18.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 14:18:50 -0700 (PDT)
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
 <34d9b2f7-9e6d-4a0a-77e5-ec0e99610f5c@kernel.dk>
 <c41c802c-9235-5383-2dfa-af9c1553f11b@deltatee.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <957591a9-3b9d-e730-9919-508349735db9@kernel.dk>
Date:   Wed, 5 Sep 2018 15:18:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <c41c802c-9235-5383-2dfa-af9c1553f11b@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/18 3:03 PM, Logan Gunthorpe wrote:
> 
> 
> On 05/09/18 02:36 PM, Jens Axboe wrote:
>> On 9/5/18 2:32 PM, Logan Gunthorpe wrote:
>>>
>>>
>>> On 05/09/18 02:19 PM, Jens Axboe wrote:
>>>> On 9/5/18 2:18 PM, Logan Gunthorpe wrote:
>>>>>
>>>>>
>>>>> On 05/09/18 02:14 PM, Jens Axboe wrote:
>>>>>> But if the caller must absolutely know where the bio will end up, then
>>>>>> it seems super redundant. So I'd vote for killing this check, it buys
>>>>>> us absolutely nothing and isn't even exhaustive in its current form.
>>>>>
>>>>>
>>>>> Ok, I'll remove it for v6.
>>>>
>>>> Since the drivers needs to know it's doing it right, it might not
>>>> hurt to add a sanity check helper for that. Just have the driver
>>>> call it, and don't add it in the normal IO submission path.
>>>
>>> I'm not sure I really see the value in that. It's the same principle in
>>> asking the driver to do the WARN: if the developer knew enough to use
>>> the special helper, they probably knew well enough to do the rest correctly.
>>
>> I don't agree with that at all. It's a "is my request valid" helper,
>> it's not some obscure and rarely used functionality. You're making up
>> this API right now, if you really want it done for every IO, make it
>> part of the p2p submission process. You could even hide it behind a
>> debug thing, if you like.
> 
> There is no special p2p submission process. In the nvme-of case we are
> using the existing process and with the code in blk-core it didn't
> change it's process at all. Creating a helper will create one and I can
> look at making a pci_p2pdma_submit_bio() for v6; but if the developer
> screws up and still calls the regular submit_bio() things will only be
> very subtly broken and that won't be obvious.

I'm very sure that something that basic will be caught in review. I
don't care if you wrap the submission or just require the caller to
call some validity helper check first, fwiw.

And I think we're done beating the dead horse at this point.

-- 
Jens Axboe

