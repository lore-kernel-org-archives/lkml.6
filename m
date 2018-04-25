Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-661710-1524658469-2-1785840229004119656
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524658468; b=dOo3K/A+a8wQdYt7+rasPYn4073biwu+48rQJMsdMUEnKVuZBG
    S8Av9CppD87kZ1F1JyB+yg5QkslzZT+mi1tMgI2hi16KSYXG/kAdIfdQqwqpUU/C
    KN6fFwKv5ytjBxsX1RqztEDZmfT3r9bOpPvo3TjTE1bzMf6ud6MVJc6J7IsgZuJY
    TkgCo+XbC5Sj/v/tHD8ZaLFH3LNhpirhfpY9Ya84nAi7nRdj8nTUor+K4W7NhN4m
    PAZeuqAHRJfjdyErLE35DxzVBuNQkRd8r8PXFuCJToffCDXn7FbyPBvLsiEYNXlZ
    V69xQawM1trp42DMNefoTRgR9HlIUN6e6mXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1524658468; bh=4Rs08CF/u2cyvi8g+LAEVoMLccG9tLVeuCvOWbO86Y
    8=; b=dNMhD12+oao4ZgOvt4zxWpRF77P+oHYtt+75YsAOup2+gSvKO5xl/szfBb
    H+kqPGlavm2WV2/oRpPVhnJGO1r9aAsTOM2BGwovs3UuU5WixA47wLvv6o1RCjB9
    UdydvrdNObdOEkRIETwV84JMNg/deYRXihnSBVDq7EgZTKeYr2isSXrr/ZifPtmY
    kggl1Q1jTx+kfanlOzNyHlgOEtVkHGHDuY2ZhbYlj9ZJTLh4QWkaHjXxWS/5Oh6e
    1xbeA/HFVKqIhoyVhvQjd3OrXrsHZT2Ia5I0oOGAuhdQmBx+ypLMnH7PMAyikXYK
    u0nKqQ/SzwqYFma23pjaR9sttxtg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=W2d65Rsx x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=VJINJqZa;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=W2d65Rsx x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=VJINJqZa;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfH+Yk87mwCdpVUp87R0Bz3Ps5LxOS9gfGnlFKVwg4bQHvVHM/AnYmquw0jz9qBitE7YSRWZOMAao8wHJNBMq0arrVIVaJY7UKFtwrWTNuwlp061XofZj
    rB0A5ESuXy1Lsawgs3JJkO5phFSQCc26g73S9kqLeaB/j+U/v4bu9q0fqq+UXn7aEK3vNejt9esU+LCbzmkFqv8HMESTAdr94zHc4mgPGZpELDF3ycC4Dhig
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=0kg-JoMdhM4A:10 a=Kd1tUaAdevIA:10 a=PtDNVHqPAAAA:8 a=ZT-azI6cAAAA:8
    a=VwQbUJbxAAAA:8 a=vuNPO4BfddSeI-1btLYA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=BpimnaHY1jUKGyF_4-AF:22 a=MMnepr4wVL9Sz6vaZzge:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752949AbeDYMO1 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 08:14:27 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:40692 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751487AbeDYMO0 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 25 Apr 2018 08:14:26 -0400
X-Google-Smtp-Source: AB8JxZpOO8bOP2NhHug0PlfeaBvqPYfYufHNKcBNC5ZSDnvAL8Iy5yKEC3k3OhMn6U447OOtqepuNINsQ8Sgn2yFWXM=
MIME-Version: 1.0
In-Reply-To: <20180420010408.24438-4-ebiederm@xmission.com>
References: <878t9ilmhv.fsf@xmission.com> <20180420010408.24438-4-ebiederm@xmission.com>
From: Vincent Chen <deanbo422@gmail.com>
Date: Wed, 25 Apr 2018 20:14:25 +0800
Message-ID: <CAJsyPhySxu=zhZVFr-7j4w6CmyDNKLUg=zMBvQ0pAdmYD=39Lg@mail.gmail.com>
Subject: Re: [REVIEW][PATCH 04/17] signal/nds32: Use force_sig in
 unhandled_interruption and unhandled_exceptions
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
> Neither unhandled_interrupt nor unhandled_exceptions fills in any of the
> siginfo fields whend sending SIGKILL.  Further because it is SIGKILL
> even if all of the fields were filled out appropriately it would be impossible
> for the process to read any of the siginfo fields.  So simplfy things and
> just use force_sig instead of force_sig_info.
>
> Fixes: 2923f5ea7738 ("nds32: Exception handling")
> Cc: Vincent Chen <vincentc@andestech.com>
> Cc: Greentime Hu <greentime@andestech.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  arch/nds32/kernel/traps.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
>
> diff --git a/arch/nds32/kernel/traps.c b/arch/nds32/kernel/traps.c
> index 6e34eb9824a4..65961bf91d64 100644
> --- a/arch/nds32/kernel/traps.c
> +++ b/arch/nds32/kernel/traps.c
> @@ -318,29 +318,22 @@ void do_debug_trap(unsigned long entry, unsigned long addr,
>
>  void unhandled_interruption(struct pt_regs *regs)
>  {
> -       siginfo_t si;
>         pr_emerg("unhandled_interruption\n");
>         show_regs(regs);
>         if (!user_mode(regs))
>                 do_exit(SIGKILL);
> -       si.si_signo = SIGKILL;
> -       si.si_errno = 0;
> -       force_sig_info(SIGKILL, &si, current);
> +       force_sig(SIGKILL, current);
>  }
>
>  void unhandled_exceptions(unsigned long entry, unsigned long addr,
>                           unsigned long type, struct pt_regs *regs)
>  {
> -       siginfo_t si;
>         pr_emerg("Unhandled Exception: entry: %lx addr:%lx itype:%lx\n", entry,
>                  addr, type);
>         show_regs(regs);
>         if (!user_mode(regs))
>                 do_exit(SIGKILL);
> -       si.si_signo = SIGKILL;
> -       si.si_errno = 0;
> -       si.si_addr = (void *)addr;
> -       force_sig_info(SIGKILL, &si, current);
> +       force_sig(SIGKILL, current);
>  }
>
>  extern int do_page_fault(unsigned long entry, unsigned long addr,
> --
> 2.14.1
>

Acked-by Vincent Chen
