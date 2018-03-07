Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754191AbeCGLQ2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 06:16:28 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34337 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751189AbeCGLQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 06:16:26 -0500
X-Google-Smtp-Source: AG47ELtrfalVCua8APLnj4CB2fi36jWC0cGt7fLG2t1qYilFNDBgNlZhipNhwlMWkVJH3kKFBw9DEg==
Subject: Re: Regression from efi: call get_event_log before ExitBootServices
To: Thiebaud Weksteen <tweek@google.com>, jeremy@jcline.org
Cc: Javier Martinez Canillas <javierm@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org,
        tpmdd-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <01000161fc0b4755-df0621f4-ab5d-479a-b425-adf98427a308-000000@email.amazonses.com>
 <CA+zpnLdSyuyKjJEH3Oowmha2mF0B-j5b4A7CLuXXY7RH47SiFQ@mail.gmail.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <185d1c06-c379-ee7d-496b-2f4e49f8c9a3@redhat.com>
Date: Wed, 7 Mar 2018 12:16:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CA+zpnLdSyuyKjJEH3Oowmha2mF0B-j5b4A7CLuXXY7RH47SiFQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 07-03-18 09:41, Thiebaud Weksteen wrote:
> Hi,
> 
> Thanks for testing and sending this report! This patch relies heavily on
> the functions exposed by the firmware. My first guess would be that some of
> these may not be implemented correctly by the manufacturer.
> 
> Could you share more information on this specific device?

I've the same device as Jeremy, but I just tried a 4.16-rc3 kernel
and I'm not seeing this problem, BIOS settings all default (I loaded
the BIOS defaults to make sure).

> Do you have any link to the manufacturer website (I found [1] but it is
> based on an ARM CPU)?
> Do you have the option to update your firmware? Is a copy of the firmware
> available from the manufacturer?

This is a really cheap Windows tablet which was given away for free in
the Netherlands with some home-schooling language courses, or something
similar.

Both mine and Jeremy tablets come from a website in the Netherlands
where people can buy/sell used goods.

Most relevant for this discussion I guess is that this device is
based on a Bay Trail Z3735G SoC, on which according to the internets:
https://embedded.communities.intel.com/thread/7868

The TPM 2.0 it contains is implemented as part of the TXE firmware.

Since I cannot reproduce I'm thinking that maybe Jeremy actually has
some log messages in the TPM log, where as mine is empty.  Is there a
way to make sure some messages are in there?

Regards,

Hans



> On your side, I assume no error message got displayed on the screen when
> booting. Would you be able to try to boot in an UEFI shell [2] and execute
> the command "dh -v"?
> 
> Thanks,
> Thiebaud
> 
> [1] https://www.gp-electronic.nl/product/7inchtablet
> [2]
> https://wiki.archlinux.org/index.php/Unified_Extensible_Firmware_Interface#UEFI_Shell
> 
> On Tue, Mar 6, 2018 at 5:00 PM Jeremy Cline <jeremy@jcline.org> wrote:
> 
>> Hi folks,
> 
>> Commit 33b6d03469b2 ("efi: call get_event_log before ExitBootServices")
>> causes my GP-electronic T701 tablet to hang when booting. Reverting the
>> patch series or hiding the TPM in the BIOS fixes the problem.
> 
>> I've never fiddled with TPMs before so I'm not sure what what debugging
>> information to provide. It's got an Atom Z3735G and the UEFI firmware is
>> InsydeH20 version BYT70A.YNCHENG.WIN.007.
> 
> 
>> Regards,
>> Jeremy
