Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 877BEC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D3BA2075C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KvqrXkRm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D3BA2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753161AbeGDQ6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 12:58:35 -0400
Received: from mail-lf0-f49.google.com ([209.85.215.49]:36136 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752815AbeGDQ6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 12:58:33 -0400
Received: by mail-lf0-f49.google.com with SMTP id n24-v6so4847115lfh.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 09:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=/cyZoIrCDDvbP1P1mbqpDDlqhAbolkimyGqA2ObCa0M=;
        b=KvqrXkRm53Ws98k1iE0V5RYgM5q/H37Y3tWAcnd4vAwiEtbxUceO1bXkt1Zh7pSYmj
         PZVeyVWjHjnN8WURm/UeRq0GRH5NKX0WsGd3n4P5oJ67qev6Y19j9+NXSSKYInSvtp3A
         nmyOxujrpSld5HzHLtl3fa5dK3b5Y0WYZewlfguAZlJYpm7+DuF96zlfLW1dllYubYEr
         Ly7SrCI8vDe5Oc5eX4xpww/jZFF8Udyonk7ZZSio7aovpaDh84TCHfR+ewDB3IQUw/Ai
         K2TQrOTltd0GzZZLuJFsYzxe3KutIa8GhH24EVM6ytz5TAEKL7fpBVVPSeK9qym2O/N9
         Afkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=/cyZoIrCDDvbP1P1mbqpDDlqhAbolkimyGqA2ObCa0M=;
        b=kK30Vmm15OnWKIO/Zr/Rfa9TrZgbnIVy1A+S5Qj9xGgK2ICRlZk81Kt2LQiB+USuP0
         Xjpq+HFlb1cFg8COEL2CP/kKT+y1IqrpTgH58ufv+23pzofBeY91Ps5zfyJyAwSKpH8q
         Us+/XyJwOjNvpv5CRcylQbJB4IT68lz9/hxUwbYPtrpjmUp2sIDL/k9T6JngJGMqyVHU
         qvS5t6DymZtxVHNWQ6REa6OIwJKM+M9jUgpUMlpIE/uEbWvLpwCQoO26mGeA4kQnzrdI
         uwQ7V7R6nihmtVzdqZzPbqVXX9aeosycFF4AqPBWK9yo4w8cgiK3sjuyKCkJ5x5Vd/hE
         BKOw==
X-Gm-Message-State: APt69E1R17HEe0ism+Au2e3288S6LnesG00RZSVlPxAmQ0YRVdrLMHql
        dFGLKdaPonsQk11SMVZIhdCJOdObYjVDjovxRcKJQzWq
X-Google-Smtp-Source: AAOMgperkA0z8nqN7LQRabMNCTqNVp5E8jiRwalbwS6uknDq3v/gIAd+dMX/OtJ3Np9vu1LSTdUavExg4F7qfgdxUXg=
X-Received: by 2002:a19:f50d:: with SMTP id j13-v6mr1994208lfb.127.1530723511561;
 Wed, 04 Jul 2018 09:58:31 -0700 (PDT)
MIME-Version: 1.0
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Wed, 4 Jul 2018 18:58:28 +0200
Message-ID: <CAA85sZuXFeRzRhU2txhN0S57VE9D5sBMEYGPqF8SmABOxMM=3g@mail.gmail.com>
Subject: [nfsd] page allocation failure -> kernel oops, even local fs hangs.
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000002912ef05702f57a0"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000002912ef05702f57a0
Content-Type: text/plain; charset="UTF-8"

Hi,

I just had this happen a little while ago, got different weird
deadlocks but this one actually generated a oops..

This is basic operation, a machine with 16 gb memory mainly doing NFS traffic.

I'm currently playing with RDMA for this, which is why mlx4 is included.

When the crash occurs, the local filesystem is just as inaccessible as
trying to use it remotely - i couldn't find any change that looked
related to it in v4.18-rc3 so here goes:

(the same report is attached as well)
[1609167.131537] nfsd: page allocation failure: order:8,
mode:0x14000c0(GFP_KERNEL), nodemask=(null)
[1609167.131548] nfsd cpuset=/ mems_allowed=0
[1609167.131554] CPU: 5 PID: 1310 Comm: nfsd Not tainted 4.17.1 #196
[1609167.131557] Hardware name: To Be Filled By O.E.M. To Be Filled By
O.E.M./X370 Taichi, BIOS P4.70 04/17/2018
[1609167.131561] Call Trace:
[1609167.131567]  dump_stack+0x46/0x5b
[1609167.131571]  warn_alloc+0xf8/0x180
[1609167.131575]  ? __alloc_pages_direct_compact+0x8b/0x110
[1609167.131578]  __alloc_pages_slowpath+0xb86/0xbc0
[1609167.131583]  ? set_next_entity+0x47b/0x680
[1609167.131586]  __alloc_pages_nodemask+0x1f9/0x230
[1609167.131589]  dma_direct_alloc+0xbd/0x120
[1609167.131593]  alloc_coherent+0x60/0x160
[1609167.131599]  mlx4_buf_direct_alloc.isra.9+0xc1/0x170 [mlx4_core]
[1609167.131604]  mlx4_buf_alloc+0x158/0x1d0 [mlx4_core]
[1609167.131608]  ? _raw_spin_lock_irqsave+0x1d/0x50
[1609167.131612]  create_qp_common.isra.48+0x4bc/0x10d0 [mlx4_ib]
[1609167.131616]  ? _raw_spin_unlock_irqrestore+0xf/0x30
[1609167.131620]  ? mlx4_free_cmd_mailbox.part.20+0x17/0x20 [mlx4_core]
[1609167.131624]  mlx4_ib_create_qp+0x128/0x880 [mlx4_ib]
[1609167.131627]  ? mlx4_ib_create_cq+0x25f/0x420 [mlx4_ib]
[1609167.131633]  ib_create_qp+0x9c/0x310 [ib_core]
[1609167.131636]  rdma_create_qp+0x39/0xb0 [rdma_cm]
[1609167.131641]  svc_rdma_accept+0x325/0x4d0 [rpcrdma]
[1609167.131644]  ? _raw_spin_unlock_irqrestore+0xf/0x30
[1609167.131648]  ? try_to_del_timer_sync+0x47/0x70
[1609167.131651]  ? svc_rdma_detach+0x10/0x10 [rpcrdma]
[1609167.131655]  svc_recv+0x2cc/0x7d0
[1609167.131659]  ? nfsd_destroy+0x80/0x80
[1609167.131661]  nfsd+0xd5/0x150
[1609167.131665]  kthread+0x109/0x120
[1609167.131668]  ? kthread_create_worker_on_cpu+0x70/0x70
[1609167.131671]  ret_from_fork+0x22/0x40
[1609167.131674] Mem-Info:
[1609167.131678] active_anon:16522 inactive_anon:21289 isolated_anon:0
                  active_file:736374 inactive_file:2641993 isolated_file:23
                  unevictable:0 dirty:2 writeback:123602 unstable:0
                  slab_reclaimable:103077 slab_unreclaimable:76545
                  mapped:10454 shmem:318 pagetables:2054 bounce:0
                  free:42337 free_pcp:12 free_cma:0
[1609167.136395] Node 0 active_anon:66088kB inactive_anon:85156kB
active_file:2945496kB inactive_file:10567972kB unevictable:0kB
isolated(anon):0kB isolated
(file):92kB mapped:41816kB dirty:8kB writeback:494408kB shmem:1272kB
shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 98304kB
writeback_tmp:0kB unstable:0kB al
l_unreclaimable? no
[1609167.138299] Node 0 DMA free:15900kB min:64kB low:80kB high:96kB
active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB
unevictable:0kB wri
tepending:0kB present:15984kB managed:15900kB mlocked:0kB
kernel_stack:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB
free_cma:0kB
[1609167.140313] lowmem_reserve[]: 0 3449 15946 15946
[1609167.141305] Node 0 DMA32 free:75596kB min:14604kB low:18252kB
high:21900kB active_anon:7208kB inactive_anon:10828kB
active_file:651676kB inactive_file:
2600688kB unevictable:0kB writepending:151540kB present:3597884kB
managed:3597884kB mlocked:0kB kernel_stack:288kB pagetables:20kB
bounce:0kB free_pcp:0kB l
ocal_pcp:0kB free_cma:0kB
[1609167.143453] lowmem_reserve[]: 0 0 12497 12497
[1609167.144600] Node 0 Normal free:77852kB min:52912kB low:66140kB
high:79368kB active_anon:58880kB inactive_anon:74328kB
active_file:2293820kB inactive_fi
le:7967284kB unevictable:0kB writepending:342876kB present:13094400kB
managed:12802572kB mlocked:0kB kernel_stack:5760kB pagetables:8196kB
bounce:0kB free_p
cp:48kB local_pcp:48kB free_cma:0kB
[1609167.146913] lowmem_reserve[]: 0 0 0 0
[1609167.148033] Node 0 DMA: 1*4kB (U) 1*8kB (U) 1*16kB (U) 0*32kB
2*64kB (U) 1*128kB (U) 1*256kB (U) 0*512kB 1*1024kB (U) 1*2048kB (M)
3*4096kB (M) = 15900
kB
[1609167.149199] Node 0 DMA32: 564*4kB (UME) 640*8kB (UME) 465*16kB
(UME) 358*32kB (UME) 275*64kB (UME) 119*128kB (UME) 45*256kB (UM)
10*512kB (M) 0*1024kB
0*2048kB 0*4096kB = 75744kB
[1609167.150389] Node 0 Normal: 1517*4kB (UMEH) 1231*8kB (UMEH)
840*16kB (UMEH) 545*32kB (UM) 304*64kB (UM) 62*128kB (UM) 14*256kB (M)
1*512kB (M) 0*1024kB
0*2048kB 0*4096kB = 78284kB
[1609167.151592] Node 0 hugepages_total=0 hugepages_free=0
hugepages_surp=0 hugepages_size=1048576kB
[1609167.152783] Node 0 hugepages_total=0 hugepages_free=0
hugepages_surp=0 hugepages_size=2048kB
[1609167.153980] 3379126 total pagecache pages
[1609167.155155] 368 pages in swap cache
[1609167.156328] Swap cache stats: add 19348, delete 18980, find 6477/7599
[1609167.157509] Free swap  = 20942168kB
[1609167.158679] Total swap = 20971516kB
[1609167.159839] 4177067 pages RAM
[1609167.161028] 0 pages HighMem/MovableOnly
[1609167.162177] 72978 pages reserved
[1609167.163319] 0 pages cma reserved
[1609167.164443] 0 pages hwpoisoned

--0000000000002912ef05702f57a0
Content-Type: text/plain; charset="US-ASCII"; name="nfsd-crash.txt"
Content-Disposition: attachment; filename="nfsd-crash.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_jj7d4ofj0>
X-Attachment-Id: f_jj7d4ofj0

WzE2MDkxNjcuMTMxNTM3XSBuZnNkOiBwYWdlIGFsbG9jYXRpb24gZmFpbHVyZTogb3JkZXI6OCwg
bW9kZToweDE0MDAwYzAoR0ZQX0tFUk5FTCksIG5vZGVtYXNrPShudWxsKQpbMTYwOTE2Ny4xMzE1
NDhdIG5mc2QgY3B1c2V0PS8gbWVtc19hbGxvd2VkPTAgICAgICAgICAgICAgClsxNjA5MTY3LjEz
MTU1NF0gQ1BVOiA1IFBJRDogMTMxMCBDb21tOiBuZnNkIE5vdCB0YWludGVkIDQuMTcuMSAjMTk2
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKWzE2MDkxNjcu
MTMxNTU3XSBIYXJkd2FyZSBuYW1lOiBUbyBCZSBGaWxsZWQgQnkgTy5FLk0uIFRvIEJlIEZpbGxl
ZCBCeSBPLkUuTS4vWDM3MCBUYWljaGksIEJJT1MgUDQuNzAgMDQvMTcvMjAxOApbMTYwOTE2Ny4x
MzE1NjFdIENhbGwgVHJhY2U6ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIApbMTYwOTE2Ny4xMzE1NjddICBkdW1wX3N0YWNrKzB4NDYvMHg1YiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIApbMTYw
OTE2Ny4xMzE1NzFdICB3YXJuX2FsbG9jKzB4ZjgvMHgxODAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIApbMTYwOTE2Ny4xMzE1NzVd
ICA/IF9fYWxsb2NfcGFnZXNfZGlyZWN0X2NvbXBhY3QrMHg4Yi8weDExMCAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgClsxNjA5MTY3LjEzMTU3OF0gIF9fYWxsb2NfcGFnZXNfc2xvd3Bh
dGgrMHhiODYvMHhiYzAgICAgICAgICAgICAgICAgICAgICAgICAgICAKWzE2MDkxNjcuMTMxNTgz
XSAgPyBzZXRfbmV4dF9lbnRpdHkrMHg0N2IvMHg2ODAgICAgIApbMTYwOTE2Ny4xMzE1ODZdICBf
X2FsbG9jX3BhZ2VzX25vZGVtYXNrKzB4MWY5LzB4MjMwICAgICAgICAgICAgICAgICAgICAgClsx
NjA5MTY3LjEzMTU4OV0gIGRtYV9kaXJlY3RfYWxsb2MrMHhiZC8weDEyMCAgICAgICAgICAgICAg
ICAgClsxNjA5MTY3LjEzMTU5M10gIGFsbG9jX2NvaGVyZW50KzB4NjAvMHgxNjAgICAgICAgICAg
ICAgICAgICAgClsxNjA5MTY3LjEzMTU5OV0gIG1seDRfYnVmX2RpcmVjdF9hbGxvYy5pc3JhLjkr
MHhjMS8weDE3MCBbbWx4NF9jb3JlXQpbMTYwOTE2Ny4xMzE2MDRdICBtbHg0X2J1Zl9hbGxvYysw
eDE1OC8weDFkMCBbbWx4NF9jb3JlXSAgICAgICAgICAKWzE2MDkxNjcuMTMxNjA4XSAgPyBfcmF3
X3NwaW5fbG9ja19pcnFzYXZlKzB4MWQvMHg1MCAgICAgICAgICAgICAgClsxNjA5MTY3LjEzMTYx
Ml0gIGNyZWF0ZV9xcF9jb21tb24uaXNyYS40OCsweDRiYy8weDEwZDAgW21seDRfaWJdIApbMTYw
OTE2Ny4xMzE2MTZdICA/IF9yYXdfc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSsweGYvMHgzMCAgICAg
ICAgICAKWzE2MDkxNjcuMTMxNjIwXSAgPyBtbHg0X2ZyZWVfY21kX21haWxib3gucGFydC4yMCsw
eDE3LzB4MjAgW21seDRfY29yZV0KWzE2MDkxNjcuMTMxNjI0XSAgbWx4NF9pYl9jcmVhdGVfcXAr
MHgxMjgvMHg4ODAgW21seDRfaWJdICAgICAgICAgClsxNjA5MTY3LjEzMTYyN10gID8gbWx4NF9p
Yl9jcmVhdGVfY3ErMHgyNWYvMHg0MjAgW21seDRfaWJdICAgICAgICAgICAgICAgICAgICAgICAg
IApbMTYwOTE2Ny4xMzE2MzNdICBpYl9jcmVhdGVfcXArMHg5Yy8weDMxMCBbaWJfY29yZV0gICAg
ICAgICAgICAgICAgICAKWzE2MDkxNjcuMTMxNjM2XSAgcmRtYV9jcmVhdGVfcXArMHgzOS8weGIw
IFtyZG1hX2NtXSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIApbMTYwOTE2Ny4xMzE2
NDFdICBzdmNfcmRtYV9hY2NlcHQrMHgzMjUvMHg0ZDAgW3JwY3JkbWFdICAgICAgICAgICAgICAg
ICAgICAKWzE2MDkxNjcuMTMxNjQ0XSAgPyBfcmF3X3NwaW5fdW5sb2NrX2lycXJlc3RvcmUrMHhm
LzB4MzAgICAgICAgICAgICAgClsxNjA5MTY3LjEzMTY0OF0gID8gdHJ5X3RvX2RlbF90aW1lcl9z
eW5jKzB4NDcvMHg3MCAgICAgICAgICAgICAgICAgICAKWzE2MDkxNjcuMTMxNjUxXSAgPyBzdmNf
cmRtYV9kZXRhY2grMHgxMC8weDEwIFtycGNyZG1hXSAgICAgICAgICAgICAKWzE2MDkxNjcuMTMx
NjU1XSAgc3ZjX3JlY3YrMHgyY2MvMHg3ZDAgICAgICAgICAgICAgICAgICAgICAgIApbMTYwOTE2
Ny4xMzE2NTldICA/IG5mc2RfZGVzdHJveSsweDgwLzB4ODAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgClsxNjA5MTY3LjEzMTY2MV0gIG5mc2QrMHhkNS8weDE1
MCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIApbMTYwOTE2Ny4xMzE2
NjVdICBrdGhyZWFkKzB4MTA5LzB4MTIwICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgClsxNjA5MTY3LjEzMTY2OF0gID8ga3RocmVhZF9jcmVhdGVfd29y
a2VyX29uX2NwdSsweDcwLzB4NzAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgClsx
NjA5MTY3LjEzMTY3MV0gIHJldF9mcm9tX2ZvcmsrMHgyMi8weDQwICAgICAgICAgICAgICAgICAg
ICAgICAgICAgClsxNjA5MTY3LjEzMTY3NF0gTWVtLUluZm86ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIApbMTYwOTE2Ny4xMzE2NzhdIGFjdGl2ZV9hbm9uOjE2NTIyIGluYWN0aXZlX2Fub246
MjEyODkgaXNvbGF0ZWRfYW5vbjowCiAgICAgICAgICAgICAgICAgIGFjdGl2ZV9maWxlOjczNjM3
NCBpbmFjdGl2ZV9maWxlOjI2NDE5OTMgaXNvbGF0ZWRfZmlsZToyMwogICAgICAgICAgICAgICAg
ICB1bmV2aWN0YWJsZTowIGRpcnR5OjIgd3JpdGViYWNrOjEyMzYwMiB1bnN0YWJsZTowCiAgICAg
ICAgICAgICAgICAgIHNsYWJfcmVjbGFpbWFibGU6MTAzMDc3IHNsYWJfdW5yZWNsYWltYWJsZTo3
NjU0NQogICAgICAgICAgICAgICAgICBtYXBwZWQ6MTA0NTQgc2htZW06MzE4IHBhZ2V0YWJsZXM6
MjA1NCBib3VuY2U6MAogICAgICAgICAgICAgICAgICBmcmVlOjQyMzM3IGZyZWVfcGNwOjEyIGZy
ZWVfY21hOjAgICAgICAgICAgICAKWzE2MDkxNjcuMTM2Mzk1XSBOb2RlIDAgYWN0aXZlX2Fub246
NjYwODhrQiBpbmFjdGl2ZV9hbm9uOjg1MTU2a0IgYWN0aXZlX2ZpbGU6Mjk0NTQ5NmtCIGluYWN0
aXZlX2ZpbGU6MTA1Njc5NzJrQiB1bmV2aWN0YWJsZTowa0IgaXNvbGF0ZWQoYW5vbik6MGtCIGlz
b2xhdGVkCihmaWxlKTo5MmtCIG1hcHBlZDo0MTgxNmtCIGRpcnR5OjhrQiB3cml0ZWJhY2s6NDk0
NDA4a0Igc2htZW06MTI3MmtCIHNobWVtX3RocDogMGtCIHNobWVtX3BtZG1hcHBlZDogMGtCIGFu
b25fdGhwOiA5ODMwNGtCIHdyaXRlYmFja190bXA6MGtCIHVuc3RhYmxlOjBrQiBhbApsX3VucmVj
bGFpbWFibGU/IG5vICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ClsxNjA5MTY3LjEzODI5OV0gTm9kZSAwIERNQSBmcmVlOjE1OTAwa0IgbWluOjY0a0IgbG93Ojgw
a0IgaGlnaDo5NmtCIGFjdGl2ZV9hbm9uOjBrQiBpbmFjdGl2ZV9hbm9uOjBrQiBhY3RpdmVfZmls
ZTowa0IgaW5hY3RpdmVfZmlsZTowa0IgdW5ldmljdGFibGU6MGtCIHdyaQp0ZXBlbmRpbmc6MGtC
IHByZXNlbnQ6MTU5ODRrQiBtYW5hZ2VkOjE1OTAwa0IgbWxvY2tlZDowa0Iga2VybmVsX3N0YWNr
OjBrQiBwYWdldGFibGVzOjBrQiBib3VuY2U6MGtCIGZyZWVfcGNwOjBrQiBsb2NhbF9wY3A6MGtC
IGZyZWVfY21hOjBrQgpbMTYwOTE2Ny4xNDAzMTNdIGxvd21lbV9yZXNlcnZlW106IDAgMzQ0OSAx
NTk0NiAxNTk0NiAgICAgICAgICAgICAKWzE2MDkxNjcuMTQxMzA1XSBOb2RlIDAgRE1BMzIgZnJl
ZTo3NTU5NmtCIG1pbjoxNDYwNGtCIGxvdzoxODI1MmtCIGhpZ2g6MjE5MDBrQiBhY3RpdmVfYW5v
bjo3MjA4a0IgaW5hY3RpdmVfYW5vbjoxMDgyOGtCIGFjdGl2ZV9maWxlOjY1MTY3NmtCIGluYWN0
aXZlX2ZpbGU6CjI2MDA2ODhrQiB1bmV2aWN0YWJsZTowa0Igd3JpdGVwZW5kaW5nOjE1MTU0MGtC
IHByZXNlbnQ6MzU5Nzg4NGtCIG1hbmFnZWQ6MzU5Nzg4NGtCIG1sb2NrZWQ6MGtCIGtlcm5lbF9z
dGFjazoyODhrQiBwYWdldGFibGVzOjIwa0IgYm91bmNlOjBrQiBmcmVlX3BjcDowa0IgbApvY2Fs
X3BjcDowa0IgZnJlZV9jbWE6MGtCICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgClsxNjA5MTY3LjE0MzQ1M10gbG93bWVtX3Jlc2VydmVbXTogMCAwIDEy
NDk3IDEyNDk3ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIApbMTYwOTE2Ny4xNDQ2MDBdIE5vZGUgMCBOb3JtYWwgZnJlZTo3Nzg1MmtC
IG1pbjo1MjkxMmtCIGxvdzo2NjE0MGtCIGhpZ2g6NzkzNjhrQiBhY3RpdmVfYW5vbjo1ODg4MGtC
IGluYWN0aXZlX2Fub246NzQzMjhrQiBhY3RpdmVfZmlsZToyMjkzODIwa0IgaW5hY3RpdmVfZmkK
bGU6Nzk2NzI4NGtCIHVuZXZpY3RhYmxlOjBrQiB3cml0ZXBlbmRpbmc6MzQyODc2a0IgcHJlc2Vu
dDoxMzA5NDQwMGtCIG1hbmFnZWQ6MTI4MDI1NzJrQiBtbG9ja2VkOjBrQiBrZXJuZWxfc3RhY2s6
NTc2MGtCIHBhZ2V0YWJsZXM6ODE5NmtCIGJvdW5jZTowa0IgZnJlZV9wCmNwOjQ4a0IgbG9jYWxf
cGNwOjQ4a0IgZnJlZV9jbWE6MGtCICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAKWzE2MDkxNjcuMTQ2OTEzXSBsb3dtZW1fcmVzZXJ2ZVtdOiAwIDAgMCAwClsxNjA5MTY3LjE0
ODAzM10gTm9kZSAwIERNQTogMSo0a0IgKFUpIDEqOGtCIChVKSAxKjE2a0IgKFUpIDAqMzJrQiAy
KjY0a0IgKFUpIDEqMTI4a0IgKFUpIDEqMjU2a0IgKFUpIDAqNTEya0IgMSoxMDI0a0IgKFUpIDEq
MjA0OGtCIChNKSAzKjQwOTZrQiAoTSkgPSAxNTkwMAprQiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgClsxNjA5MTY3LjE0OTE5OV0gTm9kZSAwIERNQTMyOiA1NjQqNGtCIChVTUUpIDY0MCo4
a0IgKFVNRSkgNDY1KjE2a0IgKFVNRSkgMzU4KjMya0IgKFVNRSkgMjc1KjY0a0IgKFVNRSkgMTE5
KjEyOGtCIChVTUUpIDQ1KjI1NmtCIChVTSkgMTAqNTEya0IgKE0pIDAqMTAyNGtCIAowKjIwNDhr
QiAwKjQwOTZrQiA9IDc1NzQ0a0IKWzE2MDkxNjcuMTUwMzg5XSBOb2RlIDAgTm9ybWFsOiAxNTE3
KjRrQiAoVU1FSCkgMTIzMSo4a0IgKFVNRUgpIDg0MCoxNmtCIChVTUVIKSA1NDUqMzJrQiAoVU0p
IDMwNCo2NGtCIChVTSkgNjIqMTI4a0IgKFVNKSAxNCoyNTZrQiAoTSkgMSo1MTJrQiAoTSkgMCox
MDI0a0IgCjAqMjA0OGtCIDAqNDA5NmtCID0gNzgyODRrQgpbMTYwOTE2Ny4xNTE1OTJdIE5vZGUg
MCBodWdlcGFnZXNfdG90YWw9MCBodWdlcGFnZXNfZnJlZT0wIGh1Z2VwYWdlc19zdXJwPTAgaHVn
ZXBhZ2VzX3NpemU9MTA0ODU3NmtCClsxNjA5MTY3LjE1Mjc4M10gTm9kZSAwIGh1Z2VwYWdlc190
b3RhbD0wIGh1Z2VwYWdlc19mcmVlPTAgaHVnZXBhZ2VzX3N1cnA9MCBodWdlcGFnZXNfc2l6ZT0y
MDQ4a0IKWzE2MDkxNjcuMTUzOTgwXSAzMzc5MTI2IHRvdGFsIHBhZ2VjYWNoZSBwYWdlcwpbMTYw
OTE2Ny4xNTUxNTVdIDM2OCBwYWdlcyBpbiBzd2FwIGNhY2hlClsxNjA5MTY3LjE1NjMyOF0gU3dh
cCBjYWNoZSBzdGF0czogYWRkIDE5MzQ4LCBkZWxldGUgMTg5ODAsIGZpbmQgNjQ3Ny83NTk5Clsx
NjA5MTY3LjE1NzUwOV0gRnJlZSBzd2FwICA9IDIwOTQyMTY4a0IKWzE2MDkxNjcuMTU4Njc5XSBU
b3RhbCBzd2FwID0gMjA5NzE1MTZrQgpbMTYwOTE2Ny4xNTk4MzldIDQxNzcwNjcgcGFnZXMgUkFN
ClsxNjA5MTY3LjE2MTAyOF0gMCBwYWdlcyBIaWdoTWVtL01vdmFibGVPbmx5ClsxNjA5MTY3LjE2
MjE3N10gNzI5NzggcGFnZXMgcmVzZXJ2ZWQKWzE2MDkxNjcuMTYzMzE5XSAwIHBhZ2VzIGNtYSBy
ZXNlcnZlZApbMTYwOTE2Ny4xNjQ0NDNdIDAgcGFnZXMgaHdwb2lzb25lZAoK
--0000000000002912ef05702f57a0--
