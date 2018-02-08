Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2276771-1518081470-2-17045890332955947880
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518081470; b=Bb6EZtg/SibL0nzLGbCTh6LJyNVVc+DmmncLoGzIQw5rBlI
    wCvSjmEnUdL3BkEro3itl8m12LtltWk+J6G/rPuPGbdmM6jxXcoDg4cZPwbSO2yl
    hxK4aGshaX+2Ew0RQTCwSYUXCqIj5Nmb6GCbJtP29dilIgAUqYEHhHh7AqDwHtqd
    RBKsIPAHHNrXoxccfUJ9HE5kR2MCDAfG3HgEB4XwKioYx4zD26WX/20JFeQ5ewna
    yTwNGNvU8fpZvg52ZGMBbLJMN7Kucd6Q7HySVEMQ18xl3kLX4vSrcVgEGgX6jafw
    jzNDWmBn45Zpi9VzkXumRYAD2Vx3jTrPIs/02JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1518081470; bh=hRDNZWE36p3nP884xBQ5mYOwASzzWcqS5sMvhE3S2RU=; b=v
    pnBjGrxBNJvQaHvXu0FhWUapxoVWGGs7RpfTZo1qj9CkcbIRpy/yZmcRsR/IVnJr
    w/IOHGw4M1SR8LFItNKTZ3Yl7ht1WF0lnsHwwvXwCTmg9d616A5MGdXL51XVB0Uw
    Pq4n4gNOrpevZDLH4osOlDuvO60MG2ItvRgpHkldoidjpEdyNlrU7YUUmeI+UGfH
    +z72nF+2zeRvidjm0HCe+3JzkuRJLyoe+jNU0L5okMgKWQC+j9Ko/7Z8tEZtf9Yg
    DGVL1cW6lqlRztxmsK1Vna1s1ENTq+EXcIL1YSOoPrDWd7wJm0b7vNBMxO91c1LJ
    dpVe1g99Ke4enxLqCXX/g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=VMcHrz8n x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=UFZf2jrx;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=VMcHrz8n x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=UFZf2jrx;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751094AbeBHJRa (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Feb 2018 04:17:30 -0500
Received: from mail-ot0-f196.google.com ([74.125.82.196]:41212 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751014AbeBHJR2 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 8 Feb 2018 04:17:28 -0500
X-Google-Smtp-Source: AH8x226omeW0S5InAF+Ibb7csy3ySVk/SjfEcwIo6H9A3j1gyK3VxE0EovP1F+vt3vFRoepaCVLWCg==
Subject: Re: [PATCH 3/5] USB: serial: f81232: enable remote wakeup via RX/RI
 pin
To: Johan Hovold <johan@kernel.org>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, peter_hong@fintek.com.tw,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
References: <1516607927-8887-1-git-send-email-hpeter+linux_kernel@gmail.com>
 <1516607927-8887-3-git-send-email-hpeter+linux_kernel@gmail.com>
 <20180130035747.GB3434@localhost>
 <e89b06fc-2daa-dae6-34d5-3eedb5b244b8@gmail.com>
 <20180204014606.GB28684@localhost>
From: "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Message-ID: <ed36abaa-2ee4-3fc2-6472-570691381377@gmail.com>
Date: Thu, 8 Feb 2018 17:17:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180204014606.GB28684@localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Johan,

Johan Hovold 於 2018/2/4 上午 09:46 寫道:
> On Thu, Feb 01, 2018 at 11:13:01AM +0800, Ji-Ze Hong (Peter Hong) wrote:
>> Our USB-To-Serial support RI/ RX remote wakeup by Modem, Fax or
>> other peripherals and we had tested it by following procedure with
>> device_set_wakeup_enable() enabled:
>>       1. Using pm-suspend to S3
>>       2. Trigger a pulse to RI/RX to wake up system.
>>
>> In our test, we can do remote wakeup only with
>> device_set_wakeup_enable() enabled.
> 
> Yeah, but you need to enable it though sysfs. Not every device should be
> able to wake the system up. That's a decision left for user space.
> 
>> Should we add device_set_wakeup_capable() & device_set_wakeup_enable()
>> like following link??
>> https://elixir.free-electrons.com/linux/latest/source/drivers/media/rc/mceusb.c#L1476
> 
> No, your driver should not call device_set_wakeup_enable() itself. Just
> set the wakeup capable flag in probe. And if you can disable the wake up
> feature, this needs to be done at suspend depending on what user space
> has requested.

We'll change to device_set_wakeup_capable() and send the v2 patch when
test OK.

Thanks
-- 
With Best Regards,
Peter Hong
