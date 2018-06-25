Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F4CFC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 388CD25A8F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vhCQdPYX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 388CD25A8F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755528AbeFYNff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 09:35:35 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:44976 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752124AbeFYNfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 09:35:33 -0400
Received: by mail-pg0-f66.google.com with SMTP id b10-v6so2401058pgq.11;
        Mon, 25 Jun 2018 06:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lxgWpkcqfBJolW6ZojM7ufHRXQ+7Xu5sCZoIIWm9rvk=;
        b=vhCQdPYXiwDPr4Ud7Ol/S9f/h5uaONc85V+AYJiqPXrF7Aat2VNSFm09wfaNy+Su9U
         qSVt4PfAt5jqhTSskAtWPdAeEiUo148DqYfAZv+68biLQW/ZhecF/u53xZhWzvIS8i+S
         tlUSTrZa/oiu9kjhwt+s+IWg0iD5xgca3CjKEdAWwqOlSvVpIr4VC3iBW94oUejZg/mX
         EHbEuia1RdwzwqWs1kCTTpqlAIgEvmnljRa/cWFOtH+/K5HqleP9IJnBFHU/UOVk72mc
         4ahaAJEzvHgBn2pD3V9rRmELE/UTyrIwHOBcQFf8okQAoqUV8F3cir3JYSHQYfv8+oEw
         Gysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lxgWpkcqfBJolW6ZojM7ufHRXQ+7Xu5sCZoIIWm9rvk=;
        b=aT1XuAQC7dPwhowieA7GxVSFdGd59kXO89c1lvLFRh+mfJ613aa6y/NaalWQVec/F0
         6m/ywfgH/AqOn2kQHs7J/vjjL/W2hSABlG6phlXDYmswKNjdGzSRTeEtElaV0irVtmju
         vv0azmv1WzR0+pE8GzIsDZzHz45QcZjzRKZwSE5aeamidCglDFGEzY41sSj6kX+JSpoj
         RC8S3tEbvHu7fycDS9o5OBqXvxxJxiTF4/7P5rKR7PbQpZgPhGGeNPkTrE7/9wuyHnxp
         oRIwT77J2b7/A2+s/6hy/xYaJQsVyH1tMKA6YIjmO1bA87FSCSiBCPnUd7F8GQCrupoC
         TmcA==
X-Gm-Message-State: APt69E27S7kod/wxTeEl1tGo2v/Gts7PMZg0rlgaLOVUj6JiFMM6ewSP
        Y6hCDRX4Xpk4cA2K8vikgJ+Yyg==
X-Google-Smtp-Source: ADUXVKL4dL1+otudLLksHYtuOZSc251PtlPzX0KiNk8Lg7FVasopKC1VYpwCeAwklyieRo8W/Uvlug==
X-Received: by 2002:a65:6141:: with SMTP id o1-v6mr10572286pgv.409.1529933733278;
        Mon, 25 Jun 2018 06:35:33 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id 8-v6sm30827226pfk.132.2018.06.25.06.35.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 06:35:32 -0700 (PDT)
Subject: Re: s390 qemu boot failure in -next
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Cc:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        qemu-s390x <qemu-s390x@nongnu.org>,
        qemu-devel <qemu-devel@nongnu.org>,
        Thomas Huth <thuth@redhat.com>
References: <20180622194736.GA5794@roeck-us.net>
 <126ac556-0602-b927-58f5-cb5f65a5e0ec@de.ibm.com>
 <88d9afed-f91d-c320-13c8-9a93fc52b700@de.ibm.com>
 <20180625100548.64222dad.cohuck@redhat.com>
 <your-ad-here.call-01529915788-ext-6027@work.hours>
 <20180625104928.6c4cb239.cohuck@redhat.com>
 <76740f8f-ef4c-9d11-dae1-192beebff4d8@de.ibm.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <64bcba64-b88f-3594-da6e-7c2118482c20@roeck-us.net>
Date:   Mon, 25 Jun 2018 06:35:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <76740f8f-ef4c-9d11-dae1-192beebff4d8@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/25/2018 05:26 AM, Christian Borntraeger wrote:
> 
> 
> On 06/25/2018 10:49 AM, Cornelia Huck wrote:
>> On Mon, 25 Jun 2018 10:36:33 +0200
>> Vasily Gorbik <gor@linux.ibm.com> wrote:
>>
>>> This change has been done on purpose. Uncompressed image is not going
>>> to be bootable any more. In future the decompressor phase would get
>>> more function (early memory detection as an example) and there is no
>>> chance to duplicate that code in uncompressed image as well (to keep it
>>> bootable on its own). The patch series commit messages contain more
>>> technical details.
>>>
>>> For qemu either bzImage or arch/s390/boot/compressed/vmlinux should be
>>> used, which are bootable images.
>>>
>>> But that's really confusing that uncompressed vmlinux is still kind
>>> of booting. May be we should discuss how to avoid this confusion
>>> (may be change uncompressed image enty point to a function doing
>>> disabled wait with badb007 or smth) and how to encourage people to use
>>> arch/s390/boot/compressed/vmlinux instead.
>>
>> So, the intention is that you can't boot the uncompressed image
>> anywhere? (Was it possible before, e.g. when punching the image under
>> z/VM?)
> 
> The uncompressed image (the vmlinux file) was never bootable in LPAR or z/VM.
> It was just a "nice hack" that QEMU was able to do so. (even qemu on x86 can not
> boot the pure vmlinux file as far as I know).
> 

"even" is relative. vmlinux boots on some arm platforms, metag, mips64, nios2,
parisc, ppc/ppc64, and riscv.

If an image is not expected to be bootable, a message such as "This image does
not boot. Please use <correct image>" would be nice. Unfortunately, which image
to boot under qemu is pretty much undocumented, and it is guesswork for each
architecture/platform.

Guenter

> I talked to Vasily and the vmlinux file in the linux source path is just an
> intermediate file. Future changes will happen that will make that ELF file
> unsuitable for direct boot anyway (e.g. think about potential ASLR or Kasan
> changes).
> 
>   If yes, it would make sense to explicitly fence it. But I'm
>> worried that it would break previously working setups (did we document
>> the purpose of the images anywhere?
>>
> 
> 
> I think by referring to arch/s390/boot/compressed/vmlinux things are probably
> good enough. That will still load from 0x10000.
> 
> We might still "change" the way that we add the parameters (e.g.
> make that not depend on the load address), but looking forward this might
> become less important for the "intermediate vmlnux file".
> 
> 

