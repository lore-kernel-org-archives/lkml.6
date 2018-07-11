Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F36C7C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA49B20B6F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:23:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA49B20B6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732359AbeGKK1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 06:27:13 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33827 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbeGKK1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 06:27:12 -0400
Received: by mail-ed1-f66.google.com with SMTP id d3-v6so18841982edi.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 03:23:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0J2M2J+Ego8ut9eI+mocF4GFnm7KcNEYsdnUuQ0Gaws=;
        b=drDTS3pe9KaklPDiHBUwpQIrxBG1pK/KqcKG36wVhjOdHIAQiWBYq6/SzvR9uUtZVR
         uharGsKlDSMYWHR8DTfw/P/1BfZsnlYIklTIV/tgU7Njv3r94LrJvTX7X6KwTDSFcGdX
         w9CgDdttq64ZJMUMrXsZl3p7kOPIvudHpJ6mp1KbGAuTK5Xc6TsHOwR5sFFYiIuyoZof
         pbfaRqulRVNlA8RRsmLMBriSZODRrMiMAQuYNCXr1cJh53zK/ca04mAsFxP2dmrCjGZv
         DYQ/5PX91ZsUkFRZKVku2M+Pld96HzWxyOKcX00/Yc4uuRJGjKTLEiFWQZdoCIUQ5U1/
         7eBw==
X-Gm-Message-State: APt69E07YaYs1oPpbXfwu0+yGYsxoLHaFBAmXbrLBorjdYFSS+lWWjL5
        qgCVYLEv0IIeX8La51t+c41gAg==
X-Google-Smtp-Source: AAOMgpeSRGXc5xu4WlrxhkRtqJWWjVb3o0CVMehuY8x6e9fXAmcreHf+QqXeeu7GQAmMMCInoVwBaw==
X-Received: by 2002:a50:af45:: with SMTP id g63-v6mr31719305edd.30.1531304614373;
        Wed, 11 Jul 2018 03:23:34 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id q2-v6sm11564729edl.42.2018.07.11.03.23.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 03:23:33 -0700 (PDT)
Subject: Re: [GIT PULL 0/1] EFI mixed mode fix for v4.18
To:     Ingo Molnar <mingo@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-efi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Wilfried Klaebe <linux-kernel@lebenslange-mailadresse.de>
References: <20180711090235.9327-1-ard.biesheuvel@linaro.org>
 <20180711101303.GA8574@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <d857fa53-6c9b-3ebc-25f1-890255b90264@redhat.com>
Date:   Wed, 11 Jul 2018 12:23:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180711101303.GA8574@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11-07-18 12:13, Ingo Molnar wrote:
> 
> * Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> 
>> The following changes since commit 1e4b044d22517cae7047c99038abb444423243ca:
>>
>>    Linux 4.18-rc4 (2018-07-08 16:34:02 -0700)
>>
>> are available in the Git repository at:
>>
>>    git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent
>>
>> for you to fetch changes up to d7f2e972e702d329fe11d6956df99dfc31211c25:
>>
>>    efi/x86: remove pointless call to PciIo->Attributes() (2018-07-11 10:52:46 +0200)
>>
>> ----------------------------------------------------------------
>> A single fix for the x86 PCI I/O protocol handling code that got
>> broken for mixed mode (64-bit Linux/x86 on 32-bit UEFI) after a
>> fix was applied in -rc2 to fix it for ordinary 64-bit Linux/x86.
> 
> Just curious, because it's unclear from the changelog, what was the symptom, a
> boot hang, instant reboot, or some other misbehavior? Also, what's the scope of
> the fix: were all 64-bit on 32-bit UEFI mixed-mode bootups affected, or only a
> certain subset?

The problem was a reboot (resulting in a boot loop). I may have tested this
on multiple Bay Trail based devices, I don't remember but it was an issue on
Bay Trail devices, which typically use a 32 bit UEFI even though they have a
64 bit capable CPU. There are some rare Bay Trail devices with a 64 bit UEFI
but they are the exception.

Regards,

Hans
