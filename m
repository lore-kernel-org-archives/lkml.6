Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5BE3C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 08:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D523255AF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 08:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6514pAv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D523255AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752586AbeFYIK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 04:10:26 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36271 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751930AbeFYIKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 04:10:23 -0400
Received: by mail-wm0-f65.google.com with SMTP id u18-v6so4374265wmc.1;
        Mon, 25 Jun 2018 01:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/LmTsA7OwGFpaYgLJtu7N/VhLl6dwTJzAhQvona3+vY=;
        b=G6514pAvWh159L081kPPqAakFw+aUW3flqbDwZJRdmWGfd3uwZK4niCKBFyyOmnyb1
         D8gZYb7AbsVZlvDwDxsgKrUkdTfRFV+9yoKKuWcsEwMkmC0t22Zbgyu5S4PEliDFExs5
         cxlgEXvodxHmpKE5A+fzrXeVgO7BWTZ3tELTBdAtKMgGk/WTVJj3oO0nQuIXFTX9g8M2
         jwQXYRWY/GlYM2gTBvoM72gM3jnDJ3jVGd9AoXeG0lHNNM9H7Fhx0DS3M6MAl7qTcjFn
         xnWpthlAWFVFxq0EddIj/bLBxfkBewRBwuDERwKF6Tu/+0m2Ym3G2dNIK2RNZicn0Feq
         gIfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=/LmTsA7OwGFpaYgLJtu7N/VhLl6dwTJzAhQvona3+vY=;
        b=VuTwVqjK4aVf1mWcXK3Vdp1MhlH/i4v8pqBiQnYQTT82/fMhw9zEL2Xyvt5D8hkFS/
         72Pff+3BXh7UG4jKoBd+2qy1YRzdEH2V9/9tvE45GBgL0BIiEKjiXhIDSwKIHP+IweNZ
         KjbZYT3Lis2HPbJyW9b+adf7J7j5RCgtaej08Bdfj98ohBYWiUUua7JFzyCdtzA3cOKo
         d5r0R9zKMK5UvKmEt36nWich3sZo5F0jLhlTDYg/UCLzTqd6r+9YaUJzkSXnzAQCyrbv
         fcoSeSNJi3A1Bve+BDp6or1aWaltoGGDS1W8hol4kn3X0Rfh1zinAaikP88gcIrW6OuP
         wY6A==
X-Gm-Message-State: APt69E1tKUBuEStwZNSkFu6dn57W3FZhyKPRE+3v3vdXrWRfMhkleoEk
        AIMxOFLeMSOJSIUHYNwbFzk=
X-Google-Smtp-Source: AAOMgpc1mq6Pr9u66kF1saHBXKG5fk9OrvmywV5YzmeKUWNYIX+R2cazvvmh5zHSOP5tv7TCA6xL4Q==
X-Received: by 2002:a1c:8ec1:: with SMTP id q184-v6mr154642wmd.48.1529914222087;
        Mon, 25 Jun 2018 01:10:22 -0700 (PDT)
Received: from [192.168.10.150] ([82.84.124.111])
        by smtp.googlemail.com with ESMTPSA id k12-v6sm9471826wrr.40.2018.06.25.01.10.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 01:10:21 -0700 (PDT)
Subject: Re: [RFC PATCH] mm, oom: distinguish blockable mode for mmu notifiers
To:     Michal Hocko <mhocko@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        linux-mm@kvack.org, Andrea Arcangeli <aarcange@redhat.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>
References: <20180622150242.16558-1-mhocko@kernel.org>
 <d617fc1d-28a7-3441-7465-bedf4dc69976@redhat.com>
 <20180625075715.GA28965@dhcp22.suse.cz>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
Message-ID: <e7f3289e-3ee3-3f02-1947-9e4327e1a864@redhat.com>
Date:   Mon, 25 Jun 2018 10:10:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180625075715.GA28965@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/06/2018 09:57, Michal Hocko wrote:
> On Sun 24-06-18 10:11:21, Paolo Bonzini wrote:
>> On 22/06/2018 17:02, Michal Hocko wrote:
>>> @@ -7215,6 +7216,8 @@ void kvm_arch_mmu_notifier_invalidate_range(struct kvm *kvm,
>>>  	apic_address = gfn_to_hva(kvm, APIC_DEFAULT_PHYS_BASE >> PAGE_SHIFT);
>>>  	if (start <= apic_address && apic_address < end)
>>>  		kvm_make_all_cpus_request(kvm, KVM_REQ_APIC_PAGE_RELOAD);
>>> +
>>> +	return 0;
>>
>> This is wrong, gfn_to_hva can sleep.
> 
> Hmm, I have tried to crawl the call chain and haven't found any
> sleepable locks taken. Maybe I am just missing something.
> __kvm_memslots has a complex locking assert. I do not see we would take
> slots_lock anywhere from the notifier call path. IIUC that means that
> users_count has to be zero at that time. I have no idea how that is
> guaranteed.

Nevermind, ENOCOFFEE.  This is gfn_to_hva, not gfn_to_pfn.  It only
needs SRCU.

Paolo
