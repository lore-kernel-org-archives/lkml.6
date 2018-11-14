Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F01C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA6E42243E
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rzSADA1f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA6E42243E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbeKOIs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:48:59 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38283 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728526AbeKOIs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:48:58 -0500
Received: by mail-pl1-f193.google.com with SMTP id p4-v6so8470623plo.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 14:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jfV/SVbTViduHFfhbk95B79doBTUZA01+hEC41aaoNM=;
        b=rzSADA1fw5biFsC0NfGvN/TH0CdcaEBSbubW7HXlpeoPlRELWdW7T8K82fZTyEE80Q
         FBcbIU4gXRFhtGOtFwtDC/z7TnbknGDp86SR9ipNYWnWNBsQyAo/lqWVXIzB4H/ll9ul
         Mco6WnXQMNTwmWt8exR/gSkYJBqSZxPWMG1HSGMY+Z8U2BTMLzcoI/VbmVjjOsL2Nfme
         CBiRW52ue8sowWy5zo6grimf2FMqX9mskcXJIP2sO+10Z007kafY9Q3gXQSeF3ee4Bqc
         LQ3D903BI7E/jc7RYdPRo8LwvYZbzobzdTbddWqXu7fBaXrF+MOtV+6qpB9s2pPSgU54
         v9NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=jfV/SVbTViduHFfhbk95B79doBTUZA01+hEC41aaoNM=;
        b=jj6L9U6GkybxyoudQ5YpLEd4CfDE7KcTNGICfbtthQKCvxMtLjDGvhOGCt2Rx8WzgC
         DAvNAh8uC5j9Y5cH0UteMWZbQseGb/Wzj4jQ7ZbU1gpMQWd44z2hAcKUi/wpZaJCcnD6
         ABbsziOKwkeYeO2NFL18eIVqlC+c+ExGgeLwCxjbaJu3LaVdy4MlCYNDA6t7j6R8Bvee
         lNDm133fMlzStiMF3UtS51dAvCdEk1XCaulxPCmEWDkyuJjvRvbI8CY4GuuQalpXzXSp
         BBOJDIIFgo8XPARykrmCjL7Pa9v4UgBUPPWpSIcmssp2oJhCjJqIC6wfJwOT/DY6YWzx
         AHlA==
X-Gm-Message-State: AGRZ1gJ1ROFHLQ7gJyxYAiZ2YWA00qzGcE3Thw8GpMfdTHYTGRYdNiKv
        4oxafKIZtWBGwij2gECW5OE=
X-Google-Smtp-Source: AJdET5fUbRX2wysKii5KeuJMeDSFTao3PCAnyYViwr2EgUQVkbA5bKuuPFaIgWAtqP3vNVLZ1s6WVQ==
X-Received: by 2002:a17:902:6185:: with SMTP id u5mr2735835plj.194.1542235427018;
        Wed, 14 Nov 2018 14:43:47 -0800 (PST)
Received: from [10.67.49.62] (igp-prod-emp-gw.vpn.broadcom.com. [192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id f62sm23782468pgc.67.2018.11.14.14.43.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 14:43:46 -0800 (PST)
Subject: Re: ARM builtin perf tests for breakpoint failures
To:     Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mark.rutland@arm.com, al.cooperx@gmail.com, tony@atomide.com,
        linux@armlinux.org.uk
References: <2433ea10-8bdc-f9bc-8d53-f6bda4018564@gmail.com>
 <20181114223442.GA4399@brain-police>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <20b6b6f6-0c1f-e31d-a425-e84c11995185@gmail.com>
Date:   Wed, 14 Nov 2018 14:43:39 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181114223442.GA4399@brain-police>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On 11/14/18 2:34 PM, Will Deacon wrote:
> Hi Florian,
> 
> On Wed, Nov 14, 2018 at 12:21:12PM -0800, Florian Fainelli wrote:
>> I have been trying to debug some perf builtin tests on ARM 32-bit and
>> found that "Breakpoint overflow signal handler" and "Breakpoint overflow
>> sampling" were failing, but there are a number of reasons for that and
>> they may fail in seemingly unexpected ways.
>>
>> My perf binary is built in Thumb2 because that is what the toolchain
>> produces by default. Going through the rabbit hole, I found the
>> following failure scenarios.
>>
>> 1) If __test_function()'s addresss has the Thumb bit set, then we set a
>> breakpoint length (bp_len = sizeof(long)) which makes us fail to
>> validate the event in hw_breakpoint_arch_parse() and we return -EINVAL
>> from SYS_perf_event_open(). This is because the offset computed has a
>> value of 1 (function address is e.g:  0x0004c169), but we requested a
>> bp_len of 4. The test fails right away.
>>
>> 2) If we correct the test such that if addr & 1 == true then we set
>> bp_len = 2, then we can see that the test runs to completion, but the
>> perf breakpoint event count returns 0 and indeed, no SIGIO is ever
>> delivered. This is presumably because of the alignment_mask value of 0x3
>> in hw_breakpoint_arch_parse() which would strip the Thumb bit and not
>> allow matching it when set assign info->address &= ~alignment_mask. We
>> would indeed not have the HW hit that breakpoint at all.
>>
>> 3) If we keep the fix from 2) and also change the the alignment_mask to
>> 0x2 to preserve the Thumb bit, then we can run into what is described as
>> 4) below.
>>
>> 4) if __test_function()'s address does not have the Thumb bit set (which
>> surprisingly can happen even if test_function does, go figure), then we
>> will set a bp_len = 4, and then we are just stuck in an infinite SIGIO
>> delivery that looks like this:
>>
>> [pid  1859] perf_event_open(0xbebee790, 0, -1, -1, 0x8 /* PERF_FLAG_???
>> */) = 3
>> [pid  1859] fcntl64(3, F_SETFL, O_RDWR|O_NONBLOCK|O_ASYNC) = 0
>> [pid  1859] fcntl64(3, F_SETSIG, 0x1d)  = 0
>> [pid  1859] fcntl64(3, F_SETOWN, 1859)  = 0
>> [pid  1859] ioctl(3, PERF_EVENT_IOC_RESET, 0) = 0
>> [pid  1859] ioctl(3, PERF_EVENT_IOC_ENABLE, 0) = 0
>> [pid  1859] --- SIGIO {si_signo=SIGIO, si_code=POLL_IN, si_band=65} ---
>> [pid  1859] rt_sigreturn()
>>
>> and on and on, we can't even see gettimeofday() begin called in that case.
>>
>> This is observable on both 4.9.135 and 4.19 on ARMv7 and ARMv8 CPUs
>> running in AArch32.
>>
>> I am not clear how to fix that properly, since there appears to be a
>> nesting of problems here.
> 
> This came up a few years ago iirc and I think most of this boils down to the
> fact that we require the overflow handler to do the stepping on arm/arm64,
> which is relied upon by GDB/ptrace. The hw_breakpoint code is a complete
> disaster so my preference would be to rip out the perf part and just
> implement something directly in ptrace, but it's a pretty horrible job.
> 
> Are you actually using the perf interface to hw_breakpoint for something
> useful?

In fact, not really, I was just looking at why these tests were failing
and was wondering what the reasoning behind could be and if it was
worth/possible fixing them. I was a bit worried because on 4.19, the
overflow test can lead to a RCU stall.

Maybe this will be good enough as a "solution" for now?

diff --git a/tools/perf/tests/bp_signal.c b/tools/perf/tests/bp_signal.c
index a467615c5a0e..3b5471ea2331 100644
--- a/tools/perf/tests/bp_signal.c
+++ b/tools/perf/tests/bp_signal.c
@@ -296,7 +296,7 @@ bool test__bp_signal_is_supported(void)
  * instruction breakpoint using the perf event interface.
  * Once it's there we can release this.
  */
-#if defined(__powerpc__) || defined(__s390x__)
+#if defined(__powerpc__) || defined(__s390x__) || defined(__arm__)
        return false;
 #else
        return true;


-- 
Florian
