Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10EA6C43612
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 16:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D484E21871
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 16:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="LxnOl42N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbeLaQXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 11:23:12 -0500
Received: from mail2.candelatech.com ([208.74.158.173]:41044 "EHLO
        mail2.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbeLaQXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 11:23:11 -0500
Received: from [192.168.1.47] (104-235-168-9.evrt.wa.frontiernet.net [104.235.168.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail2.candelatech.com (Postfix) with ESMTPSA id 1D93740A626;
        Mon, 31 Dec 2018 08:22:42 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail2.candelatech.com 1D93740A626
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1546273388;
        bh=NNnK+sMWElOcWI7DzR+H+uq1YtnavaNDDxCsIuiq/KE=;
        h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
        b=LxnOl42NZ8RqSRBOgpnVAZR5ANuQ1XKsZBglRHWzDImhmIMjXQO1eIut1wT+QMHFJ
         Ul4Qhfcwp4+hZeJ9fqROGWlhUDR0sL4MbZ2OuOSKTZYEeFX1VyY+gha/xwr9ep5xxN
         hb25Cx2i07PQmnr/5An7EDZ3iz33sOl3MLWkkV5E=
Subject: Re: [PATCH] x86/speculation: Add document to describe Spectre and its
 mitigations
To:     Tim Chen <tim.c.chen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <64efec3fda40c0758601bf9b1480a35d76d3c487.1545413988.git.tim.c.chen@linux.intel.com>
 <1c7923ec-70aa-25d4-3de1-f1b1768bb80b@candelatech.com>
 <fdf4e1cd-9b28-75c7-6846-6d0f5b816936@linux.intel.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org, stable@vger.kernel.org
From:   Ben Greear <greearb@candelatech.com>
Message-ID: <5d45f3ef-a91f-815a-f532-62e75899e697@candelatech.com>
Date:   Mon, 31 Dec 2018 08:22:39 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <fdf4e1cd-9b28-75c7-6846-6d0f5b816936@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/21/2018 05:17 PM, Tim Chen wrote:
> On 12/21/18 1:59 PM, Ben Greear wrote:
>> On 12/21/18 9:44 AM, Tim Chen wrote:
>>> Thomas,
>>>
>>> Andi and I have made an update to our draft of the Spectre admin guide.
>>> We may be out on Christmas vacation for a while.  But we want to
>>> send it out for everyone to take a look.
>>
>> Can you add a section on how to compile out all mitigations that have anything
>> beyond negligible performance impact for those running systems where performance
>> is more important than security?
>>
>
> If you don't worry about security and performance is paramount, then
> boot with "nospectre_v2".  That's explained in the document.

There seem to be lots of different variants of this type of problem.  It was not clear
to me that just doing nospectre_v2 would be sufficient to get back full performance.

And anyway, I would like to compile the kernel to not need that command-line option,
so I am still interesting in what compile options need to be set to what values...

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
