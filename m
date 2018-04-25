Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-650796-1524658322-2-17981494636452384638
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES daen, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524658322; b=eTp1nt/U/N8rDAM0BnAJHRXVbZSTSFpc4ZWUWZB6lh1KUHOQSa
    u7JvG11zwnJXFPsbzV1ABkTgfeCzqCN1w7Zt7FW7ZO9ff6cTUf3l+ddjk/YMQAHT
    JI5YfbpHK1BpaywcX3Q3M/IOTwb1aI4UyMoCqGXFJTBECNFL7bsNLbDq1gtGztSt
    XzYzH0JKPt3AyWCw4IZkttwNd3A2q2Tj3S95EVzggiPslpnqs24sUde3dZdoLIcc
    KOLRSV0LvrLENeSFPDgj+LEaXL47Jg8yqZxgG4Tk1sP80RISPi8Ij9LAC3KueAhi
    Nr33j5P/4EVxcxcXJItV4TiifL//4w65zOqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1524658322; bh=G1MKKqhD2SOlJISW7htB6IUrf3Ik+nwfeQKJQuo7o/
    M=; b=BjCFOo74nD4LYAa7O1/T1O3N+M/FwhKVFisIrQn3Bp9yuBSEfJCwGHFB3q
    PZwAlNc8eWZbiUWfVG+B3RrGYByHV6Jtw9h5qUI5b8Rele4WGntJmptc1CnVQJ3y
    O89mddht/Ml0Qw2TnqzDPGW8pnT04UgzSSF7AEagOkT0KkFKCLWIp2+ae2ITAleY
    TpIgXTAyE6238xVxJUF2UX6/nkpAohHRIsO+tSDZbMEg32xgMfvBd9UpU5WnCXFq
    rXHPTC63d+rDs6TjJ00ZPvsaeTM17bq4qERu4RppgZjMaB6P2LJYKeI79fX1rxkd
    hRLtQwmX1jFivkHcJdIKKHadRLVA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=DelT+UNv x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=JykYrp0H;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=DelT+UNv x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=JykYrp0H;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKj4QQvuNMLh3dTMPI9upE2MsBOX4tVBnzV9+U/qfST/VaqenBN2TQMke1tJMoPHhdIr5VQUmL7omOn/LAc2QiKt4Ha5W3unItxYd6WAvW6xF5fypYBk
    nlaOl9FefZFBUOByiFFysWiT3zqy12sttxGej9vOS0RMww1vYvbQfSGWm9oYf/E26sQDa6PoXGK0Nm3qrXbFswHH8QpJn847mk/En3J9ZNRYaPZ/DhFgLlwS
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=0kg-JoMdhM4A:10 a=Kd1tUaAdevIA:10 a=PtDNVHqPAAAA:8 a=ZT-azI6cAAAA:8
    a=VwQbUJbxAAAA:8 a=LfjHZU7riI05M7g1FeMA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=BpimnaHY1jUKGyF_4-AF:22 a=MMnepr4wVL9Sz6vaZzge:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753572AbeDYMLf (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 08:11:35 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:35456 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753256AbeDYMKX (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 25 Apr 2018 08:10:23 -0400
X-Google-Smtp-Source: AB8JxZrXK6tEleRP8o/yDPZV5Wih8B7Ipp69MdSGGnqcRUHC/DMEVKomXbxhokPGvVeFo5pU26EaT4BrB/a7Jj5ULz0=
MIME-Version: 1.0
In-Reply-To: <20180420010408.24438-5-ebiederm@xmission.com>
References: <878t9ilmhv.fsf@xmission.com> <20180420010408.24438-5-ebiederm@xmission.com>
From: Vincent Chen <deanbo422@gmail.com>
Date: Wed, 25 Apr 2018 20:10:22 +0800
Message-ID: <CAJsyPhyDeafwUQxXgnZ9Rfj6nwYrU_Kgyfv8DQ2q0BkwW25BBw@mail.gmail.com>
Subject: Re: [REVIEW][PATCH 05/17] signal/nds32: Use force_sig(SIGILL) in do_revisn
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Vincent Chen <vincentc@andestech.com>,
        Greentime Hu <greentime@andestech.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-04-20 9:03 GMT+08:00 Eric W. Biederman <ebiederm@xmission.com>:
> As originally committed do_revisn would deliver a siginfo for SIGILL
> with an si_code composed of random stack contents.  That makes no
> sense and is not something userspace can depend on.  So simplify
> the code and just use "force_sig(SIG_ILL, current)" instead.
>
> Fixes: 2923f5ea7738 ("nds32: Exception handling")
> Cc: Vincent Chen <vincentc@andestech.com>
> Cc: Greentime Hu <greentime@andestech.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  arch/nds32/kernel/traps.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/arch/nds32/kernel/traps.c b/arch/nds32/kernel/traps.c
> index 65961bf91d64..8e9a5b1f6234 100644
> --- a/arch/nds32/kernel/traps.c
> +++ b/arch/nds32/kernel/traps.c
> @@ -356,14 +356,11 @@ void do_dispatch_tlb_misc(unsigned long entry, unsigned long addr,
>
>  void do_revinsn(struct pt_regs *regs)
>  {
> -       siginfo_t si;
>         pr_emerg("Reserved Instruction\n");
>         show_regs(regs);
>         if (!user_mode(regs))
>                 do_exit(SIGILL);
> -       si.si_signo = SIGILL;
> -       si.si_errno = 0;
> -       force_sig_info(SIGILL, &si, current);
> +       force_sig(SIGILL, current);
>  }
>
>  #ifdef CONFIG_ALIGNMENT_TRAP
> --
> 2.14.1
>

You are right we do not store any valuable information in sigingo_t now.
However, We hope more information can be recorded by force_sig_fault()
as below instead of calling force_sig() directly.

-        force_sig(SIGILL, current);
+        force_sig_fault(SIGILL, ILL_ILLTRP,
+                        (void __user *)instruction_pointer(regs), current);

Thanks

Vincent Chen
