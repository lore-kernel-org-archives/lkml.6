Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-923319-1524476188-2-9209392858997598713
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524476187; b=pU1PuGcQmhms+FDYcIoAsC2royZS6j3vC5cCBPTBOjrv3xV2xg
    ENSXb3QUjdbXT3wQqL83QD0aESvMpDhY+DGHq4Wo0MdyzN6LRyri4hpycrCP1m+G
    2+Hu+7Tdj1fhTW4+gCkWg38h8kiZsk4FZ8k+K4KCzZFe5dLym/JrqgHW2FGLyJw8
    uIW+2GYN+EAWDKyuhJ7bO6aR0MrRxjd/549lEJ9DQRfufMiNfaR9KhJqzUwPkewH
    EY43EOLafnkUMSgRr0uw5iZ1GihZL0i1mkxQVaaCpqWBcFb02v0gETjBYWSm/Q6/
    BQ0rxO5dDk1cC+4oXupCSIiWP51GgNMIdrNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524476187;
    bh=6PCM6M3egyyahRuWHo4KUvQAiFWK6lsPWMRkAYZk5+c=; b=iLk44z/CXHC3
    T99EzeTrZ5Uh2F/dQ0GrLs9RT4rZYtBogQ1uLL5cROgYa2LyXz73pXsXzjB+F0uu
    5ZlplRksufud8sLzSpZtMr+HIFmQvCPzNh8u57x4aKe2v///5qx48D8y0EBkUw7c
    o9m95i5cPRlffbQdl3/fyIEesv6RAPV0rO0FY4P+N2xdVcA4MimHvYEvg6oT35M6
    hjom/PyG5/reDX1HoQDNrEQBGIFJ00Unozbqm5BCX5SO1glCLGInIzoF7BT+ssyU
    ypvKTeIq9+i5Z8R9Js1+cYC1tuft1/A7W/YLWV7oU7XkbE/pI9FKVqHMOwr0KY+O
    wan5gADbyQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mips.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mips.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mips.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mips.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIHPz1Am0lFgOmAUFkezQpoNf5/ooWxRUkJzsL26uBED1pQkJDKXnHbM2pl20rn8QUNrwohdde7Xa8CDkNq0/buKrUvue6b4Ki1IZFVM2OIDvsrvyyh4
    ovih1eKnIzb8LiWem4DM5XxI1rmc0S4VlsRyhylYfD/NNazZ3+eujK/I9oSRkew0zMkH6Fvy3mzXXEcEwXoyNlVVl6HkLESuC1UJ6vEV307d8BXOCdw6x8vc
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IhDdiLrqHVMA:10 a=IkcTkHD0fZMA:10
    a=Kd1tUaAdevIA:10 a=P-IC7800AAAA:8 a=ag1SF4gXAAAA:8 a=gPJu0pBYAAAA:8
    a=VwQbUJbxAAAA:8 a=WPyIoOwQAAAA:8 a=w5guViyUhFAb5q9mwOIA:9 a=QEXdDO2ut3YA:10
    a=d3PnA9EDa4IxuAV0gXij:22 a=Yupwre4RP9_Eg_Bd0iYG:22 a=AlIIF0cMT2hfDT4axODj:22
    a=AjGcO6oz07-iQ99wixmX:22 a=S-HzPIwwDS8t1QcwSuWs:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754243AbeDWJgY (ORCPT <rfc822;greg@kroah.com>);
        Mon, 23 Apr 2018 05:36:24 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.154.210]:60521 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754235AbeDWJgX (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Apr 2018 05:36:23 -0400
Subject: Re: [PATCH 3.18 45/52] MIPS: memset.S: Fix clobber of v1 in
 last_fixup
To: Heiher <r@hev.cc>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
References: <20180422135315.254787616@linuxfoundation.org>
 <20180422135317.436671003@linuxfoundation.org>
 <CAHirt9jOibozCFgm8-5bXukSvRBwvxz7ctZYvugQuxnfLFCeLQ@mail.gmail.com>
From: Matt Redfearn <matt.redfearn@mips.com>
Message-ID: <8293aba6-81fa-6552-529e-030cc41c705f@mips.com>
Date: Mon, 23 Apr 2018 10:36:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAHirt9jOibozCFgm8-5bXukSvRBwvxz7ctZYvugQuxnfLFCeLQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.155.41]
X-ClientProxiedBy: mipsdag02.mipstec.com (10.20.40.47) To
 mipsdag02.mipstec.com (10.20.40.47)
X-BESS-ID: 1524476168-382908-3433-257490-1
X-BESS-VER: 2018.5-r1804181636
X-BESS-Apparent-Source-IP: 12.201.5.32
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.192283
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 23/04/18 08:16, Heiher wrote:
> Hi,
> 
> IIRC, The v1 is a temporary register, value is not preserved across
> function calls.

v1 is conventionally used for a function return value and as such can be 
changed by called functions. However, bzero is called from inline 
assembly and v1 is not in the clobbers list
https://elixir.bootlin.com/linux/v4.17-rc1/source/arch/mips/include/asm/uaccess.h#L652
So the calling function does not expect that register to have been used 
and can legitimately expect its value to remain after the function call, 
which without this patch, it does not - as demonstrated by the test code.

Thanks,
Matt

> 
> I don't see any functions that generated by compiler to restore values
> of v1 after clobbered it.
> 
> On Sun, Apr 22, 2018 at 9:54 PM, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
>> 3.18-stable review patch.  If anyone has any objections, please let me know.
>>
>> ------------------
>>
>> From: Matt Redfearn <matt.redfearn@mips.com>
>>
>> commit c96eebf07692e53bf4dd5987510d8b550e793598 upstream.
>>
>> The label .Llast_fixup\@ is jumped to on page fault within the final
>> byte set loop of memset (on < MIPSR6 architectures). For some reason, in
>> this fault handler, the v1 register is randomly set to a2 & STORMASK.
>> This clobbers v1 for the calling function. This can be observed with the
>> following test code:
>>
>> static int __init __attribute__((optimize("O0"))) test_clear_user(void)
>> {
>>    register int t asm("v1");
>>    char *test;
>>    int j, k;
>>
>>    pr_info("\n\n\nTesting clear_user\n");
>>    test = vmalloc(PAGE_SIZE);
>>
>>    for (j = 256; j < 512; j++) {
>>      t = 0xa5a5a5a5;
>>      if ((k = clear_user(test + PAGE_SIZE - 256, j)) != j - 256) {
>>          pr_err("clear_user (%px %d) returned %d\n", test + PAGE_SIZE - 256, j, k);
>>      }
>>      if (t != 0xa5a5a5a5) {
>>         pr_err("v1 was clobbered to 0x%x!\n", t);
>>      }
>>    }
>>
>>    return 0;
>> }
>> late_initcall(test_clear_user);
>>
>> Which demonstrates that v1 is indeed clobbered (MIPS64):
>>
>> Testing clear_user
>> v1 was clobbered to 0x1!
>> v1 was clobbered to 0x2!
>> v1 was clobbered to 0x3!
>> v1 was clobbered to 0x4!
>> v1 was clobbered to 0x5!
>> v1 was clobbered to 0x6!
>> v1 was clobbered to 0x7!
>>
>> Since the number of bytes that could not be set is already contained in
>> a2, the andi placing a value in v1 is not necessary and actively
>> harmful in clobbering v1.
>>
>> Reported-by: James Hogan <jhogan@kernel.org>
>> Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
>> Cc: Ralf Baechle <ralf@linux-mips.org>
>> Cc: linux-mips@linux-mips.org
>> Cc: stable@vger.kernel.org
>> Patchwork: https://patchwork.linux-mips.org/patch/19109/
>> Signed-off-by: James Hogan <jhogan@kernel.org>
>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>
>> ---
>>   arch/mips/lib/memset.S |    2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> --- a/arch/mips/lib/memset.S
>> +++ b/arch/mips/lib/memset.S
>> @@ -210,7 +210,7 @@
>>
>>   .Llast_fixup\@:
>>          jr              ra
>> -       andi            v1, a2, STORMASK
>> +        nop
>>
>>   .Lsmall_fixup\@:
>>          PTR_SUBU        a2, t1, a0
>>
>>
>>
> 
> 
> 
