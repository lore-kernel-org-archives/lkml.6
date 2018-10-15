Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA22C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0D6620652
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWVzfYAo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0D6620652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbeJOULb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 16:11:31 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:46727 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbeJOULa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 16:11:30 -0400
Received: by mail-yw1-f68.google.com with SMTP id j202-v6so7414178ywa.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 05:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ljnGVHf28AQgQ0hQNM3X0mfai3dGA3n/W361j7a6pws=;
        b=MWVzfYAozH2hdB0l1+rgA5CByVUVtuGbh1Q1SmtA8O5/MA9xcpo4nirJr1+BYXIyDT
         R6q0LQUIh8SZa0nRqyPQHA2BQ4ZWzk1bxaug19SNGp7VPTU/5aeOwtteFC+nEEMEEL0N
         eGm4o109pFH+inTpWfeF/UegYLhSAqTQffe0hOo/lq5e90KZ0WFEKGurGuZiTGTqc5ij
         D16LY8pvSJPsrIXZn4Z3dWsgIrDz4wyrU5EuezJQsoPo3nYeCdo/aRGkgQYav64+BNdA
         L2yhKEIu/CzgS18En5KM9OEreDAgxSF3pPeJyV0UHR5L9X2yH5yQcb2zVL/Q7Pqyw3B/
         9KAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ljnGVHf28AQgQ0hQNM3X0mfai3dGA3n/W361j7a6pws=;
        b=pnKrrCw63H6V1oZ+nAS6L9Qg4Tx42rtZ6r24xH8QWhzkvsfUaM+zRc97R30CvBXsZ7
         OHQeXQtAi/2ReOajcXHkadm/+uhOZTXaIRek5Gx1ABGPMiBiEpqGxN9yWLsHa+UlU2wp
         cczpVU/vsTpq+2KtbegY80IvkW6S6fR3jshGeBnZ6vvEcEbXhwRo75WmsNRIE9mHxXpk
         VHwRSV6dPaEqfkurVwino8Dn8qmCFQ+YOiAGlF53DNhcamnsZ/PKiz+1LlgwaRUXAJW0
         THFK40XkrCrTgkjJRg/tnJdmL2hlnkjWBr8PArCElh/ZnXeQIYzu9u3+LzryW5IbuVlX
         X/eA==
X-Gm-Message-State: ABuFfogq6rlW+rxJXBlfcjXAW8UWd/8yx1Arjht7tezUHnVM2weQZRpd
        6GMG5rIUIZfeX+4iBjIKe2zMJXLogrtU9OekhOk=
X-Google-Smtp-Source: ACcGV63DulF35ZnVNf1bQfi4uuk4v3eZ7L8G+R/ahvsptpN4zrpTdPUt2mfMbWdxlTVrAnXFx+jANTrsa0ddfue2BWU=
X-Received: by 2002:a0d:c947:: with SMTP id l68-v6mr9186309ywd.404.1539606384966;
 Mon, 15 Oct 2018 05:26:24 -0700 (PDT)
MIME-Version: 1.0
References: <20180930065100.GL15893@shao2-debian> <CAOQ4uxiHkufAtt87bMs9n-0sFxJSHsBxDX6jn8v28vkvy=a_qQ@mail.gmail.com>
 <CAOQ4uxgqBgYiGpf_6zrZk=L2bAQsujzcFE0ZzUXFHu8AnHSk7g@mail.gmail.com>
 <20181001092549.GC3913@quack2.suse.cz> <20181015075101.GE28215@shao2-debian> <CAOQ4uxiNfeNaB-9ZNZki-cLK4ukMpJ6YL+R1Xe6Sm34efXX3qA@mail.gmail.com>
In-Reply-To: <CAOQ4uxiNfeNaB-9ZNZki-cLK4ukMpJ6YL+R1Xe6Sm34efXX3qA@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 15 Oct 2018 15:26:13 +0300
Message-ID: <CAOQ4uxi-xfukNt0dHMrjokcXJ9keeaD9Xx9Q4DHRv_SH_YcQXQ@mail.gmail.com>
Subject: Re: [LKP] [fsnotify] 60f7ed8c7c: will-it-scale.per_thread_ops -5.9% regression
To:     rong.a.chen@intel.com
Cc:     Jan Kara <jack@suse.cz>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, LKP <lkp@01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 12:27 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Mon, Oct 15, 2018 at 10:50 AM Rong Chen <rong.a.chen@intel.com> wrote:
> [...]
> > the patch seems not work.
> >
> > tests: 1
> > testcase/path_params/tbox_group/run: will-it-scale/16-thread-unlink2-performance/lkp-bdw-ep3d
> >
> >  commit:
> >    1e6cb72399 ("fsnotify: add super block object type")
> >    298cd0b2f4 (the below patch)
> >
> > 1e6cb72399fd58b3  298cd0b2f481d9cc2e2cd5bfd3
> > ----------------  --------------------------
> >          %stddev      change         %stddev
> >              \          |                \
> >     103.21              -5%      98.54        will-it-scale.time.user_time
> >      46266              -6%      43516        will-it-scale.time.involuntary_context_switches
> >      54483              -7%      50610        will-it-scale.per_thread_ops
> >     871749              -7%     809765        will-it-scale.workload
>
> Thanks for testing my patch. As Jan commented, it is not surprising
> that the patch
> makes no difference.
>
> I would like to clarify a few things about how you ran the test before
> I continue to
> investigate:
>
> 1. When I ran the workload I saw that it writes files to whatever filesystem is
>     mounted on /tmp. Can I assume you have tmpfs mounted at /tmp?
>
> 2. Can you confirm that there is no fanotify mount mark on the /tmp mount?
>     for example:
> # ls -l /proc/*/fd/*|grep fanotify
> lrwx------ 1 root root 64 Oct 15 08:36 /proc/3927/fd/3 -> anon_inode:[fanotify]
> # grep fanotify.mnt_id /proc/3927/fdinfo/3
> fanotify mnt_id:33 mflags:0 mask:3b ignored_mask:0
> # grep ^$(( 0x33 )) /proc/3927/mountinfo
> 51 16 0:27 / /tmp rw,relatime shared:18 - tmpfs tmpfs rw
>
> 3. I saw that LKP caches the results for a specific commit
>     (i.e. 1e6cb72399 ("fsnotify: add super block object type")).
> Did you use cached results when comparing to patch or did you re-run the
> test with the "good" commit? The reason I am asking is because
> sometimes performance result may differ between boots even with no
> kernel code change.
> Where all the "good" bisect samples taken from the same boot/machine?
> or different boots/machines?
>
> 4. If this regression is reliably reproduced, then our best bet is on the
> cost of access to s_fsnotify_{marks,mask} fields.
> The patch below moves those frequently accessed fields near the
> frequently accessed fields s_time_gran,s_writers and moves
> the seldom accessed fields s_id,s_uuid further away.
> Could you please try this patch?
>

Better test this patch instead. It does a bit more re-organizing.
If this works well for 16-thread-unlink2 workload, could you please
also run it through other workloads to see if it improves them as well?
and does not degrade them...

Thanks,
Amir.

---
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 25a449f37bb1..baec0b3ff53f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1393,17 +1393,24 @@ struct super_block {

        struct sb_writers       s_writers;

+       /* START frequently accessed fields block */
+       void                    *s_fs_info;     /* Filesystem private info */
+
+       /* Granularity of c/m/atime in ns (cannot be worse than a second) */
+       u32                     s_time_gran;
+#ifdef CONFIG_FSNOTIFY
+       __u32                   s_fsnotify_mask;
+       struct fsnotify_mark_connector __rcu    *s_fsnotify_marks;
+#endif
+       /* END frequently accessed fields block */
+
+       /* START seldom accessed fields block */
        char                    s_id[32];       /* Informational name */
        uuid_t                  s_uuid;         /* UUID */

-       void                    *s_fs_info;     /* Filesystem private info */
        unsigned int            s_max_links;
        fmode_t                 s_mode;

-       /* Granularity of c/m/atime in ns.
-          Cannot be worse than a second */
-       u32                s_time_gran;
-
        /*
         * The next field is for VFS *only*. No filesystems have any business
         * even looking at it. You had been warned.
@@ -1415,6 +1422,7 @@ struct super_block {
         * in /proc/mounts will be "type.subtype"
         */
        char *s_subtype;
+       /* END seldom accessed fields block */

        const struct dentry_operations *s_d_op; /* default d_op for dentries */

@@ -1464,11 +1472,6 @@ struct super_block {

        spinlock_t              s_inode_wblist_lock;
        struct list_head        s_inodes_wb;    /* writeback inodes */
-
-#ifdef CONFIG_FSNOTIFY
-       __u32                   s_fsnotify_mask;
-       struct fsnotify_mark_connector __rcu    *s_fsnotify_marks;
-#endif
 } __randomize_layout;
