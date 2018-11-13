Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63963C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 15:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D33B20896
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 15:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sHEsZ1Oc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D33B20896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388041AbeKNBrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 20:47:09 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44780 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727719AbeKNBrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 20:47:08 -0500
Received: by mail-qk1-f195.google.com with SMTP id n12so20145653qkh.11
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 07:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6ZLwpJCfax7mWUNNT7OyXB3bs2bMqSH3wUfjESFGnjo=;
        b=sHEsZ1OcgZUgsXOd1LS/AtteiPCJLHaEjIH92LpTkG/qqQ2Bl3AtIDnI0Yl/ZnhfRF
         TV/c+sHvAeBR6kJN/6kNr/SrFoJ/nJTsTmLSis3Vt040/Jz5G1jLGZIXH4JoUZARDZex
         vKLjuRCp0pl6Rn1iHx6+bvrborJXQ+UyLfEiuhdzPCRpULmM2GqNBJkXuxbdywmxRdfq
         8Au1xuHnxPtUAMt+OKIUDlDAj9F1Vb1q0OL7ka+tOjebAy3P2bqVHEiGFxzaFcnixCXP
         WnU0p+1J9egSsB3VlgA/s3n7OvdV5rjVHZ2gZuJZRUYSA02MALbjBawC+auVm7OhJ+14
         TGeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=6ZLwpJCfax7mWUNNT7OyXB3bs2bMqSH3wUfjESFGnjo=;
        b=TDSnQcaHsvhqCFb+aAQF37yKWuzSQwRkXVrkF0+06Soa+VjnWbDDmEQS5Us64dLv09
         GC/4rBvOfJOB1hIcFWnBUS7vnaoOQr/D2Q9ESYvcFlVRd6q5E+AAtz/haV7S2/1l31cp
         Ld5is4iMaN7AkfUAATgAKDn+3wxurZo/e4OGc/lZ0lpLX1Wq2HRZ9LlHx2q1rgf9SHIv
         REPzcdfsFhfIuZjo23sqKbcyoYe2dn/Ou2hCckeBFitiNPDtYiZKcKmOfnGVRKbIfMwK
         KiVj3xEbSTkuMgxWrCCa0/PtJ+rL/9VzYicBMmjzNfUgVVUeM03WLVBAnni/t/q7Zg+5
         /evw==
X-Gm-Message-State: AGRZ1gIedIJ5SB6Lz2eHj0KkdsB2NVX0TaUo1iUjgQ5QzvqRgmDRri8M
        +8Qc5Ef0rJH5NL1cHDaWhAQ=
X-Google-Smtp-Source: AJdET5eiI6mxRvFVFKqusRLyLUskw/a6HvO3ZBDB7skLCWaHIf5NaK9QQfeVe4XYM1f/tbpRzakXyg==
X-Received: by 2002:a37:8e81:: with SMTP id q123mr5358821qkd.34.1542124108877;
        Tue, 13 Nov 2018 07:48:28 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::6:e2a7])
        by smtp.gmail.com with ESMTPSA id p31sm13320425qkh.86.2018.11.13.07.48.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 07:48:27 -0800 (PST)
Date:   Tue, 13 Nov 2018 07:48:25 -0800
From:   Tejun Heo <tj@kernel.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH tip/core/rcu 27/41] percpu-refcount: Replace
 call_rcu_sched() with call_rcu()
Message-ID: <20181113154825.GH2509588@devbig004.ftw2.facebook.com>
References: <20181111194104.GA4787@linux.ibm.com>
 <20181111194410.6368-27-paulmck@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181111194410.6368-27-paulmck@linux.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 11:43:56AM -0800, Paul E. McKenney wrote:
> Now that call_rcu()'s callback is not invoked until after all
> preempt-disable regions of code have completed (in addition to explicitly
> marked RCU read-side critical sections), call_rcu() can be used in place
> of call_rcu_sched().  This commit therefore makes that change.
> 
> Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Jens Axboe <axboe@kernel.dk>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
