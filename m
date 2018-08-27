Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2741C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71720208E2
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TP3654Sm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71720208E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbeH0W6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 18:58:52 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36598 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbeH0W6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 18:58:52 -0400
Received: by mail-wr1-f65.google.com with SMTP id m27-v6so53292wrf.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 12:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vQ3YRfPhy3qzYABUWG9RPHSRLYweBmVTXcDrVI88uuY=;
        b=TP3654SmBDcHPt/P9x0dZj+JJndANZJ6jOnkmAFdI8q/05bjK0GIHgWcwHRSVR2vtD
         KMGr/Q4/WvEg1gFbWu1gA8Svxmam0JvL8fr5GrN0MliPQd/4h9c8oPuBv4hbT7CW3Ivd
         r3GStzPDkPUt3Hn7KHQTVTBO7BU5iE54656dixVg2cL3sBLeCZwW4uou4lnovXawhwX1
         gEjLBafeFUrbAAya7DXuQgl/X9F2MgGYr7dTUmtGmnalDqmxVUxnAaNWpMiJi0tJ008z
         PHBp67LrMDJSuomJ/zejJzgzUBYZaYAh33UiyLZ7Hrj1s+3LMnSJa0xHVyE46efhFtfS
         gfyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vQ3YRfPhy3qzYABUWG9RPHSRLYweBmVTXcDrVI88uuY=;
        b=ExtQTw1+OjrO060rStG4Glpnsj6gZdrDYSqKeiDh1YKjVQRs99kyM/hn/fR1kPjisQ
         4NWhB5qF+tcNwXPMkPWbGnMbPBnykpTIdWoSPHhKVHMr50l9Zq5nYgp1s3HixN1wbxrx
         Q/YuM2kMVVjEi61maR7ldLNSUe+iqjGW37XXVitqf/pfa3QVe3YhNUGaV01n9pUO+mKU
         WLjxg0znwdV4JFHoFr8sDBvU5xI3tsgTqE75LMIiNHMbDODWvb5mMD/YqXTFqMHJzXes
         8i6HqWvDxuQhotnWgJg03P6GWFfm559o0MRl9xS8Y99Nyuc0IbpJ/IOCuQxjRcflE0kk
         EmSw==
X-Gm-Message-State: APzg51CalORDlJNC/dUF+MVS5dkYc+cRPyOD/Ux39N9kzYYKxFms+Ozt
        m6mUIBgyPWZqMDdtYV03k3K3OUPkegqtSNFr1UU=
X-Google-Smtp-Source: ANB0VdZNrX8kOKE87WvXU9e94wW9guXIQ9RmsTU835xyAbPH2c0z1iQ2Njq4ohyFqudSj19ZY9A7n5lYQgVFLHLGmRQ=
X-Received: by 2002:adf:f8ca:: with SMTP id f10-v6mr10163671wrq.237.1535397058160;
 Mon, 27 Aug 2018 12:10:58 -0700 (PDT)
MIME-Version: 1.0
References: <CA+55aFw9mxNPX6OtOp-aoUMdXSg=gBkQudGGamo__sh_ts_LdQ@mail.gmail.com>
In-Reply-To: <CA+55aFw9mxNPX6OtOp-aoUMdXSg=gBkQudGGamo__sh_ts_LdQ@mail.gmail.com>
From:   Shuah Khan <shuahkhan@gmail.com>
Date:   Mon, 27 Aug 2018 13:10:46 -0600
Message-ID: <CAKocOOMQ7wukxNV1QL1to8SC2XgxsZUJ_7=fb7ZkN4r1tXBaew@mail.gmail.com>
Subject: Re: Linux 4.19-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        tomas.winkler@intel.com
Cc:     LKML <linux-kernel@vger.kernel.org>, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 26, 2018 at 3:51 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So two weeks have passed, and the merge window for 4.19 is over.
>


> Anyway, go forth and test,
>

I am seeing the errors use-after-free errors in mei_cl_write. dmesg as follows.
Adding Tomas Winkler to the thread.

[   12.602912] PM: Adding info for
mei:mei::309dcde8-ccb1-4062-8f78-600115a34327:01
[   12.603126] ==================================================================
[   12.603205] BUG: KASAN: use-after-free in mei_cl_write+0x481/0x860
[   12.603248] Read of size 8 at addr ffff880416d3a320 by task kworker/2:1/68

[   12.603311] CPU: 2 PID: 68 Comm: kworker/2:1 Tainted: G        W
     4.19.0-rc1 #1
[   12.603363] Hardware name: System76, Inc. Wild Dog
Performance/H87-PLUS, BIOS 0705 12/05/2013
[   12.603420] Workqueue: events mei_cl_bus_rescan_work
[   12.603459] Call Trace:
[   12.603486]  dump_stack+0x7c/0xbb
[   12.603520]  print_address_description+0x73/0x280
[   12.603560]  kasan_report+0x258/0x380
[   12.603589]  ? mei_cl_write+0x481/0x860
[   12.603625]  mei_cl_write+0x481/0x860
[   12.603664]  ? mei_cl_irq_write+0x570/0x570
[   12.603699]  ? kasan_unpoison_shadow+0x30/0x40
[   12.603735]  ? kasan_kmalloc+0xa0/0xd0
[   12.603770]  ? wait_woken+0x140/0x140
[   12.603803]  ? mei_cl_alloc_cb+0xa9/0xf0
[   12.603847]  __mei_cl_send+0x371/0x3e0
[   12.603888]  ? wait_for_completion+0x1d0/0x1d0
[   12.603923]  ? mei_cldev_driver_unregister+0x40/0x40
[   12.603961]  ? find_first_zero_bit+0x19/0x70
[   12.604014]  mei_mkhi_fix+0x12d/0x480
[   12.604045]  ? worker_thread+0x69/0x690
[   12.604075]  ? kthread+0x1ae/0x1d0
[   12.604103]  ? ret_from_fork+0x3a/0x50
[   12.604135]  ? check_chain_key+0x139/0x1f0
[   12.604173]  ? mei_wd+0xa0/0xa0
[   12.604203]  ? mark_lock+0xc7/0x7c0
[   12.604234]  ? mark_lock+0xc7/0x7c0
[   12.604285]  mei_cl_bus_dev_fixup+0x196/0x1b0
[   12.604322]  ? mei_nfc+0x4d0/0x4d0
[   12.604354]  ? lockdep_hardirqs_on+0x18c/0x280
[   12.604400]  ? __kasan_slab_free+0x143/0x180
[   12.604441]  ? mei_cl_bus_rescan_work+0x2f1/0x500
[   12.604477]  mei_cl_bus_rescan_work+0x2f1/0x500
[   12.604527]  process_one_work+0x5e5/0xb00
[   12.604573]  ? wq_pool_ids_show+0x1e0/0x1e0
[   12.604628]  worker_thread+0x69/0x690
[   12.604675]  ? process_one_work+0xb00/0xb00
[   12.604706]  kthread+0x1ae/0x1d0
[   12.604734]  ? kthread_create_worker_on_cpu+0xc0/0xc0
[   12.604776]  ret_from_fork+0x3a/0x50

[   12.604845] Allocated by task 68:
[   12.604872]  kasan_kmalloc+0xa0/0xd0
[   12.604900]  kmem_cache_alloc_trace+0x118/0x250
[   12.604933]  mei_cl_alloc_cb+0x3b/0xf0
[   12.604962]  __mei_cl_send+0x312/0x3e0
[   12.604991]  mei_mkhi_fix+0x12d/0x480
[   12.605020]  mei_cl_bus_dev_fixup+0x196/0x1b0
[   12.605052]  mei_cl_bus_rescan_work+0x2f1/0x500
[   12.605085]  process_one_work+0x5e5/0xb00
[   12.605116]  worker_thread+0x69/0x690
[   12.605144]  kthread+0x1ae/0x1d0
[   12.605170]  ret_from_fork+0x3a/0x50

[   12.605213] Freed by task 104:
[   12.605238]  __kasan_slab_free+0x12e/0x180
[   12.605269]  kfree+0xd4/0x250
[   12.605294]  mei_cl_complete+0xc1/0x230
[   12.605324]  mei_irq_compl_handler+0x95/0xf0
[   12.605356]  mei_me_irq_thread_handler+0x7e5/0xc90
[   12.605391]  irq_thread_fn+0x3f/0x80
[   12.605418]  irq_thread+0x175/0x250
[   12.605446]  kthread+0x1ae/0x1d0
[   12.605472]  ret_from_fork+0x3a/0x50

[   12.605515] The buggy address belongs to the object at ffff880416d3a300
                which belongs to the cache kmalloc-96 of size 96
[   12.605591] The buggy address is located 32 bytes inside of
                96-byte region [ffff880416d3a300, ffff880416d3a360)
[   12.605662] The buggy address belongs to the page:
[   12.605697] page:ffffea00105b4e80 count:1 mapcount:0
mapping:ffff8800b580f400 index:0x0
[   12.605753] flags: 0xa00000000000100(slab)
[   12.605785] raw: 0a00000000000100 dead000000000100 dead000000000200
ffff8800b580f400
[   12.605838] raw: 0000000000000000 0000000080200020 00000001ffffffff
0000000000000000
[   12.605888] page dumped because: kasan: bad access detected

[   12.605941] Memory state around the buggy address:
[   12.605976]  ffff880416d3a200: fb fb fb fb fb fb fb fb fb fb fb fb
fc fc fc fc
[   12.606024]  ffff880416d3a280: fb fb fb fb fb fb fb fb fb fb fb fb
fc fc fc fc
[   12.606073] >ffff880416d3a300: fb fb fb fb fb fb fb fb fb fb fb fb
fc fc fc fc
[   12.606121]                                ^
[   12.606152]  ffff880416d3a380: fc fc fc fc fc fc fc fc fc fc fc fc
fc fc fc fc
[   12.606201]  ffff880416d3a400: fc fc fc fc fc fc fc fc fc fc fc fc
fc fc fc fc
[   12.606249] =================================================================

thanks,
-- Shuah
