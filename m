Return-Path: <sdias@codeaurora.org>
X-Google-Smtp-Source: AB8JxZqYEtgx07ZYn2rVaVGaSxTdEjpPPIzdwBQ6infGUON1m8J/eHq5KiR5QkqleChKcf9ypAb8
ARC-Seal: i=1; a=rsa-sha256; t=1525403107; cv=none;
        d=google.com; s=arc-20160816;
        b=fuNGdyJHPZFKfGyO6fYjBylDqFwZiMlJGObO4aet7a99Lwli2gx8DUnHPul7V/H7aH
         VyuzoG0VRoTxZuynoMkHLAu3kAi6cF1DbC3BJfC7W8u4PxFE5t24hDLcXYf7xqKV+KnG
         x8MCuikeVKwurmPDOd+4PDhn5eV/DpoIjW3O8Q6BTJ8kDB32lQHorNPk0t4lxrh/Rw11
         t2MMAfWa4qHkyHNixpBKOsf8tEFcZWvmzbQ8hR3gYP7mx+kfngQ+Rd8w+buQJ3WNE7zS
         79+eckoZh7Zn0GrmAiyNTfhhuxaRfQszC/zo8GHzPXvmdHhrWpM6zw4Y7zgLgp3bEk0Z
         KnFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=ajB3X5WyhdyzymMtootBRVBZEQXmyq/hoQ6v4Vcc00E=;
        b=So7JuzOA64wCNmfJ+jE7UjH5UYuUsxoktxFW2HIG08phN+821gsOpo/JHuYD3VUzpp
         o7f+3D6KUGQjQwFjVWBftOq0D+vW4oHlYj9LJ2eogENoOVtRKfYQ+DDqWKv6ou0M9J68
         AAJD8rXsGXoIaVkp95Z9t4TDSpwT747ErSLy4XQcNCfFzSIMlOSSpjU6vwHWMXB5ftDp
         PixLAQlSDZpiqIlCpBiVr7xecuwoiBGv2gi7+SftM30zBlUNOzsGust0yoE5UfTejRK4
         uiyuCAZc5NEB+QoelOHP1xd8gcHBPuevc01IgaEBhqE5uJMbQtFXR7LHACIud5BgM5ZO
         ufiQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Q7w2T4/M;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Q7w2T4/M;
       spf=pass (google.com: domain of sdias@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=sdias@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Q7w2T4/M;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Q7w2T4/M;
       spf=pass (google.com: domain of sdias@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=sdias@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ECBE36028D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sdias@codeaurora.org
Subject: Re: [PATCH v1 1/4] mhi_bus: core: Add support for MHI host interface
To: Pavel Machek <pavel@ucw.cz>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, Tony Truong <truong@codeaurora.org>
References: <1524795811-21399-1-git-send-email-sdias@codeaurora.org>
 <1524795811-21399-2-git-send-email-sdias@codeaurora.org>
 <20180503192110.bjd46afhe2ein3qm@devuan>
From: Sujeev Dias <sdias@codeaurora.org>
Message-ID: <d7c9fdd2-6078-503a-517a-f20dd6d8098f@codeaurora.org>
Date: Thu, 3 May 2018 20:05:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180503192110.bjd46afhe2ein3qm@devuan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598864306474861315?=
X-GMAIL-MSGID: =?utf-8?q?1599501088778996966?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Pavel


On 05/03/2018 12:21 PM, Pavel Machek wrote:
> Hi!
>
>> MHI Host Interface is a communication protocol to be used by the host
>> to control and communcate with modem over a high speed peripheral bus.
>> This module will allow host to communicate with external devices that
>> support MHI protocol.
> I have Motorola Droid 4 cellphone here, with Qualcomm GSM modem. But
> it talks over serial line and USB. I guess MHI is not applicable to my
> hardware?
>
MHI is for PCIe based modem, in any case I can't comment about 
commercial devices.
>> +MHI Devices
>> +-----------
>> +Logical device that bind to maximum of two physical MHI channels. Once MHI is in
>> +powered on state, each supported channel by controller will be allocated as a
>> +mhi_device.
> What kind of protocol is running over MHI? I guess its not AT
> commands. QMI? Or something entirely different?
All modem services between external modem and host go over MHI.
So QMI, AT, all other data and control services go thru MHI host driver.
> 									Pavel

Thanks
Sujeev

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
