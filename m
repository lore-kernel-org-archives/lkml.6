Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1494096-1523022598-2-17410631161498354329
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523022597; b=sCGdKh+0eBFe4nObo+B2s3+4uMCVXzrV8lMSt9Od1yMhhnpovC
    jgJz/OWbt6Z82hxt3ns5e4/wLpnDFzSAzt1eaDI40rY5dIRqBJAUYThCTIp7No/S
    VArZ2qNPtwXd+HzwpgBtrvYMZepF3hMuUQzmWubws7oFNQuYRm3l8AX0q5Oo6jNl
    LawjE9/rN8Kx+3QCcQ2Uc3wR11AEzfcMQ/celZqb+Vb0o0igJDtuMlj8Ww9R07CQ
    cYFtMPrqMGQBOOShJ6I33QR73Tda+E758FcD9V7nIsw0o0rzAdLWr9zYVRmVAjr3
    Hw0BUwJ908V0qCgbYtRzQLn9Cuw7zF+QpwuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:references:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523022597;
    bh=W97HCk4As49GO13xzavnXnyIMr5QqNCJH5+n7Ye/hB8=; b=tewtOZqrcHPn
    D9Oxt/W1DtnTmwZMGx3xdHbZYKol5DcsVSnqZ7KBmq15ZVuWLPLfbFJ0kWV4Ds6U
    OK4hqrbFXvvPEWoL1KW6NgLCimxQRrBxcDwtaXwVg52h8gRv5j6HPlBYqMHEIREc
    V7MkdAOCa0c3ta6oqAXGX6KoAe4ubnAPFIYMAG8er1Lp92HqFNdy7ngMZ6rpVmxG
    U7E8wF7n+Q15rTPX7FgvtjielHsTkfl7mjrgUyOymAFS5jfnouvpylHihPwwwdyd
    WCRu5jaf8YM/t//sG2EF3LqXi8VHjTXpwE8vVMVPn6eeKNEo1MG8To0b0+FNWKPe
    t2I4y2xxVg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=AaH16CtH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=LoSQeCFF;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=AaH16CtH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=LoSQeCFF;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDjBiTCO1OpCDQqBItEntIVgx/cfJPhemQUB8bPUDe5MmjSCfiodq27SVjh4HVKAi7sd5sXbnfhmMpfPXSvH+U5c8cj6lxjTDWMCbHS6YtwuDWnHsMYU
    u3f0SDKmvBbe/l19EveE6t6MTJuhdor94hJzrklxyQ0uAe0kPwlyNLL3G/EtXvbkIlPGaHNeX8j7/77b1xcrvaZOczdLAWyDyXPOivY1WXDLZnhecwxX+/zD
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=vDLGeLTdAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=WtNs2ZdoMsjWpx52fioA:9
    a=P-0mSYa0wlPB4AU5:21 a=w_Mn3h1of716EOpB:21 a=QEXdDO2ut3YA:10
    a=1GWREyU_VPGQROUScI6K:22 a=AjGcO6oz07-iQ99wixmX:22 a=cvBusfyB2V15izCimMoJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757128AbeDFNto (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 09:49:44 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51608 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757099AbeDFNt0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 6 Apr 2018 09:49:26 -0400
X-Google-Smtp-Source: AIpwx49Rn/Mt+D2aDzRYcSfUY39OQjb0GFSeV3cpCLmtpDebYcWcLLXTq+G4YvPKf2FQnARYTqg7dA==
Subject: Re: [PATCH] arm: kgdb: fix NUMREGBYTES so that gdb_regs[] is the
 correct size
From: Daniel Thompson <daniel.thompson@linaro.org>
To: David Rivshin <drivshin@awxrd.com>
Cc: linux-arm-kernel@lists.infradead.org,
        kgdb-bugreport@lists.sourceforge.net,
        Jason Wessel <jason.wessel@windriver.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Rabin Vincent <rabin@rab.in>
References: <20180405200916.27964-1-drivshin@awxrd.com>
 <20180406132511.uzl6viazwaey4bem@holly.lan>
Message-ID: <eae3e959-60cb-a8cc-be97-f782d0c96f08@linaro.org>
Date: Fri, 6 Apr 2018 14:49:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180406132511.uzl6viazwaey4bem@holly.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 06/04/18 14:25, Daniel Thompson wrote:
> On Thu, Apr 05, 2018 at 04:09:16PM -0400, David Rivshin wrote:
>> From: David Rivshin <DRivshin@allworx.com>
>>
>> NUMREGBYTES (which is used as the size for gdb_regs[]) is incorrectly based
>> on DBG_MAX_REG_NUM instead of GDB_MAX_REGS. DBG_MAX_REG_NUM is the number
>> of total registers, while GDB_MAX_REGS is the number of 'unsigned longs'
>> it takes to serialize those registers. Since FP registers require 3
>> 'unsigned longs' each, DBG_MAX_REG_NUM is smaller than GDB_MAX_REGS.
>>
>> This causes GDB 8.0 give the following error on connect:
>> "Truncated register 19 in remote 'g' packet"
>>
>> This also causes the register serialization/deserialization logic to
>> overflow gdb_regs[], overwriting whatever follows.
>>
>> Fixes: 834b2964b7ab ("kgdb,arm: fix register dump")
>> Cc: <stable@vger.kernel.org> # 2.6.37+
>> Signed-off-by: David Rivshin <drivshin@allworx.com>
> 
> I pointed some trivial autotests at both gdb-7.12 and gdb-8.0. Results
> look good to me!
> 
> Tested-by: Daniel Thompson <daniel.thompson@linaro.org>

BTW I noticed that myself and Jason in the only "real people" in
To: . Most arch specific patches end up making their way upstream via 
the arch maintainer rather than via the kgdb tree so personally I would 
choose to the arch maintainers in the To: field as well.

I certainly think you will have to follow up via Russell King's patch 
tracker once you think its had enough time on the ML for review.


Daniel.


> 
>> ---
>>   arch/arm/include/asm/kgdb.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/include/asm/kgdb.h b/arch/arm/include/asm/kgdb.h
>> index 3b73fdcf3627a..8de1100d10674 100644
>> --- a/arch/arm/include/asm/kgdb.h
>> +++ b/arch/arm/include/asm/kgdb.h
>> @@ -77,7 +77,7 @@ extern int kgdb_fault_expected;
>>   
>>   #define KGDB_MAX_NO_CPUS	1
>>   #define BUFMAX			400
>> -#define NUMREGBYTES		(DBG_MAX_REG_NUM << 2)
>> +#define NUMREGBYTES		(GDB_MAX_REGS << 2)
>>   #define NUMCRITREGBYTES		(32 << 2)
>>   
>>   #define _R0			0
>>
>> base-commit: 0adb32858b0bddf4ada5f364a84ed60b196dbcda
>> -- 
>> 2.14.3
>>
