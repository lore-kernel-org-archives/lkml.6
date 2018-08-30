Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A2EFC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02BFC20658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TEucg1lQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02BFC20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbeH3TxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 15:53:08 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:33888 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727500AbeH3TxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 15:53:08 -0400
Received: by mail-oi0-f65.google.com with SMTP id 13-v6so16313739ois.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 08:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H5ai69DPPIITZF7j51zG04M+vRUm70fEw2Dq1nAZXTU=;
        b=TEucg1lQ3k4ZBgBLoFon6Z+b7HlMm8/Y/IMjoDCf1w9nBQgytff9A2B74qA0kQVFXJ
         cJtQsCPcCRQKfZoWCUXw/xbqEp/Pzoilxg8MtnDvcIrJucMM01tmQJQAh9WW0YgzR8EJ
         /CDVWWOT/ZeRHYVoLaQqh2r7ndfEe8d+PD5DGsTdVph5RET4lGLKhM2jLkHlcf0bddtQ
         9IVLsH2nZpcASvtYWUDQdCRpcWShlv1eWrTi20pEXGAgM4sW1cz5AKhVVqEeF6s59aTN
         lbuVe9EWR/b/Iq8voQJfB0hGITOpPU1bHSZO0aylisclLYwizmSEXKIFef52zfL7j0of
         rlsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H5ai69DPPIITZF7j51zG04M+vRUm70fEw2Dq1nAZXTU=;
        b=KJQbaXAZ4B9B/Rt2fVJKaiiH14Xg13CUnSqbAUqZ8xr34Qp734XDWjTjrY/no6/9B8
         5R39zVgMKI+JuSMWKJf+sQ/bmw3H37sxJzzrI5+/JgTJZi/+K8k2SJrpA+hqPGFbwHWx
         J66TF2LccBR4mRauOP7O1Oj0z2BOnu8TlJKl2WxFM6Ggx3RhtJrECK6x1R+7LdosBf6m
         okuu1J7KrvziJWwdqPXyon42DECtBTRvrGjgTI2XNEDxjH9hfIP1GUiwUMjmISok3U6a
         K5yJhPjwWeA4sGDqZGzkSQjTO/LZEdoYpHNRLJ+e+fmLqd6P/XoodBV0fMEucMorCSq1
         WhsQ==
X-Gm-Message-State: APzg51BnJxf2kGhMkPYxEey51fIIy1twhCvJQ1+E0bqPtB/Tgpiamjw4
        60E96T+YQ4/HvDno7R7Qo/bz+63tILlE65QyxJc+Sw==
X-Google-Smtp-Source: ANB0VdaXvIK7w/vsEFkRPV0Oazx9Dk9Wqi9NLlznTneeriIA5IvFU+PqID49DO0yHw+P6UulAl7Rfy7mFlgziRfTMCM=
X-Received: by 2002:aca:e504:: with SMTP id c4-v6mr2929576oih.246.1535644220374;
 Thu, 30 Aug 2018 08:50:20 -0700 (PDT)
MIME-Version: 1.0
References: <20180830143904.3168-1-yu-cheng.yu@intel.com> <20180830143904.3168-13-yu-cheng.yu@intel.com>
In-Reply-To: <20180830143904.3168-13-yu-cheng.yu@intel.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 30 Aug 2018 17:49:53 +0200
Message-ID: <CAG48ez0Rca0XsdXJZ07c+iGPyep0Gpxw+sxQuACP5gyPaBgDKA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 12/24] x86/mm: Modify ptep_set_wrprotect and
 pmdp_set_wrprotect for _PAGE_DIRTY_SW
To:     yu-cheng.yu@intel.com
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Florian Weimer <fweimer@redhat.com>, hjl.tools@gmail.com,
        Jonathan Corbet <corbet@lwn.net>, keescook@chromiun.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        ravi.v.shankar@intel.com, vedvyas.shanbhogue@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 4:43 PM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>
> When Shadow Stack is enabled, the read-only and PAGE_DIRTY_HW PTE
> setting is reserved only for the Shadow Stack.  To track dirty of
> non-Shadow Stack read-only PTEs, we use PAGE_DIRTY_SW.
>
> Update ptep_set_wrprotect() and pmdp_set_wrprotect().
>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> ---
>  arch/x86/include/asm/pgtable.h | 42 ++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>
> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
> index 4d50de77ea96..556ef258eeff 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -1203,7 +1203,28 @@ static inline pte_t ptep_get_and_clear_full(struct mm_struct *mm,
>  static inline void ptep_set_wrprotect(struct mm_struct *mm,
>                                       unsigned long addr, pte_t *ptep)
>  {
> +       pte_t pte;
> +
>         clear_bit(_PAGE_BIT_RW, (unsigned long *)&ptep->pte);
> +       pte = *ptep;
> +
> +       /*
> +        * Some processors can start a write, but ending up seeing
> +        * a read-only PTE by the time they get to the Dirty bit.
> +        * In this case, they will set the Dirty bit, leaving a
> +        * read-only, Dirty PTE which looks like a Shadow Stack PTE.
> +        *
> +        * However, this behavior has been improved and will not occur
> +        * on processors supporting Shadow Stacks.  Without this
> +        * guarantee, a transition to a non-present PTE and flush the
> +        * TLB would be needed.
> +        *
> +        * When change a writable PTE to read-only and if the PTE has
> +        * _PAGE_DIRTY_HW set, we move that bit to _PAGE_DIRTY_SW so
> +        * that the PTE is not a valid Shadow Stack PTE.
> +        */
> +       pte = pte_move_flags(pte, _PAGE_DIRTY_HW, _PAGE_DIRTY_SW);
> +       set_pte_at(mm, addr, ptep, pte);
>  }

I don't understand why it's okay that you first atomically clear the
RW bit, then atomically switch from DIRTY_HW to DIRTY_SW. Doesn't that
mean that between the two atomic writes, another core can incorrectly
see a shadow stack?
