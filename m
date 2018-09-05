Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49EF5C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBA0620645
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="yEmc5qe/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBA0620645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbeIFA0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 20:26:18 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:52628 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbeIFA0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 20:26:17 -0400
Received: by mail-it0-f65.google.com with SMTP id h3-v6so11623506ita.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 12:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hwWVca0/XHxuWyzuIAuoqX3GfXNrxFdvLjpu2OtS+xw=;
        b=yEmc5qe/wfgb+SCWhzJ+8L++ZYy7Zz6QIoNk8/1nu1jHwEcstMR2oBB2k+Y5u0vcFO
         Q8Zhz65goLl7B2pRCgrhaaIT8MJWPfVeg+2/V0ov6cbEQAig2iJJJWTKk92HHTmzeZ8g
         QuszrINJx0mfCCgYMxnY+dK0n8hZdWUgIDFMlg6LLhJsLPa4wZQMoLblJ1VNyfF9HOe8
         yjHZ2kLO4yEZBv4YZtlBd5KJbucrpSRTjism9SgdtX01dIXr2kTIl2jr2D3pMD/qLX3a
         n0HsWWI9UnLbNfsQUb8SvR9+WS6FLhgKXuBUYc77muHZchrUD/zlpa/vA5m9juav82o4
         R8bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hwWVca0/XHxuWyzuIAuoqX3GfXNrxFdvLjpu2OtS+xw=;
        b=NcKIgMp2Gt6wdIqpS8nDIfyxjn9SiBdRx4cDAkLJd0aZIyRqxDcuWweWBjLMADkz6P
         Ff27l21d05IvyrM+ysw0yKu/4kVMBACucMrW+Ls0pFfBYJFUjL/uwP+KW/TPT5hPG7Jz
         pYP/3BIhCtbQj0aJZQeHL2tDh4vHoswuCGRRuyoT64aVzko6qKIYxN/8tPnWGHtEj5Nl
         p1ovKSKK5gCYod+Iejq467hvpdeMvt+hbCY/oItg2Ho60Acb7f0FgQDFK4hhrxkumYCJ
         r27llkbvIroBGs+/9O7h1Fhb3xMf/HoXAqvlT3Nvzu4XBZnEHszRaKexiAi5bxw7/kRD
         MKFg==
X-Gm-Message-State: APzg51CcsradIiBSNro9uKjm0c8Jdu1eCVFvtGLLNXNgOB/sSftciZaZ
        Op2i2NnWyOvOdNH8H2sIIIFFWA==
X-Google-Smtp-Source: ANB0VdZ+jErCnNFPgjfm5LwIomY//2z4t9ognP39Ffmw2/1Fp7oHzltaUhUyJ7IBnP8pmXdp5syCsg==
X-Received: by 2002:a02:1515:: with SMTP id j21-v6mr28025426jad.2.1536177274908;
        Wed, 05 Sep 2018 12:54:34 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id k75-v6sm1426041itk.31.2018.09.05.12.54.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 12:54:33 -0700 (PDT)
Subject: Re: [PATCH v5 07/13] block: Add PCI P2P flag for request queue and
 check support for requests
To:     Christoph Hellwig <hch@lst.de>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
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
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bcc1b3cf-2fd9-fa61-9cfb-b0e4d84e5d94@kernel.dk>
Date:   Wed, 5 Sep 2018 13:54:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180905195647.GA1626@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/18 1:56 PM, Christoph Hellwig wrote:
> On Wed, Sep 05, 2018 at 01:45:04PM -0600, Jens Axboe wrote:
>> The point is that the caller doesn't necessarily know where the bio
>> will end up, hence the caller can't fully check if the whole stack
>> supports P2P.
> 
> The caller must necessarily know where the bio will end up, as for P2P
> support we need to query if the bio target is P2P capable vs the
> source of the P2P memory.

Then what's the point of having the check at all?

-- 
Jens Axboe

