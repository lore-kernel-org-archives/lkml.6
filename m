Return-Path: <hdegoede@redhat.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524776561; cv=none;
        d=google.com; s=arc-20160816;
        b=wBHnZPiFX1Zn/lJPDH6hw1Bno8gGx7ifQY1DGP4/xt2nsjXxx/3pNMHSKdt+wS7Z+T
         OzM+uZ5Igzv+5pqTs44QXymwylRImxJ4HGyu4AnKdKrWpt5VeHIr/cDVvsziSJLJ/tMP
         KrPAbOQIPpFQBO/kTo/cZ0bg46vWMCZrdCN0rC+bDyid7RsjbwCGy0LLbE0LZEW2E7TH
         4ZvXfzDRVwIPrsl8b74fPzMBnJG/sPmwfY4AWOeY10hkINEh020sLnwE+CSCdkK37LJ7
         CEjaxKsbPCqkjs5WpC/1GP9Znpd4QsL08a8jWoT8hVX7eZE5nSrtqbmVcKomd/kAbax1
         fjWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=W91bY5Hc9dEkvrXqw+ifz1vw7RaXKJhHg26GkwViVsw=;
        b=TGY90Y1FtWUpuAYIe32GInLXfNQLT/Mjy4AskJ5MKScfwpOnMLKHgakPqHXExr0L+h
         GyGC7+LnasL3BVCf5sGaAO3nvyKjOTeUFrDOjeVqvft0L3RuL+prKsj6F/ykiKiXa7hD
         ZKqefPNAXbHtf20EoX2bqRfTYzJ7WTH9dYyK6e+DT5aUi8a6TCvMWNb4gk4q6Ad+EASq
         nofaY8DOAWxbgL72MTN0Kzi0D3vuefsyNHXPmxb50NM0l/WfDPhMMp50pkzkDZulD4LJ
         HSwHYSIorewPNyl+EVfhY49qXX+IUHXLfeIH9zSS4PuNzxkzLhXFm+8HJmliJmhw0gcM
         PRrg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
X-Google-Smtp-Source: AIpwx49D0NXA0b5gcfFP7aeT+Uss4LTrGj8Af8rEGVmBuwysy1jbVQntUkFWvub9byC8vSpX6Vb+4A==
Subject: Re: [PATCH v4 1/5] efi: Export boot-services code and data as
 debugfs-blobs
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: "Luis R . Rodriguez" <mcgrof@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H . Peter Anvin" <hpa@zytor.com>, Peter Jones <pjones@redhat.com>,
 Dave Olsthoorn <dave@bewaar.me>, Will Deacon <will.deacon@arm.com>,
 Andy Lutomirski <luto@kernel.org>, Matt Fleming <matt@codeblueprint.co.uk>,
 David Howells <dhowells@redhat.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>,
 Josh Triplett <josh@joshtriplett.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Martin Fuzzey <mfuzzey@parkeon.com>, Kalle Valo <kvalo@codeaurora.org>,
 Arend Van Spriel <arend.vanspriel@broadcom.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Nicolas Broeking <nbroeking@me.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, Torsten Duwe <duwe@suse.de>,
 Kees Cook <keescook@chromium.org>, the arch/x86 maintainers
 <x86@kernel.org>, linux-efi@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180426120637.21258-1-hdegoede@redhat.com>
 <20180426120637.21258-2-hdegoede@redhat.com>
 <CAKv+Gu9sx_TnSvxdO9eGLCqsQufKW6z9p0K8nYWF_KuDBuUwag@mail.gmail.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <d587af46-72cb-8fc7-8432-36473b67de47@redhat.com>
Date: Thu, 26 Apr 2018 23:02:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu9sx_TnSvxdO9eGLCqsQufKW6z9p0K8nYWF_KuDBuUwag@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598810391211983074?=
X-GMAIL-MSGID: =?utf-8?q?1598844107488699967?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 26-04-18 18:51, Ard Biesheuvel wrote:
> On 26 April 2018 at 14:06, Hans de Goede <hdegoede@redhat.com> wrote:
>> Sometimes it is useful to be able to dump the efi boot-services code and
>> data. This commit adds these as debugfs-blobs to /sys/kernel/debug/efi,
>> but only if efi=debug is passed on the kernel-commandline as this requires
>> not freeing those memory-regions, which costs 20+ MB of RAM.
>>
>> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> Changes in v4:
>> -Add new EFI_BOOT_SERVICES flag and use it to determine if the boot-services
>>   memory segments are available (and thus if it makes sense to register the
>>   debugfs bits for them)
>>
>> Changes in v2:
>> -Do not call pr_err on debugfs call failures
>> ---
>>   arch/x86/platform/efi/efi.c    |  1 +
>>   arch/x86/platform/efi/quirks.c |  4 +++
>>   drivers/firmware/efi/efi.c     | 53 ++++++++++++++++++++++++++++++++++
>>   include/linux/efi.h            |  1 +
>>   4 files changed, 59 insertions(+)
>>
>> diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
>> index 9061babfbc83..568b7ee3d323 100644
>> --- a/arch/x86/platform/efi/efi.c
>> +++ b/arch/x86/platform/efi/efi.c
>> @@ -208,6 +208,7 @@ int __init efi_memblock_x86_reserve_range(void)
>>               efi.memmap.desc_version);
>>
>>          memblock_reserve(pmap, efi.memmap.nr_map * efi.memmap.desc_size);
>> +       set_bit(EFI_BOOT_SERVICES, &efi.flags);
>>
> 
> I think it would be better if the flag conveys whether boot services
> regions are being preserved, because they will always exist when
> EFI_BOOT is set.
> The name should then reflect that as well, e.g., EFI_PRESERVE_BS_REGIONS.

Ok, I will rename the flag to EFI_PRESERVE_BS_REGIONS for v5
(I'm going to wait a bit with sending out v5 to give others a change
  to comment on v4).

>>          return 0;
>>   }
>> diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
>> index 36c1f8b9f7e0..16bdb9e3b343 100644
>> --- a/arch/x86/platform/efi/quirks.c
>> +++ b/arch/x86/platform/efi/quirks.c
>> @@ -376,6 +376,10 @@ void __init efi_free_boot_services(void)
>>          int num_entries = 0;
>>          void *new, *new_md;
>>
>> +       /* Keep all regions for /sys/kernel/debug/efi */
>> +       if (efi_enabled(EFI_DBG))
>> +               return;
>> +
> 
> Why is this only necessary when EFI_DBG is enabled? How are you
> ensuring that the firmware is still in memory when the subsequent
> patches start relying on that?

The 2nd patch in this series makes init/main.c call
efi_check_for_embedded_firmwares() before efi_free_boot_services(),
efi_check_for_embedded_firmwares() then walks the dmi_system_id-s
"registered" (its a static list) by drivers and if their is a dmi_match
searches for the firmware described by the dmi_system_id.driver_data
ptr. If a firmware gets found it gets memdup-ed, so that we do not
have to keep all of the boot-services code around.

Regards,

Hans
