Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751207AbeC0ITr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 04:19:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37034 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750937AbeC0ITp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 04:19:45 -0400
Subject: Re: [PATCH 2/2] KVM: VMX: Add Force Emulation Prefix for "emulate the
 next instruction"
To: Liran Alon <liran.alon@oracle.com>, kernellwp@gmail.com
Cc: rkrcmar@redhat.com, linux-kernel@vger.kernel.org,
        andrew.cooper3@citrix.com, kvm@vger.kernel.org
References: <76d08635-59da-4399-bc35-f99a00236725@default>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0500b892-03a8-4c39-3d92-2c909ae473cb@redhat.com>
Date: Tue, 27 Mar 2018 10:19:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <76d08635-59da-4399-bc35-f99a00236725@default>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/03/2018 09:52, Liran Alon wrote:
>> +static bool __read_mostly fep = 0;
>> +module_param(fep, bool, S_IRUGO);
> I think this module parameter should have a better name...
> Why not "emulation_prefix" or "enable_emulation_prefix"?
> This short names just confuse the average user.
> It makes him think it is some kind of Intel VT-x technology
> that he isn't aware of :P

Agreed.

> In addition, I think this module parameter should be in kvm module
> (not kvm_intel) and you should add similar logic to kvm_amd module (SVM)

If you can move handle_ud to x86.c, then it makes sense to have the
module parameter in the kvm module.  I haven't checked.

Otherwise you would have to EXPORT_SYMBOL_GPL the variable; in the end
it's just a debugging tool, so it'd be simpler to just add it separately
to kvm_intel and kvm_amd.

Paolo
