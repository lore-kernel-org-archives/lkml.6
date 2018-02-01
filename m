Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-238414-1517513596-2-8402956060029064920
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: to='UTF-8', plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517513596; b=Mx8iUhMmfyBhLvBTOr9CUxOms/2RWtxwkVm3YnWFRXmCxNE
    725r1AxOkgv+4q03nk8qdzzKOLfbhIlCok37Rsg9BqKlzWaahoYqS8uvBJpznAUW
    bOFEOiBi4eXHVOGDZQsdTNFXeRubxKhuJPKCAL/REzesC7pxRbWjW6fBs+MNyLJn
    1yfcagDhbIeXPqYgPElLKy70wLpncv2pszkXEBKeEjd2Y/1Qn4dgz4qNvEEvPLd5
    IOWlw0pPEXWtwNE60itCK1bLJ6n2cB5jyoClC0iP9tFYYNJFLERfZ4Yw0E0K4Lat
    plcVSR8Cl1q3cbjXGX6apMv0Qs6aZaEc7kB2rpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1517513596; bh=lUrIRD0kg0G/IVmMRlHmhr2vr9g3nn9gdBAmAnsxKBU=; b=I
    0PV+Ms2SEDLAc+ia/S046ujZTYmJfuf+ZMl/eHoZyzRsk2Z3ZJasBpNiR1Dt/oxJ
    yFGQx28whp+yElCnpRS7eGJWWtp0QUh+p4h/GfHGwVhpkk/Be/wp0IDiY5ai7h1J
    mEcmXGn7A5o/BgDyRS7vbv6ZYZ3No71fydelLqwbcBcTWwcc4stSi9zqKwTuHFro
    QozV1HGYRa46PCLlK0sODRwXCH4fZ0ryZutcgTeEvSbPX09jt2AfXl0fLUR4ro/M
    G9KtSIXYjNO6Tn+V14Rn7Jg6zjo1oVuibW4Vel8Tl90xtK97KhqJaiQhESfwkg0L
    IygmNlCv8Eo7dAd0GA4YA==
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
        id S1754594AbeBATdO (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Feb 2018 14:33:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40592 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754563AbeBATdO (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 1 Feb 2018 14:33:14 -0500
Subject: Re: [PATCH] KVM: x86: fix backward migration with async_PF
To: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Wanpeng Li <wanpeng.li@hotmail.com>, stable@vger.kernel.org
References: <20180201175022.25011-1-rkrcmar@redhat.com>
 <a4fa9a87-cc4e-73d6-e248-192ab167b2c2@redhat.com>
 <20180201191040.GD26932@flask>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c820ef8e-b352-ef28-4756-d6949f718ec0@redhat.com>
Date: Thu, 1 Feb 2018 14:33:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180201191040.GD26932@flask>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 01/02/2018 14:10, Radim Krčmář wrote:
>>>
>> This check will break migration if the source guest and host both have
>> the recent kernels which support KVM_ASYNC_PF_DELIVERY_AS_PF_VMEXIT, so
>> I am not sure about it.  Otherwise, the patch is okay!
> Good point, breaking forward migration is worse than doing nothing.
> 
> A compromise solution would be to drop the feature check from the
> hypervisor.  Newer guests would work everywhere and there would be no
> change to old systems, so v4.13-v4.15 guests could at least upgrade.
> 
> Slightly better than doing nothing, IMO,

Yes, I agree.  Just removing the guest_kvm_cpuid_has should be fine.

Paolo
