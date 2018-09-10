Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B304C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2D24204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="deGHDywP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2D24204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbeIJOL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 10:11:27 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:36179 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbeIJOL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 10:11:27 -0400
Received: by mail-ua1-f65.google.com with SMTP id c12-v6so16746652uan.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 02:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=FuMqfpnvLhxKCKWSq2fBZtPk/7CMI83/kLbbSbOaVqI=;
        b=deGHDywPwbqwrMC/fY5weYL3xmvCRJq4v/E0QnAttkr2SlHbktSJnzc3BkjPtlvFjL
         NqxUK8ZDQyuE2lr6VKx6/IWPUjtS2O+1gqFsT2LVutA3MQlgIQYr2M1HcKqFrxB2yAqT
         HgN90fPFbVNxAG0I6v+d8Z0TcQGogoUiSHTc/di4t2P5RtSBU8WvqU07iz7Uq/GKN42m
         lrt4icucHskky4LL5h4XesJ8vrMw4P4ROGAuMwxsnRFpPht5iZs7grV19a5GTvWJKf71
         u0jm5XVZkGgG9pVhS3Ji/FMTNizEKhoY8PuLv+RySp87zocLWph7mCyJiV654oYuRc9s
         6NFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=FuMqfpnvLhxKCKWSq2fBZtPk/7CMI83/kLbbSbOaVqI=;
        b=QZ+COyNpYY2g/T41VTQmSTpTw2l9P9um3xDA04UEaFunQ9QirnYy4n7+pknk4v7Xql
         YacZ18xQ+H9LKCqyY1DlJrgntJo3WWSHOMUOyOTrJimtxOIZa1AqhFOwQbYYvUjnEFWn
         wgUlQd8lVa6jJfViBInvZ3Swb4DYwBK+JKXEp0oPohPdJSeNcikRHFWGcXwy+5c6tSwa
         HUUPel8Uby4Rpd8TFLRB/IYO9xK9eMku6tXcr3fIsezhXCS5minQsEfm2ql4PY+n/BIT
         Wq/EFrbw+rYRNwt5spfrjAG7yDOEFsodJ+XZeS6GB7G4/rWFCNgeYLNedhf6AoqRJkrQ
         iTag==
X-Gm-Message-State: APzg51BS2OvKH4m1H5NGwFwEOhz4f0q6Q7NcB1KuXDiukZ7yOUxSmkol
        wUiNbrjd97+zQSJsho8dgAHmx/MeM1bmGdfYvEtW+Gp16Og=
X-Google-Smtp-Source: ANB0VdYMNwpXNiLOVIU5RCzngFa8Gxr/HPEecTLiO55RsOoQDGnhy1UJ5d58Q6kTBYzQB/Rb5oLF2050pzPoHDJlHf8=
X-Received: by 2002:a67:e907:: with SMTP id c7-v6mr6388999vso.88.1536571101298;
 Mon, 10 Sep 2018 02:18:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAKYFi-4a=H+vT+vo5s6mpKXAv+0W0pyTj1WtEr6xfjoFVFmtJQ@mail.gmail.com>
In-Reply-To: <CAKYFi-4a=H+vT+vo5s6mpKXAv+0W0pyTj1WtEr6xfjoFVFmtJQ@mail.gmail.com>
From:   Marcus Linsner <constantoverride@gmail.com>
Date:   Mon, 10 Sep 2018 11:17:42 +0200
Message-ID: <CAKYFi-7H66SvwxpbZLSXankOTQ9LfCyUnL5_+hA6tpJYkJOZ8A@mail.gmail.com>
Subject: Re: Howto prevent kernel from evicting code pages ever? (to avoid
 disk thrashing when about to run out of RAM)
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 11:25 AM Marcus Linsner
<constantoverride@gmail.com> wrote:
>
> Hi. How to make the kernel keep(lock?) all code pages in RAM so that
> kswapd0 won't evict them when the system is under low memory
> conditions ?
>
> The purpose of this is to prevent the kernel from causing lots of disk
> reads(effectively freezing the whole system) when about to run out of
> RAM, even when there is no swap enabled, but well before(in real time
> minutes) OOM-killer triggers to kill the offending process (eg. ld)!
>
> I can replicate this consistently with 4G (and 12G) max RAM inside a
> Qubes OS R4.0 AppVM running Fedora 28 while trying to compile Firefox.
> The disk thrashing (continuous 192+MiB/sec reads) occurs well before
> the OOM-killer triggers to kill 'ld' (or 'rustc') process and
> everything is frozen for (real time) minutes. I've also encountered
> this on bare metal myself, if it matters at all.
>
> I tried to ask this question on SO here:
> https://stackoverflow.com/q/51927528/10239615
> but maybe I have better luck on this mailing list where the kernel experts are.
>

This is what I got working so far, to prevent the disk thrashing
(constant re-reading of active executable pages from disk) that would
otherwise freeze the OS before running Out Of Memory:

the following patch can also be seen here:
https://github.com/constantoverride/qubes-linux-kernel/blob/devel-4.18/patches.addon/le9d.patch

revision 3
preliminary patch to avoid disk thrashing (constant reading) under
memory pressure before OOM-killer triggers
more info: https://gist.github.com/constantoverride/84eba764f487049ed642eb2111a20830

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 32699b2..7636498 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -208,7 +208,7 @@ enum lru_list {

 #define for_each_lru(lru) for (lru = 0; lru < NR_LRU_LISTS; lru++)

-#define for_each_evictable_lru(lru) for (lru = 0; lru <=
LRU_ACTIVE_FILE; lru++)
+#define for_each_evictable_lru(lru) for (lru = 0; lru <=
LRU_INACTIVE_FILE; lru++)

 static inline int is_file_lru(enum lru_list lru)
 {
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 03822f8..1f3ffb5 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2086,9 +2086,9 @@ static unsigned long shrink_list(enum lr
                  struct scan_control *sc)
 {
     if (is_active_lru(lru)) {
-        if (inactive_list_is_low(lruvec, is_file_lru(lru),
-                     memcg, sc, true))
-            shrink_active_list(nr_to_scan, lruvec, sc, lru);
+        //if (inactive_list_is_low(lruvec, is_file_lru(lru),
+        //             memcg, sc, true))
+        //    shrink_active_list(nr_to_scan, lruvec, sc, lru);
         return 0;
     }

@@ -2234,7 +2234,7 @@ static void get_scan_count(struct lruvec
*lruvec, struct mem_cgroup *memcg,

     anon  = lruvec_lru_size(lruvec, LRU_ACTIVE_ANON, MAX_NR_ZONES) +
         lruvec_lru_size(lruvec, LRU_INACTIVE_ANON, MAX_NR_ZONES);
-    file  = lruvec_lru_size(lruvec, LRU_ACTIVE_FILE, MAX_NR_ZONES) +
+    file  = //lruvec_lru_size(lruvec, LRU_ACTIVE_FILE, MAX_NR_ZONES) +
         lruvec_lru_size(lruvec, LRU_INACTIVE_FILE, MAX_NR_ZONES);

     spin_lock_irq(&pgdat->lru_lock);
@@ -2345,7 +2345,7 @@ static void shrink_node_memcg(struct pglist_data
*pgdat, struct mem_cgroup *memc
              sc->priority == DEF_PRIORITY);

     blk_start_plug(&plug);
-    while (nr[LRU_INACTIVE_ANON] || nr[LRU_ACTIVE_FILE] ||
+    while (nr[LRU_INACTIVE_ANON] || //nr[LRU_ACTIVE_FILE] ||
                     nr[LRU_INACTIVE_FILE]) {
         unsigned long nr_anon, nr_file, percentage;
         unsigned long nr_scanned;
@@ -2372,7 +2372,8 @@ static void shrink_node_memcg(struct pglist_data
*pgdat, struct mem_cgroup *memc
          * stop reclaiming one LRU and reduce the amount scanning
          * proportional to the original scan target.
          */
-        nr_file = nr[LRU_INACTIVE_FILE] + nr[LRU_ACTIVE_FILE];
+        nr_file = nr[LRU_INACTIVE_FILE] //+ nr[LRU_ACTIVE_FILE]
+            ;
         nr_anon = nr[LRU_INACTIVE_ANON] + nr[LRU_ACTIVE_ANON];

         /*
@@ -2391,7 +2392,8 @@ static void shrink_node_memcg(struct pglist_data
*pgdat, struct mem_cgroup *memc
             percentage = nr_anon * 100 / scan_target;
         } else {
             unsigned long scan_target = targets[LRU_INACTIVE_FILE] +
-                        targets[LRU_ACTIVE_FILE] + 1;
+                        //targets[LRU_ACTIVE_FILE] +
+                        1;
             lru = LRU_FILE;
             percentage = nr_file * 100 / scan_target;
         }
@@ -2409,10 +2411,12 @@ static void shrink_node_memcg(struct pgl
         nr[lru] = targets[lru] * (100 - percentage) / 100;
         nr[lru] -= min(nr[lru], nr_scanned);

+        if (LRU_FILE != lru) { //avoid this block for LRU_ACTIVE_FILE
         lru += LRU_ACTIVE;
         nr_scanned = targets[lru] - nr[lru];
         nr[lru] = targets[lru] * (100 - percentage) / 100;
         nr[lru] -= min(nr[lru], nr_scanned);
+        }

         scan_adjusted = true;
}


Tested on kernel 4.18.5 under Qubes OS, in both dom0 and VMs. It gets
rid of the disk thrashing that would otherwise seemingly-permanently
freeze a qube (VM) with continous disk reading (seen from dom0 via
sudo iotop). With the above, it only freezes for at most 1 second
before OOM-killer triggers and restores the RAM by killing some
process.

If anyone has a better idea, please let me know. I am hoping someone
knowledgeable can step in :)

I tried to find a way to also keep Inactive file pages in RAM, just
for tests(!) but couldn't figure out how (I'm not a programmer).
So, keeping just the Active file pages, seem good enough for now, even
though I can clearly see (via vm.block_dump=1) that there are still
some pages that are being re-read during high memory pressure, but
they for some reason don't cause any(or much) disk thrashing.

Cheers!
