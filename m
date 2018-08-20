Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C82EAC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 04:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C83221531
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 04:34:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C83221531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alum.mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbeHTHsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 03:48:54 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:58816 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725942AbeHTHsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 03:48:53 -0400
X-AuditID: 1207440e-c13ff7000000162b-3c-5b7a44e95a03
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 46.17.05675.9E44A7B5; Mon, 20 Aug 2018 00:34:50 -0400 (EDT)
Received: from email-server.localdomain (104-63-242-122.lightspeed.irvnca.sbcglobal.net [104.63.242.122])
        (authenticated bits=0)
        (User authenticated as rian@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id w7K4YjME000487
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 20 Aug 2018 00:34:46 -0400
Received: from roundcube-server (localhost [127.0.0.1])
        (Authenticated sender: rian@thelig.ht)
        by email-server.localdomain (Postfix) with ESMTPA id D3D6749F477;
        Sun, 19 Aug 2018 21:34:42 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 19 Aug 2018 21:34:42 -0700
From:   Rian Hunter <rian@alum.mit.edu>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bpetkov@suse.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        Dmitry Safonov <dima@arista.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] x86/process: Export start_thread()
In-Reply-To: <53141AE9-7192-432B-8A27-25986CF442D4@amacapital.net>
References: <20180819230854.7275-1-rian@alum.mit.edu>
 <53141AE9-7192-432B-8A27-25986CF442D4@amacapital.net>
Message-ID: <c2517959e12dfecef167e5657881e003@thelig.ht>
X-Sender: rian@alum.mit.edu
User-Agent: Roundcube Webmail/1.1.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGKsWRmVeSWpSXmKPExsUixO6iqPvKpSraoHuNlMWRlgnsFhc/rWS3
        mLZR3OLAzxOMFpNPzWWyuLxrDpvF6rUNrBbnd61ltbh0YAGTxeZNU5ktJrVeZrb4seExqwOP
        x/03f1k8dk9vYvTYtKqTzePduXPsHu/3XWXz2Hy62uPzJjmPEy1fWAM4orhsUlJzMstSi/Tt
        ErgyHv/oYipYzlXxaEl0A+NWji5GTg4JAROJBb+/MXcxcnEICexgkuh8tYIdwnnGJLHv8AwW
        COcMo8TbbffYQFp4BQQlTs58ApTg4GAWsJZo32MAEmYWkJfY/nYOM4jNIqAqMefoJBYQmw3I
        3txyBCwuIqAp8XLKfLCZzAKrmCVuHHrOCJIQFjCXeHLmM5jNKeAkcaPnJ9guIYFciauH97ND
        7LWQWL7mGRvE2dIS2z98Ywe5QVRAWaK7LXsCo+AsJNfNQrhuFpLrFjAyr2KUS8wpzdXNTczM
        KU5N1i1OTszLSy3SNdbLzSzRS00p3cQIiSy+HYzt62UOMQpwMCrx8C64WhktxJpYVlyZe4hR
        koNJSZRX27QqWogvKT+lMiOxOCO+qDQntfgQowQHs5II79UfQOW8KYmVValF+TApaQ4WJXFe
        NpO9UUIC6YklqdmpqQWpRTBZGQ4OJQne6c5AQwWLUtNTK9Iyc0oQ0kwcnCDDeYCGf3MCquEt
        LkjMLc5Mh8ifYjTmuNXcM4mZ48/7qZOYhVjy8vNSpcR5XYDpTUgApDSjNA9uGiw5vmIUB3pO
        mHcvyFIeYGKFm/cKaBUT0Cp2NpA/iksSEVJSDYyKHkevHl9fwFx0aI91d/zuI0kbVZYdEr51
        +5+H3VTGWCWDBIbm1JcPjsYfvtUttdN6N5f/jV5J/d1Tas7mVV/fKagTuurKkpzfnlUV327+
        1LJtWSd6zMSdV+xk5ePnK+bN0hITLd/f8N7d9enCLLckQ6+kh89/CThmHnybUnVrymm/AIHK
        wi1KLMUZiYZazEXFiQA9bfNOaQMAAA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-19 19:29, Andy Lutomirski wrote:
>> On Aug 19, 2018, at 4:08 PM, Rian Hunter <rian@alum.mit.edu> wrote:
>> 
>> Commit e634d8fc792c ("x86-64: merge the standard and compat
>> start_thread() functions") removed exporting for the start_thread()
>> function in what seems like a typo. Add it back to
>> arch/x86/kernel/process_64.c for parity with process_32.c and other
>> arch.
> 
> What for?  Perhaps 32-bit could remove it instead?
> 

Came across this while writing a binfmt module. Useful for me but 
probably no one else on Earth, at least for another ~9 years on average.

>> Signed-off-by: Rian Hunter <rian@alum.mit.edu>
>> ---
>> arch/x86/kernel/process_64.c | 1 +
>> 1 file changed, 1 insertion(+)
>> 
>> diff --git a/arch/x86/kernel/process_64.c 
>> b/arch/x86/kernel/process_64.c
>> index 476e3ddf8890..a451bc374b9b 100644
>> --- a/arch/x86/kernel/process_64.c
>> +++ b/arch/x86/kernel/process_64.c
>> @@ -384,6 +384,7 @@ start_thread(struct pt_regs *regs, unsigned long 
>> new_ip, unsigned long new_sp)
>>    start_thread_common(regs, new_ip, new_sp,
>>                __USER_CS, __USER_DS, 0);
>> }
>> +EXPORT_SYMBOL_GPL(start_thread);
>> 
>> #ifdef CONFIG_COMPAT
>> void compat_start_thread(struct pt_regs *regs, u32 new_ip, u32 new_sp)
>> --
>> 2.16.3
>> 
