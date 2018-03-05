Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934186AbeCEKaB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 05:30:01 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34712 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934137AbeCEK3v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 05:29:51 -0500
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
        Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org
Subject: Re: [PATCH] KVM: lapic: stop advertising DIRECTED_EOI when in-kernel IOAPIC is in use
References: <20180209130133.28387-1-vkuznets@redhat.com>
Date: Mon, 05 Mar 2018 11:29:46 +0100
In-Reply-To: <20180209130133.28387-1-vkuznets@redhat.com> (Vitaly Kuznetsov's
        message of "Fri, 9 Feb 2018 14:01:33 +0100")
Message-ID: <87r2oyzug5.fsf@vitty.brq.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vitaly Kuznetsov <vkuznets@redhat.com> writes:

> Devices which use level-triggered interrupts under Windows 2016 with
> Hyper-V role enabled don't work: Windows disables EOI broadcast in SPIV
> unconditionally. Our in-kernel IOAPIC implementation emulates an old IOAPIC
> version which has no EOI register so EOI never happens.
>
> The issue was discovered and discussed a while ago:
> https://www.spinics.net/lists/kvm/msg148098.html
>

Radim, Paolo,

do we have a consensus here? (I wouldn't mind re-writing commit message
in case you think we shouldn't blame Windows, I just want to have the
annoying bug fixed :-)

-- 
  Vitaly
