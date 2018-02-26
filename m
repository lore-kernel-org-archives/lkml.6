Return-Path: <hdegoede@redhat.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519643994; cv=none;
        d=google.com; s=arc-20160816;
        b=n0EdVsB6VGtvm98gsalT/OVhdxNGxC7CKBJyOyz5t0X3YAKG70GVzVQlPcNYyKR8p7
         Gy4xj0AoJB3kbXNiti7YatDMlL4hQkJH3auyVT0TwNi7I4Z+SYwSoXJm8S7Ge602lddQ
         F4Uj8dzpvqIAOIK8gFceLggHJGxD1j5jrQ1JI27QZYMhZMS2YZGnYkZhPcsbrg+Jo6vV
         bFANytCz8e4IP7HP/osqALsw1GeHSPKILQri/bo90fHEs0WJPhZKZUMU/6072HzfAGXC
         VHqsqkXqnuoNaDYBHQ23BgvTdu0GZjLE3KKRwquet18R4TQOWw4HKPxObco5YDuf89cI
         +XjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=4LMHWoT+UF2opxghWHn+kDo2CCeTJ75t5thOZx+UsQU=;
        b=JG4WfA5vHFLcasKP/NcXHGleeoqLP7TFe/Pj3v1OzQvT6NHJko77AhG25itmpmOCz3
         sYXIXpOcRzIJGiPyuZXSC2bDx0XOhcnTSeShcHLz5JGQ1069Fm/INFgJyzFSAl1TEvTX
         rzkHwowKZu1zErwEeuPgNeeSkLvbXqxZuK1lBThwULRh7EgN8NNR6seVwEq3y8akPzbm
         qp4kx2F7B8g+myAQ8rMZlALAuxDot5BZIcWVAfhxM4kMpxo0rJ0/YVsj8hg633FIr82i
         15/3VaUpZQxnEVvdpG7kTYJkZr82q4/RQ8I5mhJHil3SBIfsNInbQkYqAJ15Vlyq1z7i
         Tj6w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
X-Google-Smtp-Source: AG47ELt6CVhXDqhyk/UP+cStNm+74fnQI+kcUR+Yug8V+nr+jLh3hFeLaGhNEr8MP3bWBn4ylQXW6g==
Subject: Re: [PATCH v3 00/12] USB Type-C device-connection, mux and switch
 support
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>,
 MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi
 <cw00.choi@samsung.com>, Mathias Nyman <mathias.nyman@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Guenter Roeck <linux@roeck-us.net>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Platform Driver <platform-driver-x86@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 USB <linux-usb@vger.kernel.org>
References: <20180226090925.29436-1-hdegoede@redhat.com>
 <CAHp75VevNQB_8BTaazq94RHQ_Nbs=CcjJwfw+Ph9iLunLYb9kg@mail.gmail.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <f8fc1193-2057-497f-3494-aeef437f1341@redhat.com>
Date: Mon, 26 Feb 2018 12:19:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VevNQB_8BTaazq94RHQ_Nbs=CcjJwfw+Ph9iLunLYb9kg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593454016298840899?=
X-GMAIL-MSGID: =?utf-8?q?1593462221457750601?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 26-02-18 11:59, Andy Shevchenko wrote:
> On Mon, Feb 26, 2018 at 11:09 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>> Hi All,
>>
>> Here is version 3 of Heikki's and my USB Type-C device-connection, mux and
>> switch support series. Version 2 and 3 bring various small code and style
>> fixes based on review (no major changes).
>>
>> Here is the original cover-letter of v1:
>>
>> Some devices with an USB Type-C connector have a bunch of muxes
>> behind that connector which need to be controlled by the kernel (rather
>> then having them controlled by firmware as on most devices).
>>
>> Quite a while back I submitted a patch-series to tie together these muxes
>> and the Type-C Port Manager (tcpm) code, using the then new drivers/mux
>> framework. But the way I used the mux framework went against what it was
>> designed for, so in the end that series got nowhere.
>>
>> Heikki Krogerus from Intel, who maintains the USB TYPEC subsystem, has
>> recently been working on solving the same problem for some boards he is
>> doing hardware-enablement for.
>>
>> Heikki has come up with a number of infrastructure patches for this.
>> The first one is a new device-connection framework. This solves the
>> problem of describing non bus device-links on x86 in what in my experience
>> with this problematic area is a really nice simple, clean and *generic*
>> way. This could for example in the near future also replace the custom
>> lookup code in the pwm subsys and the custom pwm_add_table() /
>> pwm_remove_table() functions.
>>
>> The other 3 patches add a framework for the different type of Type-C /
>> USB "muxes".
>>
>> Heikki and I have gone through a number of iterations of these patches
>> together and we believe these are now ready for merging. Since merging
>> infrastructure patches without users is not done and Heikki's own use-case
>> for these is not yet ready for merging, the rest of this series consists
>> of patches by me to make the Type-C connector found on some Cherry Trail
>> devices (finally) be able to actually work as an USB port and not just
>> a charge port.
>>
>> The last patch uses the new usb-role-switch framework to also do proper
>> devcie / host switching on CHT devices with a USB micro AB connector.
>> This is also a big feature for CHT users, because before this they had
>> to do a reboot to get an OTG-host cable recognized (on some devices).
>>
>> Part of this series is an usb-role-switch driver for the role-switch
>> found inside the xhci controller on e.g. CHT devices, this is currently
>> implemented as the generic xhci controller instantiating a platform
>> child-device for this, since this really is a separate chunk of HW
>> which happens to sit in the XHCI mmio space. This approach may not be
>> universally liked, given that in this new series the role-switch driver
>> is much smaller and does not have any external deps anymore we could
>> just integrate it into the xhci code if that is preferred.
>>
>> About merging this series (once everything is reviewed, etc.), there are
>> quite some interdependencies in it esp. a lot of the patches depend on
>> the first patch. Luckily patches 1-10 all apply to subsystems which are
>> maintained by Greg (most to the USB subsys). Which just leaves patches
>> 11 and 12 once 1-10 are merged. Greg, can you create an immutable branch
>> for the platform/x86 and extcon maintainers to merge once this is done?
> 
> Didn't have time to comment on v2, so here we are:
> you are using in even the same file two styles, i.e. IS_ERR_OR_NULL
> vs. !x || IS_ERR(x) (and negative ones).

Good catch, I only see this in "usb: common: Small class for USB role switches",
will fix for v4.

> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

So with the above fixed I can apply your reviewed-by to the entire series?

Regards,

Hans
