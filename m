Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2484469-1519378677-2-8738243361488244099
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519378676; b=WKaBC6uu3FcNftH+NrOxUZXFUx2l0l83q3JSb/Lz2Zdl/qv
    6MCEf/wLC3nmrVSGrRbZy5us7s+fKIR8j04Yh2LdwkX8yyipLhuuch73ThcDYcQg
    xaZsPkmsc6jw8dkSrn61dzy2qimgpF8sR5cduqHO8mECQlGADkT06yspwJ0SYGyJ
    pQDCfBLE+kFz8di0bzbklSybNZ3sJY1cLX7G2i1eX3eTreguw/b9saJU8Sxp67An
    kw4UlPs9rSCoXw/N+W+V5Atnm2aw+C/iKKTIxqvJHlS6NqDN0evcIhvGz8xvacxm
    QpEArK+5EvTcON/f3ahvAnJD0z921GOnBvKI6Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519378676; bh=2oDSnVUIbQ/Q20VhDW7n9VbS+oaZRUBeNBy4/WbEcmM=; b=o
    RpOTJDEN050gdtHhN4tlRHfsI21yJQOwqUtjf7zpkjjxmR8GFD5yt4PTFPaU5rYM
    PN7S60KBpS0kVwKSTQV3/zAsmfCMZMs2gQmXLI4AcXnf9jp2liNzY9Xg/zsZQWhG
    CxNk9YvN79k5Z8lmasrWuv8vKNOlIy+2D2U+aYM3+zkdmnNBaRXIWn+22TyluKoZ
    LiLztZwrvli343LaFJmcF+kTGsbDn3m1YjnLqhZtgI49pXr52+xv0ToXSU/hv9km
    YDyOp6WFWA2jYNE6r1NMBwfe2mrnIeUMK2PchdbySsfDma/ez2ES8vMgtWhirf4h
    9MLtpw4CfWNHGpPtCEfPw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751372AbeBWJhz (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 04:37:55 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56960 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751360AbeBWJhy (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 23 Feb 2018 04:37:54 -0500
Subject: Re: [PATCH 1/3] KVM: x86: use native MSR ops for SPEC_CTRL
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, x86@kernel.org,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KarimAllah Ahmed <karahmed@amazon.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Jim Mattson <jmattson@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, stable@vger.kernel.org
References: <1519249297-73718-1-git-send-email-pbonzini@redhat.com>
 <1519249297-73718-2-git-send-email-pbonzini@redhat.com>
 <20180222170717.GP31483@char.us.oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d66a2358-cfac-f441-3b59-e44674b6a792@redhat.com>
Date: Fri, 23 Feb 2018 10:37:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180222170717.GP31483@char.us.oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 22/02/2018 18:07, Konrad Rzeszutek Wilk wrote:
>> Having a paravirt indirect call in the IBRS restore path is not a
>> good idea, since we are trying to protect from speculative execution
>> of bogus indirect branch targets.  It is also slower, so use
>> native_wrmsrl on the vmentry path too.
> But it gets replaced during patching. As in once the machine boots
> the assembler changes from:
> 
> 	callq 	*0xfffflbah
> 
> to
> 	wrmsr
> 
> ? I don't think you need this patch.

Why not be explicit?  According to the spec, PRED_CMD and SPEC_CTRL
should be passed down to the guest without interception so it's safe to
do this.  On the other hand, especially with nested virtualization, I
don't think you can absolutely guarantee that the paravirt call will be
patched to rdmsr/wrmsr.

Paolo
