Return-Path: <robh@kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3842876-1522292968-2-14588052780156383730
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='198.145.29.99', Host='mail.kernel.org', Country='US', FromHeader='org',
  MailFrom='org'
X-Spam-charsets: to='UTF-8', cc='UTF-8', plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: robh@kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522292967; b=izktVDZWahtVc+dkKAgABOZezbbJaHRm0m3/skpQuVnZwOG
    6etduU7P5yD0p5f9ZlsdlPOYe4nRYVfHi7LYdFGXwQeSVzSaW5Evr/hf9TABLDzX
    HeE0ZH6HR/RTMhpptn7moB9rFcMLKgEqV0JOdqVZcEZ4/bdv6M+UjTcZ5bOaEXzw
    okGVkanwOMoUbsvObP9Tw8MyuOObvt5JaBSXUYmhESKVzOlrI5OuZJZWESbmjp+K
    zVl6pj003ODiLlS0a/Ssz80lCnsip46yPlRbsSIFjFp2xlJdBXuFHgH66q0ExUj4
    ZhVjCblX1Cseh8vWFtoV97B/0LlIkHCbnE8bX9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type
    :content-transfer-encoding; s=arctest; t=1522292967; bh=LfiTcqGT
    Dk7Tr4SMIoiB4UoXJyqfS7k8IlQdF/T/u34=; b=iceKA0JXf7IDmKmfCMqaEj8i
    e0o+BjCjCQJz/Mj40MR3wF3GQD4j8KXiWOG8C3Dg1qu7rGAWbas5wSluNeiM3nrj
    IuRvChV8HQQ/SN4VeATerd/OvL/nO0YUrDUxm0/C1pzH5IhdvW8ykDckROdkAv18
    DtzlGoTiBkTmIHPz2RihB5KpiQmRtZ3HuR5BKpDu1GmKjY3kyNzMC4Vq/2ReQ5m+
    qOSu6D4myVz3n5lq2Pfe7cY08Y3nL/HbFYfNfB9m1dsUwcy9meJp7h4xNhpIwcwQ
    iOJd7HVz6YM9IVDT0HvDoquXS3GViwx616m7/6d//qgl7BeS26FE0uH/oAXHHA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom=robh@kernel.org smtp.helo=mail.kernel.org;
    x-aligned-from=pass (Address match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom=robh@kernel.org smtp.helo=mail.kernel.org;
    x-aligned-from=pass (Address match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPQOjPAzHDinjxfykspuLdwo5IRA3Jj4e3HNqgD7tncIL/ZxPSPtnApe9adsHGHl5c139yBv/6+fP0kWWN6dagcpnXEUrgMNJoo+gcpbXKAImgDm0BU+
    Mn6NXDOp+BP64HiNqhzOBe91BV9dahU85Gv65pXK2QCx3hhio6xWx5mjyxMVxiwP5gokaw4NplAb1Q==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=czNdAM+YcK12vDHDihaDnQ==:117
    a=czNdAM+YcK12vDHDihaDnQ==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=l0hiEBf7AAAA:8 a=mW0iKoRZMumXdBN_uB8A:9
    a=C7lGKlN1g-roUles:21 a=O-MHX11_-Vaiw0du:21 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=ynCB8LqupOr-u-Kv-6Up:22
X-ME-CMScore: 0
X-ME-CMCategory: none
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA0A321836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh@kernel.org
X-Google-Smtp-Source: AIpwx48DEOhbiMIPM5Vrs1N5HYBMs2SthtWKzvTBC11kl4+4yQ59tV0RZAJFCmI+LTiu284C7ZS53T5zIGwWGFQf4v4=
MIME-Version: 1.0
In-Reply-To: <CAFaeLdQXQnE9XpAsgOPg=D_wAqEKe4dQhtKYrS1sDT5wgqSdVw@mail.gmail.com>
References: <1521537304-7531-1-git-send-email-leechu729@gmail.com>
 <1521537304-7531-3-git-send-email-leechu729@gmail.com> <20180326222336.jqix6k4pyqy4bg36@rob-hp-laptop>
 <CAFaeLdQXQnE9XpAsgOPg=D_wAqEKe4dQhtKYrS1sDT5wgqSdVw@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 28 Mar 2018 22:09:03 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJvitoh-+T0JQN=-GkZzTkT7J1_NcHTSx_x1_q48sTcHg@mail.gmail.com>
Message-ID: <CAL_JsqJvitoh-+T0JQN=-GkZzTkT7J1_NcHTSx_x1_q48sTcHg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] dt-bindings: usb: rt1711h device tree binding document
To: =?UTF-8?B?5p2O5pu45biG?= <leechu729@gmail.com>
Cc: Greg KH <greg@kroah.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Guenter Roeck <linux@roeck-us.net>, Mark Rutland <mark.rutland@arm.com>,
	=?UTF-8?B?c2h1ZmFuX2xlZSjmnY7mm7jluIYp?= <shufan_lee@richtek.com>,
	=?UTF-8?B?Y3lfaHVhbmco6buD5ZWf5Y6fKQ==?= <cy_huang@richtek.com>,
	Jun Li <jun.li@nxp.com>, Mats Karrman <mats.dev.list@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux USB List <linux-usb@vger.kernel.org>,
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 27, 2018 at 9:30 AM, =E6=9D=8E=E6=9B=B8=E5=B8=86 <leechu729@gma=
il.com> wrote:
> Hi Rob,
>
> 2018-03-27 6:23 GMT+08:00 Rob Herring <robh@kernel.org>:
>> On Tue, Mar 20, 2018 at 05:15:04PM +0800, ShuFan Lee wrote:
>>> From: ShuFan Lee <shufan_lee@richtek.com>
>>>
>>> Add device tree binding document for Richtek RT1711H Type-C chip driver
>>>
>>> Signed-off-by: ShuFan Lee <shufan_lee@richtek.com>
>>> ---
>>>  .../devicetree/bindings/usb/richtek,rt1711h.txt    | 30 ++++++++++++++=
++++++++
>>>  1 file changed, 30 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/usb/richtek,rt171=
1h.txt
>>>
>>>  changelogs between v2 & v3
>>>  - add dt-bindings for rt1711h typec driver
>>>
>>> diff --git a/Documentation/devicetree/bindings/usb/richtek,rt1711h.txt =
b/Documentation/devicetree/bindings/usb/richtek,rt1711h.txt
>>> new file mode 100644
>>> index 000000000000..7da4dac78ea7
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/usb/richtek,rt1711h.txt
>>> @@ -0,0 +1,30 @@
>>> +Richtek RT1711H TypeC PD Controller.
>>> +
>>> +Required properties:
>>> + - compatible : Must be "richtek,rt1711h".
>>> + - reg : Must be 0x4e, it's slave address of RT1711H.
>>> +
>>> +Recommended properties :
>>> + - interrupt-parent : the phandle for the interrupt controller that
>>> +   provides interrupts for this device.
>>> + - interrupts : <a b> where a is the interrupt number and b represents=
 an
>>> +   encoding of the sense and level information for the interrupt.
>>> +
>>> +Optional properties :
>>> + - rt,intr-gpios : IRQ GPIO pin that's connected to RT1711H interrupt.
>>> +   if interrupt-parent & interrupts are not defined, use this property=
 instead.
>>
>> Drop this. You should simply always have interrupts property.
> Does this also imply that we could always assume client->irq is ready
> for request?

No idea.

> Therefore, there's no need to check client->irq and get gpio through
> rt,intr-gpios.

Looked to me like the gpio is just converted to an irq and used for
nothing else in the driver. If that's the case, then there's no point
in it being a gpio.

Rob
