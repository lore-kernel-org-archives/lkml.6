Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 751BBC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 22:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C5BF2087F
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 22:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2sb3uOV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbfADWEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 17:04:40 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43790 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfADWEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 17:04:40 -0500
Received: by mail-pg1-f195.google.com with SMTP id v28so18008273pgk.10;
        Fri, 04 Jan 2019 14:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=n9KKoy07FqMceGHLDf06eKMyV/ZGFogpP6+m44Yd7bE=;
        b=l2sb3uOVyz41p3U0Fdr5xZMAHQjrhfqXdnJw1DHB/ICiiaMspoAGZy1Q0xnnEgAg5i
         1CFfht5I8lmZLINJZyzQLDPOs55u4Ke4IEXQJtunzcv/uuFVhpeWK9TYxmzvI0aym16Q
         KdXRqzfRVjVwIZPEJH354PCh/I5Y8y2GfF+sHkHq+gLnN9zfkMq+JWAaI+BOnoEHa5dQ
         95T4kqy5Mqryy8Kc4W1eh9ry0U55J+NmrQ2HG1/9wbyMPwLxKq7/9dxyU4PpVc/ioIl6
         So336ChBm0uMwu+1KheQZSrODmFppeQt/oVicsIOSazL6/7/SlAXJCJH2S1/I/67DSp0
         I9Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=n9KKoy07FqMceGHLDf06eKMyV/ZGFogpP6+m44Yd7bE=;
        b=LTk2iNEsrqHTt7YXG++hlZn1R4MRxq6xuQuUEDVwEoDljdReO6eIyrcQ0GbcIkt+rE
         0NIkDctADYmIZUTuNS01IxK7FzubdH3rYp7aINNy5ECFWC3SiHZNqGyHdlZNCLlV97e0
         kCu3wy5d0MEBOg/RXHl6d9zEe/JiYPdy8mjzhxBt98co8x9E0ivShHSQv/I19U7OGSX2
         ZdQGsALzUclFkDiD/sVW9O1lzjIqYO1yJaR2LDnAOyAoUwDcyn3iN+v3Nfb+eYsHeX1G
         4a0WpCwK3GTmMNt43lZ1IzIslI2RFN/v3bYcvFnsOB4UUP1SpQufql6CRegcHEtReyaK
         n6FA==
X-Gm-Message-State: AJcUukeGyoSNoKyNmg4spdwPwBS01cVqK9lfIqa3rJtv/LqQhDyzLvXC
        ME9BAiR+g1NaXDsn1jNGbpQ=
X-Google-Smtp-Source: ALg8bN6nfCuuh3FvcfZwnjNips/Xhkt6byUM71jGXUPsyLV4o6YJFTAKQrZbMdjQoTLWkxNpb3RbCA==
X-Received: by 2002:a63:78cd:: with SMTP id t196mr3067788pgc.62.1546639479078;
        Fri, 04 Jan 2019 14:04:39 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b27sm88629400pfh.113.2019.01.04.14.04.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Jan 2019 14:04:38 -0800 (PST)
Date:   Fri, 4 Jan 2019 14:04:37 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        ebiederm@xmission.com, luto@kernel.org, carlos@redhat.com,
        dhowells@redhat.com, viro@zeniv.linux.org.uk, simo@redhat.com,
        eparis@parisplace.org, serge@hallyn.com
Subject: Re: [PATCH ghak90 (was ghak32) V4 01/10] audit: collect audit task
 parameters
Message-ID: <20190104220437.GB19346@roeck-us.net>
References: <cover.1533065887.git.rgb@redhat.com>
 <8e617ab568df28a66dfbe3284452de186b42fb0f.1533065887.git.rgb@redhat.com>
 <20190104025006.GA15567@roeck-us.net>
 <20190104145735.vlrw2fip5syn2exc@madcap2.tricolour.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190104145735.vlrw2fip5syn2exc@madcap2.tricolour.ca>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 04, 2019 at 09:57:35AM -0500, Richard Guy Briggs wrote:
> On 2019-01-03 18:50, Guenter Roeck wrote:
> > Hi Richard,
> > 
> > On Tue, Jul 31, 2018 at 04:07:36PM -0400, Richard Guy Briggs wrote:
> > > The audit-related parameters in struct task_struct should ideally be
> > > collected together and accessed through a standard audit API.
> > > 
> > > Collect the existing loginuid, sessionid and audit_context together in a
> > > new struct audit_task_info called "audit" in struct task_struct.
> > > 
> > > Use kmem_cache to manage this pool of memory.
> > > Un-inline audit_free() to be able to always recover that memory.
> > > 
> > > See: https://github.com/linux-audit/audit-kernel/issues/81
> > > 
> > > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > 
> > Overall I am not sure if keeping task_struct a bit smaller is worth
> > the added complexity, but I guess that is just me. 
> 
> The motivation was to consolidate all the audit bits into one pointer,
> isolating them from the rest of the kernel, restricting access only to
> helper functions to prevent abuse by other subsystems and trying to
> reduce kABI issues in the future.  I agree it is a bit more complex.  It
> was provoked by the need to add contid which seemed to make the most
> sense as a peer to loginuid and sessionid, and adding it to task_struct
> would have made it a bit too generic and available.
> 
> This is addressed at some length by Paul Moore here in v2:
> 	https://lkml.org/lkml/2018/4/18/759
> 
That makes sense. Thanks a lot for the clarification.

Guenter
