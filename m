Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752663AbeCMNZD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 09:25:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60962 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752084AbeCMNZC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 09:25:02 -0400
Subject: Re: [PATCH 1/3] x86/kvm/vmx: read MSR_FS_BASE from current->thread
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>
References: <20180312140300.6166-1-vkuznets@redhat.com>
 <20180312140300.6166-2-vkuznets@redhat.com>
 <327f3194-715c-7aa7-f1bb-9ee1073f5b99@redhat.com>
 <87ina0cdto.fsf@vitty.brq.redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cec32ec2-6f71-0f51-8411-8d6a94881f55@redhat.com>
Date: Tue, 13 Mar 2018 14:24:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <87ina0cdto.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/03/2018 14:20, Vitaly Kuznetsov wrote:
> vmcs_writel() I guess ... and, just to make sure I follow your
> suggestion, this is for x86_64 only, right? x86_32 does
> 
> vmcs_writel(HOST_FS_BASE, segment_base(vmx->host_state.fs_sel));
> 
> and I think it needs to stay.

Yes.

> (personally, I'm rather for exporting save_fsgs(), dropping
> savesegment() and getting all we need from current to avoid propagating
> assumptions but I'm flexible)

Yes, that's fine too, as long as it's not mix and match. :)

Paolo
