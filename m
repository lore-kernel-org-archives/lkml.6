Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E726C46462
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 19:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D713420873
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 19:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bhfO7xvS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D713420873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbeG2U54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 16:57:56 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45838 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbeG2U54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 16:57:56 -0400
Received: by mail-lj1-f194.google.com with SMTP id w16-v6so4966360ljh.12;
        Sun, 29 Jul 2018 12:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=g120l+1kg1FvM93625X2HLCbuZ/cj28KpMCzCv6H4kk=;
        b=bhfO7xvSEvOjtMVR0cbM4dUCpJF3zsiWH/xeAfEICI0dpMBdNpxrJdjLI9hbU3pFf8
         r4v8H8Nm6DXVyDyqyifWqksTds3nY9GxXdnEfUPEm/gOGbTxb6FGY+qZaiOqg0XPVJ7f
         D1rFOaqEHXAhkPs1cfR5N92DVcyuv22FBPyG+jPKO8pfPWWKLtCo+ipG2wD64YZZc45a
         Y3QODYd0A0jHKrVyo8UdZyIw3HY7eLQmpKaLwtLrGUDIVv7/ggMBUf2LJc9f09q90x4w
         uugweW+4szHy1FsMBR8pKcBTB8hVMNZU5O6Qey3qmbUS7GuTcxRtWfCAflS+ObyDiWd9
         WMBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g120l+1kg1FvM93625X2HLCbuZ/cj28KpMCzCv6H4kk=;
        b=Y6xwWEqJye9+EcDzXykbcDYu/ppyhWbYvgUyDp9Rg2LC0SRmMa234tGUpyeypOdG0s
         B/LZbbK/Zp+h057S86t3mfTVPrIVh1j2QwY8kFbfLAduTBEvNuDqONoS0BHJvGy+UQ1q
         GT0kqvCdv9dlzCk4aRTV0LVAuYqg0V6+YHyDdZWl3pMjoxHKCLYhxqESNNqfHZWRq5om
         mQpjQYltk+5HesXoD5bk5uc8kybZ5gPtzn82g3AKmRWTvXVVSS/xvQs2sDL++d7VHO+c
         +ckptn6iHmRzjNHJswhJTkwbCfHwd2XTvzFyhMEHUoISnwp6uYO9nkrXOFYAkE+C3Mrn
         1vSA==
X-Gm-Message-State: AOUpUlE4g2KQJa0YdzZrewe7xrNPOReLCyl3oQmxWVHVa6yzWboMTF5S
        RpwwyQBpzfNj0mEvhQZ/HnQ=
X-Google-Smtp-Source: AAOMgpdhBBpy8UlEV7dYpkZYMu+KJu4QmY5cE5KxD2JX8UYYeQHBaGkS/g5IXSHphV/cvTWUlM/w8A==
X-Received: by 2002:a2e:9c0f:: with SMTP id s15-v6mr3962926lji.97.1532892385024;
        Sun, 29 Jul 2018 12:26:25 -0700 (PDT)
Received: from esperanza (81.5.99.119.dhcp.mipt-telecom.ru. [81.5.99.119])
        by smtp.gmail.com with ESMTPSA id m71-v6sm1691773lje.84.2018.07.29.12.26.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Jul 2018 12:26:23 -0700 (PDT)
Date:   Sun, 29 Jul 2018 22:26:21 +0300
From:   Vladimir Davydov <vdavydov.dev@gmail.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memcg: Remove memcg_cgroup::id from IDR on
 mem_cgroup_css_alloc() failure
Message-ID: <20180729192621.py4znecoinw5mqcp@esperanza>
References: <20180413112036.GH17484@dhcp22.suse.cz>
 <6dbc33bb-f3d5-1a46-b454-13c6f5865fcd@virtuozzo.com>
 <20180413113855.GI17484@dhcp22.suse.cz>
 <8a81c801-35c8-767d-54b0-df9f1ca0abc0@virtuozzo.com>
 <20180413115454.GL17484@dhcp22.suse.cz>
 <abfd4903-c455-fac2-7ed6-73707cda64d1@virtuozzo.com>
 <20180413121433.GM17484@dhcp22.suse.cz>
 <20180413125101.GO17484@dhcp22.suse.cz>
 <20180726162512.6056b5d7c1d2a5fbff6ce214@linux-foundation.org>
 <20180727193134.GA10996@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180727193134.GA10996@cmpxchg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 03:31:34PM -0400, Johannes Weiner wrote:
> That said, the lifetime of the root reference on the ID is the online
> state, we put that in css_offline. Is there a reason we need to have
> the ID ready and the memcg in the IDR before onlining it?

I fail to see any reason for this in the code.

> Can we do something like this and not mess with the alloc/free
> sequence at all?

I guess so, and this definitely looks better to me.
