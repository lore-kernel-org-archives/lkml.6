Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 831D1C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37E7A20659
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="A9rhysN9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37E7A20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbeIEX6b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 19:58:31 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:50204 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbeIEX6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 19:58:30 -0400
Received: by mail-it0-f66.google.com with SMTP id j81-v6so11530231ite.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 12:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hQCQhTXw4V+d8atsoQwkUG9QlqO6wLo/3cSY1ircY4U=;
        b=A9rhysN9fbBL1LBne6JNLTqJg1JYq7llU1Vpo0xV3DW5lMF0v4qfWsGnJ0qxHMQ+Z4
         MdwiuGwAaD6t4kjGjOz4akpWfI4yL3KNEtltbxHgu9bPnUrb7XV/yb17kRJZ6F275bZn
         0bCHNCQ8T+mCvB5/gUdd8gS8LPuj/Z9JUU8+dXBV8y9hbWLqnLWrc+7P0q6pgrrAySB3
         shAsy6TPkQw9qIrfXocRiuQyVTYapZmDaLKHFFT1HTNKvCLDSMvTpZFsYGv2z0WRUI6I
         bFIJtdOINhsVpjvvP8kMmqc0WqBlUYsNhPZ3KVr/dbgk3cc7d7vWM+oBERd9+MrgHSQb
         7G9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hQCQhTXw4V+d8atsoQwkUG9QlqO6wLo/3cSY1ircY4U=;
        b=UKIK1nCFpsLD6g9Qx5ahtRGZCr56DOdjy+IvHEdPo+o4/EuTs4233hy+u6YXBUco6h
         69EFgtaX37UXIxS6AuYh6iGSrnDzg9jwwy2yGSJD7cj4XEZ0u6psWg2TILMphWb3xoI4
         XuLuQqZHdwPzehqDigaPkSCSps28eJhzuYp7yZvxURDsSeONSUKGga0/F6V3WTcOVWdy
         LtjuX3SR+vVeEfEceqGxQkrorQMbVlxK7+ehgUp/dJkRv5SOES3dK+feFe9q0wlRkQ/F
         kHI3sbGrhr4ND7G/opUrXqozVr308Vg+Ylj2wT4bYhMqKZwn/PwCEqEENsdH0DckoOx7
         RHxw==
X-Gm-Message-State: APzg51DRKGGkaZYGfwK0l5yX8B2Qc2jKbb4bmVQFKtKHncosGF5kWqAo
        j766T4vSX+2J/8XCrt6girNNMw==
X-Google-Smtp-Source: ANB0VdapXKOqjXouem4uxXPvFcDadOQ2OG/hA0PXyR8EzKrdg1wh6lLsH8AcWo7c7VRpNdLpPkGQkg==
X-Received: by 2002:a24:2552:: with SMTP id g79-v6mr1625767itg.84.1536175615162;
        Wed, 05 Sep 2018 12:26:55 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id 84-v6sm1297805ita.35.2018.09.05.12.26.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 12:26:53 -0700 (PDT)
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
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <59b28977-8f2a-6228-2050-03fae6bdbedd@kernel.dk>
Date:   Wed, 5 Sep 2018 13:26:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <5f79c012-c6e1-56bb-62fd-0689181fb2c9@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/3/18 4:26 PM, Logan Gunthorpe wrote:
> 
> 
> On 01/09/18 02:28 AM, Christoph Hellwig wrote:
>> On Thu, Aug 30, 2018 at 01:11:18PM -0600, Jens Axboe wrote:
>>> I think this belongs in the caller - both the validity check, and
>>> passing in NOMERGE for this type of request. I don't want to impose
>>> this overhead on everything, for a pretty niche case.
>>
>> It is just a single branch, which will be predicted as not taken
>> for non-P2P users.  The benefit is that we get proper error checking
>> by doing it in the block code.
> 
> I personally agree with Christoph. But if there's consensus in the other
> direction or this is a real blocker moving this forward, I can remove it
> for the next version.

It's a simple branch because the check isn't exhaustive. It just checks
the first page. At that point you may as well just require the caller to
flag the bio/rq as being P2P, and then do a check for P2P compatibility
with the queue.

-- 
Jens Axboe

