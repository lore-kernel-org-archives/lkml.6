Return-Path: <eballetbo@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518560755; cv=none;
        d=google.com; s=arc-20160816;
        b=0ViMhm7PI8coYGg0i1/6ENTA+a57JgyddEEXrFf1RLA4hlEcvZrw7hFiwHHs1fmri1
         9FoIrrk9pZe+K5y7F0LCP5dmyCBPswM8qcBhFHNNYzSYMDl8KGfmviUURdVYKQiBDgAN
         qyqxJsFtVzg9gVMLYg5llpFsOWtu/u1/XhkQXPu7lcSLX82nvbbev+t559mvKIq0+Fv8
         +v6b66My59Yy1gCFozjK0pxsCQ3xC/hd/2OLVb5GjZKqvRI2maE2lEOaMeKoGrVdoP6l
         R6vnzs2RD8micbaxSzpsbBj7RlLaqqncEIGc91b3dHF5WRK8jlhcwl6hPTdfZtERtHty
         EneQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=n9jO8saCzf4ACac2tKhBiL5ZatJkQpMZHjDn57rS3bY=;
        b=IjFNPPqFS3DtQV1m+0R0t1a8FrRzraxZJ9eFtKDkfhe8Ok183Lrg1t/8rg3QHAmEWh
         bXB73t/nEaK6NjkNGRnfLKSCn12CijtncUmsnEv2EeQYzvOqavYUApnH1iDHhDB7a0a+
         vxGjFq3dwztKFjMzB3SoMlcabQqLmJ8EmuhLE225DM8iPnJIMGTlNWTPLX0y2emRSJtL
         +KaNuLBQOneQ4ZSYDIEQu1SEkDowenE1kAeGQEoBgNN9kc29ZfvrUz1HmLxmc0UXF6Rm
         pq8iyAHOkvgjnq93IKZlPHYcDLqOCsfgxcgqVb0gUBYNzPyK9cz1Rb1HhxC/VgjIHPwJ
         DQLQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=O6ugTyro;
       spf=pass (google.com: domain of eballetbo@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=eballetbo@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=O6ugTyro;
       spf=pass (google.com: domain of eballetbo@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=eballetbo@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x226OdqvboLoZ2GAfCkUQZG6GROEwze4n1R6AZOQNsWb1pNBuu3Se5AyR1JC2oc815F2Bq8Y85xGxSxlv5WziIsI=
MIME-Version: 1.0
In-Reply-To: <20180213182521.GA51247@rodete-desktop-imager.corp.google.com>
References: <20180210110907.5504-1-jeffy.chen@rock-chips.com>
 <20180210110907.5504-2-jeffy.chen@rock-chips.com> <20180212221309.GA66974@ban.mtv.corp.google.com>
 <059e2aa9-bf94-517d-a132-abe851ec69f7@collabora.com> <20180213182521.GA51247@rodete-desktop-imager.corp.google.com>
From: Enric Balletbo Serra <eballetbo@gmail.com>
Date: Tue, 13 Feb 2018 23:25:55 +0100
Message-ID: <CAFqH_52iUc3HQmTSoFQ5FOf5gJECf3nuPY2_ks6NrwFC4oudug@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] Input: gpio-keys - add support for wakeup event action
To: Brian Norris <briannorris@chromium.org>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>, Jeffy Chen <jeffy.chen@rock-chips.com>,
	linux-kernel <linux-kernel@vger.kernel.org>, Brian Norris <briannorris@google.com>, dtor@google.com,
	Doug Anderson <dianders@google.com>, Thomas Gleixner <tglx@linutronix.de>, Joseph Lo <josephl@nvidia.com>,
	stephen lu <lumotuwe@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Kate Stewart <kstewart@linuxfoundation.org>, linux-input@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>,
	Arvind Yadav <arvind.yadav.cs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592012049405115473?=
X-GMAIL-MSGID: =?utf-8?q?1592326363434875949?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

2018-02-13 19:25 GMT+01:00 Brian Norris <briannorris@chromium.org>:
> Hi Enric,
>
> On Tue, Feb 13, 2018 at 11:40:44AM +0100, Enric Balletbo i Serra wrote:
>> On 12/02/18 23:13, Brian Norris wrote:
>> > On Sat, Feb 10, 2018 at 07:09:05PM +0800, Jeffy Chen wrote:
>> >> Add support for specifying event actions to trigger wakeup when using
>> >> the gpio-keys input device as a wakeup source.
>> >>
>> >> This would allow the device to configure when to wakeup the system. For
>> >> example a gpio-keys input device for pen insert, may only want to wakeup
>> >> the system when ejecting the pen.
>> >>
>> >> Suggested-by: Brian Norris <briannorris@chromium.org>
>> >> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
>> >> ---
>> >>
>> >> Changes in v2:
>> >> Specify wakeup event action instead of irq trigger type as Brian
>> >> suggested.
> [...]
>> Not sure if you were aware but there is also some discussion related to this,
>> maybe we can join the efforts?
>>
>> v1: https://patchwork.kernel.org/patch/10208261/
>> v2: https://patchwork.kernel.org/patch/10211147/
>
> Thanks for the pointers. IIUC, that's talking about a different problem:
> how to utilize a GPIO key in level-triggered mode. That touches similar
> code, but it doesn't really have anything to do with configuring a
> different wakeup trigger type.
>

Right, sorry. I see now what you are doing.

> The two patches would need to be reconciled, if they both are going to
> be merged. But otherwise, I think they're perfectly fine to be separate.
>

Yes, that's why I got confused, I had those patches applied on my tree
and when I tried to apply these failed and I wrongly assumed that were
doing the same. Waiting to test the third version ;)

Thanks,
 Enric

> Brian
