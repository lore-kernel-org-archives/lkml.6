Return-Path: <hdegoede@redhat.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524594836; cv=none;
        d=google.com; s=arc-20160816;
        b=afg7gDmDLFPQtrJs1aRdU8BQyZRg3YIj+hD6RhY+4d7apUIL+fSY7hirKoWOkCAsXo
         U5ZgM+MZb60XP0DMl6zhMnV6zj93aiVsC99zTyq9sD6wW7QUQVznh/pLp6cdQwDwVAst
         LkPV+eiVNmNs6z1ft2OcSGAYZjaHQpXW5ScQkSyV94mcdJQdzygSPniWtYSHktCaRKHi
         Su4ASe2K0VZczPAmAf6TEHj4X+WS4jE/TgVgbHd67CdcAFRKjYCyCt0YvN4CXMwBHju0
         ShIyNu2T5Kh3/lesuzWLtuxOkji8Ceo/h/GINze//G/IMzdnRzG6/5lpubPxzu7mI1wF
         ptKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=E/vjRMMu5OiPEWnP9UuCux8KK+BRS/TSxH/p8ICsQIM=;
        b=oAfOAh5do77zNsiFO3OUn47w6BlTfUYwHudrgPiYicE1vgsF1IzM1oP3rPz3zKhecp
         EJfCjkltRt0YxHszsflC8cpxashLSlujkCF6jAYWLTAHrtvGGMd6i6eSXWRYjq+nbnbq
         6aKIqmOhNyOtHJS/7lWbsv3JtIAJqiz+akFA9hfjngfFew/B8nUfOF/FO8kxjFZh5v2V
         93SiMPdqFGjKg5WuqjgbAn26rap4lEh9ZVkrhgLO/Ni5rC3STcK7fhCiAPu7sKIxVJPK
         Iv3JmzWS7U7OQlwyM6rCCyhzYzgX/2HESFPCsNFMnG9Qt0e8CiIm1sf26l+vplTc2UcX
         9pRg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
X-Google-Smtp-Source: AIpwx49FtjmpNpXBySDIHTNlaei+LwMMelHTqhzzm4iJJv8EhEk0ZQzEa3FIghFimzRCNUDXAP0t4A==
Subject: Re: [PATCH v3 2/5] efi: Add embedded peripheral firmware support
To: Mimi Zohar <zohar@linux.vnet.ibm.com>,
 "Luis R. Rodriguez" <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>
Cc: Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H . Peter Anvin" <hpa@zytor.com>, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org, Peter Jones <pjones@redhat.com>,
 Dave Olsthoorn <dave@bewaar.me>, Will Deacon <will.deacon@arm.com>,
 Andy Lutomirski <luto@kernel.org>, Matt Fleming <matt@codeblueprint.co.uk>,
 David Howells <dhowells@redhat.com>, Josh Triplett <josh@joshtriplett.org>,
 dmitry.torokhov@gmail.com, mfuzzey@parkeon.com,
 Kalle Valo <kvalo@codeaurora.org>,
 Arend Van Spriel <arend.vanspriel@broadcom.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, nbroeking@me.com,
 bjorn.andersson@linaro.org, Torsten Duwe <duwe@suse.de>, x86@kernel.org,
 linux-efi@vger.kernel.org
References: <20180408174014.21908-1-hdegoede@redhat.com>
 <20180408174014.21908-3-hdegoede@redhat.com>
 <20180423211143.GZ14440@wotan.suse.de>
 <71e6a45a-398d-b7a4-dab0-8b9936683226@redhat.com>
 <1524586021.3364.20.camel@linux.vnet.ibm.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <f410a445-d02b-44d4-6e82-f94724e0031d@redhat.com>
Date: Tue, 24 Apr 2018 20:33:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1524586021.3364.20.camel@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597199782052351527?=
X-GMAIL-MSGID: =?utf-8?q?1598653555361350422?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 24-04-18 18:07, Mimi Zohar wrote:
> On Tue, 2018-04-24 at 17:09 +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 23-04-18 23:11, Luis R. Rodriguez wrote:
>>> Hans, please see use of READING_FIRMWARE_PREALLOC_BUFFER, we'll need a new ID
>>> and security for this type of request so IMA can reject it if the policy is
>>> configured for it.
>>
>> Hmm, interesting, actually it seems like the whole existence
>> of READING_FIRMWARE_PREALLOC_BUFFER is a mistake, the IMA
>> framework really does not care if we are loading the firmware
>> into memory allocated by the firmware-loader code, or into
>> memory allocated by the device-driver requesting the firmware.
>>
>> As such the current IMA code (from v4.17-rc2) actually does
>> not handle READING_FIRMWARE_PREALLOC_BUFFER at all,
> 
> Right, it doesn't yet address READING_FIRMWARE_PREALLOC_BUFFER, but
> should.
> 
> Depending on whether the device requesting the firmware has access to
> the DMA memory, before the signature verification, will determine how
> IMA-appraisal addresses READING_FIRMWARE_PREALLOC_BUFFER.

Ah I see. So this probably means that the IMA integration for
my EFI embedded firmware code should also pass READING_FIRMWARE or
READING_FIRMWARE_PREALLOC_BUFFER depending on if a pre-allocated
buffer is used.

Hmm, the security_kernel_post_read_file() call in
drivers/base/firmware_loader/fallback.c

Unconditionally passes READING_FIRMWARE, it should probably check
fw_priv->is_paged_buf and base the id to pass on that.

And yes it is possible AFAICT for the firmware_request_into_buf()
method to fallback to the userspace helper, this can happen if the
fw_fallback_config.force_sysfs_fallback flag is set.

Regards,

Hans
