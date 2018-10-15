Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87312C7112A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 09:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40D7920853
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 09:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/8WXKOl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40D7920853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbeJORMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 13:12:08 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:40147 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbeJORMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 13:12:07 -0400
Received: by mail-yw1-f66.google.com with SMTP id l79-v6so7269661ywc.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 02:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wi9OIUwCyaGNXr9RINhtczFfxD8zJ7w3UhFjmeFiBgM=;
        b=K/8WXKOlN7aHIBzw1ueU3D6hefhJDo9Sd6mARBZmToOCgF2G7fc6vuDEAtvL76FnJi
         miLOaKbmh4l/JdT8VD+hvuCfll2aaxrLnIPBdinIC5G9eGoUA+DJFXr0LgGscrDHr/+J
         tgEIRcQQHXco41Fwrbz9fvrjN9/4986dKF1JEv1cOukEv06bSmVV1X5ojbreCEJTM7zD
         Y6/vse/xc4mqo1FmamAhbRnKXEOlo3D7OmemrWUI/3eOuKoMbB1/dlAv7VOolYgg4H8y
         yFGj+RUsX5KRMiXFRpaNBmxPvfMTVVYsOPFTcqDBb1onLXcCo9kRONQ2QJbcABqvjxmu
         gNRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wi9OIUwCyaGNXr9RINhtczFfxD8zJ7w3UhFjmeFiBgM=;
        b=XG0uS7QsaVh64t5gDyaGhBCHRtu6pqh/c4hKnkC+bX432lCGU1/j8eC6OTTGq7wBTg
         1dyI0nbuM0UcciOtFwp/kJdaiLkgQnBEK1hS+sYmUfE9+YZ9yalxn01sHSgfSbUeZIFx
         By8rocHz56nAEIRE9wTS0NF+IEkJBuMWavo1dblaWveCr3FRsa38XiDHJB8NH4FpkMok
         v9is7+l0UBYlvYiHtqD8skAXp56NnU+RdURIGBHwOGB22LLVMuaSmjIR6V8cckN3JxOv
         RGMte+8KH7Fa1iUVe+54Pv/AxOZ88S4ll3ovxstaeoUBbavedllBUif2AQ9Fd3b3TlDB
         n9YQ==
X-Gm-Message-State: ABuFfohOcrtQRnXOu4UiKy7vmKQeAmldBG0mkhAkgr30m9wHjvCM4WFH
        iVkgg8WHCtTwhphGib8SUN22BPhMsZ3XZ83EYHWWK5z1
X-Google-Smtp-Source: ACcGV60MBNhjDzYo3opM/KchljwUkZkXuMHn7fVxOT4uiCs8vrWd+TacxTEJEIy/y71ea1qoxatKA4jX4nSrVRfoFII=
X-Received: by 2002:a0d:d4c9:: with SMTP id w192-v6mr8509848ywd.211.1539595660736;
 Mon, 15 Oct 2018 02:27:40 -0700 (PDT)
MIME-Version: 1.0
References: <20180930065100.GL15893@shao2-debian> <CAOQ4uxiHkufAtt87bMs9n-0sFxJSHsBxDX6jn8v28vkvy=a_qQ@mail.gmail.com>
 <CAOQ4uxgqBgYiGpf_6zrZk=L2bAQsujzcFE0ZzUXFHu8AnHSk7g@mail.gmail.com>
 <20181001092549.GC3913@quack2.suse.cz> <20181015075101.GE28215@shao2-debian>
In-Reply-To: <20181015075101.GE28215@shao2-debian>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 15 Oct 2018 12:27:28 +0300
Message-ID: <CAOQ4uxiNfeNaB-9ZNZki-cLK4ukMpJ6YL+R1Xe6Sm34efXX3qA@mail.gmail.com>
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

On Mon, Oct 15, 2018 at 10:50 AM Rong Chen <rong.a.chen@intel.com> wrote:
[...]
> the patch seems not work.
>
> tests: 1
> testcase/path_params/tbox_group/run: will-it-scale/16-thread-unlink2-performance/lkp-bdw-ep3d
>
>  commit:
>    1e6cb72399 ("fsnotify: add super block object type")
>    298cd0b2f4 (the below patch)
>
> 1e6cb72399fd58b3  298cd0b2f481d9cc2e2cd5bfd3
> ----------------  --------------------------
>          %stddev      change         %stddev
>              \          |                \
>     103.21              -5%      98.54        will-it-scale.time.user_time
>      46266              -6%      43516        will-it-scale.time.involuntary_context_switches
>      54483              -7%      50610        will-it-scale.per_thread_ops
>     871749              -7%     809765        will-it-scale.workload

Thanks for testing my patch. As Jan commented, it is not surprising
that the patch
makes no difference.

I would like to clarify a few things about how you ran the test before
I continue to
investigate:

1. When I ran the workload I saw that it writes files to whatever filesystem is
    mounted on /tmp. Can I assume you have tmpfs mounted at /tmp?

2. Can you confirm that there is no fanotify mount mark on the /tmp mount?
    for example:
# ls -l /proc/*/fd/*|grep fanotify
lrwx------ 1 root root 64 Oct 15 08:36 /proc/3927/fd/3 -> anon_inode:[fanotify]
# grep fanotify.mnt_id /proc/3927/fdinfo/3
fanotify mnt_id:33 mflags:0 mask:3b ignored_mask:0
# grep ^$(( 0x33 )) /proc/3927/mountinfo
51 16 0:27 / /tmp rw,relatime shared:18 - tmpfs tmpfs rw

3. I saw that LKP caches the results for a specific commit
    (i.e. 1e6cb72399 ("fsnotify: add super block object type")).
Did you use cached results when comparing to patch or did you re-run the
test with the "good" commit? The reason I am asking is because
sometimes performance result may differ between boots even with no
kernel code change.
Where all the "good" bisect samples taken from the same boot/machine?
or different boots/machines?

4. If this regression is reliably reproduced, then our best bet is on the
cost of access to s_fsnotify_{marks,mask} fields.
The patch below moves those frequently accessed fields near the
frequently accessed fields s_time_gran,s_writers and moves
the seldom accessed fields s_id,s_uuid further away.
Could you please try this patch?

Thanks,
Amir.

---
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 25a449f37bb1..37c19c601979 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1393,9 +1393,6 @@ struct super_block {

        struct sb_writers       s_writers;

-       char                    s_id[32];       /* Informational name */
-       uuid_t                  s_uuid;         /* UUID */
-
        void                    *s_fs_info;     /* Filesystem private info */
        unsigned int            s_max_links;
        fmode_t                 s_mode;
@@ -1403,6 +1400,14 @@ struct super_block {
        /* Granularity of c/m/atime in ns.
           Cannot be worse than a second */
        u32                     s_time_gran;
+#ifdef CONFIG_FSNOTIFY
+       __u32                   s_fsnotify_mask;
+       struct fsnotify_mark_connector __rcu    *s_fsnotify_marks;
+#endif
+
+       /* Seldom accessed fields: */
+       char                    s_id[32];       /* Informational name */
+       uuid_t                  s_uuid;         /* UUID */

        /*
         * The next field is for VFS *only*. No filesystems have any business
@@ -1464,11 +1469,6 @@ struct super_block {

        spinlock_t              s_inode_wblist_lock;
        struct list_head        s_inodes_wb;    /* writeback inodes */
-
-#ifdef CONFIG_FSNOTIFY
-       __u32                   s_fsnotify_mask;
-       struct fsnotify_mark_connector __rcu    *s_fsnotify_marks;
-#endif
 } __randomize_layout;
