Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E4CAECE565
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 09:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F2E9206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 09:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fhqyy4PN";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="aRfbGmNH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F2E9206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbeIROgu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 10:36:50 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38868 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728467AbeIROgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 10:36:50 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8FC7C6079B; Tue, 18 Sep 2018 09:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537261509;
        bh=PHsZK+MijwtJPD4jb+RPqsAGR1DCK2kHKauuH9LQ9ao=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=fhqyy4PNgABH4kPH65Smu2RD90y556/1Ih8Wi/vyj+I4/LnxFQLKdmOR+051Vakgl
         omkMwFaNKIsBua9cEBO9WZ3hmyKywK5Scv37QufyWyKULMPNPXlwQbwVwwWNRh/qRB
         puvDHB8cVhFMIRamzlpQRG+gvEMFr6Mt2R2XLyH8=
Received: from [10.79.129.80] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 91E12607F7;
        Tue, 18 Sep 2018 09:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537261508;
        bh=PHsZK+MijwtJPD4jb+RPqsAGR1DCK2kHKauuH9LQ9ao=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=aRfbGmNHcfndjEIVUidsp5ZC5Gy+85RtAiDSkSVguTPbd1KoUmf+5vQh6Ky02RWy7
         fWkqrZ+cF+tRaNtb0hLmKNAm/pWMZM/WzifrfU+IBbhmx1Dax3VRWSBAkyi0Hfseue
         WQuXy5vSWD1akWzoaHIb95QsvNX/zon/ip8rbIDU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 91E12607F7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCH] tty/sysrq: Make local variable 'killer' in
 sysrq_handle_crash() global
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>, Matthias Kaehlcke <mka@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Manoj Gupta <manojgupta@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
References: <20180917213304.44476-1-mka@chromium.org>
 <a75e8a5d-25d0-83b8-6f7c-b80e69985b60@suse.cz>
 <ebea1697-cf33-675b-172c-3e80303a9ee9@codeaurora.org>
 <20180918072037.GA4442@kroah.com>
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <ccc91067-9718-8eb8-c197-b9c560daa5ce@codeaurora.org>
Date:   Tue, 18 Sep 2018 14:35:02 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180918072037.GA4442@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/18/2018 12:50 PM, Greg Kroah-Hartman wrote:
> On Tue, Sep 18, 2018 at 12:28:39PM +0530, Sai Prakash Ranjan wrote:
>> On 9/18/2018 11:41 AM, Jiri Slaby wrote:
>>> On 09/17/2018, 11:33 PM, Matthias Kaehlcke wrote:
>>>> sysrq_handle_crash() dereferences a NULL pointer on purpose to force
>>>> an exception, the local variable 'killer' is assigned to NULL and
>>>> dereferenced later. Clang detects the NULL pointer dereference at compile
>>>> time and emits a BRK instruction (on arm64) instead of the expected NULL
>>>> pointer exception. Change 'killer' to a global variable (and rename it
>>>> to 'sysrq_killer' to avoid possible clashes) to prevent Clang from
>>>> detecting the condition. By default global variables are initialized
>>>> with zero/NULL in C, therefore an explicit initialization is not needed.
>>>>
>>>> Reported-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
>>>> Suggested-by: Evan Green <evgreen@chromium.org>
>>>> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
>>>> ---
>>>>    drivers/tty/sysrq.c | 6 +++---
>>>>    1 file changed, 3 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
>>>> index 06ed20dd01ba..49fa8e758690 100644
>>>> --- a/drivers/tty/sysrq.c
>>>> +++ b/drivers/tty/sysrq.c
>>>> @@ -132,10 +132,10 @@ static struct sysrq_key_op sysrq_unraw_op = {
>>>>    #define sysrq_unraw_op (*(struct sysrq_key_op *)NULL)
>>>>    #endif /* CONFIG_VT */
>>>> +char *sysrq_killer;
>>>> +
>>>>    static void sysrq_handle_crash(int key)
>>>>    {
>>>> -	char *killer = NULL;
>>>> -
>>>>    	/* we need to release the RCU read lock here,
>>>>    	 * otherwise we get an annoying
>>>>    	 * 'BUG: sleeping function called from invalid context'
>>>> @@ -144,7 +144,7 @@ static void sysrq_handle_crash(int key)
>>>>    	rcu_read_unlock();
>>>>    	panic_on_oops = 1;	/* force panic */
>>>>    	wmb();
>>>> -	*killer = 1;
>>>> +	*sysrq_killer = 1;
>>>
>>> Just because a static analyzer is wrong? Oh wait, even compiler is
>>> wrong. At least make it a static global. Or what about OPTIMIZER_HIDE_VAR?
>>>
>>
>> static global does not work, clang still inserts brk. As for
>> OPTIMIZE_HIDE_VAR, it seems to work.
>> But, I dont think it is defined for clang in which case it defaults to using
>> barrier(). There is already one wmb(), so will it be right?
> 
> Ick, why is this needed at all?  Why are we trying to "roll our own
> panic" in this code?
> 

Hi Greg, do you mean like why there is a killer var at all or why this 
change is required?

Below are some additional info about this issue:

CLANG generated:

   ffffff800842bc1c <sysrq_handle_crash>:
   ffffff800842bc1c:       a9bf7bfd        stp     x29, x30, [sp,#-16]!
   ffffff800842bc20:       910003fd        mov     x29, sp
   ffffff800842bc24:       97f1a34e        bl      ffffff800809495c 
<_mcount>
   ffffff800842bc28:       97f38876        bl      ffffff800810de00 
<__rcu_read_unlock>
   ffffff800842bc2c:       f0006888        adrp    x8, ffffff800913e000 
<reset_devices>
   ffffff800842bc30:       320003e9        orr     w9, wzr, #0x1
   ffffff800842bc34:       b9091109        str     w9, [x8,#2320]
   ffffff800842bc38:       d5033e9f        dsb     st
   ffffff800842bc3c:       d4200020        brk     #0x1          <----


GCC generated:

ffffff8008452f60 <sysrq_handle_crash>:
ffffff8008452f60:       a9bf7bfd        stp     x29, x30, [sp,#-16]!
ffffff8008452f64:       910003fd        mov     x29, sp
ffffff8008452f68:       aa1e03e0        mov     x0, x30
ffffff8008452f6c:       97f1078c        bl      ffffff8008094d9c <_mcount>
ffffff8008452f70:       97f2f2cc        bl      ffffff800810faa0 
<__rcu_read_unlock>
ffffff8008452f74:       900067e1        adrp    x1, ffffff800914e000 
<reset_devices>
ffffff8008452f78:       52800020        mov     w0, #0x1 
        // #1
ffffff8008452f7c:       b9096820        str     w0, [x1,#2408]
ffffff8008452f80:       d5033e9f        dsb     st
ffffff8008452f84:       d2800001        mov     x1, #0x0 
        // #0
ffffff8008452f88:       39000020        strb    w0, [x1]
ffffff8008452f8c:       a8c17bfd        ldp     x29, x30, [sp],#16
ffffff8008452f90:       d65f03c0        ret

Trigger sysrq crash:

localhost ~ # echo c > /proc/sysrq-trigger
  [   78.320401] sysrq: SysRq : Trigger a crash
  [   78.324752] Unexpected kernel BRK exception at EL1
  [   78.329691] Unhandled debug exception: ptrace BRK handler 
(0xf2000001) at 0x000000000e25c368
  [   78.338384] Internal error: : 0 [#1] PREEMPT SMP

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
