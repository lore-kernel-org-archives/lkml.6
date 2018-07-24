Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD999C28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 21:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65B8620875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 21:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lsN5H/OF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65B8620875
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388882AbeGXWQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 18:16:11 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39339 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388823AbeGXWQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 18:16:11 -0400
Received: by mail-pg1-f193.google.com with SMTP id g2-v6so3725836pgs.6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 14:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=GRpMvOtQ2l4EWsyFMosWvTYZzcMc5iTWpAY5ngEzkuw=;
        b=lsN5H/OFLNNc7MzqgLfTH21qJ+pljulOpQ/hF45IXmXn1DY7NDIpU30dGn2eVKVub4
         vRSVLOFimGJINmhyswNmdfjhBrwRgL3WcjolU8B08hK/Jk66m1NX/ubbAXNpGginmciV
         rTLsNUC0khsINDJUTDptuvEGc7aoMx9mloM1xgdam3tMHCYodVGxPmXRId6r6URAMm8s
         zdgXgWE8frwNYyQBw5StdMr/v+csKcZHkCzZFjpRC++cAgQk/+CR/T7F2RACT3IgN4rj
         3v5o+BZFD6LlPWVU5z/P7BYDaPtuuaj018EoVa2z0yORwLqadQdGJUk0vOacRad7PUIR
         zyuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=GRpMvOtQ2l4EWsyFMosWvTYZzcMc5iTWpAY5ngEzkuw=;
        b=tNVxiMYGuxrog6rBOe5OvzcUQ6+KQ9WN8UGgW9JSDlHTyaz9X/RDyF+oFZM1GVVPAb
         tLGeFe58rLQCk8J9UFrI58TtvbynBpVQ8QzpMrhNXKgS+qF3P4boalg5oLx/kGitZfQL
         xNjGDuY3tuCgUDYBndUOMTDKjpKOL96+GCRuCfbEL88BBR9f2xNWW5bI1O4CeraJMDJ1
         6mKoXJgtk8hzUz+XUNmZAYkIJyhAkxvzWRHw1872suJegttC83XDyNkhaEknuSssAjTE
         CCf6b2GeVQXo3vXF/H4OWEPkpgGe4F6qFhKuH1m1WD5jAOKYpRx4+N7nlCsB77Hv8v1d
         WQqQ==
X-Gm-Message-State: AOUpUlEOy9Cq+Zd7cS0dcJaOWRlVBg5c+dwwyfbl8WIygzjBf9l7+yYX
        U01hcxgAvzYjMgVqpM6XZt1UVSA9UBc=
X-Google-Smtp-Source: AAOMgpemc+5yBvV5dh8ku8rTX8SCYB8L0jNsRVFK4xUWd+aMwpByImhdwJj25yO+e6nwRd9r6MBLGQ==
X-Received: by 2002:a65:658d:: with SMTP id u13-v6mr17985311pgv.20.1532466470849;
        Tue, 24 Jul 2018 14:07:50 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id 84-v6sm34654729pfj.33.2018.07.24.14.07.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 14:07:50 -0700 (PDT)
Date:   Tue, 24 Jul 2018 14:07:49 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Michal Hocko <mhocko@kernel.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?Q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Dimitri Sivanich <sivanich@sgi.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        =?UTF-8?Q?J=C3=A9r=C3=B4me_Glisse?= <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Felix Kuehling <felix.kuehling@amd.com>, kvm@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        xen-devel@lists.xenproject.org,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: Re: [PATCH] mm, oom: distinguish blockable mode for mmu notifiers
In-Reply-To: <20180724141747.GP28386@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.21.1807241405450.191477@chino.kir.corp.google.com>
References: <20180716115058.5559-1-mhocko@kernel.org> <20180720170902.d1137060c23802d55426aa03@linux-foundation.org> <20180724141747.GP28386@dhcp22.suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Jul 2018, Michal Hocko wrote:

> oom_reap_task_mm should return false when __oom_reap_task_mm return
> false. This is what my patch did but it seems this changed by
> http://www.ozlabs.org/~akpm/mmotm/broken-out/mm-oom-remove-oom_lock-from-oom_reaper.patch
> so that one should be fixed.
> 
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 104ef4a01a55..88657e018714 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -565,7 +565,7 @@ static bool oom_reap_task_mm(struct task_struct *tsk, struct mm_struct *mm)
>  	/* failed to reap part of the address space. Try again later */
>  	if (!__oom_reap_task_mm(mm)) {
>  		up_read(&mm->mmap_sem);
> -		return true;
> +		return false;
>  	}
>  
>  	pr_info("oom_reaper: reaped process %d (%s), now anon-rss:%lukB, file-rss:%lukB, shmem-rss:%lukB\n",
> 
> 
> On top of that the proposed cleanup looks as follows:
> 
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 88657e018714..4e185a282b3d 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -541,8 +541,16 @@ bool __oom_reap_task_mm(struct mm_struct *mm)
>  	return ret;
>  }
>  
> +/*
> + * Reaps the address space of the give task.
> + *
> + * Returns true on success and false if none or part of the address space
> + * has been reclaimed and the caller should retry later.
> + */
>  static bool oom_reap_task_mm(struct task_struct *tsk, struct mm_struct *mm)
>  {
> +	bool ret = true;
> +
>  	if (!down_read_trylock(&mm->mmap_sem)) {
>  		trace_skip_task_reaping(tsk->pid);
>  		return false;
> @@ -555,28 +563,28 @@ static bool oom_reap_task_mm(struct task_struct *tsk, struct mm_struct *mm)
>  	 * down_write();up_write() cycle in exit_mmap().
>  	 */
>  	if (test_bit(MMF_OOM_SKIP, &mm->flags)) {
> -		up_read(&mm->mmap_sem);
>  		trace_skip_task_reaping(tsk->pid);
> -		return true;
> +		goto out_unlock;
>  	}
>  
>  	trace_start_task_reaping(tsk->pid);
>  
>  	/* failed to reap part of the address space. Try again later */
> -	if (!__oom_reap_task_mm(mm)) {
> -		up_read(&mm->mmap_sem);
> -		return false;
> -	}
> +	ret = __oom_reap_task_mm(mm);
> +	if (!ret)
> +		goto out_finish;
>  
>  	pr_info("oom_reaper: reaped process %d (%s), now anon-rss:%lukB, file-rss:%lukB, shmem-rss:%lukB\n",
>  			task_pid_nr(tsk), tsk->comm,
>  			K(get_mm_counter(mm, MM_ANONPAGES)),
>  			K(get_mm_counter(mm, MM_FILEPAGES)),
>  			K(get_mm_counter(mm, MM_SHMEMPAGES)));
> +out_finish:
> +	trace_finish_task_reaping(tsk->pid);
> +out_unlock:
>  	up_read(&mm->mmap_sem);
>  
> -	trace_finish_task_reaping(tsk->pid);
> -	return true;
> +	return ret;
>  }
>  
>  #define MAX_OOM_REAP_RETRIES 10

I think we still want to trace when reaping was skipped to know that the 
oom reaper will retry again later.



mm/oom_kill.c: clean up oom_reap_task_mm() fix

indicate reaping has been partially skipped so we can expect future skips 
or another start before finish.

Signed-off-by: David Rientjes <rientjes@google.com>
---
 mm/oom_kill.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -569,10 +569,12 @@ static bool oom_reap_task_mm(struct task_struct *tsk, struct mm_struct *mm)
 
 	trace_start_task_reaping(tsk->pid);
 
-	/* failed to reap part of the address space. Try again later */
 	ret = __oom_reap_task_mm(mm);
-	if (!ret)
+	if (!ret) {
+		/* Failed to reap part of the address space. Try again later */
+		trace_skip_task_reaping(tsk->pid);
 		goto out_finish;
+	}
 
 	pr_info("oom_reaper: reaped process %d (%s), now anon-rss:%lukB, file-rss:%lukB, shmem-rss:%lukB\n",
 			task_pid_nr(tsk), tsk->comm,
