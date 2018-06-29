Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB0CC6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90A1027C49
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a2c/cghg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90A1027C49
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755190AbeF2S7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 14:59:09 -0400
Received: from mail-io0-f201.google.com ([209.85.223.201]:41553 "EHLO
        mail-io0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751757AbeF2S7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 14:59:07 -0400
Received: by mail-io0-f201.google.com with SMTP id t14-v6so7588562ioj.8
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 11:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=DiOeDF4Qg8Nq27NSV8xjyeiyDTe9lh85B1mDmsAQp1k=;
        b=a2c/cghgED8Wtc1/rcLm5LcTuB9+tCbezzoXbhDjeeJUqBxWBq7l/TQEDwwkkG4k3V
         FooxioO8gyAHq2jjjK4dSTlYwdzO4vcXYIY5ryGfGQoOPPZ+JArC4v5aSsSrNQzHpcCw
         z92mL2gy3SU8g7bz3lF4aCbtzi17lwH6xvR/hdI1Zqj1M0da2bWrobHeD/MRuQmhRkUm
         NDTSyFzqP78UtkTJIOXX584HD8QGd2HHLhWUZrak6AW4KsfinIM2CwEonpXfRfax2rv+
         A2l75HZvmWq+AjevFv9hPfq++wVzFLeeaNIELBjELcA78+cN0I2RgXuqnUG/Y4ezDqG0
         7NhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DiOeDF4Qg8Nq27NSV8xjyeiyDTe9lh85B1mDmsAQp1k=;
        b=lR2YnmH54ErHiH9OQqE95Y0tuhQhE4Pcmi7uJGbE0vMg8QNIrn8gvd07XMJqBY6Kjq
         paPMlzJL6aJY6LrlST5cV1A2ZeOVZwN0fKbEE1LAoVZtsDQnxaq5R8sTIodnN3U85zee
         Hz1GBwCaA6KJ4TVK4FsRcBtVbI75xa4bCkf7Yjpdb365MqP4pY/j08QM3JYIY5wUlqjY
         8ow7XVVK15SHuSAznH1mM3XYv84Z55+poUgig0HNJ6zQDo6j4QRr3PQ8xPj+6WK2/GP6
         JCP5yLvsfoNZ9xLSleg4WExbsaswlBdxoUF8b4+S3F3ly+QxrbHL3tCsAHnOLVHrnSAk
         nQsg==
X-Gm-Message-State: APt69E2xKxoUrflCcl4RSRN4D9D0He+iwZTv43ODQApLtt2KEJqmOrtN
        Mgg0QRuDVzhUXaucOL/7FyorXD2Cz8Hy
X-Google-Smtp-Source: AAOMgpc4CGgXxQFav0W6vVcLxLGDhCv4Ir1KEsTOOQ7Fucu6X7BaOhfZrLc4f6DXzTlb6YEkV7qRcNFev3HA
X-Received: by 2002:a24:212:: with SMTP id 18-v6mr1301136itu.32.1530298747048;
 Fri, 29 Jun 2018 11:59:07 -0700 (PDT)
Date:   Fri, 29 Jun 2018 11:59:04 -0700
In-Reply-To: <20180629072132.GA13860@dhcp22.suse.cz>
Message-Id: <xr93bmbtju6f.fsf@gthelen.svl.corp.google.com>
Mime-Version: 1.0
References: <20180628151101.25307-1-mhocko@kernel.org> <xr93in62jy8k.fsf@gthelen.svl.corp.google.com>
 <20180629072132.GA13860@dhcp22.suse.cz>
Subject: Re: [PATCH] memcg, oom: move out_of_memory back to the charge path
From:   Greg Thelen <gthelen@google.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko <mhocko@kernel.org> wrote:

> On Thu 28-06-18 16:19:07, Greg Thelen wrote:
>> Michal Hocko <mhocko@kernel.org> wrote:
> [...]
>> > +	if (mem_cgroup_out_of_memory(memcg, mask, order))
>> > +		return OOM_SUCCESS;
>> > +
>> > +	WARN(1,"Memory cgroup charge failed because of no reclaimable memory! "
>> > +		"This looks like a misconfiguration or a kernel bug.");
>> 
>> I'm not sure here if the warning should here or so strongly worded.  It
>> seems like the current task could be oom reaped with MMF_OOM_SKIP and
>> thus mem_cgroup_out_of_memory() will return false.  So there's nothing
>> alarming in that case.
>
> If the task is reaped then its charges should be released as well and
> that means that we should get below the limit. Sure there is some room
> for races but this should be still unlikely. Maybe I am just
> underestimating though.
>
> What would you suggest instead?

I suggest checking MMF_OOM_SKIP or deleting the warning.  But I don't
feel strongly.
