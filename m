Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB75CC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 20:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 605A2205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 20:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qqv2y+w3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 605A2205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbeJXE5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 00:57:25 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42651 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbeJXE5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 00:57:25 -0400
Received: by mail-pl1-f194.google.com with SMTP id t6-v6so1130881plo.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 13:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Sqwu3uUYXU3F5NlYmSk2kaKODXKl/OR2ZVajP01+Smw=;
        b=qqv2y+w3V2kk6aGD93QB+e2nJMv64fgsWzM7aD/mpR/byk9arX3Xxpa/jc3VLWroBs
         ut1ENnYda3LDz0KGv0FJCmuqO04DVM8ZwlIbBnNxHDH6J4oFRtFcJ/TdL1RS3gsaYGA0
         IQHhSp4oaF5WKfQZ3Q6w1GEujD3Wm9IBMsslhVeKkEzf/Rfom5l9Tmg3wOKY2zT+xUd6
         GVv6hRymzZ2mli28e7tXxZ4wOUR6jrBOEa185C9BpvdMrnDUHqq5GsDjw0UujMkF4u+X
         YwdaPeMbpgkmCQqoXFOA21GcxbpDb1X4/oYDkf0MRsQAL4rrkrb1FZWF2gXGuz/3ASYx
         qb8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Sqwu3uUYXU3F5NlYmSk2kaKODXKl/OR2ZVajP01+Smw=;
        b=mIfWSrP1agq8nftAIqII5zFMotEt3IB681Quq2aRjkdPIm9z4dyksnM1v5FXx5N6Pg
         cX1Bx3GMaOYeucsTD8xBrEsrxFbgcX5h+Ud+9apezYN70by6aHp7OGXBF3oQahhWMghH
         UPuCfM+JCE9ZJl1fIM1Ydr/56/9Rq0mfhQ51/Ktxmh2Op2Gh5/9JaFfZVwB0aYM0huUk
         BorFyFeUUo/xeN7dfBo5JM+ofDLGpFwWzA8jXUAIhCLD+Y83Ii+WYr5ZBCekf8eB/WN2
         oZGX2mrrn+QUhhOI6IF6lz0vW10bw5zf4ZF/YPWXNCuUBugmcc0jDmX/txNODZjz5ZjA
         oL6w==
X-Gm-Message-State: ABuFfoiSgmUgxspimGbLkNgGHMIb+03ELDOa2Osp2P5HxiAW8Q+rTy7w
        nt+vRm/sEcyNsRuQi4cIQe8=
X-Google-Smtp-Source: ACcGV62k7hOlIEexdEGN8Wa/3veWYYZeqny9ohx6ob5/EHA3cLU/cqI0dxS4Rs1Zm7Se/zVMvRBL/w==
X-Received: by 2002:a17:902:710e:: with SMTP id a14-v6mr51176212pll.179.1540326745006;
        Tue, 23 Oct 2018 13:32:25 -0700 (PDT)
Received: from [10.33.114.204] ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id u79-v6sm4628469pfd.117.2018.10.23.13.32.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 13:32:24 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [RFC PATCH 0/5] x86: dynamic indirect call promotion
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <7182c1db-2b23-5d69-7f4c-856a6ad43f8e@intel.com>
Date:   Tue, 23 Oct 2018 13:32:21 -0700
Cc:     Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>,
        David Woodhouse <dwmw@amazon.co.uk>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FBC2D350-E001-48C2-A4B7-0532FFD54531@gmail.com>
References: <20181018005420.82993-1-namit@vmware.com>
 <7182c1db-2b23-5d69-7f4c-856a6ad43f8e@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>, Nadav Amit <namit@vmware.com>,
        Ingo Molnar <mingo@redhat.com>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at 11:36 AM, Dave Hansen <dave.hansen@intel.com> wrote:

> On 10/17/18 5:54 PM, Nadav Amit wrote:
>> base		relpoline
>> 		----		---------
>> nginx 	22898 		25178 (+10%)
>> redis-ycsb	24523		25486 (+4%)
>> dbench	2144		2103 (+2%)
>=20
> Just out of curiosity, which indirect branches are the culprits here =
for
> causing the slowdowns?

So I didn=E2=80=99t try to measure exactly which one. There are roughly =
500 that
actually =E2=80=9Crun=E2=80=9D in my tests. Initially, I took the silly =
approach of trying
to patch the C source-code using semi automatically-generated Coccinelle
scripts, so I can tell you it is not just few branches but many. The
network stack is full of function pointers (e.g., tcp_congestion_ops,
tcp_sock_af_ops, dst_ops). The file-system also uses many function =
pointers
(file_operations specifically). Compound-pages have d=E2=80=99tor and so =
on.

If you want, you can rebuild the kernel without retpolines and run
=09
  perf record -e br_inst_exec.taken_indirect_near_call:k (your workload)

For some reason I didn=E2=80=99t manage to use PEBS (:ppp) from either =
the guest or
the host, so my results are a bit skewed (i.e., the sampled location is
usually after the call was taken). Running dbench in the VM gives me the
following =E2=80=9Chot-spots=E2=80=9D:

# Samples: 304  of event 'br_inst_exec.taken_indirect_near_call'
# Event count (approx.): 60800912
#
# Overhead  Command  Shared Object            Symbol                     =
                 =20
# ........  .......  .......................  =
.............................................
#
     5.26%  :197970  [guest.kernel.kallsyms]  [g] __fget_light
     4.28%  :197969  [guest.kernel.kallsyms]  [g] __fget_light
     3.95%  :197969  [guest.kernel.kallsyms]  [g] dcache_readdir
     3.29%  :197970  [guest.kernel.kallsyms]  [g] next_positive.isra.14
     2.96%  :197970  [guest.kernel.kallsyms]  [g] __do_sys_kill
     2.30%  :197970  [guest.kernel.kallsyms]  [g] apparmor_file_open
     1.97%  :197969  [guest.kernel.kallsyms]  [g] __do_sys_kill
     1.97%  :197969  [guest.kernel.kallsyms]  [g] next_positive.isra.14
     1.97%  :197970  [guest.kernel.kallsyms]  [g] _raw_spin_lock
     1.64%  :197969  [guest.kernel.kallsyms]  [g] __alloc_file
     1.64%  :197969  [guest.kernel.kallsyms]  [g] common_file_perm
     1.64%  :197969  [guest.kernel.kallsyms]  [g] filldir
     1.64%  :197970  [guest.kernel.kallsyms]  [g] do_dentry_open
     1.64%  :197970  [guest.kernel.kallsyms]  [g] kmem_cache_free
     1.32%  :197969  [guest.kernel.kallsyms]  [g] =
__raw_callee_save___pv_queued_spin_unlock
     1.32%  :197969  [guest.kernel.kallsyms]  [g] __slab_free

Regards,
Nadav=
