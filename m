Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7BA5C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 16:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEB9B223DD
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 16:34:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CXKh9szP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEB9B223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731286AbeKNCcz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 21:32:55 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43133 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727475AbeKNCcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 21:32:55 -0500
Received: by mail-qk1-f196.google.com with SMTP id r71so20432573qkr.10;
        Tue, 13 Nov 2018 08:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jR0fRYp/BIYNsG6MN55gk0oGE8HOfcc6D5XxTxN3+DE=;
        b=CXKh9szPa8YSyGfC/4hyGn5tcixv/PpE23S3bQovGvWKSyguU74qTR2KVMf8bqbnmf
         ae6f7apxPzksUZIcwgKLkWLZUpasR1HJpwGVsBczWMDGFzz8pS2pswprAJIlLL5///pv
         RNQH2FWliPuFtvhd8Z6p0wfFzu3EWyvSUGGYa8dYSH1m8R8IZi3J+zTT7Q/XIkgm/hJe
         8ylN7kuotKbXKrgCOjFbdWcplqph16J4+Rho52Uecq7wIeNwXHRp9gZldbDBMETTUYEN
         1tHIxvK0X2chQfK8s1NhfImlU0Ktwbi88k9K92KEswJgQKhP42sLAXp+xuLhGiSuXVr9
         gysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=jR0fRYp/BIYNsG6MN55gk0oGE8HOfcc6D5XxTxN3+DE=;
        b=lTFDOwLvoTf6z4IpbqV6krkLvhgkMTkPtZ+hVDEse3ZfrMlP/AMslHV8hI4agY5W5t
         PaRrOECoz1B+CsA1RIczMq+ZTe8uGof0UAcyJWcSU3gPutDngn11L1fJrkTuCc4hGDEG
         uNjocsZe330kRv/me4ai7wwGoe8kHTXqBaoKisUDlLXmD6EYigi3xKQEIfOnBhTur/+i
         LddppfEaPQwtddNjQH+xdYwiKOUitKj8uwFg8phkGWFmst5hlts7t2UGnCJPjJzSslQs
         MWvuQWb6N1PYqoaflo8KWRXPNAEugjyzT8+KPjinNTALY6SXkXmNO54AUSixgWXVBirJ
         AP/w==
X-Gm-Message-State: AGRZ1gLxqHq1chhQN6hgcYqjdp+SaLRulJu+/tEIwRbFYk4RiZkI7Uxl
        VG9sgZbNhY713zEVXfvpWs8=
X-Google-Smtp-Source: AJdET5dMTIEfKWQKZI/WU6auRQ6dGL0V06VujjT7g5/5XsWakvJ9zgmOb9z9SllulweVIw9LFlEbVQ==
X-Received: by 2002:a37:24c9:: with SMTP id k70mr5544517qkk.281.1542126844139;
        Tue, 13 Nov 2018 08:34:04 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::6:e2a7])
        by smtp.gmail.com with ESMTPSA id y14sm14295842qky.83.2018.11.13.08.34.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 08:34:03 -0800 (PST)
Date:   Tue, 13 Nov 2018 08:34:00 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     linux-mm@kvack.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, aarcange@redhat.com,
        aaron.lu@intel.com, akpm@linux-foundation.org,
        alex.williamson@redhat.com, bsd@redhat.com,
        darrick.wong@oracle.com, dave.hansen@linux.intel.com,
        jgg@mellanox.com, jwadams@google.com, jiangshanlai@gmail.com,
        mhocko@kernel.org, mike.kravetz@oracle.com,
        Pavel.Tatashin@microsoft.com, prasad.singamsetty@oracle.com,
        rdunlap@infradead.org, steven.sistare@oracle.com,
        tim.c.chen@intel.com, vbabka@suse.cz
Subject: Re: [RFC PATCH v4 05/13] workqueue, ktask: renice helper threads to
 prevent starvation
Message-ID: <20181113163400.GK2509588@devbig004.ftw2.facebook.com>
References: <20181105165558.11698-1-daniel.m.jordan@oracle.com>
 <20181105165558.11698-6-daniel.m.jordan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105165558.11698-6-daniel.m.jordan@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Daniel.

On Mon, Nov 05, 2018 at 11:55:50AM -0500, Daniel Jordan wrote:
>  static bool start_flush_work(struct work_struct *work, struct wq_barrier *barr,
> -			     bool from_cancel)
> +			     struct nice_work *nice_work, int flags)
>  {
>  	struct worker *worker = NULL;
>  	struct worker_pool *pool;
> @@ -2868,11 +2926,19 @@ static bool start_flush_work(struct work_struct *work, struct wq_barrier *barr,
>  	if (pwq) {
>  		if (unlikely(pwq->pool != pool))
>  			goto already_gone;
> +
> +		/* not yet started, insert linked work before work */
> +		if (unlikely(flags & WORK_FLUSH_AT_NICE))
> +			insert_nice_work(pwq, nice_work, work);

So, I'm not sure this works that well.  e.g. what if the work item is
waiting for other work items which are at lower priority?  Also, in
this case, it'd be a lot simpler to simply dequeue the work item and
execute it synchronously.

>  	} else {
>  		worker = find_worker_executing_work(pool, work);
>  		if (!worker)
>  			goto already_gone;
>  		pwq = worker->current_pwq;
> +		if (unlikely(flags & WORK_FLUSH_AT_NICE)) {
> +			set_user_nice(worker->task, nice_work->nice);
> +			worker->flags |= WORKER_NICED;
> +		}
>  	}

I'm not sure about this.  Can you see whether canceling & executing
synchronously is enough to address the latency regression?

Thanks.

-- 
tejun
