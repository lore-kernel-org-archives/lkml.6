Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38297C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A1D920883
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547821389;
	bh=FsLASoKsUR2hEwLe55WKKaJrXYzkv434ZZv/qnewgxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dBB9139WwHoaSOaIppB8sswqxdtiOo0HFH/RCgDWY7Hcd7O7lg4fUoV5p7PncLTMV
	 v7vKxhC8oanE8u1rIQGMLRsyS6k9/0sR3epuCGVgxW1hltkxAkbV0/SnufpQTo2xJ5
	 nLcMylSxnSBq/zJ8E9XXAqMZHwYcPl5Eb7CMlrbk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbfAROXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 09:23:07 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:38398 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbfAROXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 09:23:06 -0500
Received: by mail-yb1-f194.google.com with SMTP id x9so4403647ybj.5;
        Fri, 18 Jan 2019 06:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fShawxudI26SvDbmZ3eSrcYp4BsXCd4u6t/WObVnJOs=;
        b=urmcgzTKKAN9cFALqi3SnsfcMXx3nk3V0CsP42IYiK7AXq26Dn09OU7KjwO8BAZKCx
         PYn9mrnU3Tj3xvcoevrmntqsbDmJTPi3nT5YEDxpXyZfpYOIJDnhzKjoo9bgTrcW7cJY
         YtuXp9bSD+NR52lOOYvHvhsl2IZtSRRYict3jo5jMZrFLsvb/+mF5aB1vnl38AXDVLUM
         BVY/2GiVJX8hhg5Cp83XqWjBVzBQlslsLLidzCyWwyq80AVGidXYrRe0L8JLThHP5WF6
         Lh7XOAd7Pb+zFlsKzcIwwvGD5EGX4V1IMeHlmj9uku2hmX521JMfxjn2jYbSWWXw1DPk
         T/gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=fShawxudI26SvDbmZ3eSrcYp4BsXCd4u6t/WObVnJOs=;
        b=XX61RpivHLHV3Ee16BbcJfGqHP5x4ZtqAMh54x8bzKcORYVp4rfSNPsIezaa87H0GE
         u21pMJWYlY4E8J0pD1tXOXjGJfBSc/1YcmJ0X635KNNC+u8xkERsm4Ftt3/wf3hDkxMC
         oMDmuF0IBb2AzVOp3aSu1nw2MKzYIm2UZ8PgENS6VOyUN0XstJfd7EmkV2txeOMZdjRd
         860F8vzi3aZsqxpVSZPC33fyC2u5xx0YhI2UJ97cPeyPOwks1vAwtk93rujZKA2yrhz7
         InpzUPn33M92AvHKgCukOD0wcBKor1gY7cgWagBLXP0AqfyvR5653gTR8cT2IXrD9qQr
         DO9g==
X-Gm-Message-State: AJcUukdXb20B5nLwm/ULDlLqAfpxQGBZ0mp2mfXcW3sLJTZCZc+SD4Vo
        CwbVH50SsdRFupWqoLrtcmCruJ3I
X-Google-Smtp-Source: ALg8bN65S+HR/xKxfr1sSLU4LhKw/a9sDj6TQysynAPP+2ix5SkZ1nyia3Id8m424R/r9wCIraURFg==
X-Received: by 2002:a25:c886:: with SMTP id y128mr6622821ybf.250.1547821385124;
        Fri, 18 Jan 2019 06:23:05 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::6:586f])
        by smtp.gmail.com with ESMTPSA id b144sm2604765ywa.33.2019.01.18.06.23.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 06:23:03 -0800 (PST)
Date:   Fri, 18 Jan 2019 06:23:02 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Masatake YAMATO <yamato@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org
Subject: Re: [PATCH] mm/mincore: allow for making sys_mincore() privileged
Message-ID: <20190118142302.GC50184@devbig004.ftw2.facebook.com>
References: <nycvar.YFH.7.76.1901051817390.16954@cbobk.fhfr.pm>
 <CAHk-=wicks2BEwm1BhdvEj_P3yawmvQuG3NOnjhdrUDEtTGizw@mail.gmail.com>
 <nycvar.YFH.7.76.1901052108390.16954@cbobk.fhfr.pm>
 <CAHk-=whGmE4QVr6NbgHnrVGVENfM3s1y6GNbsfh8PcOg=6bpqw@mail.gmail.com>
 <nycvar.YFH.7.76.1901052131480.16954@cbobk.fhfr.pm>
 <CAHk-=wgrSKyN23yp-npq6+J-4pGqbzxb3mJ183PryjHw7PWDyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgrSKyN23yp-npq6+J-4pGqbzxb3mJ183PryjHw7PWDyA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus.

On Sat, Jan 05, 2019 at 01:54:03PM -0800, Linus Torvalds wrote:
> And the first hit is 'fincore', which probably nobody cares about
> anyway, but it does
> 
>     fd = open (name, O_RDONLY)
>     ..
>     mmap(window, len, PROT_NONE, MAP_PRIVATE, ..

So, folks here have been using fincore(1) for diagnostic purposes and
are also looking to expand on it to investigate per-cgroup cache
usages (mmap -> mincore -> /proc/self/pagemap -> /proc/kpagecgroup ->
cgroup path).

These are all root-only usages to find out what's going on with the
whole page cache.  We aren't attached to doing things this particular
way but it'd suck if there's no way.

Thanks.

-- 
tejun
