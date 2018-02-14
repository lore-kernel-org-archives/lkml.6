Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030855AbeBNOhg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 09:37:36 -0500
Received: from www62.your-server.de ([213.133.104.62]:48912 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030381AbeBNOhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 09:37:34 -0500
Subject: Re: [PATCH net] bpf: cpumap: use GFP_KERNEL instead of GFP_ATOMIC in
 __cpu_map_entry_alloc()
To: Jason Wang <jasowang@redhat.com>, ast@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: mst@redhat.com, Michal Hocko <mhocko@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>, akpm@linux-foundation.org,
        dhowells@redhat.com, hannes@cmpxchg.org
References: <1518617854-4486-1-git-send-email-jasowang@redhat.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <7d679561-1b07-a6ef-58d3-6fa7215d177d@iogearbox.net>
Date: Wed, 14 Feb 2018 15:37:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <1518617854-4486-1-git-send-email-jasowang@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/14/2018 03:17 PM, Jason Wang wrote:
> There're several implications after commit 0bf7800f1799 ("ptr_ring:
> try vmalloc() when kmalloc() fails") with the using of vmalloc() since
> can't allow GFP_ATOMIC but mandate GFP_KERNEL. This will lead a WARN
> since cpumap try to call with GFP_ATOMIC. Fortunately, entry
> allocation of cpumap can only be done through syscall path which means
> GFP_ATOMIC is not necessary, so fixing this by replacing GFP_ATOMIC
> with GFP_KERNEL.
> 
> Reported-by: syzbot+1a240cdb1f4cc88819df@syzkaller.appspotmail.com
> Fixes: 0bf7800f1799 ("ptr_ring: try vmalloc() when kmalloc() fails")
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Jesper Dangaard Brouer <brouer@redhat.com>
> Cc: akpm@linux-foundation.org
> Cc: dhowells@redhat.com
> Cc: hannes@cmpxchg.org
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Applied to bpf tree, thanks Jason!
