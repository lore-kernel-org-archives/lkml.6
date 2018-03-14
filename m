Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2697220-1521063070-2-2745988387253598648
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521063069; b=krY4ZPnJe0dm5T/qnaEDtzInz+YBvHEQ5xY6p39XZ7GXiUo
    jwrJ0iOE4hBoavlBv7fz76UPRQ9IhJ+8qt3ru25fFIx0tYzAZiprZsB7balhnLvH
    JBQh/J4DCd1AihdW2dcm1NnW4fDFAz9LpBgHrO8L2cI0lrImImvAkfyyhlarDKlH
    ybK5W9QVXRuUgp0j9TIyVjo+Pnaj1XPwNDWgCOuXyscvjMQRCd+L47WqN6ia+a1w
    Id3T2L0MRgTdRbD341dVdLU8Jr8xPA8/U/etNwpWqEFZNHCJjzFkgzP1wBsATFhu
    dqz1Qn+rgB9BdPZcbaHMbsjNVIH71b/SR07VmLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1521063069; bh=YqZSKr1xP1rvjWeYmhxuv0bNsUNC8vPoxT5XOV
    LxW0w=; b=MbwOSqY0K6CEsoHsn39Bk+dbdVkAdTPUNp5jvnAhbUzzIuj+nI1xb5
    5Q/FkA+vCf2rUO0tZ9Yg7pvgf6B0htiPCOr9yXkMrFq5TxBa8G91eG+2TXIUAkeY
    jvOjUNvqlYsN7zdPEYl8z5IYOmJC/7HMImbcgGDxf3E1/RAgdm22WmjLDFxsCPD5
    sRBThVvthox4/ZffS3+trNrXWjL+Kph9T6RJDLTINxW0NU1as3m2XPfYbKiXr/YE
    0X9dFzVJC9mhcO3HhR42tMMJnEMheFUxdILe4SzZyESxNBiz7A05UJzDxcM8076W
    ESgvk37P22m64vtjTf4Cr/TR49AkMu0g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=nYW6/4/h x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=nfBy+Kt8;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=nYW6/4/h x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=nfBy+Kt8;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751279AbeCNVbI (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Mar 2018 17:31:08 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:41587 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbeCNVbH (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 14 Mar 2018 17:31:07 -0400
X-Google-Smtp-Source: AG47ELunps9OcA3KFPvB+OeG1+jy/bETLa2qF+I9HLQq6gk39PBxnO5jWfvu9aNejhEmo/eGBW4RBEWFD0+lp/dr5Sw=
MIME-Version: 1.0
In-Reply-To: <1520897374.23626.82.camel@codethink.co.uk>
References: <20180310001807.213987241@linuxfoundation.org> <20180310001807.970379538@linuxfoundation.org>
 <1520897374.23626.82.camel@codethink.co.uk>
From: Adam Ford <aford173@gmail.com>
Date: Wed, 14 Mar 2018 16:31:05 -0500
Message-ID: <CAHCN7xL3N0RnmhnPRqgTNSiehwLcVm6OFLyFNvPPcqnuh5O5oA@mail.gmail.com>
Subject: Re: [PATCH 4.4 13/36] ARM: dts: LogicPD Torpedo: Fix I2C1 pinmux
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: Tony Lindgren <tony@atomide.com>, stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 12, 2018 at 6:29 PM, Ben Hutchings
<ben.hutchings@codethink.co.uk> wrote:
> On Fri, 2018-03-09 at 16:18 -0800, Greg Kroah-Hartman wrote:
>> 4.4-stable review patch.  If anyone has any objections, please let me know.
>>
>> ------------------
>>
>> From: Adam Ford <aford173@gmail.com>
>>
>> commit 74402055a2d3ec998a1ded599e86185a27d9bbf4 upstream.
>>
>> The pinmuxing was missing for I2C1 which was causing intermittent issues
>> with the PMIC which is connected to I2C1.  The bootloader did not quite
>> configure the I2C1 either, so when running at 2.6MHz, it was generating
>> errors at time.
>>
>> This correctly sets the I2C1 pinmuxing so it can operate at 2.6MHz
>>
>> Fixes: 687c27676151 ("ARM: dts: Add minimal support for LogicPD Torpedo
>> DM3730 devkit")
>>
>> Signed-off-by: Adam Ford <aford173@gmail.com>
>> Signed-off-by: Tony Lindgren <tony@atomide.com>
>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>
>> ---
>>  arch/arm/boot/dts/logicpd-torpedo-som.dtsi |    8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> --- a/arch/arm/boot/dts/logicpd-torpedo-som.dtsi
>> +++ b/arch/arm/boot/dts/logicpd-torpedo-som.dtsi
>> @@ -90,6 +90,8 @@
>>  };
>>
>>  &i2c1 {
>> +     pinctrl-names = "default";
>> +     pinctrl-0 = <&i2c1_pins>;
>>       clock-frequency = <2600000>;
>>
>>       twl: twl@48 {
>> @@ -146,6 +148,12 @@
>>                       OMAP3630_CORE2_IOPAD(0x25da, PIN_INPUT_PULLUP | MUX_MODE2)   /* etk_ctl.sdmmc3_cmd */
>>               >;
>>       };
>> +     i2c1_pins: pinmux_i2c1_pins {
>> +             pinctrl-single,pins = <
>> +                     OMAP3_CORE1_IOPAD(0x21ba, PIN_INPUT | MUX_MODE0)        /* i2c1_scl.i2c1_scl */
>> +                     OMAP3_CORE1_IOPAD(0x21bc, PIN_INPUT | MUX_MODE0)        /* i2c1_sda.i2c1_sda */
>> +             >;
>> +     };
>
> This is being added under &omap3_pmx_core2, but upstream it was added
> under &omap3_pmx_core.  Does that matter?

I would agree with you that it should be under the omap3_pmx_core

I have been trying to get time to run tests on this, but due to a hard
drive corruption, I haven't been able to do much for the past several
days.

Greg - If I find it doesn't doesn't work as-is, do you want me to
submit a patch to you directly, or go through alternative means?

adam
>
> Ben.
>
>>  };
>>
>>  #include "twl4030.dtsi"
>>
>>
>>
> --
> Ben Hutchings
> Software Developer, Codethink Ltd.
>
