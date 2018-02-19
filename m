Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-177322-1519049254-2-14026113998708552982
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519049253; b=Q+urCHvF250R8UTOFs28MwuVkYdeEoGRVWRA8jmC3s14dzF
    5Luwzn75jALETMGWftYfJazSgoCDzyM2mD9EFSb7p4Oowqz1zsMW/Ak+NH4+gIUd
    PZVE20Js/RlZBC0XVrWtqzjuBeZEehoiqMu6nnWF7LKug4qhSc1QsPkpRwr9tPpr
    PGRhwaclYzOBrxSitjILFAYtIjbuN3ijO6tQK/zYUIfgzrmbm+jSFBw7HBZU3H00
    f48G7ZetSGAa1JIrOjV4SefeSIz5WZbrsKl+rfAvdCqDj5PIRpv6Zpk1pvdW18EZ
    aiHK+Pog2zMnDnug/RFwlyOxz5d1k5w+/SvlJxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519049253; bh=zmXUSjRKdk2Oh3GAHPf+Xs4J9ivVcqzbLqt99MIsLEY=; b=i
    uV96t6fdJI0RNebrvN7a7oQwtHkHAIrp2OiG4+sR0/c4d3AH0bGtYPLlOe1dzOvm
    uhBcmgVhVivcwwjZOWQWJ+00lVsJ8+Sy/JmauCv95Ha4xu5RmVepFE62nhIxIz06
    cKkEwf5FyTmSQ23gwRoXLAFuSaBBYbLfpucm5l3ypbsW0b+8BJemDvPX20aKTc9l
    ZFyJ9fH8Chek/3aRJqK48Id8n++N7K1Oo92ApucVtr7SXh27omqxl/ZpQWrW9m5n
    lu5XrbzJEZ4CJrJhV5+JBtHhjVYv7v2R48dfyqQh4jQUwFTGHEzUeuniQL9fV4xM
    1S8Iz7uqslb0t9Gul/4GQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751447AbeBSOHQ (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Feb 2018 09:07:16 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56752 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750998AbeBSOHP (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Feb 2018 09:07:15 -0500
Subject: Re: [PATCH 7/9] KVM/VMX: Emulate MSR_IA32_ARCH_CAPABILITIES
To: David Woodhouse <dwmw2@infradead.org>,
        Jim Mattson <jmattson@google.com>
Cc: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        KarimAllah Ahmed <karahmed@amazon.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
References: <1517938181-15317-1-git-send-email-dwmw@amazon.co.uk>
 <1517938181-15317-8-git-send-email-dwmw@amazon.co.uk>
 <4be4e462-61be-53a9-b0e1-3508466d1645@redhat.com>
 <CALMp9eQQ-94g=fNanvwpr6b2pmH87RPGr6s9gOv43dUDABFuhw@mail.gmail.com>
 <a4693ca3-face-e1f5-b619-74fc59870ce9@redhat.com>
 <1519047329.7876.64.camel@infradead.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6ef598e6-de89-abdb-f157-dc12bb24ef9d@redhat.com>
Date: Mon, 19 Feb 2018 15:07:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519047329.7876.64.camel@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 19/02/2018 14:35, David Woodhouse wrote:
> On Mon, 2018-02-19 at 14:10 +0100, Paolo Bonzini wrote:
>>> Hardware seems like a reasonable place to get the default value (cf.
>>> the VMX capability MSRs).
>>
>> There are some differences:
>>
>> - a zero value for ARCH_CAPABILITIES should be safe, while a zero value
>> for VMX capabilities doesn't really make sense.  On the contrary, a
>> nonzero value for ARCH_CAPABILITIES is not safe across live migration.
> 
> Any VMM which is going to support live migration surely needs to pay at
> least a small amount of attention to the features it exposes? Exposing
> the ARCH_CAPABILITIES CPUID bit without actually looking at the
> contents of the associated MSR which that bit advertises would be... a
> little strange, would it not? 

I think what we should do is simply backport Tom Lendacky's series to
4.14 and 4.9 ASAP, and add ARCH_CAPABILITIES support there.  Then the
question of the default becomes moot, more or less.

Paolo

> I don't see why we care so much about the *default* value, in that
> context.
