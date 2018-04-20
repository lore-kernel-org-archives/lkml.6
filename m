Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754159AbeDTDO6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 23:14:58 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:57696 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753964AbeDTDO5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 23:14:57 -0400
Subject: Re: [f2fs-dev] [PATCH] f2fs: sepearte hot/cold in free nid
To: heyunlei <heyunlei@huawei.com>,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net"
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20180420015231.90679-1-yuchao0@huawei.com>
 <42B685BFA705F94C860C6DD0752F056548377C3C@DGGEMA503-MBS.china.huawei.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <d0712a2c-393f-a11e-f1de-bab9ce148bab@huawei.com>
Date: Fri, 20 Apr 2018 11:14:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <42B685BFA705F94C860C6DD0752F056548377C3C@DGGEMA503-MBS.china.huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/4/20 10:30, heyunlei wrote:
> 
> 
>> -----Original Message-----
>> From: Chao Yu [mailto:yuchao0@huawei.com]
>> Sent: Friday, April 20, 2018 9:53 AM
>> To: jaegeuk@kernel.org
>> Cc: linux-kernel@vger.kernel.org; linux-f2fs-devel@lists.sourceforge.net
>> Subject: [f2fs-dev] [PATCH] f2fs: sepearte hot/cold in free nid
>>
>> As most indirect node, dindirect node, and xattr node won't be updated
>> after they are created, but inode node and other direct node will change
>> more frequently, so store their nat entries mixedly in whole nat table
>> will suffer:
>> - fragment nat table soon due to different update rate
>> - more nat block update due to fragmented nat table
>>
> 
> BTW, should we enable this patch:  f2fs: reuse nids more aggressively?
> 
> I think it will decrease nat area fragment and will decrease io of nat?

For a fragmented nat table, there will be no different in between reusing
obsolete nid or allocating nid from next nat block.

IMO, in order to decrease nat block write, it needs to add more allocation
algorithm like a filesystem does, but firstly, I'd like to separate hot entry
from cold one.

Thanks,
