Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44BBC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 15:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D76B20844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 15:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="ItK8sIVO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D76B20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbeIGTvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 15:51:19 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:37901 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728248AbeIGTvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 15:51:19 -0400
Received: by mail-yb1-f196.google.com with SMTP id e18-v6so5572288ybq.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 08:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TaAYZ9snpOcizEPrlLp2rv+nViYTbC2PtsByXxBogJk=;
        b=ItK8sIVOrcLoFfAyx9kSiK5UqRyUu1Sg1tovdm35w1X0tDNpzKQfFyv3oChOJfdep6
         A/6iN8Xk8OAEMGbJVF785TEs3JeM+dk3+XAMgqSVrGYBItxP3APTS7CpTEUbw4w3m8Ai
         dfkH3U5JiIpKVN8tkDfQRPHtkmSZzxevwPMNCUWK2Q/PIb9xiZoHHRA2+Pqtw4IXWAHH
         DxCNeFaFrl1W/eA1SwgLWaD5OBoZdU6Y91hq4YDiH1EZ34oLZd6f+UBqYWANXGSj7Ria
         TnmAjtKSh4UAeEG2U10a8eXtJkIpkqZNK0QBt7ZuajFXMT3A5eH+bZpFk+J7eBMh/kZs
         1mIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TaAYZ9snpOcizEPrlLp2rv+nViYTbC2PtsByXxBogJk=;
        b=Wc7Cqzl93gVRMUD3RmfdMOqj/3foJ33mqwLEdPx+f9NyZ4rmZSoEn21gyMviDg2mN1
         Qau+Dky2XXCZigwhLfnAXAD0lfpELj58v7ApaBJ+llwh+an2MrC9XY7+M/sPYlAEDqqY
         fKXlBouplhK5vjFEehZeoY4Zgwmw8/jS0IX/MP3UMda4Z0UE1H7Szvj2FhhGqoPwQFdp
         fPz3N/QcQOlj9Bia7wlQWXSf9QK9ImV5zlaqhn2jZ4Y3F/jdDec4170sSkPc1gmYlE/T
         8HHxnF4lNkDAEbF2xK4il7UdUrfLHUfkkSCQWIr1UGkRIf+iOw+p3qkJnviwvddSrPUF
         g3UQ==
X-Gm-Message-State: APzg51CH9u1v6uSOCQ65ei/mwa24gVeeGRNhfZba6veSdcZiYrQb/2bt
        YIcY0OMuBVAVE60kcZNxXVlQ1Q==
X-Google-Smtp-Source: ANB0VdacjviL7/expV7dlzxm7OCdgFyIm3feUzK3fyPT4AynIpvyMzJifI/U8vqzlag+OA3OHyBmxw==
X-Received: by 2002:a25:7911:: with SMTP id u17-v6mr4192824ybc.3.1536332998148;
        Fri, 07 Sep 2018 08:09:58 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::1:96d9])
        by smtp.gmail.com with ESMTPSA id g131-v6sm3562603ywh.70.2018.09.07.08.09.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Sep 2018 08:09:57 -0700 (PDT)
Date:   Fri, 7 Sep 2018 11:09:55 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Drake <drake@endlessm.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Christopher Lameter <cl@linux.com>,
        Peter Enderborg <peter.enderborg@sony.com>,
        Shakeel Butt <shakeelb@google.com>,
        Mike Galbraith <efault@gmx.de>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 0/9] psi: pressure stall information for CPU, memory, and
 IO v4
Message-ID: <20180907150955.GC11088@cmpxchg.org>
References: <20180828172258.3185-1-hannes@cmpxchg.org>
 <20180905214303.GA30178@cmpxchg.org>
 <20180907110407.GQ24106@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180907110407.GQ24106@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 01:04:07PM +0200, Peter Zijlstra wrote:
> So yeah, grudingly acked. Did you want me to pick this up through the
> scheduler tree since most of this lives there?

Thanks for the ack.

As for routing it, I'll leave that decision to you and Andrew. It
touches stuff all over, so it could result in quite a few conflicts
between trees (although I don't expect any of them to be non-trivial).
