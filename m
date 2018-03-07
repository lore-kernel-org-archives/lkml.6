Return-Path: <phil@raspberrypi.org>
X-Google-Smtp-Source: AG47ELuf/c2me/vSRbH2wgDDAsCquWBGNo8gH3BCVbWRUPxwZKo0S+DpUqvsUggk7RSSA/ExiY2R
ARC-Seal: i=1; a=rsa-sha256; t=1520426394; cv=none;
        d=google.com; s=arc-20160816;
        b=Uw5xjSSIKG/z1J6OuTLjDI2zeYbHNorj28aJtjyIyAEShnXjYpe67DK61uPyXZUcuy
         4rerWcpDSCPqD9cmaXqXSRaskbzXLZn+oCRFW0I1h3Cw8/+BLjrfcpKw/VJFALtMUus+
         tlTI3IAfkk+5AQT0fEX08y2wWpXmhQEj23/bhChaRQIp91S4DYi6SzVfr+B6eWAGyq9M
         6JUimoilcFWmDs+Uf4zCaIsge3DpSZJ8co+aigq8PxstzCnyrCOiaWbJqrBAE+rY/DVl
         RSQImEZ/z6j3SdMSL+3ILcylRcIvYJPC5LX4A171Kl8aDiEAmghH61ayHoBY/0gIhsys
         /ecQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:dkim-signature:arc-authentication-results;
        bh=pPGuff5EE/pJQASjNfhYYZ0P65cZOtpNB9R3+lO+2pQ=;
        b=cBAcXWRXrSzwvRwlqnOmt/1y0C5CmYZFmmc6g1zB3DfdHhKZWabQXOuRcAYyP1Deae
         RMdI+Z6xxxqfJQGmXkrZpDqDt28WrNRnO1ZUNv6Cak9AldwbuxVSi4UNHHAmeirIWMWX
         YoMiIRacByHCMK8Nss51QvQ+7V9wpbmCBzQpfJ4QIKvHR3gXWeaYAoEJzM3iqX+4hOEV
         kYJlltQaFeE1H0lRF4N4e+uFVD9SLWJ4SM6IvoF3hsr1fFsE1S+bgaLMMiqXVETDQckL
         HFkTMU2DspTiF9QxhcfzrLzOLYzexFLIxr9nh67JE0k0KfkOtFkbSBnHX6r3DpjIW6Je
         LdsQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=fail header.i=@raspberrypi.org header.s=pp header.b=S92kxO66;
       dkim=pass header.i=@raspberrypi-org.20150623.gappssmtp.com header.s=20150623 header.b=xeGtZcff;
       spf=pass (google.com: domain of phil@raspberrypi.org designates 91.207.212.211 as permitted sender) smtp.mailfrom=phil@raspberrypi.org
Authentication-Results: mx.google.com;
       dkim=fail header.i=@raspberrypi.org header.s=pp header.b=S92kxO66;
       dkim=pass header.i=@raspberrypi-org.20150623.gappssmtp.com header.s=20150623 header.b=xeGtZcff;
       spf=pass (google.com: domain of phil@raspberrypi.org designates 91.207.212.211 as permitted sender) smtp.mailfrom=phil@raspberrypi.org
Subject: Re: [PATCH 2/5] staging: vc04_services: Remove cache-line-size
 property.
To: Stefan Wahren <stefan.wahren@i2se.com>, Rob Herring <robh+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>, Eric Anholt <eric@anholt.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org
Cc: linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20180305202806.21219-1-eric@anholt.net>
 <20180305202806.21219-3-eric@anholt.net>
 <a8f369f5-691c-c05f-4c7c-2eadcf4c48c8@i2se.com> <87muzl9ger.fsf@anholt.net>
 <638bd870-bb17-a0e1-d2aa-30a364b53279@raspberrypi.org>
 <1332781939.275857.1520424630939@email.1und1.de>
From: Phil Elwell <phil@raspberrypi.org>
Message-ID: <51dc71d7-e8f5-2785-ad13-a941bc9278ab@raspberrypi.org>
Date: Wed, 7 Mar 2018 12:39:56 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1332781939.275857.1520424630939@email.1und1.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-07_05:,,
 signatures=0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594130896333791997?=
X-GMAIL-MSGID: =?utf-8?q?1594282626925932342?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 07/03/2018 12:10, Stefan Wahren wrote:
> Hi Phil,

<snip>

>> It is the L2 cache line size that matters, but as long as you end up with
>> the numbers Stefan mentioned - 32 on BCM2835, 64 on BCM2836 and BCM2837 -
>> I'm not too bothered how you get there.
> 
> i think a kernel with bcm2835_defconfig on RPi 2 could be such a corncase.
> 
> Am i right that the firmware doesn't rely on the existence of "cache-line-size"?

Because of the way partial cache lines are handled it is more important that the
two sides agree than that the value is correct. As a result, the firmware treats
the absence of a "cache_line_size" DT parameter (that sets the "cache-line-size"
property) in the DTB as an indication that the kernel driver pre-dates the ability
to switch, and uses the old fixed value of 32 as a fallback. Otherwise it sets the
parameter and the internal value used by the VPU-side VCHIQ to the correct value.

There are a number of ways to fix this, the easiest of which is to assume that the kernel
driver will either read the property or be able to work out the correct value, so
the VPU should always use the correct value regardless of the success of applying
the parameter/changing the property.

> Btw it would be nice to get fixed the corruption on ARM64 [1].

This is almost certainly due to the logic described above.

> 
> Stefan
> 
> [1] - https://github.com/lategoodbye/rpi-zero/issues/23
> 
>>
>> Phil
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
