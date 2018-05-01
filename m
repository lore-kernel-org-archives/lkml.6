Return-Path: <hdegoede@redhat.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525201887; cv=none;
        d=google.com; s=arc-20160816;
        b=ERmwOgXjAgbz7y0UGcpA3DEcsaMwYTOUr8aVS4Mf42yUXYoW1GMwnWqracoMrGWxl+
         llP/Kwu6svh2Fq52zu2R9Ff2WdwofaL7Ni4ff9q020V+lTgDx0DT0N839/7UaUq9FgQi
         tRzXdiWIb5vDoAdB33R/LLMUnd79zn50y0VMuoLeC4I/vOXU7mbXllY/NABBZZFQLJOP
         okO67FY7Bu64UCZpEbnYm671LyJXJo9VVehdpXn0idr1pM030vWem7TMRE+HNyJSZRit
         xgU5I1fnnvGs/FNUdi14ij/v+IyhB55oU5QYGhla0kGWyOJ0lQBZ1aXjh/PLMVGNi+eC
         dT1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=aR8jMkoU4yFdtVJsJYVnJLTxYwEf/7bSa+vrsPHb2vc=;
        b=UV+4ap2AJbVLAt9rqcAGF8JD3wF+jlXfqVR/0r0hlz3pyFAJ+xjKDHm8AuypepFgh0
         itnfJUxLMa+8ymKCHZfAb/twjASFRDue6PJ4ZD6XILuTwDQ2RGY8hOUHZqaA3jlC78sp
         MFEaCC2gL5EN81uvk2mAMxoJBGYsR815CA2SQ24xtgOvWEtmVo3KPhIqlCiPt3vFX3nq
         r8UIqbel9sUDj+aNwTn7JORwDub/EnfdagOLH3I5yhMhb0QvRWbY+q64HLP6MjID3MmK
         Z8evUR0fvKiIpYbGfCLXajkovt0cYnmvwUEb0QLhsxbgq/QNIL4UV5FBSYkEWlfVjd/o
         xK3g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
X-Google-Smtp-Source: AB8JxZrPNPYiiy6ygy8UR7P+/PU1WkCZwD4YaV3WXjxxCS09+cNjCyWCJP7wQ0oRXO1XGyy6AN5iYg==
Subject: Re: [PATCH v5 2/5] efi: Add embedded peripheral firmware support
To: Mimi Zohar <zohar@linux.vnet.ibm.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 "Luis R . Rodriguez" <mcgrof@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H . Peter Anvin" <hpa@zytor.com>
Cc: Peter Jones <pjones@redhat.com>, Dave Olsthoorn <dave@bewaar.me>,
 Will Deacon <will.deacon@arm.com>, Andy Lutomirski <luto@kernel.org>,
 Matt Fleming <matt@codeblueprint.co.uk>, David Howells
 <dhowells@redhat.com>, Josh Triplett <josh@joshtriplett.org>,
 dmitry.torokhov@gmail.com, mfuzzey@parkeon.com,
 Kalle Valo <kvalo@codeaurora.org>,
 Arend Van Spriel <arend.vanspriel@broadcom.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, nbroeking@me.com,
 bjorn.andersson@linaro.org, Torsten Duwe <duwe@suse.de>,
 Kees Cook <keescook@chromium.org>, x86@kernel.org,
 linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-security-module <linux-security-module@vger.kernel.org>
References: <20180429093558.5411-1-hdegoede@redhat.com>
 <20180429093558.5411-3-hdegoede@redhat.com>
 <1525185374.5669.49.camel@linux.vnet.ibm.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <dc122066-9973-a1be-3456-6d6181a8fc9f@redhat.com>
Date: Tue, 1 May 2018 21:11:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1525185374.5669.49.camel@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599072709046551146?=
X-GMAIL-MSGID: =?utf-8?q?1599290094534375386?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 01-05-18 16:36, Mimi Zohar wrote:
> [Cc'ing linux-security]
> 
> On Sun, 2018-04-29 at 11:35 +0200, Hans de Goede wrote:
> [...]
>> diff --git a/drivers/base/firmware_loader/fallback_efi.c b/drivers/base/firmware_loader/fallback_efi.c
>> new file mode 100644
>> index 000000000000..82ba82f48a79
>> --- /dev/null
>> +++ b/drivers/base/firmware_loader/fallback_efi.c
>> @@ -0,0 +1,51 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +#include <linux/efi_embedded_fw.h>
>> +#include <linux/property.h>
>> +#include <linux/security.h>
>> +#include <linux/vmalloc.h>
>> +
>> +#include "fallback.h"
>> +#include "firmware.h"
>> +
>> +int fw_get_efi_embedded_fw(struct device *dev, struct fw_priv *fw_priv,
>> +			   enum fw_opt *opt_flags, int ret)
>> +{
>> +	enum kernel_read_file_id id = READING_FIRMWARE;
> 
> Please define a new kernel_read_file_id for this (eg.
> READING_FIRMWARE_EFI_EMBEDDED).

Are you sure, I wonder how useful it is to add a new
kernel_read_file_id every time a new way to get firmware
comes up?

I especially wonder about the sense in adding a new id
given that the quite old FIRMWARE_PREALLOC_BUFFER is
still not supported / checked properly by the security code.

Anyways I can add a new id if you want me to, what about
when fw_get_efi_embedded_fw is reading into a driver allocated
buffer, do you want a separate EADING_FIRMWARE_EFI_EMBEDDED_PREALLOC_BUFFER
for that ?




> 
>> +	size_t size, max = INT_MAX;
>> +	int rc;
>> +
>> +	if (!dev)
>> +		return ret;
>> +
>> +	if (!device_property_read_bool(dev, "efi-embedded-firmware"))
>> +		return ret;
> 
> Instead of calling security_kernel_post_read_file(), either in
> device_property_read_bool() or here call security_kernel_read_file().
> 
> The pre read call is for deciding whether to allow this call
> independent of the firmware being loaded, whereas the post security
> call is currently being used by IMA-appraisal for verifying a
> signature.  There might be other LSMs using the post hook as well.  As
> there is no kernel signature associated with this firmware, use the
> security pre read_file hook.

Only the pre hook?  I believe the post-hook should still be called too,
right? So that we've hashes of all loaded firmwares in the IMA core.

Regards,

Hans


> 
> thanks,
> 
> Mimi
> 
>> +
>> +	*opt_flags |= FW_OPT_NO_WARN | FW_OPT_NOCACHE | FW_OPT_NOFALLBACK;
>> +
>> +	/* Already populated data member means we're loading into a buffer */
>> +	if (fw_priv->data) {
>> +		id = READING_FIRMWARE_PREALLOC_BUFFER;
>> +		max = fw_priv->allocated_size;
>> +	}
>> +
>> +	rc = efi_get_embedded_fw(fw_priv->fw_name, &fw_priv->data, &size, max);
>> +	if (rc) {
>> +		dev_warn(dev, "Firmware %s not in EFI\n", fw_priv->fw_name);
>> +		return ret;
>> +	}
>> +
>> +	rc = security_kernel_post_read_file(NULL, fw_priv->data, size, id);
>> +	if (rc) {
>> +		if (id != READING_FIRMWARE_PREALLOC_BUFFER) {
>> +			vfree(fw_priv->data);
>> +			fw_priv->data = NULL;
>> +		}
>> +		return rc;
>> +	}
>> +
>> +	dev_dbg(dev, "using efi-embedded fw %s\n", fw_priv->fw_name);
>> +	fw_priv->size = size;
>> +	fw_state_done(fw_priv);
>> +	return 0;
>> +}
> 
