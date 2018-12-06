Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872D9C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 476A420892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QHnyJ6/y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 476A420892
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729566AbeLFMem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 07:34:42 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:50663 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729069AbeLFMel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 07:34:41 -0500
Received: by mail-it1-f196.google.com with SMTP id z7so1074444iti.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 04:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nM+uQOx9zVJ8TTDrLmJDveS5niw0RvoquTiTM/JIbLw=;
        b=QHnyJ6/yH1EW8wjSmjDnHSybVF3eCxoG9OkhLo5sURlwI01Pae6pEQvUlJsCDaHhwL
         G5Cd0KNGuaAj/ArVykwK2mLAPerPTIgmOQ5Q1on6L+lMwIiASbdSu37Fs//KLDjiC04l
         gn9wWyu3uDky0aLZ1hvFbH9Xc+fTbWS4EoIIS5s4DtydWN3R8iypwu3sV2u1f17zvwNG
         npmu2Pho+qxFun7F39seB2GkAAI5ILuX8ogvU3FI6GeHMZWdBv5PSt08LQO8bp8fsiwv
         L+nhIJ01aqxbN1cSawS17opGL3Mx73CqRDXsS2KC9lyrvN+/i9V8NQp6xW2gi+Fs7rdC
         JkPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nM+uQOx9zVJ8TTDrLmJDveS5niw0RvoquTiTM/JIbLw=;
        b=p9LbYHr8t+M6j+hbxgBqoDLe4CAcj9YdPNdZckZvQQAyC73jfVd5sXIAP+q+MTKaxe
         ubLPXEwrCaYHt0r9o948pHMCk1ADGc6iW6EKbpjc65efbHewfCA5Aq3mi5sMG3lJshk3
         1RQe6KzybpoS+yHzw99B23yBgb7R4uMdoHxlXqwSLPLSehmUTKqiwgUSHEwjAumcoqBo
         LQH/4EDPxFLwqG0ELGR8HyX7VPE0z+YnIi93DWIbPOqFH3di/7tG5P24u6pBBv1kJrhp
         LMHf/H/mGDl9AM43WN8z+sfW/FQmepniBidftOz0TBR9xjzTsT/cQd/gUr1sKCCDpbvC
         3IkA==
X-Gm-Message-State: AA+aEWbLI6gZ6t5VtT8NHYwtpVtn9eoaUcLmms185n5PiJ2FccVRotEW
        6l0mFRPel6sABQ5X4aopFV1d5ViQlWj82mWQZhyoiA==
X-Google-Smtp-Source: AFSGD/VcGSD8ikWZwwSM3NrN8u9F7ooCVd7MOzvHziuFtTWLcldbEDKMv2fzZYPc4Ei/J45KpUmfQ3cx0v8+PATAUoU=
X-Received: by 2002:a02:93c2:: with SMTP id z60mr24418458jah.51.1544099679394;
 Thu, 06 Dec 2018 04:34:39 -0800 (PST)
MIME-Version: 1.0
References: <cover.1541687720.git.andreyknvl@google.com> <4a4063a3e074608b99cf22ab447fecc36d056251.1541687720.git.andreyknvl@google.com>
 <20181129182218.GH22027@arrakis.emea.arm.com>
In-Reply-To: <20181129182218.GH22027@arrakis.emea.arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 6 Dec 2018 13:34:28 +0100
Message-ID: <CAAeHK+z3uJrkwunH6DDuJOVg_trk6pmKgN4QLx7LnDLEP1TSDw@mail.gmail.com>
Subject: Re: [PATCH v8 1/8] arm64: add type casts to untagged_addr macro
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Kostya Serebryany <kcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Evgenii Stepanov <eugenis@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 7:22 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Thu, Nov 08, 2018 at 03:36:08PM +0100, Andrey Konovalov wrote:
> > This patch makes the untagged_addr macro accept all kinds of address types
> > (void *, unsigned long, etc.) and allows not to specify type casts in each
> > place where it is used. This is done by using __typeof__.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > ---
> >  arch/arm64/include/asm/uaccess.h | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
> > index 07c34087bd5e..c1325271e368 100644
> > --- a/arch/arm64/include/asm/uaccess.h
> > +++ b/arch/arm64/include/asm/uaccess.h
> > @@ -101,7 +101,8 @@ static inline unsigned long __range_ok(const void __user *addr, unsigned long si
> >   * up with a tagged userland pointer. Clear the tag to get a sane pointer to
> >   * pass on to access_ok(), for instance.
> >   */
> > -#define untagged_addr(addr)          sign_extend64(addr, 55)
> > +#define untagged_addr(addr)          \
> > +     ((__typeof__(addr))sign_extend64((__u64)(addr), 55))
>
> Nitpick: same comment as here (use u64):
>
> http://lkml.kernel.org/r/20181123173739.osgvnnhmptdgtlnl@lakrids.cambridge.arm.com

Will do in v9.

>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
>
> (not acking the whole series just yet, only specific patches to remember
> what I reviewed)

OK.

Thanks!
