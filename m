Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2879036-1517589852-2-4333838496360657330
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517589851; b=kZ9Ep/y5jP2y5rLNbL09e2rNRAn2mTN32SDJ/GfAcvcEqh5
    rViONb+ka3AsWyXmpuN6DCtwX2D7d3XVbwnRyj/kqpkDxfCnylrPcKwY755Hvydy
    wROpa+M10enJt2SmOgZklAnswY5khdHLiy0pKIpRXHRxwgW7QVyDuJ89FhbY01I7
    wiUcWhTt385ARWAwO72fXvbsWnWblgsDB/yNP7A8iOr9w9WQnh016cnQ2O5rWysK
    9v4eYLmsr2b/mR4sFRwgcF+lbTXhUIU945dB1zuWwvz+3rYnn17U6Q+1YnAqiO8/
    2BI6x2RGx1Ao1hWrE8KEHVs0QKdnNrS0T+mO8sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1517589851; bh=zoRm094oUBSB72ZCJbvS6KM4DoWjPn1yZ/cGFn
    siCYo=; b=JozuD5SFcRQiCUEVXyjlqwlaZPT9aaxEA73OP4oHsY4UGoC3Na+MQS
    bnhFJ73aKjx3x96hjytDI+DAFLxomavnmAMADKiEyDZp+1Ti3igVloCQzzWKx5kg
    0P8VK34eKgYbIaly4tUeAo3SohwQB7XnaOihfLqd+DafCDgHkUVfX6B0UybNriMb
    RVR1xXMax7Wn1OOm/H6sxSsPpi43MBc77DSl0610MTvVG/Ro9XaaNb5i1HMErCId
    upS9ftE1sVYWyLg2Xui3X/ETJys6DoHiTcQQr7LjHBPV5a4wpDQUcNlsBr7zeazI
    wYLrdN4u6E0DF7TWHi8Poot7BKiyG0Sg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=kNHWUrXi x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=T244gvAd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=kNHWUrXi x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=T244gvAd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751821AbeBBQoK (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 11:44:10 -0500
Received: from mail-ot0-f195.google.com ([74.125.82.195]:34756 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751732AbeBBQoJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 11:44:09 -0500
X-Google-Smtp-Source: AH8x226og/pqqQRTSzKEyf4gQxMfzXS44opGplcLfkoS8dvRC710x/2n1b0jXQCH/lSW3H7sdKXDHJoLivE/KVapvOo=
MIME-Version: 1.0
In-Reply-To: <CAK7LNATo8y_jk0xth9xiLqGTt_f2w_ocQ2agpZqBgK_tO-MOtg@mail.gmail.com>
References: <20180202154104.1522809-1-arnd@arndb.de> <20180202154104.1522809-2-arnd@arndb.de>
 <CAK7LNATo8y_jk0xth9xiLqGTt_f2w_ocQ2agpZqBgK_tO-MOtg@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 2 Feb 2018 17:44:08 +0100
X-Google-Sender-Auth: 6Vs2SgCJZQ-fd2ZG2dadUng1IOs
Message-ID: <CAK8P3a1hxVtsk6iCnumL=NQZmphSxcOfLSNPKg4a3pJ-Mgwf1A@mail.gmail.com>
Subject: Re: [PATCH 2/2] Kbuild: always define endianess in kconfig.h
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Pitre <nico@linaro.org>,
        Andi Kleen <ak@linux.intel.com>,
        Babu Moger <babu.moger@oracle.com>,
        Will Deacon <will.deacon@arm.com>,
        stable <stable@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 2, 2018 at 5:31 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> 2018-02-03 0:40 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:

>> ---
>>  include/linux/kconfig.h | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/include/linux/kconfig.h b/include/linux/kconfig.h
>> index fec5076eda91..cc8fa109cfa3 100644
>> --- a/include/linux/kconfig.h
>> +++ b/include/linux/kconfig.h
>> @@ -4,6 +4,12 @@
>>
>>  #include <generated/autoconf.h>
>>
>> +#ifdef CONFIG_CPU_BIG_ENDIAN
>> +#define __BIG_ENDIAN 4321
>> +#else
>> +#define __LITTLE_ENDIAN 1234
>> +#endif
>> +
>>  #define __ARG_PLACEHOLDER_1 0,
>>  #define __take_second_arg(__ignored, val, ...) val
>>
>> --
>> 2.9.0
>>
>
> If all architectures define
> CONFIG_CPU_BIG_ENDIAN or CONFIG_CPU_LITTLE_ENDIAN,
> is it possible to use this for endian test?
>
> i.e.
>
> Is it possible to replace like this?
>    #ifdef __BIG_ENDIAN       ->  #ifdef CONFIG_CPU_BIG_ENDIAN
>
>    #ifdef __LITTLE_ENDIAN     -> #ifdef CONFIG_CPU_LITTLE_ENDIAN

I believe we don't always define CONFIG_CPU_LITTLE_ENDIAN,
but it would work in principle. The main issue here is changing so
many files:

$ git grep -wl '__\(BIG\|LITTLE\)_ENDIAN' | wc -l
418

$ git grep -wl 'CONFIG_CPU_\(BIG\|LITTLE\)_ENDIAN' | wc -l
145

      Arnd
