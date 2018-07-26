Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0E8C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 21:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06D5720673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 21:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="WBuYpgP5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06D5720673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731605AbeGZWch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 18:32:37 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:36897 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731405AbeGZWcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 18:32:36 -0400
Received: by mail-it0-f65.google.com with SMTP id h20-v6so4647269itf.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 14:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Sv7UNFOsXx9d7/bd4JzN9SRFb5en8EumoG9ciIGHkDU=;
        b=WBuYpgP5Po/vKvudsmZ/HTSdKa5yXSnSUjODKbWAAUedVLwgI2n7uZbDuya/GNkUET
         wLtrcz1It3rMFeXZWSDXjY4kgzx4eifWPAYpEhn9cTLBvQ0N3lsSA28sQ7FG1zryuubQ
         oAihXwsi3RBRA/GAgmNoJs1PbqwiRVjZLJRQfsRdXsfxzXu9K6d+H73//dD9YpcvSUUW
         6tMLFgT4NyHFU8/HUqnyv3UD0kgYMCmBvC/L+uCy8ro6kncnrzS4iXSDFgYXvQdkvZUQ
         0r3NgQZbVJh0uHJmTKUubU7RV1pVnZn7Oal7HQ8jyuksywOCJTLwkuBN0YDR15zRqV+O
         rKtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Sv7UNFOsXx9d7/bd4JzN9SRFb5en8EumoG9ciIGHkDU=;
        b=fB+ERkUOQKVI1Hcg72B3jWWC1Aqm65oatM3PUMhPV55T9I4PUzmfknCTOxJh8NB6ai
         4maeaSOQe2Hm4q8v+0SaA1Uo1Hbr5K2/R9MvSGEemTigF3+O0XYSpNScrz4E7+KYYMDA
         KQ495y5H0GYbI8T0nUTM2btGmG5pP/pn+d89sYwJtmodNnyBVx0RkYS6QijhbY6ry8nB
         ZNmc1oMMGHSEHM5CBw+R1Ku8jUAv/uAWVRk8Mw28OViYKQbZDnboGt5yBV3Ji0kfNlPy
         nXBUc4f/yYIkxbCe17lPLwX1OrXS9AqUdbcFSUkf6QYqCDTF1MdCAYg6Rl4EFmHaf85b
         a3eQ==
X-Gm-Message-State: AOUpUlGDXwBuhljwY/4ZIW2uHFjsSjSwd2dM2a+PzF2rnCUS4tnCCEB4
        JgTlrwc2cZjnX1Eg9JTG/sARCA==
X-Google-Smtp-Source: AAOMgpeSILjvAv94tLe/CbcrfwsEYpT1LvxVa0PmRJmQWjysGmBfaVptcQmMlEUbMHLy0BJxJDNfYw==
X-Received: by 2002:a24:c2c2:: with SMTP id i185-v6mr3471972itg.76.1532639639066;
        Thu, 26 Jul 2018 14:13:59 -0700 (PDT)
Received: from [192.168.1.212] (107.191.0.158.static.utbb.net. [107.191.0.158])
        by smtp.gmail.com with ESMTPSA id v3-v6sm667037iop.78.2018.07.26.14.13.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 14:13:57 -0700 (PDT)
Subject: Re: linux-next: build failure after merge of the block tree
To:     Bart Van Assche <bart.vanassche@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steve Wise <swise@opengridcomputing.com>
References: <20180726145624.13a604ed@canb.auug.org.au>
 <20180726084833.GA23310@lst.de>
 <a65a6023-a527-b9c6-0d78-a175d47f55cf@kernel.dk>
 <bddc1cad-5646-edf5-2253-9490717ae8e5@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3e162f1d-f252-0f76-8929-fa9a0f566cb2@kernel.dk>
Date:   Thu, 26 Jul 2018 14:13:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <bddc1cad-5646-edf5-2253-9490717ae8e5@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/18 1:54 PM, Bart Van Assche wrote:
> On 07/26/18 10:48, Jens Axboe wrote:
>> On 7/26/18 1:48 AM, Christoph Hellwig wrote:
>>> On Thu, Jul 26, 2018 at 02:56:24PM +1000, Stephen Rothwell wrote:
>>>> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
>>>> index 86121a7a19b2..8c30ac7d8078 100644
>>>> --- a/drivers/nvme/target/rdma.c
>>>> +++ b/drivers/nvme/target/rdma.c
>>>> @@ -891,7 +891,7 @@ nvmet_rdma_find_get_device(struct rdma_cm_id *cm_id)
>>>>   
>>>>   	inline_page_count = num_pages(port->inline_data_size);
>>>>   	inline_sge_count = max(cm_id->device->attrs.max_sge_rd,
>>>> -				cm_id->device->attrs.max_sge) - 1;
>>>> +				cm_id->device->attrs.max_send_sge) - 1;
>>>
>>> This should be max_recv_sge.
>>
>> Why do we even have this conflicts to begin with?
> 
> Hello Jens,
> 
> A detailed description of why that change is necessary is available at
> https://www.spinics.net/lists/linux-rdma/msg65954.html. As far as I know
> the entire RDMA community supports that change.

Thanks - I'm not against the change, I just always get a little
suspicious when we have merge conflicts across subsystems. But this
one seems warranted.

-- 
Jens Axboe

