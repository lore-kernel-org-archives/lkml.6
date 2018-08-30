Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A8DC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A957C20835
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="V+Sm+tjU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A957C20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbeH3XPB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 19:15:01 -0400
Received: from mail-it0-f43.google.com ([209.85.214.43]:55054 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727117AbeH3XPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 19:15:01 -0400
Received: by mail-it0-f43.google.com with SMTP id f14-v6so4055220ita.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 12:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=g7v8KVcLqnDf+9fgon1CPhLtcLM3PxMlyVE5fEOaYy8=;
        b=V+Sm+tjU4jJvxkGil6YXxVdlrRSp9QEl9ThCk6xJOptUlf7rcKWJ7QywM9/+d6lgg9
         Cv2bMEuuW6zPwi6zn1dRmYpPY/sXubUICzIBxrBKZNy2uuJsAdBSqhYUNdgNy6MTdCeu
         gRnHOW+Jl2J0ClRNlgGwt5L/HlQoSXMvnFGOa7eeTAWMKuvtPO8XPr0HpxMlw4CK7lvu
         7z7qXzGLMtBUYqMJsy6wSElWea9uf1LnMHM3GhlusIPLLXdVEL/UzY2JYrMltm7Sc0X1
         tZETb3g76uK7wTQj+fcjWY1NqVNJ1qBu+9hpsS3TCFFMUOybny97iVbmMbI2NKz5KnzV
         pr1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g7v8KVcLqnDf+9fgon1CPhLtcLM3PxMlyVE5fEOaYy8=;
        b=YULVnO/FOkVH++LE86Rvl4u1m4W61SOI0dcDCWoPpzgvYxwxttAek0rVi/60Cxcc2c
         p0xYivPK2Dxjt4qy0iOxbL0ld7aWUHrg7XEsn8RhO0lgTqfnNp+l2yVPBmRke6ndAEI6
         Jm8QZ3qKm6GtfzVcVAqqUvFLOTJhOR3CTVecdktBtIw6zQftQs6TQZgVTFcelRFDxJWx
         uLNWrbKpxrltJ5g4vhEHLQDA+tXBNqRbeNwnQp5GqcWvAWmpOVSiFWWEKIHv/JmpUkG+
         bjMsoQVutsT987b5nzDo2U6jK/AaJAEBddoVt3b502HznGeJZsB4J5KlWBzM4269s+0P
         Oxsg==
X-Gm-Message-State: APzg51DIO0fW0/AjAy4vRvlVTEu+5aQlJsEg2+PgV8kC8oCe2QHzaPpv
        kd0MbKuK4GyNqEB/y8u7MVtGAw==
X-Google-Smtp-Source: ANB0Vda0Exfhiz84XQu61c86kGqnTxHSzBX9wkNI8HaU9Ht+W9qzUsiL+NZEHukB1XbFEi31AjAscA==
X-Received: by 2002:a24:9d84:: with SMTP id f126-v6mr3258556itd.130.1535656281718;
        Thu, 30 Aug 2018 12:11:21 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id w20-v6sm3281113ioa.82.2018.08.30.12.11.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 12:11:20 -0700 (PDT)
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
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b5ab8fa3-34ac-3117-fa0d-5206c3939435@kernel.dk>
Date:   Thu, 30 Aug 2018 13:11:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180830185352.3369-8-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/18 12:53 PM, Logan Gunthorpe wrote:
> QUEUE_FLAG_PCI_P2P is introduced meaning a driver's request queue
> supports targeting P2P memory.
> 
> When a request is submitted we check if PCI P2PDMA memory is assigned
> to the first page in the bio. If it is, we ensure the queue it's
> submitted to supports it, and enforce REQ_NOMERGE.

I think this belongs in the caller - both the validity check, and
passing in NOMERGE for this type of request. I don't want to impose
this overhead on everything, for a pretty niche case.

-- 
Jens Axboe

