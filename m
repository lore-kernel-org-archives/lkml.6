Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id MkucN9qcHlslHAAAmS7hNA
	; Mon, 11 Jun 2018 16:01:41 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id F365160792; Mon, 11 Jun 2018 16:01:40 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iplxrWb7"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 7CBEC600D0;
	Mon, 11 Jun 2018 16:01:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7CBEC600D0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932955AbeFKQBi (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 12:01:38 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:34679 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932081AbeFKQBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 12:01:35 -0400
Received: by mail-yw0-f194.google.com with SMTP id b125-v6so6484559ywe.1;
        Mon, 11 Jun 2018 09:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Rlri0GKZYcmCw/li7NYbHLv0eaeCwr60QWPZWnB/E9w=;
        b=iplxrWb722k1iceLVIB9mVcPXxtYIBYNeBWfDr6aVS+v9yv05ZkhrI4WVexHFyYALm
         brcpHQx+m2PzDUsoUCtC6VdqGxENTgNo07tlV2OpeeUGUXBEubzTKHPB61RA0AEpEFtB
         Deh6rF1X95MgOsqsCDfyz/Jwq8Q7/Dg6G/WABmsc/QwrQFrXLXr2UrccHSsbLZRoTaoH
         3zjBkWN35WUAtdSa3zmBechD1su5+f+IUv+vmBHt6psQBs7l0m5iWR8yPLQa0z+FGJ+O
         TjwL/ekdqlXJARSe1gkUDY8+tMrCnKDLf43crn++/9SINUjTbnWKPtxDCbgcj9zikV1b
         gVCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Rlri0GKZYcmCw/li7NYbHLv0eaeCwr60QWPZWnB/E9w=;
        b=E2Sv7enR9Oxp+3mjqU986RnquU9mclb0/L1LKEBpQF7Dn7tC3iGPN6z8hdftbY5ci2
         mA1ccacYf6Z4JusIbIZviMxqgmatgyDx7q2HLSKwqgyHPT9bZgybPAwuHqEru5Y5WWo7
         FEjcSSVaHaklCrWR/f/4HtaHS5cKJ2hlqWe7iN638Gw4Dy7+PQVqqINLlCGl+G/pIjur
         cQjIH5pJCyZfj3WWFtUx4wbzq+Id9//ybs8h6VIodP3VXZ9dWBkuEq1AN9nPsEplHQ79
         w0PotAZq0C076ehVBYjPR+4Zc+0ikYQQ3yyuNwxeF8O5ACXFdFVm/uYcdEElXh+mL9Kh
         edTA==
X-Gm-Message-State: APt69E0zvvIhd+b9KktOHgrmcP/n5Fop4JelLs9rXyQDOlyXEbFr0ZQ8
        /GA9dbFeKQz9q7ggwCr6QGY=
X-Google-Smtp-Source: ADUXVKKqITdj8YzbeZC2uXrQnh9yGMGRd0eBARhIwYvbv/ru/sYlFPGl8gPIuA1l3nEorGHD2s4ARQ==
X-Received: by 2002:a81:3d14:: with SMTP id k20-v6mr9277884ywa.356.1528732894116;
        Mon, 11 Jun 2018 09:01:34 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::3:5c3])
        by smtp.gmail.com with ESMTPSA id u17-v6sm14593362ywu.16.2018.06.11.09.01.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 09:01:32 -0700 (PDT)
Date: Mon, 11 Jun 2018 09:01:31 -0700
From: Tejun Heo <tj@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jens Axboe <axboe@kernel.dk>,
        syzbot <syzbot+4a7438e774b21ddd8eca@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dave Chinner <david@fromorbit.com>,
        linux-block@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] bdi: Fix another oops in wb_workfn()
Message-ID: <20180611160131.GQ1351649@devbig577.frc2.facebook.com>
References: <95865cab-e12f-d45b-b6e3-465b624862ba@i-love.sakura.ne.jp>
 <CACT4Y+byRRtCA9B9bPG9mjrf3UY3OsGeBsoh8dZ0T+V6tKpTHg@mail.gmail.com>
 <201806080231.w582VIRn021009@www262.sakura.ne.jp>
 <CACT4Y+Y7Mj1JngLst1aRHDhURXQMn-eTjyPFjDdGAT0ZV-dHrw@mail.gmail.com>
 <CACT4Y+bBfwpcP2h0URpqwiNMQ5SFJdPDHThUu2xetmrxgC+3BQ@mail.gmail.com>
 <CACT4Y+bHDWDapwOonO1EpR6TiRa=qf9nSDtHArq75yCGuHf=gg@mail.gmail.com>
 <CACT4Y+Z4i=bD49cb4pJ5zOMxVu675NT8wCNk+c2n2XJVOXG2bg@mail.gmail.com>
 <2b437c6f-3e10-3d83-bdf3-82075d3eaa1a@i-love.sakura.ne.jp>
 <3cf4b0e3-31b6-8cdc-7c1e-15ba575a7879@i-love.sakura.ne.jp>
 <20180611091248.2i6nt27h5mxrodm2@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180611091248.2i6nt27h5mxrodm2@quack2.suse.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Jun 11, 2018 at 11:12:48AM +0200, Jan Kara wrote:
> However this is wrong and so is the patch. The problem is in
> cgwb_bdi_unregister() which does cgwb_kill() and thus drops bdi's
> reference to wb structures before going through the list of wbs again and
> calling wb_shutdown() on each of them. The writeback structures we are
> accessing at this point can be already freed in principle like:
> 
> CPU1				CPU2
> 				cgwb_bdi_unregister()
> 				  cgwb_kill(*slot);
> 
> cgwb_release()
>   queue_work(cgwb_release_wq, &wb->release_work);
> cgwb_release_workfn()
> 				  wb = list_first_entry(&bdi->wb_list, ...)
> 				  spin_unlock_irq(&cgwb_lock);
>   wb_shutdown(wb);
>   ...				
>   kfree_rcu(wb, rcu);
> 				  wb_shutdown(wb); -> oops use-after-free
> 
> I'm not 100% sure how to fix this. wb structures can be at various phases of
> shutdown (or there may be other external references still existing) when we
> enter cgwb_bdi_unregister() so I think adding a way for cgwb_bdi_unregister()
> to wait for standard wb shutdown path to finish is the most robust way.
> What do you think about attached patch Tejun? So far only compile tested...
> 
> Possible problem with it is that now cgwb_bdi_unregister() will wait for
> all wb references to be dropped so it adds some implicit dependencies to
> bdi shutdown path. 

Would something like the following work or am I missing the point
entirely?

Thanks.

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 347cc83..359cacd 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -715,14 +715,19 @@ static void cgwb_bdi_unregister(struct backing_dev_info *bdi)
 	WARN_ON(test_bit(WB_registered, &bdi->wb.state));
 
 	spin_lock_irq(&cgwb_lock);
-	radix_tree_for_each_slot(slot, &bdi->cgwb_tree, &iter, 0)
-		cgwb_kill(*slot);
+	radix_tree_for_each_slot(slot, &bdi->cgwb_tree, &iter, 0) {
+		struct bdi_writeback *wb = *slot;
+
+		wb_get(wb);
+		cgwb_kill(wb);
+	}
 
 	while (!list_empty(&bdi->wb_list)) {
 		wb = list_first_entry(&bdi->wb_list, struct bdi_writeback,
 				      bdi_node);
 		spin_unlock_irq(&cgwb_lock);
 		wb_shutdown(wb);
+		wb_put(wb);
 		spin_lock_irq(&cgwb_lock);
 	}
 	spin_unlock_irq(&cgwb_lock);


-- 
tejun
