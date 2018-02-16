Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753029AbeBPAZg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 19:25:36 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:37111 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752910AbeBPAZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 19:25:35 -0500
X-Google-Smtp-Source: AH8x224gbM5cFYKxyUhTuRVfMHdVc9zAZPmJauCqER2hPGFJYth8g6O9OaTbxI0Mg/faMAB5NROjHQ==
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH RFC v2 0/6] x86: Disabling PTI in compatibility mode
From: Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <27a0082c-fadb-792a-740e-70932d51f1b5@linux.intel.com>
Date: Thu, 15 Feb 2018 16:25:32 -0800
Cc: Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Willy Tarreau <w@1wt.eu>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Message-Id: <91CEEFA7-86C8-4731-BC7E-6AF5CC3A1BA4@gmail.com>
References: <20180215163602.61162-1-namit@vmware.com>
 <27a0082c-fadb-792a-740e-70932d51f1b5@linux.intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1G0PebG027802

Dave Hansen <dave.hansen@linux.intel.com> wrote:

> On 02/15/2018 08:35 AM, Nadav Amit wrote:
>> I removed the PTI disabling while SMEP is unsupported, although I
>> must admit I did not fully understand why it is required.
> 
> Do you mean you don't fully understand how PTI gives SMEP-like behavior
> on non-SMEP hardware?

No. I understand how it provide SMEP-like behavior, and I understand the value
of SMEP by itself.

However, I do not understand why SMEP-like protection is required to protect
processes that run in compatibility-mode from Meltdown/Spectre attacks. As
far as I understand, the process should not be able to manipulate the kernel
to execute code in the low 4GB.
