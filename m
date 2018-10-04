Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E5BCC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 18:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4592720684
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 18:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMeOA5ce"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4592720684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbeJEBJ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 21:09:27 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53213 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727670AbeJEBJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 21:09:27 -0400
Received: by mail-wm1-f68.google.com with SMTP id 189-v6so9937771wmw.2;
        Thu, 04 Oct 2018 11:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZBeAL2uIxDhJvUj5bsgnGyJxC+3ht41XiHdgrhMOzsM=;
        b=BMeOA5ce6w9POAEfDU03i5z0xkdirArRh0S7AE0jFOVrRqQK3tcAMlZoo76YNLSIZ/
         sD3tuvu4BA3a3IlbetHpJpuEUYkKEYnPab+faTE0bAMfeBW1o5FWdhQB3G/o+kBORBzN
         URSHcq57fcJwRZWJ4MjtaOMvore3l959pbCtzZju1e/vITZzfjleCZ5lDe3bl0cajB7a
         FMFM6TZtAsSL2YfSZ2j8QYjFB+99SE2o56ts+iCsRSP5imwatGflbs5/CYRhIa6xpXqv
         1pisgcBJtmmzPiuSkUcEWVFvkZlVjWxGgWHJJXXj3NlhvMB4jon7hTMauOoKbJYr6v4D
         iR+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZBeAL2uIxDhJvUj5bsgnGyJxC+3ht41XiHdgrhMOzsM=;
        b=SN+K+qyR6+SI7JGRawJjmRWp7Rcmmu5OenJCPWa87btgRxbBGEV9xfl8wBFdvncGpC
         POQRcltUGVVTDmT6i/jBksLURQkf0AUL8y16SDpWgZCg4LfupIRoqNqWnWFL8aORjVQl
         TIpKZrV6I1EvLyBuUETW72jz95wJbo15cPqCv7WFPJvnpdYk1kyZ5iJDNl3tbSQZ4yWx
         Z5Ej3Eb3XAAzP4ZSnCp2/FoyD9IgTD+dsrnzaXKgFzfwQqRhKzkv5K+aJ/lUiuaOzZ/7
         ygC5vBPW9QO215OR0pPIuBRXm14MRUvto5ZeC6WeSxnUbusTjtP+U1s5u4NXj1UBh/od
         /B7g==
X-Gm-Message-State: ABuFfojns8cC85flRZhcVwY803A9WuOgOexEp4B5omDpzsYqt8lPj+uU
        5lpE652BQ+4oWU3BSc16RyI=
X-Google-Smtp-Source: ACcGV62a74LcYrC53csmVoudhS0FvJJFmZWiDB/V2g6mxOLMg/rrD02fLFT5O3lwh+O/IL2aqYsoUQ==
X-Received: by 2002:a1c:83c3:: with SMTP id f186-v6mr5410129wmd.123.1538676899446;
        Thu, 04 Oct 2018 11:14:59 -0700 (PDT)
Received: from [192.168.178.43] (x5f733e23.dyn.telefonica.de. [95.115.62.35])
        by smtp.gmail.com with ESMTPSA id 4-v6sm6268366wmt.16.2018.10.04.11.14.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 11:14:58 -0700 (PDT)
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
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <0cf4f9de-70d2-cf94-12d2-283759638e20@gmail.com>
Date:   Thu, 4 Oct 2018 20:14:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181002210741.GJ270328@devbig004.ftw2.facebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Tejun,

On 10/02/2018 11:07 PM, Tejun Heo wrote:
> Hello, Michael.
> 
> Great catch.  Can you please verify whether the following patch fixes
> the issue?
> 
> Thanks.
Against which kernel version should this apply? I get these build
errors on kernel 4.18:

[[
  CC      kernel/cgroup/cgroup.o
kernel/cgroup/cgroup.c: In function ‘cgroup_save_control’:
kernel/cgroup/cgroup.c:2851:9: error: ‘struct cgroup’ has no member named ‘old_dom_cgrp’; did you mean ‘dom_cgrp’?
   dsct->old_dom_cgrp = dsct->dom_cgrp;
         ^~~~~~~~~~~~
         dom_cgrp
kernel/cgroup/cgroup.c: In function ‘cgroup_restore_control’:
kernel/cgroup/cgroup.c:2892:26: error: ‘struct cgroup’ has no member named ‘old_dom_cgrp’; did you mean ‘dom_cgrp’?
   dsct->dom_cgrp = dsct->old_dom_cgrp;
                          ^~~~~~~~~~~~
                          dom_cgrp
make[2]: *** [scripts/Makefile.build:318: kernel/cgroup/cgroup.o] Error 1
make[1]: *** [scripts/Makefile.build:558: kernel/cgroup] Error 2
make: *** [Makefile:1029: kernel] Error 2
$ vi ~/p1.eml kernel/cgroup/cgroup.c
/home/mtk/p1.eml ==> /hdd/backup/home/mtk/p1.eml/2018-10-04_20:11:57
kernel/cgroup/cgroup.c ==> /hdd/backup/hdd/workspace/KERNEL/build/linux-4.18/kernel/cgroup/cgroup.c/2018-10-04_20:11:57
]]

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
>  kernel/cgroup/cgroup.c |   25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
> 
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
