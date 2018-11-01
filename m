Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF37BC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99E012064C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:50:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99E012064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729033AbeKBAxb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 20:53:31 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46642 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727950AbeKBAxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 20:53:31 -0400
Received: by mail-lj1-f195.google.com with SMTP id x3-v6so18475694lji.13
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 08:49:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4uyGXBmNAQ6+Vk1XK6TIdql3w/YzKZYaTF7y0RUJAyk=;
        b=qPayg7TB8RhZiDrzlp1AwB+y1HY/7uKBSOlrpVnEEkWYKBsPPSohQufq9bsvpC4x7f
         HUf/7HmZn3TomHDJjLtsMW3OTc5LNe3Nqmlq6h7/fdnBN6NP2gGLd4eq9uy4tf/9d4Ua
         mZ4RBWhDhEA1XhjAKtZ2+wDH9UniWQc2WNoVmRtSGavdephbpV3lWHPR/GPHQtYIvb7S
         bbYoi78cPKaAimZKYElfZ3SdClqznXtOkZSzTrWxCehN2Uj7BKwljAb59O868QCrR08p
         ixp3ahVchjhM05btoLFEK1WsPRQQW+Ue7KZl3k8kbA2Bztqf2GfLNUY2IJBWOT2bOc6V
         ZNSQ==
X-Gm-Message-State: AGRZ1gIheik3TaEynOPh4VJbBND3QTnassy9t4KJWaubpuefGiOeOQIF
        blQVMlTS/f37L+N9oiHCxjHRiKyzNEA2AY5fhry6ag==
X-Google-Smtp-Source: AJdET5dhNMUozkuRSnLFIYH55EvGschcCekhS0f1ZLvuqjE+5o5W1WDCSEN6MtEg07FIT5gF787vyquHtGX6clc1W+I=
X-Received: by 2002:a2e:92:: with SMTP id e18-v6mr5666872lji.130.1541087398627;
 Thu, 01 Nov 2018 08:49:58 -0700 (PDT)
MIME-Version: 1.0
References: <1540593788-28181-1-git-send-email-bhsharma@redhat.com> <201810301913.XPGMpz0a%fengguang.wu@intel.com>
In-Reply-To: <201810301913.XPGMpz0a%fengguang.wu@intel.com>
From:   Bhupesh Sharma <bhsharma@redhat.com>
Date:   Thu, 1 Nov 2018 21:19:46 +0530
Message-ID: <CACi5LpP4+H-9X3AuAt3j=SA5Y4Qk6nA-7D4HdcRF8JGaqKx_fg@mail.gmail.com>
Subject: Re: [PATCH] x86_64, vmcoreinfo: Append 'page_offset_base' to vmcoreinfo
To:     lkp@intel.com
Cc:     kbuild-all@01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bhupesh SHARMA <bhupesh.linux@gmail.com>,
        Borislav Petkov <bp@alien8.de>, Baoquan He <bhe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kazuhito Hagio <k-hagio@ab.jp.nec.com>,
        Dave Anderson <anderson@redhat.com>,
        James Morse <james.morse@arm.com>,
        Omar Sandoval <osandov@fb.com>, x86@kernel.org,
        kexec mailing list <kexec@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Oct 30, 2018 at 5:02 PM kbuild test robot <lkp@intel.com> wrote:
>
> Hi Bhupesh,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on tip/x86/core]
> [also build test ERROR on v4.19 next-20181030]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Bhupesh-Sharma/x86_64-vmcoreinfo-Append-page_offset_base-to-vmcoreinfo/20181027-075816
> config: x86_64-randconfig-s4-10301649 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64
>
> All errors (new ones prefixed by >>):
>
>    arch/x86/kernel/machine_kexec_64.o: In function `arch_crash_save_vmcoreinfo':
> >> arch/x86/kernel/machine_kexec_64.c:359: undefined reference to `page_offset_base'
> >> arch/x86/kernel/machine_kexec_64.c:359: undefined reference to `page_offset_base'
>
> vim +359 arch/x86/kernel/machine_kexec_64.c
>
>    352
>    353  void arch_crash_save_vmcoreinfo(void)
>    354  {
>    355          VMCOREINFO_NUMBER(phys_base);
>    356          VMCOREINFO_SYMBOL(init_top_pgt);
>    357          vmcoreinfo_append_str("NUMBER(pgtable_l5_enabled)=%d\n",
>    358                          pgtable_l5_enabled());
>  > 359          VMCOREINFO_NUMBER(page_offset_base);
>    360
>

Thanks I can reproduce the issue, I will send a v2 shortly to fix the
build issue.

Regards,
Bhupesh
