Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB794ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 21:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8679E20671
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 21:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="mnR+9dLr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8679E20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbeGTV4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 17:56:31 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41544 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727749AbeGTV4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 17:56:31 -0400
Received: by mail-pg1-f194.google.com with SMTP id z8-v6so7812729pgu.8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 14:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1lSBfmdyStY+qeBaFCgSb+R+TLH/5rDIp+TRXUtl+ls=;
        b=mnR+9dLrvHCdDN5gXwzlMCk2BKSY/zQADiR6bz3jTOIcUTgb31B6tqDwxmEsCWRsF0
         FXvhjJ1lMUdy5n39LcYWgybTA+rk9VTBNFuw9vTX2PEuffMsVgFv5poZ34ETmyDhTX+n
         VCe8QLU3T3MN+/pz/zKMf9C8/7yXp7QQHcAMd0TCHM69UyMlXrkYdCqkf30/oAwz52+K
         mwLeLSkXIZFCt41Tx148ih5uPUJVUYzJn6LCGD26ZxEEvkhMe+slhwEGal/CcNuDNaLU
         bn4TkzxvKvzt3qDWzK4oBNNE492Zqz0jvS07KEcFm9SDxsRzzNVTEeK9043O4cB7jxV3
         6Qpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1lSBfmdyStY+qeBaFCgSb+R+TLH/5rDIp+TRXUtl+ls=;
        b=caNTGPXPqZ6D26cyShxKOaM6t7ZkVBFrToxXdFTZan/r0LCeAZdX+79OjruWSvKzS7
         by2H7vcdkBikcp9cL6rD3K4uuyRKtWjFPPLg7vYjrnacGGNs8tHXOgUPzpB6wffNTxhN
         jybEER7qi+x56PJmQ9ALPuVUTOxA1jmF6lD4YPF2Y0iNDwU+cMiJ49jVepG/icIV+GKe
         3SK8LOQgmglKiT8EXG76jnxdS8EVU3BMlsDZ2PclsFX28YLaCynlInFqdHooL/rZMYPp
         6rorCh/GM9a1cSm0+qOaPpcMnxuMH6A0FHk/w5NMciLf4t9AOVNt4AlCzpp138bQiDgG
         l/lw==
X-Gm-Message-State: AOUpUlFlB67+SEPXZ6PZEz3Gx9C1WuuyQfZl9PhAPbmFqdAFg6ss8N5w
        3Ku6FSUCnU0eoYyc0Hy3JAEUNQ==
X-Google-Smtp-Source: AAOMgpdaKFcz2DPWSAPD0DvVj6kXKg42crJpv5hde8j71pGCrrhYb17gm74e2zpIXdq8lSV+EmkLEg==
X-Received: by 2002:a62:c98e:: with SMTP id l14-v6mr3682602pfk.10.1532120790564;
        Fri, 20 Jul 2018 14:06:30 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([134.134.139.83])
        by smtp.gmail.com with ESMTPSA id v17-v6sm3539787pfn.177.2018.07.20.14.06.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 14:06:29 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 7321B300254; Sat, 21 Jul 2018 00:06:26 +0300 (+03)
Date:   Sat, 21 Jul 2018 00:06:26 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     hughd@google.com, rientjes@google.com, aaron.lu@intel.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: thp: remove use_zero_page sysfs knob
Message-ID: <20180720210626.5bnyddmn4avp2l3x@kshutemo-mobl1>
References: <1532110430-115278-1-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532110430-115278-1-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 21, 2018 at 02:13:50AM +0800, Yang Shi wrote:
> By digging into the original review, it looks use_zero_page sysfs knob
> was added to help ease-of-testing and give user a way to mitigate
> refcounting overhead.
> 
> It has been a few years since the knob was added at the first place, I
> think we are confident that it is stable enough. And, since commit
> 6fcb52a56ff60 ("thp: reduce usage of huge zero page's atomic counter"),
> it looks refcounting overhead has been reduced significantly.
> 
> Other than the above, the value of the knob is always 1 (enabled by
> default), I'm supposed very few people turn it off by default.
> 
> So, it sounds not worth to still keep this knob around.

I don't think that having the knob around is huge maintenance burden.
And since it helped to workaround a security bug relative recently I would
rather keep it.

-- 
 Kirill A. Shutemov
