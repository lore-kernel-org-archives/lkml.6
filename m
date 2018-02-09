Return-Path: <prvs=57180e295=Andrew.Cooper3@citrix.com>
X-Google-Smtp-Source: AH8x224HtLVEG+lOJOLh2bfVyvbmyterpBptQeXi+x54D8w9cP78UbVKILCX6rmLTnuB1cbGeJkO
ARC-Seal: i=1; a=rsa-sha256; t=1518184486; cv=none;
        d=google.com; s=arc-20160816;
        b=Gt1xl1e7owyTfdg2a0R5n2odVZstYqcpMUVlMpYciPS4QlOfEAkrtm2++JtYYUMXoO
         jFvJzBulVL+OOdZK+/sNQVfUMWv5Hr1j1n1yyvMzkkxkagHWFnS0S0XUAe3DwmcnZY9+
         EwLteN9CS1yC2vI+RnCCPRHNzpzDqgH3MtH2Vkz2M7huYzYfrQT2cPgvp3q7Evps1jy7
         uCPiu4DjKZPkyryZWNkEPMxYSkb0957KdL+x4h84q5ouVm8+AJvCW+3uTOKf2FDewswp
         vvaqHyah2qs4ikNFMm3xzD3Hw+E7N36uOMGLSiC9QmvIpyqNq4CsC2WuwCHsFLLtxpjr
         mWww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=8py0D4bXUY56fIiZV+vGc0EnkOWzmxlXjFIrjBRCDQo=;
        b=alC8XuX+cPPOf/5k14LxogxRwlxsSTuHYCd63TN7tx2zfSY1hBFNS3iwSy20xd27KD
         STbEduFN4Z+QteOrB0jYNdPuErbXJbli30XnglpADhO9y68nVTq3lWAb6LR2fBYvyujO
         yF3aRc3TjvdkjzhT3eNIl2HpvjLy4xL/I2KNOovDuOtSUQNyUfRJJ+Q8pG9bnVG+UKWW
         +B7DgJxjibF00ucof/+VXw7gLVZdbqL1j2Ldc5vn7oBaABn6IDEuSCgmIwlpS5IxKNjr
         fkPWbmDe2XXlOS9afQdHZ5allaVF8S01Fsa4XKPoDwEC9K7K3ft6JChjYYs99oYbvkyI
         cU5Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of prvs=57180e295=andrew.cooper3@citrix.com designates 185.25.65.24 as permitted sender) smtp.mailfrom=prvs=57180e295=Andrew.Cooper3@citrix.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of prvs=57180e295=andrew.cooper3@citrix.com designates 185.25.65.24 as permitted sender) smtp.mailfrom=prvs=57180e295=Andrew.Cooper3@citrix.com
X-IronPort-AV: E=Sophos;i="5.46,483,1511827200";
   d="scan'208";a="67618866"
Subject: Re: [PATCH 00/31 v2] PTI support for x86_32
To: Joerg Roedel <joro@8bytes.org>, Juergen Gross <jgross@suse.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, "H .
 Peter Anvin" <hpa@zytor.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, Linus Torvalds
	<torvalds@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Dave
 Hansen <dave.hansen@intel.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, Jiri Kosina
	<jkosina@suse.cz>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Brian Gerst
	<brgerst@gmail.com>, David Laight <David.Laight@aculab.com>, Denys Vlasenko
	<dvlasenk@redhat.com>, Eduardo Valentin <eduval@amazon.com>, Greg KH
	<gregkh@linuxfoundation.org>, Will Deacon <will.deacon@arm.com>,
	<aliguori@amazon.com>, <daniel.gruss@iaik.tugraz.at>, <hughd@google.com>,
	<keescook@google.com>, Andrea Arcangeli <aarcange@redhat.com>, Waiman Long
	<llong@redhat.com>, Pavel Machek <pavel@ucw.cz>, <jroedel@suse.de>
References: <1518168340-9392-1-git-send-email-joro@8bytes.org>
 <35f19c79-7277-3ad8-50bf-8def929377b6@suse.com>
 <20180209133507.GD16484@8bytes.org>
From: Andrew Cooper <andrew.cooper3@citrix.com>
Message-ID: <9ca8429b-4ae4-e009-69b0-c4945be41e65@citrix.com>
Date: Fri, 9 Feb 2018 13:54:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180209133507.GD16484@8bytes.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591914900490843452?=
X-GMAIL-MSGID: =?utf-8?q?1591931816514645064?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 09/02/18 13:35, Joerg Roedel wrote:
> Hi Juergen,
>
> On Fri, Feb 09, 2018 at 01:11:42PM +0100, Juergen Gross wrote:
>> On 09/02/18 10:25, Joerg Roedel wrote:
>>> XENPV is also untested from my side, but I added checks to
>>> not do the stack switches in the entry-code when XENPV is
>>> enabled, so hopefully it works. But someone should test it,
>>> of course.
>> That's unfortunate. 32 bit XENPV kernel is vulnerable to Meltdown, too.
>> I'll have a look whether 32 bit XENPV is still working, though.
>>
>> Adding support for KPTI with Xen PV should probably be done later. :-)
> Not sure how much is missing to make it work there, one point is
> certainly to write the right stack into tss.sp0 for xenpv on 32bit. This
> write has a check to only happen for !xenpv.
>
> But let's first test the code as-is on XENPV and see if it still boots
> :)

IMO, the only sensible way to do KPTI + Xen PV is to have Xen to do the
pagetable switch for 32bit like we already do for 64bit guests.  All
context switches already pass through the hypervisor, and it saves the
guest having to make the updates itself (which will trap for auditing)
or having to juggle the set_stack_base() semantics.

~Andrew
