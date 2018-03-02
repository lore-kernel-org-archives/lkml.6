Return-Path: <jeffy.chen@rock-chips.com>
X-Google-Smtp-Source: AG47ELt86Px+WDMZ6B4dGnXBmr9410GRUVN9uwUJrwdiagZF17f60O1gdtPTtSF7HZ955WxVcmTM
ARC-Seal: i=1; a=rsa-sha256; t=1519963053; cv=none;
        d=google.com; s=arc-20160816;
        b=RDviZ0qjYQ5L1RhwL6i0Z/Ab3Ex6Zh5HUNagZxZrH68J1+93CzQhYRz+R8hatSUzqp
         ufO83E6WEXya7e7kz/gtoIWvqJSRCrCSUYtnzIaV5Yh6LilaJueYdP6bzHmV4p3yBAyb
         XkHPh4QiRoF7uZtIDzzAFvWy2+tXW/+rrBZZnFJqBul+DRrIEp0//CbbxoFWTzpWrMrL
         TwdBrqXPlw7OUWg9zwoC6wISrYxEBBJ/M0oH2oaeCgtN97IoLdR682zv8IHn7hQtoS8W
         JKXEkOzcimbQMzKkZbWow+8x2HLFb7u82puMuDZCx3ZSGszSlgTy/4IvKSvSvsE02072
         K6HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:in-reply-to:references:subject:cc:to
         :mime-version:user-agent:from:date:message-id
         :arc-authentication-results;
        bh=ev7OUfgNxv8c38vIcFpaFwOa/tnQfWDhJHCmr5fd8io=;
        b=ZwPjYCNeAQdVlKeWXy3YLREgHxiM1XPkZ12sDX53Hrq3AJXBPvcQdcyGucbH7KNlmc
         z9zDwo558KI9SrjTqTWsqeIOj0nSeUkCh1Zln07HkMpB1A/vdeixgzVj7oMyxoRhGSAV
         +KypbvHQnvLjmqb9m7WkanO33q3P2OXEdbt2XutCvQgjZRNTghgmJ3hlUaRbM67BIOsd
         eRpL3be/ihCDrC1yo3+FkOHQGu2moG13puRkAUOgKuf+odg0FOo/Z9Fams31tljr+0aM
         zJg7i6lHVwY6n+eMzGlzIUch0/folI+Cuuy+kwYDOc1J+nFHtjb/OTDAu8TkMdUiA9WM
         QA0A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jeffy.chen@rock-chips.com designates 211.150.80.19 as permitted sender) smtp.mailfrom=jeffy.chen@rock-chips.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jeffy.chen@rock-chips.com designates 211.150.80.19 as permitted sender) smtp.mailfrom=jeffy.chen@rock-chips.com
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ADDR-CHECKED4: 1
X-ABS-CHECKED: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
X-RL-SENDER: jeffy.chen@rock-chips.com
X-FST-TO: briannorris@chromium.org
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-UNIQUE-TAG: <bbe2218598ee7854f0d48c7698441d3c>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Message-ID: <5A98CBA1.6090801@rock-chips.com>
Date: Fri, 02 Mar 2018 11:57:21 +0800
From: JeffyChen <jeffy.chen@rock-chips.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:19.0) Gecko/20130126 Thunderbird/19.0
MIME-Version: 1.0
To: Brian Norris <briannorris@chromium.org>
CC: linux-kernel@vger.kernel.org, briannorris@google.com,
 dtor@google.com, dianders@google.com,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 Thomas Gleixner <tglx@linutronix.de>, Joseph Lo <josephl@nvidia.com>,
 stephen lu <lumotuwe@gmail.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 linux-input@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: Re: [PATCH v2 1/3] Input: gpio-keys - add support for wakeup event
 action
References: <20180210110907.5504-1-jeffy.chen@rock-chips.com> <20180210110907.5504-2-jeffy.chen@rock-chips.com> <20180212221309.GA66974@ban.mtv.corp.google.com> <5A8FE726.6080903@rock-chips.com> <20180302023229.GA164361@rodete-desktop-imager.corp.google.com>
In-Reply-To: <20180302023229.GA164361@rodete-desktop-imager.corp.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592012049405115473?=
X-GMAIL-MSGID: =?utf-8?q?1593796778615685697?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Brain,

Thanks for your reply.

On 03/02/2018 10:32 AM, Brian Norris wrote:
>>> > >What about the 'else' case? Shouldn't we try to handle that?
>> >i think the else case is for irq key, which would generate down and up
>> >events in one irq, so it would use the same trigger type for all these 3
>> >cases.
> Not necessarily. It uses whatever trigger was provided in
> platform/DT/etc. data. You could retrieve that with
> irq_get_trigger_type() and try to interpret that. Or you could just
> outlaw using that combination (e.g., in the binding documentation).
i think for the IRQ button case the assert/deassert/any are using the 
same irq trigger type, so it should be ok to leave the wakeup trigger 
type to be 0(not reconfigure the trigger type)...

i've made a v3 to add a comment about that, but forgot to send it :(

>
> Brian
>
