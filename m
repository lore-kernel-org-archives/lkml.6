Return-Path: <phil@raspberrypi.org>
X-Google-Smtp-Source: AIpwx4/Jl7nI78p8U7opVL6rmgsHR9CZEAki3cIzEHC2MTswkItTHgBCBFs9MRX65BDNOAFk1Xn4
ARC-Seal: i=1; a=rsa-sha256; t=1523964954; cv=none;
        d=google.com; s=arc-20160816;
        b=bcojdlKHdo94WmYdb6Mvckc89wEnG0sj/6sZtG9mrFakoLEQQ8ds/0IK7O2xWKaGH9
         iyuI17BUng5rMMYSO//QGYV0TcRFUe3Ql1LXUq+kVpAczy04nAD+4pERMMeunps7L1ru
         arPdMP/ngIn1ekGN5sBSTidcjDFe4heJXvD/mzHBCrDHAiW/tek6cjH6rEhpWIJaSJE3
         7S9PtR0jMeCeHUQM9RulqQZGrEdAyGI0ZntJTOftCpecDx8flWD1u0448yGbAHAEOav0
         r+k+L2rBS2i5oa0tR6d/fGvYheP29uUWlEGZLYMZfcYVFvcIsTvSFY4dS61wzGPE5Fkr
         9L7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:subject:from
         :dkim-signature:dkim-signature:arc-authentication-results;
        bh=/umCLEjDSQJQD5pBQeEv4U8DDfO3MAp9zXiTaNTKwJM=;
        b=GAhVHKHL0Wg/JJsrZGLwMakTWFVHr8Ers42MbvTLXngokduL8F3VQPZfISyH4DgBsk
         ESyIFrQm7pQnHEW/VY86K0CTq6FhzEpIbfloPhUg6GBtSH1GD5h0664caZw2K5ji8QyS
         8Daw++ygxdBzHtEgD5npXMqnqqwvJZjczGgP3bdM9pWLPu5/1+q0pHx+G+GfO4ZAtBby
         HGiZVr6uCVShpX1ipbBcUKw31PjzIzYdX+J1vUEqddZGdc8HjK6P1YJce/kAwLBQSoNI
         Sx/QoH1QxpQiMeo1SfauFQTpDs5L+yhD7nIdedCigpwrFl0IAxt8HHekVdem7YEaMHWI
         d5fg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=fail header.i=@raspberrypi.org header.s=pp header.b=OqCKIQys;
       dkim=pass header.i=@raspberrypi-org.20150623.gappssmtp.com header.s=20150623 header.b=QtmaIl1S;
       spf=pass (google.com: domain of phil@raspberrypi.org designates 62.209.51.214 as permitted sender) smtp.mailfrom=phil@raspberrypi.org
Authentication-Results: mx.google.com;
       dkim=fail header.i=@raspberrypi.org header.s=pp header.b=OqCKIQys;
       dkim=pass header.i=@raspberrypi-org.20150623.gappssmtp.com header.s=20150623 header.b=QtmaIl1S;
       spf=pass (google.com: domain of phil@raspberrypi.org designates 62.209.51.214 as permitted sender) smtp.mailfrom=phil@raspberrypi.org
From: Phil Elwell <phil@raspberrypi.org>
Subject: Re: [PATCH 4/4] dt-bindings: Document the DT bindings for lan78xx
To: Rob Herring <robh@kernel.org>
Cc: Woojung Huh <woojung.huh@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "David S. Miller"
 <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <1523541336-145953-1-git-send-email-phil@raspberrypi.org>
 <1523541336-145953-5-git-send-email-phil@raspberrypi.org>
 <20180416192226.p5pg3yvixdulobt4@rob-hp-laptop>
Message-ID: <438cb08b-afd9-5d40-fdc4-eccff29b9e73@raspberrypi.org>
Date: Tue, 17 Apr 2018 12:35:50 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180416192226.p5pg3yvixdulobt4@rob-hp-laptop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-17_06:,,
 signatures=0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597548898658681732?=
X-GMAIL-MSGID: =?utf-8?q?1597993075860794918?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 16/04/2018 20:22, Rob Herring wrote:
> On Thu, Apr 12, 2018 at 02:55:36PM +0100, Phil Elwell wrote:
>> The Microchip LAN78XX family of devices are Ethernet controllers with
>> a USB interface. Despite being discoverable devices it can be useful to
>> be able to configure them from Device Tree, particularly in low-cost
>> applications without an EEPROM or programmed OTP.
>>
>> Document the supported properties in a bindings file, adding it to
>> MAINTAINERS at the same time.
>>
>> Signed-off-by: Phil Elwell <phil@raspberrypi.org>
>> ---
>>  .../devicetree/bindings/net/microchip,lan78xx.txt  | 44 ++++++++++++++++++++++
>>  MAINTAINERS                                        |  1 +
>>  2 files changed, 45 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/net/microchip,lan78xx.txt
>>
>> diff --git a/Documentation/devicetree/bindings/net/microchip,lan78xx.txt b/Documentation/devicetree/bindings/net/microchip,lan78xx.txt
>> new file mode 100644
>> index 0000000..e7d7850
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/net/microchip,lan78xx.txt
>> @@ -0,0 +1,44 @@
>> +Microchip LAN78xx Gigabit Ethernet controller
>> +
>> +The LAN78XX devices are usually configured by programming their OTP or with
>> +an external EEPROM, but some platforms (e.g. Raspberry Pi 3 B+) have neither.
>> +
>> +Please refer to ethernet.txt for a description of common Ethernet bindings.
>> +
>> +Optional properties:
>> +- microchip,eee-enabled: if present, enable Energy Efficient Ethernet support;
> 
> I see we have some flags for broken EEE, but nothing already defined to 
> enable EEE. Seems like this should either be a user option (therefore 
> not in DT) or we should use the broken EEE properties if this is h/w 
> dependent.

In the downstream Raspberry Pi kernel we use DT as a way of passing user settings
to drivers - it's more powerful than the command line. I understand that this is
not the done thing here so I'm withdrawing this element of the patch series.

Apologies for the noise.

>> +- microchip,led-modes: a two-element vector, with each element configuring
>> +  the operating mode of an LED. The values supported by the device are;
>> +  0: Link/Activity
>> +  1: Link1000/Activity
>> +  2: Link100/Activity
>> +  3: Link10/Activity
>> +  4: Link100/1000/Activity
>> +  5: Link10/1000/Activity
>> +  6: Link10/100/Activity
>> +  7: RESERVED
>> +  8: Duplex/Collision
>> +  9: Collision
>> +  10: Activity
>> +  11: RESERVED
>> +  12: Auto-negotiation Fault
>> +  13: RESERVED
>> +  14: Off
>> +  15: On
>> +- microchip,tx-lpi-timer: the delay (in microseconds) between the TX fifo
>> +  becoming empty and invoking Low Power Idles (default 600).
> 
> Needs a unit suffix as defined in property-units.txt.
> 
>> +
>> +Example:
>> +
>> +	/* Standard configuration for a Raspberry Pi 3 B+ */
>> +	ethernet: usbether@1 {
>> +		compatible = "usb424,7800";
>> +		reg = <1>;
>> +		microchip,eee-enabled;
>> +		microchip,tx-lpi-timer = <600>;
>> +		/*
>> +		 * led0 = 1:link1000/activity
>> +		 * led1 = 6:link10/100/activity
>> +		 */
>> +		microchip,led-modes = <1 6>;
>> +	};
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 2328eed..b637aad 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -14482,6 +14482,7 @@ M:	Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
>>  L:	netdev@vger.kernel.org
>>  S:	Maintained
>>  F:	drivers/net/usb/lan78xx.*
>> +F:	Documentation/devicetree/bindings/net/microchip,lan78xx.txt
>>  
>>  USB MASS STORAGE DRIVER
>>  M:	Alan Stern <stern@rowland.harvard.edu>
>> -- 
>> 2.7.4
>>
