Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 698CAC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AC962476D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="h5osocoE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AC962476D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753397AbeGCWkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 18:40:49 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:45609 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753179AbeGCWkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 18:40:47 -0400
Received: by mail-io0-f193.google.com with SMTP id l25-v6so3157379ioh.12
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 15:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=T2PcvfEVznMAHR7V574/TrnKnFSBnfde/7dL6mqZVJk=;
        b=h5osocoE+zEP6XRcOLF7YtoH8HYNXIVPhXpdhOxp6p46O+iOwrRyc8EqIwM48q8rI7
         yMFHk9G8PJbmd+4SXOZWPCy8oJQxkKV0K5Dw6SNs7WeiA3RbrvV1cKbfy4YbFu5v3l61
         ZtKzIuGAxLGO4IOrjN0F8ruAs+kcCGD88jQqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=T2PcvfEVznMAHR7V574/TrnKnFSBnfde/7dL6mqZVJk=;
        b=bvHgYcFCHILB2+aFxV8ZPqTaVUsgicKTXPBOSb/yPsjevY9qmaPy6oQxVwmNOXaxjl
         19OCGjdWqxr2hYqzGYdWVZvMOTR900DvELnbeDWB1H4UBUibwrkDPpVCOuO8gZBeeacV
         NwggI/2hTgZaE+/YAcQvTBT5YSbGCw7RrVDWdPkqstkF/IThgyNpeJwH3+DbJojhz4mm
         5ofVtGUaP3QshBy8aiTXCzQFOt8e2RuMhGeiVAoxqsyHhrR5eVYw2tPzZk3kq8sLi/ZV
         7fDGqoaFrG8//7hZmgZ1kqxL7AUY70mWg2aZdkIQmcB8TZcMQpvnJLaJjZE893ptRR/I
         UbSQ==
X-Gm-Message-State: APt69E0GmjvrAQsz0m/T8YJOj5zAksRaemf3Omwr9gRsj0HER5rx9tO+
        qAHKjGkrh6dyVeA+jaWMbMiSOa3tOfMlSEdALSKE8w==
X-Google-Smtp-Source: AAOMgpekeaXTcgJ5DWXzfhf8Ngzio87mqUzYIV4xyDEsF0Qw+6fD+Z2mxDcYwY1LN0RKOZbpCXzwQt0/e1i70Rrq6rY=
X-Received: by 2002:a6b:5d1a:: with SMTP id r26-v6mr11795990iob.170.1530657647079;
 Tue, 03 Jul 2018 15:40:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bbc7:0:0:0:0:0 with HTTP; Tue, 3 Jul 2018 15:40:46 -0700 (PDT)
In-Reply-To: <20180703214604.GA15516@zn.tnic>
References: <1530624720-32004-1-git-send-email-brijesh.singh@amd.com>
 <CAKv+Gu8MZ1O2U=OiONCdaFQjNGVPjqASMP7ubKCg-9ULdk7Whw@mail.gmail.com>
 <20180703154418.GC4643@zn.tnic> <e17f101d-8509-17bc-f099-92cd7e817f49@amd.com>
 <20180703214604.GA15516@zn.tnic>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 4 Jul 2018 00:40:46 +0200
Message-ID: <CAKv+Gu-hWz4UUvvSyG5=RzCWmheva2-yUkSyuCM0_CDERCJihQ@mail.gmail.com>
Subject: Re: [PATCH] x86/efi: Access EFI MMIO data as unencrypted when SEV is active
To:     Borislav Petkov <bp@suse.de>
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        KVM devel mailing list <kvm@vger.kernel.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 July 2018 at 23:46, Borislav Petkov <bp@suse.de> wrote:
> On Tue, Jul 03, 2018 at 04:16:57PM -0500, Brijesh Singh wrote:
>> I agree with Ard,  it may be good idea to extend the UEFI spec to
>> include encryption information. Having this information may be helpful
>> in some cases, e.g if we ever need to map a specific non IO memory as
>> unencrypted. So far we have not seen the need for it. But I will ask AMD
>> folks working closely with UEFI committee to float this and submit it as
>> enhancement in Tianocore BZ.
>
> Except that if the IO memory handling unencrypted changes in future
> incarnations, the changes to the spec become moot. I'm just saying...
>

Quite the opposite. If we allocate a EFI_MEMORY_xx bit to signify that
a region should be mapped as encrypted, we no longer have to reason
about these things in the kernel but we can simply apply the
attributes that the UEFI memory map provides us. A platform could then
describe both encrypted and unencrypted MMIO regions at will.
