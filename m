Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 640F0C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1686C20B6F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="QIfs2AS+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1686C20B6F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732713AbeGKLRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 07:17:05 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:37864 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732387AbeGKLRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 07:17:05 -0400
Received: by mail-lf0-f67.google.com with SMTP id j8-v6so20957775lfb.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 04:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=krUDVRGc6V1+89a4VQ/P1sYf27tDMKEF+Ye9qfQqHwM=;
        b=QIfs2AS+5ETjWOdEbOtWUMKknz825Kcfy1S60Pa9FsehZCuTK/KpicqYihljKYN5zP
         hVLi+dslDNWD1s+L2Mt5t3MjghSnJugo2ylQrA+PhZrBeoFGwihZvB3rQFZDsKijZ+XL
         3wI+TqkZgcpVkZp3DQG1YUBivV6GXgREwPSpcaO2j3lam6Xfv+bfJZCUNpiQd4WfJPcE
         bZbXMTyF68Mv6RzbtZ6Bp5KqGVGAZQFX7/GDiZQ8p5A5iGvyVzZRQ/nmXJ8fPpQxiUrC
         gYyhrgi+BkHnP8D7el9VkvLXIXTwLNmyxfNMXxFCaV2j3nDCA1hNWat8KtRvz3+H6NNV
         q8Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=krUDVRGc6V1+89a4VQ/P1sYf27tDMKEF+Ye9qfQqHwM=;
        b=F5uLx/zjjmwP1NjzhM7XG8zIKXdpZvHTEXv6Jd/tR1LGjG0I5rtYcWSKR7hHYRRmsq
         5dvWQEKVSg/fnYzTAsnj08w2bWVIQn4SalZOtsG2u9i+6M+JHe/oFun+GFcPl+SjfjLe
         Gl5JOYaILJ7L07VF4bXjeSuY4H7SrZ4pj7wzlybnNeJC+XN5w3Dzh8x/fqjDb0PcFzs8
         V1Y71ToYxAV97AehfOXjvZEXbHM5DAu3YEpOSActtn6z/Z/c8Z+pDagwwiXcW5yyL0ri
         +XVn98xtBP1OkQfxDITy+hJweW5RKw8x1i+GeL8iq6JJu08Mi0tAKEM/LsEfuf1v2i1c
         ctSQ==
X-Gm-Message-State: AOUpUlEq4r5OorINXTXoW8n2J5L0zqTTjbI8CRS+q9eSZqcdP8BQ904o
        JWPXr/WiusfXmINmUJ+XFSY/gw==
X-Google-Smtp-Source: AAOMgpcjWy3vJfsvkpX/cfRmK8f9NHKt1UQPSk0aSHNF/r4MGuk4aj2s5i17i1ZYfX1p/IF05OqdbQ==
X-Received: by 2002:a19:e307:: with SMTP id a7-v6mr730094lfh.125.1531307595171;
        Wed, 11 Jul 2018 04:13:15 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain (mm-114-95-122-178.brest.dynamic.pppoe.byfly.by. [178.122.95.114])
        by smtp.gmail.com with ESMTPSA id k77-v6sm4110075lfi.46.2018.07.11.04.13.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 04:13:14 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 251E530029D; Wed, 11 Jul 2018 14:13:12 +0300 (+03)
Date:   Wed, 11 Jul 2018 14:13:12 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Yang Shi <yang.shi@linux.alibaba.com>, willy@infradead.org,
        ldufour@linux.vnet.ibm.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC v4 0/3] mm: zap pages with read mmap_sem in munmap for
 large mapping
Message-ID: <20180711111311.hrh5kxdottmpdpn2@kshutemo-mobl1>
References: <1531265649-93433-1-git-send-email-yang.shi@linux.alibaba.com>
 <20180711103312.GH20050@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711103312.GH20050@dhcp22.suse.cz>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 12:33:12PM +0200, Michal Hocko wrote:
> this is not a small change for something that could be achieved
> from the userspace trivially (just call madvise before munmap - library
> can hide this). Most workloads will even not care about races because
> they simply do not play tricks with mmaps and userspace MM. So why do we
> want to put the additional complexity into the kernel?

As I said before, kernel latency issues have to be addressed in kernel.
We cannot rely on userspace being kind here.

-- 
 Kirill A. Shutemov
