Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2820880-1519905254-2-8607878122815461777
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519905253; b=kJtBzwaOy4X92BW4OZzZ61j6qtd6sQLc7SWZYD1V0Cik7F+
    92yD7r5gKbzX6k2L1zZ76vSXAysTFeLfKdiDeBRmtDeqMJ6sgahBmNjdIbG3w/dM
    MSL7if1fpTsP8u1iVMrrybxT3n1qcadjjjKs/h/BFZof18evPAjkOoVrKlvvL8Pa
    H2iTLK/IgAcSnLbgmqx4WErHe0d5HbxVgV4wP7h8pt0rPVLeK8DHj+hvenKdY7c5
    nP3U76UY/muEb4op+zNb8/4OXbM86R6PXQX/KBrgtuV0/fRhcNYdCZpOu+n1500L
    QtQMJNGp/DX71MBYHCmjkJLv4dECl5L3URJP9uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519905253; bh=hiC6eveHiHLlo+ezQv/FCd8cz/Jh0vTHeV/+Egfkl0A=; b=e
    2+FvGU7GDTyyfyDgSl3YyMcH3NrwLhdtSLnXzDGVqehwg6e3hAQ0RaB/bbID0ZHw
    6n/pNjhw1lcUQ9rd3WdDj2PGYYVBih7LTxD42hj4BaBSIS6fcggs7pOx/8W0OtQu
    K/Vot+TAL3mPLboBsBBVSBEUig/UiyG7qnPPLdRo9hv4JTXpjxYTQ7oSIAFQ7m8L
    3rCensfameX/tkdcZwBrD7sMyt7XViugxo0hp4MdmXvcIgLUVPAQxOKVS27jxp7p
    HequEp3qBB7zEUdwKYRxtbeyfo212xnAs3OpmENG4CGuZWs+SmCGfBkchpUK21Wn
    fcsqMmqtexW7uauK5AUfg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=GOKVr3Dj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=amkFnKSr;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=GOKVr3Dj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=amkFnKSr;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967808AbeCALyL (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 06:54:11 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:41523 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967795AbeCALyK (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Mar 2018 06:54:10 -0500
X-Google-Smtp-Source: AG47ELuvbaxGu6esKFP1+jhcRZ3LuwW9brU8phkr5WjfIl9J1cpQ4SFQvf3Qu/lpnVsPELR2r8Sgpg==
Subject: Re: [PATCH 01/29] arm64: mm: Use non-global mappings for kernel space
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
 <1519790211-16582-2-git-send-email-alex.shi@linaro.org>
 <20180228120828.GB8453@kroah.com>
From: Alex Shi <alex.shi@linaro.org>
Message-ID: <92d7d0b8-7483-74d7-efe5-29249093d1ad@linaro.org>
Date: Thu, 1 Mar 2018 19:53:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180228120828.GB8453@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 02/28/2018 08:08 PM, Greg KH wrote:
> On Wed, Feb 28, 2018 at 11:56:23AM +0800, Alex Shi wrote:
>> From: Will Deacon <will.deacon@arm.com>
>>
>> commit e046eb0c9bf2 upstream.
>>
>> In preparation for unmapping the kernel whilst running in userspace,
>> make the kernel mappings non-global so we can avoid expensive TLB
>> invalidation on kernel exit to userspace.
>>
>> Reviewed-by: Mark Rutland <mark.rutland@arm.com>
>> Tested-by: Laura Abbott <labbott@redhat.com>
>> Tested-by: Shanker Donthineni <shankerd@codeaurora.org>
>> Signed-off-by: Will Deacon <will.deacon@arm.com>
>> Signed-off-by: Alex Shi <alex.shi@linaro.org>
>>
>> Conflicts:
>> 	skip PTE_RDONLY of PAGE_NONE in arch/arm64/include/asm/pgtable-prot.h
> 
> These "Conflicts:" lines need to be removed, or put below the --- line
> please.
> 

Thanks response! Greg,

There are still a boot hang on one of renesas board on
CONFIG_RANDOMIZE_BASE. I am trying to get help from Renesas guys help on
this. I will back after fix it.

https://kernelci.org/boot/id/5a96f3dd59b5146590b3a4d5/

Thanks
Alex
