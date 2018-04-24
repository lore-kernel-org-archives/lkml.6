Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755768AbeDXFXC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 01:23:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:43503 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751603AbeDXFXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 01:23:00 -0400
Subject: Re: [Xen-devel] [RFC 0/2] To introduce xenwatch multithreading (xen
 mtwatch)
To: Dongli Zhang <dongli.zhang@oracle.com>, Wei Liu <wei.liu2@citrix.com>
Cc: ian.jackson@eu.citrix.com, linux-kernel@vger.kernel.org,
        srinivas.eeda@oracle.com, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com, Joao Martins <joao.m.martins@oracle.com>
References: <1523100355-27647-1-git-send-email-dongli.zhang@oracle.com>
 <20180423140911.bihiwfwtlneobgzd@citrix.com>
 <6c379249-886d-76ee-db9c-942967b23d80@oracle.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <db08fec6-5648-4d87-4ace-2f42d1d04479@suse.com>
Date: Tue, 24 Apr 2018 07:22:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <6c379249-886d-76ee-db9c-942967b23d80@oracle.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/04/18 01:55, Dongli Zhang wrote:
> Hi Wei,
> 
> On 04/23/2018 10:09 PM, Wei Liu wrote:
>> On Sat, Apr 07, 2018 at 07:25:53PM +0800, Dongli Zhang wrote:
>>> About per-domU xenwatch thread create/destroy, a new type of xenstore node is
>>> introduced: '/local/domain/0/mtwatch/<domid>'.
>>>
>>> Suppose the new domid id 7. During the domU (domid=7) creation, the xen
>>> toolstack writes '/local/domain/0/mtwatch/7' to xenstore before the insertion
>>> of '/local/domain/7'. When the domid=7 is destroyed, the last xenstore
>>> operation by xen toolstack is to remove '/local/domain/0/mtwatch/7'.
>>>
>>> The dom0 kernel subscribes a watch at node '/local/domain/0/mtwatch'.  Kernel
>>> thread [xen-mtwatch-7] is created when '/local/domain/0/mtwatch/7' is inserted,
>>> while this kernel thread is destroyed when the corresponding xenstore node is
>>> removed.
>>
>> Instead of inventing yet another node, can you not watch /local/domain
>> directly?
> 
> Would you like to watch at /local/domain directly? Or is your question "is there
> any other way to not watch at /local/domain, while no extra xenstore node will
> be introduced"?
> 
> Actually, the first prototype of this idea was to watch at /local/domain
> directly to get aware of the domU create/destroy, so that xen toolstack will not
> get involved. Joao Martins (CCed) had a concern on the performance as watching
> at /local/domain would lead to large amount of xenwatch events.

That's what the special watches "@introduceDomain" and "@releaseDomain"
are meant for.


Juergen
