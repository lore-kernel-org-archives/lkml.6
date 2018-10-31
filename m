Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C51C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27E0D20847
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uNBzINul"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27E0D20847
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731567AbeKAIYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:24:42 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33849 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731229AbeKAIKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:10:47 -0400
Received: by mail-lf1-f67.google.com with SMTP id n26-v6so12960357lfl.1;
        Wed, 31 Oct 2018 16:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bYvSjIaIsPqm0El1wWSvP8KsufjC/oEwOQPYiVRHspc=;
        b=uNBzINulDQi6bkHaqZ/jJmLA6O8ppB1Chie3RRl6cDZjNCc2opxtV//u6TJabrAjDO
         hMUXnrrWSMLAwezRpxNto5dgQstx1KWHCPUtVNt9iTkJqJDi4J+Xe2V5hR89zldgBfhC
         csJbppMR6ETBaGRns5zLoqy7Hq2FhIrQDT6sdSy2OGwddkCw2Gfh+e/eHSS2Ozco4y01
         vDEl/ilE6y2oQ63lbzPyrT+C0QbKBYpKt7AMuuWwrvRK9GWa0C7p96zoulDj44RGsXTH
         wNk3EyYVdR/Gs1DWG9itlgLR9hz7fwphGS8mUL3L1n1gG6eiedDY7WIm9NZ1FN6VTCJR
         2xlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bYvSjIaIsPqm0El1wWSvP8KsufjC/oEwOQPYiVRHspc=;
        b=oVyv+/VATxZi2bNr5ODilo2mxw78yaGQMsJlz+dMZ9n9Zm26uMsN+Uc7Uc4ncGc4Yf
         VVXdI3k9ml9ZUzT9ft2FKvQskcetGB4XijhoK/KY5avNqxGYJv8mfc9mSC4RfX1c8jG5
         DubcOVzp3bxP+TRCKBxVpeeiCLEe0WOe7ry5kIXia6Lu0qmpyjzkWACt6/DGttcbv+FE
         L4z496i7f21Ul+BZuvi0Pjo7/R7hBOCIb92AYkkn1sV9n267XOVXiLACL+oWHkZ3eSgG
         8eu/42frC67bnOdx4jrfBim+T8ZdtYtGMJSBapZESq2k7p1qiR+VpFniQQv83Mi1rlnp
         XfYw==
X-Gm-Message-State: AGRZ1gJl3qPs6Iev00KVOxE0mkY8JT6WX2kr+KeCxlQnInniF77t9AC0
        lkc4bpj3MspqPwd6Dzrf5rE=
X-Google-Smtp-Source: AJdET5d+pgCrny9FrLo89lL5MKtLMx0Ce00NcYH9Al+J7eP+RGQ/olbAcOfwyGhZPPSRIbX3sLkfJg==
X-Received: by 2002:a19:200b:: with SMTP id g11mr1281107lfg.58.1541027433478;
        Wed, 31 Oct 2018 16:10:33 -0700 (PDT)
Received: from [192.168.10.160] (91-159-62-242.elisa-laajakaista.fi. [91.159.62.242])
        by smtp.gmail.com with ESMTPSA id e14-v6sm672120ljl.43.2018.10.31.16.10.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 16:10:32 -0700 (PDT)
Subject: Re: [PATCH 10/17] prmem: documentation
To:     Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Tycho Andersen <tycho@tycho.ws>,
        Kees Cook <keescook@chromium.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dave Chinner <david@fromorbit.com>,
        James Morris <jmorris@namei.org>,
        Michal Hocko <mhocko@kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Igor Stoppa <igor.stoppa@huawei.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laura Abbott <labbott@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <CAGXu5jJftJ+Hq+jrZGHX5CTDLWOog7kGsd_Ne=yMvrRs__skSg@mail.gmail.com>
 <0A7AFB50-9ADE-4E12-B541-EC7839223B65@amacapital.net>
 <20181030175814.GB10491@bombadil.infradead.org> <20181030182841.GE7343@cisco>
 <20181030192021.GC10491@bombadil.infradead.org>
 <9edbdf8b-b5fb-5a82-43b4-b639f5ec8484@gmail.com>
 <20181030213557.GE10491@bombadil.infradead.org>
 <CALCETrW1FcT88u0QY9k_PMOeZj0G8H6KNb5Bnreo-12NvmmCEQ@mail.gmail.com>
 <20181031100237.GN744@hirez.programming.kicks-ass.net>
 <659CFC78-22BF-492B-B2E4-B8E89AA08446@amacapital.net>
 <20181031210032.GA3159@hirez.programming.kicks-ass.net>
 <2E29C35B-3F98-473D-A874-0D9B9B15B399@amacapital.net>
From:   Igor Stoppa <igor.stoppa@gmail.com>
Message-ID: <4124995b-4363-9b37-19b1-1879bf04978b@gmail.com>
Date:   Thu, 1 Nov 2018 01:10:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <2E29C35B-3F98-473D-A874-0D9B9B15B399@amacapital.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/11/2018 00:57, Andy Lutomirski wrote:
> 
> 
>> On Oct 31, 2018, at 2:00 PM, Peter Zijlstra <peterz@infradead.org> wrote:



>> I _think_ the use-case for atomics is updating the reference counts of
>> objects that are in this write-rare domain. But I'm not entirely clear
>> on that myself either. I just really want to avoid duplicating that
>> stuff.
> 
> Sounds nuts. Doing a rare-write is many hundreds of cycles at best. Using that for a reference count sounds wacky.
> 
> Can we see a *real* use case before we over complicate the API?
> 


Does patch #14 of this set not qualify? ima_htable.len ?

https://www.openwall.com/lists/kernel-hardening/2018/10/23/20

--
igor
