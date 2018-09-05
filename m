Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32CCFC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C575920839
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="C0JO0Hzl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C575920839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbeIFAQs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 20:16:48 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:39614 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727688AbeIFAQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 20:16:48 -0400
Received: by mail-it0-f66.google.com with SMTP id h1-v6so11053013itj.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 12:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0fECAhizIBhNxKtSSNpeEPwN82HgUK6SANPtOTiRX3A=;
        b=C0JO0HzlyB6DKiLtE+2ATnwMKLPynRriso+Qzb6qlfy5Ol/7zCj9bRH9bmCQWXjnEM
         8AcikyaqX9nUpVA2qoB6XUdxmo6kB1xCMyHOzIfVlROITrttDe2V4j7eseNMha8TUVfi
         eFwawxNh25mM5Bt+DyZzdxyPTGfV5QiXJXDJgyzBLTJCEc6PmNVsO1OVH2+LQHe2ljih
         fWE3RJm6KQvqUYhJiYVlXrw2V+DHq6EoSk6Y/rIRE18FAiZXMlaodC2lIrvvHjOzQoiI
         Fwg3YLivA18CKpLLUjgW8jDrQY+UrdDwwM+mw3JHV29OHUT3JJIvPz9Yhm7bDc2SNDTv
         mDTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0fECAhizIBhNxKtSSNpeEPwN82HgUK6SANPtOTiRX3A=;
        b=Q6Yj3HVWMR8oTFBIdRncAO4zGdRxdN+Q3rahKvBMkku/iG7XLJ2C8A6XANG1WvDcPM
         kYSpw1GYNjODmMS0dhxKjbT5ww51b/JupqF+0C/R018mZU4eeBVRB4PdcY3mXsugVswk
         uaRAMBK00TXAjCNzsLAE9v20e5Hl7UNpfsRX6uLKYfwtN9JRJkJ62tRaYxl05G6oXUqV
         FnFwj84B3jptmUk14WGCtV84uUaBTFeKyjoC23+fDzVbPtjuKyQvcWlgtmWSVGnxuicO
         X5JTsPdDdqLpp2D38aFVvKjM+F/a17ZCz95ZyD28hW2iWYCioakYQr9OK2xancteYXjR
         oPfw==
X-Gm-Message-State: APzg51B2phZTLz3NYxv0vXif10y5KEmS0zNSnrPwtTd+vxWVn2yTHdA2
        Pt8eHZU8W4nvGqVLUbw7BT81Lg==
X-Google-Smtp-Source: ANB0VdbM4mEHbZ6kEbfGcMvYUTS6B8esz+nJHvNXOgiBuOKqRQp41EeH1IPDe7RHGhrt3waSl6Kvuw==
X-Received: by 2002:a02:b459:: with SMTP id w25-v6mr26739326jaj.32.1536176707638;
        Wed, 05 Sep 2018 12:45:07 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id b3-v6sm1166648itj.32.2018.09.05.12.45.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 12:45:06 -0700 (PDT)
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
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <09258b9b-3aed-9890-b31a-bd70a133966c@kernel.dk>
Date:   Wed, 5 Sep 2018 13:45:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <1b4283da-44df-4a02-3167-e295243cef78@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/18 1:33 PM, Logan Gunthorpe wrote:
> 
> 
> On 05/09/18 01:26 PM, Jens Axboe wrote:
>> On 9/3/18 4:26 PM, Logan Gunthorpe wrote:
>>> I personally agree with Christoph. But if there's consensus in the other
>>> direction or this is a real blocker moving this forward, I can remove it
>>> for the next version.
>>
>> It's a simple branch because the check isn't exhaustive. It just checks
>> the first page. At that point you may as well just require the caller to
>> flag the bio/rq as being P2P, and then do a check for P2P compatibility
>> with the queue.
> 
> Hmm, we had something like that in v4[1] but it just seemed redundant to
> create a flag when the information was already in the bio and kind of
> ugly for the caller to check for, then set, the flag. I'm not _that_
> averse to going back to that though...

The point is that the caller doesn't necessarily know where the bio
will end up, hence the caller can't fully check if the whole stack
supports P2P.

What happens if a P2P request ends up with a driver that doesn't
support it?

-- 
Jens Axboe

