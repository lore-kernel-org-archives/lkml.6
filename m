Return-Path: <dave.hansen@intel.com>
X-Google-Smtp-Source: AG47ELsc1Vb6OIdIZY7Zjs9oV3mvDrIVwyXljPOTSjFcvZogzjp4wtBRMEiTV3SVP7n76pUotV4g
ARC-Seal: i=1; a=rsa-sha256; t=1520343958; cv=none;
        d=google.com; s=arc-20160816;
        b=FryUkCNs5Eae62FZ4/y2eINA6jFaYmzOthCFrpONEGNNCbG1ovh/gFiQQhs2bRexxX
         Nz/e+VFo+dwHK/XwSR0CPaJkXPJeTEG2RTU6eQO+yqGl7amrW4I1HBWBBZu2RKu4BfAP
         G/l8Jh5GUyZDdRD6aXgCb8YMLjdn1C2oYlCdwpygqQ+rFXHnrWjb61gOVKqVHFsFdb/X
         PwOfX8Ov4sPsq5Rp9BTsbLibt/mKrYV7fNo9ClpVzvZeCqb7ukYWY1MC6V6gHQSAnK9u
         tbNG0+S+ZfXSYrdYIQWGERknH27Hv/UZLvpookTTW3vZxWWVx9bIB2yR38/rsSh4b07l
         ldfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:cc:references:to:subject
         :arc-authentication-results;
        bh=jOTQlXXZaVothf5DfucmTg1u9l4IpmCcVal7rvLUeMc=;
        b=p6QewBi43uvIxqF8TlHJLk+su7roKhtRk190unmonebKOOizl0G4/iX1M4X0IJ3PTH
         zKymj76LVUBvU5P5PqW4yM3+ndsXpb4Vm7jEruWeBGWnhHfRfYaCEUWSuEEM8uWHoowr
         f8nFF6LjVNnvkAgmvKiOrnuC7gEqTdPX3yAgo2ZjzsWy6k6RttHDuJg+simMLHFF51hK
         OSRiqXsWsb5dkrAiFl9LUmnX/lGReoQ+RTZr+Irp79Hfa+sObnVemIIy/qKPjMBI3edK
         Rg0nbBwEoQsFOJFChwRkCqCmbWu9MgDLy2SRdGQsNFCmTLX3NPUvAR4CXpWlFaXkjp6l
         Nl/Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of dave.hansen@intel.com designates 134.134.136.20 as permitted sender) smtp.mailfrom=dave.hansen@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of dave.hansen@intel.com designates 134.134.136.20 as permitted sender) smtp.mailfrom=dave.hansen@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,431,1515484800";
   d="scan'208";a="35015544"
Subject: Re: [PATCH 07/34] x86/entry/32: Restore segments before int registers
To: Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
References: <1520245563-8444-1-git-send-email-joro@8bytes.org>
 <1520245563-8444-8-git-send-email-joro@8bytes.org>
 <CA+55aFym-18UbD5K3n1Ki=mvpuLqa7E6E=qG0aE-dctzTap_WQ@mail.gmail.com>
 <20180305131231.GR16484@8bytes.org>
 <CA+55aFwn5EkHTfrUFww54CDWovoUornv6rSrao43agbLBQD6-Q@mail.gmail.com>
 <CAMzpN2hscOXJFzm07Hk=2Ttr3wQFSisxP=EZhRMtAU6xSm8zSw@mail.gmail.com>
 <CA+55aFwxiZ9bD2Zu5xV0idz_dDctPvrrWA2r54+NL4aj9oeN8Q@mail.gmail.com>
 <20180305213550.GV16484@8bytes.org>
 <CA+55aFx2dxZmL487CnhV6rWRiqmJwZNAspyPqCD4Hwqxwncs6Q@mail.gmail.com>
 <12c11262-5e0f-2987-0a74-3bde4b66c352@zytor.com>
 <20180306070437.kf3fkevqj6cuxptz@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, Brian Gerst <brgerst@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 the arch/x86 maintainers <x86@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-mm <linux-mm@kvack.org>, Andrew Lutomirski <luto@kernel.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?=
 <jgross@suse.com>, Peter Zijlstra <peterz@infradead.org>,
 Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 David Laight <David.Laight@aculab.com>, Denys Vlasenko
 <dvlasenk@redhat.com>, Eduardo Valentin <eduval@amazon.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Will Deacon <will.deacon@arm.com>, "Liguori, Anthony" <aliguori@amazon.com>,
 Daniel Gruss <daniel.gruss@iaik.tugraz.at>, Hugh Dickins <hughd@google.com>,
 Kees Cook <keescook@google.com>, Andrea Arcangeli <aarcange@redhat.com>,
 Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>,
 Joerg Roedel <jroedel@suse.de>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <6224cf9e-4c13-58e5-4541-c06074a20191@intel.com>
Date: Tue, 6 Mar 2018 05:45:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180306070437.kf3fkevqj6cuxptz@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594093021030252223?=
X-GMAIL-MSGID: =?utf-8?q?1594196187048541367?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/05/2018 11:04 PM, Ingo Molnar wrote:
> * H. Peter Anvin <hpa@zytor.com> wrote:
>> On NX-enabled hardware NX works with PDE, but the PDPDT in general doesn't
>> have permission bits (it's really more of a set of four CR3s than a page
>> table level.)
> The 4 PDPDT entries are also shadowed in the CPU and are only refreshed
> on CR3 loads, not spontaneously reloaded from memory during TLB walk
> like regular page table entries, right?

Yes.  The SDM even calls them non-architectural "PDPTE Registers" and
talks about them only being loaded at CR3 write time.

~5 years ago we even had a bug directly related to this feature:

> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/commit/?id=324cdc3f7e6a752fe0e95fa7b5c9664171a34ded
