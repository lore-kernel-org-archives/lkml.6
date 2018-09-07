Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C96F5C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 23:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 643AA20844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 23:53:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 643AA20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbeIHEhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 00:37:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:46298 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725731AbeIHEhA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 00:37:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 614A9AEF1;
        Fri,  7 Sep 2018 23:53:35 +0000 (UTC)
Subject: Re: [PATCH] apparmor: Fix network performance issue in
 aa_label_sk_perm
To:     John Johansen <john.johansen@canonical.com>
Cc:     seth.arnold@canonical.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20180907043357.4638-1-tonyj@suse.de>
 <c7676cd4-6ffe-0c6d-8d77-3fd20d692254@canonical.com>
From:   Tony Jones <tonyj@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=tonyj@suse.de; prefer-encrypt=mutual; keydata=
 xsDiBEkQmbwRBACDch7wo/RzlNt2HA8jLICsO2w8yOkJ7UTzHYNn3Q83Ro0qev2KokfE3EDw
 il+vam9CDR7jIDmswHqaMe0/O+UnZtO5PlDgylZcrwNwbBzHfm/KGejbi1RBGAoETrvcfwGi
 w83bR/aDnoRXY5Ho1uphQ05/065EMpbJOOBdn9qQ4wCgv2Q6C/QeYDGsxJPRO+20nLu5K00D
 /Rde4OTZ5biM+vb6ObTmgPNeiMrTwGpMokN7audIl7njwvD+lYrlgQjmDzcaPFz29rYWwT7g
 6t6hcFgjpU1he/v3qxeQlTJoi2+u5Mqj42z//49h6DqNjT859Z/6h5IwKBo/EZC17iBIlS2G
 VXAstNiZASGiaIlONozWJ/GSjUaRA/9wZTV1nXF/+xX+qmc7SvTg1w6jWyjxVumQLoq2SeA4
 1Sy5X2IATkAGCCjbeoQGnFdbOnHRSJdlTazObgwreqGPlPnIROpr9QESkfxsaCkDiZfpl0xk
 6X069QMZBEwGAWILHYXL9UqlOjniZaU2BkVA11JEdBhyQorC8T/ji1edc81CQW50aG9ueSBO
 ZXZpbGxlIEpvbmVzIChmdWxsIGxlZ2FsIG5hbWUgb24gSUQpIDx0b255QHRvbnlqb25lcy5j
 b20+wmEEExECACEFAldtZNcCGwMFCwkIBwIGFQgJCgsCBBYCAwECHgECF4AACgkQsVhbIR/i
 Shd9PgCeMA43k9Ej5K/l8lVdE2niwBvJAoIAoI2EVzpZQZH5QDl+EFIhEP0lCnMPzsFNBEkQ
 mbwQCADOv1l3e/sHXQ4O1VztfFsx7dbqjUV0KUv1kiAu/rXOFZy1p8oMy78xRK/GZgWrTSl5
 wP9J9fyjECsDTb6xDYT79lvgns0BYgDEJ+bLtUTTAMGtkf+EFqkjH8uBWph9n1HD5rgVeuWT
 XLyhALCG+P6RaubtXuiVHRo87LU0UY1TJMVIyP6lubGI05d0LFVRB7dQTWT3ID6YguPJpFqf
 CSIIsKM29E8vzxDTXsF2FUFZmbPyqHBc39GuMJwMew9fk7R6/rwwvK6yHmZ+6S68KrNbVjdC
 X6LB/ATDmU2ZAZ2hX1yyDsk/uxoOJxIU7Ypxm8xu8Myq08WKl0XlRah9kpnfAAMFB/9vlxU3
 JvmLxAjQbsE8YE2fhWVBfmfrpOw8GetE06LcyFNNUQEKnyz6OpSMmNcSOMD47iEibtCp2yjO
 6vDsaVxDQDTp0jM7/VFSCVlkygLQkvjdlCYn7f7IWsuNaAYfp6/oA5tgsftm6OAAHmfQfLZk
 gKHOwospsem0W0G+kMoHy6l2r4a6exjig3fAZrruH2weoO+PKnrgLOCfwbm4YvDHd/951sQI
 rPmQ9RLMKESTey4rvjZIQ/TW/itrlZfzwefzU2MYHJAzP1pwkt0LsV8vNe9s1rQqC8NpKWVh
 +wkigYLPd4pU65NZc6JoQgq7Lzff7eavY+6UsLIsrKwAR10qwkkEGBECAAkFAkkQmbwCGwwA
 CgkQsVhbIR/iSheGBACfUQYBMtk9LncC3236ndLwGQ0j3JEAn0DQ6YuWK/6vAR6xgaUZ4Y1o odMn
Message-ID: <6d1908de-aa62-dc63-cc60-8883358d257c@suse.de>
Date:   Fri, 7 Sep 2018 16:53:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <c7676cd4-6ffe-0c6d-8d77-3fd20d692254@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/2018 09:37 AM, John Johansen wrote:

> hey Tony,
> 
> thanks for the patch, I am curious did you're investigation look
> into what parts of DEFINE_AUDIT_SK are causing the issue?

Hi JJ.

Attached are the perf annotations for DEFINE_AUDIT_SK (percentages are relative to the fn).   
Our kernel performance testing is carried out with default installs which means AppArmor 
is enabled but the performance tests are unconfined. It was obvious that the overhead of 
DEFINE_AUDIT_SK was significant for smaller packet sizes (typical of synthetic benchmarks) 
and that it didn't need to execute for the unconfined case,  hence the patch.  I didn't 
spend any time looking at the performance of confined tasks.  It may be worth your time to 
look at this.

Comparing my current tip (2601dd392dd1) to tip+patch I'm seeing an increase of 3-6% in netperf
throughput for packet sizes 64-1024.

HTH

Tony

 Percent |	Source code & Disassembly of vmlinux for cycles:ppp (117 samples)
---------------------------------------------------------------------------------
         :
         :
         :
         :                      Disassembly of section .text:
         :
         :                      ffffffff813fbec0 <aa_label_sk_perm>:
         :                      aa_label_sk_perm():
         :                                                                 type));
         :                      }
         :
         :                      static int aa_label_sk_perm(struct aa_label *label, const char *op, u32 request,
         :                                                  struct sock *sk)
         :                      {
    0.00 :   ffffffff813fbec0:       callq  ffffffff81a017f0 <__fentry__>
    2.56 :   ffffffff813fbec5:       push   %r14
    0.00 :   ffffffff813fbec7:       mov    %rcx,%r14
         :                              struct aa_profile *profile;
         :                              DEFINE_AUDIT_SK(sa, op, sk);
    0.00 :   ffffffff813fbeca:       mov    $0x7,%ecx
         :                      {
    0.00 :   ffffffff813fbecf:       push   %r13
    3.42 :   ffffffff813fbed1:       mov    %edx,%r13d
    0.00 :   ffffffff813fbed4:       push   %r12
    0.00 :   ffffffff813fbed6:       push   %rbp
    0.00 :   ffffffff813fbed7:       mov    %rdi,%rbp
    5.13 :   ffffffff813fbeda:       push   %rbx
    0.00 :   ffffffff813fbedb:       sub    $0xb8,%rsp
         :                              DEFINE_AUDIT_SK(sa, op, sk);
    0.00 :   ffffffff813fbee2:       movzwl 0x10(%r14),%r9d
         :                      {
    1.71 :   ffffffff813fbee7:       mov    %gs:0x28,%rax
    0.00 :   ffffffff813fbef0:       mov    %rax,0xb0(%rsp)
    0.00 :   ffffffff813fbef8:       xor    %eax,%eax
         :                              DEFINE_AUDIT_SK(sa, op, sk);
    0.00 :   ffffffff813fbefa:       lea    0x78(%rsp),%rdx
    1.71 :   ffffffff813fbeff:       lea    0x20(%rsp),%r8
    0.00 :   ffffffff813fbf04:       movq   $0x0,(%rsp)
    0.00 :   ffffffff813fbf0c:       movq   $0x0,0x10(%rsp)
    0.00 :   ffffffff813fbf15:       mov    %rdx,%rdi
   14.53 :   ffffffff813fbf18:       rep stos %rax,%es:(%rdi)
    1.71 :   ffffffff813fbf1b:       mov    $0xb,%ecx
    0.00 :   ffffffff813fbf20:       mov    %r8,%rdi
    0.00 :   ffffffff813fbf23:       mov    %r14,0x80(%rsp)
   18.80 :   ffffffff813fbf2b:       rep stos %rax,%es:(%rdi)
    0.00 :   ffffffff813fbf2e:       mov    %rsi,0x28(%rsp)
    1.71 :   ffffffff813fbf33:       mov    %r9w,0x88(%rsp)
    0.00 :   ffffffff813fbf3c:       cmp    $0x1,%r9w
    0.00 :   ffffffff813fbf41:       je     ffffffff813fbfa1 <aa_label_sk_perm+0xe1>
    0.00 :   ffffffff813fbf43:       mov    $0x2,%eax
    0.00 :   ffffffff813fbf48:       test   %r14,%r14
    0.00 :   ffffffff813fbf4b:       je     ffffffff813fbfa1 <aa_label_sk_perm+0xe1>
   14.53 :   ffffffff813fbf4d:       mov    %al,(%rsp)
    0.00 :   ffffffff813fbf50:       movzwl 0x1ea(%r14),%eax
         :                              AA_BUG(!sk);
         :
         :                              if (unconfined(label))
         :                                      return 0;
         :
         :                              return fn_for_each_confined(label, profile,
    0.00 :   ffffffff813fbf58:       xor    %r12d,%r12d
         :                              DEFINE_AUDIT_SK(sa, op, sk);
    0.00 :   ffffffff813fbf5b:       mov    %r8,0x18(%rsp)
    8.55 :   ffffffff813fbf60:       mov    %eax,0x58(%rsp)
    0.00 :   ffffffff813fbf64:       movzbl 0x1e9(%r14),%eax
    0.00 :   ffffffff813fbf6c:       mov    %rdx,0x8(%rsp)
    0.00 :   ffffffff813fbf71:       mov    %eax,0x5c(%rsp)
         :                              if (unconfined(label))
    8.55 :   ffffffff813fbf75:       testb  $0x2,0x40(%rbp)
    0.00 :   ffffffff813fbf79:       je     ffffffff813fbfa8 <aa_label_sk_perm+0xe8>
         :                                              aa_profile_af_sk_perm(profile, &sa, request, sk));
         :                      }
    0.00 :   ffffffff813fbf7b:       mov    0xb0(%rsp),%rdx
    0.00 :   ffffffff813fbf83:       xor    %gs:0x28,%rdx
    4.27 :   ffffffff813fbf8c:       mov    %r12d,%eax
    0.00 :   ffffffff813fbf8f:       jne    ffffffff813fbfe5 <aa_label_sk_perm+0x125>
    0.00 :   ffffffff813fbf91:       add    $0xb8,%rsp
    0.00 :   ffffffff813fbf98:       pop    %rbx
    5.13 :   ffffffff813fbf99:       pop    %rbp
    0.00 :   ffffffff813fbf9a:       pop    %r12
    0.00 :   ffffffff813fbf9c:       pop    %r13
    0.00 :   ffffffff813fbf9e:       pop    %r14
    7.69 :   ffffffff813fbfa0:       retq
         :                              DEFINE_AUDIT_SK(sa, op, sk);
    0.00 :   ffffffff813fbfa1:       mov    $0x7,%eax
    0.00 :   ffffffff813fbfa6:       jmp    ffffffff813fbf4d <aa_label_sk_perm+0x8d>
         :                              return fn_for_each_confined(label, profile,
    0.00 :   ffffffff813fbfa8:       xor    %esi,%esi
    0.00 :   ffffffff813fbfaa:       jmp    ffffffff813fbfcd <aa_label_sk_perm+0x10d>
         :                      aa_profile_af_sk_perm():
         :                      static inline int aa_profile_af_sk_perm(struct aa_profile *profile,
         :                                                              struct common_audit_data *sa,
         :                                                              u32 request,
         :                                                              struct sock *sk)
         :                      {
         :                              return aa_profile_af_perm(profile, sa, request, sk->sk_family,
    0.00 :   ffffffff813fbfac:       movzwl 0x10(%r14),%ecx
    0.00 :   ffffffff813fbfb1:       movzwl 0x1ea(%r14),%r8d
    0.00 :   ffffffff813fbfb9:       mov    %rsp,%rsi
    0.00 :   ffffffff813fbfbc:       mov    %r13d,%edx
    0.00 :   ffffffff813fbfbf:       callq  ffffffff813fbdf0 <aa_profile_af_perm>
         :                      aa_label_sk_perm():
    0.00 :   ffffffff813fbfc4:       lea    0x1(%rbx),%esi
    0.00 :   ffffffff813fbfc7:       test   %eax,%eax
    0.00 :   ffffffff813fbfc9:       cmovne %eax,%r12d
    0.00 :   ffffffff813fbfcd:       mov    %rbp,%rdi
    0.00 :   ffffffff813fbfd0:       callq  ffffffff813f7310 <aa_label_next_confined>
    0.00 :   ffffffff813fbfd5:       mov    %eax,%ebx
    0.00 :   ffffffff813fbfd7:       cltq
    0.00 :   ffffffff813fbfd9:       mov    0x50(%rbp,%rax,8),%rdi
    0.00 :   ffffffff813fbfde:       test   %rdi,%rdi
    0.00 :   ffffffff813fbfe1:       jne    ffffffff813fbfac <aa_label_sk_perm+0xec>
    0.00 :   ffffffff813fbfe3:       jmp    ffffffff813fbf7b <aa_label_sk_perm+0xbb>
         :                      }
    0.00 :   ffffffff813fbfe5:       callq  ffffffff81090d60 <__stack_chk_fail>
