Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932353AbeCEUip (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 15:38:45 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:52966 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751275AbeCEUin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 15:38:43 -0500
Subject: Re: [PATCH v12 08/11] mm: Clear arch specific VM flags on protection
 change
To: Dave Hansen <dave.hansen@linux.intel.com>, akpm@linux-foundation.org,
        davem@davemloft.net
Cc: mhocko@suse.com, jack@suse.cz, kirill.shutemov@linux.intel.com,
        ross.zwisler@linux.intel.com, willy@infradead.org, hughd@google.com,
        n-horiguchi@ah.jp.nec.com, mgorman@suse.de, jglisse@redhat.com,
        dave.jiang@intel.com, dan.j.williams@intel.com,
        anthony.yznaga@oracle.com, nadav.amit@gmail.com, zi.yan@cs.rutgers.edu,
        aarcange@redhat.com, khandual@linux.vnet.ibm.com,
        aneesh.kumar@linux.vnet.ibm.com, henry.willard@oracle.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        sparclinux@vger.kernel.org, Khalid Aziz <khalid@gonehiking.org>
References: <cover.1519227112.git.khalid.aziz@oracle.com>
 <f0bfc4b7ce6c8563bf0d5ef74af20b5d1edea66f.1519227112.git.khalid.aziz@oracle.com>
 <df5344a2-f28d-7828-b76b-107dc24be2dd@linux.intel.com>
From: Khalid Aziz <khalid.aziz@oracle.com>
Organization: Oracle Corp
Message-ID: <fd08210e-a6af-c3f5-3807-9ffe9dad66b0@oracle.com>
Date: Mon, 5 Mar 2018 13:38:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <df5344a2-f28d-7828-b76b-107dc24be2dd@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8823 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=626
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803050236
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/2018 12:23 PM, Dave Hansen wrote:
> On 02/21/2018 09:15 AM, Khalid Aziz wrote:
>> +/* Arch-specific flags to clear when updating VM flags on protection change */
>> +#ifndef VM_ARCH_CLEAR
>> +# define VM_ARCH_CLEAR	VM_NONE
>> +#endif
>> +#define VM_FLAGS_CLEAR	(ARCH_VM_PKEY_FLAGS | VM_ARCH_CLEAR)
> 
> Shouldn't this be defining
> 
> # define VM_ARCH_CLEAR	ARCH_VM_PKEY_FLAGS
> 
> on x86?

ARCH_VM_PKEY_FLAGS is used by x86 as well as powerpc. On those two 
architectures VM_FLAGS_CLEAR will end up being ARCH_VM_PKEY_FLAGS and 
thus current behavior will be retained. Defining VM_ARCH_CLEAR to be 
ARCH_VM_PKEY_FLAGS on x86 will just result in VM_FLAGS_CLEAR to be 
(ARCH_VM_PKEY_FLAGS | ARCH_VM_PKEY_FLAGS) which is superfluous.

--
Khalid
