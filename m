Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754157AbeCUXQw convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 19:16:52 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:14954 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754032AbeCUXQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 19:16:51 -0400
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 21 Mar 2018 16:16:51 -0700
Subject: Re: [PATCH 10/15] mm/hmm: do not differentiate between empty entry or
 missing directory v2
To: Jerome Glisse <jglisse@redhat.com>
CC: <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, Evgeny Baskakov <ebaskakov@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>
References: <20180320020038.3360-1-jglisse@redhat.com>
 <20180320020038.3360-11-jglisse@redhat.com>
 <4b0da5bb-4e44-798c-f4dd-cabc93cfeb99@nvidia.com>
 <20180321144826.GA3214@redhat.com>
X-Nvconfidentiality: public
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <85bd655c-c161-bf2e-c94f-9bac60483366@nvidia.com>
Date: Wed, 21 Mar 2018 16:16:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180321144826.GA3214@redhat.com>
X-Originating-IP: [10.110.48.28]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/21/2018 07:48 AM, Jerome Glisse wrote:
> On Tue, Mar 20, 2018 at 10:24:34PM -0700, John Hubbard wrote:
>> On 03/19/2018 07:00 PM, jglisse@redhat.com wrote:
>>> From: Jérôme Glisse <jglisse@redhat.com>
>>>

<snip>

>>
>> <snip>
>>
>>> @@ -438,7 +423,7 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
>>>  		pfns[i] = 0;
>>>  
>>>  		if (pte_none(pte)) {
>>> -			pfns[i] = HMM_PFN_EMPTY;
>>> +			pfns[i] = 0;
>>
>> This works, but why not keep HMM_PFN_EMPTY, and just define it as zero?
>> Symbols are better than raw numbers here.
>>
> 
> The last patch do that so i don't think it is worth respinning
> just to make this intermediate state prettier.
> 

Yes, you're right, of course. And, no other problems found, so:

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard
NVIDIA
