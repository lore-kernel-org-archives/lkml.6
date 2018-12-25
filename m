Return-Path: <SRS0=Ytqw=PC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B65E7C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 08:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CD632173B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 08:41:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="F6vImGr/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725894AbeLYIle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 03:41:34 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:2120 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbeLYIld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 03:41:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1545727293; x=1577263293;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=kgR6sCBhd1myeGo4t4K1QN7QdbTtt8itH4GswjnTGiI=;
  b=F6vImGr/aOQkEgooYQtYsDaL0NhHHGNHKWD3JP8oIlE0/3KGIFpdDmou
   bqJ2/di/BSjWCvkamTlT0JfYo0ITkxlhKqi+gDY+mUzkPDqAcqzkvfoYO
   yyZ3d2rO4WyeGlaPWiYcu324yXWggwjfW/dDGCjQjPSLHrzaGX0q3xzFc
   M=;
X-IronPort-AV: E=Sophos;i="5.56,253,1539648000"; 
   d="scan'208";a="778221812"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2b-4e24fd92.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 25 Dec 2018 08:41:30 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2b-4e24fd92.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id wBP8fS3V106122
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 25 Dec 2018 08:41:28 GMT
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 25 Dec 2018 08:41:28 +0000
Received: from [10.218.62.26] (10.43.160.211) by EX13D19EUB003.ant.amazon.com
 (10.43.166.69) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 25 Dec
 2018 08:41:21 +0000
Subject: Re: rfc: bool structure members (was Re: [PATCH V3] net/mlx4: Get rid
 of page operation after dma_alloc_coherent)
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Joe Perches <joe@perches.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Tariq Toukan <tariqt@mellanox.com>, <xavier.huwei@huawei.com>,
        <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        "Stephen Warren" <swarren@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        <linux-kernel@vger.kernel.org>
References: <20181219182031.8675-1-swarren@wwwdotorg.org>
 <20181220174318.GA21404@ziepe.ca> <20181220174448.GA21149@lst.de>
 <1545328145.185366.500.camel@acm.org>
 <072c2d9d187daf0672bf54ab035e47a05fd1cd1d.camel@perches.com>
 <20181221033159.GF23877@ziepe.ca>
 <b906bec0fd12d25474561263087a26b8b0519fe4.camel@perches.com>
 <20181221235230.GC13168@ziepe.ca>
 <dc6d4923-63bd-e133-310b-7b164b0c92f5@amazon.com>
 <20181224231228.GB17036@ziepe.ca>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <71005ff2-e6b0-ca97-0d4b-6e6f7b491760@amazon.com>
Date:   Tue, 25 Dec 2018 10:41:16 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181224231228.GB17036@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.160.211]
X-ClientProxiedBy: EX13D10UWB004.ant.amazon.com (10.43.161.121) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-Dec-18 01:12, Jason Gunthorpe wrote:
> On Sun, Dec 23, 2018 at 06:42:20PM +0200, Gal Pressman wrote:
>> On 22-Dec-18 01:52, Jason Gunthorpe wrote:
>>> On Thu, Dec 20, 2018 at 09:12:43PM -0800, Joe Perches wrote:
>>>> Care to submit a coding_style.rst patch or
>>>> improve the one below this?
>>>
>>> I took yours and revised it a little bit. I spent some time looking at
>>> assembly and decided to drop the performance note, the number of cases
>>> that run into overhead seems pretty small and probably already
>>> requires !! to be correct. There is also an equally unlikely gain, ie
>>> 'if (a & b)' optimizes a tiny bit better for bool types.
>>>
>>> I also added a small intro on bool, as I know some people are
>>> unfamiliar with C11 _Bool and might think bool is just '#define bool
>>> u8'
>>>
>>> (for those added to the cc) I'm looking at cases, like the patch that
>>> spawned this, where the struct has a single bool and no performance
>>> considerations. As CH said, seeing that get converted to int due to
>>> checkpatch is worse than having used bool. Using u8 won't make this
>>> struct smaller or faster.
>>>
>>
>> Since a "Using bool" section is added, perhaps it's worth documenting the bool
>> usage as a function parameter [1]?
>>
>> [1] https://www.spinics.net/lists/linux-rdma/msg72336.html
> 
> I'm not really sure how to express that as something concrete.. That
> specific case clearly called out for a flags as it was a widely used
> API - maybe less spread out cases like static functions or something
> are OK??
> 
> Jason
> 

Sounds reasonable, sometimes adding flags and enum for a single bool function
parameter is a bit too much IMO. For a widely used API it makes sense.
