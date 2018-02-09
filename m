Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752013AbeBIMnb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 07:43:31 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58958 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750863AbeBIMn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 07:43:29 -0500
Subject: Re: [PATCH v2] x86/kvm/vmx: Don't halt vcpu when L1 is injecting
 events to L2
To: Chao Gao <chao.gao@intel.com>, kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Liran Alon <liran.alon@oracle.com>
References: <1518152952-12633-1-git-send-email-chao.gao@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8654b592-c945-f66c-6c7c-f26cd3fa24f6@redhat.com>
Date: Fri, 9 Feb 2018 13:43:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <1518152952-12633-1-git-send-email-chao.gao@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/02/2018 06:09, Chao Gao wrote:
> Although L2 is in halt state, it will be in the active state after
> VM entry if the VM entry is vectoring according to SDM 26.6.2 Activity
> State. Halting the vcpu here means the event won't be injected to L2
> and this decision isn't reported to L1. Thus L0 drops an event that
> should be injected to L2.

Can you please write a testcase for kvm-unit-tests?

Thanks,

Paolo
