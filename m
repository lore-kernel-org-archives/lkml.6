Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D730C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 23:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E09BE2473F
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 23:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s/e/30jl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E09BE2473F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753063AbeGCX3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 19:29:05 -0400
Received: from mail-qk0-f201.google.com ([209.85.220.201]:56182 "EHLO
        mail-qk0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752003AbeGCX3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 19:29:03 -0400
Received: by mail-qk0-f201.google.com with SMTP id i127-v6so3858191qkc.22
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 16:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ReenQXEBeM0cKTKAX61mE/8d3BaM7uMgpXgXtlJHCf0=;
        b=s/e/30jlCMoQlOna8ljRXoOy0M13Z0iaRwNpf+/5/cDFIaosyV1Yah8CGQ3axf+QrV
         +N7Sc6G4BjcsByb/7Udw9RDdF10trgUSne2/Ri692uS18tMG8ZO9t2oGGWPuSVOIr1mE
         9fBbbQtxqKB5PoVQG9Lsy1ihPBCHFlEVkDKkERiEzke3HKgkuuORmm2gTlRhUSLnK5rC
         cvr1R5C9/3yo/maW2ng26XSSR0BBnjtMK+AflvIKNqpAyuSz899wtEsS6/CIgaqwwHhH
         IoLU+90CP6RMt1wHKJ+IECG+h3nF5mUhqw+OSUR9s25lxCHO/8XlJ5xMRA9QtHsutDlw
         CxGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ReenQXEBeM0cKTKAX61mE/8d3BaM7uMgpXgXtlJHCf0=;
        b=YEsXGZSCD2Dv6PraFonMLe+FH7dUqya7bbrM8fQA1m85cZp7fvuonvKW0o+E7l9H83
         k8O1YCDMuuH10vd62hq8wabHezevfIjnu+v0JOtk2cIfqzxMPLNgQZLA08ZjCF1ZakM+
         EQ/NYntpdFGWisxDFcqXuqND7PmwScOUH+CcCOTe9m7goFl/973kAGuuC229eaw4N7mI
         CiIQX+XBTobpuD17MQIVsMCimN1OeySFTRRiz9/2bjdJe3jrOFIFhAUdBocNmoCAtKP+
         CBscI0/tfJQtERmwQ+kC0wMLgXlsfDIha047eAvcNeWs7clTTsAQ5/9tGjq/0ZKIje6W
         +Geg==
X-Gm-Message-State: APt69E0Q54HcwrruzPou3abefp2j2a3NepXuGbumLhSDfQpRo0lQcw0U
        k0dImCUV7i151juMjqJH30UEtvcpDDIA
X-Google-Smtp-Source: AAOMgpc5dtyZCynTUyTzM5tErSycZqBn5ARBBWaSsGO2MC/xRPhrZ7FgDlaaIKWSu5rotDZK0aLNS+PEMdh1
X-Received: by 2002:a0c:b981:: with SMTP id v1-v6mr8699728qvf.35.1530660543092;
 Tue, 03 Jul 2018 16:29:03 -0700 (PDT)
Date:   Tue, 03 Jul 2018 16:29:00 -0700
In-Reply-To: <20180703071658.GC16767@dhcp22.suse.cz>
Message-Id: <xr93woubj3ur.fsf@gthelen.svl.corp.google.com>
Mime-Version: 1.0
References: <20180628151101.25307-1-mhocko@kernel.org> <xr93in62jy8k.fsf@gthelen.svl.corp.google.com>
 <20180629072132.GA13860@dhcp22.suse.cz> <xr93bmbtju6f.fsf@gthelen.svl.corp.google.com>
 <20180702100301.GC19043@dhcp22.suse.cz> <xr938t6skd9m.fsf@gthelen.svl.corp.google.com>
 <20180703071658.GC16767@dhcp22.suse.cz>
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

> On Tue 03-07-18 00:08:05, Greg Thelen wrote:
>> Michal Hocko <mhocko@kernel.org> wrote:
>> 
>> > On Fri 29-06-18 11:59:04, Greg Thelen wrote:
>> >> Michal Hocko <mhocko@kernel.org> wrote:
>> >> 
>> >> > On Thu 28-06-18 16:19:07, Greg Thelen wrote:
>> >> >> Michal Hocko <mhocko@kernel.org> wrote:
>> >> > [...]
>> >> >> > +	if (mem_cgroup_out_of_memory(memcg, mask, order))
>> >> >> > +		return OOM_SUCCESS;
>> >> >> > +
>> >> >> > +	WARN(1,"Memory cgroup charge failed because of no reclaimable memory! "
>> >> >> > +		"This looks like a misconfiguration or a kernel bug.");
>> >> >> 
>> >> >> I'm not sure here if the warning should here or so strongly worded.  It
>> >> >> seems like the current task could be oom reaped with MMF_OOM_SKIP and
>> >> >> thus mem_cgroup_out_of_memory() will return false.  So there's nothing
>> >> >> alarming in that case.
>> >> >
>> >> > If the task is reaped then its charges should be released as well and
>> >> > that means that we should get below the limit. Sure there is some room
>> >> > for races but this should be still unlikely. Maybe I am just
>> >> > underestimating though.
>> >> >
>> >> > What would you suggest instead?
>> >> 
>> >> I suggest checking MMF_OOM_SKIP or deleting the warning.
>> >
>> > So what do you do when you have MMF_OOM_SKIP task? Do not warn? Checking
>> > for all the tasks would be quite expensive and remembering that from the
>> > task selection not nice either. Why do you think it would help much?
>> 
>> I assume we could just check current's MMF_OOM_SKIP - no need to check
>> all tasks.
>
> I still do not follow. If you are after a single task memcg then we
> should be ok. try_charge has a runaway for oom victims
> 	if (unlikely(tsk_is_oom_victim(current) ||
> 		     fatal_signal_pending(current) ||
> 		     current->flags & PF_EXITING))
> 		goto force;
>
> regardless of MMF_OOM_SKIP. So if there is a single process in the
> memcg, we kill it and the oom reaper kicks in and sets MMF_OOM_SKIP then
> we should bail out there. Or do I miss your intention?

For a single task memcg it seems that racing process cgroup migration
could trigger the new warning (I have attempted to reproduce this):

Processes A,B in memcg M1,M2.  M1 is oom.

  Process A[M1]               Process B[M2]

  M1 is oom
  try_charge(M1)
                              Move A M1=>M2
  mem_cgroup_oom()
  mem_cgroup_out_of_memory()
    out_of_memory()
      select_bad_process()
        sees nothing in M1
      return 0
    return 0
  WARN()


Another variant might be possible, this time with global oom:

Processes A,B in memcg M1,M2.  M1 is oom.

  Process A[M1]               Process B[M2]

  try_charge()
                              trigger global oom
                              reaper sets A.MMF_OOM_SKIP
  mem_cgroup_oom()
  mem_cgroup_out_of_memory()
    out_of_memory()
      select_bad_process()
        sees nothing in M1
      return 0
    return 0
  WARN()


These seem unlikely, so I'm fine with taking a wait-and-see approach.
