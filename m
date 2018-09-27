Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A47AC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8704215E5
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:30:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="yj8WEaQW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8704215E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbeI0Rse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 13:48:34 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:53597 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbeI0Rsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 13:48:33 -0400
Received: by mail-wm1-f43.google.com with SMTP id b19-v6so5541159wme.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 04:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qVaYBM2/NQhYa4ilmkQ4ShY6tgKAh7gZu8tgP7jc6hA=;
        b=yj8WEaQWvRoTJ6hJqRA/wnsBnFkOGuB9bIe6Et1JmkWK8huwvWgD+UVlywI8gvi7DS
         fa+76f6dxDYnBm0+5xVquguC0O5CNm4QnD14CDIVqUs4pGfYIBGCVENn+UKORWN3i5zY
         yKqpeDfUouTA1oIVWqzWDcxT7BMUT+3UObQHONf3Jld4IOxZB1I01ahe3cmrwdQwOQI2
         mNxFvrQIOa6ps25Bl+P3wdnIqq4R+rrO75IVB1WaDmVm+cR/63n2B7pftn3AjMtexpy0
         ZaBi0KUWpKzfraKxHxe9Y2ogsi7oVx7bT8q7d8OFtcp8x+UcIxzaj1Bpnp74YTYaxKno
         VDTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qVaYBM2/NQhYa4ilmkQ4ShY6tgKAh7gZu8tgP7jc6hA=;
        b=jCxjoegJXePRKcEZvqXa6m6qryN/aqgelMMks0PWf86tsui9iJtHoGKi5Fv3FgxFca
         0KHfs3VsZ4v/W0amzq7Q1OyZl0JtmO9jNhcAzpUTF06aaG4liEdppD4cT68nD3m7PoHo
         hn067jSdZ3CNOOEa5j324+rbe5CkHnfiePQy+CbT3J92CM9neWZMZigc9QxGi6FiXixW
         5iH5ZDEHwwwde7nkU2WWcuACfk+oD3/LvM0kAoD27p+jfAu+JTSxCzoSD6zp4H+XadFP
         rwhazkhDMR2ub/QAPRvSxMECj4gfbKhoGCd3xsECfhZgO/94+zSMxr+5Xrw2txSTLb10
         CtaQ==
X-Gm-Message-State: ABuFfojGnS7QSC2cxsa3kBLyBpdiNrFgYIzdutkkHybUHOoxv6lX/2ww
        akJ32utO0mlsBICIOi1K93YwWmav6wDUlQ==
X-Google-Smtp-Source: ACcGV63pDqCcOHtj2aP3AgWt0wUQGodwTtMymXwF/HiPCcZUKREtwe7M+aTolfZSND+PQApvRpdzvw==
X-Received: by 2002:a1c:ef15:: with SMTP id n21-v6mr5951922wmh.151.1538047842688;
        Thu, 27 Sep 2018 04:30:42 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain (mm-66-208-122-178.brest.dynamic.pppoe.byfly.by. [178.122.208.66])
        by smtp.gmail.com with ESMTPSA id 144-v6sm2685808wma.19.2018.09.27.04.30.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 04:30:41 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id D3C61300029; Thu, 27 Sep 2018 14:30:40 +0300 (+03)
Date:   Thu, 27 Sep 2018 14:30:40 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        Andrea Argangeli <andrea@kernel.org>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Stefan Priebe - Profihost AG <s.priebe@profihost.ag>,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: linux-mm@ archive on lore.kernel.org (Was: [PATCH 0/2] thp
 nodereclaim fixes)
Message-ID: <20180927113040.buzebfcooivxsu5d@kshutemo-mobl1>
References: <20180925120326.24392-1-mhocko@kernel.org>
 <20180926130850.vk6y6zxppn7bkovk@kshutemo-mobl1>
 <20180926152523.GA8154@chatter>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926152523.GA8154@chatter>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 11:25:23AM -0400, Konstantin Ryabitsev wrote:
> On Wed, Sep 26, 2018 at 04:08:50PM +0300, Kirill A. Shutemov wrote:
> > On Tue, Sep 25, 2018 at 02:03:24PM +0200, Michal Hocko wrote:
> > > Thoughts, alternative patches?
> > > 
> > > [1] http://lkml.kernel.org/r/20180820032204.9591-1-aarcange@redhat.com
> > > [2] http://lkml.kernel.org/r/20180830064732.GA2656@dhcp22.suse.cz
> > > [3] http://lkml.kernel.org/r/20180820032640.9896-2-aarcange@redhat.com
> > 
> > All these links are broken. lore.kernel.org doesn't have linux-mm@ archive.
> > 
> > Can we get it added?
> 
> Adding linux-mm to lore.kernel.org certainly should happen, but it will not
> fix the above problem, because lkml.kernel.org/r/<foo> links only work for
> messages on LKML, not for all messages passing through vger lists (hence the
> word "lkml" in the name).

What is the reason for the separation? From my POV it's beneficial to have
single url scheme to refer any message in the archive regardless of the
list.

-- 
 Kirill A. Shutemov
