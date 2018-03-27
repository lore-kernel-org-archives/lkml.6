Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751840AbeC0HZL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 03:25:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47650 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750913AbeC0HZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 03:25:09 -0400
Subject: Re: [PATCH 2/2] KVM: VMX: Add Force Emulation Prefix for "emulate the
 next instruction"
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Wanpeng Li <kernellwp@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>
References: <1522116735-4861-1-git-send-email-wanpengli@tencent.com>
 <1522116735-4861-3-git-send-email-wanpengli@tencent.com>
 <20180327044020.GB16974@char.us.oracle.com>
 <20180327045558.GC16974@char.us.oracle.com>
 <CANRm+Cw7VVNmA=DvrzbUDoTQZ_O2sTQVJiu-v-fVt+e3jfB_gw@mail.gmail.com>
 <20180327051840.GF16974@char.us.oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0ad9fff9-6ebb-2d63-5c9f-b9aba7d619ac@redhat.com>
Date: Tue, 27 Mar 2018 09:25:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180327051840.GF16974@char.us.oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/03/2018 07:18, Konrad Rzeszutek Wilk wrote:
>> I think a global module is enough for testing.
> If so, perhaps have it wrapped with #ifdef DEBUG?
> 
> No need to put code gadgets that won't be utilized 99% of time.

It is going to be used a lot in testing, actually.  There are quite a
few emulate.c bugfixes that are hard to test (see for example the
syscall eflags.tf bug that can currently be tested only on Intel) and
having something like this can only improve our coverage.

#ifdef DEBUG is almost always a bad idea, and though I agree that the
commit messages can be improved, I think the module parameter is the way
to go.

Wanpeng, can you also add it to svm.c?

Thanks,

Paolo
