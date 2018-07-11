Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF36C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 17:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2281C20870
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 17:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cz7E2fRh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2281C20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389095AbeGKRzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 13:55:08 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:33859 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733203AbeGKRzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 13:55:08 -0400
Received: by mail-qt0-f196.google.com with SMTP id m13-v6so21808993qth.1;
        Wed, 11 Jul 2018 10:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NeGXoR8z44F7IqX2W2+SCPz8Ki85jqIZ9XhKRi3d7Cs=;
        b=Cz7E2fRh+SxU3POQD7g4SnSEw6+Q6VXkOLlmL3BxaIRq3XjGKSzE+ZvekuhHo4MJcT
         KqgYegWecbHoUZQy5+2W9qRp3P94ftBvg7G0CNDHKu0VUaGDMEzSqfqgSSQa7xot+qB6
         Z/PT/Hp/eiiD8d7MMqjigSKU1p4oVVIaVo3FmRiDGuYiNir7+UjcLARJQCMvrtcBKtxa
         EKz0x9BZvUGDhGyufyJRCfH+Gs08czwAM3XGwjt/C89JO2xIS9672OLq9hWeAVzyEjTo
         KquUvmj44BWdXSThl70CkakJMPWz4JkWfi9ANvvfHRlXkjADe9uchFnknOFT1yEUkHnx
         ASMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=NeGXoR8z44F7IqX2W2+SCPz8Ki85jqIZ9XhKRi3d7Cs=;
        b=gO98k22T/IyvumXxkGRuKQV9GBzFFEo2H4l+nnHH09LRsOMs9yeI8z1SQJuuqDBZ1p
         4izNEss/IE73Mouq3ooqQ6PG6F7ZlIf/aXBRZdvrCFQaWNz0Gv43SaMTqA1wW92YnWCp
         7LO3koFk6yRwl+1iYNNezFYUPg1KclqbkQq59SnLM2TUhgXfgQdlyrJHWdZPUs2dGCJn
         +/TovOAkYZOqFDR94y7kJoC0KquF1poKn33tBi8If+LG0TQUV97D5FqWdKMrRturbnCn
         rZw/UyM1s3xP2slEMEZQaVupyKNmIMzQf7ecnb8/oizKUwHs3PhVuMpOclY7HBAWHoNu
         1XPw==
X-Gm-Message-State: AOUpUlFvbH3C1D6W7SzXTFRjFVMWaKakINmwNGe8rKX+5/5boi6WHesS
        /FjiP50hyCBFVVE21/CUVAfTmjiD
X-Google-Smtp-Source: AAOMgpd30aOM7W+UxJf/IhYUES0NNvU1WBn2fkilVbqQUgMyUq4nef0XCjOBYGTzklQXBRrVvrhqqg==
X-Received: by 2002:a0c:99ec:: with SMTP id y44-v6mr291291qve.226.1531331383083;
        Wed, 11 Jul 2018 10:49:43 -0700 (PDT)
Received: from localhost ([2620:10d:c091:180::1:7350])
        by smtp.gmail.com with ESMTPSA id m4-v6sm16124158qtm.79.2018.07.11.10.49.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 10:49:42 -0700 (PDT)
Date:   Wed, 11 Jul 2018 10:49:40 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, cgroups@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] cgroup/tracing: Move taking of spin lock out of trace
 event handlers
Message-ID: <20180711174940.GH72677@devbig577.frc2.facebook.com>
References: <20180709174854.74a30b57@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709174854.74a30b57@gandalf.local.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 05:48:54PM -0400, Steven Rostedt wrote:
> From: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> It is unwise to take spin locks from the handlers of trace events.
> Mainly, because they can introduce lockups, because it introduces locks
> in places that are normally not tested. Worse yet, because trace events
> are tucked away in the include/trace/events/ directory, locks that are
> taken there are forgotten about.
> 
> As a general rule, I tell people never to take any locks in a trace
> event handler.
> 
> Several cgroup trace event handlers call cgroup_path() which eventually
> takes the kernfs_rename_lock spinlock. This injects the spinlock in the
> code without people realizing it. It also can cause issues for the
> PREEMPT_RT patch, as the spinlock becomes a mutex, and the trace event
> handlers are called with preemption disabled.
> 
> By moving the calculation of the cgroup_path() out of the trace event
> handlers and into a macro (surrounded by a
> trace_cgroup_##type##_enabled()), then we could place the cgroup_path
> into a string, and pass that to the trace event. Not only does this
> remove the taking of the spinlock out of the trace event handler, but
> it also means that the cgroup_path() only needs to be called once (it
> is currently called twice, once to get the length to reserver the
> buffer for, and once again to get the path itself. Now it only needs to
> be done once.
> 
> Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Applied to cgroup/for-4.19.

Thanks.

-- 
tejun
