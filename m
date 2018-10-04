Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF076C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 10:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81B762082A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 10:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DdONSnEi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81B762082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbeJDRHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 13:07:02 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37794 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbeJDRHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 13:07:01 -0400
Received: by mail-wr1-f65.google.com with SMTP id u12-v6so9235696wrr.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 03:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5uYwxQHzVVjKKKIcBn7qdgUaMoYMrJ57XcFa7IxpZiU=;
        b=DdONSnEiW3wI6mpL9QDsZTOI6tpMGeUx5fUWjwlP/mZDZf08OgrTViArp26dU6D6p4
         Y1sXvqfdA5urEF/suY+arEbcmYZsCOYwo1lhU2ML7REJlvzEw0sRdGtM/N/xh9LwYRXc
         pDcDdeDK8/PZJlyd/GQ0s4M6Fd3aOXido2O/NU8FD2b8f3YLs7VOQyJcEMdlvLTsL9ZA
         Ywb6cVk3oHijfsOZr7lOnX6ehfN5FzgP5bOh3YPxWhQ1VKvrIZkuIRE3aYYbhbAYe+ob
         X5ENW4rcHW/CYpRk8qLr1tf2XSdaIrDiZKVGhDGLCJejfwUSMZKvJAhI+jKgHTrYrwuv
         VXBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=5uYwxQHzVVjKKKIcBn7qdgUaMoYMrJ57XcFa7IxpZiU=;
        b=NHCtaK5kS7J0kQe9fsPuu2aVFaHOzs633OpQ6SK818J/F+rXQbJURUFjn/LSAv4wkm
         X/TMcJDUd8zHYZlkyGqrF8Vof+KJw09f2KnpixsZ8vGZcjZfy2IYUT3weN3Y1HMmZzcF
         6Fg4Uf5fEHmgOKF9R3iDRsEiUzSSnECWibqCM7xXoRA2beaeqh4ZH7n4ngeevnRAZg89
         VKNHgKH7T0l2XJnFQkCJsrYn1BurPuX4JU0Jkatj2Z9FhjS5giPjidBzjhErd3j6rdor
         JzvG2Tn9anX0O022Cr3ZvdorMPXXhGYEY6/U2Qo4E+KPmWvk/olaDH4L6UAd10MVEfT1
         djSg==
X-Gm-Message-State: ABuFfoi4bUWFAM0ekJKLPb3d4jIyhep0P1+ceozAd+V4VaOJSnUnb8a+
        gUQbWlszupAQpsP35aOBs7I=
X-Google-Smtp-Source: ACcGV60wsb+b4jfMiEOpgrAYS/rZ2DMRpcmh06t7VWsPjwVrtrtOODZXdMFoEMBHo5/y1iDdOHl0jg==
X-Received: by 2002:a5d:4c4d:: with SMTP id n13-v6mr3900694wrt.120.1538648066035;
        Thu, 04 Oct 2018 03:14:26 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id z21-v6sm3291209wmi.29.2018.10.04.03.14.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Oct 2018 03:14:25 -0700 (PDT)
Date:   Thu, 4 Oct 2018 12:14:23 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] locking/lockdep: Make class->ops a percpu counter
Message-ID: <20181004101423.GA83274@gmail.com>
References: <1538511560-10090-1-git-send-email-longman@redhat.com>
 <1538511560-10090-5-git-send-email-longman@redhat.com>
 <20181003074809.GJ26858@hirez.programming.kicks-ass.net>
 <62801eb9-16f2-606f-d3a2-61fef5b0a704@redhat.com>
 <d66681f3-8781-9793-1dcf-2436a284550b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d66681f3-8781-9793-1dcf-2436a284550b@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Waiman Long <longman@redhat.com> wrote:

> diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
> index b0d0b51c4d85..1fd82ff99c65 100644
> --- a/include/linux/lockdep.h
> +++ b/include/linux/lockdep.h
> @@ -99,13 +99,8 @@ struct lock_class {
>  	 */
>  	unsigned int			version;
>  
> -	/*
> -	 * Statistics counter:
> -	 */
> -	unsigned long			ops;
> -
> -	const char			*name;
>  	int				name_version;
> +	const char			*name;

'name' gets moved by the patch - better structure packing on 64-bit kernels?

Looks good to me otherwise.

Thanks,

	Ingo
