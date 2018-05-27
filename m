Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032566AbeE0CWd convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 22:22:33 -0400
Received: from ozlabs.org ([203.11.71.1]:50943 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032474AbeE0CWc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 22:22:32 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Date: Sun, 27 May 2018 12:22:23 +1000
User-Agent: K-9 Mail for Android
In-Reply-To: <20180525133308.GA17443@roeck-us.net>
References: <20180525133308.GA17443@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH] powerpc/64s: Clear PCR on boot
To: Guenter Roeck <linux@roeck-us.net>,
        Michael Neuling <mikey@neuling.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
CC: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
From: Michael Ellerman <michael@ellerman.id.au>
Message-ID: <31148B04-5AA9-4F4F-BD34-CD9665F7F6D6@ellerman.id.au>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25 May 2018 11:33:08 pm AEST, Guenter Roeck <linux@roeck-us.net> wrote:
>On Fri, May 18, 2018 at 11:37:42AM +1000, Michael Neuling wrote:
>> Clear the PCR (Processor Compatibility Register) on boot to ensure we
>> are not running in a compatibility mode.
>> 
>> We've seen this cause problems when a crash (and kdump) occurs while
>> running compat mode guests. The kdump kernel then runs with the PCR
>> set and causes problems. The symptom in the kdump kernel (also seen
>in
>> petitboot after fast-reboot) is early userspace programs taking
>> sigills on newer instructions (seen in libc).
>> 
>
>Hi folks,
>
>this patch causes qemu to bail out with
>
>Trying to write privileged spr 338 (0x152) at c000000000033454
>
>when running it with "-M powernv -cpu POWER8" and powernv_defconfig.
>
>Can you confirm that this is a bug in qemu ?

Hi Guenter,

Thanks for the report. As far as I'm concerned this is a qemu bug, that register should exist on a bare metal Power8.

Will try and get you a qemu patch to fix it.

cheers

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
