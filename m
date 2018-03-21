Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754123AbeCUWgG convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 18:36:06 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:10987 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753972AbeCUWgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 18:36:03 -0400
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 21 Mar 2018 15:36:02 -0700
Subject: Re: [PATCH 13/15] mm/hmm: factor out pte and pmd handling to simplify
 hmm_vma_walk_pmd()
To: Jerome Glisse <jglisse@redhat.com>
CC: <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, Evgeny Baskakov <ebaskakov@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>
References: <20180320020038.3360-1-jglisse@redhat.com>
 <20180320020038.3360-14-jglisse@redhat.com>
 <e0fd4348-8b8c-90b2-a9d8-91a30768fddc@nvidia.com>
 <20180321150819.GC3214@redhat.com>
X-Nvconfidentiality: public
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <6ded8a12-1522-3270-602c-bafc7e823758@nvidia.com>
Date: Wed, 21 Mar 2018 15:36:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180321150819.GC3214@redhat.com>
X-Originating-IP: [10.110.48.28]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/21/2018 08:08 AM, Jerome Glisse wrote:
> On Tue, Mar 20, 2018 at 10:07:29PM -0700, John Hubbard wrote:
>> On 03/19/2018 07:00 PM, jglisse@redhat.com wrote:
>>> From: Jérôme Glisse <jglisse@redhat.com>

<snip>
 
>>> +static int hmm_vma_handle_pmd(struct mm_walk *walk,
>>> +			      unsigned long addr,
>>> +			      unsigned long end,
>>> +			      uint64_t *pfns,
>>
>> Hi Jerome,
>>
>> Nice cleanup, it makes it much easier to follow the code now.
>>
>> Let's please rename the pfns argument above to "pfn", because in this
>> helper (and the _pte helper too), there is only one pfn involved, rather
>> than an array of them.
> 
> This is only true to handle_pte, for handle_pmd it will go over several
> pfn entries. But they will all get fill with same value modulo pfn which
> will increase monotically (ie same flag as pmd permissions apply to all
> entries).

oops, yes you are right about handle_pmd.

> 
> Note sure s/pfns/pfn for hmm_vma_handle_pte() warrant a respin.

Probably not, unless there is some other reason to respin. Anyway, this patch
looks good either way, I think, so you can still add:

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard
NVIDIA
