Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B66C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD5AD20B6F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qg6h5qJb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD5AD20B6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732395AbeGKK1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 06:27:42 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:33657 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbeGKK1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 06:27:42 -0400
Received: by mail-io0-f196.google.com with SMTP id z20-v6so23127898iol.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 03:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2Ius3EBXnxI5jot9k/eVpwo9eA/uRnhnnVMoplFK+h4=;
        b=Qg6h5qJbfnqXcoAFWuXtXi1s0hBlVHI7Biayhz9OQeFIth1imjxJaJPIdt8qOafHut
         bPoT6ay99B0Ma4ADQV82zwd5wFCOFqenpdCoQKUPTq8cZ5t4STv8cOs+barsiMwpg19T
         oQBlfqRMPB1FZ0zqp5d47SryaeAb3aMz3vyd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2Ius3EBXnxI5jot9k/eVpwo9eA/uRnhnnVMoplFK+h4=;
        b=l0CcnT6LNurhtyyKW/6GygrIhl2molaSa7kt9ScgcSTLWcOpQFLezfdcQsp8YCUdEK
         8RwKUy6zG8NfYbPAJ8zW7chlJ8/6dMy1XAhrvmexQVynq7pG1KNt00435j9cP/0ZJ1At
         9oHdYnF5d9R5HcQTH3OlDpDZ7xGa4PrvchiVoEJKOEKhkbYrRKYSASkX+y+feYQlVWDI
         BWUOkQbo0QgNOESy9xlLOt5ARH6CfMgJ9n+OoJZc338DvnTrQhtvCVtD4vainwpdP9+s
         tO5Mow4PpH56G8iDLKBFvSzHBFBb7hlmwsv/FbZNUsEJnVQwDMltXy7QqkF2XBYdCGiy
         ea6w==
X-Gm-Message-State: AOUpUlFbj2rSg2WvTYKOPHL1n6vxt35WCmIjuePqo2l5TUOYV++SlUO2
        /b0kKyaWnwdoEb/cYvYqeOfLLBJvbeXWy8O57bu90wli
X-Google-Smtp-Source: AAOMgpdOAU3vQVprewH2YoAwiSi+EpCuOGeSaInXRwz/o+hfiMshphw6PXVslhmie3CnAUf3a/yNT0sqKRXzC0N+8D8=
X-Received: by 2002:a6b:be83:: with SMTP id o125-v6mr23614443iof.173.1531304644210;
 Wed, 11 Jul 2018 03:24:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bbc7:0:0:0:0:0 with HTTP; Wed, 11 Jul 2018 03:24:03
 -0700 (PDT)
In-Reply-To: <20180711101303.GA8574@gmail.com>
References: <20180711090235.9327-1-ard.biesheuvel@linaro.org> <20180711101303.GA8574@gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 11 Jul 2018 12:24:03 +0200
Message-ID: <CAKv+Gu8m4UgL0GyYDuu5z+dzEF=N--H4PkqoO_xqwyW2_A+RMA@mail.gmail.com>
Subject: Re: [GIT PULL 0/1] EFI mixed mode fix for v4.18
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Wilfried Klaebe <linux-kernel@lebenslange-mailadresse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 July 2018 at 12:13, Ingo Molnar <mingo@kernel.org> wrote:
>
> * Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
>> The following changes since commit 1e4b044d22517cae7047c99038abb444423243ca:
>>
>>   Linux 4.18-rc4 (2018-07-08 16:34:02 -0700)
>>
>> are available in the Git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent
>>
>> for you to fetch changes up to d7f2e972e702d329fe11d6956df99dfc31211c25:
>>
>>   efi/x86: remove pointless call to PciIo->Attributes() (2018-07-11 10:52:46 +0200)
>>
>> ----------------------------------------------------------------
>> A single fix for the x86 PCI I/O protocol handling code that got
>> broken for mixed mode (64-bit Linux/x86 on 32-bit UEFI) after a
>> fix was applied in -rc2 to fix it for ordinary 64-bit Linux/x86.
>
> Just curious, because it's unclear from the changelog, what was the symptom, a
> boot hang, instant reboot, or some other misbehavior?

Hans reported that his mixed mode tablet would not boot at all any
more, but enter a reboot loop without any logs printed by the kernel.

> Also, what's the scope of
> the fix: were all 64-bit on 32-bit UEFI mixed-mode bootups affected, or only a
> certain subset?
>

Any mixed mode system with PCI is likely to be affected. I have added
a QEMU mixed mode config to my boot test environment to catch errors
like this one.

The unfortunate thing here is that this uncovered a fundamental issue
with mixed mode, i.e., that any UEFI protocol prototype involving
64-bit by-value parameters needs to be special cased in the stub code,
which is rather tedious. There is one other call that is potentially
affected, a file open call in the initrd handling code, but that
specific occurrence happens to work unmodified. This patch removes the
other one. Going forward, we will have to carefully review UEFI
protocol invocations for mixed mode compatibility.
