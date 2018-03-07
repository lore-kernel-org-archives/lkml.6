Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754433AbeCGMAw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 07:00:52 -0500
Received: from mail-wr0-f169.google.com ([209.85.128.169]:42107 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754353AbeCGMAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 07:00:49 -0500
X-Google-Smtp-Source: AG47ELvANjeImyhqFvS36qujfaibQwUD0gQZAFjTzxEgQovH9/+6778/hXhY8FZAbqXFSyUUwHj7ag==
Subject: Re: Regression from efi: call get_event_log before ExitBootServices
To: Hans de Goede <hdegoede@redhat.com>,
        Thiebaud Weksteen <tweek@google.com>, jeremy@jcline.org
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org,
        tpmdd-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <01000161fc0b4755-df0621f4-ab5d-479a-b425-adf98427a308-000000@email.amazonses.com>
 <CA+zpnLdSyuyKjJEH3Oowmha2mF0B-j5b4A7CLuXXY7RH47SiFQ@mail.gmail.com>
 <185d1c06-c379-ee7d-496b-2f4e49f8c9a3@redhat.com>
From: Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <ec9d004b-4bd1-896f-b132-9fd84cac47eb@redhat.com>
Date: Wed, 7 Mar 2018 13:00:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <185d1c06-c379-ee7d-496b-2f4e49f8c9a3@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On 03/07/2018 12:16 PM, Hans de Goede wrote:
> Hi,
> 
> On 07-03-18 09:41, Thiebaud Weksteen wrote:
>> Hi,
>>
>> Thanks for testing and sending this report! This patch relies heavily on
>> the functions exposed by the firmware. My first guess would be that some of
>> these may not be implemented correctly by the manufacturer.
>>
>> Could you share more information on this specific device?
> 
> I've the same device as Jeremy, but I just tried a 4.16-rc3 kernel
> and I'm not seeing this problem, BIOS settings all default (I loaded
> the BIOS defaults to make sure).
> 
>> Do you have any link to the manufacturer website (I found [1] but it is
>> based on an ARM CPU)?
>> Do you have the option to update your firmware? Is a copy of the firmware
>> available from the manufacturer?
> 
> This is a really cheap Windows tablet which was given away for free in
> the Netherlands with some home-schooling language courses, or something
> similar.
> 
> Both mine and Jeremy tablets come from a website in the Netherlands
> where people can buy/sell used goods.
> 
> Most relevant for this discussion I guess is that this device is
> based on a Bay Trail Z3735G SoC, on which according to the internets:
> https://embedded.communities.intel.com/thread/7868
> 
> The TPM 2.0 it contains is implemented as part of the TXE firmware.
> 
> Since I cannot reproduce I'm thinking that maybe Jeremy actually has
> some log messages in the TPM log, where as mine is empty.  Is there a
> way to make sure some messages are in there?
>

The UEFI firmware does some measurements and so does shim. So you should
have some event logs. What version of shim are you using? And also would
be good to know if it's the same shim version that Jeremy is using.

> Regards,
> 
> Hans
> 

Best regards,
-- 
Javier Martinez Canillas
Software Engineer - Desktop Hardware Enablement
Red Hat
