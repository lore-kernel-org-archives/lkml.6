Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932687AbeDWXx0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 19:53:26 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:51964 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932615AbeDWXxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 19:53:24 -0400
Subject: Re: [Xen-devel] [RFC 0/2] To introduce xenwatch multithreading (xen
 mtwatch)
To: Wei Liu <wei.liu2@citrix.com>
References: <1523100355-27647-1-git-send-email-dongli.zhang@oracle.com>
 <20180423140911.bihiwfwtlneobgzd@citrix.com>
Cc: jgross@suse.com, ian.jackson@eu.citrix.com,
        linux-kernel@vger.kernel.org, srinivas.eeda@oracle.com,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com,
        Joao Martins <joao.m.martins@oracle.com>
From: Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <6c379249-886d-76ee-db9c-942967b23d80@oracle.com>
Date: Tue, 24 Apr 2018 07:55:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20180423140911.bihiwfwtlneobgzd@citrix.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8872 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=790
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804230235
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wei,

On 04/23/2018 10:09 PM, Wei Liu wrote:
> On Sat, Apr 07, 2018 at 07:25:53PM +0800, Dongli Zhang wrote:
>> About per-domU xenwatch thread create/destroy, a new type of xenstore node is
>> introduced: '/local/domain/0/mtwatch/<domid>'.
>>
>> Suppose the new domid id 7. During the domU (domid=7) creation, the xen
>> toolstack writes '/local/domain/0/mtwatch/7' to xenstore before the insertion
>> of '/local/domain/7'. When the domid=7 is destroyed, the last xenstore
>> operation by xen toolstack is to remove '/local/domain/0/mtwatch/7'.
>>
>> The dom0 kernel subscribes a watch at node '/local/domain/0/mtwatch'.  Kernel
>> thread [xen-mtwatch-7] is created when '/local/domain/0/mtwatch/7' is inserted,
>> while this kernel thread is destroyed when the corresponding xenstore node is
>> removed.
> 
> Instead of inventing yet another node, can you not watch /local/domain
> directly?

Would you like to watch at /local/domain directly? Or is your question "is there
any other way to not watch at /local/domain, while no extra xenstore node will
be introduced"?

Actually, the first prototype of this idea was to watch at /local/domain
directly to get aware of the domU create/destroy, so that xen toolstack will not
get involved. Joao Martins (CCed) had a concern on the performance as watching
at /local/domain would lead to large amount of xenwatch events.

Dongli Zhang
