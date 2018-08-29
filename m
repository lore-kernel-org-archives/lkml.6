Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92135C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 01:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3497D2087C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 01:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="kpqSs1Xz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3497D2087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbeH2FBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 01:01:55 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:20899 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725723AbeH2FBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 01:01:54 -0400
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id w7T17FG1011845;
        Wed, 29 Aug 2018 10:07:15 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w7T17FG1011845
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1535504836;
        bh=v9SCePt63z/fx/VrWBl3eE2QeUXvOr5M/paGsiyaBEo=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=kpqSs1Xz0RjOgMzoVvqH+FlzA3OKwhZUXr+PRRfCyJcyigaJWQWnGV9FHcHoVax0h
         W9LlLfBLZJEVJvMMq3mGvpt+Xtz7LbbAmxnbuuH3MkDI3dLbc4wfjdN4g5nS9H3Jo/
         f9KXTZxk9TJ0b94TLEnsF56QOcCzCPexe54rhX1gIzDX6JgL5BCxzknS3kNitL43es
         zUega8ZQ9fcHjUAcHv42j5cdOnWRhGpE5ejztK3He6Cq5qhsAHHeGFmyvUrtIU8Ook
         9W6QUbyAN+axOTLi2DgmzNroaLAFbyVELvip4cehfmXP3xvUK1mdHi8U0G292xdEZy
         qg4ddM5RhSLwg==
X-Nifty-SrcIP: [209.85.222.48]
Received: by mail-ua1-f48.google.com with SMTP id g18-v6so2224446uam.6;
        Tue, 28 Aug 2018 18:07:15 -0700 (PDT)
X-Gm-Message-State: APzg51BACh7sZZRY5jcShBhfNyFsu4hN16bgdV4s9TAmzQ8rrYfxCAq+
        Wcv4GFaGtxr7cp1YZah/QvtVTOjU1IYgAms1/S4=
X-Google-Smtp-Source: ANB0VdY4UhwUcSLc2uCJsQWduHkek6RQyyJfsHJ9TYx7P+MAiVtkYrfBLPgXKRT3kYdOu45RQtGKkNXu2xj/7BTtjhQ=
X-Received: by 2002:ab0:6a6:: with SMTP id g35-v6mr2779027uag.16.1535504834597;
 Tue, 28 Aug 2018 18:07:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2642:0:0:0:0:0 with HTTP; Tue, 28 Aug 2018 18:06:34
 -0700 (PDT)
In-Reply-To: <c9066b61-6666-5adc-1f34-f8cea91864c5@infradead.org>
References: <4449cd91-fae5-caf1-a917-82e0c5f0aba8@infradead.org>
 <CAK7LNASyhKFp+AWQr-RWTRbMu78=G7Uj=350xrjq_Lht8MVYzQ@mail.gmail.com> <c9066b61-6666-5adc-1f34-f8cea91864c5@infradead.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 29 Aug 2018 10:06:34 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQPQd6DX6aXO6HtZ6kTXZk-71VH_Pwi=yE_UnhHs74yNw@mail.gmail.com>
Message-ID: <CAK7LNAQPQd6DX6aXO6HtZ6kTXZk-71VH_Pwi=yE_UnhHs74yNw@mail.gmail.com>
Subject: Re: [PATCH v3] modules_install: make missing $DEPMOD a warning
 instead of an error
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kbuild <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable <stable@vger.kernel.org>,
        Lucas De Marchi <lucas.demarchi@profusion.mobi>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Jessica Yu <jeyu@kernel.org>,
        Chih-Wei Huang <cwhuang@linux.org.tw>,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy

2018-08-29 4:55 GMT+09:00 Randy Dunlap <rdunlap@infradead.org>:
> On 08/23/2018 09:20 PM, Masahiro Yamada wrote:
>> Hi Randy,
>>
>>
>> 2018-08-24 3:13 GMT+09:00 Randy Dunlap <rdunlap@infradead.org>:
>>> From: Randy Dunlap <rdunlap@infradead.org>
>>>
>>> When $DEPMOD is not found, only print a warning instead of exiting
>>> with an error message and error status.
>>
>>
>> Could you add the motivation of this change
>> (as Nikolaus reported) ?
>>
>> Without the reason recorded in git-log,
>> somebody may wonder why this commit is useful.
>>
>
> Added for v4.

Thanks.




>> BTW, if System.map is missing, depmod is silently skipped.
>>
>>
>> I think if System.map is missing, a user is doing something wrong,
>> but you could do like this:
>>
>> $ make mrproper
>>    [snip]
>> $ make defconfig
>>    [snip]
>> $ make modules
>>    [snip]
>> $ make modules_install
>>   INSTALL drivers/thermal/x86_pkg_temp_thermal.ko
>>   INSTALL fs/efivarfs/efivarfs.ko
>>   INSTALL net/ipv4/netfilter/ipt_MASQUERADE.ko
>>   INSTALL net/ipv4/netfilter/iptable_nat.ko
>>   INSTALL net/ipv4/netfilter/nf_log_arp.ko
>>   INSTALL net/ipv4/netfilter/nf_log_ipv4.ko
>>   INSTALL net/ipv4/netfilter/nf_nat_ipv4.ko
>>   INSTALL net/ipv6/netfilter/nf_log_ipv6.ko
>>   INSTALL net/netfilter/nf_log_common.ko
>>   INSTALL net/netfilter/nf_nat.ko
>>   INSTALL net/netfilter/nf_nat_ftp.ko
>>   INSTALL net/netfilter/nf_nat_irc.ko
>>   INSTALL net/netfilter/nf_nat_sip.ko
>>   INSTALL net/netfilter/xt_LOG.ko
>>   INSTALL net/netfilter/xt_addrtype.ko
>>   INSTALL net/netfilter/xt_mark.ko
>>   INSTALL net/netfilter/xt_nat.ko
>>   DEPMOD  4.18.0+
>>
>>
>> The log looks like all the process went well,
>> but depmod is actually skipped because System.map is
>> generated by "make vmlinux"
>>
>>
>> What do you think we should do about this case?
>>
>> Skip depmod silently?
>> Make it fail?
>> Print noisy warning like missing depmod case?
>
> Since this shouldn't be happening, I prefer the noisy warning message
> like the missing depmod case.
>
> Do you want a separate patch for that?


Yes.  Could you send a patch?



-- 
Best Regards
Masahiro Yamada
