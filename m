Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA1AC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F8D22082A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:54:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F8D22082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbeH2Qva (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 12:51:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56642 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727452AbeH2Qva (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 12:51:30 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4FB5A406E807;
        Wed, 29 Aug 2018 12:54:40 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw.lab.eng.bos.redhat.com [10.16.186.145])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5614A10EE838;
        Wed, 29 Aug 2018 12:54:37 +0000 (UTC)
Subject: Re: [PATCH v2] console: Add console=auto option
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Salter <msalter@redhat.com>,
        Al Stone <ahs3@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        x86@kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
References: <728a8e68-ea4b-4040-a0fc-217df4f1928d@redhat.com>
 <20180816173902.18971-1-prarit@redhat.com>
 <20180817093828.GA10337@jagdpanzerIV>
 <a530a430-70ce-c1e1-ccba-bf5df107c5ad@redhat.com>
 <20180817105046.GB10337@jagdpanzerIV>
 <9d164aa0-bc61-1bbf-f888-a24aeaf7dec0@redhat.com>
 <20180817125714.yekdxxqflmgajf2s@pathway.suse.cz>
From:   Prarit Bhargava <prarit@redhat.com>
Message-ID: <8689f544-c905-3542-5d45-2d817cf86283@redhat.com>
Date:   Wed, 29 Aug 2018 08:54:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180817125714.yekdxxqflmgajf2s@pathway.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 29 Aug 2018 12:54:40 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 29 Aug 2018 12:54:40 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'prarit@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/17/2018 08:57 AM, Petr Mladek wrote:
> On Fri 2018-08-17 07:06:56, Prarit Bhargava wrote:
>> On 08/17/2018 06:50 AM, Sergey Senozhatsky wrote:
>>>> Like I mentioned to Petr, I'd like to know if you (or anyone else) has strong
>>>> feelings about changing the behaviour of earlycon on x86?  I could make it so
>>>> that specifying just earlycon would also initialize the console.
>>>
>>> x86 people and/or scheduler people might have strong opinions on this.
>>> I Cc-ed Peter Zijlstra; he represents both groups and is known to be
>>> a hardcore earlycon user.
>>
>> Thanks, I'm a user of earlycon too, but only moderately.
>>
>> peterz, to give you an overview:  Currently on x86, the SPCR information is only
>> interpreted by the early console code, and can be enabled with kernel parameter
>> "earlycon" (no arguments).  In this patch I'm proposing adding "console=auto"
>> that would enable the console based on the SPCR data.
>>
>> There are two options on the table.  One, we could go with this patch which
>> would make users do "earlycon console=auto" or, I could just change the
>> behaviour of earlycon (no arguments) to also bring up the console.  In the
>> second case the kernel parameter would just be "earlycon".  There is precedent
>> for the second option as arm64 enables both the earlycon and console by default
>> if SPCR is present.  However, on x86, I know many users do not want the console
>> enabled by default so we should keep it on demand.
>>
>> tl;dr: Pick one
>>
>> Option 1: earlycon enables both the early console and console.
> 
> I am afraid that this is not acceptable. Users are sensitive
> when a new kernel suddenly enables different consoles. For example,
> see:
> 
> + commit dac8bbbae1d0ccba9 ("Revert "printk: fix double printing with
>   earlycon")
> 
> + commit c6c7d83b9c9e6a8b3 ("Revert "console: don't prefer first
>   registered if DT specifies stdout-path")
> 
> 
> By other words, the new behavior must depend on a new option.
> 
> 
>> Option 2: earlycon only enables the early console, and console=auto enables the
>> console.
> 
> I suggest:
> 
> Option 3: "earlycon" enables early console defined by SPCR
> 	  "console" enables console defined by SPCR
> 
> I mean that "console" without extra options would enable the console
> defined by ACPI SPCR. It would work the same as "earlycon" without
> extra options for early consoles.
> 
> If you would want to make it explicit than I agree with Sergey
> and would prefer "console=spcr" instead of "console=auto".

I'm going with "console=spcr".  FYI.

P.

> 
> Note kernel tries to enable some consoles automatically even
> when "console" parameter is not defined at all. Therefore "auto"
> is somehow misleading.
> 
> Best Regards,
> Petr
> 
> PS: JFYI, I have vacation the following week...
> 
