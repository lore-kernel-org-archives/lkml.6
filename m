Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753328AbeAaCdQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 21:33:16 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:58616 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752941AbeAaCdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 21:33:15 -0500
Subject: Re: [PATCH 3/3] mm: memfd: remove memfd code from shmem files and use
 new memfd files
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
        David Herrmann <dh.herrmann@gmail.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20180130000101.7329-4-mike.kravetz@oracle.com>
 <201801310705.HNIeJce6%fengguang.wu@intel.com>
From: Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <6225b786-ebd6-6d3b-3db8-55b87dc9a8bd@oracle.com>
Date: Tue, 30 Jan 2018 18:28:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <201801310705.HNIeJce6%fengguang.wu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8790 signatures=668657
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=955
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1801310029
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/30/2018 03:49 PM, kbuild test robot wrote:
> Hi Mike,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on mmotm/master]
> [also build test WARNING on next-20180126]
> [cannot apply to linus/master v4.15]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Mike-Kravetz/restructure-memfd-code/20180131-023405
> base:   git://git.cmpxchg.org/linux-mmotm.git master
> reproduce:
>         # apt-get install sparse
>         make ARCH=x86_64 allmodconfig
>         make C=1 CF=-D__CHECK_ENDIAN__
> 
> 
> sparse warnings: (new ones prefixed by >>)
> 
>>> mm/memfd.c:40:9: sparse: incorrect type in assignment (different address spaces) @@ expected void @@ got void <avoid @@

<snip>

> :::::: The code at line 40 was first introduced by commit
> :::::: 6df4ed2a410bc04f1ec04dce16ccd236707f7f32 mm: memfd: split out memfd for use by multiple filesystems

Yes, but I also removed those same warnings from mm/shmem.c so I should
get some credit for that. :)

I fixed up the warnings in the moved code and will send out v2.
-- 
Mike Kravetz
