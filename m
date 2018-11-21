Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EBD6C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 16:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 024C921479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 16:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DEg17h/E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 024C921479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731828AbeKVDJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 22:09:58 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:47077 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727874AbeKVDJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 22:09:57 -0500
Received: by mail-lf1-f68.google.com with SMTP id f23so4425519lfc.13;
        Wed, 21 Nov 2018 08:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=W47rqKvf2a7T9NXZrvi97XrIaJMvSnnFpWA4cl5Ou2o=;
        b=DEg17h/E+7MmFUmt8lK0cg8he2VK3t249zzC1DUDHqmwrH37UkOmGic+v6DvpUkZ/b
         IBZCNRDU5IDqxAEAgIB0b0hkBBMnYFDkJFihfXX2rRTdmfVPF3pC5fkiTBNcAI/b1Xv0
         bwFphaoG+Z96SKHnDsqF6YAzfs3MqKsczzRyTmK05zsE5XrInzTEZQkEM4Satr4uj1k7
         rUDvfgnDTEa0YJ5kE3OFNQqonaaBHrzbs++7JGtJM/iBlivSadWzBztT6bheHpPzmSzC
         tPtHgBuBgjMh1PeILuxb4uqWHJMkrr+lg+Bz4oEUbH9uEKp7UZmWX3StnLTlCXnShnaE
         mwWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W47rqKvf2a7T9NXZrvi97XrIaJMvSnnFpWA4cl5Ou2o=;
        b=oY1TS5hcvck47/491dLQidi//4eKbrsHeF4t1/lTRTSA78ZLWfQU8F+llTJqanF6Ok
         G7k5moUWz8W75YYlHEIZrd5eI7sYIxk5IRDTmWTtoFophmQO6Z4HPSCeaV+0MR5NrRtA
         r7aPUIohYO7e8DRIAvOd7l0wV4+uRWslNZ9EqybPBiuOYQyZyVXsYGCqd5tKmQxY0XK5
         6744j4uL56eOqelZHMd1kWLc89ei8lBlIZsv0Ag21nilu5SPjdWlgvvmu9Q2xG5LRm/S
         8bM0Chf9ySpkJiyTMzZ1jqPk/6vo7W8MohuJJSgrejPxTblvss8z/08mKq8ui7HbpzZn
         4lcg==
X-Gm-Message-State: AGRZ1gJS+hl9IXew/v1hYWlZEnw003feOX3vras3bq9UqlcxLy/JyBze
        SO2eoziuaKCNcXuHTL16PlE=
X-Google-Smtp-Source: AJdET5eQGf+Pvj9MxTPIewttBPD0Og2SxPHsZhpTY3+FH/S001ZF/zNGk5SpZlJuXuvvVgSRe7n2+Q==
X-Received: by 2002:a19:8f45:: with SMTP id r66mr4605729lfd.9.1542818085369;
        Wed, 21 Nov 2018 08:34:45 -0800 (PST)
Received: from ?IPv6:2001:14bb:40:1c40:9d63:5352:fe43:f29c? (dkyrfbjndmqls8t-wxt-4.rev.dnainternet.fi. [2001:14bb:40:1c40:9d63:5352:fe43:f29c])
        by smtp.gmail.com with ESMTPSA id c2-v6sm5952139ljj.41.2018.11.21.08.34.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 08:34:44 -0800 (PST)
Subject: Re: [PATCH 10/17] prmem: documentation
To:     Andy Lutomirski <luto@kernel.org>,
        Igor Stoppa <igor.stoppa@huawei.com>
Cc:     Nadav Amit <nadav.amit@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        James Morris <jmorris@namei.org>,
        Michal Hocko <mhocko@kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laura Abbott <labbott@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20181023213504.28905-1-igor.stoppa@huawei.com>
 <20181023213504.28905-11-igor.stoppa@huawei.com>
 <20181026092609.GB3159@worktop.c.hoisthospitality.com>
 <CAGXu5jKCs01jvtvpEFS7R8qCR-5iRqK11kJxLJY99NicGWc4aQ@mail.gmail.com>
 <20181028183126.GB744@hirez.programming.kicks-ass.net>
 <40cd77ce-f234-3213-f3cb-0c3137c5e201@gmail.com>
 <20181030152641.GE8177@hirez.programming.kicks-ass.net>
 <CAGXu5jJftJ+Hq+jrZGHX5CTDLWOog7kGsd_Ne=yMvrRs__skSg@mail.gmail.com>
 <0A7AFB50-9ADE-4E12-B541-EC7839223B65@amacapital.net>
 <6f60afc9-0fed-7f95-a11a-9a2eef33094c@gmail.com>
 <CALCETrXNckT9W288VXx-6inO5qYn-6dUPocKGcBT0GCO3xi3ZQ@mail.gmail.com>
 <386C0CB1-C4B1-43E2-A754-DA8DBE4FB3CB@gmail.com>
 <CALCETrWWcfLK4W3mn0bavzejmMBVKMX29aAUA3+VPQ8m9vmfhw@mail.gmail.com>
 <9373ccf0-f51b-4bfa-2b16-e03ebf3c670d@huawei.com>
 <2e52e103-15d0-0c26-275f-894dfd07e8ec@huawei.com>
 <CALCETrV0sPgf4ZgG1joF_5hM-ycPsWM9DWGO=diQ_LQKin4VuA@mail.gmail.com>
From:   Igor Stoppa <igor.stoppa@gmail.com>
Message-ID: <1166e55c-0c06-195c-a501-383b4055ea46@gmail.com>
Date:   Wed, 21 Nov 2018 18:34:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CALCETrV0sPgf4ZgG1joF_5hM-ycPsWM9DWGO=diQ_LQKin4VuA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 13/11/2018 20:36, Andy Lutomirski wrote:
> On Tue, Nov 13, 2018 at 10:33 AM Igor Stoppa <igor.stoppa@huawei.com> wrote:
>>
>> I forgot one sentence :-(
>>
>> On 13/11/2018 20:31, Igor Stoppa wrote:
>>> On 13/11/2018 19:47, Andy Lutomirski wrote:
>>>
>>>> For general rare-writish stuff, I don't think we want IRQs running
>>>> with them mapped anywhere for write.  For AVC and IMA, I'm less sure.
>>>
>>> Why would these be less sensitive?
>>>
>>> But I see a big difference between my initial implementation and this one.
>>>
>>> In my case, by using a shared mapping, visible to all cores, freezing
>>> the core that is performing the write would have exposed the writable
>>> mapping to a potential attack run from another core.
>>>
>>> If the mapping is private to the core performing the write, even if it
>>> is frozen, it's much harder to figure out what it had mapped and where,
>>> from another core.
>>>
>>> To access that mapping, the attack should be performed from the ISR, I
>>> think.
>>
>> Unless the secondary mapping is also available to other cores, through
>> the shared mm_struct ?
>>
> 
> I don't think this matters much.  The other cores will only be able to
> use that mapping when they're doing a rare write.


I'm still mulling over this.
There might be other reasons for replicating the mm_struct.

If I understand correctly how the text patching works, it happens 
sequentially, because of the text_mutex used by arch_jump_label_transform

Which might be fine for this specific case, but I think I shouldn't 
introduce a global mutex, when it comes to data.
Most likely, if two or more cores want to perform a write rare 
operation, there is no correlation between them, they could proceed in 
parallel. And if there really is, then the user of the API should 
introduce own locking, for that specific case.

A bit unrelated question, related to text patching: I see that each 
patching operation is validated, but wouldn't it be more robust to first 
validate  all of then, and only after they are all found to be 
compliant, to proceed with the actual modifications?

And about the actual implementation of the write rare for the statically 
allocated variables, is it expected that I use Nadav's function?
Or that I refactor the code?

The name, referring to text would definitely not be ok for data.
And I would have to also generalize it, to deal with larger amounts of data.

I would find it easier, as first cut, to replicate its behavior and 
refactor only later, once it has stabilized and possibly Nadav's patches 
have been acked.

--
igor
