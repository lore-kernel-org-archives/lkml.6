Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B47C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 16:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D22326CBA
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 16:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JgYpFPm6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D22326CBA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752400AbeFZQXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 12:23:03 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:37360 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751088AbeFZQXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 12:23:00 -0400
Received: by mail-pl0-f65.google.com with SMTP id 31-v6so8790834plc.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 09:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FDadEb7UtElnZrOrzzEUCDSEcYBmz31sTyw6Kq6Trsw=;
        b=JgYpFPm60J2SvZOZoISzOTlopLPlIbgBkawrtMuFrze1COL6LawC7uISWiTttSsXrd
         jTHPZx1blC/ipQq1uVFl1K16TDgyEq5fUfmndKdUHKhMfmXd/V++Mno+UIiPNDfhbxJ6
         ksJRrpcU4/rsDl1Y+czQ4yKuLmrHGM8xa02xLesmthcCh7sQ1w593d7UkRPauYxcC2Am
         mrU6fXBTPhZZ2u3JKDL7C3DB4GB+uK/pVdgF64YXmYsoh5M74pAjf07zU6B8M2DyuPxj
         WdCPXbm+Wabqy6WdUUc+DSVDgGO4hY7IOGXzE3MNcCmoddJf6mRg/3GoYy5pB2MFyoHf
         nHdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FDadEb7UtElnZrOrzzEUCDSEcYBmz31sTyw6Kq6Trsw=;
        b=Bhz1ke+kMrt3AGY0W8WuhjvB7QYgN0r8HIfSakbdSdQQ3Arznod6eaSFgrslgoyR3a
         kj2UtrLxLMSORzPmEGV6TdndNszVjpXB0KChWTy+Gq0yTOZP0V94s0YgX/90F0HgaEcL
         8BOfgEBwbDL1u2HRqVhAyuCpFI8aKnmO51VJXSMIeM2o7sy6OODZO+YD/W5qiUDeAmP0
         KKWrSnzuAneZCkhDLBC7bdm7nArAQgfOUzGn9eHu41ZyQRTa0IUIdGJsehIvd1Jmha7K
         MkI9bBGpdtIFD65Hr79KGW3FyW/tGJXniaq3Fv3/j+Bh0P1AZpfrlYx0ug2Sh0/XFIgy
         hjcA==
X-Gm-Message-State: APt69E3yoDxau+phGbO8hhOBGwmkkdFqfel0kaMmFMo3CiRPa3N+jr6e
        xH769T04nAGvdS+l/msTRBLYJv0RC5o5IsuWzrUm7g==
X-Google-Smtp-Source: ADUXVKLrxbHz0YLWebMIW0/ibs1wa6zVQeAAGqjn3utu+3S3V+MyxHukbZbdRYWr5iFhK5pC7Fie7ijV1c7/zlkCJPY=
X-Received: by 2002:a17:902:7586:: with SMTP id j6-v6mr2318399pll.262.1530030179456;
 Tue, 26 Jun 2018 09:22:59 -0700 (PDT)
MIME-Version: 1.0
References: <20180621162324.36656-1-ndesaulniers@google.com>
 <20180621162324.36656-4-ndesaulniers@google.com> <20180622022402.GA24194@gmail.com>
 <CAKwvOdn5gnB5cK=cy6weKyxAn4SNEdZTT_MtT_D_nHRG5EDZ4g@mail.gmail.com> <20180626071325.GA25751@gmail.com>
In-Reply-To: <20180626071325.GA25751@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 26 Jun 2018 12:22:47 -0400
Message-ID: <CAKwvOdnW9r=pgmodEL0VXCv=PZVt_WMCA+B5x4D5oKRM1y-0Ow@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] x86: paravirt: make native_save_fl extern inline
To:     Ingo Molnar <mingo@kernel.org>
Cc:     mingo@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>, hpa@zytor.com,
        linux-efi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        x86@kernel.org, virtualization@lists.linux-foundation.org,
        Alistair Strachan <astrachan@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        Greg Hackmann <ghackmann@google.com>, sedat.dilek@gmail.com,
        tstellar@redhat.com, Kees Cook <keescook@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        geert@linux-m68k.org, Will Deacon <will.deacon@arm.com>,
        mawilcox@microsoft.com, Arnd Bergmann <arnd@arndb.de>,
        David Rientjes <rientjes@google.com>, acme@redhat.com,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        boris.ostrovsky@oracle.com, "J. Kiszka" <jan.kiszka@siemens.com>,
        rostedt@goodmis.org, kirill.shutemov@linux.intel.com,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        akataria@vmware.com, brijesh.singh@amd.com,
        Cao jin <caoj.fnst@cn.fujitsu.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        jarkko.sakkinen@linux.intel.com, jgross@suse.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Matthias Kaehlcke <mka@chromium.org>, thomas.lendacky@amd.com,
        Thiebaud Weksteen <tweek@google.com>, mjg59@google.com,
        joe@perches.com, andrea.parri@amarulasolutions.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 3:13 AM Ingo Molnar <mingo@kernel.org> wrote:
> Ok!
>
> Acked-by: Ingo Molnar <mingo@kernel.org>
>
> What's the planned upstreaming route for these patches/fixes?

While the fix is mainly for paravirt, 2/3 of the patches exclusively
touch arch/x86, so I think they should go up in the x86 tree (as
opposed to paravirt's), if you would be so kind.  hpa mentioned not
handling merges in https://lkml.org/lkml/2018/6/14/903, so I reached
out to you and tglx.

(Also, this is the first series I've ever sent (as opposed to one off
commits), so I'm unfamiliar with the protocol for merging series that
may be touch more than one subsystem.  I assume we don't split up
series to take parts in one tree vs another?)

-- 
Thanks,
~Nick Desaulniers
