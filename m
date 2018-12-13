Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DFBAC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21DED2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544717250;
	bh=SfrhN3Qw6iyn7jcqfFmWLU6iEtp+I2b/T1VauRpxsoI=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=OR34saSR1InZRALWxdKvLjxRe0lJ0KmHrHHWO4H63YThj8SJl4TUb5LJfkSv2bxmk
	 8xN819ZSQ7+wgEdVFGlw/iOXoBbZBKslhu/2Denjh70eFwJrmO7a+rCj3hlatlF3K5
	 JSsnzAXdAbG4+6AURXhRmSS/8NFOUGm5vQvfo4sQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21DED2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729205AbeLMQH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 11:07:29 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:43287 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728111AbeLMQH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 11:07:28 -0500
Received: by mail-yb1-f194.google.com with SMTP id d136so991759ybh.10;
        Thu, 13 Dec 2018 08:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VMIvv9oJ+d07z3QLhR1Tb2CkKzGyeqd0I0xBtqS1Vdo=;
        b=DJCdmOKH4EV3o9DYzEMgupaZtPGPMc3U7+H6RJbn/9fNmfWytE01k2XQA9rg1L1wmt
         653dRwOtcYmSO9QX51AbyrqfpbfB1Za+5ibAPxqeMixThQ4Og21n5RvUu7oaRA+w3uz+
         Bzs/bgXVdeeLyPjNSY8AY1mnl5dJqSbOQqI2SSxJyLwknRrI+klu7CLG7sdLGOya/u1W
         W/+aVtAc63k6ks+NMgeGTMLwECt7g3deILYkEbJoicYAIPrHhqU3IJHZnFgUIQvpTLdo
         b1grkuYz+1nwQpEHm6iRwihqcbe73hhzS7eN7i4A6tU8dG9jBnPXGXMJjtlNx3lScPZQ
         ZiOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=VMIvv9oJ+d07z3QLhR1Tb2CkKzGyeqd0I0xBtqS1Vdo=;
        b=U/ax9G0e3FDChzH/h5iEqo+OQBvkFxwPOvk50RFesolF+Yp2rG/pqr7A5+11Xnq+rm
         WeRKAN14DXYvUB/yRDxLuC3qmwNhfJFude842tI5J9Fpbicz02Ju3EciBsPuCsVmGQzF
         ZG9IB/OeqRyiTAHgG6MTFSxqAGZxrBf+AaQnurUk8myk6xL9ikHQE1Di0rE9w3OG5IMf
         oxdHYhne78XjMnvQKdDfedBkckDgVLZ/yTJF5yFsJNaF2tz426CLi8Tiz+JTl3QmxNqx
         Mnnwd79zPkc2ffROdI5IXvJF/IO0XZvNzc23N5mgelsN6SGnsYvDla1ux7cqtnsk4MAv
         hIaA==
X-Gm-Message-State: AA+aEWZtiKk2Ci3AvPhmoozFzE7RlsY5mtXv67OnFbPI+V7buVVdkJzW
        bFHBVPkbclClu8DpEpWO7awyUMVq
X-Google-Smtp-Source: AFSGD/XaHnhA8puaqhQL5SyS3/Oa1AVoVClV3l3jcTQNkawebs0DXuDFa4XWwAH40gQyD7Ig8p/rlA==
X-Received: by 2002:a25:8446:: with SMTP id r6mr24548364ybm.474.1544717246882;
        Thu, 13 Dec 2018 08:07:26 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::4:b482])
        by smtp.gmail.com with ESMTPSA id l9sm770910ywc.81.2018.12.13.08.07.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 08:07:25 -0800 (PST)
Date:   Thu, 13 Dec 2018 08:07:24 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Michael Cree <mcree@orcon.net.nz>, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, debian-alpha@lists.debian.org
Subject: Re: Generic kernel fails to boot on Alpha bisected to b38d08f3181c
Message-ID: <20181213160724.GU2509588@devbig004.ftw2.facebook.com>
References: <20181213082612.bi2dcd6uhzp3t6iq@tower>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213082612.bi2dcd6uhzp3t6iq@tower>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Michael.

On Thu, Dec 13, 2018 at 09:26:12PM +1300, Michael Cree wrote:
> A kernel built for generic UP Alpha had been noted to fail to boot
> for quite some time (since the release of 3.18).  The kernel either
> locks up before printing any messages to the console or just falls
> back into the SRM with a HALT instruction again before any messages
> are printed to the console.  A work around is to either use a kernel
> built for generic SMP or to build a machine specific kernel as these
> boot correctly.
> 
> Because there were other compile errors at the time it proved
> difficult to bisect, but we are continuing to get complaints about
> it as it renders the Debian Alpha installer somewhat useless, so I
> returned to trying to find the problem and managed to bisect it to:
> 
> commit b38d08f3181c5025a7ce84646494cc4748492a3b
> Author: Tejun Heo <tj@kernel.org>
> Date:   Tue Sep 2 14:46:02 2014 -0400
> 
>     percpu: restructure locking
> 
> Any suggestions as to what might be the problem and a fix?

So, the only thing I can think of is that it's calling
spin_unlock_irq() while irq handling isn't set up yet.  Can you please
try the followings?

1. Convert all spin_[un]lock_irq() to
   spin_lock_irqsave/unlock_irqrestore().

2. If that still doesn't work, just convert all of them to
   spin_lock/unlock(), which is obviously broken but still is useful
   for debugging.

Thanks.

-- 
tejun
