Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3EB8ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 567B421532
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HhXfejM+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 567B421532
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388299AbeIUCi6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 22:38:58 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:46338 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727232AbeIUCi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 22:38:58 -0400
Received: by mail-yb1-f195.google.com with SMTP id y20-v6so4515568ybi.13;
        Thu, 20 Sep 2018 13:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gPCPZ0WoAFCyPZNUumPrnNe2t4LxKKQ0rNNqZggjQkI=;
        b=HhXfejM+/BekWy7eZIU8Cifi2+xqxfvl2j3xGoNSfaG9G8XWcu9qL+J1pXMAJh2R7c
         xPfSpc3L1XB2Z67jVPVmKF+s2sds/cpdXj8RD9W/JQmBktS6iUUf4v8y/DDKjJ4F3Vfk
         1Eg9fyWtmJflFGtARjPTs2c6I5pmSa/jCsZ1YaclA1QZpdAVmP970KsqIft2PFnNgLrV
         G5rR2Csxdx5Wb9i5+0Ia3mT45nUJrVtO/pIHMtCWDC3MiXBxtt3QBuDGIeR0Xn0F+NXQ
         4PrcEZs3mHUT2HmlCi2/BLa5O9wJ0nFQyNm0T3/ifzZTKCQie8/cjyW4J1i62yGhzth8
         yAaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=gPCPZ0WoAFCyPZNUumPrnNe2t4LxKKQ0rNNqZggjQkI=;
        b=Nx7AU3hk/Vl3JDpVdr1FFffhRybQ8nITXgYtL6Js5VTTzYdv00vNlISAFXi7u+jf/w
         68/pfIuEwhdYypPEFq4JXnqDhwZfj4XhqWpr/MWigSWUYoSYGcqir1AMwWCdhEzc/ALe
         3Ce/CcNIHpF1NIwthZJ6eN9tIZoxwirxA5+I4uY3FNqQVCgXN+alHwGrUZTRnxKip2r0
         9Jd33sfyJXzCxP7Hehe+h7Z5O8qv6Lx5V4PcDr8o7ife7mYa3p1+J11niwMOxoOAnnCL
         8nuSmYW61QiQgLDonD2TcWdgq5I18bNZD1jRqa2GDB1S01JOqks49n4SZyPXIsAvn6W+
         xMAA==
X-Gm-Message-State: APzg51AYZcyXBa9whw32jcg6S+b4J5gc+IMVq56XiqLqmVr57K43YLp6
        djx+r7Pj6r1Xzzo+tkKMGx4=
X-Google-Smtp-Source: ANB0VdbIU+fulfdE39td1uwGdxpjonCAfhPiIAlqH2MnHkqFl99Ls9uH+UOzWvCLO//riKcFfT54iQ==
X-Received: by 2002:a25:ad0d:: with SMTP id y13-v6mr9642806ybi.455.1537476816314;
        Thu, 20 Sep 2018 13:53:36 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::2:8453])
        by smtp.gmail.com with ESMTPSA id p78-v6sm15300558ywp.31.2018.09.20.13.53.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 13:53:35 -0700 (PDT)
Date:   Thu, 20 Sep 2018 13:53:33 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Jianchao Wang <jianchao.w.wang@oracle.com>
Cc:     axboe@kernel.dk, kent.overstreet@gmail.com, ming.lei@redhat.com,
        bart.vanassche@wdc.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] percpu_ref: add a new helper interface
 __percpu_ref_get_many
Message-ID: <20180920205333.GF902964@devbig004.ftw2.facebook.com>
References: <1537438703-25217-1-git-send-email-jianchao.w.wang@oracle.com>
 <1537438703-25217-2-git-send-email-jianchao.w.wang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537438703-25217-2-git-send-email-jianchao.w.wang@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Sep 20, 2018 at 06:18:21PM +0800, Jianchao Wang wrote:
> -static inline void percpu_ref_get_many(struct percpu_ref *ref, unsigned long nr)
> +static inline void __percpu_ref_get_many(struct percpu_ref *ref, unsigned long nr)
>  {
>  	unsigned long __percpu *percpu_count;
>  
> -	rcu_read_lock_sched();

So, if we're gonna do this (please read below tho), please add the
matching assertion

>  	if (__ref_is_percpu(ref, &percpu_count))
>  		this_cpu_add(*percpu_count, nr);
>  	else
>  		atomic_long_add(nr, &ref->count);
> +}
>  
> +/**
> + * percpu_ref_get_many - increment a percpu refcount
> + * @ref: percpu_ref to get
> + * @nr: number of references to get
> + *
> + * Analogous to atomic_long_add().
> + *
> + * This function is safe to call as long as @ref is between init and exit.
> + */
> +static inline void percpu_ref_get_many(struct percpu_ref *ref, unsigned long nr)
> +{
> +	rcu_read_lock_sched();
> +	__percpu_ref_get_many(ref, nr);
>  	rcu_read_unlock_sched();
>  }

And add the matching variant for get/put with and without _many.

Ming, so, if we make locking explicit like above, I think it should be
fine to share the locking.  However, please note that percpu_ref and
blk_mq are using different types of RCU, at least for now, and I'm not
really sure that unifying that and taking out one rcu read lock/unlock
is a meaningful optimization.

Let's please first do something straight-forward.  If somebody can
show that this actually impacts performance, we can optimize it but
right now all these seem premature to me.

Thanks.

-- 
tejun
