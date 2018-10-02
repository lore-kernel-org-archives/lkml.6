Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F77BC64EBC
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED8DC208D9
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5yuxNSC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED8DC208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbeJCDxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 23:53:01 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:37333 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727832AbeJCDxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 23:53:00 -0400
Received: by mail-yb1-f194.google.com with SMTP id h1-v6so1441866ybm.4;
        Tue, 02 Oct 2018 14:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ra+rmc2HY5drD887QHu6zwBPZPvMu9Noss4auH4fFgI=;
        b=G5yuxNSC1rYnd8DoiBPjgxf7yxmG6fhcovQp5r1zkH6xL6GU74mokR3b5KGg11dsdl
         FKoMy3We+5xXuSLCaIL2opffen4Fd27fsQ9BpZHMBkm+YNSgJdSeAYJPOASuzJ4KkbWm
         6H83kyHiMpMFKALX81mcO51VlFi+/wmD6EHCozMVhu+IgqvO6A0Q0fGdX112GbG8Zd4g
         fPEj3Xx1KcCcJmaWrwpHqOl5qQq7GEHss6FbqsveIthe2SlIVKc5qe06SKqq52/l7MmM
         VCockNlFZ3hQP22ilp90sKWyAUP/q/o/sppCoTosdZfyRZbS+z54vfKpfMymsa3SmaAe
         k3vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ra+rmc2HY5drD887QHu6zwBPZPvMu9Noss4auH4fFgI=;
        b=TjCSA2w2P2isow+rJ6u30htlUtkd8oWx5ExPyyCfdTDKKhIMD1qP8YvX+2da2rUOis
         lgPlOM3Pd3nCY4ueINDenoT56UB1fE6PH1VFmZJo3p/fmvA+hvxoImeVa1QS6+TN4oPD
         pKKZHhnVTGfUd55uu95v6LZyMrfTUSF3/3ivTL5PgV2mRkNGm5koBAXy7Hgy1DKkxFE9
         r+knfZqPeQ1qDeKd3X+1sWVkRddKcb+pg6o00uyBFdh3DhE9wgyhfCqwIVPUoxUlwhlM
         LDU9uQloyxV7f39c5OBJ7B3HcJr+T3NFs/w2rVLsdJZzz5xqJxRyljpbgnXSc+DOCQru
         bhhQ==
X-Gm-Message-State: ABuFfoieI94xrozaaO6nBS2DRP1CbYTS5irmJsg9eSg7KymSQD3y1UuF
        ir5dbMbzEnzQoPRGO9FGLA93k+aK
X-Google-Smtp-Source: ACcGV63RRH+aFJTvwIsWUipHpjSR546dwADC75Uf+3ZZsug632QN95htXfwAY3zLyjzPqczECjYfHQ==
X-Received: by 2002:a25:3055:: with SMTP id w82-v6mr9495301ybw.57.1538514463959;
        Tue, 02 Oct 2018 14:07:43 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::7:aff1])
        by smtp.gmail.com with ESMTPSA id g14-v6sm696110ywk.94.2018.10.02.14.07.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 14:07:43 -0700 (PDT)
Date:   Tue, 2 Oct 2018 14:07:41 -0700
From:   Tejun Heo <tj@kernel.org>
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Amin Jamali <ajamali@pivotal.io>,
        Joao De Almeida Pereira <jpereira@pivotal.io>
Subject: Re: Cgroup v2 bug: "domain invalid" node can't be converted to
 "threaded"
Message-ID: <20181002210741.GJ270328@devbig004.ftw2.facebook.com>
References: <CAKgNAkhHYCMn74TCNiMJ=ccLd7DcmXSbvw3CbZ1YREeG7iJM5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgNAkhHYCMn74TCNiMJ=ccLd7DcmXSbvw3CbZ1YREeG7iJM5g@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Michael.

Great catch.  Can you please verify whether the following patch fixes
the issue?

Thanks.

------ 8< ------
Subject: cgroup: Fix dom_cgrp propagation when enabling threaded mode

A cgroup which is already a threaded domain may be converted into a
threaded cgroup if the prerequisite conditions are met.  When this
happens, all threaded descendant should also have their ->dom_cgrp
updated to the new threaded domain cgroup.  Unfortunately, this
propagation was missing leading to the following failure.

  # cd /sys/fs/cgroup/unified
  # cat cgroup.subtree_control    # show that no controllers are enabled

  # mkdir -p mycgrp/a/b/c
  # echo threaded > mycgrp/a/b/cgroup.type

  At this point, the hierarchy looks as follows:

      mycgrp [d]
	  a [dt]
	      b [t]
		  c [inv]

  Now let's make node "a" threaded (and thus "mycgrp" s made "domain threaded"):

  # echo threaded > mycgrp/a/cgroup.type

  By this point, we now have a hierarchy that looks as follows:

      mycgrp [dt]
	  a [t]
	      b [t]
		  c [inv]

  But, when we try to convert the node "c" from "domain invalid" to
  "threaded", we get ENOTSUP on the write():

  # echo threaded > mycgrp/a/b/c/cgroup.type
  sh: echo: write error: Operation not supported

This patch fixes the problem by

* Moving the opencoded ->dom_cgrp save and restoration in
  cgroup_enable_threaded() into cgroup_{save|restore}_control() so
  that mulitple cgroups can be handled.
  
* Updating all threaded descendants' ->dom_cgrp to point to the new
  dom_cgrp when enabling threaded mode.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Link: https://lore.kernel.org/r/CAKgNAkhHYCMn74TCNiMJ=ccLd7DcmXSbvw3CbZ1YREeG7iJM5g@mail.gmail.com
Fixes: 454000adaa2a ("cgroup: introduce cgroup->dom_cgrp and threaded css_set handling")
Cc: stable@vger.kernel.org # v4.14+
---
 kernel/cgroup/cgroup.c |   25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -2836,11 +2836,12 @@ restart:
 }
 
 /**
- * cgroup_save_control - save control masks of a subtree
+ * cgroup_save_control - save control masks and dom_cgrp of a subtree
  * @cgrp: root of the target subtree
  *
- * Save ->subtree_control and ->subtree_ss_mask to the respective old_
- * prefixed fields for @cgrp's subtree including @cgrp itself.
+ * Save ->subtree_control, ->subtree_ss_mask and ->dom_cgrp to the
+ * respective old_ prefixed fields for @cgrp's subtree including @cgrp
+ * itself.
  */
 static void cgroup_save_control(struct cgroup *cgrp)
 {
@@ -2850,6 +2851,7 @@ static void cgroup_save_control(struct c
 	cgroup_for_each_live_descendant_pre(dsct, d_css, cgrp) {
 		dsct->old_subtree_control = dsct->subtree_control;
 		dsct->old_subtree_ss_mask = dsct->subtree_ss_mask;
+		dsct->old_dom_cgrp = dsct->dom_cgrp;
 	}
 }
 
@@ -2875,11 +2877,12 @@ static void cgroup_propagate_control(str
 }
 
 /**
- * cgroup_restore_control - restore control masks of a subtree
+ * cgroup_restore_control - restore control masks and dom_cgrp of a subtree
  * @cgrp: root of the target subtree
  *
- * Restore ->subtree_control and ->subtree_ss_mask from the respective old_
- * prefixed fields for @cgrp's subtree including @cgrp itself.
+ * Restore ->subtree_control, ->subtree_ss_mask and ->dom_cgrp from the
+ * respective old_ prefixed fields for @cgrp's subtree including @cgrp
+ * itself.
  */
 static void cgroup_restore_control(struct cgroup *cgrp)
 {
@@ -2889,6 +2892,7 @@ static void cgroup_restore_control(struc
 	cgroup_for_each_live_descendant_post(dsct, d_css, cgrp) {
 		dsct->subtree_control = dsct->old_subtree_control;
 		dsct->subtree_ss_mask = dsct->old_subtree_ss_mask;
+		dsct->dom_cgrp = dsct->old_dom_cgrp;
 	}
 }
 
@@ -3196,6 +3200,8 @@ static int cgroup_enable_threaded(struct
 {
 	struct cgroup *parent = cgroup_parent(cgrp);
 	struct cgroup *dom_cgrp = parent->dom_cgrp;
+	struct cgroup *dsct;
+	struct cgroup_subsys_state *d_css;
 	int ret;
 
 	lockdep_assert_held(&cgroup_mutex);
@@ -3225,12 +3231,13 @@ static int cgroup_enable_threaded(struct
 	 */
 	cgroup_save_control(cgrp);
 
-	cgrp->dom_cgrp = dom_cgrp;
+	cgroup_for_each_live_descendant_pre(dsct, d_css, cgrp)
+		if (dsct == cgrp || cgroup_is_threaded(dsct))
+			dsct->dom_cgrp = dom_cgrp;
+
 	ret = cgroup_apply_control(cgrp);
 	if (!ret)
 		parent->nr_threaded_children++;
-	else
-		cgrp->dom_cgrp = cgrp;
 
 	cgroup_finalize_control(cgrp, ret);
 	return ret;
