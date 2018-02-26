Return-Path: <sudeep.holla@arm.com>
X-Google-Smtp-Source: AG47ELt7WyjqCerrVOtT7YPASRhUnn7dLDiiTb6rdXxVILHn3RVFGCadyedzKi7E5xJNL9J9Y9uN
ARC-Seal: i=1; a=rsa-sha256; t=1519665063; cv=none;
        d=google.com; s=arc-20160816;
        b=r2rEUUt/x2sJOroyidp1gl6cnIaE4CGyDsfdp6mZPDp8SuViOJz8qDUBjOjOFXWTIa
         Ylhixsy7KCZVkhcxb85VsgEeZIs81FQFbAPsmTzF5MEzLEMqYzaxUxZNZs4aFEirYq8e
         6BTftDJCrJfPONyb7FWVlhXh8vLIY0irQI8pIaJIkgnoVAwN7Zo2cKGjwxWGOzMXBTa0
         B98WJWdknlwBjseG/eaZr7yHJAS3zVSy0nyxUlVTdY4K14Q9HLkOW5w5nGyVGK+frPV8
         6x+mlXge3nYVfYbyq8rX8/TMyDJKTqMQJkO94Fd4NSmXAlsRYtxnV+H3Nm32wCfklFp3
         y/lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:to:subject
         :cc:arc-authentication-results;
        bh=45ubT5E2Rszgujdo7t7VKRX1LAP68Yy/BL83fcsj2Og=;
        b=rinzXVwt68GsC8daOB/C5AHo0r+SUiDZkwYjECX3Dqa8LpdN5UvanLeuWSD4ZH3WLa
         ZrVbj5KxjtXbl4Q/lHFEpSNL7JQl5syUuKm6ThQ8QxvvSBUUoNuuH3vRd2px5eeaFRp+
         /1MPafIElrqS1eTnnV1WSmKV0vPQ4ub+hytW9sJ052Dkp5YfivVEJTD8jCF2VQkp1X7e
         BEMje44IKkyNUhev3w/GF3R7pUcqvR/WsXAdIACJbrwR/l/NOlWipvEWxYaaQEFxrbsY
         nv2gbxgEXgxQOTajt9wzTRbjSy7n66KPDk5GnqV6IxUV+b8yuip+C0oO2OZTlKT4QA/5
         e5LQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Cc: Sudeep Holla <sudeep.holla@arm.com>,
 ALKML <linux-arm-kernel@lists.infradead.org>,
 LKML <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>,
 Alexey Klimov <klimov.linux@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v6 03/20] firmware: arm_scmi: add basic driver
 infrastructure for SCMI
To: Philippe Ombredanne <pombredanne@nexb.com>
References: <1519403030-21189-1-git-send-email-sudeep.holla@arm.com>
 <1519403030-21189-4-git-send-email-sudeep.holla@arm.com>
 <CAOFm3uE8q63h-zk3FGnZkDqvxjJj=d0mfuUtK+nyioKosmt=dw@mail.gmail.com>
From: Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <9c173e91-cb4e-fcc4-7671-b16c0a672401@arm.com>
Date: Mon, 26 Feb 2018 17:10:59 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAOFm3uE8q63h-zk3FGnZkDqvxjJj=d0mfuUtK+nyioKosmt=dw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593209576065765675?=
X-GMAIL-MSGID: =?utf-8?q?1593484313069720852?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Philippe,

On 26/02/18 15:57, Philippe Ombredanne wrote:
> Sudeep,

[...]

>> --- /dev/null
>> +++ b/drivers/firmware/arm_scmi/common.h
>> @@ -0,0 +1,77 @@
>> +/*
>> + * System Control and Management Interface (SCMI) Message Protocol
>> + * driver common header file containing some definitions, structures
>> + * and function prototypes used in all the different SCMI protocols.
>> + *
>> + * Copyright (C) 2017 ARM Ltd.
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms and conditions of the GNU General Public License,
>> + * version 2, as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope it will be useful, but WITHOUT
>> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>> + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
>> + * more details.
>> + *
>> + * You should have received a copy of the GNU General Public License along
>> + * with this program. If not, see <http://www.gnu.org/licenses/>.
>> + */
> 
> Would you consider using the SPDX tags [1] instead of this legalese?
> Thanks!
> 

Sure, I have fixed locally [1] for now, will post if there are any other
changes before PR.

-- 
Regards,
Sudeep

[1] https://git.kernel.org/sudeep.holla/linux/h/for-list/new_arm_scmi
