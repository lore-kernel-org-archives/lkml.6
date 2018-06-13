Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 0DE04C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 11:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C197D20891
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 11:00:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C197D20891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935379AbeFMLAC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 07:00:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33746 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935269AbeFMLAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 07:00:00 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3911F81663E7;
        Wed, 13 Jun 2018 11:00:00 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 45B872166BB2;
        Wed, 13 Jun 2018 10:59:59 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KVM list <kvm@vger.kernel.org>
Subject: Re: [GIT PULL] KVM changes for 4.18 merge window
References: <1528812229-53043-1-git-send-email-pbonzini@redhat.com>
        <CA+55aFwvE5G7MV7AV4naAXdbFoszc4JNKEj_QtYqpLFfa2RXtA@mail.gmail.com>
        <6570c00b-bbec-82c3-16e2-1ba96d8e263b@redhat.com>
Date:   Wed, 13 Jun 2018 12:59:58 +0200
In-Reply-To: <6570c00b-bbec-82c3-16e2-1ba96d8e263b@redhat.com> (Paolo
        Bonzini's message of "Wed, 13 Jun 2018 12:09:11 +0200")
Message-ID: <87y3fjossx.fsf@vitty.brq.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 13 Jun 2018 11:00:00 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 13 Jun 2018 11:00:00 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vkuznets@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 13/06/2018 04:18, Linus Torvalds wrote:
>> On Tue, Jun 12, 2018 at 7:03 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>>>
>>> * x86: many bugfixes, implement more Hyper-V super powers,
>> 
>> Uhhuh, I didn't notice this initially, because my basic sanity tests
>> are with everything enabled, but this breaks the build:
>> 
>>   ERROR: "ms_hyperv" [arch/x86/kvm/kvm-intel.ko] undefined!
>> 
>> The attached patch _may_ be the right thing to do. It's not pretty.
>> 
>> Hmm? And why was this not found before it hit my tree?
>
> Because I should do more "make randconfig"s, probably.
>

This was reported before by Arnd Bergmann:

https://www.spinics.net/lists/kvm/msg169536.html

but it seems his patch got lost.

Sorry for the breakage :-)

-- 
  Vitaly
