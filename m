Return-Path: <hdegoede@redhat.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524559716; cv=none;
        d=google.com; s=arc-20160816;
        b=de55Scmduq3uMXwQ5z65QmSRz810CKCpdjydBeyFQWNdiDwlaOblletXwVDHFyPotz
         HCe6R6DnGp6lX5/6vkw3+DVQDR65dQgdoYpl5OJk5WlnupLYK38RPHOJK9copliqoNx3
         5H0eVmk+dpDUA1F48DSylEWVhfFjdv+bwrFcEgHVUkQ1sN4DJJ4/YyRSRnw9yMTpLuzG
         ovT4EXAQQnC2UV3Lbd0rdeqSQRxyvT+OuCK1OW26ayX/4nHyEU01QjwxALjpz+Qc9LWJ
         kk+ATwPTJ93bTUFJOr9NCpM5xFQ1G1eoaOZCUm91v791ZWKqCrcEZbfLM0p+5zylCwdC
         aGFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=Qp0W6Bn7gbDs4tKDMivTaUO1ZGWmNIIfup/WG7snOlw=;
        b=0YLH1qn4+v6bHos2Qt47TDD9Vv9vh5Yo76J87bDG9vgZFjFwBBTwTPBJy1B9GPFsmj
         InaJ+pYMqaODF72CLuhSzrOhumKSvty8y2k1sDkm0igD1ozgx/9yg6hVFTtE0uUYCs8J
         A0tzzNPVE2w8XnpXO7Y0pdjQd10Miemq+folQ9RQg5U+lO8sJtIqnN6uTSSp1QlW2XpK
         scrmmlftULC3GcHQ7DArTizNeWA1Axa6ViYtR2j5fzKyMpb3W3BsGSRiQGynewmKJgLB
         Yx6mXdKOlZk/YV9pbp1vlAnU6R6IZFYe7tIGoUyfck10H+xfrvuZQoa60VqE27yBQVAe
         Z04w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
X-Google-Smtp-Source: AIpwx48k4iR6lxpY96v7l9ejrTog81uwOoUkJj6BHOVGmwQ091yjiFl5FhGSm6wymWGSQlMvV4y5CA==
Subject: Re: [PATCH] usb: always build usb/common/ targets; fixes
 extcon-axp288 build error
To: Chanwoo Choi <cw00.choi@samsung.com>, Randy Dunlap
 <rdunlap@infradead.org>, USB list <linux-usb@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Cc: Fengguang Wu <fengguang.wu@intel.com>,
 MyungJoo Ham <myungjoo.ham@samsung.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>
References: <d2641585-65d8-76d4-0668-a278955967d8@infradead.org>
 <CGME20180417090153epcas4p16fcd18a906baef77b8e87471916a6ed4@epcas4p1.samsung.com>
 <9632a61d-fb15-4764-93ae-d6f4049cba82@redhat.com>
 <5ADEDFF6.3010902@samsung.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <e71a77ab-2ee8-3ffc-1fc5-3e500921f0e7@redhat.com>
Date: Tue, 24 Apr 2018 10:48:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <5ADEDFF6.3010902@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597969071996624646?=
X-GMAIL-MSGID: =?utf-8?q?1598616728779321116?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 24-04-18 09:42, Chanwoo Choi wrote:
> On 2018년 04월 17일 18:01, Hans de Goede wrote:
>> Hi,
>>
>> On 17-04-18 07:14, Randy Dunlap wrote:
>>> From: Randy Dunlap <rdunlap@infradead.org>
>>>
>>> The extcon-axp288 driver selects USB_ROLE_SWITCH, but the USB
>>> Makefile does not currently build drivers/usb/common/ (where
>>> USB_ROLE_SWITCH code is) unless USB_COMMON is set, so modify
>>> the USB Makefile to always descend into drivers/usb/common/
>>> to build its configured targets.
>>>
>>> Fixes these build errors:
>>>
>>> ERROR: "usb_role_switch_get" [drivers/extcon/extcon-axp288.ko] undefined!
>>> ERROR: "usb_role_switch_set_role" [drivers/extcon/extcon-axp288.ko] undefined!
>>> ERROR: "usb_role_switch_get_role" [drivers/extcon/extcon-axp288.ko] undefined!
>>> ERROR: "usb_role_switch_put" [drivers/extcon/extcon-axp288.ko] undefined!
>>>
>>> An alternative patch would be to select USB_COMMON in the EXTCON_AXP288
>>> driver Kconfig entry, but this would build more code in
>>> drivers/usb/common/ than is necessary.
>>
>> Ah, that variant of fixing this got posted yesterday and I acked that,
>> but I agree that this version is better.
>>
>> Greg, what is your take on this fix?
>>
>> Chanwoo Choi, please wait with merging the fix from yesterday until
>> we've a decision which fix to use.
> 
> OK. I'll not send pull request for fix patches until deciding them.

Greg has picked up another patch to fix this, so you can drop this.

Regards,

Hans
