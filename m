Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38ADEC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 19:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD0FE278D1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 19:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Hsc0MzsT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD0FE278D1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965613AbeF1T6D (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 15:58:03 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:55795 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965535AbeF1T57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 15:57:59 -0400
Received: by mail-it0-f66.google.com with SMTP id 16-v6so14503732itl.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 12:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4rKmfEUuk51mfhwjtRbJDcxJv9lntII7cLxnKXAD0S8=;
        b=Hsc0MzsTpZdi/5r8tkb+GPbYECoIwI6MW2CidskOOLkPzbFa2BkTyn4hhy3wnZRLtR
         MQSMBYfs4IKudcSIOwnDouDdrPXUZaN/56N2hFgdyWV58nddO1CAasFlrFIw0TwsX1h/
         wnIY/1eNMJl8u+zrOLimuK/7ahEOaUSfZ93w/udvrRNv/4ZKcgf3lQdDsk+fb5E32K7m
         ZmRHYFnU59NV4VeERntpCQNZebIaW6otW7MLVzYxsIxpA0pY1FlGvtoaIH4rFkZ4Zs4j
         dGh6WW6fGJjSiXMF7tEjkXOtX7KuaMWFpZPF2B9WsW3E/O0Y39Mj2Aox57ixzpy2+gjW
         XcUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4rKmfEUuk51mfhwjtRbJDcxJv9lntII7cLxnKXAD0S8=;
        b=AWr5MDpx4Cwb6890aEqPWphYHrBd+Ymq/Pbbv3gSiEMjfib8C92cIkoV0BbUvu/4po
         iTVOEw2KtPxSzm03KL+6Zmw7srkK04wOLsFmgOrPb9UQ/rY6O+N4OYFu7d2lXMASgN7p
         x4nb9GJIMSMcbvA+aYCeXAIoKVFZ057QHnvTAwVvh+z/G1DXg+5V+wL+KKiCVmECKwVq
         wIhurjH/pAa6ISLZdAguHueU0LewKYzeqVtT67G+HD7CTUJ7rhgmgojuIrRPVTRlGNp8
         6TxcwE30npWISqZeCkp2YvRDoIhBAsqf3e7HLHT/Q1y1VmOzQQd+hr4at55gh4eBcgdE
         PTLQ==
X-Gm-Message-State: APt69E1osONnxqLDi1rhOcfK3x/g82XTsFU0eny0bv0Vu8rBkOwthSmb
        o1mG2sfs5LLxzhRI4SPvbN8onQ==
X-Google-Smtp-Source: AAOMgpdFbdBG/bBlrP7aLVWdSOSgMpA8lU+h3bujH+fH/7h7PUb5EYOz21SagLWHL/uEMBpqOe/+Fg==
X-Received: by 2002:a24:308b:: with SMTP id q133-v6mr8878041itq.55.1530215878515;
        Thu, 28 Jun 2018 12:57:58 -0700 (PDT)
Received: from [192.168.1.212] (107.191.0.158.static.utbb.net. [107.191.0.158])
        by smtp.gmail.com with ESMTPSA id 135-v6sm773950ity.19.2018.06.28.12.57.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 12:57:57 -0700 (PDT)
Subject: Re: Oops in kmem_cache_free() via bioset_exit() (was Re:
 [next-20180601][nvme][ppc] Kernel Oops is triggered when creating lvm
 snapshots on nvme disks)
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-next <linux-next@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        sachinp <sachinp@linux.vnet.ibm.com>,
        sim <sim@linux.vnet.ibm.com>,
        manvanth <manvanth@linux.vnet.ibm.com>,
        Brian King <brking@linux.vnet.ibm.com>,
        linux-block@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>
References: <1530003645.24245.7.camel@abdul.in.ibm.com>
 <87d0wd7jph.fsf@concordia.ellerman.id.au>
 <1530176707.24245.12.camel@abdul.in.ibm.com>
 <87a7rf55vy.fsf@concordia.ellerman.id.au>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <32e06233-3e58-10af-40d9-a22d9e5c4e96@kernel.dk>
Date:   Thu, 28 Jun 2018 13:57:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <87a7rf55vy.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/28/18 8:42 AM, Michael Ellerman wrote:
> Kent, Jens,
> 
> This looks like it might be related to the recent bioset changes?
> 
> cheers
> 
> Abdul Haleem <abdhalee@linux.vnet.ibm.com> writes:
>> On Tue, 2018-06-26 at 23:36 +1000, Michael Ellerman wrote:
>>> Abdul Haleem <abdhalee@linux.vnet.ibm.com> writes:
> ...
>> I was able to reproduce again with slub_debug=FZP and DEBUG_INFO enabled
>> on 4.17.0-rc7-next-20180601, but not much traces other than the Oops stack trace
> 
> Are you still testing on that revision? It's nearly a month old.
> 
> Please try to reproduce on mainline or today's linux-next.
> 
> 
>> the faulty instruction points to below code path :
>>
>> gdb -batch vmlinux -ex 'list *(0xc000000000304fe0)'
>> 0xc000000000304fe0 is in kmem_cache_free (mm/slab.h:231).
>> 226	}
>> 227	
>> 228	static inline bool slab_equal_or_root(struct kmem_cache *s,
>> 229					      struct kmem_cache *p)
>> 230	{
>> 231		return p == s || p == s->memcg_params.root_cache;
>> 232	}
> 
> And s is NULL.
> 
> Called via:
>   kmem_cache_free+0x210/0x2a0
>   mempool_free_slab+0x24/0x40
>   mempool_exit+0x50/0x90
>   bioset_exit+0x40/0x1d0
>   dm_io_client_destroy+0x2c/0x50
>   dm_bufio_client_destroy+0x1fc/0x2d0 [dm_bufio]
>   persistent_read_metadata+0x430/0x660 [dm_snapshot]
>   snapshot_ctr+0x5c8/0x7a0 [dm_snapshot]
>   dm_table_add_target+0x19c/0x3c0
>   table_load+0x104/0x450
>   ctl_ioctl+0x1f8/0x570
>   dm_ctl_ioctl+0x18/0x30
>   do_vfs_ioctl+0xcc/0x9e0
>   ksys_ioctl+0x5c/0xe0
>   sys_ioctl+0x20/0x80
>   system_call+0x58/0x6c
> 
> So looks like we did:
> 
>   kmem_cache_free(NULL
> 
> Probably a bad error path that frees before the cache has been allocated.
> 
> mempool_init_node() calls mempool_exit() on a partially initialised
> mempool, which looks fishy, though you're not hitting that patch AFAICS.

The slab cache is setup elsewhere, it's pending_cache. So if pending_cache
is NULL, then yeah and exit there will barf. I'd try something like the
below, but from the trace, we already basically see the path.


diff --git a/include/linux/mempool.h b/include/linux/mempool.h
index 0c964ac107c2..ebfa2f89ffdd 100644
--- a/include/linux/mempool.h
+++ b/include/linux/mempool.h
@@ -59,6 +59,7 @@ void mempool_free_slab(void *element, void *pool_data);
 static inline int
 mempool_init_slab_pool(mempool_t *pool, int min_nr, struct kmem_cache *kc)
 {
+	BUG_ON(!kc);
 	return mempool_init(pool, min_nr, mempool_alloc_slab,
 			    mempool_free_slab, (void *) kc);
 }
diff --git a/mm/mempool.c b/mm/mempool.c
index b54f2c20e5e0..060f44acd0df 100644
--- a/mm/mempool.c
+++ b/mm/mempool.c
@@ -508,7 +508,9 @@ EXPORT_SYMBOL(mempool_alloc_slab);
 void mempool_free_slab(void *element, void *pool_data)
 {
 	struct kmem_cache *mem = pool_data;
-	kmem_cache_free(mem, element);
+
+	if (!WARN_ON(!mem))
+		kmem_cache_free(mem, element);
 }
 EXPORT_SYMBOL(mempool_free_slab);
 

-- 
Jens Axboe

