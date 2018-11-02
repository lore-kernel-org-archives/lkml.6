Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F232C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 06:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B03B20833
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 06:02:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B03B20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728246AbeKBPII (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 11:08:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58354 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727804AbeKBPII (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 11:08:08 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 212537F6A7;
        Fri,  2 Nov 2018 06:02:08 +0000 (UTC)
Received: from tonnant.bos.jonmasters.org (ovpn-120-10.rdu2.redhat.com [10.10.120.10])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0928D60BF4;
        Fri,  2 Nov 2018 06:02:04 +0000 (UTC)
Subject: Re: [PATCH v5 11/17] arm64: docs: document pointer authentication
To:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Kristina Martsenko <kristina.martsenko@arm.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Marc Zyngier <Marc.Zyngier@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Adam Wallis <awallis@codeaurora.org>,
        Suzuki Poulose <Suzuki.Poulose@arm.com>,
        Christoffer Dall <Christoffer.Dall@arm.com>,
        Dave P Martin <Dave.Martin@arm.com>,
        Amit Kachhap <Amit.Kachhap@arm.com>,
        Ramana Radhakrishnan <ramana.radhakrishnan@foss.arm.com>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Kees Cook <keescook@chromium.org>
References: <20181005084754.20950-1-kristina.martsenko@arm.com>
 <20181005084754.20950-12-kristina.martsenko@arm.com>
 <9acb0cd2-66b0-1c41-b1a8-7c70608e9a9b@foss.arm.com>
 <7b0de19b-45b9-f4df-25d1-c7e80fab49dc@arm.com>
 <20181019113556.ljbdmjo5pdw7muvz@mbp>
 <e73035eb-2157-7a9c-3631-d4d2ad0b7d38@arm.com>
 <20181019151029.GD3985@arrakis.emea.arm.com>
 <20181019174524.GC4429@brain-police>
From:   Jon Masters <jcm@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jcm@redhat.com; keydata=
 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
 yrXvw9qg2waGcnb8WuoS+g==
Message-ID: <d73e8824-bb8e-8172-4541-9be136453020@redhat.com>
Date:   Fri, 2 Nov 2018 02:02:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181019174524.GC4429@brain-police>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Fri, 02 Nov 2018 06:02:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/18 1:45 PM, Will Deacon wrote:

>>> I think an alternative solution is to just disable trapping of pointer
>>> auth instructions in KVM. This will mean that the instructions will
>>> behave the same in the guest as they do in the host. HINT-space
>>> instructions (including XPACLRI) will behave as NOPs (or perform their
>>> function, if enabled by the guest), and will not trap.
>>
>> OK, so this means disabling the trap (during early EL2 setup) but still
>> sanitizing the CPUID not to report the feature to EL1 unless fully
>> supported on all CPUs.
> 
> ... which is perfectly sensible, but not actually my main concern here.
> I'm worried about the possibility of distributions shipping *now* with
> userspace that's built with these instructions. That stuff is going to
> break if/when it encounters v8.3 hardware, and I don't think we can do
> much about it other than alert them to the potential issue.

FYI tracking this for RHEL. It's not a problem currently. I'll alert our
tools teams to hold off on any PAC work until this is figured out.

Jon.

-- 
Computer Architect | Sent with my Fedora powered laptop
