Return-Path: <sudeep.holla@arm.com>
X-Google-Smtp-Source: AB8JxZryr0va/VH85JUunIjCIH/96bdfCEKUv0sekXc/wkDk5FdcwbH6LoPOWOEoXQvGtnxY92P7
ARC-Seal: i=1; a=rsa-sha256; t=1524740763; cv=none;
        d=google.com; s=arc-20160816;
        b=KeE03y2vVPfEqr6RG5b9WMPAmSnEa/HwovlS/GtWP1NUve8rINEEq/ABr5vWSy9D0V
         2+KHfxHVKXKGfSl4WlDfKi0CK0fk85YraVoW7f5T9/dsvumyTbLJQcLbFoTCl2DBcSp5
         N02/RBC3xu9SHC0UPpv5+e9SaigtdM6EKZycyU/Ab/RkKQeGVPkniws0QA6LtBNOc3Ma
         1jdQH3EZCWGJfOYYgPWSSglaql07B/oHfVj58fIpSKFaAI808f/CVujI+qVcsD7cqu/q
         EI3wt+GkNqS6yp47XSAqshdpfH8pWbePtULMreR1Pfh3suG6u6qg9nMceyawZrc0GTWk
         3aeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:to:subject
         :cc:arc-authentication-results;
        bh=YV+LZlbX4ZS056ajV7pv7buuQMnE8TkppPkp1YTXLMk=;
        b=mXCUMiDKuM10ImuRwxPOjjQvF3dIdba8XXBcUUfh45uEClSuAbVUAmqfbUwzwcIIip
         CSQbuGRLEQ+r7Y7xBbhEz6Urt+me3A+zF1rm5vJMAqzKq2ZwS52PJshTajDSeejy3bq2
         KQxMdK6tj8blJpbDvugt7oN7bmr4lZnjqjHe4kNJPiDKfPcSI5SRMkyvSI7xZsOdz3ky
         0LVw2vTj6hXjSFcPFu0T727fxjBh6DRS52FFuhxwN9pxyBfzFcKoG0AMnLMQ8U/oz6Cj
         JFdmAsfCqdbuCAtrYzi9cv2CigI+kzzo5PYrg5DArV+f406hQ0eYh9Vx8zKYF7vvgOm8
         Em6w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Cc: Sudeep Holla <sudeep.holla@arm.com>,
 linux-arm-kernel@lists.infradead.org, Lorenzo.Pieralisi@arm.com,
 hanjun.guo@linaro.org, rjw@rjwysocki.net, Will.Deacon@arm.com,
 Catalin.Marinas@arm.com, gregkh@linuxfoundation.org, Mark.Rutland@arm.com,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 wangxiongfeng2@huawei.com, vkilari@codeaurora.org, ahs3@redhat.com,
 Dietmar.Eggemann@arm.com, Morten.Rasmussen@arm.com, palmer@sifive.com,
 lenb@kernel.org, john.garry@huawei.com, austinwc@codeaurora.org,
 tnowicki@caviumnetworks.com, jhugo@qti.qualcomm.com, timur@qti.qualcomm.com,
 ard.biesheuvel@linaro.org
Subject: Re: [PATCH v8 07/13] drivers: base cacheinfo: Add support for ACPI
 based firmware tables
To: Jeremy Linton <jeremy.linton@arm.com>, linux-acpi@vger.kernel.org
References: <20180425233121.13270-1-jeremy.linton@arm.com>
 <20180425233121.13270-8-jeremy.linton@arm.com>
From: Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <c3306746-aacd-5ed8-95d6-a3186ec2089f@arm.com>
Date: Thu, 26 Apr 2018 12:05:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180425233121.13270-8-jeremy.linton@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598766321415119595?=
X-GMAIL-MSGID: =?utf-8?q?1598806570594155789?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 26/04/18 00:31, Jeremy Linton wrote:
> Call ACPI cache parsing routines from base cacheinfo code if ACPI
> is enable. Also stub out cache_setup_acpi() so that individual
> architectures can enable ACPI topology parsing.
> 

[...]

> +#ifndef CONFIG_ACPI
> +static inline int acpi_find_last_cache_level(unsigned int cpu)
> +{
> +	/* ACPI kernels should be built with PPTT support */

This sounds incorrect for x86. But I understand why you have it there.
Does it makes sense to change above to .. ?

#if !defined(CONFIG_ACPI) || (defined(CONFIG_ACPI) && !(CONFIG_ACPI_PPTT))

-- 
Regards,
Sudeep
