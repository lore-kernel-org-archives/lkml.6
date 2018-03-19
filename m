Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932781AbeCSJvC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 05:51:02 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:53171 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932567AbeCSJvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 05:51:00 -0400
X-Google-Smtp-Source: AG47ELto+vmSSIHsXkmsI3yh/7zcvQsbXo8fzYS5QXxAUiE3+pk1Qued5QfhlpfPnUz7MIKW33UKjA==
Subject: Re: [Possible REGRESSION, 4.16-rc4] Error updating SMART data during
 runtime and could not connect to lvmetad at some boot attempts
To: Thorsten Leemhuis <regressions@leemhuis.info>,
        Martin Steigerwald <martin@lichtvoll.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Tejun Heo <tj@kernel.org>
References: <27165802.vQ9JbjrmvU@merkaba>
 <a3af4fed-a728-5be2-2224-6a0573406c5b@leemhuis.info>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <f6f20cd6-0d52-4501-f8ea-c4da9ec128cf@redhat.com>
Date: Mon, 19 Mar 2018 10:50:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <a3af4fed-a728-5be2-2224-6a0573406c5b@leemhuis.info>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thorsten,

On 19-03-18 10:42, Thorsten Leemhuis wrote:
> Hi! On 11.03.2018 09:20, Martin Steigerwald wrote:
>>
>> Since 4.16-rc4 (upgraded from 4.15.2 which worked) I have an issue
>> with SMART checks occassionally failing like this:
> 
> Martin (or someone else): Could you gibe a status update? I have this
> issue on my list or regressions, but it's hard to follow as two
> different issues seem to be discussed. Or is it just one issue? Did the
> patch/discussion that Bart pointed to help? Is the issue still showing
> up in rc6?

Your right there are 2 issues here:

1) The Crucial M500 SSD (at least the 480GB MU03 firmware version) does
not like enabling SATA link power-management at a level of min_power
or at the new(ish) med_power_with_dipm level. This problem exists in
older kernels too, so this is not really a regression.

New in 4.16 is a Kconfig option to enable SATA LPM by default, which
makes this existing problem much more noticeable. Not sure if you want
to count this as a regression. Either way I'm preparing and sending
out a patch fixing this (by blacklisting LPM for this model SSD) right
now.

2) There seem to be some latency issues in the MU03 version of the
firmware, triggered by polling SMART data, which causes lvmetad to
timeout in some cases. Note I'm not involved in that part of this
thread, but I believe that issue is currently unresolved.

Regards,

Hans
