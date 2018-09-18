Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCFC0C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 12:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A5CF2146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 12:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdNlpDYL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A5CF2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729666AbeIRSVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 14:21:42 -0400
Received: from mail-yw1-f52.google.com ([209.85.161.52]:45359 "EHLO
        mail-yw1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbeIRSVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 14:21:41 -0400
Received: by mail-yw1-f52.google.com with SMTP id p206-v6so692346ywg.12;
        Tue, 18 Sep 2018 05:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NTGut8/9fAU/AkL2ZQdzd38/N8jqCnc53mU70MNv0+U=;
        b=FdNlpDYLJbn9Nezh8Af9hqyqtHPbfUnfvk76/6gnEl347NvgT2AjBin9cohBsANKZ2
         yRqlkQGgL8jRJwgkcikX0GAlZA3QQymKWLQ9jbGFbD26Nyu9Kf0UCQih+4aN3Lana/MZ
         tgFrIsvzsOChTo4cT/YOQNiY39UpF6RXwCvE9dsB5aHSjKLyh5Zv1684dGCM6ytbJZZ+
         BqXQyRzHtZ4j3hw82X7xgbvEdGkVXfDZT2KBw7YRymgAtqX3YP7UAyi/GxvvQTk6WFSg
         4AFruG2PlwebVif47FWTp/1svwM4AlAT5ENTV2DP5rjJLCsMMrc3zpN6oXBLgVVB6rW3
         +/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=NTGut8/9fAU/AkL2ZQdzd38/N8jqCnc53mU70MNv0+U=;
        b=IWm9wTuW8tRPe2aASzc6cc4PGMJxQDX4oR0o124G98qj/SGdTPpGo6OQpNlMZuGCVK
         9J3UXwF9U8+3M/7PU4FayLjnfVudUddFehVRGSOsH/oEQTcize65hThigMqO9MqnGiCJ
         6Ut8fK0GY20fvN9GljoVg7Fqq2W+T21gHRETYGowVtjgMYPCNzxrWOuc8MSGLA2h17T6
         nblizRmWr8jRlohIizv5tevKPUdKhnDBdoeIySkVrpBYbxVg4Tk3SEHL6ePPAQY6Vc03
         67Ls50/Hler8fvd/MFnu37XF1oiZkKFN774MDM2EktWtyshvv8C0E6cyxvqldPcOQzQQ
         SR9A==
X-Gm-Message-State: APzg51Aq69WS+dHquJHJVIgbUuxCd87zOdYmmj/wN4jE6qPeozrZpBcj
        zYhFf5EQZgsVj1vQd1gVibs=
X-Google-Smtp-Source: ANB0VdZiRdL/GH61PlDq8iE8YTipwBYrADCsNuejkkDmTk/5DMlA+YCOcZqBF5hR/8sHVXjXRiSeJw==
X-Received: by 2002:a81:3507:: with SMTP id c7-v6mr12013182ywa.186.1537274954113;
        Tue, 18 Sep 2018 05:49:14 -0700 (PDT)
Received: from localhost ([2620:10d:c091:180::1:6613])
        by smtp.gmail.com with ESMTPSA id w80-v6sm1013931ywd.55.2018.09.18.05.49.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 05:49:12 -0700 (PDT)
Date:   Tue, 18 Sep 2018 05:49:09 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] percpu-refcount: relax limit on percpu_ref_reinit()
Message-ID: <20180918124909.GA902964@devbig004.ftw2.facebook.com>
References: <20180911134836.GG1100574@devbig004.ftw2.facebook.com>
 <20180911154540.GA10082@ming.t460p>
 <20180911154959.GI1100574@devbig004.ftw2.facebook.com>
 <20180911160532.GB10082@ming.t460p>
 <20180911163032.GA2966370@devbig004.ftw2.facebook.com>
 <20180911163443.GD10082@ming.t460p>
 <20180911163856.GB2966370@devbig004.ftw2.facebook.com>
 <20180912015247.GA12475@ming.t460p>
 <20180912155321.GE2966370@devbig004.ftw2.facebook.com>
 <20180912221139.GB15810@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912221139.GB15810@ming.t460p>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Ming.

Sorry about the delay.

On Thu, Sep 13, 2018 at 06:11:40AM +0800, Ming Lei wrote:
> > Yeah but what guards ->release() starting to run and then the ref
> > being switched to percpu mode?  Or maybe that doesn't matter?
> 
> OK, we may add synchronize_rcu() just after clearing the DEAD flag in
> the new introduced helper to avoid the race.

That doesn't make sense to me.  How is synchronize_rcu() gonna change
anything there?

> > > 4) after the queue is recovered(or the controller is reset successfully), it
> > > isn't necessary to wait until the refcount drops zero, since it is fine to
> > > reinit it by clearing DEAD and switching back to percpu mode from atomic mode.
> > > And waiting for the refcount dropping to zero in the reset handler may trigger
> > > IO hang if IO timeout happens again during reset.
> > 
> > Does the recovery need the in-flight commands actually drained or does
> > it just need to block new issues for a while.  If latter, why is
> 
> The recovery needn't to drain the in-flight commands actually.

Is it just waiting till confirm_kill is called?  So that new ref is
not given away?  If synchronization like that is gonna work, the
percpu ref operations on the reader side must be wrapped in a larger
critical region, which brings up two issues.

1. Callers of percpu_ref must not depend on what internal
   synchronization construct percpu_ref uses.  Again, percpu_ref
   doesn't even use regular RCU.

2. If there is already an outer RCU protection around ref operation,
   that RCU critical section can and should be used for
   synchronization, not percpu_ref.

> > percpu_ref even being used?
> 
> Just for avoiding to invent a new wheel, especially .q_usage_counter
> has served for this purpose for long time.

It sounds like this was more of an abuse.  So, basically what you want
is sth like the following.

READER

 rcu_read_lock();
 if (can_issue_new_commands)
	issue;
 else
	abort;
 rcu_read_unlock();

WRITER

 can_issue_new_commands = false;
 synchronize_rcu();
 // no new command will be issued anymore

Right?  There isn't much wheel to reinvent here and using percpu_ref
for the above is likely already incorrect due to the different RCU
type being used.

> > > So what I am trying to propose is the following usage:
> > > 
> > > 1) percpu_ref_kill() on .q_usage_counter before recovering the controller for
> > > preventing new requests from entering queue
> > 
> > The way you're describing it, the above part is no different from
> > having a global bool which gates new issues.
> 
> Right, but the global bool has to be checked in fast path, and the sync

That likely bool test isn't gonna cost anything.

> between updating the flag and checking it has to be considered. Given
> blk-mq has already used .q_usage_counter for this purpose, that is why
> I suggest to scale percpu-refcount to cover this use case.

And the synchronization part should always be considered and is
already likely wrong.

Thanks.

-- 
tejun
