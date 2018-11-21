Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F25AFC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 22:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1F132080F
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 22:55:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1F132080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390380AbeKVJbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 04:31:51 -0500
Received: from mga17.intel.com ([192.55.52.151]:20837 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390349AbeKVJbv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 04:31:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Nov 2018 14:55:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,262,1539673200"; 
   d="scan'208";a="110134814"
Received: from avandeve-mobl.amr.corp.intel.com (HELO [10.251.25.44]) ([10.251.25.44])
  by fmsmga001.fm.intel.com with ESMTP; 21 Nov 2018 14:55:23 -0800
Subject: Re: [patch 01/24] x86/speculation: Update the TIF_SSBD comment
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Jiri Kosina <jkosina@suse.cz>, thomas.lendacky@amd.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>, dave.hansen@intel.com,
        Casey Schaufler <casey.schaufler@intel.com>,
        "Mallick, Asit K" <asit.k.mallick@intel.com>, jcm@redhat.com,
        longman9394@gmail.com, Greg KH <gregkh@linuxfoundation.org>,
        david.c.stewart@intel.com, Kees Cook <keescook@chromium.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
References: <20181121201430.559770965@linutronix.de>
 <20181121201722.337599561@linutronix.de>
 <CAHk-=wgLZkKDLeNN818VG0wC6B_kCUJqKPLdW+KDVocU6_DvtA@mail.gmail.com>
 <CAHk-=wj6fZpcad+1O5Ou0HZb0NEv1RM_BweyM0XBGtzE87YXXg@mail.gmail.com>
 <alpine.DEB.2.21.1811212345180.1665@nanos.tec.linutronix.de>
 <20181121225336.GE27559@zn.tnic>
From:   Arjan van de Ven <arjan@linux.intel.com>
Message-ID: <9cbce8e5-bc0d-a817-04f5-57b9f8ec0f70@linux.intel.com>
Date:   Wed, 21 Nov 2018 14:55:20 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181121225336.GE27559@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21/2018 2:53 PM, Borislav Petkov wrote:
> On Wed, Nov 21, 2018 at 11:48:41PM +0100, Thomas Gleixner wrote:
>> Btw, I really do not like the app2app wording. I'd rather go for usr2usr,
>> but that's kinda horrible as well. But then, all of this is horrible.
>>
>> Any better ideas?
> 
> It needs to have "task isolation" in there somewhere as this is what it
> does, practically. But it needs to be more precise as in "isolates the
> tasks from influence due to shared hardware." :)
> 

part of the problem is that "sharing" has multiple dimensions: time and space (e.g. hyperthreading)
which makes it hard to find a nice term for it other than describing who attacks whom

