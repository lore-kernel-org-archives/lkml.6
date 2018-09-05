Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A844C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 20:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8EE82073D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 20:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Z6lGVNAJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8EE82073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbeIFAqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 20:46:39 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:37559 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727955AbeIFAqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 20:46:38 -0400
Received: by mail-it0-f53.google.com with SMTP id h20-v6so11172533itf.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 13:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EwfboM9jZUO13Bzodil9bm0IpV5Cci/yRxwfapPgYIM=;
        b=Z6lGVNAJl3O/T2p0V8Chgvp1lYSDbbf2kiJT5XwnguCr8BY3C80QNvhFQsOvuBIPVw
         veQhd/eWuruhWF95e9TyWJMlBm5uJb4rxKViCUSwLBdvZ7tWFoF0dguhqGxO1o6R2fYw
         PJwD5umAYc8BFCO4f+WiQc4VKbu7VtrlFe5EPc1r/Kl/XDGIU06IXbzXV62aO8UnJDmL
         9jsyYtbXfALo+ksqIchPVlrVr48gi/SXtwLc/iyZAgDaUUKGIsvIQPlAxltU5a6XgHDh
         3F70BNzXEZwXjdVTh/dJGoJUW4nk5NdFFfO/F7vhoH6uB+Ml9KDPQpNz0uow2Pi2S6j0
         BfBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EwfboM9jZUO13Bzodil9bm0IpV5Cci/yRxwfapPgYIM=;
        b=jRD+bJggxd/jAXHsh+VG1HVm3B0rJDyzq86Xn4I5o+Mni2rIwUMcABRZhJyPQQlKFq
         nvZ/88Fh8lmLA/K166PTBLrIKuDDQPH+9XiFT5UXu+3E4CQIaPyl8sm1WILmOcVJZTTd
         9+2/Xfg6QAHs3xda8E29Gx1C0n2zh+AFnyuZ8Mdg+ZVThxccOhW2grP+ra0QtqsV+gPY
         OTPmtyswKTUbqLLLtxJZzu592BiKtEF4Fw9+9qG+wSpPCsL8cVZZgj7b7Tq4WWPbo5WW
         WA+1LIgOrxg0wuOShAc6PZo58RsRBkiomytkXb5uwzXWwBv9Rf5MPpytvfhqAJ+iESu0
         MBRg==
X-Gm-Message-State: APzg51AWA1nSKCC5BDxAXqMWFQE23Ied8cDEMuku5SKIVU/D6C930o8/
        PLC4UJydOqqHj2qse8H6LCmQfQ==
X-Google-Smtp-Source: ANB0VdZu6dDvBOUmeN+DPI1YAgZitD7XIt58kVWxMmjic3lCjlwWeMYu31KW2ZjLPD9OV48GNVQaTQ==
X-Received: by 2002:a24:5004:: with SMTP id m4-v6mr59900itb.38.1536178491314;
        Wed, 05 Sep 2018 13:14:51 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id d134-v6sm902201iog.84.2018.09.05.13.14.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 13:14:50 -0700 (PDT)
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
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2a3394bd-5f13-4818-43f4-dfc61f501e05@kernel.dk>
Date:   Wed, 5 Sep 2018 14:14:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <eb42fb94-9da6-955b-8524-0a0f5ac4bd19@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/18 2:09 PM, Logan Gunthorpe wrote:
> 
> 
> On 05/09/18 02:11 PM, Christoph Hellwig wrote:
>> On Wed, Sep 05, 2018 at 01:54:31PM -0600, Jens Axboe wrote:
>>> On 9/5/18 1:56 PM, Christoph Hellwig wrote:
>>>> On Wed, Sep 05, 2018 at 01:45:04PM -0600, Jens Axboe wrote:
>>>>> The point is that the caller doesn't necessarily know where the bio
>>>>> will end up, hence the caller can't fully check if the whole stack
>>>>> supports P2P.
>>>>
>>>> The caller must necessarily know where the bio will end up, as for P2P
>>>> support we need to query if the bio target is P2P capable vs the
>>>> source of the P2P memory.
>>>
>>> Then what's the point of having the check at all?
>>
>> Just an additional little safe guard.  If you think it isn't worth
>> it I guess we can just drop it for now.
> 
> Yes, the point is to prevent driver writers from doing the wrong thing
> by not doing the necessary checks before submitting to the queue.

But if the caller must absolutely know where the bio will end up, then
it seems super redundant. So I'd vote for killing this check, it buys
us absolutely nothing and isn't even exhaustive in its current form.

-- 
Jens Axboe

