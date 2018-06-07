Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id hwdMBuNRGVuwEwAAmS7hNA
	; Thu, 07 Jun 2018 15:41:20 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A7B42608B8; Thu,  7 Jun 2018 15:41:20 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="c4993oq6"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_MED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 0B5EA6074D;
	Thu,  7 Jun 2018 15:41:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0B5EA6074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934750AbeFGPlR (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:41:17 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:44707 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933177AbeFGPlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 11:41:14 -0400
Received: by mail-io0-f193.google.com with SMTP id g7-v6so12321456ioh.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 08:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AKOxTbN/SkW7Osg14gDyM5YoIrNS6XZTKZMg91k8ILY=;
        b=c4993oq6PFD6Gq1c/MS0tjkuQDD4kvVPH+Q4NddNHsLIWWxJmPJdKtYxF2L6adqP4m
         Qax7wxbOk2aPKXZVM+3BDP4Byf5/JPXIOXVJVCDCGgmJk5C9/S2hkjktYEmGr8YTRKLX
         19xLjrsPZPiXCpbLm9GDXeE4PLqKXRN3zi+HNfB2N/fV1j9l7gAzmuqDUdnTTwEwZ7a5
         XDLmNr4RZiUuCWIkq863QMg8Ttp1OeRzFAw85a9T8k5/BFIi+yl2YbrOTpyrkuS//dCI
         jTX5WIdJ1vhe2iKLuuESjEt1uf56RWkNAIPOj6tx69c5p2iyVDWC8qJGsYmyi2mfDKUK
         nkYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AKOxTbN/SkW7Osg14gDyM5YoIrNS6XZTKZMg91k8ILY=;
        b=d+3RPBaUJDzyIieRdKCDysKdkyPKhuHiNZLVbGaIs6KLpH7I0jskxyCF09C/5a6Be1
         W8BZ1q5emgI9IadIZDwCAo/uNvD4p7QteQ6EcsLlcJpgJPquwOxI2qgRWh8FrMV5/zTJ
         7UNvOfg2RB7FZtS0Qh8YP6vJFbjr+Whmo8OXksZhqmEzE3d2G6PPMwuHXrLPW4MGhg2l
         QmzrjAuGTt2vq/FIoZZGcFjmnvHk8YyYSUkxoHfTh/xTxoDKlnb4v1fC0QrBJqwLwDp8
         sVx1FHxw5xy8Ec3+bpEsIGCDqdxDkQSMUt1fepAxaZRWYGwoscuMRFXHOrY3JUag6tRG
         aaxQ==
X-Gm-Message-State: APt69E2CbkCUg+3lzGnAHiSabb+k98uti2R69zFehLzb1O7fR9B0EqO8
        l8rKYtIT98RjmXupGIVAS9QBCKqhbtU=
X-Google-Smtp-Source: ADUXVKIgpIWXJRqfnrz2Hac8LvMaQr4t3S3PnQ35dkEEOucLaJTxUhiEGJpXi6DeVO0/PAhbMNIg5A==
X-Received: by 2002:a6b:8f84:: with SMTP id r126-v6mr2017940iod.233.1528386073260;
        Thu, 07 Jun 2018 08:41:13 -0700 (PDT)
Received: from [192.168.1.167] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id k8-v6sm7825590ioj.55.2018.06.07.08.41.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 08:41:12 -0700 (PDT)
Subject: Re: Block IO issue in kernel-v4.17
From: Jens Axboe <axboe@kernel.dk>
To: Chunyu Hu <chuhu.ncepu@gmail.com>
Cc: Kent Overstreet <kent.overstreet@gmail.com>,
        Li Wang <liwang@redhat.com>, Coly Li <colyli@suse.de>,
        hch@lst.de, darrick.wong@oracle.com, snitzer@redhat.com,
        linux-block@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <CAEemH2fbPv2wphVBHxSSS+KEK5S-rercXhvgLJ7YMOZnrTpexg@mail.gmail.com>
 <20180606084105.GA10720@kmo-pixel>
 <015f6160-216a-31ba-e251-11336e7ff5d6@kernel.dk>
 <CABATaM7FHcXF7rO5kuMVFRFKFqhqnkoJ_t4w-y4=mNx42=b3Cg@mail.gmail.com>
 <39e797fa-b24c-d122-c06b-196ba2a2d395@kernel.dk>
Message-ID: <75ca49d6-0a09-20d5-20c9-dac77604fdd4@kernel.dk>
Date: Thu, 7 Jun 2018 09:41:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <39e797fa-b24c-d122-c06b-196ba2a2d395@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/18 8:46 AM, Jens Axboe wrote:
> On 6/7/18 12:33 AM, Chunyu Hu wrote:
>> kasan reported a user-after-free. I'm using a kvm machine, it panic
>> during boot. I'm using the latest linux tree. which contains below.
>>
>> commit d377535405686f735b90a8ad4ba269484cd7c96e
>> Author: Kent Overstreet <kent.overstreet@gmail.com>
>> Date:   Tue Jun 5 05:26:33 2018 -0400
>>
>>     dm: Use kzalloc for all structs with embedded biosets/mempools
> 
> Can you try with the below? Li Wang, would be great if you could too.

Please try this one instead.
 

diff --git a/block/bio.c b/block/bio.c
index 595663e0281a..0616d86b15c6 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1967,6 +1967,21 @@ int bioset_init(struct bio_set *bs,
 }
 EXPORT_SYMBOL(bioset_init);
 
+int bioset_init_from_src(struct bio_set *new, struct bio_set *src)
+{
+	unsigned int pool_size = src->bio_pool.min_nr;
+	int flags;
+
+	flags = 0;
+	if (src->bvec_pool.min_nr)
+		flags |= BIOSET_NEED_BVECS;
+	if (src->rescue_workqueue)
+		flags |= BIOSET_NEED_RESCUER;
+
+	return bioset_init(new, pool_size, src->front_pad, flags);
+}
+EXPORT_SYMBOL(bioset_init_from_src);
+
 #ifdef CONFIG_BLK_CGROUP
 
 /**
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 98dff36b89a3..20a8d63754bf 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1953,9 +1953,10 @@ static void free_dev(struct mapped_device *md)
 	kvfree(md);
 }
 
-static void __bind_mempools(struct mapped_device *md, struct dm_table *t)
+static int __bind_mempools(struct mapped_device *md, struct dm_table *t)
 {
 	struct dm_md_mempools *p = dm_table_get_md_mempools(t);
+	int ret = 0;
 
 	if (dm_table_bio_based(t)) {
 		/*
@@ -1982,13 +1983,16 @@ static void __bind_mempools(struct mapped_device *md, struct dm_table *t)
 	       bioset_initialized(&md->bs) ||
 	       bioset_initialized(&md->io_bs));
 
-	md->bs = p->bs;
-	memset(&p->bs, 0, sizeof(p->bs));
-	md->io_bs = p->io_bs;
-	memset(&p->io_bs, 0, sizeof(p->io_bs));
+	ret = bioset_init_from_src(&md->bs, &p->bs);
+	if (ret)
+		goto out;
+	ret = bioset_init_from_src(&md->io_bs, &p->io_bs);
+	if (ret)
+		bioset_exit(&md->bs);
 out:
 	/* mempool bind completed, no longer need any mempools in the table */
 	dm_table_free_md_mempools(t);
+	return ret;
 }
 
 /*
@@ -2033,6 +2037,7 @@ static struct dm_table *__bind(struct mapped_device *md, struct dm_table *t,
 	struct request_queue *q = md->queue;
 	bool request_based = dm_table_request_based(t);
 	sector_t size;
+	int ret;
 
 	lockdep_assert_held(&md->suspend_lock);
 
@@ -2068,7 +2073,11 @@ static struct dm_table *__bind(struct mapped_device *md, struct dm_table *t,
 		md->immutable_target = dm_table_get_immutable_target(t);
 	}
 
-	__bind_mempools(md, t);
+	ret = __bind_mempools(md, t);
+	if (ret) {
+		old_map = ERR_PTR(ret);
+		goto out;
+	}
 
 	old_map = rcu_dereference_protected(md->map, lockdep_is_held(&md->suspend_lock));
 	rcu_assign_pointer(md->map, (void *)t);
@@ -2078,6 +2087,7 @@ static struct dm_table *__bind(struct mapped_device *md, struct dm_table *t,
 	if (old_map)
 		dm_sync_table(md);
 
+out:
 	return old_map;
 }
 
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 810a8bee8f85..307682ac2f31 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -417,6 +417,7 @@ enum {
 extern int bioset_init(struct bio_set *, unsigned int, unsigned int, int flags);
 extern void bioset_exit(struct bio_set *);
 extern int biovec_init_pool(mempool_t *pool, int pool_entries);
+extern int bioset_init_from_src(struct bio_set *new, struct bio_set *src);
 
 extern struct bio *bio_alloc_bioset(gfp_t, unsigned int, struct bio_set *);
 extern void bio_put(struct bio *);

-- 
Jens Axboe
