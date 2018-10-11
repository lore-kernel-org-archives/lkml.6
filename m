Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8283C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 11:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49B122077C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 11:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g5cDs5Xj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49B122077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbeJKTPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 15:15:40 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32995 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbeJKTPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 15:15:40 -0400
Received: by mail-wr1-f66.google.com with SMTP id e4-v6so9357497wrs.0;
        Thu, 11 Oct 2018 04:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=jVPa2OBQuQWHIEBTRHX0t8oOVwePJRfv51Ptm++bqRA=;
        b=g5cDs5XjdQLCD/IpNurawDbISTQxIAa+Y0ualCzS5ivo/wpGw9VtPptyg08vzZjalq
         te4tMTepfPqoPjMMN2pUmUjHr3P+81KdpTzRUKwe4R9UbjGcLqmBWHmCGAEudWWs6LNK
         WhGN6QFYc/oQqohA0suWrWVaD8s3hBPK4DtYK2SZYOlx1Pum2BGstaN07pNM1ji4Cwwd
         ZMQwOuVxpgy3E+Am3AxoBTJCyPp1qHkA6JTIMhVjUaucdcnbV70C3d5GPYagKKleIOcD
         oLka3c5Un76B2lM/racBkmop/VM2FbovXXIBdcLwBrL45GWVttBtLGc59jexsdBkhBEW
         p5xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=jVPa2OBQuQWHIEBTRHX0t8oOVwePJRfv51Ptm++bqRA=;
        b=IcT7nJC1AQiJQFq/axvlM/dgg/CFO+qvpoJhxS0ngAztopXptzFKa1uGWqB9g8d6P6
         8tzXCR7pcmyXcsS3rd5oN4zl0U+0XR+4ehu9Jn3KQxjvltFwMzveVXOEUEGbfG7Bsu/L
         AfGBWNKt8PJJid6y5Gsg6gy2KkW5jEvaHvZ5rz+BrItZwEO0DU0wENwTtg/t9yOry034
         WGD9s8uKX47rCe2nRgt54FOcvyvyTo0XjuI+BxRkVVYPVOpnljlLzqz+AMe9zojNHpsz
         8Za7lJ628/6k8fyepcn1VlurBILVG/qS/Fo5wa3RS++ZZ9De6G2KGEweiiwbuy/5KJtv
         9W+w==
X-Gm-Message-State: ABuFfoj9faWrkFE5XKMuRsDOl0IwrLMi1rdYTEKLAdKLkgoaa1Yfb2qM
        KpXimGtuur2hgo4StLWv5s8=
X-Google-Smtp-Source: ACcGV629fk2q6cRBrZcOY54AN4q9jOJCz3ntVCl33zRkavrYQ6QAzjJ1anJ/DTv/zoxWK5c1ymVZzA==
X-Received: by 2002:a05:6000:114e:: with SMTP id d14mr1242224wrx.301.1539258524970;
        Thu, 11 Oct 2018 04:48:44 -0700 (PDT)
Received: from [172.16.1.10] (host-89-243-172-161.as13285.net. [89.243.172.161])
        by smtp.gmail.com with ESMTPSA id 64-v6sm28467038wrr.64.2018.10.11.04.48.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 04:48:44 -0700 (PDT)
Subject: Re: [PATCH 03/34] teach move_mount(2) to work with OPEN_TREE_CLONE
 [ver #12]
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, torvalds@linux-foundation.org,
        ebiederm@xmission.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mszeredi@redhat.com
References: <5c6f3d62-4cec-2aea-4693-62928611c526@gmail.com>
 <153754740781.17872.7869536526927736855.stgit@warthog.procyon.org.uk>
 <153754743491.17872.12115848333103740766.stgit@warthog.procyon.org.uk>
 <de050902-f3d0-b2db-2627-983a36c87b3c@gmail.com>
 <862e36a2-2a6f-4e26-3228-8cab4b4cf230@gmail.com>
 <16207.1539249451@warthog.procyon.org.uk>
From:   Alan Jenkins <alan.christopher.jenkins@gmail.com>
Message-ID: <c7af263d-f265-7feb-8d40-0b0d773f24bf@gmail.com>
Date:   Thu, 11 Oct 2018 12:48:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <16207.1539249451@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2018 10:17, David Howells wrote:
> Alan Jenkins <alan.christopher.jenkins@gmail.com> wrote:
>
>> # unshare --mount=private_mnt/child_ns --propagation=shared ls -l /proc/self/ns/mnt
> I think the problem is that the mount of the nsfs object done by unshare here
> pins the new mount namespace - but doesn't add the namespace's contents into
> the mount tree, so the mount struct cycle-detection code is bypassed.
>
> I think it's fine for all other namespaces, just not the mount namespace.
>
> It looks like this bug might theoretically exist upstream also, though I don't
> think there's any way to actually effect it given that mount() doesn't take a
> dirfd argument.
>
> The reason that you can do this with open_tree()/move_mount() is that it
> allows you to create a mount tree (OPEN_TREE_CLONE) that has no namespace
> assignment, pass it through the namespace switch and then attach it inside the
> child namespace.  The cross-namespace checks in do_move_mount() are bypassed
> because the root of the newly-cloned mount tree doesn't have one.
>
> Unfortunately, just searching the newly-cloned mount tree for a conflicting
> nsfs mount doesn't help because the potential loop could be hidden several
> levels deep.
>
> I think the simplest solution is to either reject a request for
> open_tree(OPEN_TREE_CLONE) if there are any nsfs objects in the source tree,
> or to just not copy said objects.
>
> David

Very clearly written, thank you.  Hum, your solution would mean 
open_tree(OPEN_TREE_CLONE) + move_mount() is not equivalent to the 
current `mount --rbind` :-(.  That does not fit the current patch 
description.

It sounds like you're under-estimating how we can use mnt_ns->seq (as is 
currently used in mnt_ns_loop()).  Or maybe I am over-estimating it :).

In principle, it should suffice for attach_recursive_mount() to check 
the NS sequence numbers of the NS files which are mounted. You can't 
hide the loop at a deeper level inside the NS, because of the existing 
mnt_ns_loop() check.

I think mnt_ns_loop() works 100% correctly upstream, and there is no 
memory leak bug there.  You can pass a mount NS fd between processes in 
arbitrary namespaces, and you can mount it with "mount --no-canonicalize 
--bind /proc/self/fd/3 /other_ns".  But mnt_ns_loop() will only allow 
the mount when the other NS is newer than your own mount namespace.

Upstream also covers mount propagation (and CLONE_NEWNS), by simply not 
propagating mounts of mount NS files.  ( See commit 4ce5d2b1a8fd "vfs: 
Don't copy mount bind mounts of /proc/<pid>/ns/mnt between namespaces" / 
https://unix.stackexchange.com/questions/473717/what-code-prevents-mount-namespace-loops-in-a-more-complex-case-involving-mount-propagation 
)

I think it is more a question of taste :-).  Would it be acceptable to 
prune the tree (or fail?) in move_mount() (and also `mount --move`, if 
you [ab]use it like I did) ?

I suspect we should prefer your solution.  It is clearly simpler, and I 
don't know that anyone really uses `mount --rbind` to clone trees of 
mount NS files.

Either way, I suggest we take care to say whether `mount --rbind` and 
`mount --bind` can be implemented using open_tree() + move_mount(), or 
whether we think it might be undesirable.  (E.g. because someone might 
read the current commit message, and desire to implement `mount 
--bind,ro` atomically, if/when we also have mount_setattr() ).

Regards

Alan


> ---
>
> Test script:
>
> 	mount -t tmpfs none /a
> 	mount --make-shared /a
> 	cd /a
> 	mkdir private_mnt
> 	mount -t tmpfs xxx private_mnt
> 	mount --make-private private_mnt
> 	touch private_mnt/child_ns
> 	unshare --mount=private_mnt/child_ns --propagation=shared \
> 	    ls -l /proc/self/ns/mnt
> 	findmnt
>
> 	~/open_tree 3</a/private_mnt 3 \
> 	    nsenter --mount=/a/private_mnt/child_ns \
> 	    sh -c '~/move_mount 4</mnt'
>
> 	grep Shmem: /proc/meminfo
> 	dd if=/dev/zero of=/a/private_mnt/bigfile bs=1M count=10
>
> 	umount -l /a/private_mnt/
> 	grep Shmem: /proc/meminfo
