Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58CBFC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20CFC20827
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:40:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20CFC20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbeKEU7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 15:59:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43534 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727048AbeKEU7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 15:59:15 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 899D930821F6;
        Mon,  5 Nov 2018 11:39:57 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DC39D26352;
        Mon,  5 Nov 2018 11:39:56 +0000 (UTC)
Subject: Re: [PATCH] kdb: fix strncpy warning
To:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jason Wessel <jason.wessel@windriver.com>
Cc:     Olof Johansson <olof@lixom.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kgdb-bugreport@lists.sourceforge.net
References: <20181102212405.5911-1-olof@lixom.net>
 <20181103153925.ozyb4pqnixu6hw4z@holly.lan>
 <CAOesGMjW0Ekbo0HmJak81zytLkSMeZq7=Mk8oTT8eVEED9=gEA@mail.gmail.com>
From:   Prarit Bhargava <prarit@redhat.com>
Message-ID: <2b728c10-1c76-5e7f-1aa1-c7c1dc4a7125@redhat.com>
Date:   Mon, 5 Nov 2018 06:39:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAOesGMjW0Ekbo0HmJak81zytLkSMeZq7=Mk8oTT8eVEED9=gEA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Mon, 05 Nov 2018 11:39:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/03/2018 12:54 PM, Olof Johansson wrote:
> On Sat, Nov 3, 2018 at 8:39 AM Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
>>
>> On Fri, Nov 02, 2018 at 02:24:05PM -0700, Olof Johansson wrote:
>>> kdb does a strncpy(a, b, strlen(b)+1), which makes no sense. Might as
>>> well do a strcpy at this point.
>>>
>>> Fixes this warning:
>>>
>>> In function 'strncpy', inlined from 'kallsyms_symbol_next' at kernel/debug/kdb/kdb_support.c:239:4:
>>> ./include/linux/string.h:253:9: warning: '__builtin_strncpy' specified bound depends on the length of the source argument [-Wstringop-overflow=]
>>
>> I think we already have a pending patch for this:
>> https://lore.kernel.org/patchwork/patch/989013/
>>
>> When we looked into this there actually is an unchecked overflow here so
>> Prarit's fix adds infrastructure to keep track of the remaining length.
> 
> I'm not surprised that there are more bugs.
> 
> The above patch was posted a month and a half ago though, why is it
> not yet merged? Can we get it in by -rc2, please?
> 
> 

Jason?  ping?  Just making sure the above patch is in your queue.

P.

> -Olof
> 
