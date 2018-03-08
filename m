Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934288AbeCHQu2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 11:50:28 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:53978 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752133AbeCHQu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 11:50:26 -0500
X-Google-Smtp-Source: AG47ELtgkDik9az8DCZprX6VEEovJO+AXOete9lVjZ95WCVnhUjp6pxr5X40LRNugXsA32YTYv4Vng==
From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: Regression from efi: call get_event_log before ExitBootServices
To: Javier Martinez Canillas <javierm@redhat.com>,
        Jeremy Cline <jeremy@jcline.org>, Thiebaud Weksteen <tweek@google.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org,
        tpmdd-devel@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <01000161fc0b4755-df0621f4-ab5d-479a-b425-adf98427a308-000000@email.amazonses.com>
 <e7c2be5c-cf21-fc2d-efda-d9222d93ffad@redhat.com>
 <b32f335c-0d77-1749-f7fe-65f512280255@redhat.com>
 <ade378f6-c997-1d48-a30d-cceee6435fc8@redhat.com>
 <a3b5f822-f8f4-e2f5-46da-e23e13174f28@redhat.com>
Message-ID: <cec36124-0950-6ad9-58a8-9bd69e63aa04@redhat.com>
Date: Thu, 8 Mar 2018 17:50:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <a3b5f822-f8f4-e2f5-46da-e23e13174f28@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<somehow this part of the thread was missing some email addresses, I've added these now>

Hi,

On 07-03-18 12:34, Javier Martinez Canillas wrote:
> On 03/07/2018 12:10 PM, Hans de Goede wrote:

<snip>

>> Both according to the BIOS and to the /sys/class/tpm/tpm0/device/description
>> file it is a TPM 2.0.
>>
> 
> I see, so you can choose enabling the TPM 1.2 or TPM 2.0 device? At least that's
> the case on my X1 Carbon laptop. I've both a hardware TPM 1.2 and a firmware TPM
> 2.0 that's implemented as an Intel ME application (AFAIU).

This device only has the firmware TPM 2.0 implementation.

<snip>

>> I'm actually amazed that this machine has a TPM at all, a quick internet
>> search shows that it is a software implemented TPM running as part of the
>> TXE firmware.
>>
> 
> A quick search suggests that it comes with Windows 10?

Yes, it comes with Windows 10.

>>> For start, can you please check if you can boot a v4.16-rcX kernel with the
>>> TPM device enabled? That way we will know that at least that it consistently
>>> fails on this machine and is not and isolated issue.
>>
>> I just tried and v4.16-rc3 boots fine for me, repeatedly.
>>
> 
> That's an interesting data point.
> 
>> I guess Jeremy's model may actually have something in the TPM log
> 
> I don't think so. The UEFI firmware already does some measurements and also
> does shim. So you *should* have some logs.
> 
>> while my TPM log is empty... Is there anyway to make sure the TPM
>> log has some info to retreive?
>>
> 
> Are you also able to read the TPM event logs?
> 
> $ hexdump /sys/kernel/security/tpm0/binary_bios_measurements

Yes for me that outputs a lot of hex :)

> The UEFI firmware does some measurements and so does shim. So you should
> have some event logs. What version of shim are you using? And also would
> be good to know if it's the same shim version that Jeremy is using.

That is a very good question, I'm using: shim-ia32-13-0.7.x86_64, which is
the last version for F27 AFAICT.

But Jeremy's tablet might very well be not using the shim at all, as
I manually installed Fedora 25 on the tablet he now has, before Fedora supported
machines with 32 bit EFI. I then later did a "dnf distro-sync" to Fedora-27.

Jeremy might also very well still be booting using a grub binary I build
manually back then, without any shim being involved.

Jeremy what does efibootmgr -v output on your device ?

Regards,

Hans
