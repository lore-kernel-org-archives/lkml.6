Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5DBECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65FC220847
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QErZ8pNl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65FC220847
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731338AbeKAI0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:26:45 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41240 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727546AbeKAI0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:26:42 -0400
Received: by mail-lf1-f66.google.com with SMTP id c16so12945153lfj.8;
        Wed, 31 Oct 2018 16:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Dq7VC9OA51j0v9D76s73ZNiqY11Lfx+xMfnqOl+h9IY=;
        b=QErZ8pNl4q35OEABZnKleOEqU+yK4KcnVy0PCybVaskL7VB2mnKgof7nOHKOKQQtvm
         s2IylFcXQR3tbtuhIyN5xSGQz4uz7pN0I0LqsRaidL8jkzhjYEp9P5HRURrwhooEuvh2
         CGDLJzbhDdvl61GaqfmNYA4j4GhLEMJc7oXa3HJfwERbezyiuXGn2qBTi7SGl41YF7Mz
         j7wEekAKvELMmpMjnBW0zWKXM0EcZh7EvpbBTxFuSrviJOzuUkDEzZp9uvsmvY+m12hH
         AxpGlXIKjIlZkzAo/rBqUUI5RyHILE93apAnPh4VBMIyp0yVo2dk33P3XnFwsR0eTMcg
         WN/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Dq7VC9OA51j0v9D76s73ZNiqY11Lfx+xMfnqOl+h9IY=;
        b=rAq0v5FQq4aiCuzGwMqZXfWW5CLUC+VTYD+sE76T2uaqoLyDd/kjPlabRlb7F7pac5
         18rBzIlwOe+8Dlz5sXS+gwf+KpwRWQ0OOmSNJXst5MCy2POQ0WXwHi+9tWb5YFJz40Oj
         czFMeClgAFdX7RY0nYdyTpxizgTDzeJFu0JgTwtuUTohkHcLsVRCeLT14nFvcCCrb8jX
         A1JVh7zON64AtsVZ+adSbC5QfMy95DqiDc0WtFWIYvoTllwELcLzJ/hGWBCpuKA+cD4f
         aAq4Tq8uaZruMwc95bT7J8Z4xyyv8M7quCpYTNhB5XeoVUxsVuhfMuEzCTtUNmG/yugN
         lZSQ==
X-Gm-Message-State: AGRZ1gKMy9Of154TxmYNNqcEuIus4M7lmVSZA4dZY0+iFYI/xvW4J7bE
        mKACUaKVTfpfmjlOBpUkVk8=
X-Google-Smtp-Source: AJdET5fK56VAEVSIiEWpFJwkll6LM+hwh86+kCzurB3BUsHLIjdZ24L6MB9hcIinNrLzkd756zgcvg==
X-Received: by 2002:a19:4948:: with SMTP id l8-v6mr2883476lfj.16.1541028383218;
        Wed, 31 Oct 2018 16:26:23 -0700 (PDT)
Received: from [192.168.10.160] (91-159-62-242.elisa-laajakaista.fi. [91.159.62.242])
        by smtp.gmail.com with ESMTPSA id k2-v6sm2659485ljg.39.2018.10.31.16.26.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 16:26:22 -0700 (PDT)
Subject: Re: [PATCH 10/17] prmem: documentation
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
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
 <4124995b-4363-9b37-19b1-1879bf04978b@gmail.com>
 <CALCETrWCvAfyfBWgcmhy8TGByiX3ZXXSOkLtZFdM385fDqYJVw@mail.gmail.com>
From:   Igor Stoppa <igor.stoppa@gmail.com>
Message-ID: <8675e9d8-0ef0-7515-a894-097d4be25b73@gmail.com>
Date:   Thu, 1 Nov 2018 01:26:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CALCETrWCvAfyfBWgcmhy8TGByiX3ZXXSOkLtZFdM385fDqYJVw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/11/2018 01:19, Andy Lutomirski wrote:

> ISTM you don't need that atomic operation -- you could take a spinlock
> and then just add one directly to the variable.

It was my intention to provide a 1:1 conversion of existing code, as it 
should be easier to verify the correctness of the conversion, as long as 
there isn't any significant degradation in performance.

The rework could be done afterward.

--
igor
