Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522191234; cv=none;
        d=google.com; s=arc-20160816;
        b=G2UARNuI2lssdIy5mYKUSvpEzJ5iEa2ss98MzJeN0BF2AHBp1PF6qOMYO2NfRNrDm6
         XWguyGrmcJCGlBW8Sb2SlB1GXTBFJVWIxB4RagxawwIIIO5f8gHB64k0B29ci7p9v4zr
         u7QrJlMJAv2fqNEYf6Hyxu6kQaCY1TGXRT3HPWvVD8kYPXZ5x/hvUNh6Sz4mLkfp0y58
         rE+cxEbvJ7+kqLUk4QHFCYnk8JlqwtadmNnPVKyDj0D0VK4ndPlOyYjxR+zrYw11eOdi
         UQX9rgtcCIM/RmId30qp1skLi2oHDKUL2Mt5Gv47XcdhAIsY67ysFA66ANX0E8PYvpHR
         oKcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:sender:mime-version:dkim-signature
         :dkim-signature:arc-authentication-results;
        bh=loyG69wHNKT9MD8vZID5AEtRxaGQKi0SO0iiz6eKOM8=;
        b=NRDeaiJCwjfo9PxVtzFCRwsEitCEr4sex+l+05h1TkUVrb/OLVdKOO80UrOJ3MmAMu
         xUj7Bpo1QhZtkHts2DxP2FtrT8m4dpnhxAE2rSK8KxBQJ1NGsdsHSd59bn4SSUuT8Rwj
         InmkXyngs2hOjcV4XQePLiN2H9qojVVJZmKLk0aOGdyIw8c8Wke4CkUeK6CDAV2Gi2Uf
         UuLMYJTmtsDMXv8pW1n9jazKVNkYF3gNnDM2EoDrVmvlCF2rYB/ZSIw5Kktlx9+aLDf1
         6IaOrDDu8NzWDqrVUu+f3o5MLUPzLEqpMhxUi8gAQYRLosVYvlTH+2bXSCD/Xo05aNBy
         iVOw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=tVNFiWDG;
       dkim=pass header.i=@chromium.org header.s=google header.b=XXmu9+lJ;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=tVNFiWDG;
       dkim=pass header.i=@chromium.org header.s=google header.b=XXmu9+lJ;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AIpwx48PouASi+w3BYcLP4/4o2LBBa/BfdVGLPQILdIObxTm8V8k4beuyDA0Li8ZjcITo8QX4kLWHI62B5oMBhWckAg=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <0549F29C-12FC-4401-9E85-A430BC11DA78@gmail.com>
References: <1521736598-12812-1-git-send-email-blackzert@gmail.com>
 <20180323124806.GA5624@bombadil.infradead.org> <651E0DB6-4507-4DA1-AD46-9C26ED9792A8@gmail.com>
 <20180326084650.GC5652@dhcp22.suse.cz> <01A133F4-27DF-4AE2-80D6-B0368BF758CD@gmail.com>
 <20180327072432.GY5652@dhcp22.suse.cz> <0549F29C-12FC-4401-9E85-A430BC11DA78@gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 27 Mar 2018 15:53:53 -0700
X-Google-Sender-Auth: KTa7gMG05ILwOGyzGGVHG1c1Zfk
Message-ID: <CAGXu5j+XXufprMaJ9GbHxD3mZ7iqUuu60-tTMC6wo2x1puYzMQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/2] Randomization of address chosen by mmap.
To: Ilya Smith <blackzert@gmail.com>
Cc: Michal Hocko <mhocko@kernel.org>, Matthew Wilcox <willy@infradead.org>,
	Richard Henderson <rth@twiddle.net>, ink@jurassic.park.msu.ru, mattst88@gmail.com,
	Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@armlinux.org.uk>,
	Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
	Ralf Baechle <ralf@linux-mips.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>,
	Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
	"David S. Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>, nyc@holomorphy.com,
	Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
	Greg KH <gregkh@linuxfoundation.org>, Deepa Dinamani <deepa.kernel@gmail.com>,
	Hugh Dickins <hughd@google.com>, Kate Stewart <kstewart@linuxfoundation.org>,
	Philippe Ombredanne <pombredanne@nexb.com>, Andrew Morton <akpm@linux-foundation.org>,
	Steve Capper <steve.capper@arm.com>, Punit Agrawal <punit.agrawal@arm.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Nick Piggin <npiggin@gmail.com>,
	Bhupesh Sharma <bhsharma@redhat.com>, Rik van Riel <riel@redhat.com>, nitin.m.gupta@oracle.com,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jan Kara <jack@suse.cz>, Ross Zwisler <ross.zwisler@linux.intel.com>,
	Jerome Glisse <jglisse@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>,
	Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, linux-snps-arc@lists.infradead.org,
	linux-ia64@vger.kernel.org, linux-metag@vger.kernel.org,
	Linux MIPS Mailing List <linux-mips@linux-mips.org>, linux-parisc <linux-parisc@vger.kernel.org>,
	PowerPC <linuxppc-dev@lists.ozlabs.org>, linux-s390 <linux-s390@vger.kernel.org>,
	linux-sh <linux-sh@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>,
	Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595656488556903336?=
X-GMAIL-MSGID: =?utf-8?q?1596133196308747803?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 27, 2018 at 6:51 AM, Ilya Smith <blackzert@gmail.com> wrote:
>
>> On 27 Mar 2018, at 10:24, Michal Hocko <mhocko@kernel.org> wrote:
>>
>> On Mon 26-03-18 22:45:31, Ilya Smith wrote:
>>>
>>>> On 26 Mar 2018, at 11:46, Michal Hocko <mhocko@kernel.org> wrote:
>>>>
>>>> On Fri 23-03-18 20:55:49, Ilya Smith wrote:
>>>>>
>>>>>> On 23 Mar 2018, at 15:48, Matthew Wilcox <willy@infradead.org> wrote=
:
>>>>>>
>>>>>> On Thu, Mar 22, 2018 at 07:36:36PM +0300, Ilya Smith wrote:
>>>>>>> Current implementation doesn't randomize address returned by mmap.
>>>>>>> All the entropy ends with choosing mmap_base_addr at the process
>>>>>>> creation. After that mmap build very predictable layout of address
>>>>>>> space. It allows to bypass ASLR in many cases. This patch make
>>>>>>> randomization of address on any mmap call.
>>>>>>
>>>>>> Why should this be done in the kernel rather than libc?  libc is per=
fectly
>>>>>> capable of specifying random numbers in the first argument of mmap.
>>>>> Well, there is following reasons:
>>>>> 1. It should be done in any libc implementation, what is not possible=
 IMO;
>>>>
>>>> Is this really so helpful?
>>>
>>> Yes, ASLR is one of very important mitigation techniques which are real=
ly used
>>> to protect applications. If there is no ASLR, it is very easy to exploi=
t
>>> vulnerable application and compromise the system. We can=E2=80=99t just=
 fix all the
>>> vulnerabilities right now, thats why we have mitigations - techniques w=
hich are
>>> makes exploitation more hard or impossible in some cases.
>>>
>>> Thats why it is helpful.
>>
>> I am not questioning ASLR in general. I am asking whether we really need
>> per mmap ASLR in general. I can imagine that some environments want to
>> pay the additional price and other side effects, but considering this
>> can be achieved by libc, why to add more code to the kernel?
>
> I believe this is the only one right place for it. Adding these 200+ line=
s of
> code we give this feature for any user - on desktop, on server, on IoT de=
vice,
> on SCADA, etc. But if only glibc will implement =E2=80=98user-mode-aslr=
=E2=80=99 IoT and SCADA
> devices will never get it.

I agree: pushing this off to libc leaves a lot of things unprotected.
I think this should live in the kernel. The question I have is about
making it maintainable/readable/etc.

The state-of-the-art for ASLR is moving to finer granularity (over
just base-address offset), so I'd really like to see this supported in
the kernel. We'll be getting there for other things in the future, and
I'd like to have a working production example for researchers to
study, etc.

-Kees

--=20
Kees Cook
Pixel Security
