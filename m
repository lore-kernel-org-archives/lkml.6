Return-Path: <robh@kernel.org>
X-Google-Smtp-Source: AIpwx4/w42THe8QNJMgoDTaSvVg/9Yo89EGtUU01lMzAhplU6vCl15JgQF2xmxCS9geIlrYln7Rd
ARC-Seal: i=1; a=rsa-sha256; t=1523367068; cv=none;
        d=google.com; s=arc-20160816;
        b=YNWtS7kymZ5YQgkzhYQpaLAzRpnsvQ6vyOtnd+VMjLUtnjNquwIkqV0BZlBDUpPgAj
         GP5OvZAbbu31D+tdGiemJSSuJQn5BCK5ItoKnEPWHki1+UDMvdP7GiVxrm2SttXPC1GO
         hO3yyXIOdT6cgM6f10aAa+TIES4h3SoEmpP72cjCrgY0jfPRHl4jdE3uOyMdRrHoHdh1
         a+pCz58IfjfD23nWc224McYVVR2MriyWlJJ1usX++wJnVE7vF2a5fUKpKrpAziVkUshd
         1ag9cn0vIp0mbXIhwhaGenB9ESoq7iZTEyOmOT/lHbS2o++X5yRuFsqd6Mg3EMda+ExL
         prYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dmarc-filter:arc-authentication-results;
        bh=G1i6Et1SQ6yv2+k7JYOlW02LqyxIyzqhCLA7zswP3xk=;
        b=jEtNf5ugAHrIB0QYRlK5faC02NXrr/1SPMLJZ8lZMAdsdvAOlWGiic67w9v4O/bR28
         85Nvjr2gW2eQNyrQ9Rp9Kjgt/3AruxpuWF88oiTDOMbzyGCKGsaRikvcCwyIU/ZttJuu
         LLdAAL39eAZHlMCYhecUOjva9Fm94H64/+m3OeoBbDCpstwbQDvQ5MJPR+qSEu5egVFP
         hoeUpiI7S1ygZ8nNJV5KoMARziubT0jz0uymK7vapDRO3mTpS8ujm1WVKAJvYRuiSKv3
         CIzHH0PejwGbKlEc2bb3LzciMhgpWQi9Mo1U6nXxnAT9VjBu/QP2Y4VgK6+oaCVA5SIq
         9ouA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of robh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=robh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of robh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=robh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C134C21842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh@kernel.org
MIME-Version: 1.0
In-Reply-To: <615d6771-00c3-a4a7-a99f-ec4f6e667c8f@kapsi.fi>
References: <1521607244-29734-1-git-send-email-rrajk@nvidia.com>
 <1521607244-29734-4-git-send-email-rrajk@nvidia.com> <20180327145249.xjoo42qow34ksdle@rob-hp-laptop>
 <867aace8-dac7-51d4-bd46-15919b58b37d@kapsi.fi> <CAL_Jsq+AsUiWWBQ7K4OUM58KqQbvBHuFYmXxXLwr7viwoKW-Yw@mail.gmail.com>
 <615d6771-00c3-a4a7-a99f-ec4f6e667c8f@kapsi.fi>
From: Rob Herring <robh@kernel.org>
Date: Tue, 10 Apr 2018 08:30:45 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ-ZJtprXcLxVhRGKp30DTFRO1NzNoqpeSne0marcnmBQ@mail.gmail.com>
Message-ID: <CAL_JsqJ-ZJtprXcLxVhRGKp30DTFRO1NzNoqpeSne0marcnmBQ@mail.gmail.com>
Subject: Re: [PATCH V2 3/9] dt-bindings: Tegra186 tachometer device tree bindings
To: Mikko Perttunen <cyndis@kapsi.fi>
Cc: Rajkumar Rampelli <rrajk@nvidia.com>, Mark Rutland <mark.rutland@arm.com>,
	Thierry Reding <thierry.reding@gmail.com>, Jon Hunter <jonathanh@nvidia.com>,
	Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Jonathan Corbet <corbet@lwn.net>,
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>,
	Manikanta Maddireddy <mmaddireddy@nvidia.com>, Mikko Perttunen <mperttunen@nvidia.com>,
	Arnd Bergmann <arnd@arndb.de>, Timur Tabi <timur@codeaurora.org>, Andy Gross <andy.gross@linaro.org>,
	Wei Xu <xuwei5@hisilicon.com>, Alex Elder <elder@linaro.org>,
	"heiko@sntech.de" <heiko@sntech.de>, Krzysztof Kozlowski <krzk@kernel.org>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>, devicetree@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux PWM List <linux-pwm@vger.kernel.org>,
	linux-tegra@vger.kernel.org, Linux HWMON List <linux-hwmon@vger.kernel.org>,
	linux-doc@vger.kernel.org,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	Laxman Dewangan <ldewangan@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595520871004470026?=
X-GMAIL-MSGID: =?utf-8?q?1597366147761570317?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 9, 2018 at 9:37 AM, Mikko Perttunen <cyndis@kapsi.fi> wrote:
>
>
> On 04/09/2018 04:21 PM, Rob Herring wrote:
>>
>> On Mon, Apr 9, 2018 at 12:38 AM, Mikko Perttunen <cyndis@kapsi.fi> wrote:
>>>
>>> Rob,
>>
>>
>> Please don't top post to lists.
>>
>>> this binding is for a specific IP block (for measuring/aggregating input
>>> pulses) on the Tegra186 SoC, so I don't think it fits into any generic
>>> binding.
>>
>>
>> What is it hooked up to to measure? You only mention "fan" five times
>> in the doc.
>
>
> In practice, fans.
>
>>
>> You have #pwm-cells too, so this block has PWM output as well? If not,
>> then where's the PWM for the fan control because there is no point in
>> having fan tach without some control mechanism.
>
>
> It doesn't provide a PWM output. The (Linux) PWM framework provides
> functionality in both directions - control and capture. But if the device
> tree #pwm-cells/pwms properties are only for control, we may need to
> introduce a new #capture-pwm-cells/capture-pwms or similar.

Yes, perhaps. But there is no point in having
#capture-pwm-cells/capture-pwms if you aren't describing the
connection between the fan and the fan controller.

> The idea is that the generic fan node can then specify two pwms, one for
> control and one for capture, to enable e.g. closed-loop control (I'm not
> personally familiar with the usecase for this but I could imagine something
> like that). The control PWM can be something completely different, maybe not
> a PWM in the first place (e.g. some fixed voltage).

Yes. As you can have different types of fans (3-wire, 4-wire, etc.)
they would have different compatibles and differing properties
associated with them.

>> There's only so many ways to control fans and types of fans, so yes,
>> the interface of control and feedback lines between a fan and its
>> controller should absolutely be generic.
>
>
> I'm not quite getting what you mean by this. Clearly we need a custom
> compatibility string for the tachometer as it's a different hardware block
> with different programming than others.

Yes, of course. It's the interface between fan controllers and fans
that I'm concerned about.

> Or are you complaining about the
> nvidia,pulse-per-rev/capture-window-len properties?

Well, those sound like properties of a fan (at least the first one),
so they belong in a fan node.

The aspeed fan controller is probably the closest thing we have to a
fan binding. Look at that if you haven't already.

Rob
