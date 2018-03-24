Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751733AbeCXIJy (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 04:09:54 -0400
Received: from mail-wr0-f176.google.com ([209.85.128.176]:41661 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750797AbeCXIJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 04:09:50 -0400
X-Google-Smtp-Source: AG47ELsjn6Ji/+ONxbFMelf8yIGx5P4FYHMdQKEHJBNqiQYMY1G/83yXw2wgDEtpyDwMYaCSYW/85Q==
Date: Sat, 24 Mar 2018 09:09:46 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: x86 <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Hugh Dickins <hughd@google.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH v3 1/2] x86, msr: allow rdmsr_safe_on_cpu() to schedule
Message-ID: <20180324080946.3db4xdkl5i6jx2rc@gmail.com>
References: <20180323215818.127774-1-edumazet@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180323215818.127774-1-edumazet@google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Eric Dumazet <edumazet@google.com> wrote:

> I noticed high latencies caused by a daemon periodically reading
> various MSR on all cpus. KASAN kernels would see ~10ms latencies
> simply reading one MSR. Even without KASAN, sending IPI to CPU
> in deep sleep state or blocking hard IRQ in a a long section,
> then waiting for the answer can consume hundreds of usec.
> 
> Converts rdmsr_safe_on_cpu() to use a completion instead
> of busy polling.
> 
> Overall daemon cpu usage was reduced by 35 %,
> and latencies caused by msr_read() disappeared.

What "daemon" is this and why is it reading MSRs?

Thanks,

	Ingo
