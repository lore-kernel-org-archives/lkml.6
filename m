Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752962AbeBEOTd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 09:19:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45216 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752612AbeBEOT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 09:19:27 -0500
Subject: Re: [PATCH] x86/kvm: clear RSB before VMENTER to obscure host
 addresses
To: Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc: x86@kernel.org, luto@amacapital.net, ak@linux.intel.com,
        jun.nakajima@intel.com, tim.c.chen@linux.intel.com,
        arjan@linux.intel.com, dwmw2@infradead.org, keescook@google.com
References: <20180202211028.0A49AAAD@viggo.jf.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6196469d-9766-faef-563d-e278dc92e4e2@redhat.com>
Date: Mon, 5 Feb 2018 15:19:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180202211028.0A49AAAD@viggo.jf.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/2018 22:10, Dave Hansen wrote:
> I'm posting this because I went to the trouble of hacking it together
> and writing up a pretty lengthy description of what it does and where
> it _might_ have benefit.  But, I'm rather unconvinced that mitigation
> of attacks on ASLR has a lot of value because of how many other
> attacks on ASLR there are.
> 
> Thus, the RFC.

I'm a bit afraid that this would be pretty expensive for just an ASLR
attack.

The cost of stuffing the RSB once is about 60 clock cycles, and if you
do it twice we're spending 10-15% of vmexit time (for the low-latency
cases that matter) on RSB stuffing.

Paolo
