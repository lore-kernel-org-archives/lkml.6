Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA31BC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E01E2083E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin-net.20150623.gappssmtp.com header.i=@ursulin-net.20150623.gappssmtp.com header.b="orFwPNBt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E01E2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754789AbeGCK2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 06:28:17 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51007 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754665AbeGCK2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 06:28:13 -0400
Received: by mail-wm0-f65.google.com with SMTP id v25-v6so1761971wmc.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 03:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Rmu3+tA61xOtjTmfmkKWIvN2ZnexuhBx7UcNsdZD11s=;
        b=orFwPNBtJkN17cSm9klcudlJiXM15TrdVc9bDsiXoSdBOFEA/nkqukOLkVt5gWo7Mf
         1yabUAjip+IQkXs0MkZ1pTcu1epSSygUVzFBlOQkRVZtNKUQ9tqHXpqyhSjuGgyoUMQv
         KHGiF0IVcpxdyh3uZrbH/xd0hLFOnA8SN9pXp5GpkyETdi7ngR7VmsYuP5I4EPs4QWxe
         FY01w/rR/VfNFlc+PX1UKhs+VPPeYCktywtUgo329Ykzi9ZZnwgklAO43HMZwCoUyebd
         TR9Nzs/Aey6zJOKNMg4/vZkYYvgsVGDJzg46A+AsMEV2kmYN59Aq41u1gz8/Ngev6RnF
         OmcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Rmu3+tA61xOtjTmfmkKWIvN2ZnexuhBx7UcNsdZD11s=;
        b=ZG8FwzGAJ1FmvWN1pxDv+r0QuDiy9rbCZUiJI2Y2wd0iscmhhIufIke9WbxdS+PaCQ
         mcxI7ojAbIryIuRnJixpAqX52MhK7J+blyw1eLYVa/P1QOfDJkhTUphVn5iA+x50Eabg
         5QTMawHBJNhzMzXi7T3sXp1MhO5xo1HyCjK6TupFJjwEEcdsT4BL2dZY6sW6GDgEYssk
         KtDI9lAcQxKhYwJaZy8E3pyvU3YzMdO+5+SZTQULXzhDjOnbhNVWRuGLJsMddtZ+aPuu
         jbs6HObMEHp3GhdmQvDDzgM8PvJkAAzBon5qFdJJfP8BHAAbbVubGMbBFNqqFWcOHFCY
         e3jA==
X-Gm-Message-State: APt69E12iQM/0YVYM4XXzAiJLDdCFHy8JBCJwxyJCNQEqyquflyrYkMR
        rOzhxelawFnyz2iiYgLlcWwCpg==
X-Google-Smtp-Source: AAOMgpd7n2WKTTGcCuSJDQTvM0f19bzanJskeDQq3C1rTgIuw8OZyH1GIE1UQNA3fpPcSPEDSNlP2A==
X-Received: by 2002:a1c:910f:: with SMTP id t15-v6mr1843172wmd.51.1530613691305;
        Tue, 03 Jul 2018 03:28:11 -0700 (PDT)
Received: from [192.168.0.197] ([95.146.151.144])
        by smtp.googlemail.com with ESMTPSA id 24-v6sm2333104wrz.94.2018.07.03.03.28.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 03:28:10 -0700 (PDT)
Subject: Re: [RFC 2/4] perf: Pass pmu pointer to perf_paranoid_* helpers
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        x86@kernel.org
References: <20180626153642.5587-1-tvrtko.ursulin@linux.intel.com>
 <20180626153642.5587-3-tvrtko.ursulin@linux.intel.com>
 <5b618e5f-0dcd-5acb-96a0-a0560815c0d7@linux.ibm.com>
From:   Tvrtko Ursulin <tursulin@ursulin.net>
Message-ID: <d96f847f-e7b7-f586-27f8-cec4a50cdc0c@ursulin.net>
Date:   Tue, 3 Jul 2018 11:28:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <5b618e5f-0dcd-5acb-96a0-a0560815c0d7@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Ravi,

On 03/07/18 11:24, Ravi Bangoria wrote:
> Hi Tvrtko,
> 
>> @@ -199,7 +199,7 @@ static inline void perf_get_data_addr(struct pt_regs *regs, u64 *addrp)
>>   	if (!(mmcra & MMCRA_SAMPLE_ENABLE) || sdar_valid)
>>   		*addrp = mfspr(SPRN_SDAR);
>>   
>> -	if (perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN) &&
>> +	if (perf_paranoid_kernel(ppmu) && !capable(CAP_SYS_ADMIN) &&
>>   		is_kernel_addr(mfspr(SPRN_SDAR)))
>>   		*addrp = 0;
>>   }
> 
> This patch fails for me on powerpc:
> 
> arch/powerpc/perf/core-book3s.c: In function ‘perf_get_data_addr’:
> arch/powerpc/perf/core-book3s.c:202:27: error: passing argument 1 of ‘perf_paranoid_kernel’ from incompatible pointer type [-Werror=incompatible-pointer-types]
>    if (perf_paranoid_kernel(ppmu) && !capable(CAP_SYS_ADMIN) &&
>                             ^~~~
> In file included from arch/powerpc/perf/core-book3s.c:13:0:
> ./include/linux/perf_event.h:1191:20: note: expected ‘const struct pmu *’ but argument is of type ‘struct power_pmu *’
>   static inline bool perf_paranoid_kernel(const struct pmu *pmu)
>                      ^~~~~~~~~~~~~~~~~~~~
> arch/powerpc/perf/core-book3s.c: In function ‘power_pmu_bhrb_read’:
> arch/powerpc/perf/core-book3s.c:470:8: error: too few arguments to function ‘perf_paranoid_kernel’
>      if (perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN) &&
>          ^~~~~~~~~~~~~~~~~~~~
> In file included from arch/powerpc/perf/core-book3s.c:13:0:
> ./include/linux/perf_event.h:1191:20: note: declared here
>   static inline bool perf_paranoid_kernel(const struct pmu *pmu)
>                      ^~~~~~~~~~~~~~~~~~~~
>    CC      net/ipv6/route.o

Yep, kbuild reported this as well. I will need to re-arrange the code a 
bit to a) pass the correct pointer in, and b) I missed one call-site as 
well.

I was holding of doing that until some more general feedback arrives.

Regards,

Tvrtko
