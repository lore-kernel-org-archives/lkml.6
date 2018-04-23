Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-906599-1524476736-2-8838458093151293238
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='cc',
  MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524476735; b=eebUpfURwadU394ATWMl+5Z3UHM6auIGu7CV0yDiqCi734/OBb
    NtSsv+qOdGeLeO/ukEXX2h6y+oAWAuZiFwctaGfAwCzFvRP9oGXewkViFTn6yOgS
    jU0eyo01qvxpJTEy+zmBiTjT/h9vh/Oqr4g0nCqEK5f0vqQ4XvDNuqzFJn3X0Fjg
    UI8vXG3zuOdh2WzdnjHoiEi8It2nGF12j5E8uuWbc1bSvI3sRJJYvV1jnN5yxK3b
    3POoHKKvV+6PjBP5R0eI7iM2AwpMWdI33EvVDhPHp+yVN0QDIyjQEgangu//ClBb
    YZ43EPRzuW4Nkeqf82rpFiZLhUac8BrmlNWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1524476735; bh=t7DTZPv8cWgnRte7OHnI6lYKlO7thziQzD/+GfyHM6
    Y=; b=Vs+KTEzE+9Rzi2DFKnt05JF1+d0iUIr9aYDwQj57rEXZU/dx61k9vVjpML
    6QhHg+uxmtN8rhKJ1GThIHxX274UBMcOnuKzKKWH9eq6gHDQ/kP35OLNlNZ0t0KC
    Tt5XBrQV9X8kDrQiZlYdSfezSIj2k6k+fCkxwygI0ydl81YJx2xcuiy3nj+d6bBM
    grmzfGUpkNGf9bw1LVWLOx13oM08lqTQn//4FoaTLg112eFV2dkzyQ/mPWV8p8XG
    NE2suf3oNbL+VbXdK9CqOwNrDo/r+FHCuutWBEuA1nLMHRwGlIhHuqRehxbbiXiZ
    x92Z2XA8EMenfRzqNsTe09DwsA2g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=hev-cc.20150623.gappssmtp.com header.i=@hev-cc.20150623.gappssmtp.com header.b=rVOyY3QD x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=hev.cc;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=qHdKeROj;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=hev.cc header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-90 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=hev-cc.20150623.gappssmtp.com header.i=@hev-cc.20150623.gappssmtp.com header.b=rVOyY3QD x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=hev.cc;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=qHdKeROj;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=hev.cc header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-90 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJn65CFSSbV0ftgts+826+4SxeXeLXxa+RpO7u2teMxnJEdHFOrGQiCG1fCbrKM6bm5n2s3aAc+7TyWqDPXIN4TIRhKo5xnmucQRwj8A1x2Q11fD4xBo
    tfS1HoBjmxVaQZqDR2LmYwau6rBokO3/wqJM4oL5eFjOtq3GlZcpymdXg8FYMzZ81i4r0HV/Gf/jrtHd5Tk8J6ohIVQnr4tD/ZokFwdI0S5LXZ67IFtSqNCP
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=aF4QxoVWhU8A:10 a=IkcTkHD0fZMA:10
    a=MKtGQD3n3ToA:10 a=Kd1tUaAdevIA:10 a=Fzw85mIY04MA:10 a=ZZnuYtJkoWoA:10
    a=gPJu0pBYAAAA:8 a=P-IC7800AAAA:8 a=ag1SF4gXAAAA:8 a=VwQbUJbxAAAA:8
    a=WPyIoOwQAAAA:8 a=IgMiUd-jAAAA:8 a=dwrQFdSqG07kbD8sU6YA:9 a=QEXdDO2ut3YA:10
    a=-FEs8UIgK8oA:10 a=NWVoK91CQyQA:10 a=AlIIF0cMT2hfDT4axODj:22
    a=d3PnA9EDa4IxuAV0gXij:22 a=Yupwre4RP9_Eg_Bd0iYG:22 a=AjGcO6oz07-iQ99wixmX:22
    a=S-HzPIwwDS8t1QcwSuWs:22 a=lJAw6gxB7vXy5UHAmKbH:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754304AbeDWJpc (ORCPT <rfc822;greg@kroah.com>);
        Mon, 23 Apr 2018 05:45:32 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:38254 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754081AbeDWJpa (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Apr 2018 05:45:30 -0400
X-Google-Smtp-Source: AIpwx4+EeNgHmbJO79fqCjdyaXL8BPNHesglrTwRdfbugtAkr90sMADPMGFJHSlLFsWHOkOXdbix99KMISeOilCe1lk=
MIME-Version: 1.0
X-Originating-IP: [172.247.34.138]
In-Reply-To: <8293aba6-81fa-6552-529e-030cc41c705f@mips.com>
References: <20180422135315.254787616@linuxfoundation.org> <20180422135317.436671003@linuxfoundation.org>
 <CAHirt9jOibozCFgm8-5bXukSvRBwvxz7ctZYvugQuxnfLFCeLQ@mail.gmail.com> <8293aba6-81fa-6552-529e-030cc41c705f@mips.com>
From: Heiher <r@hev.cc>
Date: Mon, 23 Apr 2018 17:45:28 +0800
Message-ID: <CAHirt9jWrkBk3btjxe1VVW_XSZYkGJMpc0vM3_OP5ugqrR2G=w@mail.gmail.com>
Subject: Re: [PATCH 3.18 45/52] MIPS: memset.S: Fix clobber of v1 in last_fixup
To: Matt Redfearn <matt.redfearn@mips.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

Now I understand, thank you explain.

On Mon, Apr 23, 2018 at 5:36 PM, Matt Redfearn <matt.redfearn@mips.com> wrote:
>
>
> On 23/04/18 08:16, Heiher wrote:
>>
>> Hi,
>>
>> IIRC, The v1 is a temporary register, value is not preserved across
>> function calls.
>
>
> v1 is conventionally used for a function return value and as such can be
> changed by called functions. However, bzero is called from inline assembly
> and v1 is not in the clobbers list
> https://elixir.bootlin.com/linux/v4.17-rc1/source/arch/mips/include/asm/uaccess.h#L652
> So the calling function does not expect that register to have been used and
> can legitimately expect its value to remain after the function call, which
> without this patch, it does not - as demonstrated by the test code.
>
> Thanks,
> Matt
>
>
>>
>> I don't see any functions that generated by compiler to restore values
>> of v1 after clobbered it.
>>
>> On Sun, Apr 22, 2018 at 9:54 PM, Greg Kroah-Hartman
>> <gregkh@linuxfoundation.org> wrote:
>>>
>>> 3.18-stable review patch.  If anyone has any objections, please let me
>>> know.
>>>
>>> ------------------
>>>
>>> From: Matt Redfearn <matt.redfearn@mips.com>
>>>
>>> commit c96eebf07692e53bf4dd5987510d8b550e793598 upstream.
>>>
>>> The label .Llast_fixup\@ is jumped to on page fault within the final
>>> byte set loop of memset (on < MIPSR6 architectures). For some reason, in
>>> this fault handler, the v1 register is randomly set to a2 & STORMASK.
>>> This clobbers v1 for the calling function. This can be observed with the
>>> following test code:
>>>
>>> static int __init __attribute__((optimize("O0"))) test_clear_user(void)
>>> {
>>>    register int t asm("v1");
>>>    char *test;
>>>    int j, k;
>>>
>>>    pr_info("\n\n\nTesting clear_user\n");
>>>    test = vmalloc(PAGE_SIZE);
>>>
>>>    for (j = 256; j < 512; j++) {
>>>      t = 0xa5a5a5a5;
>>>      if ((k = clear_user(test + PAGE_SIZE - 256, j)) != j - 256) {
>>>          pr_err("clear_user (%px %d) returned %d\n", test + PAGE_SIZE -
>>> 256, j, k);
>>>      }
>>>      if (t != 0xa5a5a5a5) {
>>>         pr_err("v1 was clobbered to 0x%x!\n", t);
>>>      }
>>>    }
>>>
>>>    return 0;
>>> }
>>> late_initcall(test_clear_user);
>>>
>>> Which demonstrates that v1 is indeed clobbered (MIPS64):
>>>
>>> Testing clear_user
>>> v1 was clobbered to 0x1!
>>> v1 was clobbered to 0x2!
>>> v1 was clobbered to 0x3!
>>> v1 was clobbered to 0x4!
>>> v1 was clobbered to 0x5!
>>> v1 was clobbered to 0x6!
>>> v1 was clobbered to 0x7!
>>>
>>> Since the number of bytes that could not be set is already contained in
>>> a2, the andi placing a value in v1 is not necessary and actively
>>> harmful in clobbering v1.
>>>
>>> Reported-by: James Hogan <jhogan@kernel.org>
>>> Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
>>> Cc: Ralf Baechle <ralf@linux-mips.org>
>>> Cc: linux-mips@linux-mips.org
>>> Cc: stable@vger.kernel.org
>>> Patchwork: https://patchwork.linux-mips.org/patch/19109/
>>> Signed-off-by: James Hogan <jhogan@kernel.org>
>>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>
>>> ---
>>>   arch/mips/lib/memset.S |    2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> --- a/arch/mips/lib/memset.S
>>> +++ b/arch/mips/lib/memset.S
>>> @@ -210,7 +210,7 @@
>>>
>>>   .Llast_fixup\@:
>>>          jr              ra
>>> -       andi            v1, a2, STORMASK
>>> +        nop
>>>
>>>   .Lsmall_fixup\@:
>>>          PTR_SUBU        a2, t1, a0
>>>
>>>
>>>
>>
>>
>>
>



-- 
Best regards!
Hev
https://hev.cc
