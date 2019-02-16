Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA53CC10F00
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 16:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89BE0222D0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 16:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731582AbfBPQze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 11:55:34 -0500
Received: from mout.gmx.net ([212.227.15.19]:49253 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730824AbfBPQzd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 11:55:33 -0500
Received: from [192.168.20.60] ([92.116.187.158]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LhOSG-1hQ2Sz47ua-00maae; Sat, 16
 Feb 2019 17:55:26 +0100
Subject: Re: [PATCH v2] parisc: Fix ptrace syscall number modification
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190216024623.GA11910@altlinux.org>
 <20190216131039.GA18767@altlinux.org>
From:   Helge Deller <deller@gmx.de>
Openpgp: preference=signencrypt
Autocrypt: addr=deller@gmx.de; keydata=
 xsBNBFDPIPYBCAC6PdtagIE06GASPWQJtfXiIzvpBaaNbAGgmd3Iv7x+3g039EV7/zJ1do/a
 y9jNEDn29j0/jyd0A9zMzWEmNO4JRwkMd5Z0h6APvlm2D8XhI94r/8stwroXOQ8yBpBcP0yX
 +sqRm2UXgoYWL0KEGbL4XwzpDCCapt+kmarND12oFj30M1xhTjuFe0hkhyNHkLe8g6MC0xNg
 KW3x7B74Rk829TTAtj03KP7oA+dqsp5hPlt/hZO0Lr0kSAxf3kxtaNA7+Z0LLiBqZ1nUerBh
 OdiCasCF82vQ4/y8rUaKotXqdhGwD76YZry9AQ9p6ccqKaYEzWis078Wsj7p0UtHoYDbABEB
 AAHNHEhlbGdlIERlbGxlciA8ZGVsbGVyQGdteC5kZT7CwJIEEwECADwCGwMGCwkIBwMCBhUI
 AgkKCwQWAgMBAh4BAheAFiEE9M/0wAvkPPtRU6Boh8nBUbUeOGQFAlrHzIICGQEACgkQh8nB
 UbUeOGT1GAgAt+EeoHB4DbAx+pZoGbBYp6ZY8L6211n8fSi7wiwgM5VppucJ+C+wILoPkqiU
 +ZHKlcWRbttER2oBUvKOt0+yDfAGcoZwHS0P+iO3HtxR81h3bosOCwek+TofDXl+TH/WSQJa
 iaitof6iiPZLygzUmmW+aLSSeIAHBunpBetRpFiep1e5zujCglKagsW78Pq0DnzbWugGe26A
 288JcK2W939bT1lZc22D9NhXXRHfX2QdDdrCQY7UsI6g/dAm1d2ldeFlGleqPMdaaQMcv5+E
 vDOur20qjTlenjnR/TFm9tA1zV+K7ePh+JfwKc6BSbELK4EHv8J8WQJjfTphakYLVM7ATQRQ
 zyD2AQgA2SJJapaLvCKdz83MHiTMbyk8yj2AHsuuXdmB30LzEQXjT3JEqj1mpvcEjXrX1B3h
 +0nLUHPI2Q4XWRazrzsseNMGYqfVIhLsK6zT3URPkEAp7R1JxoSiLoh4qOBdJH6AJHex4CWu
 UaSXX5HLqxKl1sq1tO8rq2+hFxY63zbWINvgT0FUEME27Uik9A5t8l9/dmF0CdxKdmrOvGMw
 T770cTt76xUryzM3fAyjtOEVEglkFtVQNM/BN/dnq4jDE5fikLLs8eaJwsWG9k9wQUMtmLpL
 gRXeFPRRK+IT48xuG8rK0g2NOD8aW5ThTkF4apznZe74M7OWr/VbuZbYW443QQARAQABwsBf
 BBgBAgAJBQJQzyD2AhsMAAoJEIfJwVG1HjhkNTgH/idWz2WjLE8DvTi7LvfybzvnXyx6rWUs
 91tXUdCzLuOtjqWVsqBtSaZynfhAjlbqRlrFZQ8i8jRyJY1IwqgvHP6PO9s+rIxKlfFQtqhl
 kR1KUdhNGtiI90sTpi4aeXVsOyG3572KV3dKeFe47ALU6xE5ZL5U2LGhgQkbjr44I3EhPWc/
 lJ/MgLOPkfIUgjRXt0ZcZEN6pAMPU95+u1N52hmqAOQZvyoyUOJFH1siBMAFRbhgWyv+YE2Y
 ZkAyVDL2WxAedQgD/YCCJ+16yXlGYGNAKlvp07SimS6vBEIXk/3h5Vq4Hwgg0Z8+FRGtYZyD
 KrhlU0uMP9QTB5WAUvxvGy8=
Message-ID: <c41a211b-6f61-b2a5-0613-32df52bfd367@gmx.de>
Date:   Sat, 16 Feb 2019 17:55:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190216131039.GA18767@altlinux.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:iMlFsdHHpfuJyvIjVYjDqacKjzSplTk1lpgxm3pU0IULQ5Vkf4a
 Nay5N2P8SjCfZIJuFe5cH99FAsiEzblnBjznJcUnXQQd3ITtUgCLt9D3RMlLdOZSiggA2pS
 knnX0KzmaljRywGi7x/tz3NtvmlBBJzJAP+fzIpGi2RBKfHYnO8Gk9WArogxsi/NN761RlF
 qERqU8OqGW9JkfyuIDaAw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OB4CBpMQNLA=:+CIe81ztbZjCO4O4exGWvZ
 3I4wiBI75ROs2jVLBWNBj2jnSIm3RxPemisZ4wt+yJdpLRZ3hBA3NZLH2WJK061SRIghv28lL
 LdLRAnjhCVZ6T62s5IUDpZJznCCH+s+bTgzmV/IRGz2kpnx5nVLp8nUlGzXAFALdycA3Ts/zX
 aQS38lKyRAFsVpOmjlk3yDfOaAfasZC6YKbjqtmkCnGt7eFRJb9NmTjQnrrQsQCmfMfduSXke
 5o5QCp9iaIt4NgEf1NPt0pxdk4Lt5VUqHS+IjNKZJ+V9pCf+ND1JdD1odme4AXwxop9+cIc3n
 KH00ZFzhJ4VSrzg9/HLwoNaBKSrC3sW0ZA0M2ebwkSbgmv5CizEzHJJNCvUFDFt93dtUFVhX1
 /4IuEsMQ0OfiqNjKzCxHLsQ6qTKQFlM10/A91H6XmkZAbbWc9biRStjLD4hAhzhe+cwgfLzmB
 F2W4C9nlU2A4Z68fm7jhJmMwFCUJOGcEJBkcnK8VqhUpC+4n3zn0ypl1saCyxDdur37g+U8g/
 GbUxc9eWyRY/9z9Caqi0UW3V1Mrbe3rRaTVVDe4dCQY2xnjLpBn9QikPFMr4+pbyFIudJd9mo
 QEwsSpeQ1BFcYVsybeVFd3Wz49JlNs9KVj6gxyxZq4RuAGa6daUJzkMJHhaIPhXqUml3jK6GB
 cTVVgNLRspMNHMzr9ahy+topiihpEqXJeIjzjU/4pe9oJbbG49IBizSoX0sjrxbMNkanTYsSx
 iSM9T+IhYKKmxTQ92wkK+QUw6wI7u+PDHKK9KhcLG8jBwDNNrx9XX6iWh27pqKRPmYtgN3fUA
 GN5j90DpFcPge0K9ByRz4Wns2Zc8Q3K0JleQmwoc4i2t/KiPKuhHb5eMjGdK1H4dTprwk7gsa
 nqyu/XJyVrVeGkzVYG0XbKKTNBZ2ILvFbsycU9qvbbWPm5MYZQDcvTqMKc3gvF
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.02.19 14:10, Dmitry V. Levin wrote:
> Commit 910cd32e552e ("parisc: Fix and enable seccomp filter support")
> introduced a regression in ptrace-based syscall tampering: when tracer
> changes syscall number to -1, the kernel fails to initialize %r28 with
> -ENOSYS and subsequently fails to return the error code of the failed
> syscall to userspace.
> 
> This erroneous behaviour could be observed with a simple strace syscall
> fault injection command which is expected to print something like this:
> 
> $ strace -a0 -ewrite -einject=write:error=enospc echo hello
> write(1, "hello\n", 6) = -1 ENOSPC (No space left on device) (INJECTED)
> write(2, "echo: ", 6) = -1 ENOSPC (No space left on device) (INJECTED)
> write(2, "write error", 11) = -1 ENOSPC (No space left on device) (INJECTED)
> write(2, "\n", 1) = -1 ENOSPC (No space left on device) (INJECTED)
> +++ exited with 1 +++
> 
> After commit 910cd32e552ea09caa89cdbe328e468979b030dd it loops printing
> something like this instead:
> 
> write(1, "hello\n", 6../strace: Failed to tamper with process 12345: unexpectedly got no error (return value 0, error 0)
> ) = 0 (INJECTED)
> 
> This bug was found by strace test suite.
> 
> Fixes: 910cd32e552e ("parisc: Fix and enable seccomp filter support")
> Cc: stable@vger.kernel.org # v4.5+
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>

Thanks, the patch works as expected.
You may add:
Tested-by: Helge Deller <deller@gmx.de>

There is an "out" label a few lines below, which should be removed as well.
Otherwise you get this warning:
arch/parisc/kernel/ptrace.c: In function ‘do_syscall_trace_enter’:
arch/parisc/kernel/ptrace.c:357:1: warning: label ‘out’ defined but not used [-Wunused-label]

I've fixed it up locally and added the patch to my for-next tree.
If it's ok for you, I'll push it through the parisc tree.

Helge

> ---
> 
>  v2: Updated comments.
>      Set gr[28] to -ENOSYS after tracehook_report_syscall_entry() invocation
>      because setting of syscall return code by tracer on entering syscall
>      shall not affect the syscall return code.
> 
>  N.B. I have no parisc box to test the patch.
> 
>  arch/parisc/kernel/ptrace.c | 28 +++++++++++++++++++++-------
>  1 file changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/parisc/kernel/ptrace.c b/arch/parisc/kernel/ptrace.c
> index 2582df1c529b..be4d6a279b12 100644
> --- a/arch/parisc/kernel/ptrace.c
> +++ b/arch/parisc/kernel/ptrace.c
> @@ -308,15 +308,29 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
>  
>  long do_syscall_trace_enter(struct pt_regs *regs)
>  {
> -	if (test_thread_flag(TIF_SYSCALL_TRACE) &&
> -	    tracehook_report_syscall_entry(regs)) {
> +	if (test_thread_flag(TIF_SYSCALL_TRACE)) {
> +		int rc = tracehook_report_syscall_entry(regs);
> +
>  		/*
> -		 * Tracing decided this syscall should not happen or the
> -		 * debugger stored an invalid system call number. Skip
> -		 * the system call and the system call restart handling.
> +		 * As tracesys_next does not set %r28 to -ENOSYS
> +		 * when %r20 is set to -1, initialize it here.
>  		 */
> -		regs->gr[20] = -1UL;
> -		goto out;
> +		regs->gr[28] = -ENOSYS;
> +
> +		if (rc) {
> +			/*
> +			 * A nonzero return code from
> +			 * tracehook_report_syscall_entry() tells us
> +			 * to prevent the syscall execution.  Skip
> +			 * the syscall call and the syscall restart handling.
> +			 *
> +			 * Note that the tracer may also just change
> +			 * regs->gr[20] to an invalid syscall number,
> +			 * that is handled by tracesys_next.
> +			 */
> +			regs->gr[20] = -1UL;
> +			return -1;
> +		}
>  	}
>  
>  	/* Do the secure computing check after ptrace. */
> 

