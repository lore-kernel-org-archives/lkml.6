Return-Path: <amc96@hermes.cam.ac.uk>
X-Google-Smtp-Source: AH8x2263WVefQkTCQws09pa+gI1qrcPTxXkU3PDsEG1EcT+e7ppsZM3gYqXjeSan4WPh8f9miDZO
ARC-Seal: i=1; a=rsa-sha256; t=1518211695; cv=none;
        d=google.com; s=arc-20160816;
        b=c8ZnXBGR0gPPDTgW2ABJASeV+267M3vWi4sxcEAo5pqR59E3pZu0Dzz3YoCEj+Dykv
         CNgHRr3UY73mNSoNNj5Zmpr3bxB9z8lV1RlEB4yMp4f3QV+XTbyD+mrycUM6CZDeFdW8
         AJVyD6j1lF1J0tr7CyDcArtzbImwDlbix7O6KGly77tU0m4MAlxbIGtRQ7aOPu8/rDJA
         mYpavixSunLYONbffwNs7Yy/dAaJtVUhSS11lYv9U0cL+twGVfLy+QOm17VcOYghOAzR
         gOZq/kkstHg2xMtCpVgk3ZfhMqEJRlal6+N+7eYV1wMMy1aWRxgmO4pyrpwzcQ7pWJ/O
         FPlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=sender:content-language:content-transfer-encoding:in-reply-to
         :mime-version:user-agent:date:message-id:from:references:cc:to
         :subject:arc-authentication-results;
        bh=ajg1E7vi4ULo4GX98hQJSJgodv/4iaVvuJgVjc5m9DY=;
        b=MD+SkMHfZbmJxO8TMJGqp6z84oKDFSE3PsD0JnwhI2W36b7Fs5iOOvzGwQjsqRShZC
         ytcNdxWKrNZdf1tcx9lxBzW6O7c1rg2ii1t9wF07k3zefHXdKBPDne/hiASHszkv1js9
         2bOcU2GmsfsLWYiwaiY/tXs8qVq2bM/GEdfBZDoHyXLBggWRe36rF86Q1jtSwxZmvDBa
         PUbgW8PMQN0SMQK4LIZ8Wm5E+RMHAKBp+kg+Qjpj6xfuXGHHkOIXHuQ17tkzeMRb9XqG
         a+1xcQhqh0OCe3TId4bvirKK8rqsr9fyDrQx/RjjQ3VlTnXTimIh0rppJbzU5DuLrp97
         pYDg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of amc96@hermes.cam.ac.uk designates 131.111.8.130 as permitted sender) smtp.mailfrom=amc96@hermes.cam.ac.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of amc96@hermes.cam.ac.uk designates 131.111.8.130 as permitted sender) smtp.mailfrom=amc96@hermes.cam.ac.uk
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://help.uis.cam.ac.uk/email-scanner-virus
Subject: Re: [PATCH 00/31 v2] PTI support for x86_32
To: Pavel Machek <pavel@ucw.cz>, Andy Lutomirski <luto@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
 X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux-MM <linux-mm@kvack.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Dave Hansen <dave.hansen@intel.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Juergen Gross <jgross@suse.com>,
 Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>,
 Jiri Kosina <jkosina@suse.cz>, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Brian Gerst <brgerst@gmail.com>, David Laight <David.Laight@aculab.com>,
 Denys Vlasenko <dvlasenk@redhat.com>, Eduardo Valentin <eduval@amazon.com>,
 Greg KH <gregkh@linuxfoundation.org>, Will Deacon <will.deacon@arm.com>,
 "Liguori, Anthony" <aliguori@amazon.com>,
 Daniel Gruss <daniel.gruss@iaik.tugraz.at>, Hugh Dickins <hughd@google.com>,
 Kees Cook <keescook@google.com>, Andrea Arcangeli <aarcange@redhat.com>,
 Waiman Long <llong@redhat.com>, Joerg Roedel <jroedel@suse.de>
References: <1518168340-9392-1-git-send-email-joro@8bytes.org>
 <CALCETrUF61fqjXKG=kwf83JWpw=kgL16UvKowezDVwVA1=YVAw@mail.gmail.com>
 <20180209210918.GA7333@amd>
From: Andrew Cooper <andrew.cooper3@citrix.com>
Message-ID: <a5e37af1-cfa3-1284-cb1c-3912c30505e3@citrix.com>
Date: Fri, 9 Feb 2018 21:28:08 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180209210918.GA7333@amd>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: Andrew Cooper <amc96@hermes.cam.ac.uk>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591914900490843452?=
X-GMAIL-MSGID: =?utf-8?q?1591960346680424191?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 09/02/2018 21:09, Pavel Machek wrote:
> On Fri 2018-02-09 17:47:43, Andy Lutomirski wrote:
>> PCID bit set in CPUID should print a big fat warning like "WARNING:
>> you are using 32-bit PTI on a 64-bit PCID-capable CPU.  Your
>> performance will increase dramatically if you switch to a 64-bit
>> kernel."
> Hardware supports PCID even on 32-bit kernels, no?

Attempting to set CR4.PCIDE is disallowed outside of long mode.  It is
strictly a 64bit-only feature.

~Andrew
