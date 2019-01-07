Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D4BC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 14:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAE1F2173C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 14:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Q8bQhSwX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbfAGOgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 09:36:12 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42477 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727854AbfAGOgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 09:36:09 -0500
Received: by mail-qt1-f196.google.com with SMTP id d19so612224qtq.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 06:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oNHJ28PHCRGNBfxGC4JYon2+bxtcvPjs+sEoG2143Eo=;
        b=Q8bQhSwXxxudatND4G8+Ihuw7A2k81G53OVMf2ibLRYrBnmeiyAAOgIIQ2dcQZb2t5
         sxX+ApGOGISxRaeQdPwgkLpntx23OcIZ/eJ5z7CgnRmQ1vizWDxq2hwptwjg77r3K2IQ
         kd3370tyBCs7jaC9poftx4IUFw7B/xKpskZVO/PfsjzoakAvA/bS2PURzwmWLUbfm8MV
         BVoZV0AhEYJ7QJKj1VimSW8S9PHWWc1UoJCqGQoWLj8la7cvoRt18vwYozjkbunByFwn
         o90UEYDqIJg/mocNhU3tmiTaXa9zkgGL+ZX31WvibeQ2oFsC57m98V9eI/x+RWdnmTJE
         O4NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oNHJ28PHCRGNBfxGC4JYon2+bxtcvPjs+sEoG2143Eo=;
        b=ZsY7/eiqUcDmzHvaS6Yxc0kW/EflBJr2TuY72UvEBJrLlpFBzx3co7OdmisTN/WSgG
         k0UlcZXoQ3cje7wzsYwRnNTfjcmuzmFOMhaIlmI3FkUU++Ukd4a6lLP67G45iNO2B/OM
         OlnGkgkjyVfpKQREH1Xpz+ggxDkzYmTt9RNnH3rMYCKz93n8C4kH3GdsTJduyhzSD0Ky
         vK7taXSIb/hyRVSlcCWK75bST6LCY3l1HoYoHHIqdIVrJh+G8c1HgGO6+sStFL15sFUX
         Q2Zs4bqsi+3MZBLPTdVEiWpm3BoCTi01/YrodG8ydmSxyuTeOjZbrpn1k+SdihfnijNs
         fb5A==
X-Gm-Message-State: AJcUukcBS+7mjSVYL9wMNEnFYoVFpu+9T7h3PwX+EQlCuYWqGlONK9qr
        Imevzp6VJxasWCGWEAJYBT37iw==
X-Google-Smtp-Source: ALg8bN58a3E/LGwZU0KAaRBR5tK8HeWKX8oS6VcaX15xO1+5z8hNdLRrljm49hmVbm/Yj3+n8NlNPg==
X-Received: by 2002:a0c:ade7:: with SMTP id x36mr58670610qvc.66.1546871767705;
        Mon, 07 Jan 2019 06:36:07 -0800 (PST)
Received: from ovpn-120-55.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id m41sm42554081qtc.58.2019.01.07.06.36.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 06:36:07 -0800 (PST)
Subject: Re: kernel BUG at kernel/sched/core.c:3490!
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        linux kernel <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, gkohli@codeaurora.org
References: <ba9c5ad8-d78c-904d-0430-a67d8e3ea729@lca.pw>
 <20190107135215.GG14122@hirez.programming.kicks-ass.net>
From:   Qian Cai <cai@lca.pw>
Message-ID: <46089f1c-ad72-c96c-2f35-c2f60e726462@lca.pw>
Date:   Mon, 7 Jan 2019 09:36:05 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190107135215.GG14122@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/7/19 8:52 AM, Peter Zijlstra wrote:
> On Tue, Jan 01, 2019 at 12:44:35AM -0500, Qian Cai wrote:
>> Running some mmap() workloads to put the system on low memory situation with
>> swapping and OOM, and then it trigger this BUG(),
>>
>> void __noreturn do_task_dead(void)
>> {
>>         /* Causes final put_task_struct in finish_task_switch(): */
>>         set_special_state(TASK_DEAD);
>>
>>         /* Tell freezer to ignore us: */
>>         current->flags |= PF_NOFREEZE;
>>
>>         __schedule(false);
>>         BUG();
>>
>>         /* Avoid "noreturn function does return" - but don't continue if BUG()
>> is a NOP: */
>>         for (;;)
>>                 cpu_relax();
>> }
> 
> This would mean that we somehow loose the TASK_DEAD state before hitting
> schedule(), but that is something that should be avoided by
> set_special_state(), which is supposed to serialize against concurrent
> wake-ups.
> 
> Also see commit: b5bf9a90bbeb ("sched/core: Introduce set_special_state()")
> 
> How readily does this reproduce?

Running LTP oom01 [1] triggered it at least once in five attempts every time so
far on v4.20+. Have not tried much on v5.0-rc1 yet.

[1]
https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/mem/oom/oom01.c
