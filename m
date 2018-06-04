Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752537AbeFDL17 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 07:27:59 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:5555 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751769AbeFDL1q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 07:27:46 -0400
From: Nixiaoming <nixiaoming@huawei.com>
To: Michal Hocko <mhocko@kernel.org>
CC: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "vdavydov.dev@gmail.com" <vdavydov.dev@gmail.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "garsilva@embeddedor.com" <garsilva@embeddedor.com>,
        "ktkhai@virtuozzo.com" <ktkhai@virtuozzo.com>,
        "stummala@codeaurora.org" <stummala@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: RE: [PATCH] mm: Add conditions to avoid out-of-bounds
Thread-Topic: [PATCH] mm: Add conditions to avoid out-of-bounds
Thread-Index: AQHT+/ODcalbMzUwQk2w0KnDFcXRgaRPbg8AgACHnjA=
Date: Mon, 4 Jun 2018 11:27:26 +0000
Message-ID: <E490CD805F7529488761C40FD9D26EF12A6834EF@dggemm507-mbx.china.huawei.com>
References: <20180604103735.42781-1-nixiaoming@huawei.com>
 <20180604112026.GI19202@dhcp22.suse.cz>
In-Reply-To: <20180604112026.GI19202@dhcp22.suse.cz>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.57.88.168]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm very sorry. It was my mistake. 
it won't cross the border here.

Thanks 


-----Original Message-----
From: Michal Hocko [mailto:mhocko@kernel.org] 
Sent: Monday, June 04, 2018 7:20 PM
To: Nixiaoming <nixiaoming@huawei.com>
Cc: akpm@linux-foundation.org; vdavydov.dev@gmail.com; hannes@cmpxchg.org; garsilva@embeddedor.com; ktkhai@virtuozzo.com; stummala@codeaurora.org; linux-kernel@vger.kernel.org; linux-mm@kvack.org
Subject: Re: [PATCH] mm: Add conditions to avoid out-of-bounds

On Mon 04-06-18 18:37:35, nixiaoming wrote:
> In the function memcg_init_list_lru
> if call goto fail when i == 0, will cause out-of-bounds at lru->node[i]

How? All I can see is that the fail path does
	for (i = i - 1; i >= 0; i--)

so it will not do anything for i=0.
-- 
Michal Hocko
SUSE Labs
