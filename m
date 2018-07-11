Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE2EC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A1DC20B6F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBvWSiTQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A1DC20B6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbeGKKaI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 06:30:08 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53144 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbeGKKaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 06:30:07 -0400
Received: by mail-wm0-f65.google.com with SMTP id w16-v6so1902741wmc.2;
        Wed, 11 Jul 2018 03:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MT/qNtDc+ap+ovYb2pkL5vPiGIOY7MWZSV048PsyGcY=;
        b=cBvWSiTQ601ABslqKAHKFPN5Qhes0HrkUGvPhrLczeCSlTUlTqGNZlXibyp/lO3KVL
         uAMpFgJoH7YHBsSvDPg8lZZEtSfIQAF+AjczsjWpCE65zuOA+2mC6y9TrF301CgTbTxE
         1SA2g5HaGpsyEyB8Q4LAr/s+vT93krfEdfRpoI/HfNN7hcvrdubgxFTzfs/w/noMW7W0
         P3vt4rjLnR8lijGfQroYnKStBLlFrlVA4lJQW1HCIRI9ygWDBSbsToe0EPUOtyIEKBCu
         k38FyCWlkoaUNnxdApstXIZ9qI/gCb+rsM5S3G5rxbWT4UlwHztK9bRZ3gJ+0/qB0d6D
         LJFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=MT/qNtDc+ap+ovYb2pkL5vPiGIOY7MWZSV048PsyGcY=;
        b=gJRpMsDHLGvJhtuz4zFeLJq95fGUgeRIqJdah6+2PU4WKGQW7OsbvyiDJx+HzUVVDg
         6xUODBKJXD59aqhyEF15zkVai4FIH7Ei44QmJpYUaSgS2q6prVk1VJXCm4NnZhiX08cG
         Ebzw6pI5Q0zwIYACd1i2y3FWKfRiXZ96AzDubUx6CeFOeugEo+iu862rxRnjMZvVsTQJ
         n0HkifbFZBaHsQOwoJEhoNeNJXRaPEFQNru+stYBiS780js8lkEt4ltr+I3jDmxxU8NM
         S4S5QMfuBWaMqvOu5+a+8m59fxIeGt/WEZmQSFMk1D8BrOXha/iJyKY3b4aAlSxG3ua7
         Q7tA==
X-Gm-Message-State: APt69E1a8bDKuwMlSVcGg6KEu0yUzdON1ZBawqURrzbroxnLOnlNpkir
        yZJOkcfz4I43+ryvSkvqm0Gp13Ys
X-Google-Smtp-Source: AAOMgpeJGaPWRqVdLoe7Te9Fg5ZhYs0/V6BsSkE35Lgon617jBAqpz7prj4zImFywaxkyjTRcjDoNQ==
X-Received: by 2002:a1c:2142:: with SMTP id h63-v6mr6088271wmh.51.1531304787653;
        Wed, 11 Jul 2018 03:26:27 -0700 (PDT)
Received: from [192.168.10.165] (dynamic-adsl-78-12-151-35.clienti.tiscali.it. [78.12.151.35])
        by smtp.googlemail.com with ESMTPSA id h1-v6sm26029631wri.90.2018.07.11.03.26.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 03:26:26 -0700 (PDT)
Subject: Re: [PATCH v2 00/12] KVM/X86: Introduce a new guest mapping interface
To:     "Raslan, KarimAllah" <karahmed@amazon.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "david@redhat.com" <david@redhat.com>
References: <1523829198-13236-1-git-send-email-karahmed@amazon.de>
 <b390f953-6fe3-1119-15eb-e3b31e609305@redhat.com>
 <1531224393.10099.37.camel@amazon.de>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
Message-ID: <15b8718d-f209-1a3c-349e-497ae5f0d191@redhat.com>
Date:   Wed, 11 Jul 2018 12:26:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1531224393.10099.37.camel@amazon.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/07/2018 14:06, Raslan, KarimAllah wrote:
> On Mon, 2018-04-16 at 13:10 +0200, Paolo Bonzini wrote:
>> On 15/04/2018 23:53, KarimAllah Ahmed wrote:
>>>
>>> Guest memory can either be directly managed by the kernel (i.e. have a "struct
>>> page") or they can simply live outside kernel control (i.e. do not have a
>>> "struct page"). KVM mostly support these two modes, except in a few places
>>> where the code seems to assume that guest memory must have a "struct page".
>>>
>>> This patchset introduces a new mapping interface to map guest memory into host
>>> kernel memory which also supports PFN-based memory (i.e. memory without 'struct
>>> page'). It also converts all offending code to this interface or simply
>>> read/write directly from guest memory.
>>>
>>> As far as I can see all offending code is now fixed except the APIC-access page
>>> which I will handle in a seperate patch.
>>
>> I assume the caching will also be a separate patch.
>>
>> It looks good except that I'd squash patches 4 and 9 together.  But I'd
>> like a second set of eyes to look at it.
> 
> BTW, Why did you want to squash these 2 patches specifically? They are 
> very unrelated to me. The only common thing is that they switch from 
> code that supports only "struct page" to code that supports PFN only
> but this is also common for all other patches.

Probably at the time I was thinking they both affect cmpxchg, but really
they are gpte and emulator respectively.  Looks like I have 12 more
patches on my review queue then! *ouch*

Paolo

>>
>> Thanks,
>>
>> Paolo
>>
> Amazon Development Center Germany GmbH
> Berlin - Dresden - Aachen
> main office: Krausenstr. 38, 10117 Berlin
> Geschaeftsfuehrer: Dr. Ralf Herbrich, Christian Schlaeger
> Ust-ID: DE289237879
> Eingetragen am Amtsgericht Charlottenburg HRB 149173 B
> 

