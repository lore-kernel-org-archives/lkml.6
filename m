Return-Path: <sudeep.holla@arm.com>
X-Google-Smtp-Source: AG47ELssdZ34th/MUC2+Cu4+JUrJt5S3TjQHwO86Y3+TOxmgGntLn8nrnYl8WmnVA0GQXZtquHpt
ARC-Seal: i=1; a=rsa-sha256; t=1520511547; cv=none;
        d=google.com; s=arc-20160816;
        b=G/4CS4iO96znfRqcox1ptVPoMOSQfWchEsGPmjgAKRuluEmYQ7TJcYzXQ89nd2RqrM
         FnSSHgH7q0QruT+LnV0/j3fzdwNeCD6EYHBUxiyRAIJStNv+iRkB8RanY+xHk5DMYsPa
         LrWo55Ru0zqEKBTcqe1g7AkboPDUg+FN61lnYqDF/jF9TMVM32lwOrUPnHjyGNuzqDkI
         Y7car5HbnFMOuYgbUfXclzqApXlpfm0UtMoR0R63PEbB3ee85Y1YJLJBkuIniuLYVm6u
         0c9A76xLT2wKYHGPemoZELTexOXPNet6KespcMBOveHr3nf16H+IAI2d/dSyUAq9I0i6
         p9ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:to:subject
         :cc:arc-authentication-results;
        bh=b0/XVmZExlqJwgvL4HDa6ig4VN6G2SccwrgyVTwEd84=;
        b=lNfdkn0LKi9ogAAS0wZwtmz3buUb9lbxfZy6AcuKndQdcXit6FQV3Jsr/HABmY3rs1
         aYsXc8L5XSGhaKK0uiFNVaEe0FUgInffmwpIY+DcVX5P1k1Ix5dpvK24YRJTlm8CmRFR
         V/9q0h1Boa3fk+w4+b52G/yVRlKSyJXw3UqLlvl6b0SHVgsmnNnogp/DWDnK673wWZJx
         M/gktVOIKrooZSyZfaq49csjjkwHAJUgQdku+FBTc2gSm7MKATze8XFlVq72lr3Zz1TE
         e6UxPnpZVIMiHasZFt9B1TW/70UYsShY4r72ctSRFgg14lTj8NnnQaLNi2OYXGrsWJ8Z
         DF/Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Cc: Sudeep Holla <sudeep.holla@arm.com>,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>,
 bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH v2 3/6] dt-bindings: soc: Add a binding for the Broadcom
 VCHIQ services.
To: Eric Anholt <eric@anholt.net>, Florian Fainelli <f.fainelli@gmail.com>,
 Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>,
 devicetree@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Phil Elwell <phil@raspberrypi.org>
References: <20180307185716.17449-1-eric@anholt.net>
 <20180307185716.17449-3-eric@anholt.net>
From: Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <616b5c0c-ca31-c041-ba5a-f73febf62fe6@arm.com>
Date: Thu, 8 Mar 2018 12:18:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180307185716.17449-3-eric@anholt.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594306376933935522?=
X-GMAIL-MSGID: =?utf-8?q?1594371916826835366?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 07/03/18 18:57, Eric Anholt wrote:
> The VCHIQ communication channel can be provided by BCM283x and Capri
> SoCs, to communicate with the VPU-side OS services.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
> 
> v2: dropped firmware property, added cache-line-size.
> 
>  .../bindings/soc/bcm/brcm,bcm2835-vchiq.txt        | 28 ++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.txt
> 
> diff --git a/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.txt b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.txt
> new file mode 100644
> index 000000000000..cdef4abc5e47
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.txt
> @@ -0,0 +1,28 @@
> +Broadcom VCHIQ firmware services
> +
> +Required properties:
> +
> +- compatible:	Should be "brcm,bcm2835-vchiq"
> +- reg:		Physical base address and length of the doorbell register pair
> +- interrupts:	The interrupt number
> +		  See bindings/interrupt-controller/brcm,bcm2835-armctrl-ic.txt
> +
> +Optional properties:
> +
> +- cache-line-size:
> +		Size of L2 cache lines.  The VPU firmware detects


Which L2 cache is this ? VPU or CPUs ?
If CPUs, just drop it and get it from CPU nodes if you need it.

If VPUs, it's better add that to the name as CPUs use "cache-line-size"
At-least for me, it looked like you are specifying CPU L2 cache line
size and hence thought to comment.

-- 
Regards,
Sudeep
