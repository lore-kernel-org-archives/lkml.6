Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 398F4ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 17:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCB4E2150F
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 17:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QqhA21E5";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="odUpehAV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCB4E2150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbeIVX1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 19:27:14 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54794 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbeIVX1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 19:27:14 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0321360E58; Sat, 22 Sep 2018 17:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537637574;
        bh=JoTkmxJkK9Zvvar1YesuDCKF9QJ2EJWCVqUjksi3Dv0=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=QqhA21E5xp4mwB2ue42Y0+XtYP+DjRi35p/KHRMbIQ8ca4iTYhLHlf1Hr4hffz3F9
         rpBGjApFktRVBaDGU0tTvOdHiXgSoxkNOqCSDoTtT4HHBceHsdP4x08BpBGMW4I4JG
         98KzoyN1Zi9z91/YG9Tl540qJ2EHyI78IvtCk/ZA=
Received: from [192.168.43.47] (unknown [223.237.247.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5AEBD60CA2;
        Sat, 22 Sep 2018 17:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537637572;
        bh=JoTkmxJkK9Zvvar1YesuDCKF9QJ2EJWCVqUjksi3Dv0=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=odUpehAVFYG5vrgTe1PV2hNylXHmgUN30IZbxpYzLiLUlGptgd/1OskLcuoKLDF0q
         /vz8VXFkJhj22FMn5c5cPdcgv97hzeW8rQN2ks13APWR4Q0AA0EUADOC+vjSzNRBQc
         18MaHHs25rKJzAs9Tzet2OPcd9CwrXr059/GyESE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5AEBD60CA2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCH 2/6] pstore: Add event tracing support
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Laura Abbott <labbott@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Colin Cross <ccross@android.com>,
        Jason Baron <jbaron@akamai.com>,
        Tony Luck <tony.luck@intel.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Joe Perches <joe@perches.com>,
        Jim Cromie <jim.cromie@gmail.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        tsoni@codeaurora.org, Bryan Huntsman <bryanh@codeaurora.org>,
        Tingwei Zhang <tingwei@codeaurora.org>,
        kernel-team <kernel-team@android.com>
References: <cover.1536430404.git.saiprakash.ranjan@codeaurora.org>
 <b9b60ff2864a17fb05481aa33f90114ab051d6ce.1536430404.git.saiprakash.ranjan@codeaurora.org>
 <CAEXW_YRXQwKvnahv5X1F_Bu_98vMg=w1xpo8PZ+aNT02vBrwwg@mail.gmail.com>
 <e8fdef37-afcd-24b3-1005-e707b73f20b1@codeaurora.org>
Message-ID: <ab7c17a6-c853-d763-1f12-1c169ff7a579@codeaurora.org>
Date:   Sat, 22 Sep 2018 23:02:37 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <e8fdef37-afcd-24b3-1005-e707b73f20b1@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/22/2018 10:07 PM, Sai Prakash Ranjan wrote:
> On 9/22/2018 2:35 PM, Joel Fernandes wrote:
>> On Sat, Sep 8, 2018 at 4:28 PM Sai Prakash Ranjan
>> <saiprakash.ranjan@codeaurora.org> wrote:
>>>
>> Could you just split the pstore space into a per-cpu event buffer like
>> we are doing for ftrace-on-pstore? Then you don't need to lock. I fear
>> the lock contention will be apparent. The pstore code already has
>> plumbing to split the store buffer per CPU.
>>
> 
> Hi Joel,
> 
> Thanks a lot for reviewing.
> 
> I just looked at per-cpu buffer for ftrace and itseems the pstore percpu 
> records will need to be merged into one record if we add this support 
> for events. Merging of ftrace logs is based on timestamp, but for events 
> we do not have timestamp field (for this specific reason I have added 
> timestamp field for IO event tracing so that atleast we can know the cpu 
> number in pstore output). For example, the sched event pstore output 
> below has no timestamp field, so how do we merge per-cpu logs?
> 
> # tail /sys/fs/pstore/event-ramoops-0
> sched_waking: comm=rcu_sched pid=11 prio=120 target_cpu=002
> sched_wakeup: comm=rcu_sched pid=11 prio=120 target_cpu=002
> 
> Also Pstore ftrace log format is fixed i.e.,(CPU:%d ts:%llu %08lx  %08lx 
>   %pf <- %pF\n"), but different events will have different formats and 
> we will not be able to add timestamp field like how pstore ftrace does 
> using  pstore_ftrace_write_timestamp() and pstore_ftrace_read_timestamp().
> 
> Sorry if I am confusing you, I can explain better I guess.
> 

To add to this on db410c board with the current patch I just measured 
average throughput of dd over 60 seconds with sched event tracing 
enabled (trace_event=sched tp_pstore) : 190 MB/s

# dd if=/dev/zero of=/dev/null status=progress
11402907648 bytes (11 GB, 11 GiB) copied, 60 s, 190 MB/s^C
22430312+0 records in
22430312+0 records out
11484319744 bytes (11 GB, 11 GiB) copied, 60.4277 s, 190 MB/s

It seems fine or maybe I am testing it wrongly? Anyways let me know if I 
can test any additional things in some different ways.

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
