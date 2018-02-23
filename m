Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3493875-1519407352-2-17040071115388879662
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
    t=1519407351; b=WtAkvhOlqKkkYkPhoIAUCl4LytJ7lwfqJxFOZRVOv7V4uzY
    0aLaLS/iEj2W24tOYA96+CZeRhSAxBDNDBihvtNM2p1jDsf/O6fpizUFOhAmnvrO
    LzUQ31WbD8+zgfX/w/d0DY3hCGRRRqnSffMeD1SqGU0fbDNOMtZv2Trlhca3xJsy
    TBUT/PRJj335FFdmf5cXR9sGql0ZAft/yG7XFVSJ4nrniBM+pyHli+NWVbB5fjAz
    dvK5vXcFrR01l0erUe317aHPZDAtzZDc+nGvsHWDZlJqejQK5vV3m6r1SB0iuJSO
    4qBKF3Nz2t09CQUCYZo/EqxeIktDAzFBdpoesJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519407351; bh=nU5ImXiipsZk2dEX+m0n+2IHf9PaQOW9ZpS87pLg0K4=; b=f
    RlkQkwIKSMAOt5Zt81g3mIFPFYhnn5qQZtLIOXWeSWQ5SffyZqhNM4oD47+LTn1H
    KSUD+0XVuV399NOUQaZyvntRySLUAeYN8M6uMMcGwXqRIHAVKS4GmfEblAHe9Lsq
    oekDcAtW/VM+YSgv09xPHqRc1IIqdMMU4OHWYIbyszTVFiseOkvPB6yiTFoV2nNs
    GywdwUuKPSp+BcW8SmAjxeSaZH/k6qCz+8W6HCJUeci2FAmIkI2ZAQI/5ofiqNJg
    5CVritdfc4Nne9oz1nrEIEP157tuNSsUVKfykxDJ5YUhtXSmJFa+qygj8SZrLme8
    HgM88jpHlKUvFM050HPKQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751885AbeBWRfg (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 12:35:36 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44656 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751425AbeBWRff (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 23 Feb 2018 12:35:35 -0500
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
 <d66a2358-cfac-f441-3b59-e44674b6a792@redhat.com>
 <20180223172220.GK8252@char.us.oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7534bcd3-e21b-240c-9ed2-62026ba10301@redhat.com>
Date: Fri, 23 Feb 2018 18:35:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180223172220.GK8252@char.us.oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 23/02/2018 18:22, Konrad Rzeszutek Wilk wrote:
> On Fri, Feb 23, 2018 at 10:37:49AM +0100, Paolo Bonzini wrote:
>> On 22/02/2018 18:07, Konrad Rzeszutek Wilk wrote:
>>>> Having a paravirt indirect call in the IBRS restore path is not a
>>>> good idea, since we are trying to protect from speculative execution
>>>> of bogus indirect branch targets.  It is also slower, so use
>>>> native_wrmsrl on the vmentry path too.
>>> But it gets replaced during patching. As in once the machine boots
>>> the assembler changes from:
>>>
>>> 	callq 	*0xfffflbah
>>>
>>> to
>>> 	wrmsr
>>>
>>> ? I don't think you need this patch.
>>
>> Why not be explicit?  According to the spec, PRED_CMD and SPEC_CTRL
> 
> Explicit is fine.
> 
> But I would recommend you change the commit message to say so, and
> perhaps remove 'It is also slower' - as that is incorrect.

Actually it is faster---that's why I made the change in the first place,
though later I noticed

> If it is detected to be Xen PV, then yes
> it will be a call to a function. But that won't help as Xen PV runs in
> ring 3, so it has a whole bunch of other issues.

Ok, I wasn't sure about PVH (which runs in ring 0 afair).

Paolo
