Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754706AbeCVMiO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 08:38:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59642 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753076AbeCVMiL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 08:38:11 -0400
Subject: Re: [PATCH] KVM: X86: Fix the decoding of segment overrides in 64bit
 mode
To: Andrew Cooper <andrew.cooper3@citrix.com>,
        Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <1521707651-9375-1-git-send-email-wanpengli@tencent.com>
 <aadc47c3-9d5f-b4d5-92d3-cb888a29563c@redhat.com>
 <49454fe4-16e2-4d8b-7ad5-9e488afc786e@citrix.com>
 <d1126eb9-7203-7044-f72b-174cac6607ab@redhat.com>
 <e9db6804-4881-be93-f570-e9631dbccac8@citrix.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9bd82cb0-d88f-4891-a111-3704802e1d4e@redhat.com>
Date: Thu, 22 Mar 2018 13:38:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <e9db6804-4881-be93-f570-e9631dbccac8@citrix.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/2018 12:04, Andrew Cooper wrote:
> We've got a Force Emulation Prefix (ud2a; .ascii "xen") for doing
> magic.  Originally, this was used for PV guests to explicitly request an
> emulated CPUID, but I extended it to HVM guests for "emulate the next
> instruction", after we had some guest user => guest kernel privilege
> escalations because of incorrect emulation.

Wanpeng, why don't you add it behind a new kvm module parameter? :)

Paolo
