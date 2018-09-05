Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1B5C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 20:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED8252073D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 20:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="uKNMms6J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED8252073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbeIFAva (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 20:51:30 -0400
Received: from mail-it0-f46.google.com ([209.85.214.46]:36310 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727586AbeIFAva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 20:51:30 -0400
Received: by mail-it0-f46.google.com with SMTP id u13-v6so11211708iti.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 13:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=I2A46jX71yroumZdLirx89tBYPtjvNrtZpAe6pwPsIw=;
        b=uKNMms6JWhE33FlQRWls0EgRXlbMKZhk+/WMR/5xDPUIs3rNAH1Dg6VPV4/QVRI2L+
         O7pqwoyEFNLl94EjrLN9REKWPvRmxJluaPTaQLa3FAaLVzjwkbn0uHQ05e/M0SLc2uNS
         VSxTXl/bMVlVmzm2/etVXutbedoT/+a3HZFFtCykXIrTkr6EzVP7jszwJT5gZeFWKve1
         JHZYvmhLRw+IaSqhrKGQ8xrpvZckCLRi17rGwY+3+YMSe2oG1scJOpahwqtnkotLaGq1
         iIKjLaR+Oa8DpqCVSFDqk2RLlEHoLZ2I4ZgQtzt+p301HQGeNOlJH3RoUlmTsjgaZIeQ
         0XZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I2A46jX71yroumZdLirx89tBYPtjvNrtZpAe6pwPsIw=;
        b=WxW0u1VsN/fOAvMZeBRQ3PqSdDDK839CwlEAHng7Zh0SjwYRn/aFKZOY8nFxGrYwey
         +8OTFa2n7ZnNtYYc6Lj39+ND5hhHdNZyW1kldkdQ9hbu0s/Lasoc8Vq0N0o7VImlhB8G
         8jW4s/OujNS+Z6PYzsKuDnzOX4mibjUGEktJ+MDLplwzOAXXjNGu2gaRYbkLssJ+pNvD
         xISGKJWqnl3AiPtRbJ2egdKxGwGqqWWAq/9KkIJbcW1ozLj1/WdIU60T2omMxKsEXUpl
         v1em4JQveq8A7C0rRzFQpmML+QekdHqOCka5PdFQbNL7tGDcF9VZusjiXAvwL+7Cx0Yy
         5zOw==
X-Gm-Message-State: APzg51CjKs9qrfuYCp+a4STPnACCygqTdGsiUwB40b6Itbx2XQi9fXsE
        t9VKFXuhBQCfthrn0sjTKCjwpQ==
X-Google-Smtp-Source: ANB0VdYpQiJ1z0uHxCVA4YQQAwT2AjnQSnTCoyZas6qbncRw9k/nmT+11SVvxsfYRoD8/xbrkZ1qCg==
X-Received: by 2002:a24:4c90:: with SMTP id a138-v6mr48194itb.138.1536178782002;
        Wed, 05 Sep 2018 13:19:42 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id e129-v6sm1371708ite.35.2018.09.05.13.19.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 13:19:40 -0700 (PDT)
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
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3af4d1d4-da07-c0a6-8464-9ddc1378f2f4@kernel.dk>
Date:   Wed, 5 Sep 2018 14:19:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <e3ef26e6-6c8d-25b8-fa64-14594a51263c@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/18 2:18 PM, Logan Gunthorpe wrote:
> 
> 
> On 05/09/18 02:14 PM, Jens Axboe wrote:
>> But if the caller must absolutely know where the bio will end up, then
>> it seems super redundant. So I'd vote for killing this check, it buys
>> us absolutely nothing and isn't even exhaustive in its current form.
> 
> 
> Ok, I'll remove it for v6.

Since the drivers needs to know it's doing it right, it might not
hurt to add a sanity check helper for that. Just have the driver
call it, and don't add it in the normal IO submission path.

-- 
Jens Axboe

