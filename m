Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41577C3279B
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 01:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E10E22240E
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 01:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKubBFkN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E10E22240E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932778AbeGGBlg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 21:41:36 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39695 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932642AbeGGBle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 21:41:34 -0400
Received: by mail-wm0-f67.google.com with SMTP id h20-v6so7365wmb.4;
        Fri, 06 Jul 2018 18:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:openpgp:autocrypt:to:cc:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=cxc7BSGiiR5jWXyfWvkFNBG6rCTOrhajDuYKIWcGZ5c=;
        b=JKubBFkN4RCSYsGiWIq1qMP2xnwSzFdD2MMMtdrPK6czEqWEg2lfZal3ippHWX5Ca4
         rDU6wjGw8gAHOTXrVhVDFnCp+jKosGmjb4KPGkKnBJHV8zXu0hRL4vmtdGUB7EV/h8Fz
         QSTwSHx1ay0Tvo41EmdV5YRn6QXY21lAynuLHIXmV+7fV+dvFYJsaBqJu70EyDe/ICgJ
         ZOYdiZNPLdG1bsmeAEzru1vDdE98eGlo+BiZnOHWIc1OhILlvjFMmfTa3qRbIxVL/AWk
         SSEUU+tLKQ5GG3D9x96Rf8r1UP9s/9EHlktwpL9lUp9v9tdJWmHonGRp3HMjQDjDI8vk
         YPvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:openpgp:autocrypt:to:cc:message-id
         :date:user-agent:mime-version:content-transfer-encoding
         :content-language;
        bh=cxc7BSGiiR5jWXyfWvkFNBG6rCTOrhajDuYKIWcGZ5c=;
        b=C5+GKTg8Y7KhI8KDaPR30L17Zbvffr3jkh23te1pWV1Wmlt6xYmUvpSzk4bDlAtzVo
         zecrBoWLhMAFHRiJiy53o7roiGR7+cDz0rZE3AuAlXp8WKwNODeQdOeu8fjVcFUn81Ud
         f2m42htNcJhLLnSRFZ1myUXZw+7jrFGj6RDKIPK08W3NwWVQfIhDulKnBl6wG3kLVsPE
         ay3neSlNWfgKAzsZDi1D6bmfiM/DAuaD/DHHO0P6dK25VrbG/eIvlXVUd0/iZ6pFIzk9
         V9AkMfpee/kXmTe+meZZa8OYILWlv0CzIv3srROmwkRh0YSuj2twdkafnudr3i+VTEFg
         OzYg==
X-Gm-Message-State: APt69E0DBEBXA+/xsFTBAyNHCttE40VMXdv4ivO5sc6eScmiY3TkvfYI
        TNJhISYf30aPz+5OkNqH2Os=
X-Google-Smtp-Source: AAOMgpcbTkVX8sK/y1WJxKJj4XflCTa1RGiC74GnFwqkkMlWySB53ciopciHv6tEuMvKP19+Oza+Sg==
X-Received: by 2002:a1c:1748:: with SMTP id 69-v6mr1997766wmx.75.1530927692527;
        Fri, 06 Jul 2018 18:41:32 -0700 (PDT)
Received: from [192.168.8.10] ([185.175.214.210])
        by smtp.gmail.com with ESMTPSA id n8-v6sm14978933wmg.27.2018.07.06.18.41.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 18:41:31 -0700 (PDT)
From:   Tomas Bortoli <tomasbortoli@gmail.com>
Subject: [PATCH] KASAN: use-after-free Read in rdma_listen
Openpgp: preference=signencrypt
Autocrypt: addr=tomasbortoli@gmail.com; prefer-encrypt=mutual; keydata=
 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
To:     dledford@redhat.com, jgg@ziepe.ca
Cc:     leon@kernel.org, parav@mellanox.com, roland@purestorage.com,
        swise@opengridcomputing.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller@googlegroups.com
Message-ID: <b7dd13a9-cb0d-7e10-beb2-3fb25214067a@gmail.com>
Date:   Sat, 7 Jul 2018 03:41:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I spent some time debugging the Syzkaller's found issue at subject:

https://syzkaller.appspot.com/bug?id=3Db8febdb3c7c8c1f1b606fb903cee66b21b=
2fd02f

And I've backtracked the UAF to the fact that the cma_listen_on_all()
function adds "id_priv->list" to the global var "listen_any_list" but
then such element is not removed in the rdma_destroy_id() function
(though I've seen that the call to cma_release_dev() in
rdma_destroy_id() should do the removal but doesn't get executed).

Therefore, if a program allocates a "struct rdma_cm_id" (through
ucma_open + ucma_create_id), then executes cma_listen_on_all(), then
frees the struct and repeat, during the second execution of
cma_listen_on_all() the kernel will try to update the references of the
freed node, triggering the UAF. I was able to fix the UAF with this ugly
patch:

--- b/drivers/infiniband/core/cma.c=C2=A0=C2=A0 =C2=A02018-07-07 02:28:03=
=2E214589868 +0200
+++ a/drivers/infiniband/core/cma.c=C2=A0=C2=A0 =C2=A02018-07-07 03:35:44=
=2E325301216 +0200
@@ -1678,6 +1678,11 @@ void rdma_destroy_id(struct rdma_cm_id *
=C2=A0=C2=A0=C2=A0 =C2=A0mutex_lock(&id_priv->handler_mutex);
=C2=A0=C2=A0=C2=A0 =C2=A0mutex_unlock(&id_priv->handler_mutex);
=C2=A0
+=C2=A0=C2=A0 =C2=A0mutex_lock(&lock);
+=C2=A0=C2=A0 =C2=A0if(id_priv->list.next!=3D0 && id_priv->list.prev!=3D0=
)
+=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0list_del(&id_priv->list);
+=C2=A0=C2=A0 =C2=A0mutex_unlock(&lock);
+
=C2=A0=C2=A0=C2=A0 =C2=A0if (id_priv->cma_dev) {
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0rdma_restrack_del(&id_priv->r=
es);
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0if (rdma_cap_ib_cm(id_priv->i=
d.device, 1)) {

Note: I only tested this patch against the shortest reproducer for this
issue (not any other use of rdma_cm):

https://syzkaller.appspot.com/text?tag=3DReproC&x=3D1334f10f800000

I had to add that "if" in the patch because running the reproducer
(after several iterations) provoked a NULL-dereference in the added
list_del() call because for some reason I haven't cleared yet the next
and prev pointers of the list at issue gets zeroed, sometimes ( by what ?=
?).


Moreover, I noticed that running the reproducer for "long" time exhaust
all the available memory. To spot the memory leaks I recompiled with:

CONFIG_HAVE_DEBUG_KMEMLEAK=3Dy
CONFIG_DEBUG_KMEMLEAK=3Dy
CONFIG_DEBUG_KMEMLEAK_EARLY_LOG_SIZE=3D10000

The reproducer induces, apparently, 2 memory leaks reported by kmemleak:

unreferenced object 0xffff880069f49d40 (size 512):
=C2=A0 comm "repro", pid 4263, jiffies 4294722196 (age 688.262s)
=C2=A0 hex dump (first 32 bytes):
=C2=A0=C2=A0=C2=A0 00 b8 13 5a 00 88 ff ff 40 9d f4 69 00 88 ff ff=C2=A0 =
=2E..Z....@..i....
=C2=A0=C2=A0=C2=A0 0a 00 98 a6 00 00 00 00 fe 80 00 00 00 00 00 00=C2=A0 =
=2E...............
=C2=A0 backtrace:
=C2=A0=C2=A0=C2=A0 [<0000000075a2f334>] kmem_cache_alloc_trace+0x1b2/0x3d=
0
=C2=A0=C2=A0=C2=A0 [<0000000075fd9fea>] rdma_resolve_ip+0xc0/0x6b0
=C2=A0=C2=A0=C2=A0 [<0000000033592b0b>] rdma_resolve_addr+0x490/0x2580
=C2=A0=C2=A0=C2=A0 [<00000000d6f2cd9d>] ucma_resolve_ip+0x193/0x260
=C2=A0=C2=A0=C2=A0 [<0000000068f1c2b7>] ucma_write+0x2ec/0x3f0
=C2=A0=C2=A0=C2=A0 [<00000000015692cc>] __vfs_write+0x107/0x920
=C2=A0=C2=A0=C2=A0 [<000000009528b010>] vfs_write+0x189/0x510
=C2=A0=C2=A0=C2=A0 [<000000001a5d169b>] ksys_write+0xfa/0x240
=C2=A0=C2=A0=C2=A0 [<00000000b747746a>] __x64_sys_write+0x73/0xb0
=C2=A0=C2=A0=C2=A0 [<0000000071590ffb>] do_syscall_64+0x18c/0x760
=C2=A0=C2=A0=C2=A0 [<000000003c31113f>] entry_SYSCALL_64_after_hwframe+0x=
49/0xbe
=C2=A0=C2=A0=C2=A0 [<0000000059247e9d>] 0xffffffffffffffff


unreferenced object 0xffff88006c0c0bc0 (size 576):
=C2=A0 comm "repro", pid 4261, jiffies 4294722191 (age 688.261s)
=C2=A0 hex dump (first 32 bytes):
=C2=A0=C2=A0=C2=A0 00 02 00 00 00 00 00 00 80 b8 07 6c 00 88 ff ff=C2=A0 =
=2E..........l....
=C2=A0=C2=A0=C2=A0 b0 7d 2c 6b 00 88 ff ff d8 0b 0c 6c 00 88 ff ff=C2=A0 =
=2E},k.......l....
=C2=A0 backtrace:
=C2=A0=C2=A0=C2=A0 [<0000000039511ef2>] kmem_cache_alloc+0x1b2/0x3d0
=C2=A0=C2=A0=C2=A0 [<00000000106bf668>] radix_tree_node_alloc.constprop.1=
8+0x5e/0x2e0
=C2=A0=C2=A0=C2=A0 [<000000005b2f026d>] idr_get_free+0x9f5/0x1000
=C2=A0=C2=A0=C2=A0 [<00000000445baa5a>] idr_alloc_u32+0x1bc/0x3d0
=C2=A0=C2=A0=C2=A0 [<000000007fd1b6f4>] idr_alloc+0xfd/0x190
=C2=A0=C2=A0=C2=A0 [<00000000d706389e>] cma_alloc_port+0xb0/0x170
=C2=A0=C2=A0=C2=A0 [<000000008f968f9e>] rdma_bind_addr+0x1252/0x1f00
=C2=A0=C2=A0=C2=A0 [<00000000e3361215>] rdma_resolve_addr+0x39e/0x2580
=C2=A0=C2=A0=C2=A0 [<00000000d6f2cd9d>] ucma_resolve_ip+0x193/0x260
=C2=A0=C2=A0=C2=A0 [<0000000068f1c2b7>] ucma_write+0x2ec/0x3f0
=C2=A0=C2=A0=C2=A0 [<00000000015692cc>] __vfs_write+0x107/0x920
=C2=A0=C2=A0=C2=A0 [<000000009528b010>] vfs_write+0x189/0x510
=C2=A0=C2=A0=C2=A0 [<000000001a5d169b>] ksys_write+0xfa/0x240
=C2=A0=C2=A0=C2=A0 [<00000000b747746a>] __x64_sys_write+0x73/0xb0
=C2=A0=C2=A0=C2=A0 [<0000000071590ffb>] do_syscall_64+0x18c/0x760
=C2=A0=C2=A0=C2=A0 [<000000003c31113f>] entry_SYSCALL_64_after_hwframe+0x=
49/0xbe

I don't have a background on usage or internals of the driver at issue
but I hope these clues will help in finding the proper fix.

Tomas


