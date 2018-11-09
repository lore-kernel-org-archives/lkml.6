Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E09C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 18:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E89A120818
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 18:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HP+DWaXe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E89A120818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728651AbeKJDqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 22:46:52 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45059 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbeKJDqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 22:46:52 -0500
Received: by mail-ed1-f66.google.com with SMTP id w39-v6so2431466edw.12
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 10:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K/kmF0EAZL5pcQjaPqhI/9spIMxf6DZWxWBWQC8eOuY=;
        b=HP+DWaXeTDnTJFhJsNlkSkt0gtEK3G3dNpkLrbA7oW4gtBVRrfTJZFrNw1mNgyXKyz
         wpsQwKWUa7q1EsUomif0LUbGLoVuADpi95Ooo3QmOYvLlyFsDORuWU/GXn28ke4WwNtF
         E+x6eI/4obeG9DbLK4em4tK10eLv33YoG9jvGxZIun70ZtsW/X3dLBfUUNHXKkAhqtdx
         /7qpOvEtvrewhlDSRxaLP2llfODUEK/KtpWSdoOlE+92SqLi1qLcX29XChwVMvsXPnZh
         HnexsiHEhK4GaHcV8kpaKVuDMSAKHxsyBkOvsGS6gxydZ/ZXulVyXbBNBsI9p7y1+JWQ
         R5QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K/kmF0EAZL5pcQjaPqhI/9spIMxf6DZWxWBWQC8eOuY=;
        b=UUvw5lC46On+pcakN+9y3FIctgtnrWd6vM7w8wBdiEIEb5slohL3wbkazCVHJms+MA
         h5NrfO7vA2QEe6xO05p4TJJc/X5KEsPujG52q+a6qgnzpN/F5ub0NQs8nR4vo6pPJHmW
         pKAE98VQHNo+UBpj1wJdRimC75+ysCZRdaP4e3KYqGioU0B7gEupFasjST54pRyOpCn/
         AP5gD8XPo4AjgdKfz0b6DkIO+gKOaFZwfYcC8Hw6tBOiFZMMjojXO1S99lytfuf9DKhp
         Ji0KDRIQbPb0KvQTZGdUW8zlGA3dZP2runS4FY6NlZDW2Li20DhK+udQ1m94G5NgtLrI
         iSaQ==
X-Gm-Message-State: AGRZ1gLiLxvkFEcU1gwB64nh5HKDNxJRnIEoB9W1WDO224yuF0UZ/y6u
        +ZeMVptslPJZMequOK+ZiBbZpXiwFZ5lNwEiLuE=
X-Google-Smtp-Source: AJdET5cxXDiu+oR7FrZHnoT9LKFy6d43/Co9RSalPf2XALFZn34Upb0ZTLzRWCp1den15QusRCYCcT+jwvfkWbRp+hA=
X-Received: by 2002:a50:aefd:: with SMTP id f58-v6mr3307171edd.42.1541786710365;
 Fri, 09 Nov 2018 10:05:10 -0800 (PST)
MIME-Version: 1.0
References: <CANmpu8XY10CgYsnGn9hVDzGJQyWdwNihpYu3So62KtNwrkwGXw@mail.gmail.com>
 <20181109174918.GA3594@linux.intel.com>
In-Reply-To: <20181109174918.GA3594@linux.intel.com>
From:   Rian Quinn <rianquinn@gmail.com>
Date:   Fri, 9 Nov 2018 11:04:59 -0700
Message-ID: <CANmpu8Xuuuqhfa8Tspgd9cHXetNCBkRGuGfFFSovB1A1We=n+A@mail.gmail.com>
Subject: Re: x86_64 INIT/SIPI Bug
To:     sean.j.christopherson@intel.com
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> I apologize upfront if this is the wrong place to post this, pretty new to this.
>>
>> We are working on the Bareflank Hypervisor (www.bareflank.org), and we
>> are passing through the INIT/SIPI process (similar to how a VMX
>> rootkit from EFI might boot the OS) and we noticed that on Arch Linux,
>> the INIT/SIPI process stalls, something we are not seeing on Ubuntu.
>
> I'm confused, INIT is blocked post-VMXON, what are you passing through?

You are correct that INIT will track unconditionally, but all we do is set the
activity state to wait-for-sipi and return back, allowing Linux to continue
its boot process. The code can be seen here:
https://github.com/rianquinn/extended_apis/blob/hyperkernel_1/bfvmm/src/hve/arch/intel_x64/vmexit/init_signal.cpp

It should be noted that this works great for Linux and Windows, allowing us
to boot pretty much any OS that we want with the hypervisor running
(kind of like a VMX rootkit as no traps are really occurring except CPUID
once the OS is loaded). We are doing something very similar to Intel's KGT,
and Xen's PVH dom0.

The problem is, as we started working this we noticed that Ubuntu was booting
fine, but Arch wasn't and it turns out that Arch must be compiling the kernel
with this optimization enabled. Once it is enabled, the kernel basically
sends two SIPI commands before the AP has a chance to trap INIT, set
the activity
state, and then reenter, which causes both SIPIs to get dropped by hardware
. In other words, since Linux is not waiting to send the first SIPI
like the manual states, the SIPIs are lost if a hypervisor is enabled, even
if the hypervisor is doing the least possible amount of code (just setting the
activity state and returning). The working solution is either us a Linux
distribution that disables this optimization like Ubuntu, or to provide the
Linux kernel with the boot param to tell it to add the delay.

To root of the issue is the quirk is assuming that the CPU can handle the
INIT/SIPI/SIPI without a delay, but this assumption doesn't hold if the INIT
first has to trap to a hypervisor (regardless of the hypervisor). In this case,
a delay is still needed.
On Fri, Nov 9, 2018 at 10:49 AM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> On Thu, Nov 08, 2018 at 03:23:59PM -0700, Rian Quinn wrote:
> > I apologize upfront if this is the wrong place to post this, pretty new to this.
> >
> > We are working on the Bareflank Hypervisor (www.bareflank.org), and we
> > are passing through the INIT/SIPI process (similar to how a VMX
> > rootkit from EFI might boot the OS) and we noticed that on Arch Linux,
> > the INIT/SIPI process stalls, something we are not seeing on Ubuntu.
>
> I'm confused, INIT is blocked post-VMXON, what are you passing through?
