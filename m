Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E220C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E11AD2082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="MaO7F6Iw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E11AD2082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbeH3XXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 19:23:09 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:37701 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727229AbeH3XXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 19:23:09 -0400
Received: by mail-io0-f196.google.com with SMTP id v14-v6so8499015iob.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 12:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mroj/0Oz64/AelOC6y8tjEVjwRywlncLvvzQ9lzBmq8=;
        b=MaO7F6Iwfon4A9vMqZ6iGa6VQrUonYavelIy5l3wWW/GhTkrcFZoiIoy0YhLPItOvA
         5vCNKwnl++rm19iJ+64S+u9MHP8E6Q9iuir7bLcgPsxa96fwMVTCr055gs/n7rPmFAXS
         OfIwMR4LFPO3yccTESsMHXwlf31bbV5vszNZsPx0X66U25XpoiIMhyr2h97c2meyF6ju
         uARhuUQWTOo4SjB1TeIn5ZwkTNUcsL4zj2SGndR6jUPn4SqKwkKh1lkxiWpDX7NvPDwZ
         wJPTqUEfyXZIVnPp4MCIL9a481+B4YBtQFEqv5sblzin8bfy17oZ+BJeORXIch0cUjoN
         oazw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mroj/0Oz64/AelOC6y8tjEVjwRywlncLvvzQ9lzBmq8=;
        b=N+8+0IHKo68Cn4iY7rP9XSqr+/wmLMvna4k06BVuemKSc4+U7GM3L9DjtAws/npKnY
         ITtqtJb6PaB67WcjQViFFoHSDvIyiZaa5EPr0LPO1/y8MX+ho1iSuY5O4nSPZgdxmeff
         7ZEQ/k9mvUjl65KyD+kc0zYlfkQDwyZukMTe7GQlpY4gFaHrfBNi1nET3xBq6DMYYYQF
         Lq8EekGGSq2Iw4DMUgiB9Y9bichmQ2aS1ZIUUzyoktYUzpWCW4d2wuzZ8DwjSXHq/ldm
         CiMEKX0eehcMLvCTH8pvQwcY8egYCtLj+j6/UNot3iO6V0uMrAio5EYw08mRbV1WQ9Hg
         F7xA==
X-Gm-Message-State: APzg51AFoNIFsBZjc/Fr9WgsOPcUj36ZzPwlfOJ8xrzMdr4BujJfkG+z
        FrTuU6BDlxux7HWNkzNiMmXEgQ==
X-Google-Smtp-Source: ANB0VdaW5AlaaaNjQ4bSLZjuX9NnuxMaLw7sfiM8lhfROJzuBkx6Wg0nwu6RuDBAWFzMLD+k7Py8YA==
X-Received: by 2002:a5e:9615:: with SMTP id a21-v6mr9982289ioq.53.1535656768604;
        Thu, 30 Aug 2018 12:19:28 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id i20-v6sm1345140iti.15.2018.08.30.12.19.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 12:19:27 -0700 (PDT)
Subject: Re: [PATCH v5 07/13] block: Add PCI P2P flag for request queue and
 check support for requests
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-block@vger.kernel.org
Cc:     Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
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
 <7c5b9d2c-d94e-582c-f1d7-0827dbb7df7c@deltatee.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <56e1a633-bad3-cac7-13b4-747f0001f5c8@kernel.dk>
Date:   Thu, 30 Aug 2018 13:19:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <7c5b9d2c-d94e-582c-f1d7-0827dbb7df7c@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/18 1:17 PM, Logan Gunthorpe wrote:
> 
> 
> On 30/08/18 01:11 PM, Jens Axboe wrote:
>> On 8/30/18 12:53 PM, Logan Gunthorpe wrote:
>>> QUEUE_FLAG_PCI_P2P is introduced meaning a driver's request queue
>>> supports targeting P2P memory.
>>>
>>> When a request is submitted we check if PCI P2PDMA memory is assigned
>>> to the first page in the bio. If it is, we ensure the queue it's
>>> submitted to supports it, and enforce REQ_NOMERGE.
>>
>> I think this belongs in the caller - both the validity check, and
>> passing in NOMERGE for this type of request. I don't want to impose
>> this overhead on everything, for a pretty niche case.
> 
> Well, the point was to prevent driver writers from doing the wrong
> thing. The WARN_ON would be a bit pointless in the driver if we rely on
> the driver to either do the right thing or add the WARN_ON themselves.
> 
> If I'm going to change anything I'd drop the warning entirely and move
> the NO_MERGE back into the caller...

Of course, if you move it into the caller, the warning makes no sense.

> Note: the check will be compiled out if the kernel does not support PCI P2P.

Sure, but then distros tend to enable everything...

-- 
Jens Axboe

