Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756860AbeBPAs2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 19:48:28 -0500
Received: from mail-pg0-f50.google.com ([74.125.83.50]:44292 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756845AbeBPAs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 19:48:26 -0500
X-Google-Smtp-Source: AH8x2249WUR7Due4zMwyo859E2YilM3bSoX1kJ12F8X/yabHV/RuaF7faE6j6e+zLVlqgTx5cjYTAQ==
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH RFC v2 0/6] x86: Disabling PTI in compatibility mode
From: Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <9a825978-fe69-1c10-0da0-0c67dbb9b232@linux.intel.com>
Date: Thu, 15 Feb 2018 16:48:23 -0800
Cc: Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Willy Tarreau <w@1wt.eu>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Message-Id: <2A2A000F-D39E-40A6-8C01-58344F1034DD@gmail.com>
References: <20180215163602.61162-1-namit@vmware.com>
 <27a0082c-fadb-792a-740e-70932d51f1b5@linux.intel.com>
 <91CEEFA7-86C8-4731-BC7E-6AF5CC3A1BA4@gmail.com>
 <9a825978-fe69-1c10-0da0-0c67dbb9b232@linux.intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1G0mWlm000996

Dave Hansen <dave.hansen@linux.intel.com> wrote:

> On 02/15/2018 04:25 PM, Nadav Amit wrote:
>> Dave Hansen <dave.hansen@linux.intel.com> wrote:
>> 
>>> On 02/15/2018 08:35 AM, Nadav Amit wrote:
>>>> I removed the PTI disabling while SMEP is unsupported, although I
>>>> must admit I did not fully understand why it is required.
>>> 
>>> Do you mean you don't fully understand how PTI gives SMEP-like behavior
>>> on non-SMEP hardware?
>> 
>> No. I understand how it provide SMEP-like behavior, and I understand the value
>> of SMEP by itself.
>> 
>> However, I do not understand why SMEP-like protection is required to protect
>> processes that run in compatibility-mode from Meltdown/Spectre attacks. As
>> far as I understand, the process should not be able to manipulate the kernel
>> to execute code in the low 4GB.
> 
> There are two problems: one is that regardless of Meltdown/Spectre, SMEP
> is valuable.  It's valuable to everything, compatibility-mode or not.
> 
> The second problem is the RSB.  It has a full-width virtual address and,
> unlike the other indirect branch prediction, can steer you anywhere
> including to the low 4GB.

Thanks for the explanation. Based on Linus response, I guess this series is
nak’d, but still thanks for your patience.

I suspected the RSB might be the reason but it seemed to me that all the ROP
opportunities are still there, so I assumed it is not a reason.

Anyhow, thanks again.
