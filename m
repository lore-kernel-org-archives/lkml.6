Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9432AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FEE9214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="cY9TbJQb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FEE9214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389089AbeKVGpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 01:45:22 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55142 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbeKVGpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 01:45:21 -0500
Received: by mail-wm1-f65.google.com with SMTP id r63-v6so6802506wma.4;
        Wed, 21 Nov 2018 12:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Y8d3yGnK1MstfmgGfMiRbo8OlHwuukqT7oNx5bxI1Z8=;
        b=cY9TbJQb31dT7+PiQq9jRj5wxsaGsFFkhqgiWHeHTc0YKjZtxPv4EYKAvL8gbxrOgJ
         rlJN74ZjlFeBJhSJ+jiqxxEOH/cp8rHeWZqtXZeLfaG6zZPiBKWP80KxWgTVfuGqE7dA
         cjhHBB1essERYpUHnpT651I2yk86E8I1jo+OcolGCsu5e1A9RxiS8QgmXSZyN13tUzxV
         YsubgvnwnpkiC0BX5eqTuSMa90o+TZ860PIK/JbTI7cYw44oo6lsHeid10qImXnsALq9
         Pgw2wttlMSmb+wRGeKQQYomicqkOa/QMGfAkq7+6TAqsGKZdIkaFeIIUgwdiHXWIlkM0
         N5rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y8d3yGnK1MstfmgGfMiRbo8OlHwuukqT7oNx5bxI1Z8=;
        b=cijnCe7nnuS+xDJd82JUF73+ZlY9eQ1lgPuKnIFIZrmqufMo5kcynQikhQIe2858NB
         g0q3s/ktNIwVSg5m9R/7TzrhBqiFuwUxnliWFt3WxuBTvQQQHkLX1VQoq3n32UCE05uB
         THBapIEAdTl5ynMKs/gVdliSksTT9WAZDfvkXLbJDbt1RSvnyW503LFPvuL5MOTDGt8C
         QC0FpfBYSoIukbIew10KOyq/zMV0JqaYF01Y0dyKhflhTMyCERXJkzwwfe/zWcxWHDbZ
         A9a5+0emDg0KGoHWe2TyHgDOqdELZdlKQ5ntoQhS5LVntGTA3pde3EdxV4QTuboAvCQa
         lpTQ==
X-Gm-Message-State: AGRZ1gKZzDd9k4zbg0/Y2v16eddyRLRRuF7ghTw1VhfoRh8EWObCEv8v
        HcIy6t7KHiKOgx5z8wsUic5TOxCh
X-Google-Smtp-Source: AJdET5cFQ2vVCYZJiUHg/Kz9tSFam6OA/vke7ao12/8pdOUL/OyK2TcMudbQwS321HaCQHhmvLKCGg==
X-Received: by 2002:a1c:bc82:: with SMTP id m124-v6mr6875803wmf.47.1542830973531;
        Wed, 21 Nov 2018 12:09:33 -0800 (PST)
Received: from jig.fritz.box (p2003005F6E03DA00453B38B3AA0188E8.dip0.t-ipconnect.de. [2003:5f:6e03:da00:453b:38b3:aa01:88e8])
        by smtp.gmail.com with ESMTPSA id v189-v6sm2370855wmd.40.2018.11.21.12.09.31
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 21 Nov 2018 12:09:32 -0800 (PST)
Date:   Wed, 21 Nov 2018 21:09:23 +0100
From:   Mathias Krause <minipli@googlemail.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Steffen Klassert <steffen.klassert@secunet.com>
Cc:     Pan Bian <bianpan2016@163.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Pan Bian <bianpan2013@163.com>,
        minipli@googlemail.com
Subject: Re: [net] xfrm_user: use xfrm_state_put to free xfrm_state_alloc
 return value
Message-ID: <20181121200923.GA12460@jig.fritz.box>
References: <1542783468-67482-1-git-send-email-bianpan2016@163.com>
 <20181121080045.4vtozqc6eyeyis2n@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181121080045.4vtozqc6eyeyis2n@gondor.apana.org.au>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 04:00:45PM +0800, Herbert Xu wrote:
> On Wed, Nov 21, 2018 at 02:57:48PM +0800, Pan Bian wrote:
> > From: Pan Bian <bianpan2013@163.com>
> > 
> > The memory chunk allocated by xfrm_state_alloc() should be released with
> > xfrm_state_put(), not kfree.
> > 
> > Signed-off-by: Pan Bian <bianpan2013@163.com>
> 
> This bug was introduced by
> 
> 	commit 565f0fa902b64020d5d147ff1708567e9e0b6e49
> 	Author: Mathias Krause <minipli@googlemail.com>
> 	Date:   Thu May 3 10:55:07 2018 +0200
> 

Oh, snap. You're totally right. I missed the kfree() in xfrm_user.c.
Sorry for that!

> While using xfrm_state_put may work it's certainly not the designed
> to do this.  We should instead export a function that calls
> kmem_cache_free on xfrm_state directly and use that here.

Maybe something like the below patch? Steffen?

-- >8 --

Subject: [PATCH] xfrm_user: fix freeing of xfrm states on acquire

Commit 565f0fa902b6 ("xfrm: use a dedicated slab cache for struct
xfrm_state") moved xfrm state objects to use their own slab cache.
However, it missed to adapt xfrm_user to use this new cache when
freeing xfrm states.

Fix this by introducing and make use of a new helper for freeing
xfrm_state objects.

Fixes: 565f0fa902b6 ("xfrm: use a dedicated slab cache for struct xfrm_state")
Reported-by: Pan Bian <bianpan2016@163.com>
Cc: <stable@vger.kernel.org> # v4.18+
Signed-off-by: Mathias Krause <minipli@googlemail.com>
---
 include/net/xfrm.h    | 1 +
 net/xfrm/xfrm_state.c | 8 +++++++-
 net/xfrm/xfrm_user.c  | 4 ++--
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 0eb390c205af..da588def3c61 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -1552,6 +1552,7 @@ int xfrm_state_walk(struct net *net, struct xfrm_state_walk *walk,
 		    int (*func)(struct xfrm_state *, int, void*), void *);
 void xfrm_state_walk_done(struct xfrm_state_walk *walk, struct net *net);
 struct xfrm_state *xfrm_state_alloc(struct net *net);
+void xfrm_state_free(struct xfrm_state *x);
 struct xfrm_state *xfrm_state_find(const xfrm_address_t *daddr,
 				   const xfrm_address_t *saddr,
 				   const struct flowi *fl,
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index dc4a9f1fb941..0a0b01b688d7 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -426,6 +426,12 @@ static void xfrm_put_mode(struct xfrm_mode *mode)
 	module_put(mode->owner);
 }
 
+void xfrm_state_free(struct xfrm_state *x)
+{
+	kmem_cache_free(xfrm_state_cache, x);
+}
+EXPORT_SYMBOL(xfrm_state_free);
+
 static void xfrm_state_gc_destroy(struct xfrm_state *x)
 {
 	tasklet_hrtimer_cancel(&x->mtimer);
@@ -452,7 +458,7 @@ static void xfrm_state_gc_destroy(struct xfrm_state *x)
 	}
 	xfrm_dev_state_free(x);
 	security_xfrm_state_free(x);
-	kmem_cache_free(xfrm_state_cache, x);
+	xfrm_state_free(x);
 }
 
 static void xfrm_state_gc_task(struct work_struct *work)
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index c9a84e22f5d5..277c1c46fe94 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -2288,13 +2288,13 @@ static int xfrm_add_acquire(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 	}
 
-	kfree(x);
+	xfrm_state_free(x);
 	kfree(xp);
 
 	return 0;
 
 free_state:
-	kfree(x);
+	xfrm_state_free(x);
 nomem:
 	return err;
 }
