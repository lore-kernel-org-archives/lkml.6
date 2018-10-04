Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF41C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 19:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C96D2098A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 19:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/dafZ1F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C96D2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbeJECGp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 22:06:45 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43047 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbeJECGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 22:06:45 -0400
Received: by mail-wr1-f66.google.com with SMTP id n1-v6so11092938wrt.10;
        Thu, 04 Oct 2018 12:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9th6wm9+/VGG3F3Bqr6Re6NhsZvdns3WWk6xeTshRtc=;
        b=Y/dafZ1Fqf5wT2FhORaiGIzlaD4KPhNJjQVi8KAP223RdoAZlTZZmAL8NG8RMADaDZ
         tB7sqcgBAOClRURzlVjbgShopoxrjTd6Z8Klos2q7LJRE/v82xt7IhZhRwsaXvt9RYmo
         AJtR3m8SWxHWfCwhVf4fHZT/1WlIsgMdDZhtkK6kAR/ANwi3BJdyG/zq1On8jGIMGTYm
         qtN8nTwR0LNZOSv3Bx5s/QlNNdFxQoAOzBOEXD0JdCDx7jyE/VITOTrH3jv3J4rFW+8R
         s2FV46HtlWaIN7R60GBR91ZhEeyDv9eEkwLVbkYNkMZrifvxnYv/yFUtMcfmvVJOYYJd
         i9Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9th6wm9+/VGG3F3Bqr6Re6NhsZvdns3WWk6xeTshRtc=;
        b=dX6unvunfaYUQuGkGGNhRFrG5QCcM7DKyofCgo5Vy2FmULToSuQUCOC+o30YB+bHTQ
         O5WtfgLmfVoBW54Jesa9MgmqKi0pXZZhLu+Ptwdqp5pSJljqOoRc2oUd1Rs9puFjmOmB
         q2oRhzeZpwkM+vJjATt8eG7ozE073+8kwgjN2hjX9pthonaB4HSjJPJMGBZAJBod16nc
         a/w+rSECg3Rd2MWugqnxqMRyWck/a6diVvRlmkjx8rAWeLlfYcdW11vtraFXaQBrupTE
         vlwKhaZAhSeAYa9cGbFreBBzZppBJhL68fsC0mnmwaH5nfDJgz59yvMNEy44pTqNreNI
         SQaw==
X-Gm-Message-State: ABuFfohZPqUt59RjDytZo820qur6Kcou4T1eRcILpNV4UC79/fiZAMvF
        DZfnb77ZXlU1A7cYYMgHh616CmuP
X-Google-Smtp-Source: ACcGV61yvX4/qypovBGBAEM1feL9jEmfSzgH9mSVEaD3QO1kU9LCbDRiAJH7uNiVfHxUqmmsGJo5Fg==
X-Received: by 2002:adf:db8e:: with SMTP id u14-v6mr6027552wri.217.1538680325569;
        Thu, 04 Oct 2018 12:12:05 -0700 (PDT)
Received: from ?IPv6:2001:a61:25ca:c200:9cfe:b5b3:4ec3:2c28? ([2001:a61:25ca:c200:9cfe:b5b3:4ec3:2c28])
        by smtp.gmail.com with ESMTPSA id 140-v6sm281502wmx.34.2018.10.04.12.12.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 12:12:04 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, lkml <linux-kernel@vger.kernel.org>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Amin Jamali <ajamali@pivotal.io>,
        Joao De Almeida Pereira <jpereira@pivotal.io>
Subject: Re: Cgroup v2 bug: "domain invalid" node can't be converted to
 "threaded"
To:     Tejun Heo <tj@kernel.org>
References: <CAKgNAkhHYCMn74TCNiMJ=ccLd7DcmXSbvw3CbZ1YREeG7iJM5g@mail.gmail.com>
 <20181002210741.GJ270328@devbig004.ftw2.facebook.com>
 <0cf4f9de-70d2-cf94-12d2-283759638e20@gmail.com>
 <20181004182017.GK270328@devbig004.ftw2.facebook.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <1558fb10-5a70-61fb-1e2f-771e044a2e6b@gmail.com>
Date:   Thu, 4 Oct 2018 21:12:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181004182017.GK270328@devbig004.ftw2.facebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Tejun,

On 10/04/2018 08:20 PM, Tejun Heo wrote:
> Hello,
> 
> On Thu, Oct 04, 2018 at 08:14:55PM +0200, Michael Kerrisk (man-pages) wrote:
>> On 10/02/2018 11:07 PM, Tejun Heo wrote:
>>> Hello, Michael.
>>>
>>> Great catch.  Can you please verify whether the following patch fixes
>>> the issue?
>>>
>>> Thanks.
>> Against which kernel version should this apply? I get these build
>> errors on kernel 4.18:
> 
> lol, sorry about that.  The header change ended up in the wrong patch.
> Updated patch follows.

That fixes the problem for me (built against 4.19-rc6).

When you roll the final patch, please include Amin and Joao in the 
Reported-by:

Thanks,

Michael


> ------ 8< ------
> Subject: cgroup: Fix dom_cgrp propagation when enabling threaded mode
> 
> A cgroup which is already a threaded domain may be converted into a
> threaded cgroup if the prerequisite conditions are met.  When this
> happens, all threaded descendant should also have their ->dom_cgrp
> updated to the new threaded domain cgroup.  Unfortunately, this
> propagation was missing leading to the following failure.
> 
>   # cd /sys/fs/cgroup/unified
>   # cat cgroup.subtree_control    # show that no controllers are enabled
> 
>   # mkdir -p mycgrp/a/b/c
>   # echo threaded > mycgrp/a/b/cgroup.type
> 
>   At this point, the hierarchy looks as follows:
> 
>       mycgrp [d]
> 	  a [dt]
> 	      b [t]
> 		  c [inv]
> 
>   Now let's make node "a" threaded (and thus "mycgrp" s made "domain threaded"):
> 
>   # echo threaded > mycgrp/a/cgroup.type
> 
>   By this point, we now have a hierarchy that looks as follows:
> 
>       mycgrp [dt]
> 	  a [t]
> 	      b [t]
> 		  c [inv]
> 
>   But, when we try to convert the node "c" from "domain invalid" to
>   "threaded", we get ENOTSUP on the write():
> 
>   # echo threaded > mycgrp/a/b/c/cgroup.type
>   sh: echo: write error: Operation not supported
> 
> This patch fixes the problem by
> 
> * Moving the opencoded ->dom_cgrp save and restoration in
>   cgroup_enable_threaded() into cgroup_{save|restore}_control() so
>   that mulitple cgroups can be handled.
>   
> * Updating all threaded descendants' ->dom_cgrp to point to the new
>   dom_cgrp when enabling threaded mode.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reported-by: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
> Link: https://lore.kernel.org/r/CAKgNAkhHYCMn74TCNiMJ=ccLd7DcmXSbvw3CbZ1YREeG7iJM5g@mail.gmail.com
> Fixes: 454000adaa2a ("cgroup: introduce cgroup->dom_cgrp and threaded css_set handling")
> Cc: stable@vger.kernel.org # v4.14+
> ---
>  include/linux/cgroup-defs.h |    1 +
>  kernel/cgroup/cgroup.c      |   25 ++++++++++++++++---------
>  2 files changed, 17 insertions(+), 9 deletions(-)
> 
> --- a/include/linux/cgroup-defs.h
> +++ b/include/linux/cgroup-defs.h
> @@ -412,6 +412,7 @@ struct cgroup {
>  	 * specific task are charged to the dom_cgrp.
>  	 */
>  	struct cgroup *dom_cgrp;
> +	struct cgroup *old_dom_cgrp;		/* used while enabling threaded */
>  
>  	/* per-cpu recursive resource statistics */
>  	struct cgroup_rstat_cpu __percpu *rstat_cpu;
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -2836,11 +2836,12 @@ restart:
>  }
>  
>  /**
> - * cgroup_save_control - save control masks of a subtree
> + * cgroup_save_control - save control masks and dom_cgrp of a subtree
>   * @cgrp: root of the target subtree
>   *
> - * Save ->subtree_control and ->subtree_ss_mask to the respective old_
> - * prefixed fields for @cgrp's subtree including @cgrp itself.
> + * Save ->subtree_control, ->subtree_ss_mask and ->dom_cgrp to the
> + * respective old_ prefixed fields for @cgrp's subtree including @cgrp
> + * itself.
>   */
>  static void cgroup_save_control(struct cgroup *cgrp)
>  {
> @@ -2850,6 +2851,7 @@ static void cgroup_save_control(struct c
>  	cgroup_for_each_live_descendant_pre(dsct, d_css, cgrp) {
>  		dsct->old_subtree_control = dsct->subtree_control;
>  		dsct->old_subtree_ss_mask = dsct->subtree_ss_mask;
> +		dsct->old_dom_cgrp = dsct->dom_cgrp;
>  	}
>  }
>  
> @@ -2875,11 +2877,12 @@ static void cgroup_propagate_control(str
>  }
>  
>  /**
> - * cgroup_restore_control - restore control masks of a subtree
> + * cgroup_restore_control - restore control masks and dom_cgrp of a subtree
>   * @cgrp: root of the target subtree
>   *
> - * Restore ->subtree_control and ->subtree_ss_mask from the respective old_
> - * prefixed fields for @cgrp's subtree including @cgrp itself.
> + * Restore ->subtree_control, ->subtree_ss_mask and ->dom_cgrp from the
> + * respective old_ prefixed fields for @cgrp's subtree including @cgrp
> + * itself.
>   */
>  static void cgroup_restore_control(struct cgroup *cgrp)
>  {
> @@ -2889,6 +2892,7 @@ static void cgroup_restore_control(struc
>  	cgroup_for_each_live_descendant_post(dsct, d_css, cgrp) {
>  		dsct->subtree_control = dsct->old_subtree_control;
>  		dsct->subtree_ss_mask = dsct->old_subtree_ss_mask;
> +		dsct->dom_cgrp = dsct->old_dom_cgrp;
>  	}
>  }
>  
> @@ -3196,6 +3200,8 @@ static int cgroup_enable_threaded(struct
>  {
>  	struct cgroup *parent = cgroup_parent(cgrp);
>  	struct cgroup *dom_cgrp = parent->dom_cgrp;
> +	struct cgroup *dsct;
> +	struct cgroup_subsys_state *d_css;
>  	int ret;
>  
>  	lockdep_assert_held(&cgroup_mutex);
> @@ -3225,12 +3231,13 @@ static int cgroup_enable_threaded(struct
>  	 */
>  	cgroup_save_control(cgrp);
>  
> -	cgrp->dom_cgrp = dom_cgrp;
> +	cgroup_for_each_live_descendant_pre(dsct, d_css, cgrp)
> +		if (dsct == cgrp || cgroup_is_threaded(dsct))
> +			dsct->dom_cgrp = dom_cgrp;
> +
>  	ret = cgroup_apply_control(cgrp);
>  	if (!ret)
>  		parent->nr_threaded_children++;
> -	else
> -		cgrp->dom_cgrp = cgrp;
>  
>  	cgroup_finalize_control(cgrp, ret);
>  	return ret;
> 


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
