Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753282AbeCaS3x (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 14:29:53 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:41942 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753073AbeCaS3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 14:29:51 -0400
X-Google-Smtp-Source: AIpwx49m8jYQOJ/eFXT7SsRx8hR+gLIL4Z/ycX8PRRT2XJp6lnhwAFLHaNMF/GnXyNy5tsshBmY4DopgKlVxmiPAVMI=
MIME-Version: 1.0
In-Reply-To: <ee25829c-e8de-1171-e54e-3b34206acc9e@oracle.com>
References: <20180319165804.10636-1-jandryuk@gmail.com> <c3075b0c-a60b-0809-e34b-223701a53b84@oracle.com>
 <CAKf6xps0HJecKM0gYSK+3BGhKknYp9Ydxr3S0oWBThtXeytegw@mail.gmail.com> <ee25829c-e8de-1171-e54e-3b34206acc9e@oracle.com>
From: Jason Andryuk <jandryuk@gmail.com>
Date: Sat, 31 Mar 2018 14:29:49 -0400
Message-ID: <CAKf6xpvhX3_MehbYP-XbJPRgVMyFbZ6f6fsJyaTfHca0xwTpWw@mail.gmail.com>
Subject: Re: [PATCH] x86/xen: Delay get_cpu_cap until stack canary is established
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, xen-devel@lists.xenproject.org,
        open list <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 31, 2018 at 2:10 PM, Boris Ostrovsky
<boris.ostrovsky@oracle.com> wrote:
> On 03/31/2018 01:38 PM, Jason Andryuk wrote:
>> On Wed, Mar 21, 2018, 5:12 PM Boris Ostrovsky <boris.ostrovsky@oracle.com
>> <mailto:boris.ostrovsky@oracle.com>> wrote:
>>
>>     On 03/19/2018 12:58 PM, Jason Andryuk wrote:
>>      > Commit 2cc42bac1c79 ("x86-64/Xen: eliminate W+X mappings")
>>     introduced a
>>      > call to get_cpu_cap, which is fstack-protected.  This is works on
>>     x86-64
>>      > as commit 4f277295e54c ("x86/xen: init %gs very early to avoid page
>>      > faults with stack protector") ensures the stack protector is
>>     configured,
>>      > but it it did not cover x86-32.
>>      >
>>      > Delay calling get_cpu_cap until after xen_setup_gdt has
>>     initialized the
>>      > stack canary.  Without this, a 32bit PV machine crashes early
>>      > in boot.
>>      > (XEN) Domain 0 (vcpu#0) crashed on cpu#0:
>>      > (XEN) ----[ Xen-4.6.6-xc  x86_64  debug=n  Tainted:    C ]----
>>      > (XEN) CPU:    0
>>      > (XEN) RIP:    e019:[<00000000c10362f8>]
>>      >
>>      > And the PV kernel IP corresponds to init_scattered_cpuid_features
>>      >    0xc10362f8 <+24>:    mov    %gs:0x14,%eax
>>      >
>>      > Fixes 2cc42bac1c79 ("x86-64/Xen: eliminate W+X mappings")
>>      >
>>      > Signed-off-by: Jason Andryuk <jandryuk@gmail.com
>>     <mailto:jandryuk@gmail.com>>
>>      >
>>
>>
>>     Applied to for-linus-4.17
>>
>>
>> Thanks. If it's not too late, can this be cc: stable?
>
> We can always try ;-)
>
> This is 4.15 and 4.16 only, I believe.

I'm using this patch on 4.14, so there as well.

-Jason
