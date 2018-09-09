Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46DD7C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 15:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2EAC20833
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 15:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dNy5e64h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2EAC20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbeIIUm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 16:42:58 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37834 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbeIIUm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 16:42:58 -0400
Received: by mail-pf1-f195.google.com with SMTP id h69-v6so9238265pfd.4;
        Sun, 09 Sep 2018 08:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iojHWaatITouzQvemG43J8FNoHUYk52RfK5liD5lwtU=;
        b=dNy5e64hxgTFgJOkzmXy3vxq0oIhZfX/ayZOfU1I37YFxb/mzomo826yhR2/eXHM/b
         /y/E1SkFNNxlnaDbLH2bMyrcquz/TRKvMuUjloSxvjhT+O3qbtp9iNYQCmK7DV8N0+PP
         nHG4KKJn83pqfJ7oW5PzzVSqj18WCsgD6+FnhGvsGOuCcwCcx+Hg/dXfhdBwIc/vEChE
         DmKZzkg7Ua0wlt4piqtGlve4iMR1Va02aKBxGfY2KruPUf5PanKSvDz8qHGStNqMXpbg
         h3eGczQE6nn8Uxs3KipL9tVBwDdtPlfPPNkZjlN25ppr9yFKhIvdEc5STpvMkXk8QXi0
         0dOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iojHWaatITouzQvemG43J8FNoHUYk52RfK5liD5lwtU=;
        b=Ck3ZyaDONUSmJiW7Uyp/9EGGH324zzswlUiTNSW1ZiuWJ36A6yYb4djJ5mey/Cou78
         d2dUevWCd9LlYfwQKD7OrCNQJoeXd3JZo7r0qpSF426U/GKRyeybKC+akXzwRCIvlT5j
         d9JoCjm/wpJr4aTH/8H+SYdUK48Ap88Hg78chjiGW9JoXPD1DGUUxncatTLZLKZwFBxs
         TNiTl7Kk/HjiL1va9Ai2ja//QoEWjCzAzNaBlM5pMH05aPvQ4SfhkeedtMIv8zTHt43G
         bHm3PheNuFcN9A0jJm7bwMN+bW6N4kZ2y/OM7T3HIrKQzNnGmjo8b7mH+DaK+mjH+tzx
         o3kw==
X-Gm-Message-State: APzg51Db5UpFY0THnrjU5bnbf4+dSs6IjAxLwweLXJUhxTH8oX1isYjW
        XQKAXaqdMO/V9JmRQf70XdKE5YeF
X-Google-Smtp-Source: ANB0VdZCmr+/ZIHoVwTBL8QqZJ+ISfWqOnvCqb5lVgBzTbzhE2A6c/7/GZHPWXENQbtR1ZxC+jI0vw==
X-Received: by 2002:a63:db4f:: with SMTP id x15-v6mr17438416pgi.214.1536508372328;
        Sun, 09 Sep 2018 08:52:52 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id p11-v6sm19096161pfj.72.2018.09.09.08.52.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Sep 2018 08:52:51 -0700 (PDT)
Subject: Re: [PATCH 4.4 00/47] 4.4.155-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180907210904.607934824@linuxfoundation.org>
 <198bd18b-727d-ef9a-1553-8e2a99351f86@roeck-us.net>
 <20180909090127.GA4195@kroah.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <4956c399-a061-c6b6-c027-5c9823d2f18a@roeck-us.net>
Date:   Sun, 9 Sep 2018 08:52:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180909090127.GA4195@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/09/2018 02:01 AM, Greg Kroah-Hartman wrote:
> On Sat, Sep 08, 2018 at 02:13:48PM -0700, Guenter Roeck wrote:
>> On 09/07/2018 02:09 PM, Greg Kroah-Hartman wrote:
>>> This is the start of the stable review cycle for the 4.4.155 release.
>>> There are 47 patches in this series, all will be posted as a response
>>> to this one.  If anyone has any issues with these being applied, please
>>> let me know.
>>>
>>> Responses should be made by Sun Sep  9 21:08:44 UTC 2018.
>>> Anything received after that time might be too late.
>>>
>>
>> Build results:
>> 	total: 151 pass: 150 fail: 1
>> Failed builds:
>> 	powerpc:allmodconfig
>> Qemu test results:
>> 	total: 281 pass: 281 fail: 0
>>
>> Details are available at https://kerneltests.org/builders/.
> 
> Should now be fixed, I've pushed out a -rc2 for this.
> 

For v4.4.154-48-gf4777549b6b8:

Build results:
	total: 151 pass: 151 fail: 0
Qemu test results:
	total: 281 pass: 281 fail: 0

Guenter
