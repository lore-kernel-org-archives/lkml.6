Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B0B7C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24B1B24899
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rN+fJ8LA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24B1B24899
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932517AbeGCHIL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 03:08:11 -0400
Received: from mail-qt0-f201.google.com ([209.85.216.201]:42676 "EHLO
        mail-qt0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932095AbeGCHIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 03:08:09 -0400
Received: by mail-qt0-f201.google.com with SMTP id f8-v6so1202088qth.9
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 00:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=I6uosl1zIWwBC1sQZN+ohO0DgT673+yEsyktb6d5uuU=;
        b=rN+fJ8LAbvHbAp5txQiEGhmICd7MnVMPwbij4gJdBBFTxDSRdV73oKChJlueF657xw
         IaeRoWGHsKsrai7jY3+Zhd3eumpC0Tvxv3+VC8FxAGEat2aWOB9sbzbo657ZABXg6dFB
         uga198+mUIlbSj6Hs76Q0sjaxDtWuFLh+7N/cnuRMd9+sVtCAz/UPTFZtP/4nNWtotxy
         ac0QlsU60uDy5MqAzIBlzA0RiuM9qyvf+Xdphdf2iLtPBl3nCMK2U55cpZmbrw72CCwI
         cUK8BJoXLqhcbzl+k+n2xEWfmx3FF40upDl8NU8mO11m66v2Z2HmtXjZF1JnOqstDRLI
         qYkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=I6uosl1zIWwBC1sQZN+ohO0DgT673+yEsyktb6d5uuU=;
        b=UKx+esLxzeAn11pV8WV9gftPH+PVMsY3w5elHRQjcl6hgqZ7i+4ZirVcHRMRzAxHd7
         plG7Ba+O7TNtgsK/7izSnlZLOIPTq/JyAoDoSvUIUOHYs3A6hni1ubCNhaD35SM3j2J0
         jrb6zhCmMQuWZB6w6eYjolBC/UcIgbilRjyjhLebLVA6+yuyw/fEDIGJluvZJd2k3B58
         IsLwcjP9dJ5MRClpXLkSVln+Has3p46YoJd9izm8uMX5SUg+Y7TWEFkXUhOOUoqgFnie
         v2KWN1nc2fNzaIVBzbGlnZalfOdiW3QJSFogAinptoaAp4hq1FV8ElwGAdv050t11IKz
         MsIg==
X-Gm-Message-State: APt69E14pLM3RFCccrab4gNcaKKOepQ7iHTGXdSviTzwENwmEketoikd
        o1TOoh5WIlohaABCIIchY5HPJYfBcJN/
X-Google-Smtp-Source: AAOMgpf9m6suLZo8yI3v+8UW8+9Vh/DB3R6y/FZOUWRMe9Ix9doWXdohLilhLknlDjxXyxSH1miyWyoiNeuH
X-Received: by 2002:aed:2106:: with SMTP id 6-v6mr15706370qtc.24.1530601688459;
 Tue, 03 Jul 2018 00:08:08 -0700 (PDT)
Date:   Tue, 03 Jul 2018 00:08:05 -0700
In-Reply-To: <20180702100301.GC19043@dhcp22.suse.cz>
Message-Id: <xr938t6skd9m.fsf@gthelen.svl.corp.google.com>
Mime-Version: 1.0
References: <20180628151101.25307-1-mhocko@kernel.org> <xr93in62jy8k.fsf@gthelen.svl.corp.google.com>
 <20180629072132.GA13860@dhcp22.suse.cz> <xr93bmbtju6f.fsf@gthelen.svl.corp.google.com>
 <20180702100301.GC19043@dhcp22.suse.cz>
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

> On Fri 29-06-18 11:59:04, Greg Thelen wrote:
>> Michal Hocko <mhocko@kernel.org> wrote:
>> 
>> > On Thu 28-06-18 16:19:07, Greg Thelen wrote:
>> >> Michal Hocko <mhocko@kernel.org> wrote:
>> > [...]
>> >> > +	if (mem_cgroup_out_of_memory(memcg, mask, order))
>> >> > +		return OOM_SUCCESS;
>> >> > +
>> >> > +	WARN(1,"Memory cgroup charge failed because of no reclaimable memory! "
>> >> > +		"This looks like a misconfiguration or a kernel bug.");
>> >> 
>> >> I'm not sure here if the warning should here or so strongly worded.  It
>> >> seems like the current task could be oom reaped with MMF_OOM_SKIP and
>> >> thus mem_cgroup_out_of_memory() will return false.  So there's nothing
>> >> alarming in that case.
>> >
>> > If the task is reaped then its charges should be released as well and
>> > that means that we should get below the limit. Sure there is some room
>> > for races but this should be still unlikely. Maybe I am just
>> > underestimating though.
>> >
>> > What would you suggest instead?
>> 
>> I suggest checking MMF_OOM_SKIP or deleting the warning.
>
> So what do you do when you have MMF_OOM_SKIP task? Do not warn? Checking
> for all the tasks would be quite expensive and remembering that from the
> task selection not nice either. Why do you think it would help much?

I assume we could just check current's MMF_OOM_SKIP - no need to check
all tasks.  My only (minor) objection is that the warning text suggests
misconfiguration or kernel bug, when there may be neither.

> I feel strongly that we have to warn when bypassing the charge limit
> during the corner case because it can lead to unexpected behavior and
> users should be aware of this fact. I am open to the wording or some
> optimizations. I would prefer the latter on top with a clear description
> how it helped in a particular case though. I would rather not over
> optimize now without any story to back it.

I'm fine with the warning.  I know enough to look at dmesg logs to take
an educates that the race occurred.  We can refine it later if/when the
reports start rolling in.  No change needed.
