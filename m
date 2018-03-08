Return-Path: <robh+dt@kernel.org>
X-Google-Smtp-Source: AG47ELsKzmSorFs5n956BtHgUP5nSfi6KOIhs/+pAwVFV30A/VKOtwnwzxUGvqkd6qRCiuFmeyr4
ARC-Seal: i=1; a=rsa-sha256; t=1520551453; cv=none;
        d=google.com; s=arc-20160816;
        b=UlK0bU4lom6SFKrdCZHaxb3QJ2ZID3VZbqpGZMsbgXV6h8bqHAmDoqVBPSLTsQ85eI
         lRcYs5kF2QPfCScmOKrQUTyLJKraGe2bXebLat8ErAlhDs+X0aJ8AxDPFH/ARJ48No3l
         jS5fE84sO6OyMtvtavovu/7pRAh+nR9P9f3EWu+E27pyJYBoqp0uFntYzsd8HOCn/xnd
         Yd/uoFf2Uu2yY7LWzVma8WEmVUcqrCmBC9a4Rzab1SZUnwL8YzaHjzkTi9T1s6SSArb/
         POZje4K5L+BsEXEOEMCz7xPxhr20EAmLY1ea91xeIQ009w+lwlx+7ZRXmw0FPwX157Xj
         r+UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dmarc-filter:arc-authentication-results;
        bh=Kt4GU+ahxM+migapMjB33FlylJEb2rnc3JJnyusbzPQ=;
        b=jyxEnWp1oLOaji2nv79BEXdAVXm+rrXFJUA52YVOs6AtrYBEPJ/LBz28+3cByExbxf
         UNxgB7aVrKXHrxmaHEct3C32k7dunGpn574+qqAo7+yOa0D/XzcbWlwMnZbg0qOaBgFR
         a58RW3QC++g2i8b4dKh4RBY36oQLU3aHqQhiIoKnEzSrqaNn+htUTREJiMlbvJx88Oyx
         326NAROcBi+ee3yiJfNQmtsJJNXVGusobnhCzAN7s5rZqNpsZfzp5sF+owMQzY74ejdM
         adrOE3zJbMv+4T6ylsOYGzrHqEsZC5RnWj1Cvay9UPgDaxWFPN0DhGMCEM6rN40GTBSB
         wgBw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of robh+dt@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=robh+dt@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of robh+dt@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=robh+dt@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EB4A2178B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh+dt@kernel.org
MIME-Version: 1.0
In-Reply-To: <87lgf2fhn2.fsf@anholt.net>
References: <20180307185716.17449-1-eric@anholt.net> <20180307185716.17449-3-eric@anholt.net>
 <CAL_Jsq+1-9-RGfzPimYwCokEZx1vef_PX5rkp-c8s6fUchg=ag@mail.gmail.com> <87lgf2fhn2.fsf@anholt.net>
From: Rob Herring <robh+dt@kernel.org>
Date: Thu, 8 Mar 2018 17:23:51 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJTsJfud6a445hu6ENVV6QyBF6f69opTwq1yp_X9oUPAQ@mail.gmail.com>
Message-ID: <CAL_JsqJTsJfud6a445hu6ENVV6QyBF6f69opTwq1yp_X9oUPAQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] dt-bindings: soc: Add a binding for the Broadcom
 VCHIQ services.
To: Eric Anholt <eric@anholt.net>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Mark Rutland <mark.rutland@arm.com>,
	devicetree@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Phil Elwell <phil@raspberrypi.org>,
	"moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Stefan Wahren <stefan.wahren@i2se.com>,
	bcm-kernel-feedback-list@broadcom.com
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594306376933935522?=
X-GMAIL-MSGID: =?utf-8?q?1594413761228417702?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 8, 2018 at 2:15 PM, Eric Anholt <eric@anholt.net> wrote:
> Rob Herring <robh+dt@kernel.org> writes:
>
>> On Wed, Mar 7, 2018 at 12:57 PM, Eric Anholt <eric@anholt.net> wrote:
>>> The VCHIQ communication channel can be provided by BCM283x and Capri
>>> SoCs, to communicate with the VPU-side OS services.
>>>
>>> Signed-off-by: Eric Anholt <eric@anholt.net>
>>> ---
>>>
>>> v2: dropped firmware property, added cache-line-size.
>>>
>>>  .../bindings/soc/bcm/brcm,bcm2835-vchiq.txt        | 28 ++++++++++++++++++++++
>>>  1 file changed, 28 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.txt b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.txt
>>> new file mode 100644
>>> index 000000000000..cdef4abc5e47
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.txt
>>> @@ -0,0 +1,28 @@
>>> +Broadcom VCHIQ firmware services
>>> +
>>> +Required properties:
>>> +
>>> +- compatible:  Should be "brcm,bcm2835-vchiq"
>>> +- reg:         Physical base address and length of the doorbell register pair
>>> +- interrupts:  The interrupt number
>>> +                 See bindings/interrupt-controller/brcm,bcm2835-armctrl-ic.txt
>>> +
>>> +Optional properties:
>>> +
>>> +- cache-line-size:
>>> +               Size of L2 cache lines.  The VPU firmware detects
>>> +                 this property and overrides it with the actual L2
>>> +                 cache line size it's using when loading the
>>> +                 device-tree.  Determines the required alignment of
>>> +                 offsets/sizes of VCHIQ pagelists.  If missing, the
>>> +                 firmware assumes an older kernel using 32-byte
>>> +                 alignment.
>>
>> How is this a VCHIQ property? This is a standard property for cache
>> nodes, but this is not a cache node.
>
> Because the existing firmware code is choosing a value based on the
> property's presence in this node.  This is the DT ABI for the firmware
> that's been shipping for a long time (at least since the 4.9 era).

It's not an ABI if it is not upstream and documented.

>> Is it really a problem to just use a fixed maximum alignment? That
>> seems to be good enough for all the rest of the kernel.
>
> If we can't have this DT property, then it looks like we need the
> upstream kernel to just use 32, since that's what the firmware will
> assume in its absence.  Maybe the firmware maintainers can give us a new
> arg to the mailbox call for setup where we could pass in the value to
> use (or flag for them to pass their preferred value back to us) so we
> can avoid DT.

I read thru the discussion on the previous version and skimmed thru
the code, but still don't really have a grasp on things. If the actual
cache line size is 64 bytes, but you use 32 things would be pretty
broken I'd think.

BTW, I'm pretty sure this line is not doing what you want:

static unsigned int g_cache_line_size = sizeof(CACHE_LINE_SIZE);

Rob
