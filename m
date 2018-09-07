Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C13C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 20:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF92C20645
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 20:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fi5BZCbD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF92C20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbeIHBHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 21:07:08 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:42143 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbeIHBHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 21:07:08 -0400
Received: by mail-yw1-f66.google.com with SMTP id n207-v6so5831339ywn.9;
        Fri, 07 Sep 2018 13:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9Be7dN/R3NmgXTLGeqjDknniy0VbvWrwupfeyuN8MtY=;
        b=Fi5BZCbD/RuA31kGNB5SuFrZOqg1t4x5mPxOMSGiCliq2q5gQSK71QKHHPCtSTuYGO
         VfNXsPt6cK2rZr4yx5miWrREB+I8ddjTCOYKoZoWHLMr5KxocUsQUSELbUP30mciOKJC
         t4W1ASAmwKr5+J+5kH/IqfWjyzXjA3dcG4YF5tx716jnhcrm2xDonaSiiT2ZKERX9wo0
         DXAqmGui/VuKX6AO9Wei4913hBQtD2Vgy2KKzVEN1YYxVlOVKyDLxjY1dpiasgzqBP2H
         gA84orufmobC7NqJd/Qxs4EE+WO6bBVpGErstfR3aTb8642HVDTUrpHCiWdMubiRbbNO
         4rdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9Be7dN/R3NmgXTLGeqjDknniy0VbvWrwupfeyuN8MtY=;
        b=B601uy5l5j/7M2oZQ8D4QmqUdfzCoJNtNvjfo4B5v1ps5YpZKE033wGjpKM1vSGWwQ
         NoHmXMzdkTyC25zD1G+sddc0P9/kk12z9XBSB4iI5PhFpf8fl8H1CE2Yvelz8D9Q32j2
         oJaq0UwI9nJvnhzkVTWADeR550zqKAdMIR3eYl1nR3AkLcKkzK1yyZBvua1TuKEv5g1R
         8NYWDSs7gCkybj+ekwyC0GSYoAWX1THOIRtyHqnPUn+4ajKytadG01gNk3Vk+27MC/Lm
         UnQB99tdKXOFZS97a/JHnJDejwvH4GmR57TVAePM59PjWuLDEPiRJi0cmo7/zSUzOJnO
         QZsg==
X-Gm-Message-State: APzg51DFlCFQzyo1VjsHAoA/PgK0CbBkINFHvn71yHXBfaua5i56pTM8
        Yu2F0XiBVSdJaIhzJFEZB2s=
X-Google-Smtp-Source: ANB0VdZLSoB5S2NT0Bw/AVbJ3jkUg2O/W4m6FHEYfwrKQT63srh/Nh6MRWzbsI+THRkFNZPyddIjSA==
X-Received: by 2002:a0d:d40d:: with SMTP id w13-v6mr5269212ywd.352.1536351873107;
        Fri, 07 Sep 2018 13:24:33 -0700 (PDT)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:200::9697])
        by smtp.gmail.com with ESMTPSA id r69-v6sm3131114ywh.44.2018.09.07.13.24.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 13:24:32 -0700 (PDT)
Date:   Fri, 7 Sep 2018 16:24:30 -0400
From:   Dennis Zhou <dennisszhou@gmail.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/12] blkcg: remove additional reference to the css
Message-ID: <20180907202429.GA97913@dennisz-mbp.dhcp.thefacebook.com>
References: <20180906211045.29055-1-dennisszhou@gmail.com>
 <20180906211045.29055-10-dennisszhou@gmail.com>
 <20180907175446.GC1100574@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180907175446.GC1100574@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 10:54:46AM -0700, Tejun Heo wrote:
> Hello,
> 
> On Thu, Sep 06, 2018 at 05:10:42PM -0400, Dennis Zhou wrote:
> > +struct cgroup_subsys_state *cgroup_e_css(struct cgroup *cgrp,
> > +					 struct cgroup_subsys *ss)
> > +{
> > +	struct cgroup_subsys_state *css;
> > +
> > +	rcu_read_lock();
> > +
> > +	do {
> > +		css = cgroup_css(cgrp, ss);
> > +
> > +		if (css)
> > +			goto out_unlock;
> > +		cgrp = cgroup_parent(cgrp);
> > +	} while (cgrp);
> > +
> > +	css = init_css_set.subsys[ss->id];
> > +out_unlock:
> > +	rcu_read_unlock();
> 
> Nothing protects @css here tho.  It can be released before the caller
> is done with it.  The caller must ensure that it's holding rcu read
> lock to protect the lookup and the subsequent uses.  cgroup_css()
> already checks for rcu locking, so if you just drop
> rcu_read_lock/unlock(), everything should work fine.
> 

Ah yes, that's my bad. I've removed it and the unnecessary goto now.

Thanks,
Dennis
