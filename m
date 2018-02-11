Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753483AbeBKP2x (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 10:28:53 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:58146 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751077AbeBKP2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 10:28:52 -0500
Subject: Re: [PATCH 2/2] xen: xenbus: WARN_ON XS_TRANSACTION_{START,END}
 misuse
To: Simon Gaiser <simon@invisiblethingslab.com>,
        xen-devel@lists.xenproject.org
Cc: Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org
References: <20180207222236.7434-1-simon@invisiblethingslab.com>
 <20180207222236.7434-2-simon@invisiblethingslab.com>
 <8a0fd059-7acf-3279-10f9-649c19522e2a@oracle.com>
 <66103cca-321e-6950-2083-6f5d068e12e6@invisiblethingslab.com>
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <0bf1782a-b7c4-1775-c2cb-6e68fe62a199@oracle.com>
Date: Sun, 11 Feb 2018 10:28:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <66103cca-321e-6950-2083-6f5d068e12e6@invisiblethingslab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8802 signatures=668668
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=879
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802110205
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/10/2018 08:27 PM, Simon Gaiser wrote:
> Boris Ostrovsky:
>> On 02/07/2018 05:22 PM, Simon Gaiser wrote:
>>> +    users_old = xs_state_users;
>>>        xs_state_users--;
>>>        if ((req->type == XS_TRANSACTION_START && req->msg.type == XS_ERROR) ||
>>>            req->type == XS_TRANSACTION_END)
>>>            xs_state_users--;
>>> +    if (WARN_ON(xs_state_users > users_old))
>>
>>
>> WARN_ON_ONCE()?
> 
> Since we "fix" the wrong decrement by clamping at zero it should not
> happen immediately again. But if you prefer _ONCE I can change it.
> 


If this error can happen once then someone at least theoretically can 
construct a case when it is repeated. So let's switch to _ONCE() variant.

Thanks.
-boris
