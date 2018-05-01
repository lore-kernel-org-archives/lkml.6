Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755866AbeEAMfF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 08:35:05 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:41574 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755230AbeEAMfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 08:35:02 -0400
Subject: Re: [Xen-devel] [PATCH 4/4] xen/PVH: Remove reserved entry in PVH GDT
To: =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        jgross@suse.com
References: <20180430162339.17143-1-boris.ostrovsky@oracle.com>
 <20180430162339.17143-5-boris.ostrovsky@oracle.com>
 <20180501080009.wnjmno5pietptixo@MacBook-Pro-de-Roger.local>
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <5a357f3d-b66e-ca55-0601-18a89b549f4a@oracle.com>
Date: Tue, 1 May 2018 08:34:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180501080009.wnjmno5pietptixo@MacBook-Pro-de-Roger.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8879 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=836
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805010126
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/01/2018 04:00 AM, Roger Pau Monné wrote:
> On Mon, Apr 30, 2018 at 12:23:39PM -0400, Boris Ostrovsky wrote:
>> And without it we can't use _BOOT_XX macros any longer so define new ones.
> 
> Not being that familiar with Linux internals I'm not sure I see the
> benefit of this. Isn't there a risk that some other code is going to
> use the __BOOT_XX defines?

The startup code we are jumping to loads their own GDT and I don't see 
any explicit references to segments.

The reason I added this patch was that since we are adding another 
segment descriptor (GS) we are now using PVH-specific GDT and so we are 
not sharing layout with other code anymore. (Also, the new GS segment 
overlaps with __BOOT_TSS so I kind of broke it already there, not 
unintentionally).

But if people think I should stick with __BOOT_XX I can drop this patch 
(and then probably move GS down one entry).


-boris
