Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3233056-1518111745-2-16827432574196798957
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
    t=1518111744; b=DZvnA8oxWdYg1rX4xOt5H2IoLQUuRkOw4i8dvU1GIquPQJA
    WdTk3xxn2SOJAXcgoOG6E0LW+lncNaOYq4bs+gvbD+YnjGgcUgIavnkftdk3NWmb
    t6ngF9yANwzTPcLIo8fouausz9lnBSwsIjohypDpF2Y5PwNJLQnn7+q0OvAd+jIq
    8NJ3E7Vz/3mQSFDDYgTJwTw3P08vEiAwaOTCZne7RDX5wRL+fB3aed8yiqUdzYxt
    Z4ac/+nGeeWLDQTKjD8NF/9j9+AKjJM5DoXTu8WhGs5VOBgAZhkvLjywghqDxDJd
    jb/Kfi+cQZhzRWfpklgrUF43c/tEDqujJIsJocQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1518111744; bh=YIurag2xC9G3NHsdhF81KfpWvcTcYOBIPvf8tsc8dZ8=; b=F
    qspV7rDIHVDtggBO1wdZ4/ZRhhGhN2nRmtQo+FtPPm+xmc9wk/WqOAm1mcNgXv8r
    k1ZZV6QjjXUl4s6aRaC3sHEVdutQFaV7NUPtX3t4eGkgF5BxThknaWJKPP0wPIXY
    NOIXdMyRC6mGHjFHiQMmQneCHj2sozB28MUCBPJqdhpKa1ZRfgZ0hYimSEArff10
    2SZ1yLcm42iWId8HVDwWRBhYBnRdNbsIAbqIt21TED6UepF5VECDvO2GXumCBAJ7
    NZ7MOEM6X2lsqQpRQ/dN/WYtVbhtZ0f/WZ8dTsUaOn/9wuFJ1UqGVuyedGi6EeO9
    KILXLxifGxly2VXSdZmnw==
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
        id S1752087AbeBHRmJ (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Feb 2018 12:42:09 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35364 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750847AbeBHRmH (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Feb 2018 12:42:07 -0500
Subject: Re: [STABLE 4.9.y PATCH 0/9] Backport of KVM Speculation Control
 support
To: Greg KH <gregkh@linuxfoundation.org>,
        "Woodhouse, David" <dwmw@amazon.co.uk>
Cc: Jim Mattson <jmattson@google.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        KarimAllah Ahmed <karahmed@amazon.de>, stable@vger.kernel.org
References: <1517938181-15317-1-git-send-email-dwmw@amazon.co.uk>
 <9ea4d52a-7ae6-a179-2f86-1e7b77255387@redhat.com>
 <1517951146.3677.34.camel@amazon.co.uk> <20180208024959.GA16399@kroah.com>
 <20180208171436.GA3521@kroah.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d609eb51-b5eb-0d39-070b-e8fe0e2837f7@redhat.com>
Date: Thu, 8 Feb 2018 18:42:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180208171436.GA3521@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 08/02/2018 18:14, Greg KH wrote:
> On Thu, Feb 08, 2018 at 03:49:59AM +0100, Greg KH wrote:
>> On Tue, Feb 06, 2018 at 09:05:46PM +0000, Woodhouse, David wrote:
>>>
>>>
>>> On Tue, 2018-02-06 at 19:01 +0100, Paolo Bonzini wrote:
>>>> On 06/02/2018 18:29, David Woodhouse wrote:
>>>>> I've put together a linux-4.9.y branch at 
>>>>> http://git.infradead.org/retpoline-stable.git/shortlog/refs/heads/linux-4.9.y
>>>>>  
>>>>> Most of it is fairly straightforward, apart from the IBPB on context 
>>>>> switch for which Tim has already posted a candidate. I wanted some more
>>>>> review on my backports of the KVM bits though, including some extra
>>>>> historical patches I pulled in.
>>>>
>>>> Looks good!  Thanks for the work,
>>>>
>>>> Paolo
>>>
>>> Thanks. In that case, Greg, the full set is lined up in
>>> http://git.infradead.org/retpoline-stable.git/shortlog/refs/heads/linux-4.9.y
>>> or git://git.infradead.org/retpoline-stable linux-4.9.y
>>
>> Many thanks for all of this work.  I've now queued up all of these.
> 
> There's a problem with the backport of 6342c50ad12e ("KVM: nVMX:
> vmx_complete_nested_posted_interrupt() can't fail") as there is still a
> check in the function that can fail:
> 
> 		vapic_page = kmap(vmx->nested.virtual_apic_page);
> 		if (!vapic_page) {
> 			WARN_ON(1);
> 			return -ENOMEM;
> 		}
> 
> Do we need something else before this patch in order to fix this?  I
> guess kmap really can't fail, should I just drop the whole (!vapic_page)
> check?

Yes, that would be commit 42cf014d38d8822cce63703a467e00f65d000952.
Should David or I respin?

Thanks,

Paolo
