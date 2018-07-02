Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E716C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16A2825766
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:35:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16A2825766
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753528AbeGBVfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 17:35:52 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:2176 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753401AbeGBVfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 17:35:50 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b3a9ab30000>; Mon, 02 Jul 2018 14:35:48 -0700
Received: from HQMAIL107.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 02 Jul 2018 14:35:49 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 02 Jul 2018 14:35:49 -0700
Received: from [10.110.48.28] (10.110.48.28) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 2 Jul
 2018 21:35:49 +0000
Subject: Re: [PATCH v2 1/6] mm: get_user_pages: consolidate error handling
To:     Jan Kara <jack@suse.cz>, <john.hubbard@gmail.com>
CC:     Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
References: <20180702005654.20369-1-jhubbard@nvidia.com>
 <20180702005654.20369-2-jhubbard@nvidia.com>
 <20180702101725.esnjyo4zp3726i3n@quack2.suse.cz>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <2bb69d70-33c4-3547-823d-4750df237d83@nvidia.com>
Date:   Mon, 2 Jul 2018 14:34:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180702101725.esnjyo4zp3726i3n@quack2.suse.cz>
X-Originating-IP: [10.110.48.28]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2018 03:17 AM, Jan Kara wrote:
> On Sun 01-07-18 17:56:49, john.hubbard@gmail.com wrote:
>> From: John Hubbard <jhubbard@nvidia.com>
>>
>> An upcoming patch requires a way to operate on each page that
>> any of the get_user_pages_*() variants returns.
>>
>> In preparation for that, consolidate the error handling for
>> __get_user_pages(). This provides a single location (the "out:" label)
>> for operating on the collected set of pages that are about to be returned.
>>
>> As long every use of the "ret" variable is being edited, rename
>> "ret" --> "err", so that its name matches its true role.
>> This also gets rid of two shadowed variable declarations, as a
>> tiny beneficial a side effect.
>>
>> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> 
> This looks nice! You can add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 

Great, thanks for the review!

-- 
John Hubbard
NVIDIA
