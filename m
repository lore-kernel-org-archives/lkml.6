Return-Path: <pbonzini@redhat.com>
X-Google-Smtp-Source: AH8x224q20m8QT670YNWpOfdGamcPWkf+0lV3xH+8nIHF3cLcp/eq0wdHVAzEtoZ4DJLz2WUbcqy
ARC-Seal: i=1; a=rsa-sha256; t=1517494152; cv=none;
        d=google.com; s=arc-20160816;
        b=r9X4mXGOr5KJY1GfHjf7dCnHlI875i48uKctirIuUI7jwUe39r4+kZTdgap5T6Lrxf
         dCukuKjhiuJa9yroBs6Je/D4QY9UKWrspkUpyGGXRSZRp8MAKbL3KOE4mBMOC73axEdf
         5gHgp+IVdrl9nJsgJ94h0p1WznLJNcDVUHCYyMFnuXvD/L7rj+nomcfQqpVUGZLfX6FW
         j/Gj2jAvHdTeLvlCNScg5BnQ0ulHIgOV9Ce3z85QQz57iWzzJgPBiobZZPYwElLYMuUk
         MFxvWZy4qqrAjTtztUbG8qwsMpjs2Rd4yf8aoUtJhQu/eML3nVrvUAytxmbz+E0HEx49
         gd3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=/DFgnEPkb6Qu9qgzW+Bsoe+PM2U7vydylgpGjwJBudM=;
        b=pZ0maFSXw/Q7PFAU39cKUMGtQxYSt2K0bGqL5VXWfbKZhE0fbHm2IpAiHJFAxkhkjQ
         gOsnWNvaOOPNGDm8CdomObF8vYD+bslAudsqQmxU8XBTxuE37RqTUbkXUV3Mb5RUibqu
         XhE5yqUVrT62b/blLn10FPoa4c/rVDBDXlN81R0kHqr37zPePZjQ3A2PLtVwNAjZ9w9m
         799u1R6VYNGQZjuyQ96bIJyAQ8/NF4EfKE8UmaeKA/2DLj22WxJX7qZM2Ycb09nepPJU
         UQT8N4ZQR/CR80Dg0gFIfg34f3NwuaQ4WvYWgnNLX+456gUSIMnwKMrhDKfuXXPK4Ijy
         062A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of pbonzini@redhat.com designates 209.132.183.28 as permitted sender) smtp.mailfrom=pbonzini@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of pbonzini@redhat.com designates 209.132.183.28 as permitted sender) smtp.mailfrom=pbonzini@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Subject: Re: [PATCH v5 4/5] KVM: VMX: Allow direct access to
 MSR_IA32_SPEC_CTRL
To: David Woodhouse <dwmw2@infradead.org>, Jim Mattson <jmattson@google.com>
Cc: KarimAllah Ahmed <karahmed@amazon.com>,
 KarimAllah Ahmed <karahmed@amazon.de>, kvm list <kvm@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 the arch/x86 maintainers <x86@kernel.org>,
 Asit Mallick <asit.k.mallick@intel.com>,
 Arjan Van De Ven <arjan.van.de.ven@intel.com>,
 Dave Hansen <dave.hansen@intel.com>, Andi Kleen <ak@linux.intel.com>,
 Andrea Arcangeli <aarcange@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Tim Chen <tim.c.chen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 Dan Williams <dan.j.williams@intel.com>,
 Jun Nakajima <jun.nakajima@intel.com>, Greg KH <gregkh@linuxfoundation.org>,
 Andy Lutomirski <luto@kernel.org>, Ashok Raj <ashok.raj@intel.com>
References: <1517427467-28567-1-git-send-email-karahmed@amazon.de>
 <1517427467-28567-5-git-send-email-karahmed@amazon.de>
 <CALMp9eRgc-qKS5CDTvqoUDdnAXu8xqy9ZB-rew=P9NgE5AfXWA@mail.gmail.com>
 <06cb88da-f355-41ed-380f-7daa8ddf6159@amazon.com>
 <CALMp9eS9LAJz+u3ujKZ5kLHihHMZ68LHajn3ri7sRPPEgFbHfA@mail.gmail.com>
 <67dca2bb-1298-c7fa-f681-018e4edc6725@redhat.com>
 <CALMp9eT677DU=EGoezcyjRMAP3XKiK_6FBJb-rVQrBX2CSbTuw@mail.gmail.com>
 <16d89e09-fbfc-4a08-00a6-40cfb4776018@redhat.com>
 <CALMp9eQ5fbfnqCvs_dMhoTOGTDX-+yt6QtJdUfiQg1BXq-0P3A@mail.gmail.com>
 <f6e76523-7727-6e79-7bcf-3d6c6ebd64d8@redhat.com>
 <CALMp9eRF4_khB40b1_HmUj9K+FPE5X0M+KUkthi7k_rdQdgwoA@mail.gmail.com>
 <1517435981.18619.215.camel@infradead.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <337b9577-50bc-412f-3cf3-7d366755aa76@redhat.com>
Date: Thu, 1 Feb 2018 09:09:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <1517435981.18619.215.camel@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591113692084885209?=
X-GMAIL-MSGID: =?utf-8?q?1591207948132328516?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 31/01/2018 16:59, David Woodhouse wrote:
> 
> 
> On Wed, 2018-01-31 at 13:53 -0800, Jim Mattson wrote:
>> On Wed, Jan 31, 2018 at 1:42 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>>> Can we just say it sucks to be L2 too? :)  Because in the end as long as
>>> no one ever writes to spec_ctrl, everybody is happy.
>>
>> Unfortunately, quite a few OS vendors shipped IBRS-based mitigations
>> earlier this month. (Has Redhat stopped writing to IA32_SPEC_CTRL yet?
>> :-)
>>
>> And in the long run, everyone is going to set IA32_SPEC_CTRL.IBRS=1 on
>> CPUs with IA32_ARCH_CAPABILITIES.IBRS_ALL.
> 
> 
> I'm actually working on IBRS_ALL at the moment.
> 
> I was tempted to *not* let the guests turn it off. Expose SPEC_CTRL but
> just make it a no-op.

That would be very slow.

> Or if that really doesn't fly, perhaps with IBRS_ALL we should invert
> the logic. Set IBRS to 1 on vCPU reset, and only if it's set to *zero*
> do we pass through the MSR and set the save_spec_ctrl_on_exit flag.

... but something like that would be a good idea.  Even if IBRS to 0 on
vCPU reset, only pass it through once it's set to zero.  The first
IBRS=1 write would not enable pass through, and would not set the
save_spec_ctrl_on_exit flag.  In fact it need not even be conditional on
IBRS_ALL.

Paolo

> But let's get the code for *current* hardware done first...
> 
